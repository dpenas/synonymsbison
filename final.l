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
sense "Sense:"
title "title"
%s _sense
%s _syn
%s _wanted
%%

<_syn>{word} {printf("\n-- Syn: %s\n", yytext); yylval.string = yytext; BEGIN(_wanted); return SYNONYM;}

<_sense>{word} {printf("\n|Sense: %s|\n", yytext); yylval.string = yytext; BEGIN(_wanted); return SENSE;}

<_wanted>{sense}{ci} {BEGIN (_sense);}
<_wanted>{title}{something}">" {BEGIN(_syn);}

{obr}{ospan}{something}">"{word}{cspan} {printf("IntroWordreference\n"); BEGIN(_wanted);}


%%
