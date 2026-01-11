func exit(status int32) extern;
func puts(s uint) int32 extern;
struct stringRepr { ptr uint, len uint, }
func ptrof(s string) uint { return (s as struct stringRepr).ptr; }
func handlePanic() pub { exit(255!int32); }

func sideEffect(b bool, s string) bool {
    puts(ptrof(s));
    return b;
}

func main() int32 pub {
    if false || sideEffect(false, "GOOD: || evaluates right-hand when needed\0") {
        puts(ptrof("BAD: wrong false || false result\0"));
    }
    if !(false || sideEffect(true, "GOOD: || evaluates right-hand when needed\0")) {
        puts(ptrof("BAD: wrong false || true result\0"));
    }
    if !(true || sideEffect(false, "BAD: || does not short-circuit\0")) {
        puts(ptrof("BAD: wrong true || false result\0"));
    }
    if !(true || sideEffect(true, "BAD: || does not short-circuit\0")) {
        puts(ptrof("BAD: wrong true || true result\0"));
    }

    if false && sideEffect(false, "BAD: && does not short-circuit\0") {
        puts(ptrof("BAD: wrong false && false result\0"));
    }
    if false && sideEffect(true, "BAD: && does not short-circuit\0") {
        puts(ptrof("BAD: wrong false && true result\0"));
    }
    if true && sideEffect(false, "GOOD: && evaluates right-hand when needed\0") {
        puts(ptrof("BAD: wrong true && false result\0"));
    }
    if !(true && sideEffect(true, "GOOD: && evaluates right-hand when needed\0")) {
        puts(ptrof("BAD: wrong true && true result\0"));
    }

    return 0!int32;
}
