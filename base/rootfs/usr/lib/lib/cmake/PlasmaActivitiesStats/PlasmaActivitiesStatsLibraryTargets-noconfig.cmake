#----------------------------------------------------------------
# Generated CMake target import file.
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "Plasma::ActivitiesStats" for configuration ""
set_property(TARGET Plasma::ActivitiesStats APPEND PROPERTY IMPORTED_CONFIGURATIONS NOCONFIG)
set_target_properties(Plasma::ActivitiesStats PROPERTIES
  IMPORTED_LINK_DEPENDENT_LIBRARIES_NOCONFIG "Qt6::DBus;Qt6::Sql;Plasma::Activities;KF6::ConfigCore"
  IMPORTED_LOCATION_NOCONFIG "${_IMPORT_PREFIX}/lib/libPlasmaActivitiesStats.so.6.7.3"
  IMPORTED_SONAME_NOCONFIG "libPlasmaActivitiesStats.so.1"
  )

list(APPEND _cmake_import_check_targets Plasma::ActivitiesStats )
list(APPEND _cmake_import_check_files_for_Plasma::ActivitiesStats "${_IMPORT_PREFIX}/lib/libPlasmaActivitiesStats.so.6.7.3" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
