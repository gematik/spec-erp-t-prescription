#!/usr/bin/env python3
"""
Build Mapping Bundle from Individual FHIR Resources

This script reads individual FHIR resource JSON files from a test case directory
and creates a mapping bundle (type: collection) suitable for StructureMap transformation.

Expected files in test case directory:
- KBV_Prescription.json (MedicationRequest)
- KBV_Medication_*.json (any KBV Medication profile)
- GEM_ERP_PR_Medication.json (GEM Medication from workflow)
- GEM_MedicationDispense.json (MedicationDispense)
- VZDSearchSet.json (VZD SearchSet Bundle)
- Task.json (Task in closed state)

Usage:
    python build-bundle.py <test-case-dir> <output-file>
"""

import json
import sys
import os
from pathlib import Path
from typing import Dict, List, Any


def load_json_file(filepath: Path) -> Dict[str, Any]:
    """Load and parse a JSON file."""
    with open(filepath, 'r', encoding='utf-8') as f:
        return json.load(f)


def create_bundle_entry(resource: Dict[str, Any], full_url: str) -> Dict[str, Any]:
    """Create a bundle entry with the given resource."""
    return {
        "fullUrl": full_url,
        "resource": resource
    }


def load_xml_file(filepath: Path) -> Dict[str, Any]:
    """Load and parse an XML file, converting to dict representation."""
    import xml.etree.ElementTree as ET
    tree = ET.parse(filepath)
    root = tree.getroot()
    # For now, we'll read it as text and let the caller handle it
    with open(filepath, 'r', encoding='utf-8') as f:
        return {"xml_content": f.read(), "root_element": root.tag}


def extract_from_kbv_bundle(kbv_bundle: Dict[str, Any]) -> tuple[Dict[str, Any], Dict[str, Any]]:
    """Extract KBV_Prescription and KBV_Medication from KBV eRezept Bundle."""
    prescription = None
    medication = None
    
    for entry in kbv_bundle.get('entry', []):
        resource = entry.get('resource', {})
        resource_type = resource.get('resourceType')
        
        if resource_type == 'MedicationRequest':
            prescription = resource
            print(f"  → Extracted KBV_Prescription (id: {resource.get('id', 'unknown')})")
        elif resource_type == 'Medication':
            medication = resource
            print(f"  → Extracted KBV_Medication (id: {resource.get('id', 'unknown')})")
    
    return prescription, medication


def extract_from_dispense_parameters(params: Dict[str, Any]) -> tuple[Dict[str, Any], Dict[str, Any]]:
    """Extract GEM_MedicationDispense and GEM_Medication from Parameters resource."""
    dispense = None
    medication = None
    
    for param in params.get('parameter', []):
        if param.get('name') == 'rxDispensation':
            for part in param.get('part', []):
                resource = part.get('resource', {})
                resource_type = resource.get('resourceType')
                
                if resource_type == 'MedicationDispense':
                    dispense = resource
                    print(f"  → Extracted GEM_MedicationDispense (id: {resource.get('id', 'unknown')})")
                elif resource_type == 'Medication':
                    medication = resource
                    print(f"  → Extracted GEM_Medication (id: {resource.get('id', 'unknown')})")
    
    return dispense, medication


