%{

#include <stdio.h>
#include <string.h>
#include <stdlib.h>

char synonyms[100][100];
int number_synonyms = 0;

char* create_url(char* word){
	char* wordrefurl = "http://api.wordreference.com/";
	char* apikey = "de96c/";
	char* type = "thesaurus/";
	size_t totallength = strlen(wordrefurl) + strlen(apikey) + strlen(word) + strlen(type);
	char *final = (char*) malloc(totallength+1);
	final = strcpy(final, wordrefurl);
	strcat(final, apikey);
	strcat(final, type);
	strcat(final, word);
	printf("%s\n", final);
	return final;
}

void download_url(char* url){
	size_t totallength = strlen(url) + strlen("wget ") + strlen(" -o salida");
	char* url_final = (char*) malloc(totallength+1);
	url_final = strcpy(url_final, "wget ");
	strcat(url_final, url);
	strcat(url_final, " -O htmlresult");
	printf("%s\n", url_final);
	system(url_final);					
}

void yyerror (char *s) {
	printf("error\n");
	printf("%s\n", s);
}

void insertsynonyms(char* synonym){
	strcpy(synonyms[number_synonyms], synonym);
	number_synonyms++;
}

void printsynonyms(){
	int i;
	for (i = 0; i < number_synonyms; i++){
		printf("%s", synonyms[i]);
	}
}

%}


%union{
	char* string;
}

%token <string> SENSE WORDSENSE SYNONYM PRINCIPAL INTRO
%type <string> initial_part senses
%start S

%%

S: initial_part

initial_part: INTRO PRINCIPAL senses {};

senses: SENSE SENSE WORDSENSE senses {printf("HOLA1\n");}
      | SENSE SENSE WORDSENSE synonyms {printf("HOLA2\n");}

synonyms: synonyms SYNONYM {printf("HOLA3\n"); insertsynonyms($2);}
	| SYNONYM senses {printf("HOLA4\n"); insertsynonyms($1);}
	| SYNONYM {printf("HOLA5\n"); insertsynonyms($1);}

%%
void main(){
	//char* url;
	//url = create_url("house");
	//download_url(url);
	//printf("Descargado HTML RESULT\n");
	yyparse();
	printsynonyms();
}
