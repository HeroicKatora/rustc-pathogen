#! /bin/bash
grep "User time" | awk -F ':' '{print $2}' | grep -n "" | tr ":" "," | awk '{printf("(%s)\n", $0)}'
