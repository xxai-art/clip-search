#!/usr/bin/env python

from os.path import abspath, join, dirname
import os

MODEL_NAME = os.getenv('MODEL') or 'AltCLIP-XLMR-L-m18'

ROOT = dirname(dirname(dirname(abspath(__file__))))

ONNX_DIR = join(ROOT, 'model', MODEL_NAME)

ONNX_FP = join(ONNX_DIR, 'onnx')

PROCESS_DIR = join(ONNX_DIR, 'process')
