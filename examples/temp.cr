include "common.cr";

func main() int32 pub {
	var lower int32 = 0!int32;
	var upper int32 = 300!int32;
	var step int32 = 20!int32;

	printf(ptrof(" °F    °C\n\0"), 0!uint, 0!uint);
	for var fahr int32 = lower; fahr <= upper; fahr += step {
		var celsius int32 = 5!int32 * (fahr - 32!int32) / 9!int32;
		printf(ptrof("%3d   %3d\n\0"), (fahr as uint32) as uint, (celsius as uint32) as uint);
	}

    return 0!int32;
}
