#define num_types 2 // Total number of query types (without error) -> afects what_2_do
#define thesaurus 0
#define translation 1

typedef struct {
	int type;
	char * word;
} query_t;

// lang_trans * lt = (lang_trans *) malloc (sizeof(lang_trans*) * num_langs);

query_t qt [num_types]= 
	{
		{0, "thesaurus"},
		{1, "translation"}
	};