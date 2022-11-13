#include "imgui.h"

#include <imgui_impl_bgfx.h> // ImGui_ImplBgfx_*
#include <imgui_impl_glfw.h> // ImGui_ImplGlfw_*

void imgui_init(GLFWwindow* window, unsigned short view_id, float /* font_size */)
{
    IMGUI_CHECKVERSION();

    ImGui::CreateContext();

    ImGuiIO& io = ImGui::GetIO();
    io.ConfigFlags |= ImGuiConfigFlags_NavEnableKeyboard;
    io.ConfigFlags |= ImGuiConfigFlags_DockingEnable;
    io.IniFilename  = nullptr;

    ImGui::StyleColorsDark();

    ImGui_ImplGlfw_InitForOther(window, true);
    ImGui_ImplBgfx_Init(view_id);

    io.Fonts->AddFontDefault();
}

void imgui_shutdown()
{
    ImGui_ImplBgfx_Shutdown();
    ImGui_ImplGlfw_Shutdown();

    ImGui::DestroyContext();
}

void imgui_begin_frame()
{
    ImGui_ImplBgfx_NewFrame();
    ImGui_ImplGlfw_NewFrame();

    ImGui::NewFrame();
}

void imgui_end_frame()
{
    ImGui::Render();
    ImGui_ImplBgfx_RenderDrawData(ImGui::GetDrawData());
}
