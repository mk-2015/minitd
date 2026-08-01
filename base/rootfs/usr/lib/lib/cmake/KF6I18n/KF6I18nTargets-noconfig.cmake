#----------------------------------------------------------------
# Generated CMake target import file.
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "KF6::I18n" for configuration ""
set_property(TARGET KF6::I18n APPEND PROPERTY IMPORTED_CONFIGURATIONS NOCONFIG)
set_target_properties(KF6::I18n PROPERTIES
  IMPORTED_LOCATION_NOCONFIG "${_IMPORT_PREFIX}/lib/libKF6I18n.so.6.28.0"
  IMPORTED_SONAME_NOCONFIG "libKF6I18n.so.6"
  )

list(APPEND _cmake_import_check_targets KF6::I18n )
list(APPEND _cmake_import_check_files_for_KF6::I18n "${_IMPORT_PREFIX}/lib/libKF6I18n.so.6.28.0" )

# Import target "KF6::I18nLocaleData" for configuration ""
set_property(TARGET KF6::I18nLocaleData APPEND PROPERTY IMPORTED_CONFIGURATIONS NOCONFIG)
set_target_properties(KF6::I18nLocaleData PROPERTIES
  IMPORTED_LINK_DEPENDENT_LIBRARIES_NOCONFIG "KF6::I18n"
  IMPORTED_LOCATION_NOCONFIG "${_IMPORT_PREFIX}/lib/libKF6I18nLocaleData.so.6.28.0"
  IMPORTED_SONAME_NOCONFIG "libKF6I18nLocaleData.so.6"
  )

list(APPEND _cmake_import_check_targets KF6::I18nLocaleData )
list(APPEND _cmake_import_check_files_for_KF6::I18nLocaleData "${_IMPORT_PREFIX}/lib/libKF6I18nLocaleData.so.6.28.0" )

# Import target "KF6::I18nQml" for configuration ""
set_property(TARGET KF6::I18nQml APPEND PROPERTY IMPORTED_CONFIGURATIONS NOCONFIG)
set_target_properties(KF6::I18nQml PROPERTIES
  IMPORTED_LINK_DEPENDENT_LIBRARIES_NOCONFIG "Qt6::Qml;KF6::I18n"
  IMPORTED_LOCATION_NOCONFIG "${_IMPORT_PREFIX}/lib/libKF6I18nQml.so.6.28.0"
  IMPORTED_SONAME_NOCONFIG "libKF6I18nQml.so.6"
  )

list(APPEND _cmake_import_check_targets KF6::I18nQml )
list(APPEND _cmake_import_check_files_for_KF6::I18nQml "${_IMPORT_PREFIX}/lib/libKF6I18nQml.so.6.28.0" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
