#include "shaderclib.h"

#include <vector>      // vector

#include <bgfx/bgfx.h> // copy, createShader

#include <shaderc.h>   // Options

namespace bgfx
{

bool compileShader(const char*, const char*, char*, uint32_t, Options&, bx::WriterI*);

} // namespace bgfx

namespace shaderc
{

struct BufferWriter : public bx::FileWriter, public std::vector<uint8_t>
{
public:
	virtual ~BufferWriter() {}

	virtual int32_t write(const void* data, int32_t size, bx::Error*) override
	{
		const char* start = static_cast<const char*>(data);
		insert(end(), start, start + size);

		return size;
	}
};

bgfx::ShaderHandle compile_from_memory
(
    ShaderType  type,
    const char* source,
    const char* varying
)
{
    bgfx::Options options;
    options.shaderType = "cfv"[int(type)];
#if BX_PLATFORM_OSX
    options.platform = "osx";
    options.profile = "metal";
#elif BX_PLATFORM_WINDOWS
    options.platform = "windows";
    options.profile = "s_5_0";
#else
#   error Unsupported platform.
#endif

    constexpr size_t pad = 16384;
    const size_t size = bx::strLen(source);

    char* data = new char[size + pad + 1];
    bx::memCopy(data, source, size);
    bx::memSet(&data[size], 0, pad + 1);

    BufferWriter writer;
    if (!bgfx::compileShader(
        varying,
        "",
        data,
        size,
        options,
        &writer
    ))
    {
        return BGFX_INVALID_HANDLE;
    }

    return bgfx::createShader(bgfx::copy(writer.data(), writer.size()));
}

} // namespace shaderc
