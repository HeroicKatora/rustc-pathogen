#!/bin/bash
# Extracts the memory from the log. Combine with `plot.sh` and/or `plot.py`
grep "Maximum resident set size" | awk -F ':' '{print $2}'
