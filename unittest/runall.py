#!/usr/bin/env python3

import os
import subprocess

testgroups = []

utestdir = os.getcwd()

for item in os.listdir():
	itempath = os.path.join(utestdir, item)
	if not os.path.isdir(itempath):
		continue
	elif item == 'dontrun':
		continue

	testgroups.append(itempath)

testgroups.sort()

for testgroup in testgroups:
	groupname = os.path.basename(testgroup)

	print('#================================================================#')
	print(f"# Running TEST GROUP: `{groupname}`")
	print('#================================================================#')

	os.chdir(testgroup)

	subprocess.run(['python3', 'runall.py'])
	print()
	print()
