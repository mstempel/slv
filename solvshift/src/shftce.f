C-----|--|---------|---------|---------|---------|---------|---------|--|------|
C
C      filename: shftex.f
C
C                       COARSE-GRAIN SOLVATOCHROMIC 
C         EFFECTIVE FRAGMENT POTENTIAL BASED FREQUENCY SHIFT THEORY
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
      SUBROUTINE SHFTCE(REDMSS,FREQ,GIJJ,EIGLVC,RNA,RNB,RIA,RIB,RIA1,
     &                  CIKA,CIKB,CIKCA,CIKCB,CIKA1,
     &                  SKM,TKM,TKK,TLL,VKM,VKL,VLK,VLN,SK1M,TK1M,
     &                  FAIJ,FBIJ,FAIJC,FBIJC,FAIJ1,
     &                  ZA,ZB,MLIST,
     &                  NBSA,NBSB,NMOSA,NMOSB,NATA,NATB,NMODES,
     &                  MODEID,SHFTMA,SHFTEA)
C -----------------------------------------------------------------------------
      IMPLICIT DOUBLE PRECISION(A-H,O-Z)
      DIMENSION REDMSS(NMODES),FREQ(NMODES),GIJJ(NMODES),
     & EIGLVC(NMODES,NATA,3),RNA(NATA,3),RNB(NATB,3),
     & RIA(NMOSA,3),RIB(NMOSB,3),RIA1(NMODES,NMOSA,3),
     & CIKA(NMOSA,NBSA),CIKB(NMOSB,NBSB),CIKCA(NBSA,NBSA),
     & CIKCB(NBSB,NBSB),CIKA1(NMODES,NMOSA,NBSA),
     & SKM(NBSA,NBSB),TKM(NBSA,NBSB),TKK(NBSA,NBSA),TLL(NBSB,NBSB),
     & VKM(NBSA,NBSA),VKL(NBSA,NBSB),VLK(NBSB,NBSA),VLN(NBSB,NBSB),
     & SK1M(NBSA,NBSB,3),TK1M(NBSA,NBSB,3),
     & FAIJ(NMOSA,NMOSA),FBIJ(NMOSB,NMOSB),FAIJC(NBSA),
     & FBIJC(NBSB),FAIJ1(NMODES,NMOSA,NMOSA),
     & ZA(NATA),ZB(NATB),MLIST(NBSA)
      COMMON /FEX   / FIEX(40), FICT(40), FJEX
      COMMON /INTIJ1/ SIJ(40,40),TIJ(40,40)
      COMMON /INTIJ2/ SIJC(164,164),TIJC(164,164),TIKC(164,164),
     &                TJLC(164,164),VIJC(164,164),VIKC(164,164),
     &                VJLC(164,164),VJIC(164,164)
      COMMON /INTIJ3/ SIJM1(40,40,40),TIJM1(40,40,40)
      COMMON /INTIJ4/ SIJC1(40,164,164),TIJC1(40,164,164),
     &                VIJC1(40,164,164),VIKC1(40,164,164),
     &                TIKC1(40,164,164),VJIC1(40,164,164),
     &                VJLC1(40,164,164)
      PARAMETER (ZERO=0.0D+00,ONE=1.0D+00,TWO=2.0D+00,THREE=3.0D+00,
     &           FOUR=4.0D+00,FIVE=5.0D+00)
Cf2py INTENT(OUT) SHFTMA,SHFTEA
C
C     calculate <I|O|J> integrals and their derivatives dMM
C     Operator O is 1 for overlap and -HALF*LAPLACIAN for kinetic
C
      CALL QALCIJ(EIGLVC,CIKA,CIKB,CIKCA,CIKCB,CIKA1,
     &       SKM,TKM,TKK,TLL,VKM,VKL,VLK,VLN,SK1M,TK1M,
     &       MLIST,NMOSA,NMOSB,NMODES,NATA,NBSA,NBSB)
C
C     calculate first derivatives of exchange-repulsion energy
C     with respect to normal coordinates MM
C
      CALL QALCFX(EIGLVC,FAIJ,FBIJ,FAIJ1,RNA,RNB,RIA,RIB,RIA1,
     &            ZA,ZB,NMOSA,NMOSB,NMODES,NATA,NATB)
