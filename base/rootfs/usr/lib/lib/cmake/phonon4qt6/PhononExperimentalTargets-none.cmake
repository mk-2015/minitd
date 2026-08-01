#----------------------------------------------------------------
# Generated CMake target import file for configuration "None".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "Phonon::phonon4qt6experimental" for configuration "None"
set_property(TARGET Phonon::phonon4qt6experimental APPEND PROPERTY IMPORTED_CONFIGURATIONS NONE)
set_target_properties(Phonon::phonon4qt6experimental PROPERTIES
  IMPORTED_LOCATION_NONE "${_IMPORT_PREFIX}/lib/libphonon4qt6experimental.so.4.12.0"
  IMPORTED_SONAME_NONE "libphonon4qt6experimental.so.4"
  )

list(APPEND _cmake_import_check_targets Phonon::phonon4qt6experimental )
list(APPEND _cmake_import_check_files_for_Phonon::phonon4qt6experimental "${_IMPORT_PREFIX}/lib/libphonon4qt6experimental.so.4.12.0" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
