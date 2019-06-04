#! /bin/bash

eat() {
	new="$1"
	mkdir $new
	pushd $new
	cargo init --lib
	echo "pub fn hello_there() { println!(\"We meet again, $new\") } " > src/lib.rs
	popd
	echo "$new = { path = \"$new\" }" >> Cargo.toml
	echo "pub use $new::hello_there as ${new}_there;" >> src/lib.rs
}

for i in {0..1050}
do
	new="fatter$i"
	eat "$new" >& /dev/null
	# rm -r ./target
	# time cargo build
done