c
C     calculate charge-transfer interaction energy
C
      CALL EINTCT(FAIJC,FBIJC,EINT,NBSA,NBSB,NMOSA,NMOSB)
      EINT = EINT * 627.509469D+00
      WRITE(*,*) "CH-TRNSF INTERACTION ENERGY [KCAL/MOL]: ", EINT
C
C     calculate exchange-repulsion interaction energy
C
      CALL QALCEN(FAIJ,FBIJ,RNA,RNB,RIA,RIB,EINT,ZA,ZB,
     &            NMOSA,NMOSB,NATA,NATB)
      EINT = EINT * 627.509469D+00
      WRITE(*,*) "EXCH-REP INTERACTION ENERGY [KCAL/MOL]: ", EINT
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

      SUBROUTINE CTFX(FAIJC1,FAIJC,FBIJC,CTAB,CTBA,
     *                NMOSA,NMOSB,NBSA,NBSB,NMODES)
C
C          EVALUATE FX FOR CHARGE TRANSFER FREQUENCY SHIFTS
C
      IMPLICIT DOUBLE PRECISION(A-H,O-Z)
      COMMON /FEX   / FIEX(40), FICT(40), FJEX
      COMMON /INTIJ2/ SIJC(164,164),TIJC(164,164),TIKC(164,164),
     &                TJLC(164,164),VIJC(164,164),VIKC(164,164),
     &                VJLC(164,164),VJIC(164,164)
      COMMON /INTIJ4/ SIJC1(40,164,164),TIJC1(40,164,164),
     &                VIJC1(40,164,164),VIKC1(40,164,164),
     &                TIKC1(40,164,164),VJIC1(40,164,164),
     &                VJLC1(40,164,164)
      DIMENSION FAIJC1(NMODES,NBSA),FAIJC(NBSA),FBIJC(NBSB)
      PARAMETER (ZERO=0.0D+00,ONE=1.0D+00,TWO=2.0D+00)
C
      CTAB = ZERO
      CTBA = ZERO
      DNBSA= ONE / DFLOAT(NBSA)
      DNBSB= ONE / DFLOAT(NBSB)
C
C     A(B) PROPERTY
C
      DO 11 I=1,NMOSA
      DO 11 N=1,NMOSB+1,NBSB
         UIN = ZERO
         AIN = ZERO
         BIN = ZERO
C
         VINV = VIJC(I,N)
         FIIV = FAIJC(I)
         TNNV = TJLC(I,N)
         UNORM = ONE
         UTERM = ZERO
C
         DO 211 M=1,NBSA
            SNMV = SIJC(M,N)
            VIMV = VIJC(I,M)
            UTERM = UTERM - SNMV * VIMV
            UNORM = UNORM - SNMV * SNMV
C
            DO 311 J=1,NMOSB
               SIJV = SIJC(I,J)
               TNJV = TJLC(N,J)
               TMJV = TIJC(M,J)
               BIN  = BIN + (SIJV * TNJV * DNBSA) - SIJV * SNMV * TNJV
 311        CONTINUE
 211     CONTINUE
         UIN = UNORM * (FIIV - TNNV)
         UINSQ= UIN * UIN
         AIN = VINV - UTERM
C
C        LOOP OVER NORMAL COORDINATES
C
         DO 9999 MM=1,NMODES
            FICTVM = FICT(MM)
            UIN1 = UNORM * FAIJC1(MM,I)
            BIN1 = ZERO
            AIN1 = VIJC1(MM,I,N)
C
            TSUM1 = ZERO
            TSUM2 = ZERO
            TSUM3 = ZERO
            TSUM4 = ZERO
            DO M=1,NBSA
               SNMV = SIJC(M,N)
               TMJV = TIJC(M,J)
               SMMMN= SIJC1(MM,M,N)
               TSUM1 = TSUM1 + SNMV * SMMMN
               TSUM2 = TSUM2 + SMMMN* VIKC(I,M) + 
     *                         VIKC1(MM,I,M) * SNMV
               DO J=1,NMOSB
                  TSUM3 = TSUM3 - SIJC(I,J) * ( TMJV * SMMMN + 
     *                            SNMV * TIJC1(MM,M,J))
                  TSUM4 = TSUM4 + SIJC1(MM,I,J) * ( TJLC(N,J) * DNBSA -
     *                            SNMV * TMJV )
               ENDDO
            ENDDO
            UIN1 = UIN1 - TWO * (FIIV - TNNV) * TSUM1
            AIN1 = AIN1 - TSUM2
            BIN1 = TSUM3 + TSUM4
