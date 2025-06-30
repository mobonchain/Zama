# Auto Commit Tool

A simple Bash script to automatically generate backdated Git commits on Linux (e.g., GitHub Codespaces).

## Features

- Create a random number of commits between a minimum and maximum you specify  
- Backdate each commit by setting `GIT_AUTHOR_DATE` and `GIT_COMMITTER_DATE`  
- Append a line to any file you choose (default: `autocommit.txt`)  
- Configure start date, time interval, commit message prefix, and commit count range  

## Installation

```bash
git clone https://github.com/mobonchain/Zama.git
cd Zama
chmod +x auto_commit.sh
````

## Usage

```bash
./auto_commit.sh \
  -s 2025-06-30T00:00:00 \   # ISO-8601 start date (required)  
  -f README.md \             # file to append lines to (default: autocommit.txt)  
  -m "Docs: auto-commit" \    # commit message prefix  
  -d 5 \                      # minutes between commits  
  -n "10 10"                  # create exactly 10 commits  
```

### Options

* `-s START_DATE`
  Required. ISO 8601 start date/time, e.g. `2025-06-01T06:00:00`.

* `-f FILE`
  File path to append content. (default: `autocommit.txt`)

* `-m MESSAGE_PREFIX`
  Prefix for each commit message. (default: `Auto commit`)

* `-d DELTA_MINUTES`
  Minutes between each backdated commit. (default: `5`)

* `-n "MIN MAX"`
  Two integers specifying the minimum and maximum number of commits.
  Example: `-n "11 15"` to create a random count between 11 and 15.
  Use the same number twice (`"10 10"`) for exactly 10 commits.

## Examples

Create between 11 and 15 commits, starting on June 10, 2025 at 06:00, appending to `README.md`:

```bash
./auto_commit.sh \
  -s 2025-06-10T06:00:00 \
  -f README.md \
  -m "Docs: auto-commit" \
  -d 5 \
  -n "11 15"
```

Create exactly 12 commits, starting on June 29, 2025 at 23:00:

```bash
./auto_commit.sh \
  -s 2025-06-29T23:00:00 \
  -n "12 12"
```

## License

This project is licensed under the MIT License. See [LICENSE](/LICENSE) for details.