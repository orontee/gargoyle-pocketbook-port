cmake_minimum_required(VERSION 3.25)

project(
  gpp
  VERSION 0.0.1
  DESCRIPTION "Port of Gargoyle interactive fiction player to PocketBook e-readers"
  HOMEPAGE_URL https://github.com/orontee/gargoyle-pocketbook-port
)

if(NOT CMAKE_SYSTEM_NAME STREQUAL "Linux")
  message(FATAL_ERROR "Platform not supported")
endif()

if(PROJECT_SOURCE_DIR STREQUAL PROJECT_BINARY_DIR)
  message(FATAL_ERROR "In-source builds are not allowed")
endif()

if(NOT PB_PLATFORM STREQUAL "ARM")
  message(FATAL_ERROR "Has env_set.sh been called and sourced?")
endif()

include(FetchContent)

add_subdirectory(src gpp)
