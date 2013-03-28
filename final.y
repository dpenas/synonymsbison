%{

#include <stdio.h>
#include <string.h>
#include <stdlib.h>

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

synonyms: SYNONYM synonyms {printf("HOLA3\n");}
	| SYNONYM senses {printf("HOLA4\n");}
	| SYNONYM {printf("HOLA5\n");}

%%
void main(){
	char* url;
	url = create_url("house");
	download_url(url);
	printf("Descargado HTML RESULT\n");
	yyparse();
}
