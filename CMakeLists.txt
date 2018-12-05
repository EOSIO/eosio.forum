find_package(eosio.cdt)

cmake_minimum_required(VERSION 3.5)
project(eosio.forum VERSION 1.0.0)

add_contract(forum forum src/forum.cpp)

target_compile_options(forum.wasm PUBLIC -R${CMAKE_CURRENT_SOURCE_DIR}/resources)
target_include_directories(forum.wasm PUBLIC ${CMAKE_CURRENT_SOURCE_DIR}/include)
