
####### Expanded from @PACKAGE_INIT@ by configure_package_config_file() #######
####### Any changes to this file will be overwritten by the next CMake run ####
####### The input file was KF6CoreAddonsConfig.cmake.in                            ########

get_filename_component(PACKAGE_PREFIX_DIR "${CMAKE_CURRENT_LIST_DIR}/../../../" ABSOLUTE)

# Use original install prefix when loaded through a "/usr move"
# cross-prefix symbolic link such as /lib -> /usr/lib.
get_filename_component(_realCurr "${CMAKE_CURRENT_LIST_DIR}" REALPATH)
get_filename_component(_realOrig "/usr/lib/cmake/KF6CoreAddons" REALPATH)
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
find_dependency(Qt6Core 6.9.0)

if(NOT TRUE)
    if(NOT WIN32)
        find_dependency(Threads)
    endif()

    # Should be if(Inotify_FOUND) here, but for some reason this doesn't work when building statically
    # due to ECM's FindInotify.cmake misbehavior — see https://bugs.kde.org/show_bug.cgi?id=460656 for details.
    # This workaround stops CMake from failing on Linux by relying on the fact that Inotify is built into
    # kernel there, so no additional linking is required, resulting in an empty Inotify_LIBRARIES var.
    # The issue (most likely) persists on BSD, though, where Inotify is, in fact, provided by a library.
    if()
        find_dependency(Inotify)
    endif()

    if()
        find_dependency(Procstat)
    endif()

    if(1)
        find_dependency(Qt6DBus 6.9.0)
    endif()

    if (TRUE)
        find_dependency(UDev)
    endif()

    if (TRUE)
        find_dependency(LibMount)
    endif()
endif()

####################################################################################
# CMAKE_AUTOMOC

# CMake 3.9+ warns about automoc on files without Q_OBJECT, and doesn't know about other macros.
# 3.10+ lets us provide more macro names that require automoc.
foreach(macro_name  K_PLUGIN_FACTORY;K_PLUGIN_CLASS;K_PLUGIN_FACTORY_WITH_JSON;K_PLUGIN_CLASS_WITH_JSON)
    # we can be run multiple times, so add only once
    list (FIND CMAKE_AUTOMOC_MACRO_NAMES "${macro_name}" _index)
    if(_index LESS 0)
        list(APPEND CMAKE_AUTOMOC_MACRO_NAMES ${macro_name})
    endif()
endforeach()

####################################################################################

include("${CMAKE_CURRENT_LIST_DIR}/KF6CoreAddonsTargets.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/KF6CoreAddonsMacros.cmake")
