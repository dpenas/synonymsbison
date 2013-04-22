%{
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <stdio.h>

char everything[100][100];
int number_everything = 0;
int senses[100];
int number_senses = 0;
FILE *file;

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
	printf("\nerror: %s\n", s);
	exit(1);
}

void insertsenses(char* sense){
	strcpy(everything[number_everything], sense);
	senses[number_senses] = number_everything;
	number_everything++;
	number_senses++;
}

void inserteverything(char* something){
	strcpy(everything[number_everything], something);
	number_everything++;
}

void printsynonyms(){
	int i, j, count;
	count = 0;
	for (i = 0; i < number_senses; i++){
		fprintf(file, "\nSense: %s\n", everything[count]);
		count++;
		for (j = count; j < senses[i+1]; j++){
			fprintf(file, " %s ", everything[j]);
			count++;
		}
	}
	for (i = count; i < number_everything; i++){
		fprintf(file, " %s ", everything[i]);
	}
		fprintf(file, "\n");
}

void insertTrans(char * cosas){
	fprintf(file, " %s ", cosas);
}

%}


%union{
	char* string;
}

%token <string> SYNONYM SENSE TOTRANS TRANS TSENSE NOTFOUND
%type <string> thesaurus synonyms senses tsense tword synerror
%start S

%%

S: thesaurus | translations | synerror

thesaurus: senses|synonyms {};

senses: synonyms SENSE {insertsenses($2);}
      | SENSE {insertsenses($1);}

synonyms: synonyms SYNONYM {inserteverything($2);}
	| senses SYNONYM {inserteverything($2);}
	| senses SENSE {inserteverything($2);}
	| SYNONYM {inserteverything($1);}

translations: totrans | tsense | tword {};

totrans: TOTRANS {insertTrans($1);}
     | tsense TOTRANS {insertTrans($2);}

tsense: tword TSENSE {insertTrans($2);}
      | tsense TSENSE {insertTrans($2);}
      | totrans TSENSE {insertTrans($2);}
      | tword TOTRANS {insertTrans($2);}
      | TSENSE {insertTrans($1);}

tword: tsense TRANS {insertTrans($2);}
     | tword TRANS {insertTrans($2);}
     | TRANS {insertTrans($1);}

synerror: NOTFOUND {yyerror("The word isn't in the dictionary\n");}

%%
int main(){
	//char* url;
	//url = create_url("house");
	//download_url(url);
	//printf("Descargado HTML RESULT\n");
	file = fopen("salida.txt","a++");
	yyparse();
	printf("IMPRIMIMOS\n");
	printsynonyms();
}