def build_mapping_bundle(test_case_dir: Path) -> Dict[str, Any]:
    """
    Build a mapping bundle from resources in the test case directory.
    
    Expected resource files:
    - KBV_Bundle.json - KBV eRezept Bundle containing Prescription and Medication
    - MedicationDispense_Parameters.json - Parameters containing dispense and medication
    - Task.xml - Task in closed state (XML format)
    - VZDSearchSet.xml - VZD SearchSet Bundle (XML format)
    """
    bundle = {
        "resourceType": "Bundle",
        "type": "collection",
        "entry": []
    }
    
    base_url = "https://erp-t-prescription-test.de"
    
    # Extract from KBV Bundle (try both JSON and XML)
    kbv_bundle_json = test_case_dir / "KBV_Bundle.json"
    kbv_bundle_xml = test_case_dir / "KBV_Bundle.xml"
    
    if kbv_bundle_json.exists():
        print(f"✓ Processing KBV_Bundle.json")
        kbv_bundle = load_json_file(kbv_bundle_json)
        prescription, medication = extract_from_kbv_bundle(kbv_bundle)
        
        if prescription:
            resource_id = prescription.get('id', 'KBV-Prescription')
            full_url = f"{base_url}/MedicationRequest/{resource_id}"
            bundle["entry"].append(create_bundle_entry(prescription, full_url))
        
        if medication:
            resource_id = medication.get('id', 'KBV-Medication')
            full_url = f"{base_url}/Medication/{resource_id}"
            bundle["entry"].append(create_bundle_entry(medication, full_url))
    elif kbv_bundle_xml.exists():
        print(f"✓ Processing KBV_Bundle.xml")
        kbv_bundle = convert_xml_to_json(kbv_bundle_xml)
        if kbv_bundle:
            prescription, medication = extract_from_kbv_bundle(kbv_bundle)
            
            if prescription:
                resource_id = prescription.get('id', 'KBV-Prescription')
                full_url = f"{base_url}/MedicationRequest/{resource_id}"
                bundle["entry"].append(create_bundle_entry(prescription, full_url))
            
            if medication:
                resource_id = medication.get('id', 'KBV-Medication')
                full_url = f"{base_url}/Medication/{resource_id}"
                bundle["entry"].append(create_bundle_entry(medication, full_url))
    else:
        print(f"⚠ Warning: KBV_Bundle.json or KBV_Bundle.xml not found")
    
    # Extract from MedicationDispense Parameters (try both JSON and XML)
    dispense_params_json = test_case_dir / "MedicationDispense_Parameters.json"
    dispense_params_xml = test_case_dir / "MedicationDispense_Parameters.xml"
    
    if dispense_params_json.exists():
        print(f"✓ Processing MedicationDispense_Parameters.json")
        dispense_params = load_json_file(dispense_params_json)
        dispense, gem_medication = extract_from_dispense_parameters(dispense_params)
        
        if dispense:
            resource_id = dispense.get('id', 'GEM-MedicationDispense')
            full_url = f"{base_url}/MedicationDispense/{resource_id}"
            bundle["entry"].append(create_bundle_entry(dispense, full_url))
        
        if gem_medication:
            resource_id = gem_medication.get('id', 'GEM-Medication')
            full_url = f"{base_url}/Medication/{resource_id}"
            bundle["entry"].append(create_bundle_entry(gem_medication, full_url))
    elif dispense_params_xml.exists():
        print(f"✓ Processing MedicationDispense_Parameters.xml")
        dispense_params = convert_xml_to_json(dispense_params_xml)
        if dispense_params:
            dispense, gem_medication = extract_from_dispense_parameters(dispense_params)
            
            if dispense:
                resource_id = dispense.get('id', 'GEM-MedicationDispense')
                full_url = f"{base_url}/MedicationDispense/{resource_id}"
                bundle["entry"].append(create_bundle_entry(dispense, full_url))
            
            if gem_medication:
                resource_id = gem_medication.get('id', 'GEM-Medication')
                full_url = f"{base_url}/Medication/{resource_id}"
                bundle["entry"].append(create_bundle_entry(gem_medication, full_url))
    else:
        print(f"⚠ Warning: MedicationDispense_Parameters.json or MedicationDispense_Parameters.xml not found")
    
    # Add Task from XML
    task_xml_path = test_case_dir / "Task.xml"
    if task_xml_path.exists():
        print(f"✓ Processing Task.xml")
        # Parse XML and convert to JSON for the bundle
        task_json = convert_xml_to_json(task_xml_path)
        if task_json:
            resource_id = task_json.get('id', 'Task')
            full_url = f"{base_url}/Task/{resource_id}"
            bundle["entry"].append(create_bundle_entry(task_json, full_url))
    else:
        print(f"⚠ Warning: Task.xml not found")
    
    # Add VZDSearchSet from XML
    vzd_xml_path = test_case_dir / "VZDSearchSet.xml"
    if vzd_xml_path.exists():
        print(f"✓ Processing VZDSearchSet.xml")
        vzd_json = convert_xml_to_json(vzd_xml_path)
        if vzd_json:
            resource_id = vzd_json.get('id', 'VZD-SearchSet')
            full_url = f"{base_url}/Bundle/{resource_id}"
            bundle["entry"].append(create_bundle_entry(vzd_json, full_url))
    else:
        print(f"⚠ Warning: VZDSearchSet.xml not found")
    
    print(f"\n📦 Bundle created with {len(bundle['entry'])} entries")
    return bundle


