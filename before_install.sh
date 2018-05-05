#!/usr/bin/env bash

# print all the executed commands and  exit if an error occurs
set -xe

PKG_DIR="$PWD"
LUADIST_BOOTSTRAP_DIR="$PKG_DIR/../_luadist_bootstrap"
LUADIST_DIR="$LUADIST_BOOTSTRAP_DIR/_install"
TRAVIS_SCRIPTS_DIR="$PKG_DIR/../_travis_scripts"

# get the bootstrap script
git clone --depth 1 https://github.com/LuaDist-core/bootstrap $LUADIST_BOOTSTRAP_DIR

# run it
cd $LUADIST_BOOTSTRAP_DIR
./bootstrap

# get the travis scripts
git clone --depth 1 https://github.com/MilanVasko/travis-scripts $TRAVIS_SCRIPTS_DIR

# TODO: remove eventually!
# workaround for downloading the latest LuaDist2 instead of the versioned one
LUADIST2_WORKAROUND_DIR="$PWD/../_luadist2_workaround"
git clone --depth 1 https://github.com/LuaDist-core/luadist2 $LUADIST2_WORKAROUND_DIR
cd $LUADIST2_WORKAROUND_DIR
# simulate CMake
sed -e 's/@luadist2_VERSION@/0\.8\.2/' -e 's/@PLATFORM@/{"unix"}/' ./dist/config.in.lua -e 's/git:\/\/github\.com\/LuaDist2\/manifest\.git/git:\/\/github\.com\/LuaDist-testing\/manifest\.git/' > ./dist/config.lua
cd -
rm -rf "$LUADIST_DIR/lib/lua/dist" "$LUADIST_DIR/lib/lua/luadist.lua"
cp -r "$LUADIST2_WORKAROUND_DIR/dist" "$LUADIST_DIR/lib/lua/"
cp "$LUADIST2_WORKAROUND_DIR/luadist.lua" "$LUADIST_DIR/lib/lua/luadist.lua"


ROCKSPEC2CMAKE_WORKAROUND_DIR="$PWD/../_rockspec2cmake_workaround"
git clone --depth 1 https://github.com/LuaDist-core/rockspec2cmake $ROCKSPEC2CMAKE_WORKAROUND_DIR
rm -rf "$LUADIST_DIR/lib/lua/rockspec2cmake" "$LUADIST_DIR/lib/lua/r2cmake.lua"
cp -r "$ROCKSPEC2CMAKE_WORKAROUND_DIR/rockspec2cmake" "$LUADIST_DIR/lib/lua/"
cp "$ROCKSPEC2CMAKE_WORKAROUND_DIR/r2cmake.lua" "$LUADIST_DIR/lib/lua/r2cmake.lua"

