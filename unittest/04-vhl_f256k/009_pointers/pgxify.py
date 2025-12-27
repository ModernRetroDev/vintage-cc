#!/usr/bin/env python3

import sys


def main():
	prgname = ''
	address = ''
	args = sys.argv

	if len(args) >= 3:
		prgname = args[1]
		address = args[2]
	else:
		print("usage: pgxify.py  PRGFILE  ADDRESS_0")
		print("Adds lead-in bytes to a PRG to make it a F256, PGX file.")
		return;

	if not (prgname.endswith(".prg") or prgname.endswith(".PRG")):
		print("ERROR: PRGFILE, must end with either `.prg` or `.PRG`.")
		return;

	fname_in  = prgname
	fname_out = prgname[:-4] + ".pgx"

	print(f"fname_out = `{fname_out}`")

	with open(fname_out, "wb") as f_out:
		f_out.write(0x50.to_bytes(1, 'little')) # 'P'
		f_out.write(0x47.to_bytes(1, 'little')) # 'G'
		f_out.write(0x58.to_bytes(1, 'little')) # 'X'
		#
		f_out.write(0x03.to_bytes(1, 'little')) # '1' CPU = 65C02
		# 0x080D
		f_out.write(0x00.to_bytes(1, 'little')) # ADDR_LO
		f_out.write(0x03.to_bytes(1, 'little')) # ADDR_HI
		f_out.write(0x00.to_bytes(1, 'little')) # ADDR_LO
		f_out.write(0x00.to_bytes(1, 'little')) # ADDR_LO

		with open(fname_in, "rb") as f_in:
			data = f_in.read()

			# trim off the leading 14 bytes associated with launching binaries
			# on the X16
			f_out.write(data[14:])

if __name__ == "__main__":
	main()
