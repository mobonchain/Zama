#!/usr/bin/env bash
bash auto_commit.sh -s 2025-06-01T00:00:00 -n 1 -f test.txt
if [[ -f test.txt ]]; then echo "PASS"; else echo "FAIL"; fi
