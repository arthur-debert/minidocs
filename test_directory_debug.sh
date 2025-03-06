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

# Try running minidocs with the directory using strace to see what's happening
echo "Running minidocs with directory (with debugging):"
VERBOSE=true ./minidocs "$TEST_DIR" 2>&1 | grep -E "INFO|Warning|Error"
