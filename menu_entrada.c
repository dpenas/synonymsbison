#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "languages.h"

#define error -1
#define num_types 2 // Total number of query types (without error) -> afects what_2_do
#define thesaurus 0
#define translation 1
#define max_len_word 50


struct query {
	int type;
	char * word;
	char * trans; //languages for translation, Wordreference formatted
};


void print_options(){
	printf("\t ______________________\n");
	printf("\t|Selecciona la opción: |\n");
	printf("\t|   # 0: Sinónimos     |\n");
	printf("\t|   # 1: Traducción    |\n");
	printf("\t|______________________|\n");
	
}

void print_langs(){
	printf("\t ______________________\n");
	printf("\t|Selecciona el idioma: |\n");
	printf("\t|   # 0: Inglés        |\n");
	printf("\t|   # 1: Español       |\n");
	printf("\t|______________________|\n");

}

int get_opcion(int * type){
	printf("Opción: ");
	scanf("%d",type);	
}

int what_2_do(){
	int type = -1;
	int check = (type < 0) | (type > num_types);
	while(check){
		print_options();
		get_opcion(&type);
		check = (type < 0) | (type >= num_types); // Checks if type is wrong
		if(check)
			printf("\n** Error: Opción no válida. Selecciona de nuevo, por favor. **\n");
	}

	return type;
}

char * get_word(){
	char * w = (char *) malloc (sizeof(char*) * max_len_word);
	printf("Palabra: ");
	scanf( "%s", w); 
	return w;
}

int get_lang(){
	int lang = -1;
	int check = (lang < 0) | (lang > num_langs);
	while(check){
		print_langs();
		get_opcion(&lang);
		check = (lang < 0) | (lang >= num_langs); // Checks if lang is wrong
		if(check)
			printf("\n** Error: Opción no válida. Selecciona de nuevo, por favor. **\n");
	}	
	return lang;
}


char * format_trans(lang1, lang2){
	char * trans;
	char * pal1 = lt[lang1].word;
	char * pal2 = lt[lang2].word;

	trans = strdup(pal1);

	strcat(trans, pal2);
	return trans;
}

void get_thesaurus(struct query * q){
	printf("Introduce la palabra para la que buscar sinónimos:\n");	
	char * w = get_word();
	q->word = w;
}

void get_translation(struct query * q){
	printf("Introduce la palabra a traducir\n");
	char * w = get_word();
	q->word = w;
	printf("Idioma origen:\n");
	int lang1 = get_lang();
	printf("Idioma destino:\n");
	int lang2 = get_lang();

	int max_trans = 6;
	char * trans = (char *) malloc (sizeof(char*) * max_trans);	
	trans = format_trans(lang1,lang2);
	q->trans = trans;
}


struct query * get_query(){
	struct query * q = (struct query *) malloc(sizeof(struct query));

	q->type = what_2_do();

	switch(q->type) {

		case thesaurus :
			get_thesaurus(q);
			break;

		case translation :
			get_translation(q);
			break;

		default :
			printf("Error obtaining the query\n");
			exit(-1);
	}

	return q;
}


void print_query(struct query * q){
	printf("Query:\n");
	printf("- Type: %d\n", q->type);
	printf("- Word: %s\n", q->word);
	printf("- Trans: %s\n", q-> trans);
}

int main(){
	struct query * q = get_query();

	print_query(q);

//	free (q);
}