#!/bin/bash
# Script to clean LeetCode nvim cache directory
# Works across different computers by expanding ~ to home directory

# Define the target directory (expands ~ to user's home)
TARGET_DIR="$HOME/.local/share/nvim/leetcode"

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${YELLOW}LeetCode Cache Cleaner${NC}"
echo "Target directory: $TARGET_DIR"
echo ""

# Check if directory exists
if [ ! -d "$TARGET_DIR" ]; then
    echo -e "${RED}Error: Directory does not exist!${NC}"
    exit 1
fi

# Count items to be deleted
ITEM_COUNT=$(find "$TARGET_DIR" -mindepth 1 | wc -l | tr -d ' ')

if [ "$ITEM_COUNT" -eq 0 ]; then
    echo -e "${GREEN}Directory is already empty!${NC}"
    exit 0
fi

# Show what will be deleted
echo -e "${BLUE}Found $ITEM_COUNT item(s) to delete:${NC}"
echo ""

# List all items that will be deleted
find "$TARGET_DIR" -mindepth 1 -print0 | while IFS= read -r -d '' item; do
    # Show relative path from TARGET_DIR
    rel_path="${item#$TARGET_DIR/}"
    echo "  - $rel_path"
done

echo ""
echo -e "${YELLOW}Deleting...${NC}"

# Delete everything inside the directory but keep the directory itself
rm -rf "${TARGET_DIR:?}"/*
rm -rf "${TARGET_DIR:?}"/.[!.]*

echo -e "${GREEN}✓ Successfully cleaned $TARGET_DIR${NC}"
