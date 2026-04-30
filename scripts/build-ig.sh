# Run scripts that need artifacts from IG Publisher
./tests/run-all-tests.sh
./scripts/fml_table.sh

# Run Transformation of Mapping Bundle
# Create a temporary directory containing only the StructureMaps to avoid loading example bundles
TEMP_IG_DIR=$(mktemp -d)
trap "rm -rf '$TEMP_IG_DIR'" EXIT

for sm_file in ./fsh-generated/resources/StructureMap-*.json; do
    cp "$sm_file" "$TEMP_IG_DIR/"
done

# Use modern HAPI 6.8+ syntax: transform URL input_file
java -jar /home/vscode/.fhir/validators/validator_cli.jar \
    transform https://gematik.de/fhir/erp-t-prescription/StructureMap/ERPTPrescriptionStructureMapCarbonCopy \
    ./fsh-generated/resources/Bundle-Mapping-Bundle.json \
    -version 4.0.1 \
    -output ./input/content/Bundle-erp-t-prescription-carbon-copy-actual.json \
    -ig "$TEMP_IG_DIR" \
    -ig de.gematik.erezept-workflow.r4 \
    -ig kbv.ita.erp \
    -ig de.gematik.ti#1.1.0
