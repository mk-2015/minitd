#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/stat.h>

#include <minit/api.h>
#include <minit/process.h>
#include <libubookd/booker.h>

Book* g_Book = NULL;

int _early_core_bookd(const char* params) {
    if (!params) return -1;

    g_Book = (Book*)malloc(sizeof(Book));
    if (!g_Book) return -1;

    int ret = OpenBook((char*)params, BOOK_FILE_PERM, g_Book);
    if (ret != 0) {
        free(g_Book);
        g_Book = NULL;
        return -1;
    }

    printf("[ INFO ] Early-core bookd started with log file\n");

    return 0;
}