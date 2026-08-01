
####### Expanded from @PACKAGE_INIT@ by configure_package_config_file() #######
####### Any changes to this file will be overwritten by the next CMake run ####
####### The input file was Plasma5SupportConfig.cmake.in                            ########

get_filename_component(PACKAGE_PREFIX_DIR "${CMAKE_CURRENT_LIST_DIR}/../../../" ABSOLUTE)

# Use original install prefix when loaded through a "/usr move"
# cross-prefix symbolic link such as /lib -> /usr/lib.
get_filename_component(_realCurr "${CMAKE_CURRENT_LIST_DIR}" REALPATH)
get_filename_component(_realOrig "/usr/lib/cmake/Plasma5Support" REALPATH)
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

# Any changes in this ".cmake" file will be overwritten by CMake, the source is the ".cmake.in" file.

include("${CMAKE_CURRENT_LIST_DIR}/Plasma5SupportTargets.cmake")


set(Plasma5Support_INSTALL_PREFIX "${PACKAGE_PREFIX_DIR}")

set(Plasma5Support_LIBRARIES Plasma::Plasma5Support)

set(PLASMA5SUPPORT_DATAENGINES_PLUGINDIR ${KDE_INSTALL_PLUGINDIR}/plasma5support/dataengine)

include(CMakeFindDependencyMacro)
find_dependency(Qt6Gui "6.10.0")
find_dependency(KF6CoreAddons "6.26.0")
find_dependency(KF6Service "6.26.0")

include("${CMAKE_CURRENT_LIST_DIR}/Plasma5SupportMacros.cmake")
