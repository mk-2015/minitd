#----------------------------------------------------------------
# Generated CMake target import file.
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "PW::krdb" for configuration ""
set_property(TARGET PW::krdb APPEND PROPERTY IMPORTED_CONFIGURATIONS NOCONFIG)
set_target_properties(PW::krdb PROPERTIES
  IMPORTED_LINK_DEPENDENT_LIBRARIES_NOCONFIG "Qt6::Widgets;Qt6::DBus;KF6::CoreAddons;KF6::DBusAddons;KF6::GuiAddons;KF6::I18n;KF6::WindowSystem;KF6::ColorScheme"
  IMPORTED_LOCATION_NOCONFIG "${_IMPORT_PREFIX}/lib/libkrdb.so"
  IMPORTED_SONAME_NOCONFIG "libkrdb.so"
  )

list(APPEND _cmake_import_check_targets PW::krdb )
list(APPEND _cmake_import_check_files_for_PW::krdb "${_IMPORT_PREFIX}/lib/libkrdb.so" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
