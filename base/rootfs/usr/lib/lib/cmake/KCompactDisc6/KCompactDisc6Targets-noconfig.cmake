#----------------------------------------------------------------
# Generated CMake target import file.
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "KCompactDisc6" for configuration ""
set_property(TARGET KCompactDisc6 APPEND PROPERTY IMPORTED_CONFIGURATIONS NOCONFIG)
set_target_properties(KCompactDisc6 PROPERTIES
  IMPORTED_LINK_DEPENDENT_LIBRARIES_NOCONFIG "Qt6::DBus;KF6::Solid;KF6::I18n;Phonon::phonon4qt6"
  IMPORTED_LOCATION_NOCONFIG "${_IMPORT_PREFIX}/lib/libKCompactDisc6.so.5.0.0"
  IMPORTED_SONAME_NOCONFIG "libKCompactDisc6.so.5"
  )

list(APPEND _cmake_import_check_targets KCompactDisc6 )
list(APPEND _cmake_import_check_files_for_KCompactDisc6 "${_IMPORT_PREFIX}/lib/libKCompactDisc6.so.5.0.0" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
