#----------------------------------------------------------------
# Generated CMake target import file.
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "KF6::KCMUtilsCore" for configuration ""
set_property(TARGET KF6::KCMUtilsCore APPEND PROPERTY IMPORTED_CONFIGURATIONS NOCONFIG)
set_target_properties(KF6::KCMUtilsCore PROPERTIES
  IMPORTED_LINK_DEPENDENT_LIBRARIES_NOCONFIG "KF6::ConfigCore;KF6::ItemViews"
  IMPORTED_LOCATION_NOCONFIG "${_IMPORT_PREFIX}/lib/libKF6KCMUtilsCore.so.6.28.0"
  IMPORTED_SONAME_NOCONFIG "libKF6KCMUtilsCore.so.6"
  )

list(APPEND _cmake_import_check_targets KF6::KCMUtilsCore )
list(APPEND _cmake_import_check_files_for_KF6::KCMUtilsCore "${_IMPORT_PREFIX}/lib/libKF6KCMUtilsCore.so.6.28.0" )

# Import target "KF6::KCMUtilsQuick" for configuration ""
set_property(TARGET KF6::KCMUtilsQuick APPEND PROPERTY IMPORTED_CONFIGURATIONS NOCONFIG)
set_target_properties(KF6::KCMUtilsQuick PROPERTIES
  IMPORTED_LINK_DEPENDENT_LIBRARIES_NOCONFIG "KF6::I18n;KF6::ConfigGui;Qt6::Quick;KF6::I18nQml"
  IMPORTED_LOCATION_NOCONFIG "${_IMPORT_PREFIX}/lib/libKF6KCMUtilsQuick.so.6.28.0"
  IMPORTED_SONAME_NOCONFIG "libKF6KCMUtilsQuick.so.6"
  )

list(APPEND _cmake_import_check_targets KF6::KCMUtilsQuick )
list(APPEND _cmake_import_check_files_for_KF6::KCMUtilsQuick "${_IMPORT_PREFIX}/lib/libKF6KCMUtilsQuick.so.6.28.0" )

# Import target "KF6::KCMUtils" for configuration ""
set_property(TARGET KF6::KCMUtils APPEND PROPERTY IMPORTED_CONFIGURATIONS NOCONFIG)
set_target_properties(KF6::KCMUtils PROPERTIES
  IMPORTED_LINK_DEPENDENT_LIBRARIES_NOCONFIG "Qt6::Qml;Qt6::Quick;Qt6::QuickWidgets;KF6::GuiAddons;KF6::I18n;KF6::ItemViews;KF6::XmlGui"
  IMPORTED_LOCATION_NOCONFIG "${_IMPORT_PREFIX}/lib/libKF6KCMUtils.so.6.28.0"
  IMPORTED_SONAME_NOCONFIG "libKF6KCMUtils.so.6"
  )

list(APPEND _cmake_import_check_targets KF6::KCMUtils )
list(APPEND _cmake_import_check_files_for_KF6::KCMUtils "${_IMPORT_PREFIX}/lib/libKF6KCMUtils.so.6.28.0" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
