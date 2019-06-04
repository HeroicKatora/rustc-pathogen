#! /bin/bash
grep real | awk '{print $2}' | sed 's/0m//' | sed 's/s//' | tr "," "." | grep -n "" | tr ":" "," | awk '{printf("(%s)\n", $0)}'
