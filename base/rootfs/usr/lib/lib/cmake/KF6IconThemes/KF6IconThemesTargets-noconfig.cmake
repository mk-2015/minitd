#----------------------------------------------------------------
# Generated CMake target import file.
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "KF6::IconWidgets" for configuration ""
set_property(TARGET KF6::IconWidgets APPEND PROPERTY IMPORTED_CONFIGURATIONS NOCONFIG)
set_target_properties(KF6::IconWidgets PROPERTIES
  IMPORTED_LINK_DEPENDENT_LIBRARIES_NOCONFIG "Qt6::Svg;KF6::I18n;KF6::ConfigGui;KF6::WidgetsAddons"
  IMPORTED_LOCATION_NOCONFIG "${_IMPORT_PREFIX}/lib/libKF6IconWidgets.so.6.28.0"
  IMPORTED_SONAME_NOCONFIG "libKF6IconWidgets.so.6"
  )

list(APPEND _cmake_import_check_targets KF6::IconWidgets )
list(APPEND _cmake_import_check_files_for_KF6::IconWidgets "${_IMPORT_PREFIX}/lib/libKF6IconWidgets.so.6.28.0" )

# Import target "KF6::IconThemes" for configuration ""
set_property(TARGET KF6::IconThemes APPEND PROPERTY IMPORTED_CONFIGURATIONS NOCONFIG)
set_target_properties(KF6::IconThemes PROPERTIES
  IMPORTED_LINK_DEPENDENT_LIBRARIES_NOCONFIG "Qt6::Svg;KF6::Archive;KF6::I18n;KF6::ColorScheme;Qt6::DBus;KF6::BreezeIcons"
  IMPORTED_LOCATION_NOCONFIG "${_IMPORT_PREFIX}/lib/libKF6IconThemes.so.6.28.0"
  IMPORTED_SONAME_NOCONFIG "libKF6IconThemes.so.6"
  )

list(APPEND _cmake_import_check_targets KF6::IconThemes )
list(APPEND _cmake_import_check_files_for_KF6::IconThemes "${_IMPORT_PREFIX}/lib/libKF6IconThemes.so.6.28.0" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
