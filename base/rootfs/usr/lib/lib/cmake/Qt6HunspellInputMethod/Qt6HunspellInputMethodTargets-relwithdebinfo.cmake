#----------------------------------------------------------------
# Generated CMake target import file for configuration "RelWithDebInfo".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "Qt6::HunspellInputMethod" for configuration "RelWithDebInfo"
set_property(TARGET Qt6::HunspellInputMethod APPEND PROPERTY IMPORTED_CONFIGURATIONS RELWITHDEBINFO)
set_target_properties(Qt6::HunspellInputMethod PROPERTIES
  IMPORTED_LINK_DEPENDENT_LIBRARIES_RELWITHDEBINFO "Qt6::Core;Qt6::Gui;Qt6::Qml"
  IMPORTED_LOCATION_RELWITHDEBINFO "${_IMPORT_PREFIX}/lib/libQt6HunspellInputMethod.so.6.11.1"
  IMPORTED_SONAME_RELWITHDEBINFO "libQt6HunspellInputMethod.so.6"
  )

list(APPEND _cmake_import_check_targets Qt6::HunspellInputMethod )
list(APPEND _cmake_import_check_files_for_Qt6::HunspellInputMethod "${_IMPORT_PREFIX}/lib/libQt6HunspellInputMethod.so.6.11.1" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
