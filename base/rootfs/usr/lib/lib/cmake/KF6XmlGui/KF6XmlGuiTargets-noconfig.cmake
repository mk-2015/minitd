#----------------------------------------------------------------
# Generated CMake target import file.
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "KF6::XmlGui" for configuration ""
set_property(TARGET KF6::XmlGui APPEND PROPERTY IMPORTED_CONFIGURATIONS NOCONFIG)
set_target_properties(KF6::XmlGui PROPERTIES
  IMPORTED_LINK_DEPENDENT_LIBRARIES_NOCONFIG "KF6::GlobalAccel;Qt6::Network;Qt6::PrintSupport;KF6::CoreAddons;KF6::WidgetsAddons;KF6::ItemViews;KF6::I18n;KF6::IconThemes;KF6::IconWidgets"
  IMPORTED_LOCATION_NOCONFIG "${_IMPORT_PREFIX}/lib/libKF6XmlGui.so.6.28.0"
  IMPORTED_SONAME_NOCONFIG "libKF6XmlGui.so.6"
  )

list(APPEND _cmake_import_check_targets KF6::XmlGui )
list(APPEND _cmake_import_check_files_for_KF6::XmlGui "${_IMPORT_PREFIX}/lib/libKF6XmlGui.so.6.28.0" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
