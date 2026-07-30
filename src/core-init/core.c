#include<minit/api.h>
#include<stdio.h>

extern void _info_early();
extern void _sign_early();
extern void _setenv_early();
extern void _ensure_early();

void _early_core(const char* params)
{
    // run early-core
    printf("[ INFO ] Running early-core\n");

    _ensure_early();
    _info_early();
    _sign_early();
    _setenv_early();

    // stop early-core
    printf("[ INFO ] Stopped early-core\n");
    return;
}