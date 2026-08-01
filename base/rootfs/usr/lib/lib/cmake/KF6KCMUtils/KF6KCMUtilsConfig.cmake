# SPDX-FileCopyrightText: 2022 Alexander Lohnau <alexander.lohnau@gmx.de>
# SPDX-License-Identifier: BSD-3-Clause


####### Expanded from @PACKAGE_INIT@ by configure_package_config_file() #######
####### Any changes to this file will be overwritten by the next CMake run ####
####### The input file was KF6KCMUtilsConfig.cmake.in                            ########

get_filename_component(PACKAGE_PREFIX_DIR "${CMAKE_CURRENT_LIST_DIR}/../../../" ABSOLUTE)

# Use original install prefix when loaded through a "/usr move"
# cross-prefix symbolic link such as /lib -> /usr/lib.
get_filename_component(_realCurr "${CMAKE_CURRENT_LIST_DIR}" REALPATH)
get_filename_component(_realOrig "/usr/lib/cmake/KF6KCMUtils" REALPATH)
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

include(CMakeFindDependencyMacro)
find_dependency(KF6ConfigWidgets  "6.28.0")
find_dependency(KF6CoreAddons   "6.28.0")
find_dependency(Qt6Qml          "6.9.0")

if (NOT TRUE)
    find_dependency(Qt6Quick        "6.9.0")
    find_dependency(Qt6QuickWidgets "6.9.0")

    find_dependency(KF6GuiAddons    "6.28.0")
    find_dependency(KF6I18n         "6.28.0")
    find_dependency(KF6ItemViews    "6.28.0")
    find_dependency(KF6XmlGui       "6.28.0")
endif()



include("${CMAKE_CURRENT_LIST_DIR}/KF6KCMUtilsTargets.cmake")

include("${CMAKE_CURRENT_LIST_DIR}/KF6KCMUtilsMacros.cmake")

if(CMAKE_CROSSCOMPILING AND KF6_HOST_TOOLING)
    find_file(KCMUTILS_TARGETSFILE KF6KCMUtils/KF6KCMUtilsToolingTargets.cmake
        PATHS ${KF6_HOST_TOOLING} ${CMAKE_CURRENT_LIST_DIR}
        NO_DEFAULT_PATH
        NO_CMAKE_FIND_ROOT_PATH)
    include("${KCMUTILS_TARGETSFILE}")
else()
    include("${CMAKE_CURRENT_LIST_DIR}/KF6KCMUtilsToolingTargets.cmake")
endif()
