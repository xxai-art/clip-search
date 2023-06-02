#!/usr/bin/env bash

DIR=$(realpath $0) && DIR=${DIR%/*/*}
cd $DIR
set -ex

if [ ! -f ".envrc" ]; then
  ln -s .envrc.example .envrc
fi

direnv allow

pip install -r ./requirements.txt

if [ -x "$(command -v nvidia-smi)" ]; then
  pip install onnxruntime-gpu
else
  system=$(uname)
  arch=$(uname -m)
  if [[ $system == *"Darwin"* ]] && [[ $arch == "arm64" ]]; then
    pip install onnxruntime-silicon
  else
    grep 'vendor_id' /proc/cpuinfo | awk '{print $3}' | grep 'GenuineIntel' >/dev/null
    if [ $? -eq 0 ]; then
      echo 'Intel CPU'
      pip install onnxruntime-openvino
    else
      echo 'Non-Intel CPU'
      pip install onnxruntime
    fi
  fi
fi

MODEL_DIR=$DIR/model

if [ ! -d "$MODEL_DIR/$MODEL" ]; then
  mkdir -p $MODEL_DIR
  cd $MODEL_DIR
  wget -c https://huggingface.co/xxai/AltCLIP/resolve/main/$MODEL-2023-06-02.tar.bz2 -O $MODEL.tar.bz2
  tar -jxvf $MODEL.tar.bz2
  rm -rf $MODEL.tar.bz2
fi
