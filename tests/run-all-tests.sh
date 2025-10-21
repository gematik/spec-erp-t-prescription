#!/bin/bash
#
# StructureMap Test Pipeline
# 
# This script runs the complete test pipeline for StructureMap transformations:
# 1. Finds all test case directories
# 2. Builds mapping bundles from individual resources
# 3. Transforms bundles using HAPI FHIR StructureMaps
# 4. Reports results
#
# Usage:
#   ./run-all-tests.sh [--clean]
#
# Options:
#   --clean    Remove all output files before running tests
#

set -e  # Exit on error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Directories
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TEST_CASES_DIR="$SCRIPT_DIR/test-cases"
OUTPUT_DIR="$SCRIPT_DIR/output"
SCRIPTS_DIR="$SCRIPT_DIR/scripts"

# Scripts
BUILD_SCRIPT="$SCRIPTS_DIR/build-bundle.py"
TRANSFORM_SCRIPT="$SCRIPTS_DIR/transform-bundle.py"

# Counters
TOTAL_TESTS=0
PASSED_TESTS=0
FAILED_TESTS=0

# Clean output if requested
if [[ "$1" == "--clean" ]]; then
    echo -e "${YELLOW}🧹 Cleaning output directory...${NC}"
    rm -rf "$OUTPUT_DIR"
    echo -e "${GREEN}✓ Output directory cleaned${NC}\n"
fi

# Create output directories
mkdir -p "$OUTPUT_DIR"

echo -e "${BLUE}╔════════════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║   StructureMap Test Pipeline                  ║${NC}"
echo -e "${BLUE}╚════════════════════════════════════════════════╝${NC}\n"

# Check if test cases directory exists
if [[ ! -d "$TEST_CASES_DIR" ]]; then
    echo -e "${RED}❌ Test cases directory not found: $TEST_CASES_DIR${NC}"
    exit 1
fi

# Find all test case directories
TEST_CASES=($(find "$TEST_CASES_DIR" -mindepth 1 -maxdepth 1 -type d | sort))

if [[ ${#TEST_CASES[@]} -eq 0 ]]; then
    echo -e "${YELLOW}⚠ No test cases found in: $TEST_CASES_DIR${NC}"
    echo -e "${YELLOW}  Create test case directories with FHIR resource JSON files.${NC}"
    exit 0
fi

echo -e "${BLUE}Found ${#TEST_CASES[@]} test case(s)${NC}\n"

# Process each test case
for test_case_path in "${TEST_CASES[@]}"; do
    test_case_name=$(basename "$test_case_path")
    TOTAL_TESTS=$((TOTAL_TESTS + 1))
    
    echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${BLUE}Test Case: $test_case_name${NC}"
    echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    
    # Create test case output directory
    test_output_dir="$OUTPUT_DIR/$test_case_name"
    mkdir -p "$test_output_dir"
    
    bundle_file="$test_output_dir/${test_case_name}-mapping-bundle.json"
    result_file="$test_output_dir/${test_case_name}-digitaler-durchschlag.json"
    
    # Step 1: Build mapping bundle
    echo -e "\n${YELLOW}[1/2] Building mapping bundle...${NC}"
    if python3 "$BUILD_SCRIPT" "$test_case_path" "$test_output_dir"; then
        echo -e "${GREEN}✓ Bundle created: $bundle_file${NC}"
    else
        echo -e "${RED}✗ Bundle creation failed${NC}"
        FAILED_TESTS=$((FAILED_TESTS + 1))
        continue
    fi
    
    # Step 2: Transform with StructureMap
    echo -e "\n${YELLOW}[2/2] Transforming with StructureMap...${NC}"
    if python3 "$TRANSFORM_SCRIPT" "$bundle_file" "$test_output_dir"; then
        echo -e "${GREEN}✓ Transformation successful: $result_file${NC}"
        PASSED_TESTS=$((PASSED_TESTS + 1))
    else
        echo -e "${RED}✗ Transformation failed${NC}"
        FAILED_TESTS=$((FAILED_TESTS + 1))
    fi
    
    echo ""
done

# Print summary
echo -e "${BLUE}╔════════════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║   Test Results Summary                         ║${NC}"
echo -e "${BLUE}╚════════════════════════════════════════════════╝${NC}\n"

echo -e "Total test cases:  $TOTAL_TESTS"
echo -e "${GREEN}Passed:            $PASSED_TESTS${NC}"
echo -e "${RED}Failed:            $FAILED_TESTS${NC}\n"

if [[ $FAILED_TESTS -eq 0 ]]; then
    echo -e "${GREEN}✅ All tests passed!${NC}\n"
    exit 0
else
    echo -e "${RED}❌ Some tests failed!${NC}\n"
    exit 1
fi
