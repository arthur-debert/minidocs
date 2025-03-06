#!/bin/zsh
set -e

# Colors for output
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Set up test files
existing_file1="tests/_support/fixtures/fixture1.txt"
existing_file2="tests/_support/fixtures/fixture2.txt"
nonexistent_file1="tests/_support/fixtures/nonexistent1.txt"
nonexistent_file2="tests/_support/fixtures/nonexistent2.txt"

# Verify the existing files exist
if [[ ! -f $existing_file1 ]]; then
  echo "${RED}Error: Existing file $existing_file1 does not exist${NC}"
  exit 1
fi

if [[ ! -f $existing_file2 ]]; then
  echo "${RED}Error: Existing file $existing_file2 does not exist${NC}"
  exit 1
fi

# Verify the non-existent files don't exist
if [[ -f $nonexistent_file1 ]]; then
  echo "${RED}Error: Non-existent file $nonexistent_file1 exists${NC}"
  exit 1
fi

if [[ -f $nonexistent_file2 ]]; then
  echo "${RED}Error: Non-existent file $nonexistent_file2 exists${NC}"
  exit 1
fi

# Run minidocs with a mix of existing and non-existing files
echo "Running minidocs with mix of existing and non-existing files..."
# Capture both stdout and stderr
output=$(./minidocs "$existing_file1" "$nonexistent_file1" "$existing_file2" "$nonexistent_file2" 2>&1)

# Print the output for debugging
echo "Output from minidocs:"
echo "$output"

# Check if output contains content from existing files
if [[ $output != *"This is the first test fixture file"* ]]; then
  echo "${RED}Error: Output does not contain content from first existing file${NC}"
  exit 1
fi

if [[ $output != *"This is the second test fixture file"* ]]; then
  echo "${RED}Error: Output does not contain content from second existing file${NC}"
  exit 1
fi

# Check if file headers for existing files are included
if [[ $output != *"fixture1.txt"* ]]; then
  echo "${RED}Error: Output does not contain first file header${NC}"
  exit 1
fi

if [[ $output != *"fixture2.txt"* ]]; then
  echo "${RED}Error: Output does not contain second file header${NC}"
  exit 1
fi

# Check if output contains warnings about non-existent files
if [[ $output != *"Warning: File not found: $nonexistent_file1"* ]]; then
  echo "${RED}Error: Output does not contain warning about first non-existent file${NC}"
  exit 1
fi

if [[ $output != *"Warning: File not found: $nonexistent_file2"* ]]; then
  echo "${RED}Error: Output does not contain warning about second non-existent file${NC}"
  exit 1
fi

echo "${GREEN}✓ Test passed: Mix of existing and non-existing files handled correctly${NC}"
