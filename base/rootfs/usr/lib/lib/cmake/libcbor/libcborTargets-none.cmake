#----------------------------------------------------------------
# Generated CMake target import file for configuration "None".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "libcbor::libcbor" for configuration "None"
set_property(TARGET libcbor::libcbor APPEND PROPERTY IMPORTED_CONFIGURATIONS NONE)
set_target_properties(libcbor::libcbor PROPERTIES
  IMPORTED_LOCATION_NONE "${_IMPORT_PREFIX}/lib/libcbor.so.0.14.0"
  IMPORTED_SONAME_NONE "libcbor.so.0.14"
  )

list(APPEND _cmake_import_check_targets libcbor::libcbor )
list(APPEND _cmake_import_check_files_for_libcbor::libcbor "${_IMPORT_PREFIX}/lib/libcbor.so.0.14.0" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
