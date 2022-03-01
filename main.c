#include "sys_calls.h"
#define NULL 0

const int stdin = 0;
const int stdout = 1;
const int stderr = 2;

#define BUFLEN 1024
static const char dunno[] = "I don't know how to greet you. Please specify your name: ";
static const char greet[] = "Nice to meet you, ";
static const char errmsg[] = "I didn't get your name :(\n";
static char *name = NULL;
static char buf[BUFLEN];

int mstrlen(const char *buf)
{
	int i = 0;
	while (buf[i] != '\0')
		i++;
	return i;
}

int main(int argc, char **argv)
{
	if (argc < 2)
	{
		sys_write(stdout, dunno, sizeof(dunno));
		int res = sys_read(stdin, buf, BUFLEN);
		if (res == -1)
		{
			sys_write(stdout, errmsg, sizeof(errmsg));
			return 1;
		}
		name = buf;
	}
	else
	{
		name = argv[1];
	}

	sys_write(stdout, greet, sizeof(greet));
	sys_write(stdout, name, mstrlen(name));
	sys_write(stdout, "\n", 1);

	return 0;
}
