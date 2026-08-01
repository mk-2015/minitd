#----------------------------------------------------------------
# Generated CMake target import file.
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "cppdap::cppdap" for configuration ""
set_property(TARGET cppdap::cppdap APPEND PROPERTY IMPORTED_CONFIGURATIONS NOCONFIG)
set_target_properties(cppdap::cppdap PROPERTIES
  IMPORTED_LOCATION_NOCONFIG "${_IMPORT_PREFIX}/lib/libcppdap.so"
  IMPORTED_SONAME_NOCONFIG "libcppdap.so"
  )

list(APPEND _cmake_import_check_targets cppdap::cppdap )
list(APPEND _cmake_import_check_files_for_cppdap::cppdap "${_IMPORT_PREFIX}/lib/libcppdap.so" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
