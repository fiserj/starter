#include "imgui_impl_glfw_patched.h"

#include <imgui_impl_glfw.cpp>


bool ImGui_ImplGlfwPatched_Init(GLFWwindow* window)
{
    // TODO
    return ImGui_ImplGlfw_InitForOther(window, true);
}

void ImGui_ImplGlfwPatched_NewFrame()
{
    // TODO
    ImGui_ImplGlfw_NewFrame();
}
