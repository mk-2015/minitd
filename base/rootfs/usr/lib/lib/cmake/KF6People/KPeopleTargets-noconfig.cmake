#----------------------------------------------------------------
# Generated CMake target import file.
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "KF6::PeopleWidgets" for configuration ""
set_property(TARGET KF6::PeopleWidgets APPEND PROPERTY IMPORTED_CONFIGURATIONS NOCONFIG)
set_target_properties(KF6::PeopleWidgets PROPERTIES
  IMPORTED_LINK_DEPENDENT_LIBRARIES_NOCONFIG "KF6::I18n;KF6::ItemViews;KF6::WidgetsAddons;KF6::PeopleBackend;KF6::CoreAddons"
  IMPORTED_LOCATION_NOCONFIG "${_IMPORT_PREFIX}/lib/libKF6PeopleWidgets.so.6.28.0"
  IMPORTED_SONAME_NOCONFIG "libKF6PeopleWidgets.so.6"
  )

list(APPEND _cmake_import_check_targets KF6::PeopleWidgets )
list(APPEND _cmake_import_check_files_for_KF6::PeopleWidgets "${_IMPORT_PREFIX}/lib/libKF6PeopleWidgets.so.6.28.0" )

# Import target "KF6::PeopleBackend" for configuration ""
set_property(TARGET KF6::PeopleBackend APPEND PROPERTY IMPORTED_CONFIGURATIONS NOCONFIG)
set_target_properties(KF6::PeopleBackend PROPERTIES
  IMPORTED_LOCATION_NOCONFIG "${_IMPORT_PREFIX}/lib/libKF6PeopleBackend.so.6.28.0"
  IMPORTED_SONAME_NOCONFIG "libKF6PeopleBackend.so.6"
  )

list(APPEND _cmake_import_check_targets KF6::PeopleBackend )
list(APPEND _cmake_import_check_files_for_KF6::PeopleBackend "${_IMPORT_PREFIX}/lib/libKF6PeopleBackend.so.6.28.0" )

# Import target "KF6::People" for configuration ""
set_property(TARGET KF6::People APPEND PROPERTY IMPORTED_CONFIGURATIONS NOCONFIG)
set_target_properties(KF6::People PROPERTIES
  IMPORTED_LINK_DEPENDENT_LIBRARIES_NOCONFIG "Qt6::Sql;KF6::I18n;KF6::CoreAddons;KF6::PeopleBackend;Qt6::DBus"
  IMPORTED_LOCATION_NOCONFIG "${_IMPORT_PREFIX}/lib/libKF6People.so.6.28.0"
  IMPORTED_SONAME_NOCONFIG "libKF6People.so.6"
  )

list(APPEND _cmake_import_check_targets KF6::People )
list(APPEND _cmake_import_check_files_for_KF6::People "${_IMPORT_PREFIX}/lib/libKF6People.so.6.28.0" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
