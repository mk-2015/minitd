#----------------------------------------------------------------
# Generated CMake target import file.
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "KF6::meinproc6" for configuration ""
set_property(TARGET KF6::meinproc6 APPEND PROPERTY IMPORTED_CONFIGURATIONS NOCONFIG)
set_target_properties(KF6::meinproc6 PROPERTIES
  IMPORTED_LOCATION_NOCONFIG "${_IMPORT_PREFIX}/bin/meinproc6"
  )

list(APPEND _cmake_import_check_targets KF6::meinproc6 )
list(APPEND _cmake_import_check_files_for_KF6::meinproc6 "${_IMPORT_PREFIX}/bin/meinproc6" )

# Import target "KF6::checkXML6" for configuration ""
set_property(TARGET KF6::checkXML6 APPEND PROPERTY IMPORTED_CONFIGURATIONS NOCONFIG)
set_target_properties(KF6::checkXML6 PROPERTIES
  IMPORTED_LOCATION_NOCONFIG "${_IMPORT_PREFIX}/bin/checkXML6"
  )

list(APPEND _cmake_import_check_targets KF6::checkXML6 )
list(APPEND _cmake_import_check_files_for_KF6::checkXML6 "${_IMPORT_PREFIX}/bin/checkXML6" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
