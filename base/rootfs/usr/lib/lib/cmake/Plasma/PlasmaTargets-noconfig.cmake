#----------------------------------------------------------------
# Generated CMake target import file.
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "Plasma::Plasma" for configuration ""
set_property(TARGET Plasma::Plasma APPEND PROPERTY IMPORTED_CONFIGURATIONS NOCONFIG)
set_target_properties(Plasma::Plasma PROPERTIES
  IMPORTED_LINK_DEPENDENT_LIBRARIES_NOCONFIG "Qt6::Quick;Qt6::WaylandClient;KF6::ConfigGui;KF6::ColorScheme;KF6::ConfigQml;KF6::I18n;KF6::WindowSystem;KF6::GlobalAccel;KF6::Notifications;KF6::IconThemes;Plasma::Activities;KF6::Svg;KF6::Package"
  IMPORTED_LOCATION_NOCONFIG "${_IMPORT_PREFIX}/lib/libPlasma.so.6.7.3"
  IMPORTED_SONAME_NOCONFIG "libPlasma.so.7"
  )

list(APPEND _cmake_import_check_targets Plasma::Plasma )
list(APPEND _cmake_import_check_files_for_Plasma::Plasma "${_IMPORT_PREFIX}/lib/libPlasma.so.6.7.3" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
