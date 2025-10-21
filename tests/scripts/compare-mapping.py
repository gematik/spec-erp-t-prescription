#!/usr/bin/env python3
"""
Compare source and target resources from StructureMap transformation.

This script analyzes the mapping bundle (source) and digitaler durchschlag (target)
to show which fields were mapped and which were not.
"""

import json
import sys
from pathlib import Path
from typing import Dict, Any, List, Set, Tuple


def flatten_json(obj: Any, parent_key: str = '', sep: str = '.') -> Dict[str, Any]:
    """
    Flatten a nested JSON object into a flat dictionary with dot-separated keys.
    
    Args:
        obj: JSON object to flatten
        parent_key: Parent key for recursion
        sep: Separator for nested keys
    
    Returns:
        Flattened dictionary
    """
    items = {}
    
    if isinstance(obj, dict):
        for k, v in obj.items():
            new_key = f"{parent_key}{sep}{k}" if parent_key else k
            
            if isinstance(v, (dict, list)):
                items.update(flatten_json(v, new_key, sep=sep))
            else:
                items[new_key] = v
    elif isinstance(obj, list):
        for i, item in enumerate(obj):
            new_key = f"{parent_key}[{i}]"
            if isinstance(item, (dict, list)):
                items.update(flatten_json(item, new_key, sep=sep))
            else:
                items[new_key] = item
    else:
        items[parent_key] = obj
    
    return items


def get_resource_paths(resource: Dict[str, Any], prefix: str = '') -> Set[str]:
    """
    Get all field paths in a resource (excluding values, just paths).
    
    Args:
        resource: FHIR resource
        prefix: Path prefix for recursion
    
    Returns:
        Set of all field paths
    """
    paths = set()
    
    if isinstance(resource, dict):
        for key, value in resource.items():
            current_path = f"{prefix}.{key}" if prefix else key
            paths.add(current_path)
            
            if isinstance(value, (dict, list)):
                paths.update(get_resource_paths(value, current_path))
    elif isinstance(resource, list):
        for i, item in enumerate(resource):
            current_path = f"{prefix}[{i}]"
            if isinstance(item, (dict, list)):
                paths.update(get_resource_paths(item, current_path))
    
    return paths


def normalize_path(path: str) -> str:
    """
    Remove array indices from path for comparison.
    Strips both [0], [1] etc. and [] to make all paths comparable.
    """
    import re
    # Remove [0], [1], etc. and also []
    normalized = re.sub(r'\[\d*\]', '', path)
    return normalized


def normalize_array_in_path(path: str, obj: Dict[str, Any]) -> str:
    """
    Normalize a path by detecting if intermediate keys contain arrays
    and adding [] where appropriate for consistent comparison.
    
    For example, if 'code.coding.code' actually represents 'code.coding[].code'
    because 'coding' is an array in the data.
    """
    import re
    parts = path.split('.')
    current_obj = obj
    normalized_parts = []
    
    for part in parts:
        # Check if part has array index already
        if '[' in part:
            normalized_parts.append(re.sub(r'\[\d+\]', '[]', part))
            # Navigate through the array
            base_part = part.split('[')[0]
            if isinstance(current_obj, dict) and base_part in current_obj:
                current_val = current_obj[base_part]
                if isinstance(current_val, list) and len(current_val) > 0:
                    current_obj = current_val[0]
        else:
            # Check if this field is actually an array in the object
            if isinstance(current_obj, dict) and part in current_obj:
                current_val = current_obj[part]
                if isinstance(current_val, list):
                    # This is an array, add [] to normalize
                    normalized_parts.append(f"{part}[]")
                    if len(current_val) > 0:
                        current_obj = current_val[0]
                else:
                    normalized_parts.append(part)
                    current_obj = current_val
            else:
                normalized_parts.append(part)
    
    return '.'.join(normalized_parts)


