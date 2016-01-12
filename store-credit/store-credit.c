#include "../commons.h"


typedef struct {
	uint16_t credits;
	uint16_t *list;
	uint16_t list_size;
} case_data;


typedef struct {
	uint16_t item1;
	uint16_t item2;
} found_items;


case_data *parse_case(FILE *in) {
	case_data *data = malloc(sizeof(case_data));
	*data = (case_data) {
		.credits = 0,
		.list = NULL,
		.list_size = 0,
	};

	checked_scan(fscanf(in, "%hu\n", &data->credits), != 1)
	checked_scan(fscanf(in, "%hu\n", &data->list_size), != 1)

	data->list = malloc(sizeof(uint16_t) * data->list_size);

	for (int i = 0; i < data->list_size-1; i++) {
		checked_scan(fscanf(in, "%hu ", &data->list[i]), != 1)
	}
	checked_scan(fscanf(in, "%hu\n", &data->list[data->list_size-1]), != 1)

	return data;
}


found_items *find_items(case_data data) {
	found_items *items = malloc(sizeof(found_items));
	for (uint16_t i = 0; i < data.list_size - 1; i++) {
		for (uint16_t j = i+1; j < data.list_size; j++) {
			if (i == j) continue;

			if (data.list[i] + data.list[j] == data.credits) {
				items->item1 = i + 1;
				items->item2 = j + 1;
				return items;
			}
		}
	}
	return NULL;
}


int main(int argc, char const *argv[]) {
	check_argc(argc, 2, "Usage: %s input.txt\n", argv[0])

	open_file(in, argv[1], "r")

	uint8_t cases;
	checked_scan(fscanf(in, "%hhu\n", &cases), != 1)
	for (char case_n = 1; case_n <= cases; case_n++) {
		case_data *data = parse_case(in);
		
		found_items *items = find_items(*data);
		if (!items) {
			printf("Unable to find items!\n");
			fail();
		}
		printf("Case #%d: %hu %hu\n", case_n, items->item1, items->item2);
		
		free(data);
		free(items);
	}
}
