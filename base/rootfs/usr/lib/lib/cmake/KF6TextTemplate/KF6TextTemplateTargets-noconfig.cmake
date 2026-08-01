#----------------------------------------------------------------
# Generated CMake target import file.
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "KF6::TextTemplate" for configuration ""
set_property(TARGET KF6::TextTemplate APPEND PROPERTY IMPORTED_CONFIGURATIONS NOCONFIG)
set_target_properties(KF6::TextTemplate PROPERTIES
  IMPORTED_LINK_DEPENDENT_LIBRARIES_NOCONFIG "Qt6::Qml"
  IMPORTED_LOCATION_NOCONFIG "${_IMPORT_PREFIX}/lib/libKF6TextTemplate.so.6.28.0"
  IMPORTED_SONAME_NOCONFIG "libKF6TextTemplate.so.6"
  )

list(APPEND _cmake_import_check_targets KF6::TextTemplate )
list(APPEND _cmake_import_check_files_for_KF6::TextTemplate "${_IMPORT_PREFIX}/lib/libKF6TextTemplate.so.6.28.0" )

# Import target "KF6::loadertags" for configuration ""
set_property(TARGET KF6::loadertags APPEND PROPERTY IMPORTED_CONFIGURATIONS NOCONFIG)
set_target_properties(KF6::loadertags PROPERTIES
  IMPORTED_COMMON_LANGUAGE_RUNTIME_NOCONFIG ""
  IMPORTED_LOCATION_NOCONFIG "${_IMPORT_PREFIX}/lib/qt6/plugins/kf6/ktexttemplate/ktexttemplate_loadertags.so"
  IMPORTED_NO_SONAME_NOCONFIG "TRUE"
  )

list(APPEND _cmake_import_check_targets KF6::loadertags )
list(APPEND _cmake_import_check_files_for_KF6::loadertags "${_IMPORT_PREFIX}/lib/qt6/plugins/kf6/ktexttemplate/ktexttemplate_loadertags.so" )

# Import target "KF6::defaulttags" for configuration ""
set_property(TARGET KF6::defaulttags APPEND PROPERTY IMPORTED_CONFIGURATIONS NOCONFIG)
set_target_properties(KF6::defaulttags PROPERTIES
  IMPORTED_COMMON_LANGUAGE_RUNTIME_NOCONFIG ""
  IMPORTED_LOCATION_NOCONFIG "${_IMPORT_PREFIX}/lib/qt6/plugins/kf6/ktexttemplate/ktexttemplate_defaulttags.so"
  IMPORTED_NO_SONAME_NOCONFIG "TRUE"
  )

list(APPEND _cmake_import_check_targets KF6::defaulttags )
list(APPEND _cmake_import_check_files_for_KF6::defaulttags "${_IMPORT_PREFIX}/lib/qt6/plugins/kf6/ktexttemplate/ktexttemplate_defaulttags.so" )

# Import target "KF6::defaultfilters" for configuration ""
set_property(TARGET KF6::defaultfilters APPEND PROPERTY IMPORTED_CONFIGURATIONS NOCONFIG)
set_target_properties(KF6::defaultfilters PROPERTIES
  IMPORTED_COMMON_LANGUAGE_RUNTIME_NOCONFIG ""
  IMPORTED_LOCATION_NOCONFIG "${_IMPORT_PREFIX}/lib/qt6/plugins/kf6/ktexttemplate/ktexttemplate_defaultfilters.so"
  IMPORTED_NO_SONAME_NOCONFIG "TRUE"
  )

list(APPEND _cmake_import_check_targets KF6::defaultfilters )
list(APPEND _cmake_import_check_files_for_KF6::defaultfilters "${_IMPORT_PREFIX}/lib/qt6/plugins/kf6/ktexttemplate/ktexttemplate_defaultfilters.so" )

# Import target "KF6::i18ntags" for configuration ""
set_property(TARGET KF6::i18ntags APPEND PROPERTY IMPORTED_CONFIGURATIONS NOCONFIG)
set_target_properties(KF6::i18ntags PROPERTIES
  IMPORTED_COMMON_LANGUAGE_RUNTIME_NOCONFIG ""
  IMPORTED_LOCATION_NOCONFIG "${_IMPORT_PREFIX}/lib/qt6/plugins/kf6/ktexttemplate/ktexttemplate_i18ntags.so"
  IMPORTED_NO_SONAME_NOCONFIG "TRUE"
  )

list(APPEND _cmake_import_check_targets KF6::i18ntags )
list(APPEND _cmake_import_check_files_for_KF6::i18ntags "${_IMPORT_PREFIX}/lib/qt6/plugins/kf6/ktexttemplate/ktexttemplate_i18ntags.so" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