C
C           ACCUMULATE DERIVATIVES
C
            FICTVM = (AIN + BIN) * (AIN1 / UIN - AIN * UIN1 / UINSQ) +
     *               (AIN1 + BIN1) * AIN / UIN + FICTVM
            FICT(MM) = FICTVM
 9999    CONTINUE
C
C        ACCUMULATE CHARGE-TRANSFER ENERGY
C
         CTAB = CTAB + AIN * (AIN + BIN) / UIN
C
 11   CONTINUE
C
C     B(A) PROPERTY
C
      DO 12 J=1,NMOSB
      DO 12 M=1,NMOSA+1,NBSA
         UIN = ZERO
         AIN = ZERO
         BIN = ZERO
C        ..........
C
C        ACCUMULATE CHARGE-TRANSFER ENERGY
C
         CTBA = CTBA + AIN * (AIN + BIN) / UIN
 12   CONTINUE

C
      CTAB = CTAB * TWO
      CTBA = CTBA * TWO
C
      RETURN
      END
C-----|--|---------|---------|---------|---------|---------|---------|--|------|

      SUBROUTINE EINTCT(FAIJC,FBIJC,EINT,NBSA,NBSB,NMOSA,NMOSB)
C
C     CALCULATE CHARGE-TRANSFER INTERACTION ENERGY !
C
      IMPLICIT DOUBLE PRECISION(A-H,O-Z)
      DIMENSION FAIJC(NBSA),FBIJC(NBSB)
      COMMON /INTIJ1/ SIJ(40,40),TIJ(40,40)
      COMMON /INTIJ2/ SIJC(164,164),TIJC(164,164),TIKC(164,164),
     &                TJLC(164,164),VIJC(164,164),VIKC(164,164),
     &                VJLC(164,164),VJIC(164,164)
      COMMON /INTIJ3/ SIJM1(40,40,40),TIJM1(40,40,40)
      PARAMETER (ZERO=0.0D+00,ONE=1.0D+00,TWO=2.0D+00,THREE=3.0D+00,
     &           FOUR=4.0D+00,FIVE=5.0D+00,ONEPI=3.141592654D+00,
     &           TWOPI=6.283185307D+00)
C
      EINT = ZERO
      CTAB = ZERO
      CTBA = ZERO
C
C     A(B) CHARGE-TRANSFER
C
      DO 1111 I=1,NMOSA
      DO 1111 N=NMOSB+1,NBSB
         UNORM = ONE
         VIJCIN= VIJC(I,N)
         TERM1 = VIJCIN
         DO 2121 M=1,NBSA
            SIJCMN = SIJC(M,N)
            VIKCIM = VIKC(I,M)
            UNORM = UNORM - SIJCMN * SIJCMN
            TERM1 = TERM1 - SIJCMN * VIKCIM
 2121    CONTINUE
         UIN = TERM1 / (UNORM * ( FAIJC(I) - TJLC(N,N) ) )
C
         BIN = TERM1
         DO 3131 J=1,NMOSB
            TERM2 = SIJC(I,J)
            SUMKA = ZERO
            DO 12 M=1,NBSA
               SUMKA = SUMKA + SIJC(M,N) * TIJC(M,J)
 12         CONTINUE
            TERM2 = TERM2 * ( TJLC(N,J) - SUMKA )
            BIN = BIN + TERM2
 3131    CONTINUE
C
         CTAB = CTAB + UIN * BIN
 1111 CONTINUE
      CTAB = CTAB * TWO
