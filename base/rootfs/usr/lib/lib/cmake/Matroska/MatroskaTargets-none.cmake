#----------------------------------------------------------------
# Generated CMake target import file for configuration "None".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "Matroska::matroska" for configuration "None"
set_property(TARGET Matroska::matroska APPEND PROPERTY IMPORTED_CONFIGURATIONS NONE)
set_target_properties(Matroska::matroska PROPERTIES
  IMPORTED_LOCATION_NONE "/usr/lib/libmatroska.so.7.0.0"
  IMPORTED_SONAME_NONE "libmatroska.so.7"
  )

list(APPEND _cmake_import_check_targets Matroska::matroska )
list(APPEND _cmake_import_check_files_for_Matroska::matroska "/usr/lib/libmatroska.so.7.0.0" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
