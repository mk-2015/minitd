#----------------------------------------------------------------
# Generated CMake target import file for configuration "None".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "mysofa::mysofa-static" for configuration "None"
set_property(TARGET mysofa::mysofa-static APPEND PROPERTY IMPORTED_CONFIGURATIONS NONE)
set_target_properties(mysofa::mysofa-static PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_NONE "C"
  IMPORTED_LOCATION_NONE "${_IMPORT_PREFIX}/lib/libmysofa.a"
  )

list(APPEND _cmake_import_check_targets mysofa::mysofa-static )
list(APPEND _cmake_import_check_files_for_mysofa::mysofa-static "${_IMPORT_PREFIX}/lib/libmysofa.a" )

# Import target "mysofa::mysofa-shared" for configuration "None"
set_property(TARGET mysofa::mysofa-shared APPEND PROPERTY IMPORTED_CONFIGURATIONS NONE)
set_target_properties(mysofa::mysofa-shared PROPERTIES
  IMPORTED_LOCATION_NONE "${_IMPORT_PREFIX}/lib/libmysofa.so.1.3.3"
  IMPORTED_SONAME_NONE "libmysofa.so.1"
  )

list(APPEND _cmake_import_check_targets mysofa::mysofa-shared )
list(APPEND _cmake_import_check_files_for_mysofa::mysofa-shared "${_IMPORT_PREFIX}/lib/libmysofa.so.1.3.3" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
