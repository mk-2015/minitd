#----------------------------------------------------------------
# Generated CMake target import file for configuration "None".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "openjph" for configuration "None"
set_property(TARGET openjph APPEND PROPERTY IMPORTED_CONFIGURATIONS NONE)
set_target_properties(openjph PROPERTIES
  IMPORTED_LOCATION_NONE "${_IMPORT_PREFIX}/lib/libopenjph.so.0.30.1"
  IMPORTED_SONAME_NONE "libopenjph.so.0.30"
  )

list(APPEND _cmake_import_check_targets openjph )
list(APPEND _cmake_import_check_files_for_openjph "${_IMPORT_PREFIX}/lib/libopenjph.so.0.30.1" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
