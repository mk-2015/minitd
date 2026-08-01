# Copyright (C) 2024 The Qt Company Ltd.
# SPDX-License-Identifier: BSD-3-Clause


####### Expanded from @PACKAGE_INIT@ by configure_package_config_file() #######
####### Any changes to this file will be overwritten by the next CMake run ####
####### The input file was QtModuleToolsConfig.cmake.in                            ########

get_filename_component(PACKAGE_PREFIX_DIR "${CMAKE_CURRENT_LIST_DIR}/../../../" ABSOLUTE)

# Use original install prefix when loaded through a "/usr move"
# cross-prefix symbolic link such as /lib -> /usr/lib.
get_filename_component(_realCurr "${CMAKE_CURRENT_LIST_DIR}" REALPATH)
get_filename_component(_realOrig "/usr/lib/cmake/Qt6Quick3DTools" REALPATH)
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

cmake_minimum_required(VERSION 3.16...3.21)

include(CMakeFindDependencyMacro)

# Find required dependencies, if any.
if(EXISTS "${CMAKE_CURRENT_LIST_DIR}/Qt6Quick3DToolsDependencies.cmake")
    include("${CMAKE_CURRENT_LIST_DIR}/Qt6Quick3DToolsDependencies.cmake")
endif()

# If *Dependencies.cmake exists, the variable value will be defined there.
# Don't override it in that case.
if(NOT DEFINED "Qt6Quick3DTools_FOUND")
    set("Qt6Quick3DTools_FOUND" TRUE)
endif()

set(__qt_Quick3DTools_should_include_targets_code "TRUE")

# Do the checks inside Targets.cmake even when the file is still being generated
if(__qt_Quick3DTools_should_include_targets_code)
    include("${CMAKE_CURRENT_LIST_DIR}/Qt6Quick3DToolsTargetsPrecheck.cmake")
endif()

if(NOT __qt_Quick3DTools_skip_include_targets_file
        AND Qt6Quick3DTools_FOUND
        AND __qt_Quick3DTools_should_include_targets_code
    )
    include("${CMAKE_CURRENT_LIST_DIR}/Qt6Quick3DToolsTargets.cmake")
    include("${CMAKE_CURRENT_LIST_DIR}/Qt6Quick3DToolsAdditionalTargetInfo.cmake")
    if(NOT QT_NO_CREATE_VERSIONLESS_TARGETS)
        include("${CMAKE_CURRENT_LIST_DIR}/Qt6Quick3DToolsVersionlessTargets.cmake")
    endif()
    set(__qt_Quick3DTools_targets_file_included ON)
endif()

set(__qt_Quick3DTools_extra_cmake_includes "")
foreach(extra_cmake_include IN LISTS __qt_Quick3DTools_extra_cmake_includes)
    include("${CMAKE_CURRENT_LIST_DIR}/${extra_cmake_include}")
endforeach()


if(__qt_Quick3DTools_targets_file_included AND Qt6Quick3DTools_FOUND)
    __qt_internal_promote_target_to_global(Qt6::balsam)
endif()

if(__qt_Quick3DTools_targets_file_included AND Qt6Quick3DTools_FOUND)
    __qt_internal_promote_target_to_global(Qt6::balsamui)
endif()

if(__qt_Quick3DTools_targets_file_included AND Qt6Quick3DTools_FOUND)
    __qt_internal_promote_target_to_global(Qt6::meshdebug)
endif()

if(__qt_Quick3DTools_targets_file_included AND Qt6Quick3DTools_FOUND)
    __qt_internal_promote_target_to_global(Qt6::shadergen)
endif()

if(__qt_Quick3DTools_targets_file_included AND Qt6Quick3DTools_FOUND)
    __qt_internal_promote_target_to_global(Qt6::particleshadergen)
endif()

if(__qt_Quick3DTools_targets_file_included AND Qt6Quick3DTools_FOUND)
    __qt_internal_promote_target_to_global(Qt6::instancer)
endif()

if(__qt_Quick3DTools_targets_file_included AND Qt6Quick3DTools_FOUND)
    __qt_internal_promote_target_to_global(Qt6::shapegen)
endif()

if(__qt_Quick3DTools_targets_file_included AND Qt6Quick3DTools_FOUND)
    __qt_internal_promote_target_to_global(Qt6::materialeditor)
endif()

if(__qt_Quick3DTools_targets_file_included AND Qt6Quick3DTools_FOUND)
    __qt_internal_promote_target_to_global(Qt6::lightmapviewer)
endif()
set(Qt6Quick3DTools_TARGETS "Qt6::balsam;Qt6::balsamui;Qt6::meshdebug;Qt6::shadergen;Qt6::particleshadergen;Qt6::instancer;Qt6::shapegen;Qt6::materialeditor;Qt6::lightmapviewer")