C
C     B(A) CHARGE-TRANSFER
C
      DO 7111 J=1,NMOSB
      DO 7111 M=NMOSA+1,NBSA
         UNORM = ONE
         VJICJM= VJIC(M,J)
         TERM1 = VJICJM
         DO 7121 N=1,NBSB
            SIJCMN = SIJC(M,N)
            VJLCJN = VJLC(J,N)
            UNORM = UNORM - SIJCMN * SIJCMN
            TERM1 = TERM1 - SIJCMN * VJLCJN
 7121    CONTINUE
         UIN = TERM1 / (UNORM * ( FBIJC(J) - TIKC(M,M) ) )
C
         BIN = TERM1
         DO 7131 I=1,NMOSA
            TERM2 = SIJC(I,J)
            SUMKA = ZERO
            DO 72 N=1,NBSB
               SUMKA = SUMKA + SIJC(M,N) * TIJC(I,N)
 72         CONTINUE
            TERM2 = TERM2 * ( TIKC(M,I) - SUMKA )
            BIN = BIN + TERM2
 7131    CONTINUE
C
         CTBA = CTBA + UIN * BIN
 7111 CONTINUE
      CTBA = CTBA * TWO
C
      EINT = CTAB + CTBA
C
      WRITE(*,*) "CT A(B)= ",CTAB
      WRITE(*,*) "CT B(A)= ",CTBA
      RETURN
      END
C-----|--|---------|---------|---------|---------|---------|---------|--|------|

      SUBROUTINE QALCEN(FAIJ,FBIJ,RNA,RNB,RIA,RIB,EINT,ZA,ZB,
     &                  NMOSA,NMOSB,NATA,NATB)
C
C          Calculate exchange-repulsion interaction energy
C
      IMPLICIT DOUBLE PRECISION(A-H,O-Z)
      DIMENSION FAIJ(NMOSA,NMOSA),FBIJ(NMOSB,NMOSB),
     & RNA(NATA,3),RNB(NATB,3),RIA(NMOSA,3),RIB(NMOSB,3),
     & ZA(NATA),ZB(NATB)
      COMMON /FEX   / FIEX(40), FICT(40), FJEX
      COMMON /INTIJ1/ SIJ(40,40),TIJ(40,40)
      COMMON /INTIJ2/ SIJC(164,164),TIJC(164,164),TIKC(164,164),
     &                TJLC(164,164),VIJC(164,164),VIKC(164,164),
     &                VJLC(164,164),VJIC(164,164)
      COMMON /INTIJ3/ SIJM1(40,40,40),TIJM1(40,40,40)
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
c      WRITE(*,*) TTT* 627.509469D+00,TT1* 627.509469D+00,
c     &                      TT2* 627.509469D+00
C
      RETURN
      END
C-----|--|---------|---------|---------|---------|---------|---------|--|------|

      SUBROUTINE QALCFX(EIGLVC,FAIJ,FBIJ,FAIJ1,RNA,RNB,RIA,RIB,RIA1,
     &                  ZA,ZB,NMOSA,NMOSB,NMODES,NATA,NATB)
C
C          Calculate first derivatives of exchange-repulsion enegy
C
      IMPLICIT DOUBLE PRECISION(A-H,O-Z)
      DIMENSION EIGLVC(NMODES,NATA,3),FAIJ(NMOSA,NMOSA),
     & FBIJ(NMOSB,NMOSB),FAIJ1(NMODES,NMOSA,NMOSA),
     & RNA(NATA,3),RNB(NATB,3),RIA(NMOSA,3),RIB(NMOSB,3),
     & RIA1(NMODES,NMOSA,3),ZA(NATA),ZB(NATB)
      COMMON /FEX   / FIEX(40), FICT(40), FJEX
      COMMON /INTIJ1/ SIJ(40,40),TIJ(40,40)
      COMMON /INTIJ2/ SIJC(164,164),TIJC(164,164),TIKC(164,164),
     &                TJLC(164,164),VIJC(164,164),VIKC(164,164),
     &                VJLC(164,164),VJIC(164,164)
      COMMON /INTIJ3/ SIJM1(40,40,40),TIJM1(40,40,40)
      COMMON /SUMS  / SUM1,SUM2,SUM3,SUM4,SUM5,SUM6,
     &                SUM7(40),SUM8(40),SUM9(40),
     &                SUM10(40),SUM11(40),SUM12(40)
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
         DDD = DLOG(DABS(SIJV))
         AAA = SIJV / RIJ
