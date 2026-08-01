#----------------------------------------------------------------
# Generated CMake target import file.
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "KF6::SonnetCore" for configuration ""
set_property(TARGET KF6::SonnetCore APPEND PROPERTY IMPORTED_CONFIGURATIONS NOCONFIG)
set_target_properties(KF6::SonnetCore PROPERTIES
  IMPORTED_LOCATION_NOCONFIG "${_IMPORT_PREFIX}/lib/libKF6SonnetCore.so.6.28.0"
  IMPORTED_SONAME_NOCONFIG "libKF6SonnetCore.so.6"
  )

list(APPEND _cmake_import_check_targets KF6::SonnetCore )
list(APPEND _cmake_import_check_files_for_KF6::SonnetCore "${_IMPORT_PREFIX}/lib/libKF6SonnetCore.so.6.28.0" )

# Import target "KF6::SonnetUi" for configuration ""
set_property(TARGET KF6::SonnetUi APPEND PROPERTY IMPORTED_CONFIGURATIONS NOCONFIG)
set_target_properties(KF6::SonnetUi PROPERTIES
  IMPORTED_LINK_DEPENDENT_LIBRARIES_NOCONFIG "KF6::SonnetCore"
  IMPORTED_LOCATION_NOCONFIG "${_IMPORT_PREFIX}/lib/libKF6SonnetUi.so.6.28.0"
  IMPORTED_SONAME_NOCONFIG "libKF6SonnetUi.so.6"
  )

list(APPEND _cmake_import_check_targets KF6::SonnetUi )
list(APPEND _cmake_import_check_files_for_KF6::SonnetUi "${_IMPORT_PREFIX}/lib/libKF6SonnetUi.so.6.28.0" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
