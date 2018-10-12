cmake_minimum_required(VERSION 3.5)
project(eosio.forum VERSION 1.0.0)

set(CMAKE_EXPORT_COMPILE_COMMANDS ON)
set(EOSIO_CDT_DEPENDENCY "1.2")

if(EOSIO_CDT_ROOT STREQUAL "" OR NOT EOSIO_CDT_ROOT)
   set(EOSIO_CDT_ROOT "/usr/local/eosio.cdt")
endif()

list(APPEND CMAKE_MODULE_PATH ${EOSIO_CDT_ROOT}/lib/cmake)

include(EosioWasmToolchain)

configure_file("${CMAKE_CURRENT_SOURCE_DIR}/abi/forum.abi" "${CMAKE_CURRENT_BINARY_DIR}" COPYONLY)

add_executable(forum.wasm ${CMAKE_CURRENT_SOURCE_DIR}/src/forum.cpp)
target_include_directories(forum.wasm
   PUBLIC
   ${CMAKE_CURRENT_SOURCE_DIR}/include)

set_target_properties(forum.wasm
   PROPERTIES
   RUNTIME_OUTPUT_DIRECTORY "${CMAKE_CURRENT_BINARY_DIR}")

add_custom_command(TARGET forum.wasm POST_BUILD
    COMMAND ${CMAKE_COMMAND} -E copy $<TARGET_FILE:forum.wasm> "${CMAKE_CURRENT_SOURCE_DIR}/forum.wasm"
)