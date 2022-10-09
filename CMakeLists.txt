cmake_minimum_required(VERSION 3.20)

project(StarterTemplate)

set(WITH_GLEQ    OFF)
set(WITH_IMGUI   OFF)
set(WITH_MESHOPT OFF)
set(WITH_STB     OFF)

add_subdirectory(third_party)
add_subdirectory(src)