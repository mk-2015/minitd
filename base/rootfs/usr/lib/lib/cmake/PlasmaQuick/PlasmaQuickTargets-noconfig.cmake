#----------------------------------------------------------------
# Generated CMake target import file.
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "Plasma::PlasmaQuick" for configuration ""
set_property(TARGET Plasma::PlasmaQuick APPEND PROPERTY IMPORTED_CONFIGURATIONS NOCONFIG)
set_target_properties(Plasma::PlasmaQuick PROPERTIES
  IMPORTED_LINK_DEPENDENT_LIBRARIES_NOCONFIG "Qt6::Svg;Qt6::WaylandClient;KF6::ConfigGui;KF6::ConfigQml;KF6::I18n;KF6::IconThemes;KF6::CoreAddons;KF6::Package;KF6::KIOCore;KF6::KIOWidgets;KF6::Notifications;KF6::Svg;KF6::GuiAddons;KF6::I18nQml"
  IMPORTED_LOCATION_NOCONFIG "${_IMPORT_PREFIX}/lib/libPlasmaQuick.so.6.7.3"
  IMPORTED_SONAME_NOCONFIG "libPlasmaQuick.so.7"
  )

list(APPEND _cmake_import_check_targets Plasma::PlasmaQuick )
list(APPEND _cmake_import_check_files_for_Plasma::PlasmaQuick "${_IMPORT_PREFIX}/lib/libPlasmaQuick.so.6.7.3" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
