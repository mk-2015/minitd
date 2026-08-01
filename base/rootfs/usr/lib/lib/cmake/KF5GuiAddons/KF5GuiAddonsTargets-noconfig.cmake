#----------------------------------------------------------------
# Generated CMake target import file.
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "KF5::GuiAddons" for configuration ""
set_property(TARGET KF5::GuiAddons APPEND PROPERTY IMPORTED_CONFIGURATIONS NOCONFIG)
set_target_properties(KF5::GuiAddons PROPERTIES
  IMPORTED_LINK_DEPENDENT_LIBRARIES_NOCONFIG "Qt5::DBus;Qt5::WaylandClient;Qt5::X11Extras"
  IMPORTED_LOCATION_NOCONFIG "${_IMPORT_PREFIX}/lib/libKF5GuiAddons.so.5.116.0"
  IMPORTED_SONAME_NOCONFIG "libKF5GuiAddons.so.5"
  )

list(APPEND _cmake_import_check_targets KF5::GuiAddons )
list(APPEND _cmake_import_check_files_for_KF5::GuiAddons "${_IMPORT_PREFIX}/lib/libKF5GuiAddons.so.5.116.0" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
