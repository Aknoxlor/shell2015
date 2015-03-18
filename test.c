#include <fcntl.h>         /* defines options flags */
#include <sys/types.h>     /* defines types used by sys/stat.h */
#include <sys/stat.h>      /* defines S_IREAD & S_IWRITE  */
#include <stdio.h>
int main (void) 
{

	printf("%i\n", chdir("new_folder"));
	execlp("ls", "ls", "-l",(char *) NULL );
}
