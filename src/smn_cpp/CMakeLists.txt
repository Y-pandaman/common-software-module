cmake_minimum_required(VERSION 3.5)

# ##############################################################################
# CMake Project ##
# ##############################################################################

# include useful macros
include(${CMAKE_CURRENT_SOURCE_DIR}/cmake/util.cmake)


# read metadata from package.xml and setup project
zetton_cc_metadata()

# set project name and version
project(
  ${extracted_name}
  VERSION ${extracted_version}
  LANGUAGES C CXX)

# =========#
# Settings #
# =========#

# introduce default building settings
zetton_cc_settings()

set(EXTRA_DEPS "")
set(EXTRA_INCLUDES "")


# =============#
# Dependencies #
# =============#

# ----------------------#
# Third-party libraries #
# ----------------------#
include_directories(/home/bdca/lib/fmt/include/)

find_package(Threads REQUIRED)
find_package(Eigen3 REQUIRED)
find_package(OpenCV REQUIRED)
find_package(PkgConfig REQUIRED)
pkg_check_modules(GST REQUIRED gstreamer-1.0 gstreamer-app-1.0
                  gstreamer-rtsp-server-1.0)
find_package(fmt REQUIRED)
find_package(absl REQUIRED)
find_package(Catch2 REQUIRED)
find_package(OpenSSL REQUIRED)

# ##############################################################################
# Build ##
# ##############################################################################

# ==============#
# Build targets #
# ==============#

include(GenerateExportHeader)

# ---------------#
# Library target #
# ---------------#

# find all source files
file(GLOB_RECURSE src_files ${PROJECT_SOURCE_DIR}/src/*.cc
     ${PROJECT_SOURCE_DIR}/src/*/*.cc)

# common library
zetton_cc_library(
  NAME
  ${PROJECT_NAME}
  SRCS
  ${src_files}
  INCLUDES
  ${OpenCV_INCLUDE_DIRS}
  ${GST_INCLUDE_DIRS}
  ${OpenSSL_INCLUDE_DIR}
  ${EXTRA_INCLUDES}
  DEPS
  Threads::Threads
  Eigen3::Eigen
  ${OpenCV_LIBS}
  ${GST_LIBRARIES}
  fmt::fmt
  absl::flags
  absl::flags_parse
  ${OPENSSL_LIBRARIES}
  ${EXTRA_DEPS})

# copy the directory assets to ${CMAKE_INSTALL_PREFIX}/share/${PROJECT_NAME}
install(DIRECTORY ${PROJECT_SOURCE_DIR}/../../assets
        DESTINATION ${CMAKE_INSTALL_PREFIX}/share/${PROJECT_NAME})

# ------------------#
# Executable targets #
# ------------------#

zetton_cc_apps()
# zetton_cc_examples()

# -------------#
# Test targets #
# -------------#

include(CTest)
enable_testing()
zetton_cc_tests("utils")
zetton_cc_tests("core")