C
C        evaluate TERM1
C
         DO 1010 K=1,NMOSA 
            SUM1 = SUM1 + FAIJ(I,K) * SIJ(K,J)
            RIAKB1 = RIA(K,1)-RIB(J,1)
            RIAKB2 = RIA(K,2)-RIB(J,2)
            RIAKB3 = RIA(K,3)-RIB(J,3)
C
            RKJ = DSQRT( RIAKB1**2 + RIAKB2**2 + RIAKB3**2 )
C
            SUM3 = SUM3 + (ONE / RKJ)
            DO 1019 MM=1,NMODES
               SUM7(MM) = SUM7(MM) + FAIJ1(MM,I,K) * SIJ(K,J) + 
     &                               FAIJ(I,K) * SIJM1(MM,K,J)
               RKJM1 = RIAKB1 * RIA1(MM,K,1) + RIAKB2 * RIA1(MM,K,2) + 
     &                 RIAKB3 * RIA1(MM,K,3)
               RKJM1 = RKJM1 / RKJ
C
               SUM12(MM) = SUM12(MM) + RKJM1 / (RKJ**2)
 1019       CONTINUE
 1010    CONTINUE
C
         DO 1020 L=1,NMOSB
            SUM2 = SUM2 + FBIJ(J,L) * SIJ(I,L)
            RIALB1 = RIA(I,1)-RIB(L,1)
            RIALB2 = RIA(I,2)-RIB(L,2)
            RIALB3 = RIA(I,3)-RIB(L,3)
C
            RIL = DSQRT( RIALB1**2 + RIALB2**2 + RIALB3**2 )
C
            SUM4 = SUM4 + (ONE / RIL)
            DO 1029 MM=1,NMODES
               SUM8(MM) = SUM8(MM) + FBIJ(J,L) * SIJM1(MM,I,L)
C
               RILM1 = RIALB1 * RIA1(MM,I,1) + RIALB2 * RIA1(MM,I,2) + 
     &                 RIALB3 * RIA1(MM,I,3)
               RILM1 = RILM1 / RIL
C
               SUM11(MM) = SUM11(MM) + RILM1 / (RIL**2)
 1029       CONTINUE
 1020    CONTINUE
C
         DO 1030 N=1,NATA
            RNAJB1 = RNA(N,1) - RIB(J,1)
            RNAJB2 = RNA(N,2) - RIB(J,2)
            RNAJB3 = RNA(N,3) - RIB(J,3)
C
            RNJ  = DSQRT( RNAJB1**2 + RNAJB2**2 + RNAJB3**2 )
            SUM5 = SUM5 + (ZA(N) / RNJ)
C
            DO 1039 MM=1,NMODES
             RNJM1 = RNAJB1 * EIGLVC(MM,N,1) + RNAJB2 * EIGLVC(MM,N,2) +
     &               RNAJB3 * EIGLVC(MM,N,3)
             RNJM1 = RNJM1 / RNJ
             SUM10(MM) = SUM10(MM) + RNJM1 * ZA(N) / (RNJ**2)
 1039       CONTINUE
 1030    CONTINUE
C
         DO 1040 M=1,NATB
            RIAMB1 = RIA(I,1) - RNB(M,1)
            RIAMB2 = RIA(I,2) - RNB(M,2)
            RIAMB3 = RIA(I,3) - RNB(M,3)
            RIM  = DSQRT( RIAMB1**2 + RIAMB2**2 + RIAMB3**2 )
            SUM6 = SUM6 + (ZB(M) / RIM)
C
            DO 1049 MM=1,NMODES
               RIMM1 = RIAMB1 * RIA1(MM,I,1) + RIAMB2 * RIA1(MM,I,2) +
     &                 RIAMB3 * RIA1(MM,I,3)
               RIMM1 = RIMM1 / RIM
               SUM9(MM) = SUM9(MM) + RIMM1 * ZB(M) / (RIM**2)
 1049       CONTINUE
 1040    CONTINUE
C
         TERM1 = SUM1 + SUM2 - ( TWO * TIJV )
         TERM2 = SUM6 + SUM5 - TWO * ( SUM4 + SUM3 ) + ( ONE / RIJ )
