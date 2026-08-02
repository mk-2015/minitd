cmake_minimum_required(VERSION "3.0")
project(minitctl C)

add_executable(minitctl minitctl.c)
target_include_directories(minitctl PRIVATE ${CMAKE_SOURCE_DIR}/libs/include)
target_link_libraries(minitctl PRIVATE libunotifi)
target_link_options("-static")