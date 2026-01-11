# VintageCC

The Vintage Code Compiler (VCC) is a program designed and created to compile a
novel programming language named Vintage. 

## Vintage Language

Vintage is a higher-level language which is syntactically similar to `rust` but,
includes a number of design features which make it particularly unique. This
language was created with the primary goal of application development for older
and modern retro-computing systems.

Official documentation for the language is currently in development but, is not
yet ready. For now, the best references available are the included unit-tests.

## Supported Platforms

Currently VCC can compile Vintage code to `cc65` assembly which can then be used
to produce programs which run on the following platforms:

* Commander X16
* Commodore 64
* Foenix/Wildbits F256K

## Future Plans
### Integrated Build System

Internally, VCC compiles the higher-level Vintage code down to a lower-level
language, VLL. VCC can then compile the VLL code down into assembly language
code, which can then be assembled using a supported assembler (i.e. `cc65`).

The hope is to eventually streamline this process by including a build-system
capability into the VCC which should eliminate the need for using ancillary
build scripts.

### Add Remaining Language Features

VCC doesn't currently support all of the language features I originally planned
to include into Vintage. The following isn't an exhaustive list however, here
are a few of the language features which I plan to add but haven't included yet:

* Error Handling System
* Defer/Finally
* Code/Module Init Function Support
* Global/Module-Level Variables
* Signed Integers (i8/i16/i24)
* String Library Functions

### Additional Target Platforms

The following is a list of platforms that I would be interested in supporting:

* X65 (https://x65.zone/)
* MEGA65 (https://mega65.org/) 
* VLL -> C (allowing for code compilation and use on modern platforms)

That said, the MEGA65 target is currently impossible for me to make as I don't
have the hardware and the emulator is only made available to people who own the
hardware.

### Included 6502/65816 Assembler

Instead of having to rely on a system installation of `cc65` to compile the
resulting 6502/65816 assembly, I would very much like to write and include my
own rudimentary assembler so that this compiler could be distributed and used in
a more standalone manner.

### Self-hosted Compilation

Given the simplistic design of VLL, it shouldn't be completely out of the realm
of possibility to write a version of the compiler which could run directly on
the various 8 or 16 bit systems. While I don't know how practical this would
be... I'm sure it would be a lot of fun.
