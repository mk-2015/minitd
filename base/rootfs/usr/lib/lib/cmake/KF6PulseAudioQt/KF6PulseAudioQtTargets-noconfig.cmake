#----------------------------------------------------------------
# Generated CMake target import file.
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "KF6::PulseAudioQt" for configuration ""
set_property(TARGET KF6::PulseAudioQt APPEND PROPERTY IMPORTED_CONFIGURATIONS NOCONFIG)
set_target_properties(KF6::PulseAudioQt PROPERTIES
  IMPORTED_LINK_DEPENDENT_LIBRARIES_NOCONFIG "Qt6::Gui;Qt6::DBus"
  IMPORTED_LOCATION_NOCONFIG "${_IMPORT_PREFIX}/lib/libKF6PulseAudioQt.so.1.8.1"
  IMPORTED_SONAME_NOCONFIG "libKF6PulseAudioQt.so.5"
  )

list(APPEND _cmake_import_check_targets KF6::PulseAudioQt )
list(APPEND _cmake_import_check_files_for_KF6::PulseAudioQt "${_IMPORT_PREFIX}/lib/libKF6PulseAudioQt.so.1.8.1" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
