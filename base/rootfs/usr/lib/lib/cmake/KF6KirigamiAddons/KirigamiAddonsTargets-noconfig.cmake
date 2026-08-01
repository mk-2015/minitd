#----------------------------------------------------------------
# Generated CMake target import file.
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "KirigamiApp" for configuration ""
set_property(TARGET KirigamiApp APPEND PROPERTY IMPORTED_CONFIGURATIONS NOCONFIG)
set_target_properties(KirigamiApp PROPERTIES
  IMPORTED_LINK_DEPENDENT_LIBRARIES_NOCONFIG "Qt6::QuickControls2;Qt6::Qml;KF6::CoreAddons;KF6::I18n;KF6::ColorScheme;KF6::Crash;Qt6::Widgets;KF6::IconThemes"
  IMPORTED_LOCATION_NOCONFIG "${_IMPORT_PREFIX}/lib/libKirigamiApp.so.1.13.1"
  IMPORTED_SONAME_NOCONFIG "libKirigamiApp.so.6"
  )

list(APPEND _cmake_import_check_targets KirigamiApp )
list(APPEND _cmake_import_check_files_for_KirigamiApp "${_IMPORT_PREFIX}/lib/libKirigamiApp.so.1.13.1" )

# Import target "KirigamiAddonsComponents" for configuration ""
set_property(TARGET KirigamiAddonsComponents APPEND PROPERTY IMPORTED_CONFIGURATIONS NOCONFIG)
set_target_properties(KirigamiAddonsComponents PROPERTIES
  IMPORTED_LINK_DEPENDENT_LIBRARIES_NOCONFIG "Qt6::QuickControls2;Qt6::Qml"
  IMPORTED_LOCATION_NOCONFIG "${_IMPORT_PREFIX}/lib/libKirigamiAddonsComponents.so.1.13.1"
  IMPORTED_SONAME_NOCONFIG "libKirigamiAddonsComponents.so.6"
  )

list(APPEND _cmake_import_check_targets KirigamiAddonsComponents )
list(APPEND _cmake_import_check_files_for_KirigamiAddonsComponents "${_IMPORT_PREFIX}/lib/libKirigamiAddonsComponents.so.1.13.1" )

# Import target "KirigamiAddonsStatefulApp" for configuration ""
set_property(TARGET KirigamiAddonsStatefulApp APPEND PROPERTY IMPORTED_CONFIGURATIONS NOCONFIG)
set_target_properties(KirigamiAddonsStatefulApp PROPERTIES
  IMPORTED_LINK_DEPENDENT_LIBRARIES_NOCONFIG "KF6::I18n;KF6::CoreAddons"
  IMPORTED_LOCATION_NOCONFIG "${_IMPORT_PREFIX}/lib/libKirigamiAddonsStatefulApp.so.1.13.1"
  IMPORTED_SONAME_NOCONFIG "libKirigamiAddonsStatefulApp.so.6"
  )

list(APPEND _cmake_import_check_targets KirigamiAddonsStatefulApp )
list(APPEND _cmake_import_check_files_for_KirigamiAddonsStatefulApp "${_IMPORT_PREFIX}/lib/libKirigamiAddonsStatefulApp.so.1.13.1" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
