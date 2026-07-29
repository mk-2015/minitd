cmake_minimum_required(VERSION 3.10)
project(minitd C)

set(CMAKE_C_STANDARD 11)
set(CMAKE_C_STANDARD_REQUIRED ON)

add_compile_options(-Wall -Wextra -O2)

set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_SOURCE_DIR}/bin)

file(GLOB_RECURSE SRCS "src/*.c")

add_executable(init ${SRCS})

target_include_directories(init PRIVATE include)
target_link_options(init PRIVATE -static)