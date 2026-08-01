#----------------------------------------------------------------
# Generated CMake target import file.
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "QMobipocket6" for configuration ""
set_property(TARGET QMobipocket6 APPEND PROPERTY IMPORTED_CONFIGURATIONS NOCONFIG)
set_target_properties(QMobipocket6 PROPERTIES
  IMPORTED_LOCATION_NOCONFIG "${_IMPORT_PREFIX}/lib/libQMobipocket6.so.3.0.0"
  IMPORTED_SONAME_NOCONFIG "libQMobipocket6.so.3"
  )

list(APPEND _cmake_import_check_targets QMobipocket6 )
list(APPEND _cmake_import_check_files_for_QMobipocket6 "${_IMPORT_PREFIX}/lib/libQMobipocket6.so.3.0.0" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
