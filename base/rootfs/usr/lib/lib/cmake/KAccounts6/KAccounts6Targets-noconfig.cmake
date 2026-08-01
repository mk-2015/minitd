#----------------------------------------------------------------
# Generated CMake target import file.
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "KAccounts6" for configuration ""
set_property(TARGET KAccounts6 APPEND PROPERTY IMPORTED_CONFIGURATIONS NOCONFIG)
set_target_properties(KAccounts6 PROPERTIES
  IMPORTED_LOCATION_NOCONFIG "${_IMPORT_PREFIX}/lib/libkaccounts6.so.26.04.3"
  IMPORTED_SONAME_NOCONFIG "libkaccounts6.so.2"
  )

list(APPEND _cmake_import_check_targets KAccounts6 )
list(APPEND _cmake_import_check_files_for_KAccounts6 "${_IMPORT_PREFIX}/lib/libkaccounts6.so.26.04.3" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
