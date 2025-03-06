#!/bin/zsh
set -e

# Colors for output
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Set up test directory with a single file
test_dir="tests/_support/single_file_dir"
test_file="$test_dir/single.txt"

# Verify the directory exists
if [[ ! -d $test_dir ]]; then
  echo "${RED}Error: Test directory $test_dir does not exist${NC}"
  exit 1
fi

# Verify the file exists
if [[ ! -f $test_file ]]; then
  echo "${RED}Error: Test file $test_file does not exist${NC}"
  exit 1
fi

# Verify there's only one .txt file in the directory
file_count=$(find "$test_dir" -name "*.txt" | wc -l)
if [[ $file_count -ne 1 ]]; then
  echo "${RED}Error: Expected 1 .txt file in $test_dir, found $file_count${NC}"
  exit 1
fi

# Run minidocs with the directory as the sole argument
echo "Running minidocs with directory containing a single txt file..."
output=$(./minidocs "$test_dir" 2>&1)

# Print the output for debugging
echo "Output from minidocs:"
echo "$output"

# Check if output contains content from the file
if [[ $output != *"This is a single text file in a directory"* ]]; then
  echo "${RED}Error: Output does not contain content from the single file${NC}"
  exit 1
fi

# Check if file header is included
if [[ $output != *"single.txt"* ]]; then
  echo "${RED}Error: Output does not contain the file header${NC}"
  exit 1
fi

echo "${GREEN}✓ Test passed: Directory with only one txt file handled correctly${NC}"
