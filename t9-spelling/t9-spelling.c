#include "../commons.h"

#define MAX_MSG 1024


char *do_letter(char c, char prev) {
	char *str = NULL;
	switch (c) {
		case 'a': str = "2"; break;
		case 'b': str = "22"; break;
		case 'c': str = "222"; break;
		case 'd': str = "3"; break;
		case 'e': str = "33"; break;
		case 'f': str = "333"; break;
		case 'g': str = "4"; break;
		case 'h': str = "44"; break;
		case 'i': str = "444"; break;
		case 'j': str = "5"; break;
		case 'k': str = "55"; break;
		case 'l': str = "555"; break;
		case 'm': str = "6"; break;
		case 'n': str = "66"; break;
		case 'o': str = "666"; break;
		case 'p': str = "7"; break;
		case 'q': str = "77"; break;
		case 'r': str = "777"; break;
		case 's': str = "7777"; break;
		case 't': str = "8"; break;
		case 'u': str = "88"; break;
		case 'v': str = "888"; break;
		case 'w': str = "9"; break;
		case 'x': str = "99"; break;
		case 'y': str = "999"; break;
		case 'z': str = "9999"; break;
		case ' ': str = "0"; break;
		default:
			printf("Unrecognized char %c\n", c);
			fail();
	}

	if (prev && prev == str[0]) {
		size_t len = strlen(str);
		char *new_str = malloc(len + 1);
		new_str[0] = ' ';
		for (size_t i = 0; i < len+1; i++) {
			new_str[i+1] = str[i];
		}
		return new_str;
	}

	return str;
}


char *do_case(FILE *in) {
	char *line = malloc(MAX_MSG * sizeof(char));
	size_t line_size = 0;
	checked_scan(getline(&line, &line_size, in), == -1);

	char *t9_final = malloc(MAX_MSG * 5 * sizeof(char));
	uint16_t i = 0;
	char prev = NULL;
	for (size_t j = 0; line[j] != '\n'; j++) {
		char *t9 = do_letter(line[j], prev);
		size_t len = strlen(t9);
		prev = t9[len-1];
		strncpy(&t9_final[i], t9, len);
		i += len;
	}

	free(line);

	t9_final[i] = '\0';
	return t9_final;
}


int main(int argc, char **argv) {
	check_argc(argc, 2, "Usage: %s input.txt\n", argv[0])

	open_file(in, argv[1], "r")

	char *line = malloc(MAX_MSG * sizeof(char));
	size_t line_size = 0;
	checked_scan(getline(&line, &line_size, in), == -1);
	uint8_t cases = atoi(line);
	free(line);

	for (char case_n = 1; case_n <= cases; case_n++) {
		char *msg = do_case(in);

		printf("Case #%d: %s\n", case_n, msg);
		
		free(msg);
	}
}
