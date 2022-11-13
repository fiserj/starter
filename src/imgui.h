#pragma once

#include <imgui.h> // ImGui::*

struct GLFWwindow;

namespace ImGui
{

void PushMonoSpaceFont();

} // namespace ImGui

void imgui_init(GLFWwindow* window, unsigned short view_id, float font_size = 16.0f);

void imgui_shutdown();

void imgui_begin_frame();

void imgui_end_frame();
