cmake_minimum_required(VERSION 3.20)

project(StarterTemplate)

set(WITH_FMT     OFF)
set(WITH_GLEQ    OFF)
set(WITH_IMGUI   OFF)
set(WITH_MESHOPT OFF)
set(WITH_STB     OFF)

option(WITH_PREBUILT_SHADERC "Attempt to download prebuilt BGFX shader compiler." ON)

add_subdirectory(third_party)
add_subdirectory(src)