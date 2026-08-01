#----------------------------------------------------------------
# Generated CMake target import file for configuration "None".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "Verdict::verdict" for configuration "None"
set_property(TARGET Verdict::verdict APPEND PROPERTY IMPORTED_CONFIGURATIONS NONE)
set_target_properties(Verdict::verdict PROPERTIES
  IMPORTED_LOCATION_NONE "${_IMPORT_PREFIX}/lib/libverdict.so.1.4.5"
  IMPORTED_SONAME_NONE "libverdict.so.1.4"
  )

list(APPEND _cmake_import_check_targets Verdict::verdict )
list(APPEND _cmake_import_check_files_for_Verdict::verdict "${_IMPORT_PREFIX}/lib/libverdict.so.1.4.5" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
