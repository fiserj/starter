#include <stdint.h>                    // *int*_t

#include <bgfx/bgfx.h>                 // bgfx::*

#include <bx/bx.h>                     // BX_CONCATENATE
#include <bx/platform.h>               // BX_PLATFORM_*

#define GLFW_INCLUDE_NONE
#include <GLFW/glfw3.h>                // glfw*

#if BX_PLATFORM_LINUX
#   define GLFW_EXPOSE_NATIVE_X11
#   define GLFW_EXPOSE_NATIVE_GLX
#elif BX_PLATFORM_OSX
#   define GLFW_EXPOSE_NATIVE_COCOA
#   define GLFW_EXPOSE_NATIVE_NSGL
#elif BX_PLATFORM_WINDOWS
#   define GLFW_EXPOSE_NATIVE_WIN32
#   define GLFW_EXPOSE_NATIVE_WGL
#endif
#include <GLFW/glfw3native.h>          // glfwGetX11Display, glfwGet*Window

template <typename Func>
struct Deferred
{
    Func func;

    Deferred(const Deferred&) = delete;

    Deferred& operator=(const Deferred&) = delete;

    Deferred(Func&& func)
        : func(static_cast<Func&&>(func))
    {
    }

    ~Deferred()
    {
        func();
    }
};

template <typename Func>
Deferred<Func> make_deferred(Func&& func)
{
    return ::Deferred<Func>(static_cast<decltype(func)>(func));
}

#define defer(...) auto BX_CONCATENATE(deferred_ , __LINE__) = \
    ::make_deferred([&]() mutable { __VA_ARGS__; })

#if BX_PLATFORM_OSX
#   import <Cocoa/Cocoa.h>             // NSWindow
#   import <QuartzCore/CAMetalLayer.h> // CAMetalLayer

static CAMetalLayer* create_metal_layer(NSWindow* window)
{
    CAMetalLayer* layer = [CAMetalLayer layer];

    window.contentView.layer     = layer;
    window.contentView.wantsLayer = YES;

    return layer;
}

#endif // BX_PLATFORM_OSX

[[maybe_unused]] static bgfx::Init create_bgfx_init(GLFWwindow* window)
{
    int width, height;
    glfwGetFramebufferSize(window, &width, &height);

    bgfx::Init init;
    init.resolution.width  = uint32_t(width );
    init.resolution.height = uint32_t(height);

#if BX_PLATFORM_LINUX
    init.type              = bgfx::RendererType::Vulkan;
    init.platformData.ndt  = glfwGetX11Display();
    init.platformData.nwh  = reinterpret_cast<void*>(uintptr_t(glfwGetX11Window(window)));

#elif BX_PLATFORM_OSX
    init.type              = bgfx::RendererType::Metal;
    init.platformData.nwh  = create_metal_layer(static_cast<NSWindow*>(glfwGetCocoaWindow(window)));

#elif BX_PLATFORM_WINDOWS
    init.type              = bgfx::RendererType::Direct3D12;
    init.platformData.nwh  = glfwGetWin32Window(window);

#else
#   error Unsupported platform.
#endif

    return init;
}

static int run(int, char**)
{
    if (glfwInit() != GLFW_TRUE)
    {
        return 1;
    }

    defer(glfwTerminate());

    glfwDefaultWindowHints();
    glfwWindowHint(GLFW_CLIENT_API, GLFW_NO_API);
    glfwWindowHint(GLFW_SCALE_TO_MONITOR, GLFW_TRUE); // NOTE : Ignored when `glfwSetWindowSize` called.

    GLFWwindow* window = glfwCreateWindow(1024, 768, "StarterTemplate", nullptr, nullptr);
    if (window == nullptr)
    {
        return 2;
    }

    defer(glfwDestroyWindow(window));

    if (!bgfx::init(create_bgfx_init(window)))
    {
        return 3;
    }

    defer(bgfx::shutdown());

    while (!glfwWindowShouldClose(window))
    {
        glfwPollEvents();

        if (glfwGetKey(window, GLFW_KEY_ESCAPE) == GLFW_PRESS)
        {
            break;
        }

        bgfx::touch(0);

        // ...

        bgfx::frame();
    }

    return 0;
}

int main(int argc, char** argv)
{
    return run(argc, argv);
}
