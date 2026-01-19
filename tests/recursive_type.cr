struct empty {}

union maybeNode tag { struct empty, *struct node, }

struct node {
	left union maybeNode,
	right union maybeNode,
	content string,
}
