#----------------------------------------------------------------
# Generated CMake target import file for configuration "None".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "libzmq" for configuration "None"
set_property(TARGET libzmq APPEND PROPERTY IMPORTED_CONFIGURATIONS NONE)
set_target_properties(libzmq PROPERTIES
  IMPORTED_LOCATION_NONE "${_IMPORT_PREFIX}/lib/libzmq.so.5.2.5"
  IMPORTED_SONAME_NONE "libzmq.so.5"
  )

list(APPEND _cmake_import_check_targets libzmq )
list(APPEND _cmake_import_check_files_for_libzmq "${_IMPORT_PREFIX}/lib/libzmq.so.5.2.5" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
