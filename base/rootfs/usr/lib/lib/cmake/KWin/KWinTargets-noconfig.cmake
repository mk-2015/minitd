#----------------------------------------------------------------
# Generated CMake target import file.
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "KWin::kwin" for configuration ""
set_property(TARGET KWin::kwin APPEND PROPERTY IMPORTED_CONFIGURATIONS NOCONFIG)
set_target_properties(KWin::kwin PROPERTIES
  IMPORTED_LINK_DEPENDENT_LIBRARIES_NOCONFIG "Qt6::Concurrent;Qt6::Svg;KF6::ColorScheme;KF6::ConfigGui;KF6::ConfigQml;KF6::Crash;KF6::GlobalAccel;KF6::I18n;KF6::I18nQml;KF6::Package;KF6::Service;KDecoration3::KDecoration;KDecoration3::KDecoration3Private;K::KGlobalAccelD;KF6::Notifications;Plasma::KWaylandClient;Plasma::Activities;PW::KScreenLocker"
  IMPORTED_LOCATION_NOCONFIG "${_IMPORT_PREFIX}/lib/libkwin.so.6.7.3"
  IMPORTED_SONAME_NOCONFIG "libkwin.so.6"
  )

list(APPEND _cmake_import_check_targets KWin::kwin )
list(APPEND _cmake_import_check_files_for_KWin::kwin "${_IMPORT_PREFIX}/lib/libkwin.so.6.7.3" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
