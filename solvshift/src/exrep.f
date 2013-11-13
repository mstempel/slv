C-----|--|---------|---------|---------|---------|---------|---------|--|------|
C
C      filename: shftex.f
C
C                EXCHANGE-REPULSION INTERACTION ENERGY THEORY
C
C                      version 0.0a    3 Sep 2013    Bartosz Błasiak
C -----------------------------------------------------------------------------
C
C#define MsAXORB 40
C#define MsAXMOD 40
C#define MsAXBSF 300
C#define MsAXORB2 1600
C#define MsAXORB2MOD 64000
C -----------------------------------------------------------------------------
      SUBROUTINE EXREP(RIA,RIB,RNA,RNB,
     &                  FAIJ,FBIJ,CIKA,CIKB,SKM,TKM,ZA,ZB,
     &                  NBSA,NBSB,NMOSA,NMOSB,NATA,NATB,EINT)
C -----------------------------------------------------------------------------
      IMPLICIT DOUBLE PRECISION(A-H,O-Z)
      DIMENSION RIA(NMOSA,3),RIB(NMOSB,3),RNA(NATA,3),RNB(NATB,3),
     &          CIKA(NMOSA,NBSA),CIKB(NMOSB,NBSB),
     &          SKM(NBSA,NBSB),TKM(NBSA,NBSB),
     &          FAIJ(NMOSA,NMOSA),FBIJ(NMOSB,NMOSB),
     &          ZA(NATA),ZB(NATB)
      COMMON /INTIJ / SIJ(40,40), TIJ(40,40)
      PARAMETER (ZERO=0.0D+00,ONE=1.0D+00,TWO=2.0D+00,THREE=3.0D+00,
     &           FOUR=4.0D+00,FIVE=5.0D+00)
Cf2py INTENT(OUT) EINT
C
C     calculate <I|O|J> integrals and their derivatives dMM
C     Operator O is 1 for overlap and -HALF*LAPLACIAN for kinetic
C
      CALL WALCIJ(NMOSA,NMOSB,NBSA,NBSB,SKM,TKM,CIKA,CIKB)
C
C     calculate exchange-repulsion interaction energy
C
      CALL CALCEN(NMOSA,NMOSB,NATA,NATB,ZA,ZB,
     &            RIA,RIB,RNA,RNB,FAIJ,FBIJ,EINT)
C      EINT = EINT * 627.509469D+00
C      WRITE(*,*) "INTERACTION ENERGY IN KCAL/MOL: ", EINT
C      
      RETURN
      END
C-----|--|---------|---------|---------|---------|---------|---------|--|------|

      SUBROUTINE CALCEN(NMOSA,NMOSB,NATA,NATB,ZA,ZB,
     &                  RIA,RIB,RNA,RNB,FAIJ,FBIJ,EINT)
C
C          Calculate exchange-repulsion interaction energy
C
      IMPLICIT DOUBLE PRECISION(A-H,O-Z)
      DIMENSION RIA(NMOSA,3),RIB(NMOSB,3),
     &          RNA(NATA,3),RNB(NATB,3),ZA(NATA),ZB(NATB),
     &          FAIJ(NMOSA,NMOSA),FBIJ(NMOSB,NMOSB)
      COMMON /INTIJ / SIJ(40,40), TIJ(40,40)
      PARAMETER (ZERO=0.0D+00,ONE=1.0D+00,TWO=2.0D+00,THREE=3.0D+00,
     &           FOUR=4.0D+00,FIVE=5.0D+00,ONEPI=3.141592654D+00,
     &           TWOPI=6.283185307D+00)
C
      EINT = ZERO
      TTT = ZERO  
      TT1 = ZERO
      TT2 = ZERO
      DO 1000 I=1,NMOSA
      DO 1000 J=1,NMOSB
         TT11 = ZERO
         TT22 = ZERO
C        WRITE(*,*) I,J,SIJ(I,J),TIJ(I,J)
         SIJV = SIJ(I,J)
         TIJV = TIJ(I,J)
C
         RIAIB1 = RIA(I,1)-RIB(J,1)
         RIAIB2 = RIA(I,2)-RIB(J,2)
         RIAIB3 = RIA(I,3)-RIB(J,3)
