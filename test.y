%{
void yyerror (char *s);
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/file.h>
#include <string.h>
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
|	letters
		{
		char command[] = "/usr/bin/";
		printf("Searching bin for %s... \n",$1);
		strcat(command,$1);
		if(access (command, F_OK) == -1)
			printf("Command not found\n");
		else
			printf("%s found\n", $1);
			execl (command, command, (char *) NULL);
		};
;
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
	yyparse();
}

void yyerror (char *s) {fprintf (stderr, "%s\n", s);} 



