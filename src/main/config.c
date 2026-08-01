#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>
#include <unistd.h>
#include <minit/configreader.h>
#include <stdbool.h>

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

static bool parse_section_key(const char *key, char **section, char **name) {
    if (!key || !section || !name) return false;

    const char *dot = strchr(key, '.');
    if (!dot) {
        *section = NULL;
        *name = strdup(key);
        return *name != NULL;
    }

    size_t section_len = dot - key;
    *section = calloc(section_len + 1, 1);
    if (!*section) return false;
    memcpy(*section, key, section_len);
    (*section)[section_len] = '\0';
    *name = strdup(dot + 1);
    return *name != NULL;
}

static bool line_is_section(const char *line, char *section, size_t cap) {
    if (!line || line[0] != '[') return false;
    const char *end = strchr(line, ']');
    if (!end) return false;
    size_t len = end - line - 1;
    if (len >= cap) return false;
    memcpy(section, line + 1, len);
    section[len] = '\0';
    return true;
}

static bool section_matches(const char *have, const char *want) {
    if (!want) return (!have || have[0] == '\0');
    if (!have) return false;
    return strcmp(have, want) == 0;
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

    char *section = NULL;
    char *name = NULL;
    if (!parse_section_key(key, &section, &name)) return NULL;

    fseek(cfg->file, 0, SEEK_SET);
    char line[MILANG_MAX_LINE];
    char current_section[MILANG_MAX_KEY] = "";

    while (fgets(line, sizeof(line), cfg->file)) {
        strip_inline_comments(line);
        char *line_ptr = trim_whitespace(line);

        if (line_ptr[0] == '\0') continue;

        char section_name[MILANG_MAX_KEY];
        if (line_is_section(line_ptr, section_name, sizeof(section_name))) {
            snprintf(current_section, sizeof(current_section), "%s", section_name);
            continue;
        }

        if (!section_matches(current_section, section)) continue;

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

        if (strcmp(parsed_key, name) == 0) {
            char *result = strdup(parsed_val);
            free(name);
            if (section) free(section);
            return result;
        }
    }

    if (name) free(name);
    if (section) free(section);
    return NULL;
}

/* Atomic Write/Update Key */
int writekey(MiConfig *cfg, const char *key, const char *value) {
    if (!cfg || !cfg->filepath || !key || !value) return -1;

    char *section = NULL;
    char *name = NULL;
    if (!parse_section_key(key, &section, &name)) return -1;

    char tmp_path[512];
    snprintf(tmp_path, sizeof(tmp_path), "%s.tmp", cfg->filepath);

    FILE *tmp = fopen(tmp_path, "w");
    if (!tmp) {
        free(name);
        if (section) free(section);
        return -1;
    }

    fseek(cfg->file, 0, SEEK_SET);
    char line[MILANG_MAX_LINE];
    bool key_written = false;
    bool section_found = (section == NULL);
    char current_section[MILANG_MAX_KEY] = "";

    while (fgets(line, sizeof(line), cfg->file)) {
        char line_copy[MILANG_MAX_LINE];
        snprintf(line_copy, sizeof(line_copy), "%s", line);

        char *line_ptr = trim_whitespace(line_copy);
        char section_name[MILANG_MAX_KEY] = "";

        if (line_ptr[0] == '[' && line_is_section(line_ptr, section_name, sizeof(section_name))) {
            snprintf(current_section, sizeof(current_section), "%s", section_name);
            if (section_matches(current_section, section)) {
                section_found = true;
            }
            fputs(line, tmp);
            continue;
        }

        if (section_matches(current_section, section)) {
            char *sep = strchr(line_ptr, '=');
            if (sep) {
                *sep = '\0';
                char *parsed_key = trim_whitespace(line_ptr);
                if (strcmp(parsed_key, name) == 0) {
                    fprintf(tmp, "%s = %s\n", name, value);
                    key_written = true;
                    continue;
                }
            }
        }

        fputs(line, tmp);
    }

    if (!key_written) {
        if (section && !section_found) {
            fprintf(tmp, "[%s]\n", section);
        }
        fprintf(tmp, "%s = %s\n", name, value);
    }

    fclose(tmp);
    fclose(cfg->file);
    rename(tmp_path, cfg->filepath);
    cfg->file = fopen(cfg->filepath, "r+");

    free(name);
    if (section) free(section);
    return 0;
}

