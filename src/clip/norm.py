#!/usr/bin/env python

from torch import tensor


# 对特征进行归一化
def norm(li):
  vec = tensor(li)
  vec /= vec.norm(dim=-1, keepdim=True)
  return vec
