#!/bin/bash

# Get the base URL for the images
BASE_URL="https://raw.githubusercontent.com/GooglyBlox/wizard-quotes/main/images/wizards"

# The JSON file to update (pointing to the correct directory)
JSON_FILE="images/wizards/images.json"

# Print the current directory for debugging
echo "Current directory:"
pwd

# Initialize an empty JSON content
JSON_CONTENT='{"images":[]}'

# Get a list of all images in the images/wizards directory
IMAGES=$(find images/wizards -type f -regex ".*\.\(jpg\|jpeg\|png\|gif\)")

# Print the images detected
echo "Images detected:"
echo "$IMAGES"

# Iterate over images and add them to the JSON
for IMAGE in $IMAGES; do
  # Extracting just the filename from the path
  IMAGE_NAME=$(basename $IMAGE)
  IMAGE_URL="$BASE_URL/$IMAGE_NAME"
  JSON_CONTENT=$(echo "$JSON_CONTENT" | jq --arg url "$IMAGE_URL" '.images += [$url]')
done

# Print the updated JSON content
echo "Updated JSON content:"
echo "$JSON_CONTENT"

# Write the updated JSON back to the file
echo "$JSON_CONTENT" > "$JSON_FILE"

# Add and commit the changes
git config user.name "GitHub Action"
git config user.email "action@github.com"
git add "$JSON_FILE"
git commit -m "Update images.json with all images"
git push
