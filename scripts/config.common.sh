SCRIPT_DIR_L="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SUSHI_CONFIG_FILE="$SCRIPT_DIR_L/../sushi-config.yaml"

TARGET=$(yq '.version' "$SUSHI_CONFIG_FILE")
PUBLISH_URL=https://gematik.de/fhir/erp-t-prescription/$TARGET
PREV="" # Leave empty to skip moving

DEV_BUCKET_PATH=/ig/fhir/erp-t-prescription/build
BALLOT_BUCKET_PATH=/ig/fhir/erp-t-prescription
PROD_BUCKET_PATH=/ig/fhir/erp-t-prescription
DEV_BUCKET=gematik_gemspec_fhir_dev-0
BALLOT_BUCKET=gematik_gemspec_fhir_dev-0
PROD_BUCKET=gematik_gemspec_fhir_prod-0