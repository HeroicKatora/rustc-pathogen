#! /bin/bash

eat() {
	python -c "
with open('src/main.rs.0', 'w') as ofile, open('src/main.rs') as ifile:
	for line in ifile.readlines():
		ofile.write(line)
		if line.strip() == '// INSERTHERE':
			ofile.write('||\n')
	"
	mv src/main.rs.0 src/main.rs
}

for i in {0..150}
do
	eat "$new"
	rm -r ./target
	time cargo build
done