def extract_resources_from_bundle(bundle: Dict[str, Any]) -> Dict[str, Dict[str, Any]]:
    """
    Extract all resources from a Bundle.
    
    For VZD SearchSet bundles, creates a composite resource that merges all
    contained resources (Organization, HealthcareService, Location) into one
    since they map to a single target Organization.
    
    Returns:
        Dictionary mapping resource type to list of resources
    """
    resources = {}
    
    if bundle.get('resourceType') == 'Bundle' and 'entry' in bundle:
        for entry in bundle['entry']:
            if 'resource' in entry:
                resource = entry['resource']
                resource_type = resource.get('resourceType', 'Unknown')
                resource_id = resource.get('id', 'no-id')
                
                # Check if this is a VZD SearchSet Bundle (nested bundle)
                if resource_type == 'Bundle' and resource.get('type') == 'searchset' and 'VZD' in resource_id:
                    # Create a composite resource merging all VZD entries
                    composite = {
                        'resourceType': 'VZDComposite',
                        'id': resource_id,
                        'sourceResources': []
                    }
                    
                    for vzd_entry in resource.get('entry', []):
                        if 'resource' in vzd_entry:
                            vzd_resource = vzd_entry['resource']
                            vzd_type = vzd_resource.get('resourceType', 'Unknown')
                            composite['sourceResources'].append(vzd_type)
                            
                            # Merge fields from each resource type into the composite
                            # Organization -> direct fields
                            # HealthcareService -> telecom
                            # Location -> address
                            if vzd_type == 'Organization':
                                composite['name'] = vzd_resource.get('name')
                                composite['identifier'] = vzd_resource.get('identifier', [])
                            elif vzd_type == 'HealthcareService':
                                composite['telecom'] = vzd_resource.get('telecom', [])
                            elif vzd_type == 'Location':
                                composite['address'] = vzd_resource.get('address', [])
                    
                    resources[f"VZDComposite/{resource_id}"] = composite
                else:
                    # Regular resource
                    key = f"{resource_type}/{resource_id}"
                    resources[key] = resource
    
    return resources


def extract_resources_from_parameters(params: Dict[str, Any]) -> Dict[str, Dict[str, Any]]:
    """
    Extract all resources from Parameters (digitaler durchschlag).
    
    Returns:
        Dictionary mapping resource type/context to resources
    """
    resources = {}
    
    if params.get('resourceType') != 'Parameters':
        return resources
    
    for param in params.get('parameter', []):
        param_name = param.get('name', '')
        
        # Extract nested resources from parts
        if 'part' in param:
            for part in param['part']:
                if 'resource' in part:
                    resource = part['resource']
                    resource_type = resource.get('resourceType', 'Unknown')
                    part_name = part.get('name', 'unnamed')
                    
                    key = f"{param_name}.{part_name}:{resource_type}"
                    resources[key] = resource
    
    return resources


def get_field_value(obj: Dict[str, Any], path: str) -> Any:
    """
    Get value at a specific field path.
    
    Args:
        obj: Object to search
        path: Dot-notation path (with [] for arrays)
    
    Returns:
        Value at path, or None if not found
    """
    import re
    
    parts = re.split(r'\.|\[|\]', path)
    parts = [p for p in parts if p]  # Remove empty strings
    
    current = obj
    for part in parts:
        if current is None:
            return None
        
        if isinstance(current, dict):
            current = current.get(part)
        elif isinstance(current, list):
            try:
                idx = int(part)
                current = current[idx] if idx < len(current) else None
            except (ValueError, IndexError):
                return None
        else:
            return None
    
    return current


def format_value(value: Any, max_length: int = 50) -> str:
    """Format a value for display in table."""
    if value is None:
        return "-"
    
    if isinstance(value, bool):
        return str(value)
    
    if isinstance(value, (int, float)):
        return str(value)
    
    if isinstance(value, str):
        if len(value) > max_length:
            return value[:max_length-3] + "..."
        return value
    
    if isinstance(value, (dict, list)):
        s = json.dumps(value, ensure_ascii=False)
        if len(s) > max_length:
            return s[:max_length-3] + "..."
        return s
    
    return str(value)


