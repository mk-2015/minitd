#----------------------------------------------------------------
# Generated CMake target import file.
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "org.kde.breeze" for configuration ""
set_property(TARGET org.kde.breeze APPEND PROPERTY IMPORTED_CONFIGURATIONS NOCONFIG)
set_target_properties(org.kde.breeze PROPERTIES
  IMPORTED_COMMON_LANGUAGE_RUNTIME_NOCONFIG ""
  IMPORTED_LOCATION_NOCONFIG "${_IMPORT_PREFIX}/lib/qt6/plugins/kf6/kirigami/platform/org.kde.breeze.so"
  IMPORTED_NO_SONAME_NOCONFIG "TRUE"
  )

list(APPEND _cmake_import_check_targets org.kde.breeze )
list(APPEND _cmake_import_check_files_for_org.kde.breeze "${_IMPORT_PREFIX}/lib/qt6/plugins/kf6/kirigami/platform/org.kde.breeze.so" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
