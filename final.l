%{
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


%%
{odiv}{something}">"{oul}{oli}{something}">"{ob1}{something}">"{oa}{something}">"{ca}{oi}{word}{ci}{word}{cb}{oul} {printf("SENSE\n");}
{cul}{obr}{cli}{oli}{something}">"{ob1}{something}">"{oa}{something}">"{ca}{oi}{word}{ci}{word}{cb}{oul} {printf("SENSE\n");}
{obr}{ou}{ob}{word}{cb}{cu} {printf("Palabra principal\n");}
{obr}{ospan}{something}">"{word}{cspan} {printf("IntroWordreference\n");}
{oli}{something}">"{ospan}{something}">"{word}{cspan}{cli} {printf("Sinónimo\n");}

%%
