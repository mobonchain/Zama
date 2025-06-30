#!/usr/bin/env bash
# auto_commit.sh - Automatically create backdated Git commits on GitHub Codespaces (Linux).
#
# SYNOPSIS:
#   ./auto_commit.sh -s START_DATE [-f FILE] [-m MESSAGE_PREFIX] [-d DELTA_MINUTES] [-n MIN_COMMITS MAX_COMMITS]
#
# DESCRIPTION:
#   This script runs on Linux (e.g., GitHub Codespaces) to generate a random number of backdated commits
#   between MIN and MAX by appending lines to a specified file and setting GIT_AUTHOR_DATE and GIT_COMMITTER_DATE.
#
# OPTIONS:
#   -s START_DATE       ISO 8601 start date, e.g., 2025-06-01T06:00:00 (required)
#   -f FILE             File to append content (default: autocommit.txt)
#   -m MESSAGE_PREFIX   Commit message prefix (default: "Auto commit")
#   -d DELTA_MINUTES    Minutes between commits (default: 5)
#   -n "MIN MAX"       Two integers: minimum and maximum commits (default: 11 15)
#
# EXAMPLE:
#   ./auto_commit.sh -s 2025-06-10T06:00:00 -f README.md -m "Docs: auto-commit" -d 5 -n "11 15"

# Default values
START_DATE=""
FILE="autocommit.txt"
MESSAGE_PREFIX="Auto commit"
DELTA_MINUTES=5
MIN_COMMITS=11
MAX_COMMITS=15

# Print usage and exit
usage() {
  echo "Usage: $0 -s START_DATE [-f FILE] [-m MESSAGE_PREFIX] [-d DELTA_MINUTES] [-n \"MIN MAX\"]"
  exit 1
}

# Parse arguments
while [[ $# -gt 0 ]]; do
  case "$1" in
    -s) START_DATE="$2"; shift 2 ;;
    -f) FILE="$2"; shift 2 ;;
    -m) MESSAGE_PREFIX="$2"; shift 2 ;;
    -d) DELTA_MINUTES="$2"; shift 2 ;;
    -n) MIN_COMMITS="$2"; MAX_COMMITS="$3"; shift 3 ;;
    *) usage ;;
  esac
done

# Validate START_DATE
if [[ -z "$START_DATE" ]]; then
  echo "Error: START_DATE is required." >&2
  usage
fi

# Ensure Git repo
if [ ! -d .git ]; then
  echo "Error: No .git directory found. Initialize a Git repository first." >&2
  exit 1
fi

# Ensure file exists
touch "$FILE"

# Generate random count
RANGE=$(( MAX_COMMITS - MIN_COMMITS + 1 ))
COUNT=$(( RANDOM % RANGE + MIN_COMMITS ))

echo "Creating $COUNT backdated commits starting from $START_DATE, every $DELTA_MINUTES minutes, appending to $FILE."

# Loop to create commits
for (( i=1; i<=COUNT; i++ )); do
  COMMIT_DATE=$(date -d "$START_DATE + $(( (i-1) * DELTA_MINUTES )) minutes" +"%Y-%m-%dT%H:%M:%S")
  echo "$MESSAGE_PREFIX #$i at $COMMIT_DATE" >> "$FILE"
  git add "$FILE"
  GIT_AUTHOR_DATE="$COMMIT_DATE" GIT_COMMITTER_DATE="$COMMIT_DATE" git commit -m "$MESSAGE_PREFIX #$i"
done

echo "Done: $COUNT commits created."
