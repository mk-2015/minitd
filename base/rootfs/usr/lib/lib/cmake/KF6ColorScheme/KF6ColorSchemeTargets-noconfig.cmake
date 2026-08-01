#----------------------------------------------------------------
# Generated CMake target import file.
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "KF6::ColorScheme" for configuration ""
set_property(TARGET KF6::ColorScheme APPEND PROPERTY IMPORTED_CONFIGURATIONS NOCONFIG)
set_target_properties(KF6::ColorScheme PROPERTIES
  IMPORTED_LINK_DEPENDENT_LIBRARIES_NOCONFIG "KF6::ConfigGui;KF6::GuiAddons;KF6::I18n"
  IMPORTED_LOCATION_NOCONFIG "${_IMPORT_PREFIX}/lib/libKF6ColorScheme.so.6.28.0"
  IMPORTED_SONAME_NOCONFIG "libKF6ColorScheme.so.6"
  )

list(APPEND _cmake_import_check_targets KF6::ColorScheme )
list(APPEND _cmake_import_check_files_for_KF6::ColorScheme "${_IMPORT_PREFIX}/lib/libKF6ColorScheme.so.6.28.0" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
