#----------------------------------------------------------------
# Generated CMake target import file.
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "CFITSIO::cfitsio" for configuration ""
set_property(TARGET CFITSIO::cfitsio APPEND PROPERTY IMPORTED_CONFIGURATIONS NOCONFIG)
set_target_properties(CFITSIO::cfitsio PROPERTIES
  IMPORTED_LOCATION_NOCONFIG "${_IMPORT_PREFIX}/lib/libcfitsio.so.4.6.4"
  IMPORTED_SONAME_NOCONFIG "libcfitsio.so.10"
  )

list(APPEND _cmake_import_check_targets CFITSIO::cfitsio )
list(APPEND _cmake_import_check_files_for_CFITSIO::cfitsio "${_IMPORT_PREFIX}/lib/libcfitsio.so.4.6.4" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
