#----------------------------------------------------------------
# Generated CMake target import file.
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "KF6::Purpose" for configuration ""
set_property(TARGET KF6::Purpose APPEND PROPERTY IMPORTED_CONFIGURATIONS NOCONFIG)
set_target_properties(KF6::Purpose PROPERTIES
  IMPORTED_LINK_DEPENDENT_LIBRARIES_NOCONFIG "Qt6::Network;KF6::ConfigCore;Qt6::DBus"
  IMPORTED_LOCATION_NOCONFIG "${_IMPORT_PREFIX}/lib/libKF6Purpose.so.6.28.0"
  IMPORTED_SONAME_NOCONFIG "libKF6Purpose.so.6"
  )

list(APPEND _cmake_import_check_targets KF6::Purpose )
list(APPEND _cmake_import_check_files_for_KF6::Purpose "${_IMPORT_PREFIX}/lib/libKF6Purpose.so.6.28.0" )

# Import target "KF6::PurposeWidgets" for configuration ""
set_property(TARGET KF6::PurposeWidgets APPEND PROPERTY IMPORTED_CONFIGURATIONS NOCONFIG)
set_target_properties(KF6::PurposeWidgets PROPERTIES
  IMPORTED_LINK_DEPENDENT_LIBRARIES_NOCONFIG "Qt6::Qml;Qt6::Core;KF6::I18n;KF6::I18nQml"
  IMPORTED_LOCATION_NOCONFIG "${_IMPORT_PREFIX}/lib/libKF6PurposeWidgets.so.6.28.0"
  IMPORTED_SONAME_NOCONFIG "libKF6PurposeWidgets.so.6"
  )

list(APPEND _cmake_import_check_targets KF6::PurposeWidgets )
list(APPEND _cmake_import_check_files_for_KF6::PurposeWidgets "${_IMPORT_PREFIX}/lib/libKF6PurposeWidgets.so.6.28.0" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
