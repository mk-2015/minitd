#----------------------------------------------------------------
# Generated CMake target import file.
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "KF6::TextWidgets" for configuration ""
set_property(TARGET KF6::TextWidgets APPEND PROPERTY IMPORTED_CONFIGURATIONS NOCONFIG)
set_target_properties(KF6::TextWidgets PROPERTIES
  IMPORTED_LINK_DEPENDENT_LIBRARIES_NOCONFIG "KF6::SonnetCore;KF6::WidgetsAddons;KF6::Completion;KF6::ConfigGui;Qt6::TextToSpeech"
  IMPORTED_LOCATION_NOCONFIG "${_IMPORT_PREFIX}/lib/libKF6TextWidgets.so.6.28.0"
  IMPORTED_SONAME_NOCONFIG "libKF6TextWidgets.so.6"
  )

list(APPEND _cmake_import_check_targets KF6::TextWidgets )
list(APPEND _cmake_import_check_files_for_KF6::TextWidgets "${_IMPORT_PREFIX}/lib/libKF6TextWidgets.so.6.28.0" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
