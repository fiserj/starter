#pragma once

struct ImDrawData;

bool ImGui_ImplBgfx_Init(unsigned short view_id);

void ImGui_ImplBgfx_Shutdown();

void ImGui_ImplBgfx_NewFrame();

void ImGui_ImplBgfx_RenderDrawData(ImDrawData* draw_data);
