#include <errno.h>
#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>
#include <ctype.h>
#include <string.h>

#include <minit/api.h>

#ifndef MAX_CHARS_HOSTNAME
#define MAX_CHARS_HOSTNAME 64
#endif

#define MAX_ENV_LINE_BUF (MAX_CHARS_ENVNAME + 1 + MAX_CHARS_ENVCONTENT + 2)

const EnvironVar environ_default_table[] = {
    { .name = "TERM",  .content = "linux" },
    { .name = "INIT",  .content = "minitd"},
    { .name = "MRUN",  .content = "/run/minitd" }
};

const size_t environ_default_table_size = sizeof(environ_default_table) / sizeof(environ_default_table[0]);

static char *trim_whitespace(char *str) {
    char *end;
    while (isspace((unsigned char)*str)) str++;
    if (*str == 0) return str;
    end = str + strlen(str) - 1;
    while (end > str && isspace((unsigned char)*end)) end--;
    end[1] = '\0';
    return str;
}

void _setenv_all(void)
{
    for (size_t i = 0; i < environ_default_table_size; i++) {
        if (setenv(environ_default_table[i].name, environ_default_table[i].content, 1) != 0) {
            perror("[ FAIL ] Failed to set environment variable.");
        } else {
            printf("[ OK ] Set environment default varible: %s\n", environ_default_table[i].name);
        }
    }

    FILE *fp = fopen("/etc/minitd/environ", "r");
    if (!fp) {
        printf("[ INFO ] /etc/minitd/environ not found, keeping defaults.\n");
        return;
    }

    char line[MAX_ENV_LINE_BUF];
    char key[MAX_CHARS_ENVNAME + 1];
    char val[MAX_CHARS_ENVCONTENT + 1];

    while (fgets(line, sizeof(line), fp)) {
        char *trimmed = trim_whitespace(line);

        if (trimmed[0] == '\0' || trimmed[0] == '#') {
            continue;
        }
        char *eq = strchr(trimmed, '=');
        if (!eq) continue;

        *eq = '\0';
        char *raw_key = trim_whitespace(trimmed);
        char *raw_val = trim_whitespace(eq + 1);

        snprintf(key, sizeof(key), "%s", raw_key);
        snprintf(val, sizeof(val), "%s", raw_val);

        if (key[0] != '\0') {
            setenv(key, val, 1);
            printf("[ OK ] Set environment config varible: %s\n", key);
        }
    }

    fclose(fp);
}

void _setenv_early(void)
{
    char ihostname[MAX_CHARS_HOSTNAME + 1];
    memset(ihostname, 0, sizeof(ihostname));

    FILE *hostfile = fopen("/etc/hostname", "r");
    if (hostfile != NULL) {
        if (fgets(ihostname, sizeof(ihostname), hostfile) != NULL) {
            ihostname[strcspn(ihostname, "\r\n")] = '\0';
        }
        fclose(hostfile);
    }

    if (ihostname[0] == '\0') {
        strncpy(ihostname, "minit", sizeof(ihostname) - 1);
    }

    if (sethostname(ihostname, strlen(ihostname)) == -1) {
        perror("[ INIT ] sethostname failed");
        return;
    }

    printf("[ OK ] Hostname set to: %s\n", ihostname);
    _setenv_all();
}