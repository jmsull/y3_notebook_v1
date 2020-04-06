#!/bin/python
import sys
filen = sys.argv[1]
path = sys.argv[2]

if( 'json' in filen):
	with open(filen, "r") as in_file:
		buf = in_file.readlines()

	with open(filen, "w") as out_file:
		for line in buf:
			if line == ' "argv": [\n':
				line = line + '"'+path+'",\n'
			out_file.write(line)
elif( 'kernel_cosmosis' in filen):
	with open(filen, "r") as in_file:
		buf = in_file.readlines()

	with open(filen, "w") as out_file:
		for line in buf:
			if line == 'source activate cosmosis-nbtt\n':
				line = line + 'export COSMOSIS_SRC_DIR="'+path+'"\n'
			out_file.write(line)
