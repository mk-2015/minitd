
####### Expanded from @PACKAGE_INIT@ by configure_package_config_file() #######
####### Any changes to this file will be overwritten by the next CMake run ####
####### The input file was Config.cmake.in                            ########

get_filename_component(PACKAGE_PREFIX_DIR "${CMAKE_CURRENT_LIST_DIR}/../../../" ABSOLUTE)

# Use original install prefix when loaded through a "/usr move"
# cross-prefix symbolic link such as /lib -> /usr/lib.
get_filename_component(_realCurr "${CMAKE_CURRENT_LIST_DIR}" REALPATH)
get_filename_component(_realOrig "/usr/lib/cmake/wolfssl" REALPATH)
if(_realCurr STREQUAL _realOrig)
  set(PACKAGE_PREFIX_DIR "/usr")
endif()
unset(_realOrig)
unset(_realCurr)

####################################################################################
# Autoconf-generated configs won't define PACKAGE_PREFIX_DIR; fall back to the
# configured install prefix for non-relocatable packages.
if (NOT DEFINED PACKAGE_PREFIX_DIR)
  set(PACKAGE_PREFIX_DIR "")
endif()

include(CMakeFindDependencyMacro)
if (1)
  find_dependency(Threads)
endif()


include ( "${CMAKE_CURRENT_LIST_DIR}/wolfssl-targets.cmake" )