def convert_xml_to_json(xml_path: Path) -> Dict[str, Any]:
    """Convert FHIR XML to JSON using HAPI validator."""
    import subprocess
    import tempfile
    import os
    
    # Try to use HAPI validator to convert XML to JSON
    hapi_jar = Path("/Users/gematik/dev/validators/current_hapi_validator.jar")
    
    if not hapi_jar.exists():
        print(f"  ⚠ HAPI validator not found at {hapi_jar}")
        print(f"  ⚠ Cannot convert XML to JSON, using fallback parser")
        return parse_fhir_xml_simple(xml_path)
    
    # Get absolute path
    xml_abs_path = xml_path.resolve()
    
    # Create temp directory for output
    with tempfile.TemporaryDirectory() as tmpdir:
        tmp_dir = Path(tmpdir)
        
        # HAPI validator can convert formats
        result = subprocess.run(
            ["java", "-jar", str(hapi_jar), str(xml_abs_path), "-version", "4.0.1", 
             "-ig", "kbv.ita.erp", "-ig", "de.gematik.erezept-workflow.r4"],
            capture_output=True,
            text=True,
            cwd=str(tmp_dir),
            timeout=60
        )
        
        # Check if a JSON file was created
        json_files = list(tmp_dir.glob("*.json"))
        if json_files:
            with open(json_files[0], 'r', encoding='utf-8') as f:
                resource = json.load(f)
                print(f"  → Converted {resource.get('resourceType', 'Unknown')} from XML to JSON via HAPI")
                return resource
        
        # If no JSON file, try parsing stdout
        if "resourceType" in result.stdout:
            try:
                resource = json.loads(result.stdout)
                print(f"  → Converted {resource.get('resourceType', 'Unknown')} from XML to JSON via HAPI")
                return resource
            except:
                pass
        
        print(f"  ⚠ HAPI conversion failed, using fallback XML parser")
        
        # Fallback: try using simple parsing
        return parse_fhir_xml_simple(xml_path)


def parse_fhir_xml_simple(xml_path: Path) -> Dict[str, Any]:
    """Parse FHIR XML and convert to JSON-like dict structure."""
    import xml.etree.ElementTree as ET
    
    try:
        tree = ET.parse(xml_path)
        root = tree.getroot()
        
        # Remove namespace for easier parsing
        # FHIR namespace is http://hl7.org/fhir
        ns = {'fhir': 'http://hl7.org/fhir'}
        
        # Convert XML element to dict
        result = xml_element_to_dict(root, ns)
        
        resource_type = result.get('resourceType', 'Unknown')
        resource_id = result.get('id', 'unknown')
        print(f"  → Parsed {resource_type} (id: {resource_id}) using XML parser")
        
        return result
        
    except Exception as e:
        print(f"  ✗ Failed to parse XML: {e}")
        return {}


