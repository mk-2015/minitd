#----------------------------------------------------------------
# Generated CMake target import file.
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "kImageAnnotator::kImageAnnotator" for configuration ""
set_property(TARGET kImageAnnotator::kImageAnnotator APPEND PROPERTY IMPORTED_CONFIGURATIONS NOCONFIG)
set_target_properties(kImageAnnotator::kImageAnnotator PROPERTIES
  IMPORTED_LINK_DEPENDENT_LIBRARIES_NOCONFIG "kColorPicker::kColorPicker"
  IMPORTED_LOCATION_NOCONFIG "${_IMPORT_PREFIX}/lib/libkImageAnnotator.so.0.7.2"
  IMPORTED_SONAME_NOCONFIG "libkImageAnnotator.so.0"
  )

list(APPEND _cmake_import_check_targets kImageAnnotator::kImageAnnotator )
list(APPEND _cmake_import_check_files_for_kImageAnnotator::kImageAnnotator "${_IMPORT_PREFIX}/lib/libkImageAnnotator.so.0.7.2" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
