#----------------------------------------------------------------
# Generated CMake target import file.
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "qt6keychain" for configuration ""
set_property(TARGET qt6keychain APPEND PROPERTY IMPORTED_CONFIGURATIONS NOCONFIG)
set_target_properties(qt6keychain PROPERTIES
  IMPORTED_LOCATION_NOCONFIG "${_IMPORT_PREFIX}/lib/libqt6keychain.so.0.17.0"
  IMPORTED_SONAME_NOCONFIG "libqt6keychain.so.1"
  )

list(APPEND _cmake_import_check_targets qt6keychain )
list(APPEND _cmake_import_check_files_for_qt6keychain "${_IMPORT_PREFIX}/lib/libqt6keychain.so.0.17.0" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