def xml_element_to_dict(element, ns) -> Dict[str, Any]:
    """Recursively convert XML element to dictionary."""
    # Get tag name without namespace
    tag = element.tag.split('}')[-1] if '}' in element.tag else element.tag
    
    # Base case: element with value attribute (FHIR pattern)
    value_attr = element.get('value')
    if value_attr is not None and len(element) == 0:
        return value_attr
    
    # Special handling for 'resource' wrapper elements in Bundle entries
    # The actual resource is the first (and only) child
    if tag == 'resource' and len(element) == 1:
        # Return the parsed child resource directly
        return xml_element_to_dict(list(element)[0], ns)
    
    # Handle root resource type
    if tag in ['Bundle', 'Parameters', 'Task', 'MedicationRequest', 'Medication', 
               'MedicationDispense', 'Organization', 'Patient', 'Practitioner', 'Coverage', 'Composition']:
        result = {'resourceType': tag}
        
        # Get id attribute if present
        id_attr = element.get('id')
        if id_attr:
            result['id'] = id_attr
    else:
        result = {}
    
    # Process child elements - GROUP BY TAG FIRST to handle arrays properly
    children_by_tag = {}
    for child in element:
        child_tag = child.tag.split('}')[-1] if '}' in child.tag else child.tag
        
        if child_tag not in children_by_tag:
            children_by_tag[child_tag] = []
        children_by_tag[child_tag].append(child)
    
    # Now convert each group
    for child_tag, child_elements in children_by_tag.items():
        if len(child_elements) == 1:
            # Single element - not an array
            result[child_tag] = xml_element_to_dict(child_elements[0], ns)
        else:
            # Multiple elements - create array
            result[child_tag] = [xml_element_to_dict(child, ns) for child in child_elements]
    
    # Special handling for common FHIR elements
    if 'id' in result and isinstance(result['id'], dict) and 'value' in result['id']:
        result['id'] = result['id']['value']
    elif 'id' in result and isinstance(result['id'], str):
        pass  # Already a string
    
    if 'meta' in result and isinstance(result['meta'], dict):
        meta = result['meta']
        if 'profile' in meta:
            profiles = meta['profile']
            if isinstance(profiles, dict) and 'value' in profiles:
                result['meta']['profile'] = [profiles['value']]
            elif isinstance(profiles, list):
                result['meta']['profile'] = [p.get('value', p) if isinstance(p, dict) else p for p in profiles]
            elif isinstance(profiles, str):
                result['meta']['profile'] = [profiles]
    
    # Handle entry arrays in Bundles
    if 'entry' in result:
        entries = result['entry']
        if not isinstance(entries, list):
            entries = [entries]
        
        # Process each entry
        processed_entries = []
        for entry in entries:
            if isinstance(entry, dict):
                # Extract fullUrl and resource
                processed_entry = {}
                if 'fullUrl' in entry:
                    fullUrl = entry['fullUrl']
                    if isinstance(fullUrl, dict) and 'value' in fullUrl:
                        processed_entry['fullUrl'] = fullUrl['value']
                    else:
                        processed_entry['fullUrl'] = fullUrl
                
                if 'resource' in entry:
                    processed_entry['resource'] = entry['resource']
                
                processed_entries.append(processed_entry)
        
        result['entry'] = processed_entries
    
    # Handle parameter arrays in Parameters
    if 'parameter' in result:
        params = result['parameter']
        if not isinstance(params, list):
            params = [params]
        result['parameter'] = params
    
    return result


def main():
    if len(sys.argv) != 3:
        print("Usage: python build-bundle.py <test-case-dir> <output-dir>")
        print("\nExample:")
        print("  python build-bundle.py test-cases/example-case-01 output/example-case-01")
        sys.exit(1)
    
    test_case_dir = Path(sys.argv[1])
    output_dir = Path(sys.argv[2])
    
    if not test_case_dir.exists():
        print(f"❌ Error: Test case directory not found: {test_case_dir}")
        sys.exit(1)
    
    if not test_case_dir.is_dir():
        print(f"❌ Error: {test_case_dir} is not a directory")
        sys.exit(1)
    
    # Get test case name from directory
    test_case_name = test_case_dir.name
    
    # Create output file path with naming convention
    output_file = output_dir / f"{test_case_name}-mapping-bundle.json"
    
    print(f"📁 Building mapping bundle from: {test_case_dir}")
    print(f"📄 Output: {output_file}\n")
    
    # Build the bundle
    bundle = build_mapping_bundle(test_case_dir)
    
    # Create output directory if needed
    output_dir.mkdir(parents=True, exist_ok=True)
    
    # Write the bundle
    with open(output_file, 'w', encoding='utf-8') as f:
        json.dump(bundle, f, indent=2, ensure_ascii=False)
    
    print(f"\n✅ Mapping bundle created successfully: {output_file}")


if __name__ == "__main__":
    main()
