#----------------------------------------------------------------
# Generated CMake target import file.
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "Plasma::Plasma5Support" for configuration ""
set_property(TARGET Plasma::Plasma5Support APPEND PROPERTY IMPORTED_CONFIGURATIONS NOCONFIG)
set_target_properties(Plasma::Plasma5Support PROPERTIES
  IMPORTED_LINK_DEPENDENT_LIBRARIES_NOCONFIG "Qt6::Gui;Qt6::Sql;Qt6::Widgets;KF6::I18n;KF6::ConfigGui"
  IMPORTED_LOCATION_NOCONFIG "${_IMPORT_PREFIX}/lib/libPlasma5Support.so.6.7.3"
  IMPORTED_SONAME_NOCONFIG "libPlasma5Support.so.6"
  )

list(APPEND _cmake_import_check_targets Plasma::Plasma5Support )
list(APPEND _cmake_import_check_files_for_Plasma::Plasma5Support "${_IMPORT_PREFIX}/lib/libPlasma5Support.so.6.7.3" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
