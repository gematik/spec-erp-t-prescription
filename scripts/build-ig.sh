SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Pre Sushi Logic
## Generate heading-links.js
"$SCRIPT_DIR/generate-heading-links-js.sh"

# Generate Sushi
sushi .

# Run scripts that need artifacts from IG Publisher
./tests/run-all-tests.sh
./scripts/fml_table.sh

# Run Transformation of Mapping Bundle
java -jar ~/dev/validators/current_hapi_validator.jar ./fsh-generated/resources/Bundle-Mapping-Bundle.json -transform https://gematik.de/fhir/erp-t-prescription/StructureMap/ERPTPrescriptionStructureMapCarbonCopy -version 4.0.1 -ig ./fsh-generated/resources -output ./input/content/Bundle-erp-t-prescription-carbon-copy-actual.json -ig de.gematik.erezept-workflow.r4 -ig kbv.ita.erp -ig de.gematik.ti#1.1.0

# Generate IG Publisher Content
./_genonce.sh -no-sushi
