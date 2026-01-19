struct str { s string, }

func test() struct str {
	return struct str { s = "test", };
}

func main() int32 pub {
	var ret int32 = 0!int32;
	if lenof(test().s) != 4!uint {
		ret = 1!int32;
	}
	return ret;
}
