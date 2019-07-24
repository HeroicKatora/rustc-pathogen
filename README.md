A collection of bad scaling in cargo or rustc. Check out each branch for an
example. Each example can be scaled to some arbitrary number to plot the
compile time.

## Description

* `deeper`: Each iteration creates a new folder `$new`, moves the previous
  library into it and initializes within the work dir a new library target
  that depends on the inner library in `$new` and re-exports its only symbol
  `do_something`.
* `deep-and-broad`: Like `deeper` but instead of having libraries in ever
  longer paths, creates a sibling folder for each level of libraries. The
  hierarchy is unchanged but its representation on disk does not consume linear
  file paths.

## Issues

Both currently found cases behave similarly. The main issue found was that
remnants of old compilations would lead to quadratic build time. This can be
verified by comparing:

1. Execute `create.sh`, which adds one level of indirection and then tries to
   compile the configuration.
2. `git reset --hard && git clean -dff`
3. Comment-out or remove the `time cargo build` line and re-execute
   `create.sh`. Issue a `time cargo build` after the script has created the
   final configuration.
4. Note that the execution time in 1. *far* exceeds the one in the 3.

## Consequences

This should not pose much headache in most day-to-day usage of `cargo`. Note
however that some workflows may exhibit conditions more similar to the test. In
particular, it is unclear if old compilation files affect the runtime or
whether frequently switching branch with `git checkout` (which does not remove
previous compilation results) has similar effects.
