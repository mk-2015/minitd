#----------------------------------------------------------------
# Generated CMake target import file for configuration "RelWithDebInfo".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "Qt6::Quick3DAssetUtils" for configuration "RelWithDebInfo"
set_property(TARGET Qt6::Quick3DAssetUtils APPEND PROPERTY IMPORTED_CONFIGURATIONS RELWITHDEBINFO)
set_target_properties(Qt6::Quick3DAssetUtils PROPERTIES
  IMPORTED_LINK_DEPENDENT_LIBRARIES_RELWITHDEBINFO "Qt6::Quick3DAssetImport;Qt6::Quick3DRuntimeRender;Qt6::Quick3D;Qt6::Qml;Qt6::QuickTimeline"
  IMPORTED_LOCATION_RELWITHDEBINFO "${_IMPORT_PREFIX}/lib/libQt6Quick3DAssetUtils.so.6.11.1"
  IMPORTED_SONAME_RELWITHDEBINFO "libQt6Quick3DAssetUtils.so.6"
  )

list(APPEND _cmake_import_check_targets Qt6::Quick3DAssetUtils )
list(APPEND _cmake_import_check_files_for_Qt6::Quick3DAssetUtils "${_IMPORT_PREFIX}/lib/libQt6Quick3DAssetUtils.so.6.11.1" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
