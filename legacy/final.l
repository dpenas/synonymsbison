%{
#include "y.tab.h"
#include <stdio.h>
#include <stdlib.h>
%}

something [^\n\t>]+
obr "<br>"
cbr "</br>"
ou "<u>"
odiv "<div "
cdiv "</div>"
oul "<ul>"
cul "</ul>"
cu "</u>"
ob "<b>"
ob1 "<b "
cb "</b>"
oa "<a "
ca "</a>"
oli "<li "
oi "<i>"
ci "</i>"
cli "</li>"
ospan "<span "
cspan "</span>"
word [^\n\t<>]+


%s wordsense
%s sense
%%
<wordsense>{word}{cb}{oul} {printf("WORDSENSETHATMATTERS\n"); yylval.string = yytext; return WORDSENSE;}
<sense>{word}{ci} {printf("WordSense\n"); BEGIN(wordsense); yylval.string = yytext; return SENSE;}

{odiv}{something}">"{oul}{oli}{something}">"{ob1}{something}">"{oa}{something}">"{ca}{oi} {yylval.string = yytext; printf("SENSE\n"); BEGIN(sense); return SENSE;}
{cul}{obr}{cli}{oli}{something}">"{ob1}{something}">"{oa}{something}">"{ca}{oi} {printf("SENSE\n"); BEGIN(sense); yylval.string = yytext; return SENSE;}
{obr}{ou}{ob}{word}{cb}{cu} {printf("Palabra principal\n");yylval.string = yytext; return PRINCIPAL;}
{obr}{ospan}{something}">"{word}{cspan} {printf("IntroWordreference\n");yylval.string = yytext; return INTRO;}
{oli}{something}">"{ospan}{something}">"{word}{cspan}{cli} {printf("Sinónimo\n"); yylval.string = yytext; return SYNONYM;}

%%
