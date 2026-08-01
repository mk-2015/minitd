#----------------------------------------------------------------
# Generated CMake target import file.
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "kpmcore" for configuration ""
set_property(TARGET kpmcore APPEND PROPERTY IMPORTED_CONFIGURATIONS NOCONFIG)
set_target_properties(kpmcore PROPERTIES
  IMPORTED_LINK_DEPENDENT_LIBRARIES_NOCONFIG "Qt6::DBus;Qt6::Gui;KF6::I18n;KF6::CoreAddons;KF6::WidgetsAddons"
  IMPORTED_LOCATION_NOCONFIG "${_IMPORT_PREFIX}/lib/libkpmcore.so.26.04.3"
  IMPORTED_SONAME_NOCONFIG "libkpmcore.so.13"
  )

list(APPEND _cmake_import_check_targets kpmcore )
list(APPEND _cmake_import_check_files_for_kpmcore "${_IMPORT_PREFIX}/lib/libkpmcore.so.26.04.3" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