/* Delete key from configuration */
int deletekey(MiConfig *cfg, const char *key) {
    if (!cfg || !cfg->filepath || !key) return -1;

    char *section = NULL;
    char *name = NULL;
    if (!parse_section_key(key, &section, &name)) return -1;

    char tmp_path[512];
    snprintf(tmp_path, sizeof(tmp_path), "%s.tmp", cfg->filepath);

    FILE *tmp = fopen(tmp_path, "w");
    if (!tmp) {
        free(name);
        if (section) free(section);
        return -1;
    }

    fseek(cfg->file, 0, SEEK_SET);
    char line[MILANG_MAX_LINE];
    char current_section[MILANG_MAX_KEY] = "";

    while (fgets(line, sizeof(line), cfg->file)) {
        char line_copy[MILANG_MAX_LINE];
        snprintf(line_copy, sizeof(line_copy), "%s", line);

        char *line_ptr = trim_whitespace(line_copy);
        char section_name[MILANG_MAX_KEY];

        if (line_ptr[0] == '[' && line_is_section(line_ptr, section_name, sizeof(section_name))) {
            snprintf(current_section, sizeof(current_section), "%s", section_name);
            fputs(line, tmp);
            continue;
        }

        if (!section_matches(current_section, section)) {
            fputs(line, tmp);
            continue;
        }

        if (line_ptr[0] != '#' && line_ptr[0] != '\0') {
            char *sep = strchr(line_ptr, '=');
            if (sep) {
                *sep = '\0';
                char *parsed_key = trim_whitespace(line_ptr);
                if (strcmp(parsed_key, name) == 0) {
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

    free(name);
    if (section) free(section);
    return 0;
}

/* Count total non-comment key entries in the config */
unsigned int list_num_of_keys(MiConfig *cfg) {
    if (!cfg || !cfg->file) return 0;

    fseek(cfg->file, 0, SEEK_SET);
    char line[MILANG_MAX_LINE];
    unsigned int count = 0;

    while (fgets(line, sizeof(line), cfg->file)) {
        strip_inline_comments(line);
        char *line_ptr = trim_whitespace(line);

        if (line_ptr[0] == '\0') continue;
        if (line_ptr[0] == '[') continue;
        if (strchr(line_ptr, '=') != NULL) count++;
    }

    return count;
}

unsigned int list_num_key_in_section(MiConfig *cfg, const char *section) {
    return list_num_keys_in_section(cfg, section);
}

unsigned int list_num_keys_in_section(MiConfig *cfg, const char *section) {
    if (!cfg || !cfg->file || !section) return 0;

    fseek(cfg->file, 0, SEEK_SET);
    char line[MILANG_MAX_LINE];
    unsigned int count = 0;
    char current_section[MILANG_MAX_KEY] = "";

    while (fgets(line, sizeof(line), cfg->file)) {
        strip_inline_comments(line);
        char *line_ptr = trim_whitespace(line);

        if (line_ptr[0] == '\0') continue;

        char section_name[MILANG_MAX_KEY];
        if (line_ptr[0] == '[' && line_is_section(line_ptr, section_name, sizeof(section_name))) {
            snprintf(current_section, sizeof(current_section), "%s", section_name);
            continue;
        }

        if (!section_matches(current_section, section)) continue;
        if (strchr(line_ptr, '=') != NULL) count++;
    }

    return count;
}

char **list_keys_in_section(MiConfig *cfg, const char *section) {
    if (!cfg || !cfg->file || !section) return NULL;

    unsigned int num_keys = list_num_keys_in_section(cfg, section);
    if (num_keys == 0) return NULL;

    char **keys = calloc(num_keys + 1, sizeof(char *));
    if (!keys) return NULL;

    fseek(cfg->file, 0, SEEK_SET);
    char line[MILANG_MAX_LINE];
    unsigned int idx = 0;
    char current_section[MILANG_MAX_KEY] = "";

    while (fgets(line, sizeof(line), cfg->file) && idx < num_keys) {
        strip_inline_comments(line);
        char *line_ptr = trim_whitespace(line);

        if (line_ptr[0] == '\0') continue;

        char section_name[MILANG_MAX_KEY];
        if (line_ptr[0] == '[' && line_is_section(line_ptr, section_name, sizeof(section_name))) {
            snprintf(current_section, sizeof(current_section), "%s", section_name);
            continue;
        }

        if (!section_matches(current_section, section)) continue;

        char *sep = strchr(line_ptr, '=');
        if (sep) {
            *sep = '\0';
            char *parsed_key = trim_whitespace(line_ptr);
            keys[idx++] = strdup(parsed_key);
        }
    }

    keys[idx] = NULL;
    return keys;
}

unsigned int list_num_sections(MiConfig *cfg) {
    if (!cfg || !cfg->file) return 0;

    fseek(cfg->file, 0, SEEK_SET);
    char line[MILANG_MAX_LINE];
    unsigned int count = 0;

    while (fgets(line, sizeof(line), cfg->file)) {
        strip_inline_comments(line);
        char *line_ptr = trim_whitespace(line);

        if (line_ptr[0] == '[') {
            char section_name[MILANG_MAX_KEY];
            if (line_is_section(line_ptr, section_name, sizeof(section_name))) {
                count++;
            }
        }
    }

    return count;
}

char **list_sections(MiConfig *cfg) {
    if (!cfg || !cfg->file) return NULL;

    unsigned int num_sections = list_num_sections(cfg);
    if (num_sections == 0) return NULL;

    char **sections = calloc(num_sections + 1, sizeof(char *));
    if (!sections) return NULL;

    fseek(cfg->file, 0, SEEK_SET);
    char line[MILANG_MAX_LINE];
    unsigned int idx = 0;

    while (fgets(line, sizeof(line), cfg->file) && idx < num_sections) {
        strip_inline_comments(line);
        char *line_ptr = trim_whitespace(line);

        if (line_ptr[0] == '[') {
            char section_name[MILANG_MAX_KEY];
            if (line_is_section(line_ptr, section_name, sizeof(section_name))) {
                sections[idx++] = strdup(section_name);
            }
        }
    }

    sections[idx] = NULL;
    return sections;
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
        if (line_ptr[0] == '[') continue;

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