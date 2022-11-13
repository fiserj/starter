@echo off
setlocal

if exist "shaderc.exe" (
    echo Found compiled shaderc tool, skipping compilation.
    exit /B 0
)

echo Stargting shaderc tool compilation. This might take a while.

for /F "delims=" %%T in ('vswhere -latest -format value -property catalog_productLineVersion') do set VS_VER=%%T
for /F "delims=" %%T in ('vswhere -latest -format value -property installationPath') do set VS_PATH=%%T

if not defined VS_VER goto :no_vs_found
if not defined VS_PATH goto :no_vs_found
goto :vs_found

:no_vs_found
echo ERROR: Can't find any Visual Studio installation.
exit /B 1

:vs_found
echo Detected VS version and path: %VS_VER%, %VS_PATH%

:: TODO : Not sure how far back this path format is stable.
set MSBUILD_EXE="%VS_PATH%\MSBuild\Current\Bin\MSBuild.exe"

if not exist %MSBUILD_EXE% (
    echo ERROR: Can't locate MSBuild.exe at expected location: %MSBUILD_EXE%
    exit /B 2
)

:: https://developercommunity.visualstudio.com/t/windows-sdk-81-gone-from-vs2019/517851
if "%VS_VER%" == "2022" (
    set SDK_VER=10.0
) else if "%VS_VER%" == "2019" (
    set SDK_VER=10.0
) else (
    set SDK_VER=8.1
)
echo Setting wanted Windows SDK version as: %SDK_VER%

mkdir tmp
pushd tmp

:: NOTE : Need to keep these in sync with the ones in third_party/CMakeLists.txt.
if not exist bgfx (
    git clone https://github.com/bkaradzic/bgfx.git
    pushd bgfx
    git checkout e87f08b1e50af8ad416e34fe7365aa5fb6fe5e37
    popd
)

if not exist bimg (
    git clone https://github.com/bkaradzic/bimg.git
    pushd bimg
    git checkout 0de8816a8b155fe85583aa74f5bc93bdfb8910bb
    popd
)

if not exist bx (
    git clone https://github.com/bkaradzic/bx.git
    pushd bx
    git checkout 32a946990745fa1a0ee5df67ad40a6d980f5b1ab
    popd
)

pushd bgfx
..\bx\tools\bin\windows\genie --with-tools --with-windows=%SDK_VER% vs%VS_VER%
%MSBUILD_EXE% .build/projects/vs%VS_VER%/shaderc.vcxproj /p:configuration=release /p:platform=x64
copy /Y ".\.build\win64_vs%VS_VER%\bin\shadercRelease.exe" "..\..\shaderc.exe"
popd

popd
rmdir /S /Q tmp