#----------------------------------------------------------------
# Generated CMake target import file.
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "KSysGuard::Formatter" for configuration ""
set_property(TARGET KSysGuard::Formatter APPEND PROPERTY IMPORTED_CONFIGURATIONS NOCONFIG)
set_target_properties(KSysGuard::Formatter PROPERTIES
  IMPORTED_LINK_DEPENDENT_LIBRARIES_NOCONFIG "KF6::CoreAddons;KF6::I18n;KF6::ConfigCore"
  IMPORTED_LOCATION_NOCONFIG "${_IMPORT_PREFIX}/lib/libKSysGuardFormatter.so.6.7.3"
  IMPORTED_SONAME_NOCONFIG "libKSysGuardFormatter.so.2"
  )

list(APPEND _cmake_import_check_targets KSysGuard::Formatter )
list(APPEND _cmake_import_check_files_for_KSysGuard::Formatter "${_IMPORT_PREFIX}/lib/libKSysGuardFormatter.so.6.7.3" )

# Import target "KSysGuard::ProcessCore" for configuration ""
set_property(TARGET KSysGuard::ProcessCore APPEND PROPERTY IMPORTED_CONFIGURATIONS NOCONFIG)
set_target_properties(KSysGuard::ProcessCore PROPERTIES
  IMPORTED_LINK_DEPENDENT_LIBRARIES_NOCONFIG "KF6::I18n;KF6::AuthCore;KF6::CoreAddons;Qt6::Qml"
  IMPORTED_LOCATION_NOCONFIG "${_IMPORT_PREFIX}/lib/libprocesscore.so.6.7.3"
  IMPORTED_SONAME_NOCONFIG "libprocesscore.so.11"
  )

list(APPEND _cmake_import_check_targets KSysGuard::ProcessCore )
list(APPEND _cmake_import_check_files_for_KSysGuard::ProcessCore "${_IMPORT_PREFIX}/lib/libprocesscore.so.6.7.3" )

# Import target "KSysGuard::Sensors" for configuration ""
set_property(TARGET KSysGuard::Sensors APPEND PROPERTY IMPORTED_CONFIGURATIONS NOCONFIG)
set_target_properties(KSysGuard::Sensors PROPERTIES
  IMPORTED_LINK_DEPENDENT_LIBRARIES_NOCONFIG "Qt6::Core;Qt6::DBus;KF6::I18n;KSysGuard::SystemStats"
  IMPORTED_LOCATION_NOCONFIG "${_IMPORT_PREFIX}/lib/libKSysGuardSensors.so.6.7.3"
  IMPORTED_SONAME_NOCONFIG "libKSysGuardSensors.so.2"
  )

list(APPEND _cmake_import_check_targets KSysGuard::Sensors )
list(APPEND _cmake_import_check_files_for_KSysGuard::Sensors "${_IMPORT_PREFIX}/lib/libKSysGuardSensors.so.6.7.3" )

# Import target "KSysGuard::SensorFaces" for configuration ""
set_property(TARGET KSysGuard::SensorFaces APPEND PROPERTY IMPORTED_CONFIGURATIONS NOCONFIG)
set_target_properties(KSysGuard::SensorFaces PROPERTIES
  IMPORTED_LINK_DEPENDENT_LIBRARIES_NOCONFIG "Qt6::Core;Qt6::DBus;KF6::I18n;KF6::Package;KF6::ConfigQml;KF6::Solid"
  IMPORTED_LOCATION_NOCONFIG "${_IMPORT_PREFIX}/lib/libKSysGuardSensorFaces.so.6.7.3"
  IMPORTED_SONAME_NOCONFIG "libKSysGuardSensorFaces.so.2"
  )

list(APPEND _cmake_import_check_targets KSysGuard::SensorFaces )
list(APPEND _cmake_import_check_files_for_KSysGuard::SensorFaces "${_IMPORT_PREFIX}/lib/libKSysGuardSensorFaces.so.6.7.3" )

# Import target "KSysGuard::SystemStats" for configuration ""
set_property(TARGET KSysGuard::SystemStats APPEND PROPERTY IMPORTED_CONFIGURATIONS NOCONFIG)
set_target_properties(KSysGuard::SystemStats PROPERTIES
  IMPORTED_LOCATION_NOCONFIG "${_IMPORT_PREFIX}/lib/libKSysGuardSystemStats.so.6.7.3"
  IMPORTED_SONAME_NOCONFIG "libKSysGuardSystemStats.so.2"
  )

list(APPEND _cmake_import_check_targets KSysGuard::SystemStats )
list(APPEND _cmake_import_check_files_for_KSysGuard::SystemStats "${_IMPORT_PREFIX}/lib/libKSysGuardSystemStats.so.6.7.3" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
