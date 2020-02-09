// #include <stdio.h>
// #include <string.h>
// #include <stdlib.h>

// #define PROGRAM_NAME  "strchcount"

// FIXME: on windows platform delim is '\'
// but unix have '/'
// #define SPACE_PATH_DELIMETER  '\\'

// static const char *const basename(const char *path)
// {
//   const char *pos = NULL;
// 	for (; *path != '\0'; path++)
// 		if (*path == SPACE_PATH_DELIMETER) {
// 			pos = path + 2;
//     }
//   if (pos == path)
//     return NULL;
// 	return pos;
// }

// const char *pname = NULL;

// static void usage( )
// {
//   printf("usage: %s -c [char] string1, ...\n", basename(pname));
//   exit(EXIT_FAILURE);
// }

extern void exit (int __status) __attribute__ ((__nothrow__)) __attribute__ ((__noreturn__));

int main( int argc, char *argv[] )
{
  // pname = *argv;
  long long count = 0;
  char occur_char = '\0';

  if (argc == 1)
    exit(0);
  // if (argc < 4)
  //   usage();

  // FIXME: лучше бы сделать в любом месте определение -c аргумента
  argv++;
  **argv != '-' ? exit(0) : (*argv)++;
  **argv != 'c' ? exit(0) : (*argv)++;
  **argv != '\0' ? exit(0) : argv++;

  occur_char = **argv;
  occur_char == '\0' ? exit(0) : (*argv)++;
  **argv != '\0' ? exit(0) : argv++;
 
  for (; *argv != 0; argv++) {
    for ( ; **argv != '\0'; (*argv)++)
      if (**argv == occur_char)
        count++;
  }
  // printf("%08d\n", count);
  return count;
}
