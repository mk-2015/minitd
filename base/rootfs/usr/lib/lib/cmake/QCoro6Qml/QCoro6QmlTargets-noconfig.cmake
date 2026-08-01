#----------------------------------------------------------------
# Generated CMake target import file.
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "QCoro6::Qml" for configuration ""
set_property(TARGET QCoro6::Qml APPEND PROPERTY IMPORTED_CONFIGURATIONS NOCONFIG)
set_target_properties(QCoro6::Qml PROPERTIES
  IMPORTED_LOCATION_NOCONFIG "${_IMPORT_PREFIX}/lib/libQCoro6Qml.so.0.13.0"
  IMPORTED_SONAME_NOCONFIG "libQCoro6Qml.so.0"
  )

list(APPEND _cmake_import_check_targets QCoro6::Qml )
list(APPEND _cmake_import_check_files_for_QCoro6::Qml "${_IMPORT_PREFIX}/lib/libQCoro6Qml.so.0.13.0" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
