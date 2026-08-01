#----------------------------------------------------------------
# Generated CMake target import file.
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "KQuickImageEditor" for configuration ""
set_property(TARGET KQuickImageEditor APPEND PROPERTY IMPORTED_CONFIGURATIONS NOCONFIG)
set_target_properties(KQuickImageEditor PROPERTIES
  IMPORTED_LINK_DEPENDENT_LIBRARIES_NOCONFIG "opencv_core;opencv_imgproc"
  IMPORTED_LOCATION_NOCONFIG "${_IMPORT_PREFIX}/lib/libKQuickImageEditor.so.0.6.2"
  IMPORTED_SONAME_NOCONFIG "libKQuickImageEditor.so.1"
  )

list(APPEND _cmake_import_check_targets KQuickImageEditor )
list(APPEND _cmake_import_check_files_for_KQuickImageEditor "${_IMPORT_PREFIX}/lib/libKQuickImageEditor.so.0.6.2" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
