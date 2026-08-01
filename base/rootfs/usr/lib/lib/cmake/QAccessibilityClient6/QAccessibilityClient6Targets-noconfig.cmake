#----------------------------------------------------------------
# Generated CMake target import file.
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "QAccessibilityClient6" for configuration ""
set_property(TARGET QAccessibilityClient6 APPEND PROPERTY IMPORTED_CONFIGURATIONS NOCONFIG)
set_target_properties(QAccessibilityClient6 PROPERTIES
  IMPORTED_LINK_DEPENDENT_LIBRARIES_NOCONFIG "Qt6::DBus"
  IMPORTED_LOCATION_NOCONFIG "${_IMPORT_PREFIX}/lib/libqaccessibilityclient-qt6.so.0.6.0"
  IMPORTED_SONAME_NOCONFIG "libqaccessibilityclient-qt6.so.0"
  )

list(APPEND _cmake_import_check_targets QAccessibilityClient6 )
list(APPEND _cmake_import_check_files_for_QAccessibilityClient6 "${_IMPORT_PREFIX}/lib/libqaccessibilityclient-qt6.so.0.6.0" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
