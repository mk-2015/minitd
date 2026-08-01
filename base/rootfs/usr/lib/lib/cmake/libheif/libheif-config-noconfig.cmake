#----------------------------------------------------------------
# Generated CMake target import file.
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "heif" for configuration ""
set_property(TARGET heif APPEND PROPERTY IMPORTED_CONFIGURATIONS NOCONFIG)
set_target_properties(heif PROPERTIES
  IMPORTED_LINK_DEPENDENT_LIBRARIES_NOCONFIG "AOM::aom"
  IMPORTED_LOCATION_NOCONFIG "${_IMPORT_PREFIX}/lib/libheif.so.1.23.1"
  IMPORTED_SONAME_NOCONFIG "libheif.so.1"
  )

list(APPEND _cmake_import_check_targets heif )
list(APPEND _cmake_import_check_files_for_heif "${_IMPORT_PREFIX}/lib/libheif.so.1.23.1" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
