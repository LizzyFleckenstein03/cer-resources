func exit(status int32) pub extern;
func printf(fmt uint, arg1 uint, arg2 uint) int32 pub extern;

struct stringRepr pub { ptr uint, len uint, }
func ptrof(s string) uint pub {
	return (s as struct stringRepr).ptr;
}

struct panic_info pub {
	filename string,
	line uint64,
	column uint64,
	cause uint64,
	a0 uint64,
	a1 uint64,
}
func handle_panic(inf struct panic_info) pub {
	printf(ptrof("panic in %.*s:\0"), lenof(inf.filename), ptrof(inf.filename));
	printf(ptrof("%llu:%llu: \0"), inf.line as uint, inf.column as uint);

	if inf.cause == 1!uint64 {
		printf(ptrof("union tag does not match conversion target\n\0"), 0!uint, 0!uint);
	} else if inf.cause == 2!uint64 {
		printf(ptrof("index %llu out of bounds for length %llu\n\0"),
			inf.a0 as uint, inf.a1 as uint);
	} else if inf.cause == 3!uint64 {
		printf(ptrof("index %llu out of bounds for length %llu\n\0"),
			inf.a0 as uint, inf.a1 as uint);
	} else if inf.cause == 4!uint64 {
		printf(ptrof("index %llu out of bounds for length %llu\n\0"),
			inf.a0 as uint, inf.a1 as uint);
	} else {
		printf(ptrof("?\n\0"), 0!uint, 0!uint);
	}

	exit(255!int32);
}
