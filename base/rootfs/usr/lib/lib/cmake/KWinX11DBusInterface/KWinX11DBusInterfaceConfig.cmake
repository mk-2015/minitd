
####### Expanded from @PACKAGE_INIT@ by configure_package_config_file() #######
####### Any changes to this file will be overwritten by the next CMake run ####
####### The input file was KWinX11DBusInterfaceConfig.cmake.in                            ########

get_filename_component(PACKAGE_PREFIX_DIR "${CMAKE_CURRENT_LIST_DIR}/../../../" ABSOLUTE)

# Use original install prefix when loaded through a "/usr move"
# cross-prefix symbolic link such as /lib -> /usr/lib.
get_filename_component(_realCurr "${CMAKE_CURRENT_LIST_DIR}" REALPATH)
get_filename_component(_realOrig "/usr/lib/cmake/KWinX11DBusInterface" REALPATH)
if(_realCurr STREQUAL _realOrig)
  set(PACKAGE_PREFIX_DIR "/usr")
endif()
unset(_realOrig)
unset(_realCurr)

macro(set_and_check _var _file)
  set(${_var} "${_file}")
  if(NOT EXISTS "${_file}")
    message(FATAL_ERROR "File or directory ${_file} referenced by variable ${_var} does not exist !")
  endif()
endmacro()

macro(check_required_components _NAME)
  foreach(comp ${${_NAME}_FIND_COMPONENTS})
    if(NOT ${_NAME}_${comp}_FOUND)
      if(${_NAME}_FIND_REQUIRED_${comp})
        set(${_NAME}_FOUND FALSE)
      endif()
    endif()
  endforeach()
endmacro()

####################################################################################

set(KWIN_INTERFACE "${PACKAGE_PREFIX_DIR}/share/dbus-1/interfaces/kwin_x11_org.kde.KWin.xml")
set(KWIN_COMPOSITING_INTERFACE "${PACKAGE_PREFIX_DIR}/share/dbus-1/interfaces/kwin_x11_org.kde.kwin.Compositing.xml")
set(KWIN_EFFECTS_INTERFACE "${PACKAGE_PREFIX_DIR}/share/dbus-1/interfaces/kwin_x11_org.kde.kwin.Effects.xml")
set(KWIN_VIRTUALKEYBOARD_INTERFACE "${PACKAGE_PREFIX_DIR}/share/dbus-1/interfaces/kwin_x11_org.kde.kwin.VirtualKeyboard.xml")
set(KWIN_TABLETMODE_INTERFACE "${PACKAGE_PREFIX_DIR}/share/dbus-1/interfaces/kwin_x11_org.kde.KWin.TabletModeManager.xml")
set(KWIN_INPUTDEVICE_INTERFACE "${PACKAGE_PREFIX_DIR}/share/dbus-1/interfaces/kwin_x11_org.kde.kwin.InputDevice.xml")
set(KWIN_NIGHTLIGHT_INTERFACE "${PACKAGE_PREFIX_DIR}/share/dbus-1/interfaces/kwin_x11_org.kde.KWin.NightLight.xml")
