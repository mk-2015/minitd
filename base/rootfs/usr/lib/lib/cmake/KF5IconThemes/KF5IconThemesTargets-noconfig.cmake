#----------------------------------------------------------------
# Generated CMake target import file.
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "KF5::IconThemes" for configuration ""
set_property(TARGET KF5::IconThemes APPEND PROPERTY IMPORTED_CONFIGURATIONS NOCONFIG)
set_target_properties(KF5::IconThemes PROPERTIES
  IMPORTED_LINK_DEPENDENT_LIBRARIES_NOCONFIG "Qt5::Svg;KF5::Archive;KF5::I18n;KF5::WidgetsAddons;KF5::ConfigWidgets;KF5::CoreAddons;Qt5::DBus"
  IMPORTED_LOCATION_NOCONFIG "${_IMPORT_PREFIX}/lib/libKF5IconThemes.so.5.116.0"
  IMPORTED_SONAME_NOCONFIG "libKF5IconThemes.so.5"
  )

list(APPEND _cmake_import_check_targets KF5::IconThemes )
list(APPEND _cmake_import_check_files_for_KF5::IconThemes "${_IMPORT_PREFIX}/lib/libKF5IconThemes.so.5.116.0" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
