#----------------------------------------------------------------
# Generated CMake target import file.
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "KDecoration3::KDecoration3Private" for configuration ""
set_property(TARGET KDecoration3::KDecoration3Private APPEND PROPERTY IMPORTED_CONFIGURATIONS NOCONFIG)
set_target_properties(KDecoration3::KDecoration3Private PROPERTIES
  IMPORTED_LOCATION_NOCONFIG "${_IMPORT_PREFIX}/lib/libkdecorations3private.so.6.7.3"
  IMPORTED_SONAME_NOCONFIG "libkdecorations3private.so.2"
  )

list(APPEND _cmake_import_check_targets KDecoration3::KDecoration3Private )
list(APPEND _cmake_import_check_files_for_KDecoration3::KDecoration3Private "${_IMPORT_PREFIX}/lib/libkdecorations3private.so.6.7.3" )

# Import target "KDecoration3::KDecoration" for configuration ""
set_property(TARGET KDecoration3::KDecoration APPEND PROPERTY IMPORTED_CONFIGURATIONS NOCONFIG)
set_target_properties(KDecoration3::KDecoration PROPERTIES
  IMPORTED_LINK_DEPENDENT_LIBRARIES_NOCONFIG "KDecoration3::KDecoration3Private;KF6::I18n"
  IMPORTED_LOCATION_NOCONFIG "${_IMPORT_PREFIX}/lib/libkdecorations3.so.6.7.3"
  IMPORTED_SONAME_NOCONFIG "libkdecorations3.so.6"
  )

list(APPEND _cmake_import_check_targets KDecoration3::KDecoration )
list(APPEND _cmake_import_check_files_for_KDecoration3::KDecoration "${_IMPORT_PREFIX}/lib/libkdecorations3.so.6.7.3" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
