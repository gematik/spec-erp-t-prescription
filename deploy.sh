#!/bin/bash

# Error handling: The script will terminate on error.
set -e

. "$(dirname "$0")/config.common.sh"

# Check MODE
if [ -z "$ENVIRONMENT" ]; then
  echo "❌ Error: ENVIRONMENT variable not set. Use 'DEV' or 'PROD'."
  exit 1
fi


if [ "$ENVIRONMENT" = "DEV" ]; then
  BUCKET_NAME="$DEV_BUCKET"
elif [ "$ENVIRONMENT" = "PROD" ]; then
  BUCKET_NAME="$PROD_BUCKET"
else
  echo "❌ Error: ENVIRONMENT must be either 'DEV' or 'PROD'."
  exit 1
fi

echo "✅ ENVIRONMENT: ${ENVIRONMENT}"
echo "✅ TARGET PATH: ${BUCKET_NAME}${BUCKET_PATH}/${TARGET}"
if [ -n "$PREV" ]; then
  echo "✅ PREV PATH: ${BUCKET_NAME}${BUCKET_PATH}/${PREV}"
fi

echo "✅ PUBLISH_URL: ${PUBLISH_URL}"

./_genonce.sh

if gsutil ls gs://$BUCKET_NAME$BUCKET_PATH/$TARGET > /dev/null 2>&1; then
    echo "TARGET directory already exists: ${TARGET}"
    if [ -n "$PREV" ]; then
        echo "Moving TARGET to PREV: ${PREV}"
        gcloud storage mv gs://$BUCKET_NAME$BUCKET_PATH/$TARGET gs://$BUCKET_NAME$BUCKET_PATH/$PREV
    fi
    echo "Deleting existing TARGET: $TARGET"
    gcloud storage rm --recursive gs://$BUCKET_NAME$BUCKET_PATH/$TARGET
else
    echo "TARGET directory does not exist"
fi

echo "Uploading new version to TARGET: ${TARGET}"
# gcloud storage cp --recursive --cache-control="no-cache" ./output/ gs://$BUCKET_NAME$BUCKET_PATH/$TARGET
gsutil -m -h "Cache-Control:no-cache" cp -r ./output/* gs://$BUCKET_NAME$BUCKET_PATH/$TARGET/