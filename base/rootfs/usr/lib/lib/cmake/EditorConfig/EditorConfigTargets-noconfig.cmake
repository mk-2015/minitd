#----------------------------------------------------------------
# Generated CMake target import file.
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "editorconfig_static" for configuration ""
set_property(TARGET editorconfig_static APPEND PROPERTY IMPORTED_CONFIGURATIONS NOCONFIG)
set_target_properties(editorconfig_static PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_NOCONFIG "C"
  IMPORTED_LOCATION_NOCONFIG "${_IMPORT_PREFIX}/lib/libeditorconfig_static.a"
  )

list(APPEND _cmake_import_check_targets editorconfig_static )
list(APPEND _cmake_import_check_files_for_editorconfig_static "${_IMPORT_PREFIX}/lib/libeditorconfig_static.a" )

# Import target "editorconfig_shared" for configuration ""
set_property(TARGET editorconfig_shared APPEND PROPERTY IMPORTED_CONFIGURATIONS NOCONFIG)
set_target_properties(editorconfig_shared PROPERTIES
  IMPORTED_LOCATION_NOCONFIG "${_IMPORT_PREFIX}/lib/libeditorconfig.so.0.12.11"
  IMPORTED_SONAME_NOCONFIG "libeditorconfig.so.0"
  )

list(APPEND _cmake_import_check_targets editorconfig_shared )
list(APPEND _cmake_import_check_files_for_editorconfig_shared "${_IMPORT_PREFIX}/lib/libeditorconfig.so.0.12.11" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
