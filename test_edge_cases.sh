#!/bin/zsh
set -e

# Colors for output
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Test directory is treated as a file when not the sole argument
echo "Testing directory is treated as a file when not the sole argument..."
test_file="tests/_support/fixtures/fixture1.txt"
test_dir="tests/_support/fixtures"

# Verify the file and directory exist
if [[ ! -f $test_file ]]; then
  echo "${RED}Error: Test file $test_file does not exist${NC}"
  exit 1
fi

if [[ ! -d $test_dir ]]; then
  echo "${RED}Error: Test directory $test_dir does not exist${NC}"
  exit 1
fi

# Run minidocs with a file and a directory as arguments
output=$(./minidocs "$test_file" "$test_dir" 2>&1)
exit_code=$?

# Print the output for debugging
echo "Output from minidocs:"
echo "$output"
echo "Exit code: $exit_code"

# Check if output contains content from the file
if [[ $output != *"This is the first test fixture file"* ]]; then
  echo "${RED}Error: Output does not contain content from the first file${NC}"
  exit 1
fi

# Check if output contains the file header
if [[ $output != *"fixture1.txt"* ]]; then
  echo "${RED}Error: Output does not contain the first file header${NC}"
  exit 1
fi

# Check if output contains a warning about the directory not being found
if [[ $output != *"Warning: File not found"* ]]; then
  echo "${RED}Error: Output does not contain warning about directory not being found${NC}"
  exit 1
fi

# Check if output does not contain content from fixture2.txt
if [[ $output == *"This is the second test fixture file"* ]]; then
  echo "${RED}Error: Output contains content from the second file, which should not be included${NC}"
  exit 1
fi

echo "${GREEN}✓ Directory is treated as a file when not the sole argument${NC}"

# Test bundle file is treated as a regular file when not the sole argument
echo "Testing bundle file is treated as a regular file when not the sole argument..."
bundle_file="tests/_support/test_bundle.txt"

# Verify the bundle file exists
if [[ ! -f $bundle_file ]]; then
  echo "${RED}Error: Bundle file $bundle_file does not exist${NC}"
  exit 1
fi

# Run minidocs with a file and a bundle file as arguments
output=$(./minidocs "$test_file" "$bundle_file" 2>&1)
exit_code=$?

# Print the output for debugging
echo "Output from minidocs:"
echo "$output"
echo "Exit code: $exit_code"

# Check if output contains content from the first file
if [[ $output != *"This is the first test fixture file"* ]]; then
  echo "${RED}Error: Output does not contain content from the first file${NC}"
  exit 1
fi

# Check if output contains the first file header
if [[ $output != *"fixture1.txt"* ]]; then
  echo "${RED}Error: Output does not contain the first file header${NC}"
  exit 1
fi

# Check if output contains the bundle file header
if [[ $output != *"test_bundle.txt"* ]]; then
  echo "${RED}Error: Output does not contain the bundle file header${NC}"
  exit 1
fi

# Check if output does not contain content from fixture2.txt
if [[ $output == *"This is the second test fixture file"* ]]; then
  echo "${RED}Error: Output contains content from the second file, which should not be included${NC}"
  exit 1
fi

echo "${GREEN}✓ Bundle file is treated as a regular file when not the sole argument${NC}"

echo "${GREEN}All tests passed!${NC}"
