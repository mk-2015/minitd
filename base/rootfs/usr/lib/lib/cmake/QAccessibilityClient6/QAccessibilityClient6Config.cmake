
####### Expanded from @PACKAGE_INIT@ by configure_package_config_file() #######
####### Any changes to this file will be overwritten by the next CMake run ####
####### The input file was QAccessibilityClientConfig.cmake.in                            ########

get_filename_component(PACKAGE_PREFIX_DIR "${CMAKE_CURRENT_LIST_DIR}/../../../" ABSOLUTE)

# Use original install prefix when loaded through a "/usr move"
# cross-prefix symbolic link such as /lib -> /usr/lib.
get_filename_component(_realCurr "${CMAKE_CURRENT_LIST_DIR}" REALPATH)
get_filename_component(_realOrig "/usr/lib/cmake/QAccessibilityClient6" REALPATH)
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
find_dependency(Qt6Core )
find_dependency(Qt6Widgets )

# Thanks to the generated exported target, simply use qaccessibilityclient
# e.g. target_link_libraries(mytarget qaccessibilityclient)
include("${CMAKE_CURRENT_LIST_DIR}/QAccessibilityClient6Targets.cmake")

# Backward compatibility:
set(QACCESSIBILITYCLIENT_VERSION_MAJOR 0)
set(QACCESSIBILITYCLIENT_VERSION_MINOR 6)
set(QACCESSIBILITYCLIENT_VERSION_PATCH 0)
set(QACCESSIBILITYCLIENT_VERSION 0.6.0)

get_target_property(QACCESSIBILITYCLIENT_INCLUDE_DIR QAccessibilityClient6 INTERFACE_INCLUDE_DIRECTORIES)
set(QACCESSIBILITYCLIENT_LIBRARY QAccessibilityClient6)

