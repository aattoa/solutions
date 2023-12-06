cmake_minimum_required(VERSION 3.24)
project(advent-of-code CXX)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_EXTENSIONS OFF)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

if (MSVC)
    add_compile_options("/W4")
else ()
    add_compile_options("-Wall" "-Wextra" "-Wpedantic")
endif ()

add_executable(1 1.cpp)
add_executable(2 2.cpp)
add_executable(3 3.cpp)
