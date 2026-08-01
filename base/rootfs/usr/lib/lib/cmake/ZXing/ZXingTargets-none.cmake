#----------------------------------------------------------------
# Generated CMake target import file for configuration "None".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "ZXing::ZXing" for configuration "None"
set_property(TARGET ZXing::ZXing APPEND PROPERTY IMPORTED_CONFIGURATIONS NONE)
set_target_properties(ZXing::ZXing PROPERTIES
  IMPORTED_LINK_DEPENDENT_LIBRARIES_NONE "zint::zint"
  IMPORTED_LOCATION_NONE "${_IMPORT_PREFIX}/lib/libZXing.so.3.1.0"
  IMPORTED_SONAME_NONE "libZXing.so.4"
  )

list(APPEND _cmake_import_check_targets ZXing::ZXing )
list(APPEND _cmake_import_check_files_for_ZXing::ZXing "${_IMPORT_PREFIX}/lib/libZXing.so.3.1.0" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
