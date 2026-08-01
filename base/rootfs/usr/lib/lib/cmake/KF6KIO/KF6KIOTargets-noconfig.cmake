#----------------------------------------------------------------
# Generated CMake target import file.
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "KF6::KIOCore" for configuration ""
set_property(TARGET KF6::KIOCore APPEND PROPERTY IMPORTED_CONFIGURATIONS NOCONFIG)
set_target_properties(KF6::KIOCore PROPERTIES
  IMPORTED_LINK_DEPENDENT_LIBRARIES_NOCONFIG "Qt6::Xml;Qt6::Concurrent;KF6::ConfigCore;KF6::I18n;KF6::Service;KF6::Crash"
  IMPORTED_LOCATION_NOCONFIG "${_IMPORT_PREFIX}/lib/libKF6KIOCore.so.6.28.0"
  IMPORTED_SONAME_NOCONFIG "libKF6KIOCore.so.6"
  )

list(APPEND _cmake_import_check_targets KF6::KIOCore )
list(APPEND _cmake_import_check_files_for_KF6::KIOCore "${_IMPORT_PREFIX}/lib/libKF6KIOCore.so.6.28.0" )

# Import target "KF6::KIOGui" for configuration ""
set_property(TARGET KF6::KIOGui APPEND PROPERTY IMPORTED_CONFIGURATIONS NOCONFIG)
set_target_properties(KF6::KIOGui PROPERTIES
  IMPORTED_LINK_DEPENDENT_LIBRARIES_NOCONFIG "KF6::Solid;KF6::I18n;KF6::WindowSystem"
  IMPORTED_LOCATION_NOCONFIG "${_IMPORT_PREFIX}/lib/libKF6KIOGui.so.6.28.0"
  IMPORTED_SONAME_NOCONFIG "libKF6KIOGui.so.6"
  )

list(APPEND _cmake_import_check_targets KF6::KIOGui )
list(APPEND _cmake_import_check_files_for_KF6::KIOGui "${_IMPORT_PREFIX}/lib/libKF6KIOGui.so.6.28.0" )

# Import target "KF6::KIOWidgets" for configuration ""
set_property(TARGET KF6::KIOWidgets APPEND PROPERTY IMPORTED_CONFIGURATIONS NOCONFIG)
set_target_properties(KF6::KIOWidgets PROPERTIES
  IMPORTED_LINK_DEPENDENT_LIBRARIES_NOCONFIG "Qt6::Concurrent;KF6::I18n;KF6::ConfigGui;KF6::GuiAddons;KF6::IconThemes;KF6::IconWidgets;KF6::WindowSystem;KF6::ColorScheme;Qt6::DBus"
  IMPORTED_LOCATION_NOCONFIG "${_IMPORT_PREFIX}/lib/libKF6KIOWidgets.so.6.28.0"
  IMPORTED_SONAME_NOCONFIG "libKF6KIOWidgets.so.6"
  )

list(APPEND _cmake_import_check_targets KF6::KIOWidgets )
list(APPEND _cmake_import_check_files_for_KF6::KIOWidgets "${_IMPORT_PREFIX}/lib/libKF6KIOWidgets.so.6.28.0" )

# Import target "KF6::KIOFileWidgets" for configuration ""
set_property(TARGET KF6::KIOFileWidgets APPEND PROPERTY IMPORTED_CONFIGURATIONS NOCONFIG)
set_target_properties(KF6::KIOFileWidgets PROPERTIES
  IMPORTED_LINK_DEPENDENT_LIBRARIES_NOCONFIG "KF6::GuiAddons;KF6::IconThemes;KF6::IconWidgets;KF6::I18n;KF6::ConfigGui;KF6::BookmarksWidgets;KF6::ColorScheme"
  IMPORTED_LOCATION_NOCONFIG "${_IMPORT_PREFIX}/lib/libKF6KIOFileWidgets.so.6.28.0"
  IMPORTED_SONAME_NOCONFIG "libKF6KIOFileWidgets.so.6"
  )

list(APPEND _cmake_import_check_targets KF6::KIOFileWidgets )
list(APPEND _cmake_import_check_files_for_KF6::KIOFileWidgets "${_IMPORT_PREFIX}/lib/libKF6KIOFileWidgets.so.6.28.0" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
