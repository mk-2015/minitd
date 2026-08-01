#----------------------------------------------------------------
# Generated CMake target import file for configuration "Release".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "Imath::PyImath" for configuration "Release"
set_property(TARGET Imath::PyImath APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(Imath::PyImath PROPERTIES
  IMPORTED_LINK_DEPENDENT_LIBRARIES_RELEASE "Boost::python"
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib/libPyImath_Python3_14-3_2.so.30.3.2.2"
  IMPORTED_SONAME_RELEASE "libPyImath_Python3_14-3_2.so.30"
  )

list(APPEND _cmake_import_check_targets Imath::PyImath )
list(APPEND _cmake_import_check_files_for_Imath::PyImath "${_IMPORT_PREFIX}/lib/libPyImath_Python3_14-3_2.so.30.3.2.2" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
