#!/bin/sh
set -e
: "${OUTFILE=$(basename -s .cr $1)}"
if [ -z "$WORKDIR" ]; then
	WORKDIR="$(mktemp -d -t cerc.XXXXXXXXXX)"
	trap "rm -rf \"$WORKDIR\"" EXIT
fi
for arg; do
	base="$(basename -s .cr $arg)"
	cerc "$arg" > "$WORKDIR/$base.ssa"
	qbe "$WORKDIR/$base.ssa" -o "$WORKDIR/$base.as"
	as -g "$WORKDIR/$base.as" -o "$WORKDIR/$base.o"
done
as -g -o "$WORKDIR/_start.o" << EOF
.text
.globl _start
.balign 16
_start:
	callq main
	mov %rax, %rdi
	callq exit
.section .note.GNU-stack,"",@progbits
EOF
ld -g -lc -e _start -dynamic-linker /lib64/ld-linux-x86-64.so.2 "$WORKDIR"/*.o -o "$OUTFILE"
