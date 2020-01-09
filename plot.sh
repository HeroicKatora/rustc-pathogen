#! /bin/bash
grep -n "" | tr ":" "," | awk '{printf("(%s)\n", $0)}' | python -c "
import math
import matplotlib.pyplot as plt
from sys import stdin

data = [eval(line) for line in stdin.readlines()]
degree_estimate = lambda a, fa, b, fb: (math.log(fa) - math.log(fb))/(math.log(a) - math.log(b))
degree_estimates = [degree_estimate(a, fa, b, fb) for (a, fa) in data for (b, fb) in data if a != b]
print('Somewhat naive polynomial degree estimate:', sum(degree_estimates)/len(degree_estimates))
plt.scatter(*zip(*data))
plt.show()
"
