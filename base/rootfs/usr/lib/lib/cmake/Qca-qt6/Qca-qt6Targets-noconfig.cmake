#----------------------------------------------------------------
# Generated CMake target import file.
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "qca-qt6" for configuration ""
set_property(TARGET qca-qt6 APPEND PROPERTY IMPORTED_CONFIGURATIONS NOCONFIG)
set_target_properties(qca-qt6 PROPERTIES
  IMPORTED_LINK_DEPENDENT_LIBRARIES_NOCONFIG "Qt6::Core5Compat"
  IMPORTED_LOCATION_NOCONFIG "/usr/lib/libqca-qt6.so.2.3.10"
  IMPORTED_SONAME_NOCONFIG "libqca-qt6.so.2"
  )

list(APPEND _cmake_import_check_targets qca-qt6 )
list(APPEND _cmake_import_check_files_for_qca-qt6 "/usr/lib/libqca-qt6.so.2.3.10" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
