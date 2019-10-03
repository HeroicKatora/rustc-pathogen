#! /bin/bash
grep -n "" | tr ":" "," | awk '{printf("(%s)\n", $0)}' | python -c "
import matplotlib.pyplot as plt
from sys import stdin

data = [eval(line) for line in stdin.readlines()]
plt.scatter(*zip(*data))
plt.show()
"
