#include<minit/api.h>
#include<stdio.h>

extern void _info_early();

void _early_core(const char* params)
{
    // run early-core
    printf("[ INFO ] Running early-core\n");

    _info_early();

    // stop early-core
    printf("[ INFO ] Stopped early-core\n");
    return;
}