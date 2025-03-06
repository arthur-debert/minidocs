#!/bin/zsh

# Test script to debug directory handling in minidocs

# Set up test directory
TEST_DIR="tests/_support/fixtures"

# Check if directory exists
echo "Directory exists: $(test -d "$TEST_DIR" && echo "yes" || echo "no")"
echo "Directory contents:"
ls -la "$TEST_DIR"

# Check if files exist
echo "Files in directory:"
find "$TEST_DIR" -type f \( -name "*.txt" -o -name "*.md" \) -print

# Try running minidocs with the directory
echo "Running minidocs with directory:"
./minidocs -v "$TEST_DIR"