def compare_resources_with_values(source: Dict[str, Any], target: Dict[str, Any]) -> List[Dict[str, Any]]:
    """
    Compare two resources and return field mapping with values.
    
    Returns:
        List of dictionaries with field mappings and values
    """
    source_flat = flatten_json(source)
    target_flat = flatten_json(target)
    
    # Remove resourceType and meta fields
    exclude_patterns = ['resourceType', 'meta.profile', 'meta.lastUpdated', 'meta.versionId']
    source_flat = {k: v for k, v in source_flat.items() if not any(k.startswith(e) for e in exclude_patterns)}
    target_flat = {k: v for k, v in target_flat.items() if not any(k.startswith(e) for e in exclude_patterns)}
    
    # Normalize paths for comparison - remove all array indices
    # This allows matching fields whether they're arrays or single values
    source_normalized = {normalize_path(k): (k, v) for k, v in source_flat.items()}
    target_normalized = {normalize_path(k): (k, v) for k, v in target_flat.items()}
    
    # Build comparison table
    comparisons = []
    
    # Process all source fields
    for norm_path, (src_path, src_value) in sorted(source_normalized.items()):
        if norm_path in target_normalized:
            tgt_path, tgt_value = target_normalized[norm_path]
            comparisons.append({
                'source_path': src_path,
                'source_value': src_value,
                'target_path': tgt_path,
                'target_value': tgt_value,
                'status': 'mapped'
            })
        else:
            comparisons.append({
                'source_path': src_path,
                'source_value': src_value,
                'target_path': '-',
                'target_value': None,
                'status': 'unmapped'
            })
    
    # Add target-only fields (newly created)
    for norm_path, (tgt_path, tgt_value) in sorted(target_normalized.items()):
        if norm_path not in source_normalized:
            comparisons.append({
                'source_path': '-',
                'source_value': None,
                'target_path': tgt_path,
                'target_value': tgt_value,
                'status': 'new'
            })
    
    return comparisons


