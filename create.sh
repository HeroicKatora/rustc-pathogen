#! /bin/bash

eat() {
	awk '/\}/ { for(i=0;i<100;i++) print "println!(\"Hello world\");" } { print }' < src/main.rs > src/main.alt.rs
	mv src/main.alt.rs src/main.rs
}

for i in {0..100}
do
	eat # >& /dev/null
	time cargo build
done
