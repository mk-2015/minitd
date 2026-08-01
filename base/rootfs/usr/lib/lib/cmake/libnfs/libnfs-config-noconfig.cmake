#----------------------------------------------------------------
# Generated CMake target import file.
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "libnfs::nfs" for configuration ""
set_property(TARGET libnfs::nfs APPEND PROPERTY IMPORTED_CONFIGURATIONS NOCONFIG)
set_target_properties(libnfs::nfs PROPERTIES
  IMPORTED_LOCATION_NOCONFIG "${_IMPORT_PREFIX}/lib/libnfs.so.16.2.0"
  IMPORTED_SONAME_NOCONFIG "libnfs.so.16.2.0"
  )

list(APPEND _cmake_import_check_targets libnfs::nfs )
list(APPEND _cmake_import_check_files_for_libnfs::nfs "${_IMPORT_PREFIX}/lib/libnfs.so.16.2.0" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
