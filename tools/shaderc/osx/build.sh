#!/bin/bash

mkdir tmp
pushd tmp

# NOTE : Need to keep these in sync with the ones in third_party/CMakeLists.txt.
if [ ! -d "bgfx" ]; then
    git clone https://github.com/bkaradzic/bgfx.git
    pushd bgfx
    git checkout e87f08b1e50af8ad416e34fe7365aa5fb6fe5e37
    popd
fi

if [ ! -d "bimg" ]; then
    git clone https://github.com/bkaradzic/bimg.git
    pushd bimg
    git checkout 0de8816a8b155fe85583aa74f5bc93bdfb8910bb
    popd
fi

if [ ! -d "bx" ]; then
    git clone https://github.com/bkaradzic/bx.git
    pushd bx
    git checkout 32a946990745fa1a0ee5df67ad40a6d980f5b1ab
    popd
fi

pushd bgfx
make shaderc
cp -f "./.build/osx-x64/bin/shadercRelease" "../../shaderc" # TODO : Make this work on ARM as well.
popd

popd
rm -rf "tmp"
