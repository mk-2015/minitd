#----------------------------------------------------------------
# Generated CMake target import file for configuration "RelWithDebInfo".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "Qt6::VirtualKeyboardSettings" for configuration "RelWithDebInfo"
set_property(TARGET Qt6::VirtualKeyboardSettings APPEND PROPERTY IMPORTED_CONFIGURATIONS RELWITHDEBINFO)
set_target_properties(Qt6::VirtualKeyboardSettings PROPERTIES
  IMPORTED_LINK_DEPENDENT_LIBRARIES_RELWITHDEBINFO "Qt6::Core;Qt6::Gui;Qt6::Qml;Qt6::Quick;Qt6::VirtualKeyboard"
  IMPORTED_LOCATION_RELWITHDEBINFO "${_IMPORT_PREFIX}/lib/libQt6VirtualKeyboardSettings.so.6.11.1"
  IMPORTED_SONAME_RELWITHDEBINFO "libQt6VirtualKeyboardSettings.so.6"
  )

list(APPEND _cmake_import_check_targets Qt6::VirtualKeyboardSettings )
list(APPEND _cmake_import_check_files_for_Qt6::VirtualKeyboardSettings "${_IMPORT_PREFIX}/lib/libQt6VirtualKeyboardSettings.so.6.11.1" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
