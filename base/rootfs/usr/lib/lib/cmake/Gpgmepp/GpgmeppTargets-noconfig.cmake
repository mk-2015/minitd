#----------------------------------------------------------------
# Generated CMake target import file.
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "Gpgmepp" for configuration ""
set_property(TARGET Gpgmepp APPEND PROPERTY IMPORTED_CONFIGURATIONS NOCONFIG)
set_target_properties(Gpgmepp PROPERTIES
  IMPORTED_LOCATION_NOCONFIG "${_IMPORT_PREFIX}/lib/libgpgmepp.so.7.1.0"
  IMPORTED_SONAME_NOCONFIG "libgpgmepp.so.7"
  )

list(APPEND _cmake_import_check_targets Gpgmepp )
list(APPEND _cmake_import_check_files_for_Gpgmepp "${_IMPORT_PREFIX}/lib/libgpgmepp.so.7.1.0" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
