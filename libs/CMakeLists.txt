# =============================================================
# libs/CMakeLists.txt — auto-discovers every library under src/
# and builds each as its own static (default) or shared target.
#
# Expected layout:
#   libs/src/<libname>/*.c
#   libs/include/<libname>/*.h
#   libs/lib/<libname>.a   (or .so, see BUILD_SHARED_LIBS_MINITD)
#
# NOTE on object files: unlike the Makefile version, CMake does
# not let you redirect intermediate .o files to a plain
# libs/obj/<libname>/ tree without custom add_custom_command
# rules — it keeps them under its own build directory
# (CMakeFiles/<target>.dir/...). If matching that exact obj/
# layout matters to you, use the Makefile build instead; this
# file matches the final libs/lib/*.a|.so output layout exactly.
# =============================================================

option(BUILD_SHARED_LIBS_MINITD "Build libs/ as .so instead of .a" OFF)

set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/lib)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/lib)

file(GLOB LIB_CANDIDATES RELATIVE ${CMAKE_CURRENT_SOURCE_DIR}/src
     ${CMAKE_CURRENT_SOURCE_DIR}/src/*)

set(MINITD_LIBS "")

foreach(libname ${LIB_CANDIDATES})
    set(libdir ${CMAKE_CURRENT_SOURCE_DIR}/src/${libname})
    if(IS_DIRECTORY ${libdir})
        file(GLOB_RECURSE ${libname}_SRCS "${libdir}/*.c")
        if(${libname}_SRCS)
            if(BUILD_SHARED_LIBS_MINITD)
                add_library(${libname} SHARED ${${libname}_SRCS})
            else()
                add_library(${libname} STATIC ${${libname}_SRCS})
            endif()

            target_include_directories(${libname} PUBLIC
                ${CMAKE_CURRENT_SOURCE_DIR}/include
            )

            list(APPEND MINITD_LIBS ${libname})
        endif()
    endif()
endforeach()

set(MINITD_LIBS ${MINITD_LIBS} PARENT_SCOPE)