def generate_markdown_report(test_case_dir: Path, output_file: Path) -> None:
    """
    Generate a markdown comparison report.
    
    Args:
        test_case_dir: Directory containing test case
        output_file: Where to write the markdown report
    """
    test_case_name = test_case_dir.name
    
    # Load source mapping bundle
    mapping_bundle_path = test_case_dir / f"{test_case_name}-mapping-bundle.json"
    if not mapping_bundle_path.exists():
        print(f"❌ Mapping bundle not found: {mapping_bundle_path}")
        sys.exit(1)
    
    with open(mapping_bundle_path, 'r') as f:
        mapping_bundle = json.load(f)
    
    # Load target digitaler durchschlag
    dd_path = test_case_dir / f"{test_case_name}-digitaler-durchschlag.json"
    if not dd_path.exists():
        print(f"❌ Digitaler Durchschlag not found: {dd_path}")
        sys.exit(1)
    
    with open(dd_path, 'r') as f:
        digitaler_durchschlag = json.load(f)
    
    # Extract resources
    source_resources = extract_resources_from_bundle(mapping_bundle)
    target_resources = extract_resources_from_parameters(digitaler_durchschlag)
    
    # Generate report
    md = []
    md.append(f"# StructureMap Transformation Report")
    md.append(f"")
    md.append(f"**Test Case:** `{test_case_name}`  ")
    md.append(f"**Date:** {Path(dd_path).stat().st_mtime}  ")
    md.append(f"")
    md.append(f"## Summary")
    md.append(f"")
    md.append(f"- **Source Resources:** {len(source_resources)}")
    md.append(f"- **Target Parameters:** {len(target_resources)}")
    md.append(f"")
    
    # Overall statistics
    total_source_fields = 0
    total_mapped_fields = 0
    total_unmapped_fields = 0
    total_new_fields = 0
    
    md.append(f"## Resource Mapping Details")
    md.append(f"")
    
    # Group source resources by type
    source_by_type = {}
    for key, resource in source_resources.items():
        resource_type = resource.get('resourceType', 'Unknown')
        if resource_type not in source_by_type:
            source_by_type[resource_type] = []
        source_by_type[resource_type].append((key, resource))
    
    # Analyze each source resource type
    for resource_type, resources in sorted(source_by_type.items()):
        # Skip Task resources
        if resource_type == 'Task':
            continue
            
        md.append(f"### {resource_type}")
        md.append(f"")
        
        for source_key, source_resource in resources:
            source_id = source_resource.get('id', 'no-id')
            md.append(f"#### Source: `{source_key}`")
            md.append(f"")
            
            # Find corresponding target(s)
            # This is tricky as the mapping may transform resource types
            # For VZD resources, look for matching Organizations in target
            # For other resources, look for same ID or content overlap
            
            best_match = None
            best_score = 0
            
            for target_key, target_resource in target_resources.items():
                # Special handling for VZDComposite -> Organization mapping
                if resource_type == 'VZDComposite' and target_resource.get('resourceType') == 'Organization':
                    comparisons = compare_resources_with_values(source_resource, target_resource)
                    mapped_count = sum(1 for c in comparisons if c['status'] == 'mapped')
                    total_source = sum(1 for c in comparisons if c['status'] in ['mapped', 'unmapped'])
                    score = mapped_count / total_source if total_source > 0 else 0
                    
                    if score > best_score:
                        best_score = score
                        best_match = (target_key, target_resource, comparisons)
                
                # Normal matching for other resources
                elif resource_type in target_key or source_id in str(target_resource):
                    comparisons = compare_resources_with_values(source_resource, target_resource)
                    mapped_count = sum(1 for c in comparisons if c['status'] == 'mapped')
                    total_source = sum(1 for c in comparisons if c['status'] in ['mapped', 'unmapped'])
                    
                    score = mapped_count / total_source if total_source > 0 else 0
                    
                    if score > best_score:
                        best_score = score
                        best_match = (target_key, target_resource, comparisons)
            
            if best_match:
                target_key, target_resource, comparisons = best_match
                
                mapped = [c for c in comparisons if c['status'] == 'mapped']
                unmapped = [c for c in comparisons if c['status'] == 'unmapped']
                new_fields = [c for c in comparisons if c['status'] == 'new']
                
                total_source_fields += len(mapped) + len(unmapped)
                total_mapped_fields += len(mapped)
                total_unmapped_fields += len(unmapped)
                total_new_fields += len(new_fields)
                
                target_type = target_resource.get('resourceType', 'Unknown')
                coverage_pct = (len(mapped) / (len(mapped) + len(unmapped)) * 100) if (len(mapped) + len(unmapped)) > 0 else 0
                
                md.append(f"**Target:** `{target_key}` (`{target_type}`)  ")
                md.append(f"**Coverage:** {coverage_pct:.1f}% ({len(mapped)}/{len(mapped) + len(unmapped)} fields mapped)")
                md.append(f"")
                
                # Create value comparison table
                md.append(f"| Source Field | Source Value | Target Field | Target Value | Status |")
                md.append(f"|--------------|--------------|--------------|--------------|--------|")
                
                # First show mapped fields
                for comp in sorted(mapped, key=lambda x: x['source_path']):
                    src_val = format_value(comp['source_value'])
                    tgt_val = format_value(comp['target_value'])
                    md.append(f"| `{comp['source_path']}` | {src_val} | `{comp['target_path']}` | {tgt_val} | ✅ |")
                
                # Then unmapped fields
                for comp in sorted(unmapped, key=lambda x: x['source_path']):
                    src_val = format_value(comp['source_value'])
                    md.append(f"| `{comp['source_path']}` | {src_val} | - | - | ⚠️ |")
                
                # Finally new fields
                if new_fields:
                    md.append(f"")
                    md.append(f"**New fields created by transformation:**")
                    md.append(f"")
                    md.append(f"| Target Field | Target Value | Status |")
                    md.append(f"|--------------|--------------|--------|")
                    for comp in sorted(new_fields, key=lambda x: x['target_path']):
                        tgt_val = format_value(comp['target_value'])
                        md.append(f"| `{comp['target_path']}` | {tgt_val} | 🆕 |")
                
                md.append(f"")
            else:
                md.append(f"**Target:** ❌ No matching target resource found")
                md.append(f"")
                # Count source fields as unmapped
                source_flat = flatten_json(source_resource)
                total_source_fields += len(source_flat)
                total_unmapped_fields += len(source_flat)
            
            md.append(f"---")
            md.append(f"")
    
    # Write report
    with open(output_file, 'w') as f:
        f.write('\n'.join(md))
    
    print(f"📊 Comparison report generated: {output_file}")
    print(f"")
    print(f"Summary:")
    print(f"  • Source fields: {total_source_fields}")
    print(f"  • Mapped: {total_mapped_fields} ({total_mapped_fields/total_source_fields*100:.1f}%)" if total_source_fields > 0 else "  • Mapped: 0")
    print(f"  • Unmapped: {total_unmapped_fields}")
    print(f"  • New fields created: {total_new_fields}")


def main():
    if len(sys.argv) != 3:
        print("Usage: python compare-mapping.py <test-output-dir> <report-output-file>")
        print("\nExample:")
        print("  python compare-mapping.py tests/output/example-case-01 tests/output/example-case-01/mapping-report.md")
        sys.exit(1)
    
    test_output_dir = Path(sys.argv[1])
    report_file = Path(sys.argv[2])
    
    if not test_output_dir.exists():
        print(f"❌ Error: Test output directory not found: {test_output_dir}")
        sys.exit(1)
    
    print(f"📊 Generating mapping comparison report...")
    print(f"   Source: {test_output_dir}")
    print(f"   Report: {report_file}\n")
    
    generate_markdown_report(test_output_dir, report_file)


if __name__ == "__main__":
    main()
