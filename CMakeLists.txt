cmake_minimum_required(VERSION 3.5)
project(FORUM VERSION 1.0.0)

set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

if(WASM_ROOT STREQUAL "" OR NOT WASM_ROOT)
    set(WASM_ROOT ${CMAKE_INSTALL_PREFIX})
endif()
list(APPEND CMAKE_MODULE_PATH ${WASM_ROOT}/lib/cmake)

include(EosioWasmToolchain)

add_executable( forum.wasm src/forum.hpp src/forum.cpp )
