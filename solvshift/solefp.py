# -------------------------------------------------------------------------- #
#            SOLVATOCHROMIC EFFECTIVE FRAGMENT POTENTIAL MODULE              #
# -------------------------------------------------------------------------- #

from numpy     import tensordot, dot, transpose, array, float64
from units     import *
from utilities import Read_xyz_file, get_pmloca, ParseFockFromGamessLog, \
                      ParseDmatFromFchk, ParseVecFromFchk
from diff      import DIFF
from PyQuante.Ints import getS, getT, getSAB, getTAB
from shftex import shftex
import sys, copy, os, re, math, glob, PyQuante.Ints, coulomb.multip
sys.stdout.flush()

__all__ = ['Frag','EFP',]
__version__ = '1.0.1'

class EFP(object,UNITS):
    """
=============================================================================
                     EFFECTIVE FRAGMENT POTENTIAL METHOD                     
=============================================================================

Usage:
A = EFP(a,b)
result = A(shift=True)

Notes:
1) a and b are SLVPAR instances. If shift=True, a denotes IR-active molecule
   and should contain all necessary parameters for it
2) the a and b objects are assumed to be appropriately transformed in space 
   by rotations and translations
"""
    def __init__(self,a,b):
        self.__molA = a
        self.__molB = b
        # extract the dictionaries of variables
        self.__varA = a.get()
        self.__varB = b.get()
    
    def __call__(self,shift=True):
        """perform all the calculation"""
        return
    
    def sup(self,str_a=None,str_b=None):
        """superimpose the a and b objects to given structures"""
        rms_a, rms_b = None, None
        if str_a is not None: 
           rms_a = self.__molA.sup(str_a)
        if str_b is not None:
           rms_b = self.__molB.sup(str_b)
        return rms_a, rms_b
    
    # protected
    
    def _ex(self,shift=True,nmode=8):
        """calculate exchange-repulsion property"""
        # basis sets
        bfs1 = self.__varA['bfs']
        bfs2 = self.__varB['bfs']
        # instantaneous integrals
        skm  = getSAB(bfs1,bfs2)
        tkm  = getTAB(bfs1,bfs2)
        sk1m = getSA1B(bfs1,bfs2)
        tk1m = getTA1B(bfs1,bfs2)
        # parameters
        ### molecule A
        faij   = self.__varA['fock']
        faij1  = self.__varA['fock1']
        cika   = self.__varA['vecl']
        cika1  = self.__varA['vecl1']
        za     = self.__varA['atno']
        rna    = self.__varA['pos']
        ria    = self.__varA['lmoc']
        ria1   = self.__varA['lmoc1']
        redmss = self.__varA['redmass']
        freq   = self.__varA['freq']
        gijj   = self.__varA['gijk'][nmode,nmode,:]
        lvec   = self.__varA['lvec']
        mlist  = array(bfs1.LIST1,int) + 1
        ### molecule B
        fbij = self.__varB['fock']
        cikb = self.__varB['vecl']
        zb   = self.__varB['atno']
        rnb  = self.__varB['pos']
        rib  = self.__varB['lmoc']
        # transform the integrals
        sij = dot(dot(cika,skm),transpose(cikb))
        tij = dot(dot(cika,tkm),transpose(cikb))
        # calculate the properties!
        shftma,shftea = shftex(redmss,freq,gijj,lvec,
                               ria,rib,rna,rnb,ria1,
                               cika,cikb,cika1,
                               skm,tkm,sk1m,tk1m,
                               za,zb,mlist,
                               faij,fbij,faij1,nmode)
        shftma *= self.HartreePerHbarToCmRec
        shftea *= self.HartreePerHbarToCmRec

        return shftma, shftea
    
