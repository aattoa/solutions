cmake_minimum_required(VERSION 3.24)
project(advent-of-code CXX)

set(CMAKE_CXX_STANDARD 23)
set(CMAKE_CXX_EXTENSIONS OFF)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

if (MSVC)
    add_compile_options("/W4")
else ()
    add_compile_options("-Wall" "-Wextra" "-Wpedantic")
endif ()

include(FetchContent)
FetchContent_Declare(
    cpputil
    GIT_REPOSITORY https://github.com/aattoa/cpputil.git
    GIT_TAG        dabf5399fa82be60d695f006058881b1d228cb4d)
set(CPPUTIL_BUILD_TESTS OFF)
FetchContent_MakeAvailable(cpputil)

add_library(util STATIC util.hpp util.cpp)
target_link_libraries(util PUBLIC cpputil)
target_include_directories(util PUBLIC ${CMAKE_CURRENT_SOURCE_DIR})

function (add_day day)
    add_executable(${day} ${day}.cpp)
    target_link_libraries(${day} PRIVATE util)
endfunction ()

add_day(1)
add_day(2)
add_day(3)
