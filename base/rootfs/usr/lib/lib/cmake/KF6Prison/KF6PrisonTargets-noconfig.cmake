#----------------------------------------------------------------
# Generated CMake target import file.
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "KF6::Prison" for configuration ""
set_property(TARGET KF6::Prison APPEND PROPERTY IMPORTED_CONFIGURATIONS NOCONFIG)
set_target_properties(KF6::Prison PROPERTIES
  IMPORTED_LINK_DEPENDENT_LIBRARIES_NOCONFIG "ZXing::ZXing"
  IMPORTED_LOCATION_NOCONFIG "${_IMPORT_PREFIX}/lib/libKF6Prison.so.6.28.0"
  IMPORTED_SONAME_NOCONFIG "libKF6Prison.so.6"
  )

list(APPEND _cmake_import_check_targets KF6::Prison )
list(APPEND _cmake_import_check_files_for_KF6::Prison "${_IMPORT_PREFIX}/lib/libKF6Prison.so.6.28.0" )

# Import target "KF6::PrisonScanner" for configuration ""
set_property(TARGET KF6::PrisonScanner APPEND PROPERTY IMPORTED_CONFIGURATIONS NOCONFIG)
set_target_properties(KF6::PrisonScanner PROPERTIES
  IMPORTED_LINK_DEPENDENT_LIBRARIES_NOCONFIG "Qt6::Core;ZXing::ZXing"
  IMPORTED_LOCATION_NOCONFIG "${_IMPORT_PREFIX}/lib/libKF6PrisonScanner.so.6.28.0"
  IMPORTED_SONAME_NOCONFIG "libKF6PrisonScanner.so.6"
  )

list(APPEND _cmake_import_check_targets KF6::PrisonScanner )
list(APPEND _cmake_import_check_files_for_KF6::PrisonScanner "${_IMPORT_PREFIX}/lib/libKF6PrisonScanner.so.6.28.0" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