class Frag(object,DIFF):
    """
Solvatochromic Effective Fragment Potential Fragment
----------------------------------------------------

Usage:
"""
    def __init__(self,anh=None,basis=None,nae=None,
                      fchk=None,gmslog=None,):
        self.__anh    = anh
        self.__fchk   = fchk
        self.__gmslog = gmslog
        self.__basis  = basis
        self.__nae    = nae
        self._init()
        self._create()

    # public
    
    def set(self,anh=None,basis=None,nae=None,
                 fchk=None,gmslog=None,):
        """set the properties to the object"""
        if self.__anh    is not None: self.__anh    = anh
        if self.__fchk   is not None: self.__fchk   = fchk
        if self.__gmslog is not None: self.__gmslog = gmslog
        if self.__basis  is not None: self.__basis  = basis
        if self.__nae    is not None: self.__nae    = nae
        return

    def reset(self,anh=None,basis=None,nae=None,
                   fchk=None,gmslog=None,):
        """reset the properties"""
        self.__anh    = anh
        self.__fchk   = fchk
        self.__gmslog = gmslog
        self.__basis  = basis
        self.__nae    = nae
        return

    def get(self):
        """returns dictionary with parameters"""
        par = {}
        if self.__lmoc  is not None: par['lmoc' ] = self.__lmoc
        if self.__lmoc1 is not None: par['lmoc1'] = self.__lmoc1
        if self.__fock  is not None: par['fock' ] = self.__fock
        if self.__fock1 is not None: par['fock1'] = self.__fock1
        if self.__vecl  is not None: par['vecl' ] = self.__vecl
        if self.__vecl1 is not None: par['vecl1'] = self.__vecl1
        return par
    
    def eval(self):
        """Parses AO-LMO transformation matrix and Fock matrix.
Transforms the latter from AO to LMO space. Computes also 
overlap integrals and parses density matrix."""
        assert self.__mol is not None, 'molecule not specified! (no fchk file)'
        # evaluate transformation matrices and LMO centroids
        SAO   = PyQuante.Ints.getS(self.__bfs)
        dmat = ParseDmatFromFchk(self.__fchk,self.__basis_size)
        veccmo= ParseVecFromFchk(self.__fchk)[:self.__nae,:]
        tran, veclmo = get_pmloca(self.__natoms,mapi=self.__bfs.LIST1,sao=SAO,
                                  vecin=veccmo,nae=self.__nae,
                                  maxit=100000,conv=1.0E-14,
                                  lprint=True,
                                  freeze=None)
        # calculate LMTPs
        camm = coulomb.multip.MULTIP(molecule=self.__mol,
                                     basis=self.__basis,
                                     method='b3lyp',
                                     matrix=dmat,
                                     transition=False,
                                     bonds=None,vec=veclmo)
        camm.camms()
        dma = camm.get()[0]
        # parse Fock matrix
        fock = ParseFockFromGamessLog(self.__gmslog,interpol=False)
        fock = tensordot(veclmo,tensordot(veclmo,fock,(1,0)),(1,1))
        # save
        self.__lmoc = dma.get_origin()[self.__natoms:]
        self.__tran = tran
        self.__vecl = veclmo
        self.__fock = fock
        self.__sao  = SAO
        self.__dmat = dmat
        self.__dma  = dma
        return
    
    # protected
    
    def _init(self):
        """initialize the other memorials"""
        self.__mol    = None; self.__basis_size = None
        self.__lmoc   = None; self.__lmoc1  = None; self.__natoms=None
        self.__fock   = None; self.__fock1  = None; self.__bfs  = None
        self.__vecl   = None; self.__vecl1  = None
        return
    
    def _create(self):
        """creates the molecule"""
        if self.__fchk is not None:
           mol  = Read_xyz_file(self.__fchk,mol=True,
                                mult=1,charge=0,
                                name='happy dummy molecule')
           bfs        = PyQuante.Ints.getbasis(mol,self.__basis)
           basis_size = len(bfs)
           natoms= len(mol.atoms)
           # save
           self.__mol = mol
           self.__bfs = bfs
           self.__basis_size = basis_size
           self.__natoms = natoms
        return
    