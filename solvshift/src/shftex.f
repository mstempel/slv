C-----|--|---------|---------|---------|---------|---------|---------|--|------|
C
C      filename: shftex.f
C
C                       COARSE-GRAIN SOLVATOCHROMIC 
C                EXCHANGE-REPULSION FREQUENCY SHIFT THEORY
C
C                      version 0.0a    3 Sep 2013    Bartosz Błasiak
C -----------------------------------------------------------------------------
C
#define MAXORB 40
#define MAXMOD 40
#define MAXBSF 300
#define MAXORB2 1600
#define MAXORB2MOD 64000
C -----------------------------------------------------------------------------
      SUBROUTINE SHFTEX(REDMSS,FREQ,GIJJ,LVEC,RIA,RIB,RNA,RNB,RIA1,
     &                  CIKA,CIKB,CIKA1,SKM,TKM,SK1M,TK1M,ZA,ZB,
     &                  NBSA,NBSB,NMOSA,NMOSB,NATA,NATB,NMODES,MLIST,
     &                  FAIJ,FBIJ,FAIJ1,MODEID,SHFTMA,SHFTEA)
C -----------------------------------------------------------------------------
      IMPLICIT DOUBLE PRECISION(A-H,O-Z)
      DIMENSION REDMSS(NMODES), FREQ(NMODES), GIJJ(NMODES), 
     &          RIA(NMOSA,3),RIB(NMOSB,3),RNA(NATA,3),RNB(NATB,3),
     &          RIA1(NMOSA,NMODES,3),CIKA(NMOSA,NBSA),CIKB(NMOSB,NBSB),
     &          CIKA1(NMOSA,NBSA,NMODES),SKM(NBSA,NBSB),TKM(NBSA,NBSB),
     &          SK1M(NBSA,NBSB,3),TK1M(NBSA,NBSB,3),MLIST(NBSA),
     &          FAIJ(NMOSA,NMOSA),FBIJ(NMOSB,NMOSB),
     &          FAIJ1(NMOSA,NMOSA,NMODES)
      DOUBLE PRECISION LVEC(NMODES,NATA,3)
      COMMON /FEX   / FIEX(MAXMOD), FJEX
      COMMON /INTIJ / SIJ(MAXORB,MAXORB), TIJ(MAXORB,MAXORB),
     &                SIJM1(MAXORB,MAXORB,MAXMOD), 
     &                TIJM1(MAXORB,MAXORB,MAXMOD)
      PARAMETER (ZERO=0.0D+00,ONE=1.0D+00,TWO=2.0D+00,THREE=3.0D+00,
     &           FOUR=4.0D+00,FIVE=5.0D+00)
Cf2py INTENT(OUT) SHFTMA,SHFTEA
C
C     calculate <I|O|J> integrals and their derivatives dMM
C     Operator O is 1 for overlap and -HALF*LAPLACIAN for kinetic
C
      CALL CALCIJ(NMOSA,NMOSB,NMODES,NATA,NBSA,NBSB,
     &            SKM,TKM,MLIST,SK1M,TK1M,LVEC,CIKA,CIKB,CIKA1)
C
C     calculate first derivatives of exchange-repulsion energy
C     with respect to normal coordinates MM
C
      CALL CALCFX(NMOSA,NMOSB,NMODES,NATA,NATB,ZA,ZB,LVEC,
     &            RIA,RIB,RIA1,RNA,RNB)
C
C     calculate mechanical and electronic frequency shift!!!
C
      SHFTMA = ZERO
      SHFTEA = FJEX
      DENOM  = TWO*REDMSS(MODEID)*FREQ(MODEID)
      DO 999 I=1,NMODES
         SHFTMA = SHFTMA + GIJJ(I) * FIEX(I) / (REDMSS(I)*(FREQ(I)**2))
 999  CONTINUE
      SHFTMA = SHFTMA / (-ONE*DENOM)
      SHFTEA = SHFTEA / DENOM
C      
      RETURN
      END
C-----|--|---------|---------|---------|---------|---------|---------|--|------|

      SUBROUTINE CALCFX(NMOSA,NMOSB,NMODES,NATA,NATB,ZA,ZB,LVEC,
     &                  RIA,RIB,RIA1,RNA,RNB)
C
C          Calculate first derivatives of exchange-repulsion enegy
C
      IMPLICIT DOUBLE PRECISION(A-H,O-Z)
      DIMENSION RIA(NMOSA,3),RIB(NMOSB,3),RIA1(NMOSA,NMODES,3),
     &          RNA(NATA),RNB(NATB)
      DOUBLE PRECISION LVEC(NMODES,NATA,3)
      COMMON /FEX   / FIEX(MAXMOD), FJEX
      COMMON /INTIJ / SIJ(MAXORB,MAXORB), TIJ(MAXORB,MAXORB),
     &                SIJM1(MAXORB,MAXORB,MAXMOD), 
     &                TIJM1(MAXORB,MAXORB,MAXMOD)
      PARAMETER (ZERO=0.0D+00,ONE=1.0D+00,TWO=2.0D+00,THREE=3.0D+00,
     &           FOUR=4.0D+00,FIVE=5.0D+00,ONEPI=3.141592654D+00,
     &           TWOPI=6.283185307D+00)
C
      DO 1000 I=1,NMOSA
      DO 1000 J=1,NMOSB
C........calculate IJ,IM and NJ distances and their derivatives
         SIJV = SIJ(I,J)
         TIJV = TIJ(I,J)
C
         RIAIB1 = RIA(I,1)-RIB(J,1)
         RIAIB2 = RIA(I,2)-RIB(J,2)
         RIAIB3 = RIA(I,3)-RIB(J,3)
