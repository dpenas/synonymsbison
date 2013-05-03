CC = gcc -g -O0

INPUT = synonyms
FLEX = lex.yy.c
BISON = y.tab.c

default: clean execute

execute:	
	bison $(INPUT).y -yd
	flex $(INPUT).l
	$(CC) $(FLEX) $(BISON) -o $(INPUT) -lfl -ly

clean:
	find . -type f -not -name "*.h" -not -name "*.l" -not -name "*.y" -not -name "makefile" -not -name "menu_entrada.c"| xargs rm
