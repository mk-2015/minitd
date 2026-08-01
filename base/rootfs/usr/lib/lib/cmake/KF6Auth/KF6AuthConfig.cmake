
####### Expanded from @PACKAGE_INIT@ by configure_package_config_file() #######
####### Any changes to this file will be overwritten by the next CMake run ####
####### The input file was KF6AuthConfig.cmake.in                            ########

get_filename_component(PACKAGE_PREFIX_DIR "${CMAKE_CURRENT_LIST_DIR}/../../../" ABSOLUTE)

# Use original install prefix when loaded through a "/usr move"
# cross-prefix symbolic link such as /lib -> /usr/lib.
get_filename_component(_realCurr "${CMAKE_CURRENT_LIST_DIR}" REALPATH)
get_filename_component(_realOrig "/usr/lib/cmake/KF6Auth" REALPATH)
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

set(KAUTH_STUB_FILES_DIR "${PACKAGE_PREFIX_DIR}/share/kf6/kauth/")

set(KAUTH_BACKEND_NAME "POLKITQT6-1")
set(KAUTH_HELPER_BACKEND_NAME "DBUS")
set(KAUTH_POLICY_FILES_INSTALL_DIR "/usr/share/polkit-1/actions")
set(KAUTH_HELPER_INSTALL_DIR "lib/kf6/kauth")
set(KAUTH_HELPER_INSTALL_ABSOLUTE_DIR "/usr/lib/kf6/kauth")

include(CMakeFindDependencyMacro)

find_dependency(KF6CoreAddons "6.28.0")

if(NOT TRUE)
    if(NOT OFF)
        find_dependency(Qt6Gui "6.9.0")
    endif()

    if(NOT KAUTH_BACKEND_NAME AND 1 AND NOT )
        find_dependency(PolkitQt6-1 "0.112.0")
        find_dependency(Qt6DBus "6.9.0")
    endif()

    if(KAUTH_BACKEND_NAME AND NOT OFF AND "${KAUTH_BACKEND_NAME}" STREQUAL "POLKITQT6-1")
        find_dependency(PolkitQt6-1 "0.112.0")
        find_dependency(Qt6DBus "6.9.0")
    endif()
endif()

include("${CMAKE_CURRENT_LIST_DIR}/KF6AuthTargets.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/KF6AuthMacros.cmake")

if(NOT "${KAUTH_BACKEND_NAME}" STREQUAL "FAKE")
    if(CMAKE_CROSSCOMPILING AND KF6_HOST_TOOLING)
        find_file(KAUTH_TARGETSFILE KF6Auth/KF6AuthToolsTargets.cmake PATHS ${KF6_HOST_TOOLING} ${CMAKE_CURRENT_LIST_DIR} NO_DEFAULT_PATH)
        include("${KAUTH_TARGETSFILE}")
    else()
        include("${CMAKE_CURRENT_LIST_DIR}/KF6AuthToolsTargets.cmake")
    endif()
endif()
