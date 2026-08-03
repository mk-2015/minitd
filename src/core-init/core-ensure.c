#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/stat.h>
#include <errno.h>

#include <minit/api.h>
#include <minit/configreader.h>

/*
 * Initialize /etc/minitd with example environment, services and targets.
 * Generated files should avoid embedded comments so they are easier to parse.
 */
void __etc_init(void)
{
    FILE *fp = fopen("/etc/minitd/environ", "w");
    if (fp != NULL) {
        fprintf(fp, "MYENV=MYENV\n");
        fclose(fp);
    } else {
        perror("[ FAIL ] Could not open /etc/minitd/environ");
    }

    fp = fopen("/etc/osconf", "w");
    if (fp != NULL) {
        fprintf(fp, "NAME=MinitdOS\n");
        fprintf(fp, "VERSION=1.0.0\n");
        fprintf(fp, "asciilogo=/etc/logo.txt\n");
        fclose(fp);
    } else {
        perror("[ FAIL ] Could not open /etc/osconf");
    }

    mkdir("/etc/minitd/services", 0755);
    mkdir("/etc/minitd/targetfiles", 0755);
    fp = fopen("/etc/minitd/services/example.svc", "w");
    if (fp != NULL) {
        fprintf(fp, "IGNORE=1\n");
        fprintf(fp, "RunOnTarget=graphical.target\n");
        fprintf(fp, "StateTarget=graphical-multiuser.target\n");
        fprintf(fp, "Exec=/libexec/example/example\n");
        fprintf(fp, "Policy=always\n");
        fprintf(fp, "Name=ExampleService\n");
        fprintf(fp, "Priority=1\n\n");
        fclose(fp);
    } else {
        perror("[ FAIL ] Could not open /etc/minitd/services");
    }

    fp = fopen("/etc/minitd/targetfiles/basic.target", "w");
    if (fp != NULL) {
        fprintf(fp, "Name=BasicTarget\n");
        fprintf(fp, "Level=1\n");
        fprintf(fp, "Next=service.target\n");
        fclose(fp);
    } else {
        perror("[ FAIL ] Could not open /etc/minitd/targetfiles");
    }

    fp = fopen("/etc/minitd/targetfiles/service.target", "w");
    if (fp != NULL) {
        fprintf(fp, "Name=ServiceTarget\n");
        fprintf(fp, "Level=2\n");
        fprintf(fp, "Next=\n");
        fclose(fp);
    } else {
        perror("[ FAIL ] Could not open /etc/minitd/targetfiles");
    }

    fp = fopen("/etc/minitd/targetfiles/maxtarg.conf", "w");
    if (fp != NULL) {
        fprintf(fp, "LEVEL=2\n");
        fprintf(fp, "OptFile=service.target\n");
        fprintf(fp, "IGNORE=0\n");
        fclose(fp);
    } else {
        perror("[ FAIL ] Could not open /etc/minitd/targetfiles/maxtarg.conf");
    }

    fp = fopen("/etc/minitd/startexec.conf", "w");
    if (fp != NULL) {
        fprintf(fp, "[Shell]\n");
        fprintf(fp, "Exec=/bin/sh\n");
        fprintf(fp, "Policy=always\n");
        fprintf(fp, "Name=Shell\n");
        fclose(fp);
    } else {
        perror("[ FAIL ] Could not open /etc/minitd/startexec.conf");
    }

    fp = fopen("/etc/minitd/jobfile.conf", "w");
    if (fp != NULL) {
        fprintf(fp, "# Example Job Definition for minitd\n");
        fprintf(fp, "# [MountRun]\n");
        fprintf(fp, "# Name=MountRunLoop\n");
        fprintf(fp, "# Type=start\n");
        fprintf(fp, "# Target=basic.target\n");
        fprintf(fp, "# Level=1\n");
        fprintf(fp, "# Exec=/bin/sh -c \"mount /run/loop /\"\n");
        fclose(fp);
        printf("[ OK ] Created default template at /etc/minitd/jobfile.conf\n");
    } else {
        perror("[ FAIL ] Could not create /etc/minitd/jobfile.conf");
    }
}

/*
 * Ensure the configuration directory `/etc/minitd` exists. If the directory
 * is newly created, perform first-time initialization.
 */
void _ensure_early(void)
{
    if (mkdir("/etc/minitd", 0755) == 0) {
        printf("[ OK ] Created /etc/minitd. Running first-time setup...\n");
        __etc_init();
    } else if (errno == EEXIST) {
        // skip
    } else {
        perror("[ FAIL ] Failed to create /etc/minitd");
        mpanic("Cannot create /etc/minitd");
    }

    MiConfig *cfg = open_config("/etc/osconf");
    if (cfg) {
        char *name = readkey(cfg, "NAME");
        char *version = readkey(cfg, "VERSION");
        if (name && version) {
            printf("\nWelcome to %s %s!\n\n", name, version);
        }
        if (name) free(name);
        if (version) free(version);
        
        char *asciipath = readkey(cfg, "asciilogo");
        if (asciipath) {
            FILE *fp = fopen(asciipath, "r");
            if (fp) {
                char line[256];
                while (fgets(line, sizeof(line), fp)) {
                    printf("%s", line);
                }
                fclose(fp);
            }
            free(asciipath);
        }
        close_config(cfg);
    }
}