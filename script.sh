#!/usr/bin/env bash

# print all the executed commands and  exit if an error occurs
set -xe

PKG_DIR="$PWD"
LUADIST_DIR="$PKG_DIR/../_luadist_bootstrap/_install"
TRAVIS_SCRIPTS_DIR="$PKG_DIR/../_travis_scripts"

export PKG_NAME="`basename $PKG_DIR`"
export PKG_INSTALL_DIR="$PKG_DIR/../_luadist_install"
export LUA_BIN="$LUADIST_DIR/bin/lua"
export LUADIST_LIB="$LUADIST_DIR/lib/lua/luadist.lua"

$LUA_BIN $TRAVIS_SCRIPTS_DIR/script_action.lua

