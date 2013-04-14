%{
#include <stdio.h>
#include <string.h>
#include <stdlib.h>

char synonyms[100][100];
int number_synonyms = 0;
char senses[100][100];
int number_senses = 0;
int eachsense[100];
int wholedata[100];
int number_eachsense = 0;

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
	number_eachsense++;
}

void insertsenses(char* sense){
	strcpy(senses[number_senses], sense);
	eachsense[number_senses] = number_eachsense;
	number_eachsense = 0;
	number_senses++;
}

void addwholedata(){
	int i;
	for (i = 1; i < number_senses; i++){
		wholedata[i+1] = eachsense[i-1] + eachsense[i];
	}
}

void printsynonyms(){
	int i, j;
	addwholedata();
	eachsense[0] = number_synonyms - eachsense[number_eachsense];
	for (i = 0; i < number_senses; i++){
		printf("\nSense: %s\n", senses[i]);
		for (j = 0; j < eachsense[i]; j++){
			if (i == 0){
				printf("%s ", synonyms[j]);
			}else{
				if (i == 1){
					printf("%s ", synonyms[j + eachsense[i-1]]);
				}else{	
					printf("%s ", synonyms[j + wholedata[i]]);
				}
			}
		}
	}
}

%}


%union{
	char* string;
}

%token <string> SYNONYM SENSE
%type <string> thesaurus synonyms senses
%start S

%%

S: thesaurus

thesaurus: senses|synonyms {};

senses: synonyms SENSE {insertsenses($2);}
      | SENSE {insertsenses($1);}

synonyms: synonyms SYNONYM {insertsynonyms($2);}
	| senses SYNONYM {insertsynonyms($2);}
	| senses SENSE {insertsenses($2);}
	| SYNONYM {insertsynonyms($1);}


%%
void main(){
	//char* url;
	//url = create_url("house");
	//download_url(url);
	//printf("Descargado HTML RESULT\n");
	yyparse();
	printf("IMPRIMIMOS\n");
	printsynonyms();
}
