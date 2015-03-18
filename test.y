%{
void yyerror (char *s);
#include <stdio.h>
#include <stdlib.h>
int mainNumber;
%}

%union {char id; char *word;}
%start line
%token cd_command
%token ls_command
%token exit_command
%token <word> letters
%type <id> line
%type <id> action

%%

line :  action '\n'	{;}
     |	exit_command '\n'	{exit(0);}
     |	line action '\n'	{;}
     |	line exit_command '\n'	{exit(0);}
     ;
action:	cd_command letters	{printf("%s",$2);}
    |	cd_command		{;}
    |	ls_command		{;}
    ;
%%

int main (void)
{
	mainNumber = 0;
	yyparse();
}

void yyerror (char *s) {fprintf (stderr, "%s\n", s);} 