C
         DO 2000  MM=1,NMODES
            FIEXMM = FIEX(MM)
C
            SIJM1V = SIJM1(MM,I,J)
            TIJM1V = TIJM1(MM,I,J)
            RIJM1 = RIAIB1 * RIA1(MM,I,1) + RIAIB2 * RIA1(MM,I,2) + 
     &              RIAIB3 * RIA1(MM,I,3)
            RIJM1 = RIJM1 / RIJ
C
            TERM3 = SUM7(MM) + SUM8(MM) - TWO * TIJM1V
            TERM4 = SUM9(MM) + SUM10(MM) + RIJM1 / (RIJ**2) -
     &              TWO * (SUM11(MM) + SUM12(MM))
C
            FIEXMM = FIEXMM + ( DSQRT(-ONE/(TWOPI*DDD)) - 
     &               TWO * DSQRT(-TWO*DDD/ONEPI) ) * 
     &               FOUR * AAA * SIJM1V
            FIEXMM = FIEXMM + FOUR * AAA * AAA * RIJM1 * 
     &                 DSQRT(-TWO*DDD/ONEPI)
            FIEXMM = FIEXMM - TWO * SIJM1V * TERM1
     &                      - FOUR * SIJV * SIJM1V * TERM2
            FIEXMM = FIEXMM - TWO * SIJV * TERM3
     &                      + TWO * SIJV * SIJV * TERM4
C
            FIEX(MM) = FIEXMM
 2000    CONTINUE
         CALL ZRQSUM(NMODES)
 1000 CONTINUE
C      WRITE(*,*) " --- FI [A.U.] --- "
C      DO I=1,30
C         WRITE(*,*) I,FIEX(I)
C      ENDDO
C
      RETURN
      END
C-----|--|---------|---------|---------|---------|---------|---------|--|------|

      SUBROUTINE QALCIJ(EIGLVC,CIKA,CIKB,CIKCA,CIKCB,CIKA1,
     &             SKM,TKM,TKK,TLL,VKM,VKL,VLK,VLN,SK1M,TK1M,
     &             MLIST,NMOSA,NMOSB,NMODES,NATA,NBSA,NBSB)
C
C          Calculate all necessary IJ properties:
C          overlap and kinetic integrals along with their derivatives
C
      IMPLICIT DOUBLE PRECISION(A-H,O-Z)
      DIMENSION EIGLVC(NMODES,NATA,3),CIKA(NMOSA,NBSA),CIKB(NMOSB,NBSB),
     & CIKCA(NBSA,NBSA),CIKCB(NBSB,NBSB),CIKA1(NMODES,NMOSA,NBSA),
     & SKM(NBSA,NBSB),TKM(NBSA,NBSB),TKK(NBSA,NBSA),TLL(NBSB,NBSB),
     & VKM(NBSA,NBSA),VKL(NBSA,NBSB),VLK(NBSB,NBSA),VLN(NBSB,NBSB),
     & SK1M(NBSA,NBSB,3),TK1M(NBSA,NBSB,3),MLIST(NBSA)
      COMMON /INTIJ1/ SIJ(40,40),TIJ(40,40)
      COMMON /INTIJ2/ SIJC(164,164),TIJC(164,164),TIKC(164,164),
     &                TJLC(164,164),VIJC(164,164),VIKC(164,164),
     &                VJLC(164,164),VJIC(164,164)
      COMMON /INTIJ3/ SIJM1(40,40,40),TIJM1(40,40,40)
      PARAMETER (ZERO=0.0D+00,ONE=1.0D+00,TWO=2.0D+00,THREE=3.0D+00,
     &           FOUR=4.0D+00,FIVE=5.0D+00)
C
      CALL ZRQSIJ(NMODES,NMOSA,NMOSB)
C
C     ITERATE OVER CANONICAL MO SPACE
C
C     MIXED AB TERMS
      DO 998 I=1,NBSA
      DO 998 J=1,NBSB
         SIJCV = ZERO
         TIJCV = ZERO
         VIJCV = ZERO
         VJICV = ZERO
         DO 996 K=1,NBSA
         DO 996 L=1,NBSB
