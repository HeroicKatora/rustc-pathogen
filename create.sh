#! /bin/bash

dig() {
	old="$1"
	new="$2"
	mkdir $new
	mv -t $new Cargo.toml src $old
	cargo init --lib
	sed -i "s/deeper/$new/" Cargo.toml
	echo "deeper = { package = \"$old\", path = \"./$new\" }" >> Cargo.toml
	echo "pub use deeper::do_something;" > src/lib.rs
}

old=deeper0
new=deeper1

for i in {2..50}
do
	dig "$old" "$new" >& /dev/null
	old="$new"
	new="deeper$i"
	time cargo build
done
