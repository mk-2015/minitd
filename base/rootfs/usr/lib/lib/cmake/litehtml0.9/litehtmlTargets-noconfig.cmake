#----------------------------------------------------------------
# Generated CMake target import file.
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "litehtml0.9" for configuration ""
set_property(TARGET litehtml0.9 APPEND PROPERTY IMPORTED_CONFIGURATIONS NOCONFIG)
set_target_properties(litehtml0.9 PROPERTIES
  IMPORTED_LOCATION_NOCONFIG "${_IMPORT_PREFIX}/lib/liblitehtml0.9.so.0.0.0"
  IMPORTED_SONAME_NOCONFIG "liblitehtml0.9.so.0"
  )

list(APPEND _cmake_import_check_targets litehtml0.9 )
list(APPEND _cmake_import_check_files_for_litehtml0.9 "${_IMPORT_PREFIX}/lib/liblitehtml0.9.so.0.0.0" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