C
         RIJ = DSQRT( RIAIB1**2 + RIAIB2**2 + RIAIB3**2 )
         DDD = DLOG(DABS(SIJV))
         AAA = SIJV / RIJ
C
C        evaluate TTT
C
         TTT = TTT + DSQRT(-TWO*DDD/ONEPI) * AAA * SIJV
C
C        evaluate TT2
C
         DO 1010 K=1,NMOSA 
            TT11 = TT11 + (FAIJ(I,K) * SIJ(K,J))
            RIAKB1 = RIA(K,1)-RIB(J,1)
            RIAKB2 = RIA(K,2)-RIB(J,2)
            RIAKB3 = RIA(K,3)-RIB(J,3)
C
            RKJ = DSQRT( RIAKB1**2 + RIAKB2**2 + RIAKB3**2 )
            TT22 = TT22 + (TWO / RKJ)
 1010    CONTINUE
         DO 1020 L=1,NMOSB
            TT11 = TT11 + (FBIJ(J,L) * SIJ(I,L))
            RIALB1 = RIA(I,1)-RIB(L,1)
            RIALB2 = RIA(I,2)-RIB(L,2)
            RIALB3 = RIA(I,3)-RIB(L,3)
C
            RIL = DSQRT( RIALB1**2 + RIALB2**2 + RIALB3**2 )
            TT22 = TT22 + (TWO / RIL)
 1020    CONTINUE
         DO 1030 N=1,NATA
            RNAJB1 = RNA(N,1) - RIB(J,1)
            RNAJB2 = RNA(N,2) - RIB(J,2)
            RNAJB3 = RNA(N,3) - RIB(J,3)
C
            RNJ  = DSQRT( RNAJB1**2 + RNAJB2**2 + RNAJB3**2 )
            TT22 = TT22 - (ZA(N) / RNJ)
 1030    CONTINUE
         DO 1040 M=1,NATB
            RIAMB1 = RIA(I,1) - RNB(M,1)
            RIAMB2 = RIA(I,2) - RNB(M,2)
            RIAMB3 = RIA(I,3) - RNB(M,3)
            RIM  = DSQRT( RIAMB1**2 + RIAMB2**2 + RIAMB3**2 )
            TT22 = TT22 - (ZB(M) / RIM)
 1040    CONTINUE
C
         TT11 = TT11 - (TWO * TIJV)
         TT11 = TT11 * SIJV
         TT1 = TT1 + TT11
         TT22 = TT22 - (ONE / RIJ)
         TT22 = TT22 * (SIJV * SIJV)
         TT2 = TT2 + TT22
 1000 CONTINUE
C
      TTT = - TTT * FOUR 
      TT1 = - TT1 * TWO 
      TT2 =   TT2 * TWO 
      EINT = TTT + TT1 + TT2
      WRITE(*,*) TTT* 627.509469D+00,TT1* 627.509469D+00,
     &                      TT2* 627.509469D+00
C
      RETURN
      END
C-----|--|---------|---------|---------|---------|---------|---------|--|------|

      SUBROUTINE WALCIJ(NMOSA,NMOSB,NBSA,NBSB,
     &                  SKM,TKM,CIKA,CIKB)
C
C          Calculate all necessary IJ properties:
C          overlap and kinetic integrals along with their derivatives
C
      IMPLICIT DOUBLE PRECISION(A-H,O-Z)
      DIMENSION CIKA(NMOSA,NBSA),CIKB(NMOSB,NBSB),
     &          SKM(NBSA,NBSB),TKM(NBSA,NBSB)
      COMMON /INTIJ / SIJ(40,40), TIJ(40,40)
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
C
         SIJV = SIJV + COEFS * SKMKL
         TIJV = TIJV + COEFS * TKMKL
 2000 CONTINUE
      SIJ(I,J) = SIJV
      TIJ(I,J) = TIJV
 1000 CONTINUE
C
      RETURN
      END
C-----|--|---------|---------|---------|---------|---------|---------|--|------|

      BLOCK DATA
      IMPLICIT DOUBLE PRECISION(A-H,O-Z)
      COMMON /INTIJ / SIJ(40,40), TIJ(40,40)
      DATA SIJ/1600*0.D0/ 
      DATA TIJ/1600*0.D0/
      END
C-----|--|---------|---------|---------|---------|---------|---------|--|------|