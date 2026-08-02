#ifndef __UBOOKER_H__
#define __UBOOKER_H__

#include <stdio.h>

typedef enum {
    BOOK_FILE_TEMP,
    BOOK_FILE_PERM
} BookState;

typedef enum {
    LOG_LEVEL_DEBUG,
    LOG_LEVEL_INFO,
    LOG_LEVEL_WARNING,
    LOG_LEVEL_ERROR,
    LOG_LEVEL_CRITICAL
} LogLevel;

typedef struct {
    FILE* fp;
    char* path; // mallocate the strings
    size_t path_len;
    int inited;
    BookState state;
} Book;

int OpenBook(char* path, BookState state, Book* book);
int BookWriteLog(Book* book, const char* format, LogLevel level, ...);
int BookReadLineRange(unsigned int start_line, unsigned int end_line, Book* book, char* buffer, size_t buffer_size);
int BookReadLog(unsigned int line_number, Book* book, char* buffer, size_t buffer_size);
int BookReadLastLog(Book* book, char* buffer, size_t buffer_size);
int BookChangePath(Book* book, const char* new_path);
int CloseBook(Book* book);

#endif