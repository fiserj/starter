#include "imgui_impl_bgfx.h"

#include <stdint.h>               // uint*_t

#include <bgfx/bgfx.h>            // bgfx::*
#include <bgfx/embedded_shader.h> // BGFX_EMBEDDED_SHADER

#include <imgui.h>                // GetCurrentContext, GetIO

#include <shaders/imgui_fs.h>     // imgui_fs_*
#include <shaders/imgui_vs.h>     // imgui_vs_

struct ImGui_ImplBgfx_Data
{
    bgfx::VertexLayout  layout;
    bgfx::ProgramHandle program = BGFX_INVALID_HANDLE;
    bgfx::UniformHandle sampler = BGFX_INVALID_HANDLE;
    bgfx::TextureHandle texture = BGFX_INVALID_HANDLE;
    bgfx::ViewId        view_id;
};

static ImGui_ImplBgfx_Data* ImGui_ImplBgfx_GetBackendData()
{
    IM_ASSERT(ImGui::GetCurrentContext() != nullptr);

    void* bd = ImGui::GetIO().BackendRendererUserData;
    IM_ASSERT(bd != nullptr);

    return reinterpret_cast<ImGui_ImplBgfx_Data*>(bd);
}

bool ImGui_ImplBgfx_Init(unsigned short view_id)
{
    IM_ASSERT(view_id < bgfx::getCaps()->limits.maxViews);

    ImGuiIO& io = ImGui::GetIO();
    IM_ASSERT(io.BackendRendererUserData == nullptr);

    ImGui_ImplBgfx_Data* bd = IM_NEW(ImGui_ImplBgfx_Data)();
    io.BackendRendererUserData = bd;
    io.BackendRendererName     = "imgui_impl_bgfx";

    bd->view_id = bgfx::ViewId(view_id);
    bd->layout
        .begin()
        .add(bgfx::Attrib::Position , 2, bgfx::AttribType::Float)
        .add(bgfx::Attrib::TexCoord0, 2, bgfx::AttribType::Float)
        .add(bgfx::Attrib::Color0   , 4, bgfx::AttribType::Uint8, true)
        .end();

    return true;
}

void ImGui_ImplBgfx_Shutdown()
{
    ImGui_ImplBgfx_DestroyDeviceObjects();

    ImGuiIO& io = ImGui::GetIO();
    io.BackendRendererUserData = nullptr;
    io.BackendRendererName     = nullptr;

    ImGui_ImplBgfx_Data* bd = ImGui_ImplBgfx_GetBackendData();
    IM_DELETE(bd);
}

void ImGui_ImplBgfx_NewFrame()
{
    const ImGui_ImplBgfx_Data* bd = ImGui_ImplBgfx_GetBackendData();

    if (!bgfx::isValid(bd->program))
    {
        (void)ImGui_ImplBgfx_CreateDeviceObjects();
    }
}

void ImGui_ImplBgfx_RenderDrawData(ImDrawData* draw_data)
{
    // ...
}

bool ImGui_ImplBgfx_CreateFontsTexture()
{
    uint8_t* data;
    int      width, height;
    ImGui::GetIO().Fonts->GetTexDataAsAlpha8(&data, &width, &height);

    ImGui_ImplBgfx_Data* bd = ImGui_ImplBgfx_GetBackendData();
    bd->texture = bgfx::createTexture2D(
        uint16_t(width),
        uint16_t(height),
        false,
        1,
        bgfx::TextureFormat::RGBA8,
        0,
        bgfx::copy(data, uint32_t(width) * uint32_t(height))
    );
    IM_ASSERT(bgfx::isValid(bd->texture));

    return bgfx::isValid(bd->texture);
}

void ImGui_ImplBgfx_DestroyFontsTexture()
{
    ImGui_ImplBgfx_Data* bd = ImGui_ImplBgfx_GetBackendData();

    if (bgfx::isValid(bd->texture))
    {
        bgfx::destroy(bd->texture);
    }
}

bool ImGui_ImplBgfx_CreateDeviceObjects()
{
    ImGui_ImplBgfx_Data* bd = ImGui_ImplBgfx_GetBackendData();

    if (!bgfx::isValid(bd->texture))
    {
        ImGui_ImplBgfx_CreateFontsTexture();
    }

    bd->sampler = bgfx::createUniform("s_texture", bgfx::UniformType::Sampler);
    IM_ASSERT(bgfx::isValid(bd->sampler));

    const bgfx::EmbeddedShader shaders[] =
    {
        BGFX_EMBEDDED_SHADER(imgui_fs),
        BGFX_EMBEDDED_SHADER(imgui_vs),

        BGFX_EMBEDDED_SHADER_END()
    };
    bd->program = bgfx::createProgram(
        bgfx::createEmbeddedShader(shaders, bgfx::getRendererType(), "imgui_vs"),
        bgfx::createEmbeddedShader(shaders, bgfx::getRendererType(), "imgui_fs"),
        true
    );
    IM_ASSERT(bgfx::isValid(bd->program));

    return
        bgfx::isValid(bd->program) &&
        bgfx::isValid(bd->sampler) &&
        bgfx::isValid(bd->texture);
}

void ImGui_ImplBgfx_DestroyDeviceObjects()
{
    ImGui_ImplBgfx_DestroyFontsTexture();

    ImGui_ImplBgfx_Data* bd = ImGui_ImplBgfx_GetBackendData();

    if (bgfx::isValid(bd->program))
    {
        bgfx::destroy(bd->program);
    }

    if (bgfx::isValid(bd->sampler))
    {
        bgfx::destroy(bd->sampler);
    }
}