C
         RIJ = DSQRT( RIAIB1**2 + RIAIB2**2 + RIAIB3**2 )
         FIEXMM = ZERO
         DO 2000  MM=1,NMODES
            SIJM1V = SIJM1(I,J,MM)
            TIJM1V = TIJM1(I,J,MM)
            RIJM1 = RIAIB1 * RIA1(I,MM,1) + RIAIB2 * RIA1(I,MM,2) + 
     &              RIAIB3 * RIA1(I,MM,3)
            RIJM1 = RIJM1 / RIJ
C
            DDD = DLOG(DABS(SIJV))
            AAA = SIJV / RIJ
            FIEXMM = FIEXMM + DSQRT(-ONE/(TWOPI*DDD)) - 
     &               TWO * DSQRT(-TWO*DDD/ONEPI)
            FIEXMM = FIEXMM * FOUR * AAA * SIJM1V
            FIEXMM = FIEXMM - AAA*AAA * RIJM1 * DSQRT(-TWO*DDD/ONEPI)
C
            TERM1 = -TWO * TIJV
 2000 CONTINUE
      FIEX(MM) = FIEXMM
 1000 CONTINUE
C
      RETURN
      END
C-----|--|---------|---------|---------|---------|---------|---------|--|------|

      SUBROUTINE CALCIJ(NMOSA,NMOSB,NMODES,NATA,NBSA,NBSB,
     &                  SKM,TKM,MLIST,SK1M,TK1M,LVEC,CIKA,CIKB,CIKA1)
C
C          Calculate all necessary IJ properties:
C          overlap and kinetic integrals along with their derivatives
C
      IMPLICIT DOUBLE PRECISION(A-H,O-Z)
      DIMENSION CIKA(NMOSA,NBSA),CIKB(NMOSB,NBSB),
     &          CIKA1(NMOSA,NBSA,NMODES),SKM(NBSA,NBSB),TKM(NBSA,NBSB),
     &          SK1M(NBSA,NBSB,3),TK1M(NBSA,NBSB,3),MLIST(NBSA)
      DOUBLE PRECISION LVEC(NMODES,NATA,3)
      COMMON /INTIJ / SIJ(MAXORB,MAXORB), TIJ(MAXORB,MAXORB),
     &                SIJM1(MAXORB,MAXORB,MAXMOD), 
     &                TIJM1(MAXORB,MAXORB,MAXMOD)
      PARAMETER (ZERO=0.0D+00,ONE=1.0D+00,TWO=2.0D+00,THREE=3.0D+00,
     &           FOUR=4.0D+00,FIVE=5.0D+00)
C
      DO 1000 I=1,NMOSA
      DO 1000 J=1,NMOSB
C
      SIJV = ZERO
      TIJV = ZERO
      DO 2000 K=1,NBSA
      DO 2000 L=1,NBSB
         CIKAIK = CIKA(I,K)
         CIKBJL = CIKB(J,L)
         COEFS  = CIKAIK * CIKBJL
         SKMKL  = SKM(K,L)
         TKMKL  = TKM(K,L)
         MLISTK = MLIST(K)
C
         SIJV = SIJV + COEFS * SKMKL
         TIJV = TIJV + COEFS * TKMKL
C
         SK1MKL1 = SK1M(K,L,1)
         SK1MKL2 = SK1M(K,L,2)
         SK1MKL3 = SK1M(K,L,3)
         TK1MKL1 = TK1M(K,L,1)
         TK1MKL2 = TK1M(K,L,2)
         TK1MKL3 = TK1M(K,L,3)
         DO 3000  MM=1,NMODES
            RL1  = LVEC(MM,MLISTK,1)
            RL2  = LVEC(MM,MLISTK,2)
            RL3  = LVEC(MM,MLISTK,3) 
            SUM1 = RL1*SK1MKL1 + RL2*SK1MKL2 + RL3*SK1MKL3
            SUM2 = RL1*TK1MKL1 + RL2*TK1MKL2 + RL3*TK1MKL3
C
C...........the following two lines are VEEERY inefficient!!!
            SIJM1(I,J,MM) = SIJM1(I,J,MM) + CIKA1(I,K,MM) * 
     &                      CIKBJL * SKMKL + COEFS * SUM1
            TIJM1(I,J,MM) = TIJM1(I,J,MM) + CIKA1(I,K,MM) * 
     &                      CIKBJL * TKMKL + COEFS * SUM2
 3000    CONTINUE
      SIJ(I,J) = SIJV
      TIJ(I,J) = TIJV
 2000 CONTINUE
 1000 CONTINUE
C
      RETURN
      END
C-----|--|---------|---------|---------|---------|---------|---------|--|------|

      BLOCK DATA
      IMPLICIT DOUBLE PRECISION(A-H,O-Z)
      COMMON /FEX   / FIEX(MAXMOD), FJEX
      COMMON /INTIJ / SIJ(MAXORB,MAXORB), TIJ(MAXORB,MAXORB),
     &                SIJM1(MAXORB,MAXORB,MAXMOD), 
     &                TIJM1(MAXORB,MAXORB,MAXMOD)
      DATA FJEX/0.D0/
      DATA FIEX/MAXMOD*0.D0/
      DATA SIJ/MAXORB2*0.D0/ 
      DATA TIJ/MAXORB2*0.D0/
      DATA SIJM1/MAXORB2MOD*0.D0/
      DATA TIJM1/MAXORB2MOD*0.D0/
      END
C-----|--|---------|---------|---------|---------|---------|---------|--|------|