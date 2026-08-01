#----------------------------------------------------------------
# Generated CMake target import file.
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "KExiv2Qt6" for configuration ""
set_property(TARGET KExiv2Qt6 APPEND PROPERTY IMPORTED_CONFIGURATIONS NOCONFIG)
set_target_properties(KExiv2Qt6 PROPERTIES
  IMPORTED_LINK_DEPENDENT_LIBRARIES_NOCONFIG "Exiv2::exiv2lib"
  IMPORTED_LOCATION_NOCONFIG "${_IMPORT_PREFIX}/lib/libKExiv2Qt6.so.5.1.0"
  IMPORTED_SONAME_NOCONFIG "libKExiv2Qt6.so.0"
  )

list(APPEND _cmake_import_check_targets KExiv2Qt6 )
list(APPEND _cmake_import_check_files_for_KExiv2Qt6 "${_IMPORT_PREFIX}/lib/libKExiv2Qt6.so.5.1.0" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
