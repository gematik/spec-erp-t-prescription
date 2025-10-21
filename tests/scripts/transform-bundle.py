#!/usr/bin/env python3
"""
Transform Mapping Bundle using HAPI FHIR StructureMap

This script runs the HAPI FHIR validator with StructureMap transformation
on a mapping bundle to produce a carbon copy.

Usage:
    python transform-bundle.py <mapping-bundle.json> <output-carboncopy.json>
"""

import sys
import subprocess
import os
from pathlib import Path


def run_hapi_transform(
    hapi_jar_path: Path,
    input_bundle: Path,
    output_file: Path,
    fhir_version: str = "4.0.1",
    transform_url: str = "https://gematik.de/fhir/erp-t-prescription/StructureMap/ERPTPrescriptionStructureMapCarbonCopy"
) -> tuple[int, str, str]:
    """
    Run HAPI FHIR transformation on the mapping bundle.
    
    Returns:
        Tuple of (return_code, stdout, stderr)
    """
    
    # Get the project root (3 levels up from this script)
    script_dir = Path(__file__).parent
    project_root = script_dir.parent.parent
    
    # Define IG dependencies
    ig_paths = [
        str(project_root / "fsh-generated" / "resources"),
        "de.gematik.erezept-workflow.r4",
        "kbv.ita.erp",
        "de.gematik.fhir.directory",
        "de.gematik.ti",
        "de.basisprofil.r4",
        "de.gematik.epa.medication",
    ]
    
    # Build the command
    cmd = [
        "java",
        "-jar",
        str(hapi_jar_path),
        str(input_bundle),
        "-transform",
        transform_url,
        "-version",
        fhir_version,
        "-output",
        str(output_file)
    ]
    
    # Add all IG dependencies
    for ig_path in ig_paths:
        cmd.extend(["-ig", ig_path])
    
    print("🚀 Running HAPI FHIR transformation...")
    print(f"   Input: {input_bundle}")
    print(f"   Output: {output_file}")
    print(f"   Transform: {transform_url}\n")
    
    # Run the command
    result = subprocess.run(
        cmd,
        capture_output=True,
        text=True,
        cwd=str(project_root)
    )
    
    return result.returncode, result.stdout, result.stderr


def main():
    if len(sys.argv) != 3:
        print("Usage: python transform-bundle.py <mapping-bundle.json> <output-dir>")
        print("\nExample:")
        print("  python transform-bundle.py output/example-case-01/example-case-01-mapping-bundle.json output/example-case-01")
        sys.exit(1)
    
    input_bundle = Path(sys.argv[1])
    output_dir = Path(sys.argv[2])
    
    # Validate input
    if not input_bundle.exists():
        print(f"❌ Error: Input bundle not found: {input_bundle}")
        sys.exit(1)
    
    # Extract test case name from bundle filename
    # Expected format: <name>-mapping-bundle.json
    bundle_name = input_bundle.stem  # removes .json
    if bundle_name.endswith('-mapping-bundle'):
        test_case_name = bundle_name.replace('-mapping-bundle', '')
    else:
        test_case_name = bundle_name
    
    # Create output file path with naming convention
    output_file = output_dir / f"{test_case_name}-digitaler-durchschlag.json"
    
    # Find HAPI validator
    hapi_jar_path = Path("/Users/gematik/dev/validators/current_hapi_validator.jar")
    
    if not hapi_jar_path.exists():
        print(f"❌ Error: HAPI validator not found at: {hapi_jar_path}")
        print("\nPlease ensure the HAPI FHIR validator JAR is available.")
        print("Download from: https://github.com/hapifhir/org.hl7.fhir.core/releases")
        sys.exit(1)
    
    # Create output directory
    output_dir.mkdir(parents=True, exist_ok=True)
    
    # Run transformation
    return_code, stdout, stderr = run_hapi_transform(
        hapi_jar_path,
        input_bundle,
        output_file
    )
    
    # Print output
    if stdout:
        print("📋 STDOUT:")
        print(stdout)
    
    if stderr:
        print("\n📋 STDERR:")
        print(stderr)
    
    # Check result
    if return_code == 0 and output_file.exists():
        print(f"\n✅ Transformation successful!")
        print(f"   Digitaler Durchschlag created: {output_file}")
        
        # Get file size
        file_size = output_file.stat().st_size
        print(f"   File size: {file_size:,} bytes")
    else:
        print(f"\n❌ Transformation failed with return code: {return_code}")
        sys.exit(1)


if __name__ == "__main__":
    main()
