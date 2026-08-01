#----------------------------------------------------------------
# Generated CMake target import file.
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "QCoro6::WebSockets" for configuration ""
set_property(TARGET QCoro6::WebSockets APPEND PROPERTY IMPORTED_CONFIGURATIONS NOCONFIG)
set_target_properties(QCoro6::WebSockets PROPERTIES
  IMPORTED_LOCATION_NOCONFIG "${_IMPORT_PREFIX}/lib/libQCoro6WebSockets.so.0.13.0"
  IMPORTED_SONAME_NOCONFIG "libQCoro6WebSockets.so.0"
  )

list(APPEND _cmake_import_check_targets QCoro6::WebSockets )
list(APPEND _cmake_import_check_files_for_QCoro6::WebSockets "${_IMPORT_PREFIX}/lib/libQCoro6WebSockets.so.0.13.0" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
