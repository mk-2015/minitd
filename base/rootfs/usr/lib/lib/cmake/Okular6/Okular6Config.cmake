
####### Expanded from @PACKAGE_INIT@ by configure_package_config_file() #######
####### Any changes to this file will be overwritten by the next CMake run ####
####### The input file was Okular6Config.cmake.in                            ########

get_filename_component(PACKAGE_PREFIX_DIR "${CMAKE_CURRENT_LIST_DIR}/../../../" ABSOLUTE)

# Use original install prefix when loaded through a "/usr move"
# cross-prefix symbolic link such as /lib -> /usr/lib.
get_filename_component(_realCurr "${CMAKE_CURRENT_LIST_DIR}" REALPATH)
get_filename_component(_realOrig "/usr/lib/cmake/Okular6" REALPATH)
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

find_dependency(Qt6Core 6.6.0)
find_dependency(Qt6PrintSupport 6.6.0)
find_dependency(Qt6Widgets 6.6.0)
find_dependency(KF6CoreAddons )
find_dependency(KF6Config )
find_dependency(KF6XmlGui )

####################################################################################
# CMAKE_AUTOMOC

# CMake 3.9+ warns about automoc on files without Q_OBJECT, and doesn't know about other macros.
# 3.10+ lets us provide more macro names that require automoc.
foreach(macro_name  OKULAR_EXPORT_PLUGIN)
    # we can be run multiple times, so add only once
    list (FIND CMAKE_AUTOMOC_MACRO_NAMES "${macro_name}" _index)
    if(_index LESS 0)
        list(APPEND CMAKE_AUTOMOC_MACRO_NAMES ${macro_name})
    endif()
endforeach()

# CMake's automoc needs help to find names of plugin metadata files in case Q_PLUGIN_METADATA
# is indirectly used via other C++ preprocessor macros
foreach(macro_name  OKULAR_EXPORT_PLUGIN)
    # we can be run multiple times, so add only once
    list (FIND CMAKE_AUTOMOC_DEPEND_FILTERS "${macro_name}" _index)
    if(_index LESS 0)
        list(APPEND CMAKE_AUTOMOC_DEPEND_FILTERS
            "${macro_name}"
            "[\n^][ \t]*${macro_name}[ \t\n]*\\([^,]*,[ \t\n]*\"([^\"]+)\""
        )
    endif()
endforeach()

####################################################################################

include("${CMAKE_CURRENT_LIST_DIR}/Okular6Targets.cmake")
