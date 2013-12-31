find_package(PkgConfig)

pkg_check_modules(PC_GLEW QUIET glew)

set(GLEW_STANDARD_DEFINITIONS ${PC_GLEW_DEFINITIONS}
	CACHE STRING
	"GLEW required CFLAGS")
set(GLEW_STATIC_DEFINITIONS ${PC_GLEW_STATIC_DEFINITIONS}
	CACHE STRING
	"GLEW static required CFLAGS")

find_path(GLEW_STANDARD_INCLUDE_DIR GL/glew.h
	HINTS ${PC_GLEW_INCLUDEDIR}
	      ${PC_GLEW_INCLUDE_DIRS})
find_path(GLEW_STATIC_INCLUDE_DIR GL/glew.h
	HINTS ${PC_GLEW_STATIC_INCLUDEDIR}
	      ${PC_GLEW_STATIC_INCLUDE_DIRS})

find_library(GLEW_STANDARD_LIBRARY
	NAMES ${PC_GLEW_LIBRARIES} GLEW glew32 glew glew32s
	HINTS ${PC_GLEW_LIBDIR}
	      ${PC_GLEW_LIBRARY_DIRS}
	PATH_SUFFIXES lib64)
set(lib_suffixes ${CMAKE_FIND_LIBRARY_SUFFIXES})
set(CMAKE_FIND_LIBRARY_SUFFIXES ${CMAKE_STATIC_LIBRARY_SUFFIX}
	${CMAKE_DYNAMIC_LIBRARY_SUFFIX} ${CMAKE_SHARED_OBJECT_SUFFIX})
find_library(GLEW_STATIC_LIBRARY
	NAMES ${PC_GLEW_STATIC_LIBRARIES} GLEW glew32 glew glew32s
	HINTS ${PC_GLEW_STATIC_LIBDIR}
	      ${PC_GLEW_STATIC_LIBRARY_DIRS}
	PATH_SUFFIXES lib64)
set(CMAKE_FIND_LIBRARY_SUFFIXES ${lib_suffixes})
unset(lib_suffixes)

if(GLEW_FIND_COMPONENTS AND
		GLEW_FIND_COMPONENTS STREQUAL "static")
	set(GLEW_DEFINITION ${GLEW_STATIC_DEFINITIONS})
	set(GLEW_INCLUDE_DIR ${GLEW_STATIC_INCLUDE_DIR})
	set(GLEW_LIBRARY ${GLEW_STATIC_LIBRARY})
else()
	set(GLEW_DEFINITION ${GLEW_STANDARD_DEFINITIONS})
	set(GLEW_INCLUDE_DIR ${GLEW_STANDARD_INCLUDE_DIR})
	set(GLEW_LIBRARY ${GLEW_STANDARD_LIBRARY})
endif()

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(GLEW STANDARD_MESSAGE
	GLEW_INCLUDE_DIR GLEW_LIBRARY)

if(GLEW_FOUND)
	set(GLEW_DEFINITIONS ${GLEW_DEFINITION})
	set(GLEW_INCLUDE_DIRS ${GLEW_INCLUDE_DIR})
	set(GLEW_LIBRARIES ${GLEW_LIBRARY})
endif()

mark_as_advanced(
	GLEW_STANDARD_DEFINITIONS
	GLEW_STANDARD_INCLUDE_DIR
	GLEW_STANDARD_LIBRARY

	GLEW_STATIC_DEFINITIONS
	GLEW_STATIC_INCLUDE_DIR
	GLEW_STATIC_LIBRARY)