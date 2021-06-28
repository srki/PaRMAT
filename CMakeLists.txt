cmake_minimum_required(VERSION 3.18)

project(PaRMAT
        VERSION 0.1
        DESCRIPTION "PaRMAT is a multi-threaded RMAT graph generator."
        LANGUAGES C CXX)

if (CMAKE_PROJECT_NAME STREQUAL PROJECT_NAME)
    set(CMAKE_CXX_EXTENSIONS OFF)
endif ()


add_library(parmat
        src/Edge.cpp
        src/GraphGen_notSorted.cpp
        src/GraphGen_sorted.cpp
        src/Square.cpp
        src/utils.cpp)

target_include_directories(parmat PUBLIC ${PROJECT_SOURCE_DIR}/include)

find_package(Threads REQUIRED)
target_link_libraries(parmat PRIVATE ${CMAKE_THREAD_LIBS_INIT})

add_executable(PaRMAT src/PaRMAT.cpp)
target_link_libraries(PaRMAT PRIVATE parmat)