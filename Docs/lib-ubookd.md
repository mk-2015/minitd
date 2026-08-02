# ubookd

`ubookd` is a book-keeping logger API built for the minitd init system. It provides simple file-based logging with multiple log levels and line-based read/write operations.

## Log levels

The library supports the following log levels:

- `LOG_LEVEL_DEBUG` - Debug messages for diagnostic information
- `LOG_LEVEL_INFO` - Informational messages
- `LOG_LEVEL_WARNING` - Warning messages (labeled as `[WARN]`)
- `LOG_LEVEL_ERROR` - Error messages
- `LOG_LEVEL_CRITICAL` - Critical error messages

## API Reference

### Data Types

#### `BookState`

Enum to specify the file mode when opening a book:

- `BOOK_FILE_TEMP` - Temporary file (write mode, creates new)
- `BOOK_FILE_PERM` - Permanent file (read mode, must exist)

#### `Book` Structure

```c
typedef struct {
    FILE* fp;              // File pointer
    char* path;            // Path to log file
    size_t path_len;       // Length of path
    int inited;            // Initialization flag
    const BookState state; // File mode (TEMP or PERM)
} Book;
```

### Functions

#### `OpenBook()`

```c
int OpenBook(char* path, BookState state, Book* book);
```

Opens a book handle for logging. Returns 0 on success, -1 on failure.

- `path` - Path to the log file
- `state` - File mode (BOOK_FILE_TEMP or BOOK_FILE_PERM)
- `book` - Pointer to Book structure to initialize

#### `BookWriteLog()`

```c
int BookWriteLog(Book* book, const char* log, LogLevel level);
```

Writes a log entry with the specified log level. Returns 0 on success, -1 on failure.

- `book` - Pointer to initialized Book structure
- `log` - Log message string
- `level` - Log level (LogLevel enum)

#### `BookReadLog()`

```c
int BookReadLog(unsigned int line_number, Book* book, char* buffer, size_t buffer_size);
```

Reads a specific line from the log file into the provided buffer. Returns 0 on success, -1 on failure.

- `line_number` - Line number to read (0-indexed)
- `book` - Pointer to initialized Book structure
- `buffer` - Buffer to store the read line
- `buffer_size` - Size of the buffer

#### `BookReadLineRange()`

```c
int BookReadLineRange(unsigned int start_line, unsigned int end_line, Book* book, 
                      char* buffer, size_t buffer_size);
```

Reads a range of lines from the log file into the provided buffer. Returns 0 on success, -1 on failure.

- `start_line` - Starting line number (0-indexed)
- `end_line` - Ending line number (inclusive, 0-indexed)
- `book` - Pointer to initialized Book structure
- `buffer` - Buffer to store the read lines
- `buffer_size` - Size of the buffer

#### `BookReadLastLog()`

```c
int BookReadLastLog(Book* book, char* buffer, size_t buffer_size);
```

Reads the last entry from the log file into the provided buffer. Returns the number of bytes read on success, -1 on failure.

- `book` - Pointer to initialized Book structure
- `buffer` - Buffer to store the read entry
- `buffer_size` - Size of the buffer

#### `BookChangePath()`

```c
int BookChangePath(Book* book, const char* new_path);
```

Changes the log file path for an open book handle. Closes the current file and opens the new one. Returns 0 on success, -1 on failure.

- `book` - Pointer to initialized Book structure
- `new_path` - New path to log file

#### `CloseBook()`

```c
int CloseBook(Book* book);
```

Closes the book handle and frees associated resources. Returns 0 on success, -1 on failure.

- `book` - Pointer to initialized Book structure

## Usage Example

```c
#include <libubookd/booker.h>

int main() {
    Book book;
    
    // Open a temporary log file
    if (OpenBook("/tmp/mylog.txt", BOOK_FILE_TEMP, &book) != 0) {
        return 1;
    }
    
    // Write log entries
    BookWriteLog(&book, "System started\n", LOG_LEVEL_INFO);
    BookWriteLog(&book, "Initializing services\n", LOG_LEVEL_DEBUG);
    
    // Read last log entry
    char buffer[512];
    if (BookReadLastLog(&book, buffer, sizeof(buffer)) >= 0) {
        printf("Last log: %s\n", buffer);
    }
    
    // Close the book
    CloseBook(&book);
    return 0;
}
```