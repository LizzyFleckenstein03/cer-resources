include "common.cr";

func malloc(size uint) *any extern;
func free(ptr *any) extern;
func getline(lineptr *uint, n *uint, stream *any) int32 extern;
var stdin extern *any;

struct sliceRepr { ptr uint, len uint, cap uint, }

struct empty {}

union maybeString tag { struct empty, string, }
union maybeNode tag { struct empty, *struct node, }

struct node {
	left union maybeNode,
	right union maybeNode,
	content string,
}

enum 0!int { ordLt = -1!int, ordGt = 0!int, ordEq = 1!int, }

func makeString(bytes []uint8) union maybeString {
	var repr struct sliceRepr = bytes as struct sliceRepr;
	return (struct stringRepr { ptr = repr.ptr, len = repr.len, } as string) as union maybeString;
}

func copyMem(dst []uint8, src []uint8) {
	for var i uint = 0!uint; i < lenof(src); i++ {
		dst[i] = src[i];
	}
}

func copyString(s string) string {
	var len uint = lenof s;
	var bytes uint = malloc(len) as uint;
	copyMem(
		struct sliceRepr { ptr = bytes, len = len, cap = len, } as []uint8,
		struct sliceRepr { ptr = ptrof(s), len = len, cap = len, } as []uint8,
	);
	return struct stringRepr { ptr = bytes, len = len, } as string;
}

func freeString(s string) {
	free((s as struct stringRepr).ptr as *any);
}

func compareString(a string, b string) int {
	for var i uint = 0!uint; i < lenof a; i++ {
		if i >= lenof b || a[i] > b[i] {
			return ordGt;
		} else if (a[i] < b[i]) {
			return ordLt;
		}
	}

	if lenof(a) == lenof(b) {
		return ordEq;
	}

	return ordLt;
}

func readLine(buf *[]uint8) bool {
	var repr struct sliceRepr = *buf as struct sliceRepr;
	var status int32 = getline(&repr.ptr, &repr.cap, stdin);
	if status == -1!int32 {
		return false;
	}
	repr.len = (status as uint32) as uint;
	*buf = (repr as []uint8);
	return true;
}

func freeReadBuffer(buf []uint8) {
	free((buf as struct sliceRepr).ptr as *any);
}

func allocNode(content string) *struct node {
	var n *struct node = malloc(sizeof *n) as *struct node;
	*n = struct node {
		left = struct empty {} as union maybeNode,
		right = struct empty {} as union maybeNode,
		content = copyString(content),
	};
	return n;
}

func freeNode(n *struct node) {
	freeString((*n).content);
	free(n as *any);
}

func insert(tree *union maybeNode, content string) {
	if *tree is struct empty {
		*tree = allocNode(content) as union maybeNode;
	} else {
		var n *struct node = *tree as *struct node;
		var o int = compareString(content, (*n).content);

		if o == ordLt {
			insert(&(*n).left, content);
		} else if o == ordGt {
			insert(&(*n).right, content);
		}
	}
}

func printTree(tree union maybeNode) {
	if tree is *struct node {
		var n *struct node = tree as *struct node;
		printTree((*n).left);
		printf(ptrof("%.*s\n\0"), lenof (*n).content, ptrof((*n).content));
		printTree((*n).right);
	}
}

func freeTree(tree union maybeNode) {
	if tree is *struct node {
		var n *struct node = tree as *struct node;
		freeTree((*n).left);
		freeTree((*n).right);
		freeNode(n);
	}
}

func main() int32 pub {
	var buffer []uint8 = [0!uint] uint8 {};
	var tree union maybeNode = struct empty {} as union maybeNode;

	for ; readLine(&buffer); {
		if lenof buffer > 0!uint && (buffer[lenof buffer-1!uint] as uint32) as rune == '\n' {
			buffer = buffer[0!uint : (lenof buffer-1!uint)];
		}

		var line union maybeString = makeString(buffer);
		if line is string {
			insert(&tree, line as string);
		}
	}

	printTree(tree);
	freeTree(tree);
	freeReadBuffer(buffer);

	return 0!int32;
}
