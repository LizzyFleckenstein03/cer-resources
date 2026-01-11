struct empty {}
struct testStruct { f0 uint, f1 uint, f2 uint, }
union testUnion tag { struct empty, struct testStruct, }
func testReturn() union testUnion pub {
    return struct empty {} as union testUnion;
}
