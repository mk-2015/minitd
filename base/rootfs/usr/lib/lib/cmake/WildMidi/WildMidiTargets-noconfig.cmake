#----------------------------------------------------------------
# Generated CMake target import file.
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "WildMidi::libwildmidi" for configuration ""
set_property(TARGET WildMidi::libwildmidi APPEND PROPERTY IMPORTED_CONFIGURATIONS NOCONFIG)
set_target_properties(WildMidi::libwildmidi PROPERTIES
  IMPORTED_LOCATION_NOCONFIG "${_IMPORT_PREFIX}/lib/libWildMidi.so.2.1.0"
  IMPORTED_SONAME_NOCONFIG "libWildMidi.so.2"
  )

list(APPEND _cmake_import_check_targets WildMidi::libwildmidi )
list(APPEND _cmake_import_check_files_for_WildMidi::libwildmidi "${_IMPORT_PREFIX}/lib/libWildMidi.so.2.1.0" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
