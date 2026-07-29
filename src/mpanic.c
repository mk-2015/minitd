#include<stdio.h>
#include<stdlib.h>
#include<minit/api.h>

// Custom minit panic
void mpanic(const char* reason)
{
    fprintf(stderr, "\n[ FATAL ] %s", reason);
    exit(1);
}