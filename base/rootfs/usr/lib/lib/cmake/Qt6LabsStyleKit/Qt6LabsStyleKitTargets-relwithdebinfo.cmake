#----------------------------------------------------------------
# Generated CMake target import file for configuration "RelWithDebInfo".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "Qt6::LabsStyleKit" for configuration "RelWithDebInfo"
set_property(TARGET Qt6::LabsStyleKit APPEND PROPERTY IMPORTED_CONFIGURATIONS RELWITHDEBINFO)
set_target_properties(Qt6::LabsStyleKit PROPERTIES
  IMPORTED_LINK_DEPENDENT_LIBRARIES_RELWITHDEBINFO "Qt6::Gui;Qt6::Quick;Qt6::QuickTemplates2;Qt6::QuickControls2Impl;Qt6::Qml;Qt6::Core"
  IMPORTED_LOCATION_RELWITHDEBINFO "${_IMPORT_PREFIX}/lib/libQt6LabsStyleKit.so.6.11.1"
  IMPORTED_SONAME_RELWITHDEBINFO "libQt6LabsStyleKit.so.6"
  )

list(APPEND _cmake_import_check_targets Qt6::LabsStyleKit )
list(APPEND _cmake_import_check_files_for_Qt6::LabsStyleKit "${_IMPORT_PREFIX}/lib/libQt6LabsStyleKit.so.6.11.1" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
