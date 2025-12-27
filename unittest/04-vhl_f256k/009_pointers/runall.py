#!/usr/bin/env python3
import os
import shutil
import signal
import subprocess

builtins_dir = '../../../builtin'
vlang_bin    = '../../../target/debug/vintagecc'
vll_suffix     = '.vll'
vintage_suffix = '.vnt'
target         = '--target=f256k'
timeout_s = 6
alignment = '1048576'
sdimage   = 'utest.img'

modified_env = os.environ.copy()
modified_env['VINTAGECC_BUILTINS_PATH'] = builtins_dir

utests = []

def get_vll_name(vhl_fname):
	vll_fname = vhl_fname[:-4] + ".vll"
	return vll_fname

def get_prg_name(vhl_fname):
	prg_fname = vhl_fname[:-4] + ".prg"
	return prg_fname

def get_pgx_name(vhl_fname):
	pgx_fname = vhl_fname[:-4] + ".pgx"
	return pgx_fname

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

	subprocess.run([vlang_bin, target, utest], env=modified_env)

	utest_vll  = get_vll_name(utest)
	utest_prg  = get_prg_name(utest)
	utest_pgx  = get_pgx_name(utest)
	utest_name = get_utest_name(utest)

	subprocess.run([vlang_bin, target, utest_vll], env=modified_env)

	assmname = utest_vll.split('.')[0] + '.s'
	subprocess.run([
		'cl65', '-t', 'cx16', '-o', utest_prg, '-l', f'{assmname}.list', assmname])

	subprocess.run(['python3', 'pgxify.py', utest_prg, '0300'])

	shutil.copyfile(utest_pgx, 'utest.pgx')

	#---------------------------------------------------------------------#
	# Build the SDCARD image before running it                            #
	#---------------------------------------------------------------------#
	subprocess.run([
		'dd', 'if=/dev/zero', f'of={sdimage}', 'bs=1M', 'count=32'])
	subprocess.run([
		'parted', sdimage,
			'mklabel', 'msdos',
			'mkpart', 'primary', 'fat32', '1MiB', '31MiB'])
	subprocess.run([
		'mformat', '-F', '-i', f'{sdimage}@@{alignment}', '::'])

	#---------------------------------------------------------------------#
	# Add the executable to the image                                     #
	#---------------------------------------------------------------------#
	subprocess.run([
		'mcopy', '-i', f'{sdimage}@@{alignment}', 'utest.pgx', '::'])

	#---------------------------------------------------------------------#
	# Run the program within the emulator and kill it after a few seconds #
	#---------------------------------------------------------------------#
	try:
		p = subprocess.Popen([
			'f256', '-skip_gameinfo', 
				'-harddisk', sdimage, 
				'-autoboot_delay', '2', 
				'-autoboot_script', 'launch.lua'], 
			start_new_session=True)
		p.wait(timeout=timeout_s)
	except subprocess.TimeoutExpired:
		print(f"Automatically terminated MAME after {timeout_s} seconds")
		os.killpg(os.getpgid(p.pid), signal.SIGKILL)

	#-----------------------------------------------#
	# Extract the output file from within the image #
	#-----------------------------------------------#
	subprocess.run([
		'mcopy', '-i', f'{sdimage}@@{alignment}', '::out.utest'])

	shutil.move('out.utest', utest_name)
	os.remove(sdimage)

	print()
