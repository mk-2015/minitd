#----------------------------------------------------------------
# Generated CMake target import file.
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "Plasma::Weather::Data" for configuration ""
set_property(TARGET Plasma::Weather::Data APPEND PROPERTY IMPORTED_CONFIGURATIONS NOCONFIG)
set_target_properties(Plasma::Weather::Data PROPERTIES
  IMPORTED_LINK_DEPENDENT_LIBRARIES_NOCONFIG "Qt6::Core;KF6::I18n;KF6::UnitConversion;Qt6::Qml"
  IMPORTED_LOCATION_NOCONFIG "${_IMPORT_PREFIX}/lib/libplasmaweatherdata.so.6.7.3"
  IMPORTED_SONAME_NOCONFIG "libplasmaweatherdata.so.6"
  )

list(APPEND _cmake_import_check_targets Plasma::Weather::Data )
list(APPEND _cmake_import_check_files_for_Plasma::Weather::Data "${_IMPORT_PREFIX}/lib/libplasmaweatherdata.so.6.7.3" )

# Import target "Plasma::Weather::Ion" for configuration ""
set_property(TARGET Plasma::Weather::Ion APPEND PROPERTY IMPORTED_CONFIGURATIONS NOCONFIG)
set_target_properties(Plasma::Weather::Ion PROPERTIES
  IMPORTED_LOCATION_NOCONFIG "${_IMPORT_PREFIX}/lib/libplasmaweatherion.so.6.7.3"
  IMPORTED_SONAME_NOCONFIG "libplasmaweatherion.so.6"
  )

list(APPEND _cmake_import_check_targets Plasma::Weather::Ion )
list(APPEND _cmake_import_check_files_for_Plasma::Weather::Ion "${_IMPORT_PREFIX}/lib/libplasmaweatherion.so.6.7.3" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
