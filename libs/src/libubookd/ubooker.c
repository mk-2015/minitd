#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <stdarg.h>

#include <libubookd/booker.h>

/* Open Book file */
int OpenBook(char* path, BookState state, Book* book) {
    if (!book || !path) {
        return -1;
    }

    book->path_len = strlen(path);
    book->path = (char*)malloc(book->path_len + 1);
    if (!book->path) {
        return -1;
    }
    strcpy(book->path, path);

    book->state = state;  /* Initialize state field */
    const char* mode = (state == BOOK_FILE_TEMP) ? "w+" : "r+";
    book->fp = fopen(path, mode);
    if (!book->fp) {
        free(book->path);
        return -1;
    }

    book->inited = 1;
    return 0;
}

/* Write a log entry to the Book file */
int BookWriteLog(Book* book, const char* format, LogLevel level, ...) {
    if (!book || !book->inited || !format) {
        return -1;
    }

    fseek(book->fp, 0, SEEK_END);
    char logvl[64];
    if (level == LOG_LEVEL_INFO) {
        strcpy(logvl, "[INFO] ");
    } else if (level == LOG_LEVEL_DEBUG) {
        strcpy(logvl, "[DEBUG] ");
    } else if (level == LOG_LEVEL_WARNING) {
        strcpy(logvl, "[WARN] ");
    } else if (level == LOG_LEVEL_ERROR) {
        strcpy(logvl, "[ERROR] ");
    } else if (level == LOG_LEVEL_CRITICAL) {
        strcpy(logvl, "[CRITICAL] ");
    } else {
        strcpy(logvl, "[UNKNOWN] ");
    }
    
    /* Format the log message with variadic arguments */
    char formatted[4096];
    va_list args;
    va_start(args, level);
    int n = vsnprintf(formatted, sizeof(formatted), format, args);
    va_end(args);
    
    if (n < 0 || n >= (int)sizeof(formatted)) {
        return -1;
    }
    
    size_t bytes_written = fprintf(book->fp, "%s%s", logvl, formatted);
    if (bytes_written != strlen(logvl) + strlen(formatted)) {
        return -1;
    }

    fflush(book->fp);
    return 0;
}

/* Read a range of lines from the Book file */
int BookReadLineRange(unsigned int start_line, unsigned int end_line, Book* book, char* buffer, size_t buffer_size) {
    if (!book || !book->inited || !buffer || buffer_size == 0 || start_line > end_line) {
        return -1;
    }

    fseek(book->fp, 0, SEEK_SET);
    unsigned int current_line = 0;
    size_t total_bytes_read = 0;
    char temp_buffer[4096];  /* Temporary buffer for skipped lines */

    /* Skip lines before start_line */
    while (current_line < start_line) {
        if (fgets(temp_buffer, sizeof(temp_buffer), book->fp) == NULL) {
            return -1;
        }
        current_line++;
    }

    /* Read lines from start_line to end_line */
    while (current_line <= end_line) {
        if (total_bytes_read >= buffer_size) {
            return -1;  /* Buffer overflow prevention */
        }
        if (fgets(buffer + total_bytes_read, buffer_size - total_bytes_read, book->fp) == NULL) {
            return -1;
        }
        size_t line_len = strlen(buffer + total_bytes_read);
        if (total_bytes_read + line_len >= buffer_size) {
            return -1;  /* Buffer would overflow */
        }
        total_bytes_read += line_len;
        current_line++;
    }

    return 0;
}

/* Read log from Book file */
int BookReadLog(unsigned int line_number, Book* book, char* buffer, size_t buffer_size) {
    if (!book || !book->inited || !buffer || buffer_size == 0) {
        return -1;
    }

    fseek(book->fp, 0, SEEK_SET);
    unsigned int current_line = 0;
    char temp_buffer[4096];  /* Temporary buffer for lines to skip */

    /* Skip to the desired line */
    while (current_line < line_number) {
        if (fgets(temp_buffer, sizeof(temp_buffer), book->fp) == NULL) {
            return -1;
        }
        current_line++;
    }

    /* Read the target line */
    if (fgets(buffer, buffer_size, book->fp) == NULL) {
        return -1;
    }

    return 0;
}

/* Read last log from Book file */
int BookReadLastLog(Book* book, char* buffer, size_t buffer_size) {
    if (!book || !book->inited || !buffer || buffer_size == 0) {
        return -1;
    }

    fseek(book->fp, 0, SEEK_END);
    long file_size = ftell(book->fp);
    if (file_size < 0) {
        return -1;
    }

    size_t read_size = (file_size < buffer_size - 1) ? file_size : buffer_size - 1;
    fseek(book->fp, -read_size, SEEK_END);
    size_t bytes_read = fread(buffer, 1, read_size, book->fp);
    if (bytes_read != read_size) {
        return -1;
    }

    buffer[bytes_read] = '\0';
    return bytes_read;
}

/* Change Book file path */
int BookChangePath(Book* book, const char* new_path) {
    if (!book || !book->inited || !new_path) {
        return -1;
    }

    fclose(book->fp);
    free(book->path);

    book->path_len = strlen(new_path);
    book->path = (char*)malloc(book->path_len + 1);
    if (!book->path) {
        return -1;
    }
    strcpy(book->path, new_path);

    const char* mode = (book->state == BOOK_FILE_TEMP) ? "w+" : "r+";
    book->fp = fopen(new_path, mode);
    if (!book->fp) {
        free(book->path);
        return -1;
    }

    return 0;
}

/* Close Book file */
int CloseBook(Book* book) {
    if (!book || !book->inited) {
        return -1;
    }

    fclose(book->fp);
    free(book->path);
    book->inited = 0;
    return 0;
}