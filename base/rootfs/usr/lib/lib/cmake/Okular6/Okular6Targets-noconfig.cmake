#----------------------------------------------------------------
# Generated CMake target import file.
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "Okular::Core" for configuration ""
set_property(TARGET Okular::Core APPEND PROPERTY IMPORTED_CONFIGURATIONS NOCONFIG)
set_target_properties(Okular::Core PROPERTIES
  IMPORTED_LINK_DEPENDENT_LIBRARIES_NOCONFIG "KF6::Archive;KF6::KIOCore;KF6::KIOWidgets;KF6::I18n;KF6::ThreadWeaver;KF6::Bookmarks;Qt6::Svg;Phonon::phonon4qt6;KF6::Wallet;Qt6::Qml"
  IMPORTED_LOCATION_NOCONFIG "${_IMPORT_PREFIX}/lib/libOkular6Core.so.4.0.0"
  IMPORTED_SONAME_NOCONFIG "libOkular6Core.so.4"
  )

list(APPEND _cmake_import_check_targets Okular::Core )
list(APPEND _cmake_import_check_files_for_Okular::Core "${_IMPORT_PREFIX}/lib/libOkular6Core.so.4.0.0" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
