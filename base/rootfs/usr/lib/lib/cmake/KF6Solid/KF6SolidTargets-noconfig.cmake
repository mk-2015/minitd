#----------------------------------------------------------------
# Generated CMake target import file.
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "KF6::Solid" for configuration ""
set_property(TARGET KF6::Solid APPEND PROPERTY IMPORTED_CONFIGURATIONS NOCONFIG)
set_target_properties(KF6::Solid PROPERTIES
  IMPORTED_LINK_DEPENDENT_LIBRARIES_NOCONFIG "Qt6::Xml;Qt6::Gui;Qt6::DBus"
  IMPORTED_LOCATION_NOCONFIG "${_IMPORT_PREFIX}/lib/libKF6Solid.so.6.28.0"
  IMPORTED_SONAME_NOCONFIG "libKF6Solid.so.6"
  )

list(APPEND _cmake_import_check_targets KF6::Solid )
list(APPEND _cmake_import_check_files_for_KF6::Solid "${_IMPORT_PREFIX}/lib/libKF6Solid.so.6.28.0" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
