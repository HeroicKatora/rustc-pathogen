#! /bin/bash

dig() {
	old="$1"
	new="$2"
	mkdir $new
	pushd $new
	cargo init --lib
	echo "deeper = { package = \"leaf\", path = \"../leaf\" }" >> Cargo.toml
	echo "pub use deeper::do_something;" > src/lib.rs
	popd
	sed -i "s/leaf/$new/g" "$old/Cargo.toml"
}

old=deeper0
new=deeper1

for i in {2..150}
do
	dig "$old" "$new" >& /dev/null
	old="$new"
	new="deeper$i"
	time cargo build
done
