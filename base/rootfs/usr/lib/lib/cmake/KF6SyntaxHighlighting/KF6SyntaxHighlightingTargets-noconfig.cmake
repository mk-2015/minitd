#----------------------------------------------------------------
# Generated CMake target import file.
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "KF6::SyntaxHighlighting" for configuration ""
set_property(TARGET KF6::SyntaxHighlighting APPEND PROPERTY IMPORTED_CONFIGURATIONS NOCONFIG)
set_target_properties(KF6::SyntaxHighlighting PROPERTIES
  IMPORTED_LINK_DEPENDENT_LIBRARIES_NOCONFIG "Qt6::Network"
  IMPORTED_LOCATION_NOCONFIG "${_IMPORT_PREFIX}/lib/libKF6SyntaxHighlighting.so.6.28.1"
  IMPORTED_SONAME_NOCONFIG "libKF6SyntaxHighlighting.so.6"
  )

list(APPEND _cmake_import_check_targets KF6::SyntaxHighlighting )
list(APPEND _cmake_import_check_files_for_KF6::SyntaxHighlighting "${_IMPORT_PREFIX}/lib/libKF6SyntaxHighlighting.so.6.28.1" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
