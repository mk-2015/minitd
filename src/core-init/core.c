#include<minit/api.h>
#include<stdio.h>
#include<unistd.h>
#include<fcntl.h>
#include<dirent.h>
#include<sys/stat.h>

extern void _info_early();
extern void _sign_early();
extern void _setenv_early();
extern void _ensure_early();
extern int _early_core_bookd(const char* params);

extern void _start_service_early();
extern void __main_server(void);

void _early_core(const char* params)
{
    // run early-core
    printf("[ INFO ] Running early-core\n");

    _ensure_early();
    _info_early();
    _sign_early();
    _setenv_early();

    // Not early
    _start_service_early();
    __main_server();

    mkdir("/var", 0755);
    mkdir("/var/log", 0755);
    FILE* log_file = fopen("/var/log/minitd.log", "w");
    fclose(log_file);
    _early_core_bookd("/var/log/minitd.log");

    // stop early-core
    printf("[ INFO ] Stopped early-core\n");
    return;
}