%{
#include <stdio.h>
#include <stdlib.h>
#include "y.tab.h"
%}

something [^\n\t>]+
word [^\n\t<>]+
thesaurus "WordReference English Thesaurus"
ci "</i> "
sense "Sense:"
title "title"

class_FRW2 "class='FrW2'>"
class_FrCN2 "class='FrCN2'>"
class_Fr2 " <i class='Fr2'>"
class_To2 " <i class='To2' >"
class_ToWrd "class='ToWrd' >"
trans "Principal Translations"
compForms "title='Compound Forms'"

%s _sense
%s _syn
%s _wanted
%s _toTranslate
%s _tWord
%s _tSense
%s _tSyn

%%

<_syn>{word} {printf("\n-- Syn: %s\n", yytext); yylval.string = yytext; BEGIN(_wanted); return SYNONYM;}

<_sense>{word} {printf("\n|Sense: %s|\n", yytext); yylval.string = yytext; BEGIN(_wanted); return SENSE;}

<_wanted>{sense}{ci} {BEGIN (_sense);}
<_wanted>{title}{something}">" {BEGIN(_syn);}

{thesaurus} {printf("** IntroWordreference\n"); BEGIN(_wanted);}






<_tSyn>{word} {printf("\n------- tSyn: %s\n", yytext); BEGIN(_toTranslate); yylval.string = yytext; return TRANS;}

<_tSense>{class_Fr2} {printf("\n------- Sense raro Fr2\n"); BEGIN(_tSense);}
<_tSense>{class_To2} {printf("\n------- Sense raro To2\n"); BEGIN(_tSense);}
<_tSense>{word} {printf("\n------- tSense: %s\n", yytext); BEGIN(_toTranslate); yylval.string = yytext; return TSENSE;}

<_tWord>{word} {printf("\n------- tWord: %s\n",yytext); BEGIN(_toTranslate);yylval.string = yytext; return TOTRANS;}

<_toTranslate>{class_ToWrd} {BEGIN(_tSyn);}
<_toTranslate>{compForms} {printf("\n------- Compound Forms\n"); BEGIN(_toTranslate);}
<_toTranslate>{class_FRW2} {BEGIN(_tWord);}
<_toTranslate>{class_FrCN2} {BEGIN(_tSense);}

{trans} {printf("\n~~ Principal Translations ~\n"); BEGIN(_toTranslate);}

%%
