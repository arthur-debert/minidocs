# Minidocs

Minidocs is an ultra-lightweight documentation generator. no frills: concat
multiples files into a single document, adding a title separator.

## FEATURES

- Combine multiple text files
- Title Separator
- Flexible file selection
- [optional] Line Numbers: either per file or global (useful for addressing
  sections)
- [optional] Add table of contents

text files into a single document with formatted headers and optional line
numbering. It can process files provided as arguments or automatically find
`.txt` and `.md` files in the current directory.

## Usage

```bash
minidocs [options] [file1.txt file2.txt ...]
```

## Specifying Files

Minidocs offers three ways to specify the files you want to bundle:

1. **Explicit File List:** Provide a list of files directly as arguments.

   ```bash
   minidocs file1.txt file2.md chapter3.txt
   ```

2. **Directory:** Specify a directory, and Minidocs will include all `.txt` and
   `.md` files found within it.

   ```bash
   minidocs docs/
   ```

3. **Bundle File:** Create a text file (e.g., `bundle.txt`) where each line
   contains the path to a file you want to include. Minidocs will read this file
   and bundle the listed files.

   ```text
   # bundle.txt
   file1.txt
   docs/chapter2.md
   /path/to/another_file.txt
   ```

   ```bash
   minidocs bundle.txt
   ```

## Options

- `-v, --verbose`: Enable verbose output
- `-n`: Enable per-file line numbering (01, 02, etc.)
- `-nn`: Enable global line numbering (001, 002, etc.)
- `--toc`: Include a table of contents at the beginning
- `-h, --help`: Show this help message

Between files, a separator line is inserted with the format:

```bash
########################## File Name  #########################################
```

The script will exit with an error if no files are found to bundle.

## Examples

```bash
minidocs -n intro.txt chapter1.txt           # Bundle with per-file numbering
minidocs -nn --toc                           # Bundle all files with TOC and global numbers
minidocs --toc -v                            # Verbose bundle with table of contents
minidocs  some_directory                   # will add all files in directory
minidocs  bundle_file                         # bundle_file is a txt docuument with files paths on lines
```
