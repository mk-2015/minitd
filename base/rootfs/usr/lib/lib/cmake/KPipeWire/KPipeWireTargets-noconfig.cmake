#----------------------------------------------------------------
# Generated CMake target import file.
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "K::KPipeWire" for configuration ""
set_property(TARGET K::KPipeWire APPEND PROPERTY IMPORTED_CONFIGURATIONS NOCONFIG)
set_target_properties(K::KPipeWire PROPERTIES
  IMPORTED_LINK_DEPENDENT_LIBRARIES_NOCONFIG "Qt6::Quick;Qt6::OpenGL;KF6::I18n;KF6::CoreAddons;Qt6::Qml"
  IMPORTED_LOCATION_NOCONFIG "${_IMPORT_PREFIX}/lib/libKPipeWire.so.6.7.3"
  IMPORTED_SONAME_NOCONFIG "libKPipeWire.so.6"
  )

list(APPEND _cmake_import_check_targets K::KPipeWire )
list(APPEND _cmake_import_check_files_for_K::KPipeWire "${_IMPORT_PREFIX}/lib/libKPipeWire.so.6.7.3" )

# Import target "K::KPipeWireRecord" for configuration ""
set_property(TARGET K::KPipeWireRecord APPEND PROPERTY IMPORTED_CONFIGURATIONS NOCONFIG)
set_target_properties(K::KPipeWireRecord PROPERTIES
  IMPORTED_LINK_DEPENDENT_LIBRARIES_NOCONFIG "Qt6::Core;Qt6::Gui;KF6::CoreAddons;K::KPipeWireDmaBuf;Qt6::Qml"
  IMPORTED_LOCATION_NOCONFIG "${_IMPORT_PREFIX}/lib/libKPipeWireRecord.so.6.7.3"
  IMPORTED_SONAME_NOCONFIG "libKPipeWireRecord.so.6"
  )

list(APPEND _cmake_import_check_targets K::KPipeWireRecord )
list(APPEND _cmake_import_check_files_for_K::KPipeWireRecord "${_IMPORT_PREFIX}/lib/libKPipeWireRecord.so.6.7.3" )

# Import target "K::KPipeWireDmaBuf" for configuration ""
set_property(TARGET K::KPipeWireDmaBuf APPEND PROPERTY IMPORTED_CONFIGURATIONS NOCONFIG)
set_target_properties(K::KPipeWireDmaBuf PROPERTIES
  IMPORTED_LINK_DEPENDENT_LIBRARIES_NOCONFIG "Qt6::Core;Qt6::Gui"
  IMPORTED_LOCATION_NOCONFIG "${_IMPORT_PREFIX}/lib/libKPipeWireDmaBuf.so.6.7.3"
  IMPORTED_SONAME_NOCONFIG "libKPipeWireDmaBuf.so.6"
  )

list(APPEND _cmake_import_check_targets K::KPipeWireDmaBuf )
list(APPEND _cmake_import_check_files_for_K::KPipeWireDmaBuf "${_IMPORT_PREFIX}/lib/libKPipeWireDmaBuf.so.6.7.3" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
