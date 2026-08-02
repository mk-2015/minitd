cmake_minimum_required(VERSION 3.10)
project(minitctl C)

add_executable(minitctl minitctl.c)

# Tell CMake where to find libunotifi.a
target_link_directories(minitctl PRIVATE ${CMAKE_SOURCE_DIR}/libs/lib)
target_include_directories(minitctl PRIVATE ${CMAKE_SOURCE_DIR}/libs/include)

# Link the library
target_link_libraries(minitctl PRIVATE unotifi)

# Enforce fully static linking cleanly
set_target_properties(minitctl PROPERTIES LINK_FLAGS "-static")