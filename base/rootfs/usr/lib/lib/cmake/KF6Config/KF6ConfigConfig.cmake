
####### Expanded from @PACKAGE_INIT@ by configure_package_config_file() #######
####### Any changes to this file will be overwritten by the next CMake run ####
####### The input file was KF6ConfigConfig.cmake.in                            ########

get_filename_component(PACKAGE_PREFIX_DIR "${CMAKE_CURRENT_LIST_DIR}/../../../" ABSOLUTE)

# Use original install prefix when loaded through a "/usr move"
# cross-prefix symbolic link such as /lib -> /usr/lib.
get_filename_component(_realCurr "${CMAKE_CURRENT_LIST_DIR}" REALPATH)
get_filename_component(_realOrig "/usr/lib/cmake/KF6Config" REALPATH)
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

include("${CMAKE_CURRENT_LIST_DIR}/KF6ConfigTargets.cmake")

include(CMakeFindDependencyMacro)

find_dependency(Qt6Core "6.9.0")

if(ON)
    find_dependency(Qt6Gui "6.9.0")
endif()

if(NOT TRUE)
    if(ON)
        find_dependency(Qt6DBus "6.9.0")
    endif()
endif()

if(ON)
    find_dependency(Qt6Qml "6.9.0")
endif()

if(CMAKE_CROSSCOMPILING AND KF6_HOST_TOOLING)
    find_file(KCONFIGCOMPILER_PATH KF6Config/KF6ConfigCompilerTargets.cmake
        PATHS ${KF6_HOST_TOOLING} ${CMAKE_CURRENT_LIST_DIR}
        NO_DEFAULT_PATH
        NO_CMAKE_FIND_ROOT_PATH)
    include("${KCONFIGCOMPILER_PATH}")
else()
    include("${CMAKE_CURRENT_LIST_DIR}/KF6ConfigCompilerTargets.cmake")
endif()
include("${CMAKE_CURRENT_LIST_DIR}/KF6ConfigMacros.cmake")
