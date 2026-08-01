#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>
#include <unistd.h>
#include <minit/configreader.h>

static void strip_inline_comments(char *str) {
    int in_quotes = 0;
    
    for (char *p = str; *p != '\0'; p++) {
        if (*p == '"') {
            in_quotes = !in_quotes;
        } else if (*p == '#' && !in_quotes) {
            *p = '\0';
            break;
        }
    }
}

static char *trim_whitespace(char *str) {
    char *end;
    while (isspace((unsigned char)*str)) str++;
    if (*str == 0) return str;

    end = str + strlen(str) - 1;
    while (end > str && isspace((unsigned char)*end)) end--;
    end[1] = '\0';

    return str;
}

MiConfig *open_config(const char *filepath) {
    if (!filepath) return NULL;

    FILE *f = fopen(filepath, "r+");
    if (!f) {
        f = fopen(filepath, "w+");
        if (!f) {
            return NULL;
        }
    }

    MiConfig *cfg = calloc(1, sizeof(MiConfig));
    if (!cfg) {
        fclose(f);
        return NULL;
    }

    cfg->filepath = strdup(filepath);
    cfg->file = f;
    return cfg;
}

void close_config(MiConfig *cfg) {
    if (!cfg) return;
    if (cfg->file) fclose(cfg->file);
    if (cfg->filepath) free(cfg->filepath);
    free(cfg);
}

char *readkey(MiConfig *cfg, const char *key) {
    if (!cfg || !cfg->file || !key) return NULL;

    fseek(cfg->file, 0, SEEK_SET);
    char line[MILANG_MAX_LINE];

    while (fgets(line, sizeof(line), cfg->file)) {
        strip_inline_comments(line);

        char *line_ptr = trim_whitespace(line);

        if (line_ptr[0] == '\0') continue;

        char *sep = strchr(line_ptr, '=');
        if (!sep) continue;

        *sep = '\0';
        char *parsed_key = trim_whitespace(line_ptr);
        char *parsed_val = trim_whitespace(sep + 1);

        size_t vlen = strlen(parsed_val);
        if (vlen >= 2 && parsed_val[0] == '"' && parsed_val[vlen - 1] == '"') {
            parsed_val[vlen - 1] = '\0';
            parsed_val++;
        }

        if (strcmp(parsed_key, key) == 0) {
            return strdup(parsed_val);
        }
    }

    return NULL;
}

/* Atomic Write/Update Key */
int writekey(MiConfig *cfg, const char *key, const char *value) {
    if (!cfg || !cfg->filepath || !key || !value) return -1;

    char tmp_path[512];
    snprintf(tmp_path, sizeof(tmp_path), "%s.tmp", cfg->filepath);

    FILE *tmp = fopen(tmp_path, "w");
    if (!tmp) return -1;

    fseek(cfg->file, 0, SEEK_SET);
    char line[MILANG_MAX_LINE];
    int key_found = 0;

    while (fgets(line, sizeof(line), cfg->file)) {
        char line_copy[MILANG_MAX_LINE];
        strncpy(line_copy, line, sizeof(line_copy));

        char *line_ptr = trim_whitespace(line_copy);

        if (line_ptr[0] != '#' && line_ptr[0] != '\0') {
            char *sep = strchr(line_ptr, '=');
            if (sep) {
                *sep = '\0';
                char *parsed_key = trim_whitespace(line_ptr);
                if (strcmp(parsed_key, key) == 0) {
                    fprintf(tmp, "%s = %s\n", key, value);
                    key_found = 1;
                    continue;
                }
            }
        }
        fputs(line, tmp);
    }

    if (!key_found) {
        fprintf(tmp, "%s = %s\n", key, value);
    }

    fclose(tmp);
    fclose(cfg->file);

    rename(tmp_path, cfg->filepath);

    cfg->file = fopen(cfg->filepath, "r+");
    return 0;
}

/* Delete key from configuration */
int deletekey(MiConfig *cfg, const char *key) {
    if (!cfg || !cfg->filepath || !key) return -1;

    char tmp_path[512];
    snprintf(tmp_path, sizeof(tmp_path), "%s.tmp", cfg->filepath);

    FILE *tmp = fopen(tmp_path, "w");
    if (!tmp) return -1;

    fseek(cfg->file, 0, SEEK_SET);
    char line[MILANG_MAX_LINE];

    while (fgets(line, sizeof(line), cfg->file)) {
        char line_copy[MILANG_MAX_LINE];
        strncpy(line_copy, line, sizeof(line_copy));

        char *line_ptr = trim_whitespace(line_copy);

        if (line_ptr[0] != '#' && line_ptr[0] != '\0') {
            char *sep = strchr(line_ptr, '=');
            if (sep) {
                *sep = '\0';
                char *parsed_key = trim_whitespace(line_ptr);
                if (strcmp(parsed_key, key) == 0) {
                    continue;
                }
            }
        }
        fputs(line, tmp);
    }

    fclose(tmp);
    fclose(cfg->file);

    rename(tmp_path, cfg->filepath);
    cfg->file = fopen(cfg->filepath, "r+");
    return 0;
}

/* Count total non-comment key entries in the config */
unsigned int list_num_of_keys(MiConfig *cfg) {
    if (!cfg || !cfg->file) return 0;

    fseek(cfg->file, 0, SEEK_SET);
    char line[MILANG_MAX_LINE];
    unsigned int count = 0;

    while (fgets(line, sizeof(line), cfg->file)) {
        /* Strip inline comments first */
        strip_inline_comments(line);
        char *line_ptr = trim_whitespace(line);

        /* Ignore empty or pure comment lines */
        if (line_ptr[0] == '\0') continue;

        /* Look for valid key = value separator */
        if (strchr(line_ptr, '=') != NULL) {
            count++;
        }
    }

    return count;
}

/* Return NULL-terminated array of dynamically allocated key strings */
char **list_keys(MiConfig *cfg) {
    if (!cfg || !cfg->file) return NULL;

    unsigned int num_keys = list_num_of_keys(cfg);
    if (num_keys == 0) return NULL;

    char **keys = calloc(num_keys + 1, sizeof(char *));
    if (!keys) return NULL;

    fseek(cfg->file, 0, SEEK_SET);
    char line[MILANG_MAX_LINE];
    unsigned int idx = 0;

    while (fgets(line, sizeof(line), cfg->file) && idx < num_keys) {
        strip_inline_comments(line);
        char *line_ptr = trim_whitespace(line);

        if (line_ptr[0] == '\0') continue;

        char *sep = strchr(line_ptr, '=');
        if (sep) {
            *sep = '\0';
            char *parsed_key = trim_whitespace(line_ptr);
            keys[idx] = strdup(parsed_key);
            idx++;
        }
    }

    keys[idx] = NULL;
    return keys;
}

void free_key_list(char **keys) {
    if (!keys) return;
    for (size_t i = 0; keys[i] != NULL; i++) {
        free(keys[i]);
    }
    free(keys);
}