c      WRITE(*,*) " I,J,K,L= ",I,J,K,L
            CIKAIK = CIKCA(I,K)
            CIKBJL = CIKCB(J,L)
            COEFS  = CIKAIK * CIKBJL
            SKMKL  = SKM(K,L)
            TKMKL  = TKM(K,L)
            VKLKL  = VKL(K,L)
            VLKLK  = VLK(L,K)
C
            SIJCV = SIJCV + COEFS * SKMKL
            TIJCV = TIJCV + COEFS * TKMKL
            VIJCV = VIJCV + COEFS * VKLKL
            VJICV = VJICV + COEFS * VLKLK
 996     CONTINUE
         SIJC(I,J) = SIJCV
         TIJC(I,J) = TIJCV
         VIJC(I,J) = VIJCV
         VJIC(I,J) = VJICV
 998  CONTINUE
C     MOLECULE A
      DO 995 I=1,NBSA
      DO 995 K=1,NBSA
         TIKCV = ZERO
         VIKCV = ZERO
         DO 994 IS=1,NBSA
         DO 994 KS=1,NBSA
            CIKAIK = CIKCA(I,IS)
            CIKAJL = CIKCA(K,KS)
            COEFS  = CIKAIK * CIKAJL
            TKMKL  = TKK(IS,KS)
            VKMKL  = VKM(IS,KS)
C
            TIKCV = TIKCV + COEFS * TKMKL
            VIKCV = VIKCV + COEFS * VKMKL
 994     CONTINUE
         TIKC(I,K) = TIKCV
         VIKC(I,K) = VIKCV
 995  CONTINUE
C     MOLECULE B
      DO 993 J=1,NBSB
      DO 993 L=1,NBSB
         TJLCV = ZERO
         VJLCV = ZERO
         DO 992 JS=1,NBSB
         DO 992 LS=1,NBSB
            CIKBIK = CIKCB(J,JS)
            CIKBJL = CIKCB(L,LS)
            COEFS  = CIKBIK * CIKBJL
            TKMKL  = TLL(JS,LS)
            VKMKL  = VLN(JS,LS)
C
            TJLCV = TJLCV + COEFS * TKMKL 
            VJLCV = VJLCV + COEFS * VKMKL
 992     CONTINUE
         TJLC(J,L) = TJLCV
         VJLC(J,L) = VJLCV
 993  CONTINUE
C
C     ITERATE OVER LOCALIZED MO SPACE
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
            RL1  = EIGLVC(MM,MLISTK,1)
            RL2  = EIGLVC(MM,MLISTK,2)
            RL3  = EIGLVC(MM,MLISTK,3) 
            SUM1 = RL1*SK1MKL1 + RL2*SK1MKL2 + RL3*SK1MKL3
            SUM2 = RL1*TK1MKL1 + RL2*TK1MKL2 + RL3*TK1MKL3
C
C...........the following two lines are VEEERY inefficient!!! 
            CIKA1M = CIKA1(MM,I,K)
            SIJM1(MM,I,J) = SIJM1(MM,I,J) + CIKA1M * 
     &                      CIKBJL * SKMKL + COEFS * SUM1
            TIJM1(MM,I,J) = TIJM1(MM,I,J) + CIKA1M * 
     &                      CIKBJL * TKMKL + COEFS * SUM2
 3000    CONTINUE
 2000 CONTINUE
      SIJ(I,J) = SIJV
      TIJ(I,J) = TIJV
 1000 CONTINUE
C
      RETURN
      END
C-----|--|---------|---------|---------|---------|---------|---------|--|------|

      SUBROUTINE ZRQSUM(NMODES)
C
C          Zero-out the auxilliary sums
C
      IMPLICIT DOUBLE PRECISION(A-H,O-Z)
      COMMON /SUMS  / SUM1,SUM2,SUM3,SUM4,SUM5,SUM6,
     &                SUM7(40),SUM8(40),SUM9(40),
     &                SUM10(40),SUM11(40),SUM12(40)
      PARAMETER (ZERO=0.0D+00)
      SUM1 = ZERO
      SUM2 = ZERO
      SUM3 = ZERO
      SUM4 = ZERO 
      SUM5 = ZERO
      SUM6 = ZERO
      DO 1498 I=1,NMODES
         SUM7(I) = ZERO 
         SUM8(I) = ZERO
         SUM9(I) = ZERO
         SUM10(I) = ZERO
         SUM11(I) = ZERO
         SUM12(I) = ZERO
 1498 CONTINUE
