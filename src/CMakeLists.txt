set(TARGET_SOURCES
    ${CMAKE_CURRENT_SOURCE_DIR}/main.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/decoder.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/executor.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/kernel.cpp)

target_sources(${TARGET} PRIVATE ${TARGET_SOURCES})

