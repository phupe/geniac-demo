cmake_minimum_required(VERSION 3.10.2)

project(all4bamcmp LANGUAGES NONE)

set(CMAKE_BUILD_TYPE Release)

include(ExternalProject)

file(MAKE_DIRECTORY ${CMAKE_BINARY_DIR}/src)
### copy src folder in the build directory (this avoids files
### generated during the compilation to pollute the git folder
file(COPY ${CMAKE_CURRENT_SOURCE_DIR}/ DESTINATION ${CMAKE_BINARY_DIR}/src PATTERN ".git*" EXCLUDE)

##############
### htslib ###
##############

ExternalProject_Add(
    htslib
    SOURCE_DIR ${CMAKE_BINARY_DIR}/src/htslib
    CONFIGURE_COMMAND autoreconf && ./configure --prefix=${CMAKE_BINARY_DIR}/htslib
    BUILD_IN_SOURCE ON
    BUILD_COMMAND     make
    INSTALL_COMMAND   make install
   )

install(DIRECTORY ${CMAKE_BINARY_DIR}/htslib
        DESTINATION ${CMAKE_INSTALL_PREFIX})

##############
### bamcmp ###
##############

ExternalProject_Add(
    bamcmp
    SOURCE_DIR ${CMAKE_BINARY_DIR}/src/bamcmp
    CONFIGURE_COMMAND HTSLIBDIR=${CMAKE_BINARY_DIR}/htslib make
    BUILD_IN_SOURCE ON
    BUILD_COMMAND     ""
    INSTALL_COMMAND   ""
    DEPENDS htslib
   )

### bamcmp executable
install(FILES ${CMAKE_BINARY_DIR}/src/bamcmp/build/bamcmp DESTINATION ${CMAKE_INSTALL_PREFIX}/bamcmpbin PERMISSIONS OWNER_READ GROUP_READ OWNER_EXECUTE GROUP_EXECUTE WORLD_READ WORLD_EXECUTE)

### bash wrapper for bamcmp with LD_LIBRARY_PATH set with htslib
install(FILES ${CMAKE_BINARY_DIR}/src/bamcmp.sh DESTINATION ${CMAKE_INSTALL_PREFIX} RENAME bamcmp PERMISSIONS OWNER_READ GROUP_READ OWNER_EXECUTE GROUP_EXECUTE WORLD_READ WORLD_EXECUTE)


