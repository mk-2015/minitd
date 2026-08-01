#----------------------------------------------------------------
# Generated CMake target import file.
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "DolphinVcs" for configuration ""
set_property(TARGET DolphinVcs APPEND PROPERTY IMPORTED_CONFIGURATIONS NOCONFIG)
set_target_properties(DolphinVcs PROPERTIES
  IMPORTED_LOCATION_NOCONFIG "${_IMPORT_PREFIX}/lib/libdolphinvcs.so.26.04.3"
  IMPORTED_SONAME_NOCONFIG "libdolphinvcs.so.6"
  )

list(APPEND _cmake_import_check_targets DolphinVcs )
list(APPEND _cmake_import_check_files_for_DolphinVcs "${_IMPORT_PREFIX}/lib/libdolphinvcs.so.26.04.3" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
