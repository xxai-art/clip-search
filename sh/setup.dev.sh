#!/usr/bin/env bash

DIR=$(realpath $0) && DIR=${DIR%/*}
cd $DIR
set -ex

if ! [ -x "$(command -v cargo)" ]; then
  export RUSTUP_UPDATE_ROOT=https://mirrors.ustc.edu.cn/rust-static/rustup
  export RUSTUP_DIST_SERVER=https://mirrors.tuna.tsinghua.edu.cn/rustup

  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
fi

if ! [ -x "$(command -v watchexec)" ]; then
  cargo install watchexec
fi

./setup.sh
