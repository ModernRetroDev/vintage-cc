# VintageCC
Vintage Code Compiler is a simple compiler written to compile a novel and equally simple lower level language, VLL (Vintage Low-Level).

## VLL
This language is designed to be simpler to write and more expressive than 6502 assembly, but much less complex to parse (from a compiler standpoint) than C.

Currently, VintageCC can compile VLL code down to 6502 assembly (CC65 flavor) for use with the Commander X16 platform.

## Future Plans
### Additional Target Platforms
I would like to add support for other target platforms, starting with the Foenix F256 and then the X65. Another fun option would be to allow compilation of VLL code into C for subsequent compilation and use on fully modern systems.

### Included 6502/65816 Assembler
Instead of having to rely on a system installation of CC65 to compile the resulting 6502/65816 assembly, I would very much like to write and include my own rudimentary assembler so that this compiler could be used in a more standalone manner.

### Self-hosted Compilation
Given the simplistic design of VLL, it shouldn't be completely out of the realm of possibility to write a version of the compiler which could run directly on the various 8 or 16 bit systems. While I don't know how practical this would be... I'm sure it would be a lot of fun.

### VHL (Vintage High Level)
For a more concise and fun coding experience, I would eventually like to select or come up with a much more modern higher-level language design which could be compiled down to VLL, and so on and so forth.