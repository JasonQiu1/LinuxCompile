#!/bin/bash

# Install dependencies that are not handled by LinuxCompileDeps
sudo apt update
sudo mk-build-deps --install ../debian/control

# Download LuxCore sources
git clone https://github.com/LuxCoreRender/LuxCore.git

# Start build script, pass the path to the LuxCore sources as first argument
# This will take a very long time on the first run because it needs to compile all dependencies
./build-64-sse2 LuxCore
