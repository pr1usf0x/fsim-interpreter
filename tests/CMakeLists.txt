set(TEST_TARGET_SOURCES ${CMAKE_CURRENT_SOURCE_DIR}/decoder_test.cpp
                        ${CMAKE_CURRENT_SOURCE_DIR}/execution_test.cpp
                        ${PROJECT_SOURCE_DIR}/src/cpu.cpp)
include(GoogleTest)

set(TEST_TARGET toy_vm_test)
add_executable(${TEST_TARGET})
target_sources(${TEST_TARGET} PRIVATE ${TEST_TARGET_SOURCES})
target_compile_definitions(${TEST_TARGET} PRIVATE -DENABLE_TEST)
target_include_directories(${TEST_TARGET} PRIVATE ${PROJECT_SOURCE_DIR}/include)
target_link_libraries(${TEST_TARGET} PRIVATE GTest::gtest_main)
gtest_discover_tests(${TEST_TARGET})