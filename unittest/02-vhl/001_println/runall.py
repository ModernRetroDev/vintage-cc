#!/usr/bin/env python3
import os
import subprocess

builtins_dir = '../../../builtin'
vlang_bin    = '../../../target/debug/vintagecc'
vll_suffix     = '.vll'
vintage_suffix = '.vnt'

modified_env = os.environ.copy()
modified_env['VINTAGECC_BUILTINS_PATH'] = builtins_dir

utests = []

def get_vll_name(vhl_fname):
	vll_fname = vhl_fname[:-4] + ".vll"
	return vll_fname


for entry in os.listdir():
	if entry.endswith(vintage_suffix):
		utests.append(entry)


utests.sort()

for utest in utests:

	print('#----------------------------------------------------------------#')
	print(f"# Running UNIT TEST: `{utest}`")
	print('#----------------------------------------------------------------#')

	subprocess.run([vlang_bin, utest], env=modified_env)

	utest_vll = get_vll_name(utest)
	subprocess.run([vlang_bin, utest_vll], env=modified_env)

	assmname = utest_vll.split('.')[0] + '.s'
	subprocess.run([
		'cl65', '-t', 'cx16', '-o', 'UTEST.PRG', '-l', f'{assmname}.list', assmname])

	subprocess.run([
		'x16emu', '-warp', '-sound', 'none', '-prg', 'UTEST.PRG', '-run'])
	print()
