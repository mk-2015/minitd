#----------------------------------------------------------------
# Generated CMake target import file for configuration "None".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "FluidSynth::fluidsynth" for configuration "None"
set_property(TARGET FluidSynth::fluidsynth APPEND PROPERTY IMPORTED_CONFIGURATIONS NONE)
set_target_properties(FluidSynth::fluidsynth PROPERTIES
  IMPORTED_LOCATION_NONE "${_IMPORT_PREFIX}/bin/fluidsynth"
  )

list(APPEND _cmake_import_check_targets FluidSynth::fluidsynth )
list(APPEND _cmake_import_check_files_for_FluidSynth::fluidsynth "${_IMPORT_PREFIX}/bin/fluidsynth" )

# Import target "FluidSynth::libfluidsynth" for configuration "None"
set_property(TARGET FluidSynth::libfluidsynth APPEND PROPERTY IMPORTED_CONFIGURATIONS NONE)
set_target_properties(FluidSynth::libfluidsynth PROPERTIES
  IMPORTED_LOCATION_NONE "${_IMPORT_PREFIX}/lib/libfluidsynth.so.3.5.5"
  IMPORTED_SONAME_NONE "libfluidsynth.so.3"
  )

list(APPEND _cmake_import_check_targets FluidSynth::libfluidsynth )
list(APPEND _cmake_import_check_files_for_FluidSynth::libfluidsynth "${_IMPORT_PREFIX}/lib/libfluidsynth.so.3.5.5" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
