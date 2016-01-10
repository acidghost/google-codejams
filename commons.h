#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <inttypes.h>
#include <stdbool.h>
#include <string.h>
#include <time.h>

#define fail exit(EXIT_FAILURE)

#define checked_scan(scan, should_be)						\
	if (scan != should_be) {								\
		printf("Error during scan.\n");						\
		fail;												\
	}
