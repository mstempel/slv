#!/usr/bin/python
# -*- coding: utf-8 -*-

# -----------------------------------------------
from numpy.distutils.core import setup, Extension
# -----------------------------------------------

### extension module specifications

# solscf theory (not working)
SOLSCF = Extension(name='solscf',
                   sources=['solvshift/src/solscf.f'],)
# exchange-repulsion EFP
SHFTEX = Extension(name='shftex',
                   sources=['solvshift/src/shftex.f'],)
# exchange-repulsion + CT EFP
SHFTCE = Extension(name='shftce',
                   sources=['solvshift/src/shftce.f'],)
# exchange-repulsion interaction energy only
EXREP  = Extension(name='exrep',
                   sources=['solvshift/src/exrep.f'],)

# rotation of wave function in EFP
EFPROT = Extension(name='efprot',
                   sources=['solvshift/src/efprot.f'],)


### install

setup(name='SOLVSHIFT',
      version='27.4',
      description='Solvatochromic shifts from M.CHOs coarse-grained model',
      author='Bartosz Błasiak',
      author_email='globula@o2.pl',
      url='http://www.ex.no/pymod/m1',
      packages=['solvshift',
                #'solvshift.util',
                #'solvshift.diff',
               ],
      ext_modules=[SOLSCF,SHFTEX,EFPROT,SHFTCE,EXREP,]
     )
