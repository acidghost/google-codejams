#include "../commons.h"

#define MAX_BUFFER 1024
#define MAX_LIST 1000

typedef struct {
	uint16_t size;
	char **list;
} case_data;


case_data *parse_case(FILE *in) {
	case_data *data = malloc(sizeof(case_data));
	*data = (case_data) {
		.list = NULL,
		.size = 0,
	};

	char *line = malloc(MAX_LIST * MAX_BUFFER * sizeof(char));
	checked_scan(fscanf(in, "%s\n", line), 1)
	// line[strlen(line)] = '\0';
	
	data->list = malloc(MAX_LIST * sizeof(char *));
	uint16_t i = 0, j = 0;
	for (char *c = line; *c != '\0'; c++) {
		printf("c %c\n", *c);
		printf("ij %hu %hu\n", i, j);
		if (*c == ' ') {
			puts("New string");
			data->list[i++] = malloc(MAX_BUFFER * sizeof(char));
			j = 0;
		} else {
			data->list[i][j] = *c;
			j++;
		}
	}

	free(line);

	return data;
}


int main(int argc, char **argv) {
	check_argc(argc, 2, "Usage: %s input.txt\n", argv[0])

	open_file(in, argv[1], "r")

	uint8_t cases;
	checked_scan(fscanf(in, "%hhu\n", &cases), 1)
	for (char case_n = 1; case_n <= cases; case_n++) {
		case_data *data = parse_case(in);
		
		printf("Case #%d: %hu %s\n", case_n, data->size, data->list[0]);
		
		free(data);
	}
}