C
      RETURN
      END
C-----|--|---------|---------|---------|---------|---------|---------|--|------|

      SUBROUTINE ZRQSIJ(NMODES,NMOSA,NMOSB)
C
C          ZERO-OUT ALL TIJM1 AND SIJM1 DERIVATIVES
C
      IMPLICIT DOUBLE PRECISION(A-H,O-Z)
      COMMON /FEX   / FIEX(40), FICT(40), FJEX
      COMMON /INTIJ1/ SIJ(40,40),TIJ(40,40)
      COMMON /INTIJ2/ SIJC(164,164),TIJC(164,164),TIKC(164,164),
     &                TJLC(164,164),VIJC(164,164),VIKC(164,164),
     &                VJLC(164,164),VJIC(164,164)
      COMMON /INTIJ3/ SIJM1(40,40,40),TIJM1(40,40,40)
      PARAMETER (ZERO=0.0D+00)
      FJEX = ZERO
      DO 1937 M=1,NMODES
         FIEX(M) = ZERO
      DO 1937 I=1,NMOSA
      DO 1937 J=1,NMOSB
         SIJM1(M,I,J) = ZERO
         TIJM1(M,I,J) = ZERO
 1937 CONTINUE
      RETURN
      END
C-----|--|---------|---------|---------|---------|---------|---------|--|------|

      BLOCK DATA
      IMPLICIT DOUBLE PRECISION(A-H,O-Z)
      COMMON /FEX   / FIEX(40), FICT(40), FJEX
      COMMON /INTIJ1/ SIJ(40,40),TIJ(40,40)
      COMMON /INTIJ2/ SIJC(164,164),TIJC(164,164),TIKC(164,164),
     &                TJLC(164,164),VIJC(164,164),VIKC(164,164),
     &                VJLC(164,164),VJIC(164,164)
      COMMON /INTIJ3/ SIJM1(40,40,40),TIJM1(40,40,40)
      COMMON /INTIJ4/ SIJC1(40,164,164),TIJC1(40,164,164),
     &                VIJC1(40,164,164),VIKC1(40,164,164),
     &                TIKC1(40,164,164),VJIC1(40,164,164),
     &                VJLC1(40,164,164)
      COMMON /SUMS  / SUM1,SUM2,SUM3,SUM4,SUM5,SUM6,
     &                SUM7(40),SUM8(40),SUM9(40),
     &                SUM10(40),SUM11(40),SUM12(40)
      DATA FJEX/0.D0/
      DATA FIEX/40*0.D0/
      DATA FICT/40*0.D0/
      DATA SUM1,SUM2,SUM3,SUM4,SUM5,SUM6/0.D0,0.D0,0.D0,0.D0,0.D0,0.D0/
      DATA SUM7,SUM8,SUM9,SUM10,SUM11,SUM12/40*0.D0,40*0.D0,
     &                                      40*0.D0,40*0.D0,
     &                                      40*0.D0,40*0.D0/
      DATA SIJ/1600*0.D0/ 
      DATA TIJ/1600*0.D0/
      DATA SIJC/26896*0.D0/
      DATA TIJC/26896*0.D0/
      DATA TIKC/26896*0.D0/
      DATA TJLC/26896*0.D0/
      DATA VIJC/26896*0.D0/
      DATA VIKC/26896*0.D0/
      DATA VJLC/26896*0.D0/
      DATA VJIC/26896*0.D0/
      DATA SIJM1/64000*0.D0/
      DATA TIJM1/64000*0.D0/
      DATA SIJC1/1075840*0.D0/
      DATA TIJC1/1075840*0.D0/
      DATA VIJC1/1075840*0.D0/
      DATA VIKC1/1075840*0.D0/
      DATA TIKC1/1075840*0.D0/
      DATA VJIC1/1075840*0.D0/
      DATA VJLC1/1075840*0.D0/
      END
C-----|--|---------|---------|---------|---------|---------|---------|--|------|
