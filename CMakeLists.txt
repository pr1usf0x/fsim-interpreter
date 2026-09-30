cmake_minimum_required(VERSION 3.11)

project(toy_vm)
set(TARGET toy_vm)

set(CMAKE_EXPORT_COMPILE_COMMANDS ON CACHE BOOL
    "Generate compile_commands.json" FORCE)

if(MSVC)
    set(CMAKE_CXX_FLAGS "-O2 -Wall")
else()
    set(CMAKE_CXX_FLAGS "-O2 -Wall -Wextra -std=c++20")
endif()

set(CMAKE_CXX_STANDARD 20)

# ===== deps =====

include(FetchContent)
FetchContent_Declare(
  googletest
  URL https://github.com/google/googletest/archive/03597a01ee50ed33e9dfd640b249b4be3799d395.zip
)
# For Windows: Prevent overriding the parent project's compiler/linker settings
set(gtest_force_shared_crt ON CACHE BOOL "" FORCE)

FetchContent_Declare(
  cli11
  URL https://github.com/CLIUtils/CLI11/archive/refs/tags/v2.7.2.zip
)

FetchContent_MakeAvailable(googletest cli11)

# ===== intreptretator =====

add_executable(${TARGET})
target_include_directories(${TARGET} PRIVATE ${CMAKE_CURRENT_SOURCE_DIR}/include)
target_link_libraries(${TARGET} PRIVATE CLI11::CLI11)

add_subdirectory(${CMAKE_CURRENT_SOURCE_DIR}/src)

# ===== tests =====

enable_testing()
add_subdirectory(${CMAKE_CURRENT_SOURCE_DIR}/tests)



