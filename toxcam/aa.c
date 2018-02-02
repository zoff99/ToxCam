#if defined(__MINGW32__) || defined(_WIN32) || defined(WIN32)
 #define _IS_PLATFORM_WIN_
#endif

#include <ctype.h>
#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <string.h>
#include <stdarg.h>
#include <time.h>
#include <dirent.h>
#include <math.h>

#include <sys/types.h>
#include <sys/stat.h>
#ifndef _IS_PLATFORM_WIN_
 #include <sys/ioctl.h>
#endif
#include <unistd.h>
#include <getopt.h>
#include <fcntl.h>
#include <assert.h>
#include <errno.h>
#include <pthread.h>
#include <signal.h>

#include <sodium/utils.h>
#include <vpx/vpx_image.h>


#ifdef _IS_PLATFORM_WIN_
void srandom(unsigned int seed)
{
	srand(seed);
}

long int random()
{
	return (long int)rand();
}

void srand48(long int seedval)
{
	srand((unsigned int)seedval);
}

double drand48()
{
	return (double)random();
}
#endif

// ----------- version -----------
// ----------- version -----------
#define VERSION_MAJOR 0
#define VERSION_MINOR 99
#define VERSION_PATCH 14
static const char global_version_string[] = "0.99.14";
// ----------- version -----------
// ----------- version -----------

int main(int argc, char *argv[])
{
  printf("AAA:001\n");

  return 0;
}


