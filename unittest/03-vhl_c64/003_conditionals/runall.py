#!/usr/bin/env python3
import os
import signal
import subprocess

timeout_s    = 3
builtins_dir = '../../../builtin'
vlang_bin    = '../../../target/debug/vintagecc'
vll_suffix     = '.vll'
vintage_suffix = '.vnt'
target         = '--target=c64'

modified_env = os.environ.copy()
modified_env['VINTAGECC_BUILTINS_PATH'] = builtins_dir

utests = []

def get_d64_name(vhl_fname):
	d64_fname = vhl_fname[:-4] + ".d64"
	return d64_fname

def get_vll_name(vhl_fname):
	vll_fname = vhl_fname[:-4] + ".vll"
	return vll_fname

def get_utest_name(vhl_fname):
	utest_fname = vhl_fname[:-4] + ".utest"
	return utest_fname



for entry in os.listdir():
	if entry.endswith(vintage_suffix):
		utests.append(entry)


utests.sort()

for utest in utests:

	print('#----------------------------------------------------------------#')
	print(f"# Running UNIT TEST: `{utest}`")
	print('#----------------------------------------------------------------#')

	d64name = get_d64_name(utest)
	utest_name = get_utest_name(utest)

	if os.path.exists(utest_name):
		os.remove(utest_name)

	subprocess.run([vlang_bin, target, utest], env=modified_env)

	utest_vll = get_vll_name(utest)
	subprocess.run([vlang_bin, target, utest_vll], env=modified_env)

	assmname = utest_vll.split('.')[0] + '.s'
	subprocess.run([
		'cl65', '-t', 'c64', '-o', 'utest.prg', '-l', f'{assmname}.list', assmname])

	subprocess.run([
		'dtools', 'create', '-f', d64name, '-t', '35'])
	subprocess.run([
		'dtools', 'format', '-f', d64name, '-n', 'UTEST', '-i', '01'])
	subprocess.run([
		'dtools', 'insert', '-f', d64name, '-n', 'UTEST.PRG', '-i', 'utest.prg'])

	try:
		p = subprocess.Popen(['vice_c64', '-warp', d64name], start_new_session=True)
		p.wait(timeout=timeout_s)
	except subprocess.TimeoutExpired:
		print(f"Automatically terminated VICE after {timeout_s} seconds")
		os.killpg(os.getpgid(p.pid), signal.SIGTERM)

	print(f"extracting text file... `{utest_name}`")
	subprocess.run([
		'dtools', 'extract-text', '-f', d64name, '-n', 'UTEST', '-o', utest_name])

	print()
