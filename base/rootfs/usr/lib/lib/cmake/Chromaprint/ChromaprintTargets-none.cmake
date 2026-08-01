#----------------------------------------------------------------
# Generated CMake target import file for configuration "None".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "Chromaprint::chromaprint" for configuration "None"
set_property(TARGET Chromaprint::chromaprint APPEND PROPERTY IMPORTED_CONFIGURATIONS NONE)
set_target_properties(Chromaprint::chromaprint PROPERTIES
  IMPORTED_LOCATION_NONE "${_IMPORT_PREFIX}/lib/libchromaprint.so.1.6.0"
  IMPORTED_SONAME_NONE "libchromaprint.so.1"
  )

list(APPEND _cmake_import_check_targets Chromaprint::chromaprint )
list(APPEND _cmake_import_check_files_for_Chromaprint::chromaprint "${_IMPORT_PREFIX}/lib/libchromaprint.so.1.6.0" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
