#----------------------------------------------------------------
# Generated CMake target import file for configuration "None".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "id3tag::id3tag" for configuration "None"
set_property(TARGET id3tag::id3tag APPEND PROPERTY IMPORTED_CONFIGURATIONS NONE)
set_target_properties(id3tag::id3tag PROPERTIES
  IMPORTED_LOCATION_NONE "${_IMPORT_PREFIX}/lib/libid3tag.so.0.16.4"
  IMPORTED_SONAME_NONE "libid3tag.so.0"
  )

list(APPEND _cmake_import_check_targets id3tag::id3tag )
list(APPEND _cmake_import_check_files_for_id3tag::id3tag "${_IMPORT_PREFIX}/lib/libid3tag.so.0.16.4" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
