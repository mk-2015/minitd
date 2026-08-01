#----------------------------------------------------------------
# Generated CMake target import file.
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "KF6::ConfigCore" for configuration ""
set_property(TARGET KF6::ConfigCore APPEND PROPERTY IMPORTED_CONFIGURATIONS NOCONFIG)
set_target_properties(KF6::ConfigCore PROPERTIES
  IMPORTED_LINK_DEPENDENT_LIBRARIES_NOCONFIG "Qt6::DBus"
  IMPORTED_LOCATION_NOCONFIG "${_IMPORT_PREFIX}/lib/libKF6ConfigCore.so.6.28.0"
  IMPORTED_SONAME_NOCONFIG "libKF6ConfigCore.so.6"
  )

list(APPEND _cmake_import_check_targets KF6::ConfigCore )
list(APPEND _cmake_import_check_files_for_KF6::ConfigCore "${_IMPORT_PREFIX}/lib/libKF6ConfigCore.so.6.28.0" )

# Import target "KF6::ConfigGui" for configuration ""
set_property(TARGET KF6::ConfigGui APPEND PROPERTY IMPORTED_CONFIGURATIONS NOCONFIG)
set_target_properties(KF6::ConfigGui PROPERTIES
  IMPORTED_LOCATION_NOCONFIG "${_IMPORT_PREFIX}/lib/libKF6ConfigGui.so.6.28.0"
  IMPORTED_SONAME_NOCONFIG "libKF6ConfigGui.so.6"
  )

list(APPEND _cmake_import_check_targets KF6::ConfigGui )
list(APPEND _cmake_import_check_files_for_KF6::ConfigGui "${_IMPORT_PREFIX}/lib/libKF6ConfigGui.so.6.28.0" )

# Import target "KF6::ConfigQml" for configuration ""
set_property(TARGET KF6::ConfigQml APPEND PROPERTY IMPORTED_CONFIGURATIONS NOCONFIG)
set_target_properties(KF6::ConfigQml PROPERTIES
  IMPORTED_LINK_DEPENDENT_LIBRARIES_NOCONFIG "Qt6::Quick"
  IMPORTED_LOCATION_NOCONFIG "${_IMPORT_PREFIX}/lib/libKF6ConfigQml.so.6.28.0"
  IMPORTED_SONAME_NOCONFIG "libKF6ConfigQml.so.6"
  )

list(APPEND _cmake_import_check_targets KF6::ConfigQml )
list(APPEND _cmake_import_check_files_for_KF6::ConfigQml "${_IMPORT_PREFIX}/lib/libKF6ConfigQml.so.6.28.0" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
