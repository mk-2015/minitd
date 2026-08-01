#----------------------------------------------------------------
# Generated CMake target import file.
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "KF6::BookmarksWidgets" for configuration ""
set_property(TARGET KF6::BookmarksWidgets APPEND PROPERTY IMPORTED_CONFIGURATIONS NOCONFIG)
set_target_properties(KF6::BookmarksWidgets PROPERTIES
  IMPORTED_LINK_DEPENDENT_LIBRARIES_NOCONFIG "KF6::ConfigCore;KF6::ConfigGui"
  IMPORTED_LOCATION_NOCONFIG "${_IMPORT_PREFIX}/lib/libKF6BookmarksWidgets.so.6.28.0"
  IMPORTED_SONAME_NOCONFIG "libKF6BookmarksWidgets.so.6"
  )

list(APPEND _cmake_import_check_targets KF6::BookmarksWidgets )
list(APPEND _cmake_import_check_files_for_KF6::BookmarksWidgets "${_IMPORT_PREFIX}/lib/libKF6BookmarksWidgets.so.6.28.0" )

# Import target "KF6::Bookmarks" for configuration ""
set_property(TARGET KF6::Bookmarks APPEND PROPERTY IMPORTED_CONFIGURATIONS NOCONFIG)
set_target_properties(KF6::Bookmarks PROPERTIES
  IMPORTED_LINK_DEPENDENT_LIBRARIES_NOCONFIG "KF6::CoreAddons;KF6::ConfigCore"
  IMPORTED_LOCATION_NOCONFIG "${_IMPORT_PREFIX}/lib/libKF6Bookmarks.so.6.28.0"
  IMPORTED_SONAME_NOCONFIG "libKF6Bookmarks.so.6"
  )

list(APPEND _cmake_import_check_targets KF6::Bookmarks )
list(APPEND _cmake_import_check_files_for_KF6::Bookmarks "${_IMPORT_PREFIX}/lib/libKF6Bookmarks.so.6.28.0" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
