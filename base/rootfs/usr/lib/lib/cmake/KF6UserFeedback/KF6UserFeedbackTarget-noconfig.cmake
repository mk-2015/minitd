#----------------------------------------------------------------
# Generated CMake target import file.
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "KF6::UserFeedbackCore" for configuration ""
set_property(TARGET KF6::UserFeedbackCore APPEND PROPERTY IMPORTED_CONFIGURATIONS NOCONFIG)
set_target_properties(KF6::UserFeedbackCore PROPERTIES
  IMPORTED_LINK_DEPENDENT_LIBRARIES_NOCONFIG "Qt6::Gui;Qt6::Network"
  IMPORTED_LOCATION_NOCONFIG "${_IMPORT_PREFIX}/lib/libKF6UserFeedbackCore.so.6.28.0"
  IMPORTED_SONAME_NOCONFIG "libKF6UserFeedbackCore.so.6"
  )

list(APPEND _cmake_import_check_targets KF6::UserFeedbackCore )
list(APPEND _cmake_import_check_files_for_KF6::UserFeedbackCore "${_IMPORT_PREFIX}/lib/libKF6UserFeedbackCore.so.6.28.0" )

# Import target "KF6::UserFeedbackWidgets" for configuration ""
set_property(TARGET KF6::UserFeedbackWidgets APPEND PROPERTY IMPORTED_CONFIGURATIONS NOCONFIG)
set_target_properties(KF6::UserFeedbackWidgets PROPERTIES
  IMPORTED_LOCATION_NOCONFIG "${_IMPORT_PREFIX}/lib/libKF6UserFeedbackWidgets.so.6.28.0"
  IMPORTED_SONAME_NOCONFIG "libKF6UserFeedbackWidgets.so.6"
  )

list(APPEND _cmake_import_check_targets KF6::UserFeedbackWidgets )
list(APPEND _cmake_import_check_files_for_KF6::UserFeedbackWidgets "${_IMPORT_PREFIX}/lib/libKF6UserFeedbackWidgets.so.6.28.0" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
