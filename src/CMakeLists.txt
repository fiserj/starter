set(NAME ${CMAKE_PROJECT_NAME})

if(APPLE)
    set(EXT mm)
else()
    set(EXT cpp)
endif()

add_executable(${NAME}
    "main.${EXT}"
)

set(LIBRARY_LIST
    bgfx
    glfw
)

if(WITH_FMT)
    list(APPEND LIBRARY_LIST fmt)
endif()

if(WITH_GLEQ)
    list(APPEND LIBRARY_LIST gleq)
endif()

if(WITH_IMGUI)
    list(APPEND LIBRARY_LIST imgui)
endif()

if(WITH_MESHOPT)
    list(APPEND LIBRARY_LIST meshoptimizer)
endif()

if(WITH_STB)
    list(APPEND LIBRARY_LIST stb)
endif()

target_link_libraries(${NAME} PRIVATE
    ${LIBRARY_LIST}
)

if(MSVC)
    target_compile_definitions(${NAME} PRIVATE
        _CRT_SECURE_NO_WARNINGS
    )

    target_compile_options(${NAME} PRIVATE
        /Wall
    )
else()
    target_compile_options(${NAME} PRIVATE
        -Wall
        -Wextra
        -Wpedantic
    )
endif()

set_target_properties(${NAME} PROPERTIES
    CXX_STANDARD 20
    CXX_EXTENSIONS OFF
    CXX_STANDARD_REQUIRED ON
    DEBUG_POSTFIX "_d"
    RUNTIME_OUTPUT_DIRECTORY "${CMAKE_SOURCE_DIR}/bin$<$<CONFIG:Debug>:>"
)

include(cmake/add_shader_dependency.cmake)

add_shader_dependency(${NAME} "shaders/position_color.vs")
add_shader_dependency(${NAME} "shaders/position_color.fs")

if(WITH_IMGUI)
    add_shader_dependency(${NAME} "shaders/imgui.vs" "shaders/imgui.varying.def.sc")
    add_shader_dependency(${NAME} "shaders/imgui.fs" "shaders/imgui.varying.def.sc")
endif()