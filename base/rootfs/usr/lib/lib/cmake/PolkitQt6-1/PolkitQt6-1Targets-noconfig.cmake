#----------------------------------------------------------------
# Generated CMake target import file.
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "PolkitQt6-1::Core" for configuration ""
set_property(TARGET PolkitQt6-1::Core APPEND PROPERTY IMPORTED_CONFIGURATIONS NOCONFIG)
set_target_properties(PolkitQt6-1::Core PROPERTIES
  IMPORTED_LINK_DEPENDENT_LIBRARIES_NOCONFIG "Qt6::DBus"
  IMPORTED_LOCATION_NOCONFIG "${_IMPORT_PREFIX}/lib/libpolkit-qt6-core-1.so.1.201.1"
  IMPORTED_SONAME_NOCONFIG "libpolkit-qt6-core-1.so.1"
  )

list(APPEND _cmake_import_check_targets PolkitQt6-1::Core )
list(APPEND _cmake_import_check_files_for_PolkitQt6-1::Core "${_IMPORT_PREFIX}/lib/libpolkit-qt6-core-1.so.1.201.1" )

# Import target "PolkitQt6-1::Gui" for configuration ""
set_property(TARGET PolkitQt6-1::Gui APPEND PROPERTY IMPORTED_CONFIGURATIONS NOCONFIG)
set_target_properties(PolkitQt6-1::Gui PROPERTIES
  IMPORTED_LINK_DEPENDENT_LIBRARIES_NOCONFIG "Qt6::Core;Qt6::DBus"
  IMPORTED_LOCATION_NOCONFIG "${_IMPORT_PREFIX}/lib/libpolkit-qt6-gui-1.so.1.201.1"
  IMPORTED_SONAME_NOCONFIG "libpolkit-qt6-gui-1.so.1"
  )

list(APPEND _cmake_import_check_targets PolkitQt6-1::Gui )
list(APPEND _cmake_import_check_files_for_PolkitQt6-1::Gui "${_IMPORT_PREFIX}/lib/libpolkit-qt6-gui-1.so.1.201.1" )

# Import target "PolkitQt6-1::Agent" for configuration ""
set_property(TARGET PolkitQt6-1::Agent APPEND PROPERTY IMPORTED_CONFIGURATIONS NOCONFIG)
set_target_properties(PolkitQt6-1::Agent PROPERTIES
  IMPORTED_LOCATION_NOCONFIG "${_IMPORT_PREFIX}/lib/libpolkit-qt6-agent-1.so.1.201.1"
  IMPORTED_SONAME_NOCONFIG "libpolkit-qt6-agent-1.so.1"
  )

list(APPEND _cmake_import_check_targets PolkitQt6-1::Agent )
list(APPEND _cmake_import_check_files_for_PolkitQt6-1::Agent "${_IMPORT_PREFIX}/lib/libpolkit-qt6-agent-1.so.1.201.1" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
