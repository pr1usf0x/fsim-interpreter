set(TARGET_SOURCES
    ${CMAKE_CURRENT_SOURCE_DIR}/main.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/decoder.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/executor.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/kernel.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/llvm/builder_wrapper.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/llvm/module_compiler.cpp)

set(TARGET toy_vm)
add_executable(${TARGET})
target_include_directories(${TARGET} PRIVATE ${PROJECT_SOURCE_DIR}/include)
target_sources(${TARGET} PRIVATE ${TARGET_SOURCES})
target_link_libraries(${TARGET} PRIVATE CLI11::CLI11 elfio::elfio ${llvm_libs})

if (${THREADED_CODE})
    target_compile_definitions(${TARGET} PRIVATE -DTHREADED_CODE)
endif()

