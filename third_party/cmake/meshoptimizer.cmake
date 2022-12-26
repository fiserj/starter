set(MESHOPT_DIR ${meshoptimizer_SOURCE_DIR}/src)

set(MESHOPT_SOURCE_FILES
    ${MESHOPT_DIR}/indexgenerator.cpp
    ${MESHOPT_DIR}/meshoptimizer.h
    ${MESHOPT_DIR}/overdrawoptimizer.cpp
    ${MESHOPT_DIR}/vcacheoptimizer.cpp
)

add_library(meshoptimizer STATIC
    ${MESHOPT_SOURCE_FILES}
)

target_include_directories(meshoptimizer PUBLIC
    ${MESHOPT_DIR}
)

set_target_properties(meshoptimizer PROPERTIES
    CXX_STANDARD 20
    CXX_EXTENSIONS OFF
    CXX_STANDARD_REQUIRED ON
    FOLDER "Third Party"
)