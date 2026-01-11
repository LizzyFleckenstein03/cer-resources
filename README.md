# Cer Resources

This is a collection of some unofficial examples and utilities for the [Cer programming language](https://himbeerserver.de/cer/)

Unless platform agnostic, everything in here is written for amd64-linux-gnu.

# cerc.sh

[cerc.sh](cerc.sh) is a posix shell wrapper script for the `cerc` compiler which compiles, assembles, and links a Cer program for you. The program is linked against libc.

Usage: `cerc.sh <file1> [<file2> ...]`

Requires `cerc` and `qbe` to be available in `$PATH`.

The entry point for your program will be the `main` function, which should have the following signature: `func main() int32 pub`.

Set the `OUTFILE` environment variable to control the name of the output executable. By default, the executable name is derived from the base name of the first file.

Set the `WORKDIR` environment variable to control the directory for temporary files. By default, a temporary directory is created in /tmp.

# examples

The [examples](examples) directory contains introductory examples. All of these must be compiled with `cerc.sh` and depend on `common.cr`. For example, use:

```sh
./cerc.sh examples/hello.cr examples/common.cr
./hello
```

to compile and run the hello world example.

[hello.cr](examples/hello.cr): Hello world.

[temp.cr](examples/temp.cr): Fahrenheit/celsius temperature table.

[tree.cr](examples/tree.cr): Sort input lines alphabetically, using a binary tree. You can use [tree_input.txt](examples/tree_input.txt) as test input (taken from the K&R C book).

# tests

The [tests](tests) directory contains test files for compiler patches I'm working on. Expect breakage.
