func exit(status int32) extern;
func putwchar(c rune) uint32 extern;
func setlocale(category int32, locale uint) uint extern;
const LC_ALL = 6!int32;

struct stringRepr { ptr uint, len uint, }
func ptrof(s string) uint { return (s as struct stringRepr).ptr; }
func handlePanic() pub { exit(255!int32); }

func main() int32 pub {
	setlocale(LC_ALL, ptrof("en_US.utf8\0"));

	putwchar('\u0D9E');
	putwchar('\n');

	return 0!int32;
}
