#----------------------------------------------------------------
# Generated CMake target import file.
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "EBML::ebml" for configuration ""
set_property(TARGET EBML::ebml APPEND PROPERTY IMPORTED_CONFIGURATIONS NOCONFIG)
set_target_properties(EBML::ebml PROPERTIES
  IMPORTED_LOCATION_NOCONFIG "/usr/lib/libebml.so.5.0.0"
  IMPORTED_SONAME_NOCONFIG "libebml.so.5"
  )

list(APPEND _cmake_import_check_targets EBML::ebml )
list(APPEND _cmake_import_check_files_for_EBML::ebml "/usr/lib/libebml.so.5.0.0" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
