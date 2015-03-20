%{
void yyerror (char *s);
void sysCall(char *command, char *arg);
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/file.h>
#include <string.h>
%}

%union {int num; char *word;}
%start start
%token execute
%token exit_command
%token cd_command
%token <word> text
%type <word> syscall

%%
start:	execute			{;}
|	cd_command execute	{;}
|	exit_command execute	{printf("leaving the shell \n"); exit(0);}
|	syscall execute		{;} //syscall
|	start execute
|	start cd_command execute	{;}
|	start exit_command execute	{printf("leaving the shell \n"); exit(0);}
|	start syscall execute		{;} //syscall
;

//cd_command: {printf("PANIC\n");}
//;

syscall: text		{sysCall($$, NULL);} //syscall
|	text text	{sysCall($$, $1);} //syscall + arguments
;

%%

int main (void)
{
	yyparse();
}

void yyerror (char *s) {fprintf (stderr, "%s\n", s);} 

void sysCall(char *command, char *arg)
{
	char strcatIntensifies[] = "/";
	strcat(strcatIntensifies, command);
	command = strcatIntensifies;

	printf("Searching for %s... \n",command);

	char * parse;
	parse = strtok(getenv("PATH"),":");
	char fullCommand[20];
	while(parse != NULL)
	{
		printf("Searching %s \n",parse);
		strcpy(fullCommand,parse);
		strcat(fullCommand,command);
		printf("DEBUG: %s\n",fullCommand);
		if(access(fullCommand, F_OK) != -1)
		{
			printf("%s found\n", command);
			execl (fullCommand, fullCommand, (char *) NULL);
			return;
		}
		parse = strtok(NULL,":");
	}
	printf("Command not found\n");
}



