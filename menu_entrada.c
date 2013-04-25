#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "languages.h"
#include "query_types.h"

#define error -1
#define max_len_word 50


struct query {
	int type;
	char * name; // name of the query
	char * word;
	char * trans; // languages for translation, Wordreference formatted
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
	int err = 0;
	printf("> Opción: ");
	err = scanf("%d",type);
	getchar();
	return (err==0);
}

int what_2_do(){
	int err_op = 0;
	int type = -1;
	int check = (type < 0) | (type > num_types);
	while(check){
		print_options();
		int err_op = get_opcion(&type);
		check = err_op | (type < 0) | (type >= num_types); // Checks if type is wrong
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
	int err_op = 0;
	int lang = -1;
	int check = (lang < 0) | (lang > num_langs);
	while(check){
		print_langs();
		get_opcion(&lang);
		check = err_op | (lang < 0) | (lang >= num_langs); // Checks if lang is wrong
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

char * get_query_name( struct query * q ){
	q->name = qt[q->type].word;
	return q->name;
}

void get_thesaurus(struct query * q){
	get_query_name(q);
	printf("Introduce la palabra para la que buscar sinónimos:\n");	
	char * w = get_word();
	q->word = w;
}

void get_translation(struct query * q){
	get_query_name(q);
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
	printf("- Name: %s\n", q->name);
	printf("- Word: %s\n", q->word);
	printf("- Trans: %s\n", q-> trans);
}

/*
int main(){
	struct query * q = get_query();

	print_query(q);

//	free (q);
}
*/