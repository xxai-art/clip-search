#!/usr/bin/env python

from proc import tokenizer
from onnx_load import onnx_load
from norm import norm

MODEL = onnx_load('txt')


def _txt2vec(li):
  text, attention_mask = tokenizer(li)
  text = text.numpy()
  attention_mask = attention_mask.numpy()
  output = MODEL.run(None, {'input': text, 'attention_mask': attention_mask})
  return output[0]


def txt2vec(li):
  vec = _txt2vec(li)
  return norm(vec)


if __name__ == '__main__':
  TEST_TXT = (
      ('a photo of dog', 'a photo for chinese woman'),
      ('a photo of dog', 'a photo for cat'),
  )
  for li in TEST_TXT:
    r = txt2vec(li)
    for txt, i in zip(li, r):
      print(txt)
      print(i)
      print('\n')
