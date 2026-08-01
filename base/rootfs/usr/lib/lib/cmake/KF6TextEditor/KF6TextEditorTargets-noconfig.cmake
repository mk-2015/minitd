#----------------------------------------------------------------
# Generated CMake target import file.
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "KF6::TextEditor" for configuration ""
set_property(TARGET KF6::TextEditor APPEND PROPERTY IMPORTED_CONFIGURATIONS NOCONFIG)
set_target_properties(KF6::TextEditor PROPERTIES
  IMPORTED_LINK_DEPENDENT_LIBRARIES_NOCONFIG "Qt6::Qml;Qt6::PrintSupport;Qt6::TextToSpeech;KF6::I18n;KF6::Archive;KF6::GuiAddons;KF6::ItemViews;KF6::SonnetCore;KF6::SonnetUi;KF6::Codecs;KF6::KIOWidgets;KF6::ColorScheme;KF6::AuthCore"
  IMPORTED_LOCATION_NOCONFIG "${_IMPORT_PREFIX}/lib/libKF6TextEditor.so.6.28.0"
  IMPORTED_SONAME_NOCONFIG "libKF6TextEditor.so.6"
  )

list(APPEND _cmake_import_check_targets KF6::TextEditor )
list(APPEND _cmake_import_check_files_for_KF6::TextEditor "${_IMPORT_PREFIX}/lib/libKF6TextEditor.so.6.28.0" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
