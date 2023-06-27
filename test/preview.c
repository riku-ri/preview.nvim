#include <stdio.h>

int
main(int argc, char *arg_v[])
{
	while(--argc) printf("|%s|", arg_v[argc])
	/* try comment semicolon below */
	;
}
