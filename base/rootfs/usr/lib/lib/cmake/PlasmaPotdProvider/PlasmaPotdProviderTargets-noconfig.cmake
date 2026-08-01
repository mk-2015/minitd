#----------------------------------------------------------------
# Generated CMake target import file.
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "Plasma::PotdProvider" for configuration ""
set_property(TARGET Plasma::PotdProvider APPEND PROPERTY IMPORTED_CONFIGURATIONS NOCONFIG)
set_target_properties(Plasma::PotdProvider PROPERTIES
  IMPORTED_LOCATION_NOCONFIG "${_IMPORT_PREFIX}/lib/libplasmapotdprovidercore.so.2.0.0"
  IMPORTED_SONAME_NOCONFIG "libplasmapotdprovidercore.so.2"
  )

list(APPEND _cmake_import_check_targets Plasma::PotdProvider )
list(APPEND _cmake_import_check_files_for_Plasma::PotdProvider "${_IMPORT_PREFIX}/lib/libplasmapotdprovidercore.so.2.0.0" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
