#----------------------------------------------------------------
# Generated CMake target import file.
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "LayerShellQt::Interface" for configuration ""
set_property(TARGET LayerShellQt::Interface APPEND PROPERTY IMPORTED_CONFIGURATIONS NOCONFIG)
set_target_properties(LayerShellQt::Interface PROPERTIES
  IMPORTED_LOCATION_NOCONFIG "${_IMPORT_PREFIX}/lib/libLayerShellQtInterface.so.6.7.3"
  IMPORTED_SONAME_NOCONFIG "libLayerShellQtInterface.so.6"
  )

list(APPEND _cmake_import_check_targets LayerShellQt::Interface )
list(APPEND _cmake_import_check_files_for_LayerShellQt::Interface "${_IMPORT_PREFIX}/lib/libLayerShellQtInterface.so.6.7.3" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
