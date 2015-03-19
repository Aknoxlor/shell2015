%{
void yyerror (char *s);
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
int mainNumber;
%}

%union {char id; char *word;}
%token cd_command
%token bye
%token exit_command
%token <word> letters


%%
command:
| command '\n'
| command change_d
| command home
| command exit
;

change_d:
	cd_command letters	
		{
		printf("%s...\n",$2);
		};
home :	
	cd_command		
		{
		printf("GOING HOME\n");
		chdir(getenv("HOME"));
		
		};
exit:  bye
	{ printf("leaving the shell \n");
	exit(0);	
	};
%%

int main (void)
{
	mainNumber = 0;
	yyparse();
}

void yyerror (char *s) {fprintf (stderr, "%s\n", s);} 



