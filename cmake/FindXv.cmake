############################################################################
# FindXv.txt
# Copyright (C) 2014  Belledonne Communications, Grenoble France
#
############################################################################
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
#
############################################################################
#
# - Find the Xv include file and library
#
#  XV_FOUND - system has Xv
#  XV_INCLUDE_DIRS - the Xv include directory
#  XV_LIBRARIES - The libraries needed to use Xv

include(CheckIncludeFile)
include(CheckSymbolExists)

find_package(X11 REQUIRED)

set(_XV_ROOT_PATHS
	${WITH_XV}
	${CMAKE_INSTALL_PREFIX}
)

find_path(XV_INCLUDE_DIRS
	NAMES X11/extensions/Xv.h
	HINTS _XV_ROOT_PATHS
	PATH_SUFFIXES include
)
if(XV_INCLUDE_DIRS)
	check_include_file(X11/extensions/Xv.h HAVE_X11_EXTENSIONS_XV_H)
	check_include_file(X11/extensions/Xvlib.h HAVE_X11_EXTENSIONS_XVLIB_H)
endif()

find_library(XV_LIBRARIES
	NAMES Xv
	HINTS _XV_ROOT_PATHS
	PATH_SUFFIXES bin lib
)

if(XV_LIBRARIES)
	check_symbol_exists(XvCreateImage X11/extensions/Xv.h HAVE_XV_CREATE_IMAGE)
endif()

set(XV_INCLUDE_DIRS ${XV_INCLUDE_DIRS} ${X11_INCLUDE_DIRS})
set(XV_LIBRARIES ${XV_LIBRARIES} ${X11_LIBRARIES})
list(REMOVE_DUPLICATES XV_INCLUDE_DIRS)
list(REMOVE_DUPLICATES XV_LIBRARIES)

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(Xv
	DEFAULT_MSG
	XV_INCLUDE_DIRS HAVE_X11_EXTENSIONS_XV_H HAVE_X11_EXTENSIONS_XVLIB_H XV_LIBRARIES HAVE_XV_CREATE_IMAGE
)

mark_as_advanced(XV_INCLUDE_DIRS HAVE_X11_EXTENSIONS_XV_H HAVE_X11_EXTENSIONS_XVLIB_H XV_LIBRARIES HAVE_XV_CREATE_IMAGE)