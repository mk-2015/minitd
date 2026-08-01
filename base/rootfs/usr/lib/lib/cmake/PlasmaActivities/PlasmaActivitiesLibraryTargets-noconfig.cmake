#----------------------------------------------------------------
# Generated CMake target import file.
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "Plasma::Activities" for configuration ""
set_property(TARGET Plasma::Activities APPEND PROPERTY IMPORTED_CONFIGURATIONS NOCONFIG)
set_target_properties(Plasma::Activities PROPERTIES
  IMPORTED_LINK_DEPENDENT_LIBRARIES_NOCONFIG "Qt6::DBus"
  IMPORTED_LOCATION_NOCONFIG "${_IMPORT_PREFIX}/lib/libPlasmaActivities.so.6.7.3"
  IMPORTED_SONAME_NOCONFIG "libPlasmaActivities.so.7"
  )

list(APPEND _cmake_import_check_targets Plasma::Activities )
list(APPEND _cmake_import_check_files_for_Plasma::Activities "${_IMPORT_PREFIX}/lib/libPlasmaActivities.so.6.7.3" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
