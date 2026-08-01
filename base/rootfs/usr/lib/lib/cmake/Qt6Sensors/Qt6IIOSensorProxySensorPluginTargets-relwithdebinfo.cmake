#----------------------------------------------------------------
# Generated CMake target import file for configuration "RelWithDebInfo".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "Qt6::IIOSensorProxySensorPlugin" for configuration "RelWithDebInfo"
set_property(TARGET Qt6::IIOSensorProxySensorPlugin APPEND PROPERTY IMPORTED_CONFIGURATIONS RELWITHDEBINFO)
set_target_properties(Qt6::IIOSensorProxySensorPlugin PROPERTIES
  IMPORTED_COMMON_LANGUAGE_RUNTIME_RELWITHDEBINFO ""
  IMPORTED_LOCATION_RELWITHDEBINFO "${_IMPORT_PREFIX}/lib/qt6/plugins/sensors/libqtsensors_iio-sensor-proxy.so"
  IMPORTED_NO_SONAME_RELWITHDEBINFO "TRUE"
  )

list(APPEND _cmake_import_check_targets Qt6::IIOSensorProxySensorPlugin )
list(APPEND _cmake_import_check_files_for_Qt6::IIOSensorProxySensorPlugin "${_IMPORT_PREFIX}/lib/qt6/plugins/sensors/libqtsensors_iio-sensor-proxy.so" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
