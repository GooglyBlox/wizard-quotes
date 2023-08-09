#!/bin/bash

# Get the base URL for the images
BASE_URL="https://raw.githubusercontent.com/GooglyBlox/wizard-quotes/main/images/wizards"

# The JSON file to update (pointing to the correct directory)
JSON_FILE="images/wizards/images.json"

# Print the current directory for debugging
echo "Current directory:"
pwd

# Print existing content of JSON file for debugging
echo "Existing content of $JSON_FILE:"
cat "$JSON_FILE"

# Get a list of all new images added (considering only the images folder)
NEW_IMAGES=$(git diff --name-only HEAD~1..HEAD images/wizards | grep -E '\.(jpg|jpeg|png|gif)$')

# Print the new images detected
echo "New images detected:"
echo "$NEW_IMAGES"

# Read the existing JSON into a variable
if [ -f "$JSON_FILE" ]; then
  JSON_CONTENT=$(cat "$JSON_FILE")
else
  JSON_CONTENT='{"images":[]}'
fi

# Iterate over new images and add them to the JSON
for IMAGE in $NEW_IMAGES; do
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
git commit -m "Update images.json with new images"
git push
