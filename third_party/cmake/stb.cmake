add_library(stb INTERFACE)

target_include_directories(stb INTERFACE
    ${stb_SOURCE_DIR}
)

set_target_properties(stb PROPERTIES
    FOLDER "Third Party"
)