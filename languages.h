#define num_langs 2 // Total number of languages
#define english 0
#define spanish 1


typedef struct {
	int type;
	char * word;
} lang_trans;

// lang_trans * lt = (lang_trans *) malloc (sizeof(lang_trans*) * num_langs);

lang_trans lt [num_langs]= 
	{
		{0, "en"},
		{1, "es"}
	};