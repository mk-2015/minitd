#----------------------------------------------------------------
# Generated CMake target import file.
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "KSane6::Core" for configuration ""
set_property(TARGET KSane6::Core APPEND PROPERTY IMPORTED_CONFIGURATIONS NOCONFIG)
set_target_properties(KSane6::Core PROPERTIES
  IMPORTED_LINK_DEPENDENT_LIBRARIES_NOCONFIG "KF6::I18n"
  IMPORTED_LOCATION_NOCONFIG "${_IMPORT_PREFIX}/lib/libKSaneCore6.so.26.04.3"
  IMPORTED_SONAME_NOCONFIG "libKSaneCore6.so.1"
  )

list(APPEND _cmake_import_check_targets KSane6::Core )
list(APPEND _cmake_import_check_files_for_KSane6::Core "${_IMPORT_PREFIX}/lib/libKSaneCore6.so.26.04.3" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
