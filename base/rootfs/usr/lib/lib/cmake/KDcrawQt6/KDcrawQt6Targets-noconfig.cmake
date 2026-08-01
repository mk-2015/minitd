#----------------------------------------------------------------
# Generated CMake target import file.
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "KDcrawQt6" for configuration ""
set_property(TARGET KDcrawQt6 APPEND PROPERTY IMPORTED_CONFIGURATIONS NOCONFIG)
set_target_properties(KDcrawQt6 PROPERTIES
  IMPORTED_LOCATION_NOCONFIG "${_IMPORT_PREFIX}/lib/libKDcrawQt6.so.5.0.0"
  IMPORTED_SONAME_NOCONFIG "libKDcrawQt6.so.5"
  )

list(APPEND _cmake_import_check_targets KDcrawQt6 )
list(APPEND _cmake_import_check_files_for_KDcrawQt6 "${_IMPORT_PREFIX}/lib/libKDcrawQt6.so.5.0.0" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
