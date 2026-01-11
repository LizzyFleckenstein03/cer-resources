include "common.cr";

func main() int32 pub {
    printf(ptrof("hello, world!\n\0"), 0!uint, 0!uint);
    return 0!int32;
}
