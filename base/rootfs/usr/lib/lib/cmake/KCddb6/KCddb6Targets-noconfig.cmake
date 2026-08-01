#----------------------------------------------------------------
# Generated CMake target import file.
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "KCddb6" for configuration ""
set_property(TARGET KCddb6 APPEND PROPERTY IMPORTED_CONFIGURATIONS NOCONFIG)
set_target_properties(KCddb6 PROPERTIES
  IMPORTED_LINK_DEPENDENT_LIBRARIES_NOCONFIG "KF6::I18n;KF6::KIOCore;Qt6::Network;musicbrainz"
  IMPORTED_LOCATION_NOCONFIG "${_IMPORT_PREFIX}/lib/libKCddb6.so.5.1.0"
  IMPORTED_SONAME_NOCONFIG "libKCddb6.so.5"
  )

list(APPEND _cmake_import_check_targets KCddb6 )
list(APPEND _cmake_import_check_files_for_KCddb6 "${_IMPORT_PREFIX}/lib/libKCddb6.so.5.1.0" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
