#!/bin/zsh
set -e

# Colors for output
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Test directory with nested structure
test_dir="tests/_support/test_file_selection"

# Verify the directory exists
if [[ ! -d $test_dir ]]; then
  echo "${RED}Error: Test directory $test_dir does not exist${NC}"
  exit 1
fi

# Verify the nested directory exists
if [[ ! -d "$test_dir/nested" ]]; then
  echo "${RED}Error: Nested directory $test_dir/nested does not exist${NC}"
  exit 1
fi

# Run minidocs with the directory as the sole argument
echo "Running minidocs with directory: $test_dir"
output=$(./minidocs "$test_dir")

# Check if output contains content from .txt and .md files in the parent directory
if [[ $output != *"This is a test file in the main directory"* ]]; then
  echo "${RED}Error: Output does not contain content from file1.txt in the parent directory${NC}"
  exit 1
fi

if [[ $output != *"Markdown Test File"* ]]; then
  echo "${RED}Error: Output does not contain content from file2.md in the parent directory${NC}"
  exit 1
fi

# Check if output contains content from .txt and .md files in the nested directory
if [[ $output != *"This is a test file in the nested directory"* ]]; then
  echo "${RED}Error: Output does not contain content from nested_file1.txt in the nested directory${NC}"
  exit 1
fi

if [[ $output != *"Nested Markdown Test File"* ]]; then
  echo "${RED}Error: Output does not contain content from nested_file2.md in the nested directory${NC}"
  exit 1
fi

# Check if file headers are included
if [[ $output != *"file1.txt"* ]]; then
  echo "${RED}Error: Output does not contain file1.txt header${NC}"
  exit 1
fi

if [[ $output != *"file2.md"* ]]; then
  echo "${RED}Error: Output does not contain file2.md header${NC}"
  exit 1
fi

if [[ $output != *"nested_file1.txt"* ]]; then
  echo "${RED}Error: Output does not contain nested_file1.txt header${NC}"
  exit 1
fi

if [[ $output != *"nested_file2.md"* ]]; then
  echo "${RED}Error: Output does not contain nested_file2.md header${NC}"
  exit 1
fi

# Check if output does NOT contain content from non-text files
if [[ $output == *"file3.pdf"* ]]; then
  echo "${RED}Error: Output contains file3.pdf, which should not be included${NC}"
  exit 1
fi

if [[ $output == *"nested_file3.doc"* ]]; then
  echo "${RED}Error: Output contains nested_file3.doc, which should not be included${NC}"
  exit 1
fi

echo "${GREEN}✓ Test passed: Nested directory files are correctly included${NC}"
