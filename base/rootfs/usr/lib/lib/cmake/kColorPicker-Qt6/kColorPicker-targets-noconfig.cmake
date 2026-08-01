#----------------------------------------------------------------
# Generated CMake target import file.
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "kColorPicker::kColorPicker" for configuration ""
set_property(TARGET kColorPicker::kColorPicker APPEND PROPERTY IMPORTED_CONFIGURATIONS NOCONFIG)
set_target_properties(kColorPicker::kColorPicker PROPERTIES
  IMPORTED_LOCATION_NOCONFIG "${_IMPORT_PREFIX}/lib/libkColorPicker.so.0.3.1"
  IMPORTED_SONAME_NOCONFIG "libkColorPicker.so.0"
  )

list(APPEND _cmake_import_check_targets kColorPicker::kColorPicker )
list(APPEND _cmake_import_check_files_for_kColorPicker::kColorPicker "${_IMPORT_PREFIX}/lib/libkColorPicker.so.0.3.1" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
