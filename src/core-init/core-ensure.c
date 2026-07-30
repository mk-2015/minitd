#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/stat.h>
#include <errno.h>

#include <minit/api.h>

void __etc_init(void)
{
    FILE *fp = fopen("/etc/minitd/environ", "w");
    if (fp != NULL) {
        fprintf(fp, "# init environ file\n");
        fprintf(fp, "# MYENV=MYENV\n");
        fclose(fp);
    } else {
        perror("[ FAIL ] Could not open /etc/minitd/environ");
    }
}

void _ensure_early(void)
{
    if (mkdir("/etc/minitd", 0755) == 0) {
        printf("[ OK ] Created /etc/minitd. Running first-time setup...\n");
        __etc_init();
    } else if (errno == EEXIST) {
        printf("[ INFO ] /etc/minitd already exists, skipping.\n");
    } else {
        perror("[ FAIL ] Failed to create /etc/minitd");
        mpanic("Cannot create /etc/minitd");
    }
}