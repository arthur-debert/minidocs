#!/bin/zsh
set -e

# Colors for output
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Set up test directory with mixed file types
test_dir="tests/_support/test_file_selection"

# Verify the directory exists
if [[ ! -d $test_dir ]]; then
  echo "${RED}Error: Test directory $test_dir does not exist${NC}"
  exit 1
fi

# Verify the directory contains .txt and .md files
txt_count=$(find "$test_dir" -maxdepth 1 -name "*.txt" | wc -l)
md_count=$(find "$test_dir" -maxdepth 1 -name "*.md" | wc -l)
if [[ $txt_count -eq 0 || $md_count -eq 0 ]]; then
  echo "${RED}Error: Directory should contain both .txt and .md files${NC}"
  exit 1
fi

# Verify the directory contains non-.txt/.md files
other_count=$(find "$test_dir" -maxdepth 1 -not -name "*.txt" -not -name "*.md" -type f | wc -l)
if [[ $other_count -eq 0 ]]; then
  echo "${RED}Error: Directory should contain non-.txt/.md files${NC}"
  exit 1
fi

# Run minidocs with the directory as the sole argument
echo "Running minidocs with directory containing mixed file types..."
output=$(./minidocs "$test_dir" 2>&1)

# Print the output for debugging
echo "Output from minidocs:"
echo "$output"

# Check if output contains content from .txt files
if [[ $output != *"This is a test file in the main directory"* ]]; then
  echo "${RED}Error: Output does not contain content from .txt files${NC}"
  exit 1
fi

# Check if output contains content from .md files
if [[ $output != *"Markdown Test File"* ]]; then
  echo "${RED}Error: Output does not contain content from .md files${NC}"
  exit 1
fi

# Check if file headers for .txt and .md files are included
if [[ $output != *"file1.txt"* ]]; then
  echo "${RED}Error: Output does not contain .txt file header${NC}"
  exit 1
fi

if [[ $output != *"file2.md"* ]]; then
  echo "${RED}Error: Output does not contain .md file header${NC}"
  exit 1
fi

# Check if output does NOT contain content from non-.txt/.md files
if [[ $output == *"file3.pdf"* ]]; then
  echo "${RED}Error: Output contains .pdf file, which should be excluded${NC}"
  exit 1
fi

# Check if bundle files are treated as regular files, not as bundles
if [[ $output != *"bundle.txt"* ]]; then
  echo "${RED}Error: Output does not contain bundle.txt file header${NC}"
  exit 1
fi

if [[ $output != *"simple_bundle.txt"* ]]; then
  echo "${RED}Error: Output does not contain simple_bundle.txt file header${NC}"
  exit 1
fi

echo "${GREEN}✓ Test passed: Directory with mixed file types handled correctly${NC}"
