A collection of bad scaling in cargo or rustc. Check out each branch for an
example. Each example can be scaled to some arbitrary number to plot the
compile time.

## Usage

Short instructions: This times the build and then show a plot with matplotlib
and pyplot (you'll obviously need them installed).

```
./create.sh | tee -a time.log
./mem.sh < time.log | ./plot.sh
```

## Description

* `hello-world` (this branch): A simple main that prints `Hello, world`
  repeatedly by repeating the same line. Inspired by [this blog post][1].
* `deeper`: Each iteration creates a new folder `$new`, moves the previous
  library into it and initializes within the work dir a new library target
  that depends on the inner library in `$new` and re-exports its only symbol
  `do_something`.
* `deep-and-broad`: Like `deeper` but instead of having libraries in ever
  longer paths, creates a sibling folder for each level of libraries. The
  hierarchy is unchanged but its representation on disk does not consume linear
  file paths.

## Issues

I've only gotten to ~9000 prints before compilation blew 8GB of ram.

## Consequences

Pretty bad. Hopefully this is indicative of some issue that, once fixed,
increases compile times by a large margin all around. Since many projects have
more than a few thousand lines of code something fishy is going on here.

[1]: https://christine.website/blog/compile-stress-test-2019-10-03
