# Unit Test Requirements

## MAME (Multi-platform Emulator)

To run this set of unit tests, a specific version of MAME which includes F256
platform support will need to be installed and there will either need to be an
alias or a symlink configured so that this version of MAME can be run using the
following name:

```bash
f256
```

https://github.com/dtremblay/mame/releases/

### Building from Source

In the event that you need to compile the latest version from source, you will
need to use the `f256k` git branch from the following repository.

https://github.com/dtremblay/mame


## mtools (MS-DOS File Utilities)

SD card images for the unit tests are made in part using `mtools`, which should
be readily available in the repositories of most Linux distributions.

For Debian/Ubuntu or derivative Linux distributions, it should be possible to
install this set of utilities by running something like the following:

```bash
sudo apt install mtools
```
