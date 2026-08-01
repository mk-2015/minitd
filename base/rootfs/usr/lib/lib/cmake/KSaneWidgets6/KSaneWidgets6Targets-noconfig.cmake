#----------------------------------------------------------------
# Generated CMake target import file.
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "KSaneWidgets6" for configuration ""
set_property(TARGET KSaneWidgets6 APPEND PROPERTY IMPORTED_CONFIGURATIONS NOCONFIG)
set_target_properties(KSaneWidgets6 PROPERTIES
  IMPORTED_LINK_DEPENDENT_LIBRARIES_NOCONFIG "KF6::Wallet;KF6::I18n;KF6::WidgetsAddons;KF6::TextWidgets;KSane6::Core"
  IMPORTED_LOCATION_NOCONFIG "${_IMPORT_PREFIX}/lib/libKSaneWidgets6.so.26.04.3"
  IMPORTED_SONAME_NOCONFIG "libKSaneWidgets6.so.6"
  )

list(APPEND _cmake_import_check_targets KSaneWidgets6 )
list(APPEND _cmake_import_check_files_for_KSaneWidgets6 "${_IMPORT_PREFIX}/lib/libKSaneWidgets6.so.26.04.3" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
