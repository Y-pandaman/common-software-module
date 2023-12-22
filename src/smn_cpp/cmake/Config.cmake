# - Config file for the software_module_name package
# It defines the following variable
# software_module_LIBRARIES - libraries to link against

include(CMakeFindDependencyMacro)

# Find dependencies
# find_dependency(zetton_common REQUIRED)
# find_dependency(zetton_stream REQUIRED)
# find_dependency(zetton_stream_gst REQUIRED)
find_package(Threads REQUIRED)
find_package(Eigen3 REQUIRED)
find_package(OpenCV 4 REQUIRED)
find_package(PkgConfig REQUIRED)
pkg_check_modules(GST REQUIRED gstreamer-1.0 gstreamer-app-1.0
                  gstreamer-rtsp-server-1.0)
find_package(fmt REQUIRED)
find_package(Catch2 REQUIRED)
find_package(OpenSSL REQUIRED)

# Our library dependencies (contains definitions for IMPORTED targets)
include("${CMAKE_CURRENT_LIST_DIR}/@PROJECT_NAME@Targets.cmake")

# These are IMPORTED targets created by @PROJECT_NAME@Targets.cmake
set(software_module_LIBRARIES @PROJECT_NAME@::@PROJECT_NAME@)
