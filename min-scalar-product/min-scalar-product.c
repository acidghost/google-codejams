#include "../commons.h"


int cmpfunc (const void * a, const void * b) {
   return *(int*)a - *(int*)b;
}


int64_t *parse_vector(FILE *in, uint16_t n) {
	int64_t *v = malloc(sizeof(int64_t) * n);
	int i;
	for (i = 0; i < n; i++) {
		checked_scan(fscanf(in, i == n-1 ? "%lli\n" : "%lli ", (long long*) &v[i]), != 1);
	}
	return v;
} 


int64_t do_case(FILE *in) {
	char *line = NULL;
	size_t line_size = 0;
	checked_scan(getline(&line, &line_size, in), == -1);
	uint16_t n = atoi(line);

	int64_t *v1 = parse_vector(in, n);
	qsort(v1, n, sizeof(int64_t), cmpfunc);
	int64_t *v2 = parse_vector(in, n);
	qsort(v2, n, sizeof(int64_t), cmpfunc);
	int64_t p = 0;
	for (int i = 0; i < n; i++) {
		p += v1[i] * v2[n-i-1];
	}

	free(v1); free(v2);
	return p;
}


int main(int argc, char **argv) {
	check_argc(argc, 2, "Usage: %s input.txt\n", argv[0])

	open_file(in, argv[1], "r")

	char *line = NULL;
	size_t line_size = 0;
	checked_scan(getline(&line, &line_size, in), == -1);
	uint16_t cases = atoi(line);
	free(line);

	for (uint16_t case_n = 1; case_n <= cases; case_n++) {
		int64_t min = do_case(in);
		printf("Case #%d: %lli\n", case_n, (long long) min);
	}
}
