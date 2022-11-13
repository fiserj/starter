set(SHADERC_RELATIVE_TOOL_DIR "${CMAKE_CURRENT_SOURCE_DIR}/../tools/shaderc")
get_filename_component(SHADERC_TOOL_DIR ${SHADERC_RELATIVE_TOOL_DIR} ABSOLUTE)

if(APPLE)
    set(SHADERC_TOOL_BUILD_SCRIPT "${SHADERC_TOOL_DIR}/osx/build.sh")
    set(SHADERC_TOOL_OUTPUT_BINARY "${SHADERC_TOOL_DIR}/osx/shaderc")
elseif(WIN32)
    set(SHADERC_TOOL_BUILD_SCRIPT "${SHADERC_TOOL_DIR}/windows/build.bat")
    set(SHADERC_TOOL_OUTPUT_BINARY "${SHADERC_TOOL_DIR}/windows/shaderc.exe")
else()
    message(FATAL_ERROR "Script compiling shaderc binary does not yet exist for this platform.")
endif()

get_filename_component(SHADERC_TOOL_WORKING_DIR ${SHADERC_TOOL_BUILD_SCRIPT} DIRECTORY)

add_custom_command(
    OUTPUT ${SHADERC_TOOL_OUTPUT_BINARY}
    COMMAND ${SHADERC_TOOL_BUILD_SCRIPT}
    WORKING_DIRECTORY ${SHADERC_TOOL_WORKING_DIR}
)

add_custom_target(shaderc
    DEPENDS ${SHADERC_TOOL_OUTPUT_BINARY}
)