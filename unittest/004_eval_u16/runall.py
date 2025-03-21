#!/usr/bin/env python3
import os
import subprocess

builtins_dir = '../../builtin'
vlang_bin    = '../../target/debug/vintagecc'
vlang_suffix = '.vll'

modified_env = os.environ.copy()
modified_env['VINTAGECC_BUILTINS_PATH'] = builtins_dir

utests = []

for entry in os.listdir():
	if entry.endswith(vlang_suffix):
		utests.append(entry)


utests.sort()

for utest in utests:

	print('#----------------------------------------------------------------#')
	print(f"# Running UNIT TEST: `{utest}`")
	print('#----------------------------------------------------------------#')

	subprocess.run([vlang_bin, utest], env=modified_env)

	assmname = utest.split('.')[0] + '.s'
	subprocess.run([
		'cl65', '-t', 'cx16', '-o', 'UTEST.PRG', '-l', f'{assmname}.list', assmname])

	subprocess.run([
		'x16emu', '-warp', '-prg', 'UTEST.PRG', '-run'])
	print()
