#----------------------------------------------------------------
# Generated CMake target import file.
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "KF5::I18n" for configuration ""
set_property(TARGET KF5::I18n APPEND PROPERTY IMPORTED_CONFIGURATIONS NOCONFIG)
set_target_properties(KF5::I18n PROPERTIES
  IMPORTED_LOCATION_NOCONFIG "${_IMPORT_PREFIX}/lib/libKF5I18n.so.5.116.0"
  IMPORTED_SONAME_NOCONFIG "libKF5I18n.so.5"
  )

list(APPEND _cmake_import_check_targets KF5::I18n )
list(APPEND _cmake_import_check_files_for_KF5::I18n "${_IMPORT_PREFIX}/lib/libKF5I18n.so.5.116.0" )

# Import target "KF5::I18nLocaleData" for configuration ""
set_property(TARGET KF5::I18nLocaleData APPEND PROPERTY IMPORTED_CONFIGURATIONS NOCONFIG)
set_target_properties(KF5::I18nLocaleData PROPERTIES
  IMPORTED_LINK_DEPENDENT_LIBRARIES_NOCONFIG "KF5::I18n"
  IMPORTED_LOCATION_NOCONFIG "${_IMPORT_PREFIX}/lib/libKF5I18nLocaleData.so.5.116.0"
  IMPORTED_SONAME_NOCONFIG "libKF5I18nLocaleData.so.5"
  )

list(APPEND _cmake_import_check_targets KF5::I18nLocaleData )
list(APPEND _cmake_import_check_files_for_KF5::I18nLocaleData "${_IMPORT_PREFIX}/lib/libKF5I18nLocaleData.so.5.116.0" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
