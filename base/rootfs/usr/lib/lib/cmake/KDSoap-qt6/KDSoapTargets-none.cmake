#----------------------------------------------------------------
# Generated CMake target import file for configuration "None".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "KDSoap::kdsoap" for configuration "None"
set_property(TARGET KDSoap::kdsoap APPEND PROPERTY IMPORTED_CONFIGURATIONS NONE)
set_target_properties(KDSoap::kdsoap PROPERTIES
  IMPORTED_LOCATION_NONE "${_IMPORT_PREFIX}/lib/libkdsoap-qt6.so.2.3.0"
  IMPORTED_SONAME_NONE "libkdsoap-qt6.so.2"
  )

list(APPEND _cmake_import_check_targets KDSoap::kdsoap )
list(APPEND _cmake_import_check_files_for_KDSoap::kdsoap "${_IMPORT_PREFIX}/lib/libkdsoap-qt6.so.2.3.0" )

# Import target "KDSoap::kdsoap-server" for configuration "None"
set_property(TARGET KDSoap::kdsoap-server APPEND PROPERTY IMPORTED_CONFIGURATIONS NONE)
set_target_properties(KDSoap::kdsoap-server PROPERTIES
  IMPORTED_LOCATION_NONE "${_IMPORT_PREFIX}/lib/libkdsoap-server-qt6.so.2.3.0"
  IMPORTED_SONAME_NONE "libkdsoap-server-qt6.so.2"
  )

list(APPEND _cmake_import_check_targets KDSoap::kdsoap-server )
list(APPEND _cmake_import_check_files_for_KDSoap::kdsoap-server "${_IMPORT_PREFIX}/lib/libkdsoap-server-qt6.so.2.3.0" )

# Import target "KDSoap::kdwsdl2cpp" for configuration "None"
set_property(TARGET KDSoap::kdwsdl2cpp APPEND PROPERTY IMPORTED_CONFIGURATIONS NONE)
set_target_properties(KDSoap::kdwsdl2cpp PROPERTIES
  IMPORTED_LOCATION_NONE "${_IMPORT_PREFIX}/bin/kdwsdl2cpp-qt6"
  )

list(APPEND _cmake_import_check_targets KDSoap::kdwsdl2cpp )
list(APPEND _cmake_import_check_files_for_KDSoap::kdwsdl2cpp "${_IMPORT_PREFIX}/bin/kdwsdl2cpp-qt6" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
