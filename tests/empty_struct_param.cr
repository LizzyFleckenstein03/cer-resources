func exit(status int32) extern;
func puts(fmt uint) int32 extern;
struct stringRepr { ptr uint, len uint, }
func ptrof(s string) uint { return (s as struct stringRepr).ptr; }
func handlePanic() pub { exit(255!int32); }

struct empty {}
union testUnion tag { struct empty, string, }
func testParam(u union testUnion) {
	if (u is string) {
		puts(ptrof(u as string));
	}
}

func main() int32 pub {
	testParam("hello world\0" as union testUnion);
	return 0!int32;
}
