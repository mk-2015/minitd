#include <minit/api.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/stat.h>
#include <unistd.h>

void _info_early()
{
    mkdir("/run/minitd", 0755);
    FILE *f;

    f = fopen("/run/minitd/test.inf", "w");
    fprintf(f, "Test file for minitd\n");
    fclose(f);

    printf("[ OK ] Wrote minitd test file\n");

    f = fopen("/run/minitd/info.inf", "w");
    fprintf(f, "Version of minitd: %s\n", MVER);
    fprintf(f, "PID: %d", getpid());
    fclose(f);

    printf("[ OK ] Wrote minitd info file\n");
}