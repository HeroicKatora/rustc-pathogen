#!/bin/bash
# Extracts the time from the log. Combine with `plot.sh` and/or `plot.py`
grep "User time" | awk -F ':' '{print $2}'
