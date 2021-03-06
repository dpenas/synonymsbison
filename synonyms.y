%{
#include <string.h>
#include <stdlib.h>
#include "menu_entrada.c"
#include "createhtml.h"
#define input_html "htmlresult"
#define output_html "salida.html"

char everything[10000][10000];
int number_everything = 0;
int senses[100000];
int number_senses = 0;
FILE *file;

char* create_url(struct query * q){
	char* wordrefurl = "http://api.wordreference.com/";
	char* apikey = "de96c/";
	char* name = q->name;
	char* word = q->word;
	size_t totallength = strlen(wordrefurl) + strlen(apikey) + strlen(name) + strlen(word);
	char *final = (char*) malloc(totallength+1);
	final = strcpy(final, wordrefurl);
	strcat(final, apikey);
	if(q->type == translation)
		strcat(final, q->trans);
	else
		strcat(final, name);
	strcat(final, "/");
	strcat(final, word);
	return final;
}

void download_url(char* url){
	size_t totallength = strlen(url) + strlen("wget ") + strlen(" -o salida");
	char* url_final = (char*) malloc(totallength+1);
	url_final = strcpy(url_final, "wget ");
	strcat(url_final, url);
	strcat(url_final, " -O ");
	strcat(url_final, input_html);
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


void printsensehtml (FILE* file, char* sense){
	char* createhtml1;
	char* createhtml2;
		createhtml1 = "<tr class='odd'><td><span class='FrW2'>";
		createhtml2 = "</span></td></tr>";
//		createhtml1 = "<tr class='even'><td><span class='To2'>";
//		createhtml2 = "</span></td></tr>";
	fprintf(file, "%s", createhtml1);
	fprintf(file, "%s", sense);
	fprintf(file, "%s", createhtml2);
}

void printwordhtml (FILE* file, char* word){
	char* createhtml = "<tr class= 'even'><td class='ToWrd'>";
	char* createhtml1 = "</td></tr>";
	fprintf(file, "%s", createhtml);
	fprintf(file, "%s", word);
	fprintf(file, "%s", createhtml1);
}

void printsynonyms(){
	int i, j, count;
	count = 0;
	for (i = 0; i < number_senses; i++){
		printsensehtml(file, everything[count]);
		count++;
		for (j = count; j < senses[i+1]; j++){
			printwordhtml(file, everything[j]);
			count++;
		}
	}
	for (i = count; i < number_everything; i++){
		printwordhtml(file, everything[i]);
	}
}

void printhtmltrans(char* word, int flag){
	char* createhtml;
	char* createhtml1;
	/*
	* 0: It's a word
	* 1: It's a sense
	* 2: It's a ToTrans
	*/
	if(flag == 0){
		createhtml = "<tr class= 'odd'><td class='ToWrd'>";
		createhtml1 = "</td></tr>";				
	}
	if(flag == 1){
		createhtml = "<tr class= 'odd'><td> <span class='To2'>";
		createhtml1 = "</span></td></tr>";
	}
	else{
		createhtml = "<tr class= 'even'><td><span class='FRW2'>";
		createhtml1 = "</span></td></tr>";
	}

	fprintf(file, "%s", createhtml);
	fprintf(file, "%s", word);
	fprintf(file, "%s", createhtml1);
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

totrans: TOTRANS {/*printhtmltrans($1,2);*/}
| tsense TOTRANS {/*printhtmltrans($2,2);*/}

tsense: tword TSENSE {insertsenses($2);}
      | tsense TSENSE {insertsenses($2);}
      | totrans TSENSE {insertsenses($2);}
      | tword TOTRANS {/*printhtmltrans($2,2);*/}
      | TSENSE {insertsenses($1);}

tword: tsense TRANS {inserteverything($2);}
     | tword TRANS {inserteverything($2);}
     | TRANS {inserteverything($1);}

synerror: NOTFOUND {yyerror("The word isn't in the dictionary\n");}

%%
int main(){
	FILE * archivo;
	struct query * q = get_query();	
	char* url;
	url = create_url(q);
	download_url(url);
	file = fopen(output_html,"wr");
	archivo = fopen(input_html,"r");
	lecturaFichero(archivo);
	yyparse();
	createhtml(file);
	printsynonyms();

}
