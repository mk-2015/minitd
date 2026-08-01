#----------------------------------------------------------------
# Generated CMake target import file.
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "KF6::ScreenDpms" for configuration ""
set_property(TARGET KF6::ScreenDpms APPEND PROPERTY IMPORTED_CONFIGURATIONS NOCONFIG)
set_target_properties(KF6::ScreenDpms PROPERTIES
  IMPORTED_LINK_DEPENDENT_LIBRARIES_NOCONFIG "Qt6::WaylandClient"
  IMPORTED_LOCATION_NOCONFIG "${_IMPORT_PREFIX}/lib/libKF6ScreenDpms.so.6.7.3"
  IMPORTED_SONAME_NOCONFIG "libKF6ScreenDpms.so.8"
  )

list(APPEND _cmake_import_check_targets KF6::ScreenDpms )
list(APPEND _cmake_import_check_files_for_KF6::ScreenDpms "${_IMPORT_PREFIX}/lib/libKF6ScreenDpms.so.6.7.3" )

# Import target "KF6::Screen" for configuration ""
set_property(TARGET KF6::Screen APPEND PROPERTY IMPORTED_CONFIGURATIONS NOCONFIG)
set_target_properties(KF6::Screen PROPERTIES
  IMPORTED_LINK_DEPENDENT_LIBRARIES_NOCONFIG "Qt6::DBus"
  IMPORTED_LOCATION_NOCONFIG "${_IMPORT_PREFIX}/lib/libKF6Screen.so.6.7.3"
  IMPORTED_SONAME_NOCONFIG "libKF6Screen.so.8"
  )

list(APPEND _cmake_import_check_targets KF6::Screen )
list(APPEND _cmake_import_check_files_for_KF6::Screen "${_IMPORT_PREFIX}/lib/libKF6Screen.so.6.7.3" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
