#----------------------------------------------------------------
# Generated CMake target import file.
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "KioArchive" for configuration ""
set_property(TARGET KioArchive APPEND PROPERTY IMPORTED_CONFIGURATIONS NOCONFIG)
set_target_properties(KioArchive PROPERTIES
  IMPORTED_LINK_DEPENDENT_LIBRARIES_NOCONFIG "KF6::I18n;Qt6::Network"
  IMPORTED_LOCATION_NOCONFIG "${_IMPORT_PREFIX}/lib/libkioarchive6.so.6.0.0"
  IMPORTED_SONAME_NOCONFIG "libkioarchive6.so.6"
  )

list(APPEND _cmake_import_check_targets KioArchive )
list(APPEND _cmake_import_check_files_for_KioArchive "${_IMPORT_PREFIX}/lib/libkioarchive6.so.6.0.0" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
