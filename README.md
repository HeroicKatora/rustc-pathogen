A collection of bad scaling in cargo or rustc. Check out each branch for an
example. Each example can be scaled to some arbitrary number to plot the
compile time.

## Description

1.`hello-world` (this branch): A simple main that prints `Hello, world`
  repeatedly by repeating the same line. Inspired by [this blog post][1].
2.`deeper`: Each iteration creates a new folder `$new`, moves the previous
  library into it and initializes within the work dir a new library target
  that depends on the inner library in `$new` and re-exports its only symbol
  `do_something`.
3.`deep-and-broad`: Like `deeper` but instead of having libraries in ever
  longer paths, creates a sibling folder for each level of libraries. The
  hierarchy is unchanged but its representation on disk does not consume linear
  file paths.

## Issues

The issue in 1st will scale with `n^1.5` due to some known bad performance in
the borrow checker. Very long functions seem to trigger it and it is generally
known.

Both the 2nd and 3rd cases behave similarly. The main issue found was that
remnants of old compilations would lead to quadratic build time. This can be
verified by comparing:

1. Checkout the branch you are interested in.
1. Execute `create.sh`, which repeats a loop of adding one level of indirection
   and timing the compililation of each the crate configuration.
2. `git reset --hard && git clean -dff`
3. Comment-out or remove the `time cargo build` line and re-execute
   `create.sh`. Issue a `time cargo build` after the script has created the
   final configuration.
4. Note that the execution time in 2. *far* exceeds the one in the 4.

Some logs of builds on my machine can be found in `timelog` of each branch
respectively. The `plot.sh` script filters `stdin` for lines from `time …` and
extracts them as `(x, y)` pairs for a plotting tools.

## Consequences

It seems that 1st is Pretty bad. Hopefully this is indicative of some issue
that, once fixed, increases compile times by a large margin all around. Since
many projects have more than a few thousand lines of code something fishy is
going on here.  I've only gotten to ~9000 prints before compilation blew 8GB of
ram. However, in most relevant cases you can simply split your functions into
several sub-routines which scale much better.

This should not pose much headache in most day-to-day usage of `cargo`. Note
however that some workflows may exhibit conditions more similar to the test. In
particular, it is unclear if old compilation files affect the runtime or
whether frequently switching branch with `git checkout` (which does not remove
previous compilation results) has similar effects.

[1]: https://christine.website/blog/compile-stress-test-2019-10-03
