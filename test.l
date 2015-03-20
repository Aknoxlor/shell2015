%{
#include "y.tab.h"
%}

%%
"CD"		{return cd_command;}
"BYE"		{return exit_command;}
[a-zA-z]+	{yylval.word = strdup(yytext); return text;}
[/&<>]		{return yytext[0];}
[ \t]		{;}
"\n"		{return execute;}
.		{ECHO; yyerror("unexpected character");}
%%
int yywrap(void) {return 1;}
