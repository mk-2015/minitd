#include <errno.h>
#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>
#include <ctype.h>
#include <string.h>

#include <minit/api.h>
#include <minit/configreader.h>

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

void _setenv_all(void)
{
    for (size_t i = 0; i < environ_default_table_size; i++) {
        if (setenv(environ_default_table[i].name, environ_default_table[i].content, 1) != 0) {
            perror("[ FAIL ] Failed to set environment variable.");
        } else {
            printf("[ OK ] Set environment default varible: %s\n", environ_default_table[i].name);
        }
    }

    MiConfig *config = open_config("/etc/minitd/environ");
    if (!config) return;

    char **keys = list_keys(config);
    if (keys) {
        for (size_t i = 0; keys[i] != NULL; i++) {
            char *val = readkey(config, keys[i]);
            if (val) {
                if (setenv(keys[i], val, 1) == 0) {
                    printf("[ OK ] Set environment config variable: %s\n", keys[i]);
                }
                free(val);
            }
        }
        free_key_list(keys);
    }

    close_config(config);
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