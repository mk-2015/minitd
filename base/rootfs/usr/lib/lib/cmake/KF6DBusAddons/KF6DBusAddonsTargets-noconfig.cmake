#----------------------------------------------------------------
# Generated CMake target import file.
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "KF6::DBusAddons" for configuration ""
set_property(TARGET KF6::DBusAddons APPEND PROPERTY IMPORTED_CONFIGURATIONS NOCONFIG)
set_target_properties(KF6::DBusAddons PROPERTIES
  IMPORTED_LOCATION_NOCONFIG "${_IMPORT_PREFIX}/lib/libKF6DBusAddons.so.6.28.0"
  IMPORTED_SONAME_NOCONFIG "libKF6DBusAddons.so.6"
  )

list(APPEND _cmake_import_check_targets KF6::DBusAddons )
list(APPEND _cmake_import_check_files_for_KF6::DBusAddons "${_IMPORT_PREFIX}/lib/libKF6DBusAddons.so.6.28.0" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
