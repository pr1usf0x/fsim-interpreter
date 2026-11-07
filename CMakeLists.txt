cmake_minimum_required(VERSION 3.11)

project(toy_vm)

set(CMAKE_EXPORT_COMPILE_COMMANDS ON CACHE BOOL
    "Generate compile_commands.json" FORCE)
option(THREADED_CODE "Enable threaded code" ON)

include(FetchContent)
function(fetch_if_not_available PKG DOWNLOAD_URL)
    find_package(${PKG} QUIET)
    if(NOT ${PKG}_FOUND)
        include(FetchContent)
        FetchContent_Declare(${PKG}_fetchcontent
            URL ${DOWNLOAD_URL}
        )
        FetchContent_MakeAvailable(${PKG}_fetchcontent)
  endif()
endfunction()

set(CMAKE_CXX_FLAGS "-DLLVM_DISABLE_ABI_BREAKING_CHECKS_ENFORCING -O2 -Wall -Wextra -std=c++23")

set(CMAKE_CXX_STANDARD 23)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)

# ===== deps =====

fetch_if_not_available(
  googletest
  https://github.com/google/googletest/archive/03597a01ee50ed33e9dfd640b249b4be3799d395.zip
)

fetch_if_not_available(
  cli11
  https://github.com/CLIUtils/CLI11/archive/refs/tags/v2.7.2.zip
)

fetch_if_not_available(
  elfio
  https://github.com/serge1/ELFIO/archive/refs/tags/Release_3.12.zip
)

find_package(LLVM REQUIRED CONFIG)
include_directories(${LLVM_INCLUDE_DIRS})
separate_arguments(LLVM_DEFINITIONS_LIST NATIVE_COMMAND ${LLVM_DEFINITIONS})
add_definitions(${LLVM_DEFINITIONS_LIST})
llvm_map_components_to_libnames(llvm_libs support core irreader orcjit native)
# ===== intreptretator =====

add_subdirectory(${CMAKE_CURRENT_SOURCE_DIR}/src)

# ===== tests =====

enable_testing()
add_subdirectory(${CMAKE_CURRENT_SOURCE_DIR}/tests)



