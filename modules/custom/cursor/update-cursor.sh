#!/usr/bin/env bash

# Set the URL for the Cursor AppImage
APPIMAGE_URL="https://downloader.cursor.sh/linux/appImage/x64"

# Fetch the new sha256 hash using nix-prefetch-url
echo "Fetching new sha256 hash for Cursor AppImage..."
NEW_HASH=$(nix-prefetch-url $APPIMAGE_URL)

# Check if nix-prefetch-url was successful
if [ $? -ne 0 ]; then
  echo "Failed to fetch the AppImage. Exiting."
  exit 1
fi

# Define the path to the Nix file
NIX_FILE="./cursor.nix" # Adjust the path as needed

# Extract the current sha256 hash from the Nix file
CURRENT_HASH=$(grep -oP 'sha256 = "\K[^"]+' $NIX_FILE)

if [ -z "$CURRENT_HASH" ]; then
  echo "Failed to find the current sha256 hash in $NIX_FILE."
  exit 1
fi

# Show both the current and new hash
echo "Current sha256 hash: $CURRENT_HASH"
echo "New sha256 hash: $NEW_HASH"

# Replace the old sha256 hash with the new one in the Nix file
echo "Updating $NIX_FILE with the new hash..."
sed -i "s|sha256 = \"$CURRENT_HASH\";|sha256 = \"$NEW_HASH\";|" $NIX_FILE

if [ $? -eq 0 ]; then
  echo "Updated $NIX_FILE successfully!"
else
  echo "Failed to update $NIX_FILE."
  exit 1
fi

