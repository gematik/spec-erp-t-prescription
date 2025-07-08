#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Error handling: The script will terminate on error.
set -e

. "$(dirname "$0")/config.common.sh"

# Check MODE
if [ -z "$ENVIRONMENT" ]; then
  echo "❌ Error: ENVIRONMENT variable not set. Use 'DEV' or 'PROD'."
  exit 1
fi

# Check GCloud Login 

# Function: Check if gcloud is authenticated and credentials are valid
function gcloud_is_authenticated() {
  ACCOUNT=$(gcloud auth list --filter=status:ACTIVE --format="value(account)")
  if [ -z "$ACCOUNT" ]; then
    return 1
  fi
  # Try a simple gcloud command to verify credentials are valid (e.g., list projects)
  if ! gcloud projects list --limit=1 > /dev/null 2>&1; then
    return 1
  fi
  return 0
}

if gcloud_is_authenticated; then
  echo "✅ Already authenticated with gcloud and credentials are valid."
else
  echo "No valid gcloud authentication found. Trying authentication..."

  gcloud auth login
fi

if [ "$ENVIRONMENT" = "DEV" ]; then
  BUCKET_NAME="$DEV_BUCKET"
  BUCKET_PATH="$DEV_BUCKET_PATH"
elif [ "$ENVIRONMENT" = "BALLOT" ]; then
  BUCKET_NAME="$BALLOT_BUCKET"
  BUCKET_PATH="$BALLOT_BUCKET_PATH"
elif [ "$ENVIRONMENT" = "PROD" ]; then
  BUCKET_NAME="$PROD_BUCKET"
  BUCKET_PATH="$PROD_BUCKET_PATH"
else
  echo "❌ Error: ENVIRONMENT must be either 'DEV', 'BALLOT' or 'PROD'."
  exit 1
fi

echo "✅ ENVIRONMENT: ${ENVIRONMENT}"
echo "✅ TARGET PATH: ${BUCKET_NAME}${BUCKET_PATH}/${TARGET}"
if [ -n "$PREV" ]; then
  echo "✅ PREV PATH: ${BUCKET_NAME}${BUCKET_PATH}/${PREV}"
fi

echo "✅ PUBLISH_URL: ${PUBLISH_URL}"

# TODO Add Simplifier cli

# "$SCRIPT_DIR/build-ig.sh"
 

# if gsutil ls gs://$BUCKET_NAME$BUCKET_PATH/$TARGET > /dev/null 2>&1; then
#     echo "TARGET directory already exists: ${TARGET}"
#     if [ -n "$PREV" ]; then
#         echo "Moving TARGET to PREV: ${PREV}"
#         gcloud storage mv gs://$BUCKET_NAME$BUCKET_PATH/$TARGET gs://$BUCKET_NAME$BUCKET_PATH/$PREV
#     fi
#     echo "Deleting existing TARGET: $TARGET"
#     gcloud storage rm --recursive gs://$BUCKET_NAME$BUCKET_PATH/$TARGET
# else
#     echo "TARGET directory does not exist"
# fi

# echo "Uploading new version to TARGET: ${TARGET}"
# # gcloud storage cp --recursive --cache-control="no-cache" ./output/ gs://$BUCKET_NAME$BUCKET_PATH/$TARGET
# gsutil -m -h "Cache-Control:no-cache" cp -r ./output/* gs://$BUCKET_NAME$BUCKET_PATH/$TARGET/