tunalloc: tunalloc.o test_iftun.o
	gcc -o tunalloc tunalloc.o test_iftun.o

tunalloc.o: tunalloc.c
	gcc -o tunalloc.o -c tunalloc.c -W -Wall -ansi -pedantic

test_iftun.o: test_iftun.c tunalloc.h
	gcc -o test_iftun.o -c test_iftun.c -W -Wall -ansi -pedantic
