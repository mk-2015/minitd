#----------------------------------------------------------------
# Generated CMake target import file.
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "K::KGlobalAccelD" for configuration ""
set_property(TARGET K::KGlobalAccelD APPEND PROPERTY IMPORTED_CONFIGURATIONS NOCONFIG)
set_target_properties(K::KGlobalAccelD PROPERTIES
  IMPORTED_LINK_DEPENDENT_LIBRARIES_NOCONFIG "Qt6::DBus;KF6::WindowSystem;KF6::CoreAddons;KF6::ConfigCore;KF6::Service;KF6::KIOGui;KF6::JobWidgets"
  IMPORTED_LOCATION_NOCONFIG "${_IMPORT_PREFIX}/lib/libKGlobalAccelD.so.6.7.3"
  IMPORTED_SONAME_NOCONFIG "libKGlobalAccelD.so.0"
  )

list(APPEND _cmake_import_check_targets K::KGlobalAccelD )
list(APPEND _cmake_import_check_files_for_K::KGlobalAccelD "${_IMPORT_PREFIX}/lib/libKGlobalAccelD.so.6.7.3" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
