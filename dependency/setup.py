#!/usr/bin/env python

from setuptools import setup

setup(name='test-dep',
      version='1.0',
      py_modules=['dep'],
      install_requires=['requests']
     )
