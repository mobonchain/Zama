#!/usr/bin/env bash
# Minimal script to create backdated file commits and push
[ ! -d .git ] && echo "Not a git repo" && exit 1
START=""
COUNT=11
PREF="file_"
DELTA=0
while getopts "s:n:p:d:" opt; do
  case $opt in
    s) START=$OPTARG;;
    n) COUNT=$OPTARG;;
    p) PREF=$OPTARG;;
    d) DELTA=$OPTARG;;
  esac
done
[ -z "$START" ] && echo "Usage: $0 -s START_DATE [-n COUNT] [-p PREFIX] [-d DELTA]" && exit 1
BR=$(git rev-parse --abbrev-ref HEAD)
for ((i=1;i<=COUNT;i++)); do
  DATE=$(date -d "$START + $(((i-1)*DELTA)) minutes" +"%Y-%m-%dT%H:%M:%S")
  FILE="$PREF$i.txt"
  echo "File $i" > "$FILE"
  git add "$FILE"
  GIT_AUTHOR_DATE="$DATE" GIT_COMMITTER_DATE="$DATE" git commit -m "Add $FILE"
done
git push origin "$BR"
