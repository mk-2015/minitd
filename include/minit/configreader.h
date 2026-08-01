#ifndef MINIT_CONFIGREADER_H
#define MINIT_CONFIGREADER_H

#include <stdio.h>
#include <stddef.h>

#define MILANG_MAX_LINE 1024
#define MILANG_MAX_KEY  256
#define MILANG_MAX_VAL  768

typedef struct {
    char *filepath;
    FILE *file;
} MiConfig;

MiConfig *open_config(const char *filepath);
void close_config(MiConfig *cfg);

char *readkey(MiConfig *cfg, const char *key);
int writekey(MiConfig *cfg, const char *key, const char *value);
int deletekey(MiConfig *cfg, const char *key);
unsigned int list_num_of_keys(MiConfig *cfg);
char **list_keys(MiConfig *cfg);

unsigned int list_num_key_in_section(MiConfig *cfg, const char *section);
unsigned int list_num_keys_in_section(MiConfig *cfg, const char *section);
char **list_keys_in_section(MiConfig *cfg, const char *section);
unsigned int list_num_sections(MiConfig *cfg);
char **list_sections(MiConfig *cfg);
void free_key_list(char **keys);

#endif /* MINIT_CONFIGREADER_H */