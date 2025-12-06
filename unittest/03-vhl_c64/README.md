# Unit Test Requirements

## VICE (C64 Emulator)

To run this set of unit tests, VICE will need to be installed and there will
either need to be an alias or a symlink configured so that VICE can be run using
the following name:

```bash
vice_c64
```

https://vice-emu.sourceforge.io/


## dtools (d64 Image Utility)

To enable the easy collection and extraction of unit test output files, a small
CLI utility is used. This utility can obtained and compiled from source from the
following location:

https://github.com/ModernRetroDev/dtools

Once compiled for your system, the executable must be made available in your
path for the unit test scripts to be able to locate and use it.