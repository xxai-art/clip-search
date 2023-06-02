#!/usr/bin/env python

from proc import transform
from PIL import Image
from onnx_load import onnx_load

MODEL = onnx_load('img')


def img2vec(img):
  return MODEL.run(None, {'input': transform(img)})[0]


if __name__ == '__main__':
  from config import ROOT
  from os.path import join
  img = Image.open(join(ROOT, 'img/cat.jpg'))
  vec = img2vec(img)
  print(vec)
