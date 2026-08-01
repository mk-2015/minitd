#----------------------------------------------------------------
# Generated CMake target import file.
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "PW::KScreenLocker" for configuration ""
set_property(TARGET PW::KScreenLocker APPEND PROPERTY IMPORTED_CONFIGURATIONS NOCONFIG)
set_target_properties(PW::KScreenLocker PROPERTIES
  IMPORTED_LINK_DEPENDENT_LIBRARIES_NOCONFIG "Qt6::DBus;KF6::I18n;KF6::IdleTime;KF6::GlobalAccel;KF6::Notifications;KF6::CoreAddons;KF6::ConfigGui;KF6::Package;KF6::WindowSystem"
  IMPORTED_LOCATION_NOCONFIG "${_IMPORT_PREFIX}/lib/libKScreenLocker.so.6.7.3"
  IMPORTED_SONAME_NOCONFIG "libKScreenLocker.so.6"
  )

list(APPEND _cmake_import_check_targets PW::KScreenLocker )
list(APPEND _cmake_import_check_files_for_PW::KScreenLocker "${_IMPORT_PREFIX}/lib/libKScreenLocker.so.6.7.3" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
