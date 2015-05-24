!
!     EFP PARAMETER FILE FOR --- WATER --- MOLECULE
!
!                     ..
!                    :O---H
!                    /
!                   H
!
!     Contains:
!     ---------
!
!         structure    : YES
!         electrst     : YES
!         dispersion   : YES
!         wave-func    : YES
!           localized  : YES
!           canonical  : YES
!         vibration    : NO
!         NLO          : NO
!
!     Notes:
!     ------
!
!        * DMTP type: DMA-5
!        * DPOL type: GMS DPOL
!        * LMO  type: Pipek-Mezey (5 vectors)
!
!                                        9 Jan 2014
!                             Modified  24 May 2015
!
 [ molecule ]                            
   name       = WATER MOLECULE
   basis      = RHF/6-311++G**
   natoms     = 3
   nbasis     = 37
   nmodes     = 3
   nmos       = 5
   ncmos      = 37
   ndma       = 5
   npol       = 5
 
 [ Atomic coordinates ]                            N= 9
    0.0000000000E+00    2.1355606100E-01    0.0000000000E+00    1.4225574900E+00   -8.5422235200E-01
    0.0000000000E+00   -1.4225574900E+00   -8.5422235200E-01    0.0000000000E+00

 [ Atomic numbers ]                                N= 3
                   8                   1                   1

 [ Atomic masses ]                                 N= 3
    2.9164399511E+04    1.8371530786E+03    1.8371530786E+03

 [ ChelpG charges ]                                N= 3
   -8.2392678400E-01    4.1196339200E-01    4.1196339200E-01

 [ DMTP centers ]                                  N= 15
    0.0000000000E+00    2.1355604410E-01    0.0000000000E+00    1.4225573777E+00   -8.5422228690E-01
    0.0000000000E+00   -1.4225573777E+00   -8.5422228690E-01    0.0000000000E+00    7.1127868880E-01
   -3.2033312140E-01    0.0000000000E+00   -7.1127868880E-01   -3.2033312140E-01    0.0000000000E+00

 [ DMTP charges ]                                  N= 5
    7.5110433300E-02    4.6017274720E-01    4.6017274720E-01   -4.9772796380E-01   -4.9772796390E-01

 [ DMTP dipoles ]                                  N= 15
   -0.0000000000E+00   -7.2347802950E-01    0.0000000000E+00    5.2782227700E-02   -1.3097916100E-02
    0.0000000000E+00   -5.2782227700E-02   -1.3097916100E-02    0.0000000000E+00   -1.9661635750E-01
    1.6845916990E-01    0.0000000000E+00    1.9661635750E-01    1.6845916990E-01    0.0000000000E+00

 [ DMTP quadrupoles ]                              N= 30
   -3.3814321579E+00   -3.8872404563E+00   -4.5622412398E+00    0.0000000000E+00    0.0000000000E+00
    0.0000000000E+00   -2.6839825560E-01   -2.6349946590E-01   -2.7372555030E-01   -7.0478770000E-03
    0.0000000000E+00    0.0000000000E+00   -2.6839825560E-01   -2.6349946590E-01   -2.7372555030E-01
    7.0478770000E-03    0.0000000000E+00    0.0000000000E+00   -1.5690406950E-01   -1.9321241440E-01
   -2.4215625650E-01   -4.6134173000E-02    0.0000000000E+00    0.0000000000E+00   -1.5690406950E-01
   -1.9321241440E-01   -2.4215625650E-01    4.6134173000E-02    0.0000000000E+00    0.0000000000E+00

 [ DMTP octupoles ]                                N= 50
   -0.0000000000E+00   -1.6535303228E+00    0.0000000000E+00   -5.3485334720E-01    0.0000000000E+00
   -0.0000000000E+00    0.0000000000E+00   -0.0000000000E+00   -5.5177548410E-01    0.0000000000E+00
    5.4308019300E-02    2.0645087200E-02    0.0000000000E+00    9.2215682000E-03    0.0000000000E+00
    1.5798459400E-02    0.0000000000E+00    1.9322818700E-02    5.6825368000E-03    0.0000000000E+00
   -5.4308019300E-02    2.0645087200E-02    0.0000000000E+00    9.2215682000E-03    0.0000000000E+00
   -1.5798459400E-02    0.0000000000E+00   -1.9322818700E-02    5.6825368000E-03    0.0000000000E+00
   -5.1844910650E-01    4.0686051900E-01    0.0000000000E+00    1.4256868700E-01    0.0000000000E+00
   -1.7753975590E-01    0.0000000000E+00   -1.6988226680E-01    1.3542767410E-01    0.0000000000E+00
    5.1844910650E-01    4.0686051900E-01    0.0000000000E+00    1.4256868700E-01    0.0000000000E+00
    1.7753975590E-01    0.0000000000E+00    1.6988226680E-01    1.3542767410E-01    0.0000000000E+00

 [ Polarizable centers ]                           N= 15
    0.0000000000E+00    2.2390797850E-01    0.0000000000E+00   -7.3227831170E-01   -3.9362620910E-01
    0.0000000000E+00    7.3227831430E-01   -3.9362620940E-01    0.0000000000E+00   -2.6000000000E-09
    8.2652014130E-01    0.0000000000E+00    0.0000000000E+00    1.6883487000E-01    0.0000000000E+00

 [ Distributed polarizabilities ]                  N= 45
    3.2437527800E-02    1.0000000000E-10    0.0000000000E+00    1.0000000000E-10    4.6530929200E-02
    0.0000000000E+00    0.0000000000E+00    0.0000000000E+00    1.8127650000E-02    2.7247748084E+00
    1.5807002455E+00    0.0000000000E+00    1.5121771819E+00    1.8042727570E+00    0.0000000000E+00
    0.0000000000E+00    0.0000000000E+00    4.0071505870E-01    2.7247747998E+00   -1.5807002344E+00
    0.0000000000E+00   -1.5121771700E+00    1.8042727461E+00    0.0000000000E+00    0.0000000000E+00
    0.0000000000E+00    4.0071505770E-01    1.5132216010E+00   -1.1100000000E-08    0.0000000000E+00
   -1.1900000000E-08    1.8415341796E+00    0.0000000000E+00    0.0000000000E+00    0.0000000000E+00
    2.4807562440E-01    4.2655998990E-01    0.0000000000E+00    0.0000000000E+00    0.0000000000E+00
    3.5307500600E-01    0.0000000000E+00    0.0000000000E+00    0.0000000000E+00    4.4335786877E+00

 [ Distr. pol. wrt imaginary freq ]                N= 540
    3.2438904900E-02    1.0000000000E-10    0.0000000000E+00    1.0000000000E-10    4.6530693200E-02
    0.0000000000E+00    0.0000000000E+00    0.0000000000E+00    1.8128330400E-02    3.2429843500E-02
    1.0000000000E-10    0.0000000000E+00    1.0000000000E-10    4.6499488300E-02    0.0000000000E+00
    0.0000000000E+00    0.0000000000E+00    1.8122664600E-02    3.2376846600E-02    1.0000000000E-10
    0.0000000000E+00    1.0000000000E-10    4.6317888600E-02    0.0000000000E+00    0.0000000000E+00
    0.0000000000E+00    1.8089784800E-02    3.2191942100E-02    1.0000000000E-10    0.0000000000E+00
    1.0000000000E-10    4.5696103100E-02    0.0000000000E+00    0.0000000000E+00    0.0000000000E+00
    1.7978350300E-02    3.1677112200E-02    1.0000000000E-10    0.0000000000E+00    1.0000000000E-10
    4.4054521100E-02    0.0000000000E+00    0.0000000000E+00    0.0000000000E+00    1.7691577900E-02
    3.0417662600E-02    1.0000000000E-10    0.0000000000E+00    1.0000000000E-10    4.0501409200E-02
    0.0000000000E+00    0.0000000000E+00    0.0000000000E+00    1.7095984600E-02    2.7701556600E-02
    1.0000000000E-10    0.0000000000E+00    1.0000000000E-10    3.4385473700E-02    0.0000000000E+00
    0.0000000000E+00    0.0000000000E+00    1.6082576300E-02    2.2873181700E-02    0.0000000000E+00
    0.0000000000E+00    0.0000000000E+00    2.6384470300E-02    0.0000000000E+00    0.0000000000E+00
    0.0000000000E+00    1.4537240600E-02    1.6266694800E-02    0.0000000000E+00    0.0000000000E+00
    0.0000000000E+00    1.8045011600E-02    0.0000000000E+00    0.0000000000E+00    0.0000000000E+00
    1.2048121200E-02    9.3746877000E-03    0.0000000000E+00    0.0000000000E+00    0.0000000000E+00
    1.0221820000E-02    0.0000000000E+00    0.0000000000E+00    0.0000000000E+00    8.1965900000E-03
    4.2981981000E-03    0.0000000000E+00    0.0000000000E+00    0.0000000000E+00    4.5525309000E-03
    0.0000000000E+00    0.0000000000E+00    0.0000000000E+00    4.2556338000E-03    9.1231790000E-04
   -0.0000000000E+00    0.0000000000E+00   -0.0000000000E+00    9.4287520000E-04    0.0000000000E+00
    0.0000000000E+00    0.0000000000E+00    9.3856270000E-04    2.7246899489E+00    1.5806872668E+00
    0.0000000000E+00    1.5121248932E+00    1.8042307255E+00    0.0000000000E+00    0.0000000000E+00
    0.0000000000E+00    4.0065609510E-01    2.7232926394E+00    1.5796209268E+00    0.0000000000E+00
    1.5108138400E+00    1.8032607930E+00    0.0000000000E+00    0.0000000000E+00    0.0000000000E+00
    4.0061938500E-01    2.7151327383E+00    1.5733963371E+00    0.0000000000E+00    1.5031807719E+00
    1.7976078059E+00    0.0000000000E+00    0.0000000000E+00    0.0000000000E+00    4.0040703190E-01
    2.6868268114E+00    1.5518375854E+00    0.0000000000E+00    1.4770026894E+00    1.7781421493E+00
    0.0000000000E+00    0.0000000000E+00    0.0000000000E+00    3.9969572880E-01    2.6092957216E+00
    1.4930590044E+00    0.0000000000E+00    1.4075575319E+00    1.7258884730E+00    0.0000000000E+00
    0.0000000000E+00    0.0000000000E+00    3.9791708630E-01    2.4267572797E+00    1.3562976921E+00
    0.0000000000E+00    1.2554505692E+00    1.6079575660E+00    0.0000000000E+00    0.0000000000E+00
    0.0000000000E+00    3.9434282010E-01    2.0610868635E+00    1.0898245940E+00    0.0000000000E+00
    9.8718691560E-01    1.3855709670E+00    0.0000000000E+00    0.0000000000E+00    0.0000000000E+00
    3.8748308370E-01    1.4831028027E+00    6.9356959200E-01    0.0000000000E+00    6.2675321890E-01
    1.0457753633E+00    0.0000000000E+00    0.0000000000E+00    0.0000000000E+00    3.6925501830E-01
    8.2397519080E-01    2.9762076550E-01    0.0000000000E+00    2.7887522540E-01    6.3714064700E-01
    0.0000000000E+00    0.0000000000E+00    0.0000000000E+00    3.1230025800E-01    3.0995186120E-01
    6.9046635600E-02    0.0000000000E+00    6.9429576900E-02    2.6894303230E-01    0.0000000000E+00
    0.0000000000E+00    0.0000000000E+00    1.8353189580E-01    5.9183414600E-02    7.4575218000E-03
    0.0000000000E+00    8.0766465000E-03    5.5805643100E-02    0.0000000000E+00    0.0000000000E+00
    0.0000000000E+00    4.6888188700E-02    2.1604411000E-03    1.9944120000E-04    0.0000000000E+00
    2.2852980000E-04    2.0870571000E-03    0.0000000000E+00    0.0000000000E+00    0.0000000000E+00
    1.8646802000E-03    2.7246899403E+00   -1.5806872558E+00    0.0000000000E+00   -1.5121248814E+00
    1.8042307147E+00    0.0000000000E+00    0.0000000000E+00    0.0000000000E+00    4.0065609420E-01
    2.7232926308E+00   -1.5796209158E+00    0.0000000000E+00   -1.5108138282E+00    1.8032607822E+00
    0.0000000000E+00    0.0000000000E+00    0.0000000000E+00    4.0061938400E-01    2.7151327297E+00
   -1.5733963261E+00    0.0000000000E+00   -1.5031807602E+00    1.7976077951E+00    0.0000000000E+00
    0.0000000000E+00    0.0000000000E+00    4.0040703090E-01    2.6868268030E+00   -1.5518375745E+00
    0.0000000000E+00   -1.4770026779E+00    1.7781421387E+00    0.0000000000E+00    0.0000000000E+00
    0.0000000000E+00    3.9969572790E-01    2.6092957135E+00   -1.4930589940E+00    0.0000000000E+00
   -1.4075575209E+00    1.7258884629E+00    0.0000000000E+00    0.0000000000E+00    0.0000000000E+00
    3.9791708540E-01    2.4267572722E+00   -1.3562976826E+00    0.0000000000E+00   -1.2554505595E+00
    1.6079575571E+00    0.0000000000E+00    0.0000000000E+00    0.0000000000E+00    3.9434281910E-01
    2.0610868574E+00   -1.0898245864E+00    0.0000000000E+00   -9.8718690800E-01    1.3855709599E+00
    0.0000000000E+00    0.0000000000E+00    0.0000000000E+00    3.8748308270E-01    1.4831027986E+00
   -6.9356958710E-01    0.0000000000E+00   -6.2675321410E-01    1.0457753584E+00    0.0000000000E+00
    0.0000000000E+00    0.0000000000E+00    3.6925501730E-01    8.2397518870E-01   -2.9762076330E-01
    0.0000000000E+00   -2.7887522320E-01    6.3714064400E-01    0.0000000000E+00    0.0000000000E+00
    0.0000000000E+00    3.1230025720E-01    3.0995186050E-01   -6.9046635000E-02    0.0000000000E+00
   -6.9429576200E-02    2.6894303090E-01    0.0000000000E+00    0.0000000000E+00    0.0000000000E+00
    1.8353189530E-01    5.9183414500E-02   -7.4575217000E-03    0.0000000000E+00   -8.0766464000E-03
    5.5805642800E-02    0.0000000000E+00    0.0000000000E+00    0.0000000000E+00    4.6888188600E-02
    2.1604411000E-03   -1.9944120000E-04    0.0000000000E+00   -2.2852980000E-04    2.0870571000E-03
    0.0000000000E+00    0.0000000000E+00    0.0000000000E+00    1.8646802000E-03    1.5132259616E+00
   -1.1100000000E-08    0.0000000000E+00   -1.1900000000E-08    1.8414698841E+00    0.0000000000E+00
    0.0000000000E+00    0.0000000000E+00    2.4804882970E-01    1.5123855049E+00   -1.1100000000E-08
    0.0000000000E+00   -1.1900000000E-08    1.8397765506E+00    0.0000000000E+00    0.0000000000E+00
    0.0000000000E+00    2.4802450870E-01    1.5074790032E+00   -1.1000000000E-08    0.0000000000E+00
   -1.1800000000E-08    1.8299284471E+00    0.0000000000E+00    0.0000000000E+00    0.0000000000E+00
    2.4788297170E-01    1.4904790071E+00   -1.0900000000E-08    0.0000000000E+00   -1.1600000000E-08
    1.7962929603E+00    0.0000000000E+00    0.0000000000E+00    0.0000000000E+00    2.4739803230E-01
    1.4440736739E+00   -1.0500000000E-08    0.0000000000E+00   -1.1000000000E-08    1.7081381816E+00
    0.0000000000E+00    0.0000000000E+00    0.0000000000E+00    2.4610779930E-01    1.3357077873E+00
   -9.5000000000E-09    0.0000000000E+00   -9.8000000000E-09    1.5208381366E+00    0.0000000000E+00
    0.0000000000E+00    0.0000000000E+00    2.4317084220E-01    1.1222605418E+00   -7.7000000000E-09
    0.0000000000E+00   -7.6000000000E-09    1.2117122336E+00    0.0000000000E+00    0.0000000000E+00
    0.0000000000E+00    2.3690324560E-01    7.9489274270E-01   -4.9000000000E-09    0.0000000000E+00
   -4.8000000000E-09    8.3961687280E-01    0.0000000000E+00    0.0000000000E+00    0.0000000000E+00
    2.2241841530E-01    4.3744044340E-01   -2.2000000000E-09    0.0000000000E+00   -2.2000000000E-09
    5.0026507730E-01    0.0000000000E+00    0.0000000000E+00    0.0000000000E+00    1.8610075570E-01
    1.6889859580E-01   -6.0000000000E-10    0.0000000000E+00   -6.0000000000E-10    2.2243190210E-01
    0.0000000000E+00    0.0000000000E+00    0.0000000000E+00    1.1146920600E-01    3.5625306100E-02
   -1.0000000000E-10    0.0000000000E+00   -1.0000000000E-10    4.9381650500E-02    0.0000000000E+00
    0.0000000000E+00    0.0000000000E+00    3.0714383400E-02    1.3933081000E-03   -0.0000000000E+00
    0.0000000000E+00   -0.0000000000E+00    1.8843413000E-03    0.0000000000E+00    0.0000000000E+00
    0.0000000000E+00    1.1783259000E-03    4.2660929850E-01    0.0000000000E+00    0.0000000000E+00
    0.0000000000E+00    3.5309396310E-01    0.0000000000E+00    0.0000000000E+00    0.0000000000E+00
    4.4335766734E+00    4.2666597980E-01    0.0000000000E+00    0.0000000000E+00    0.0000000000E+00
    3.5311237960E-01    0.0000000000E+00    0.0000000000E+00    0.0000000000E+00    4.4290905231E+00
    4.2699609860E-01    0.0000000000E+00    0.0000000000E+00    0.0000000000E+00    3.5321913160E-01
    0.0000000000E+00    0.0000000000E+00    0.0000000000E+00    4.4030559046E+00    4.2812938460E-01
    0.0000000000E+00    0.0000000000E+00    0.0000000000E+00    3.5357895330E-01    0.0000000000E+00
    0.0000000000E+00    0.0000000000E+00    4.3148241957E+00    4.3113513480E-01    0.0000000000E+00
    0.0000000000E+00    0.0000000000E+00    3.5448177460E-01    0.0000000000E+00    0.0000000000E+00
    0.0000000000E+00    4.0879627596E+00    4.3757564810E-01    0.0000000000E+00    0.0000000000E+00
    0.0000000000E+00    3.5612944380E-01    0.0000000000E+00    0.0000000000E+00    0.0000000000E+00
    3.6202917168E+00    4.4697546130E-01    0.0000000000E+00    0.0000000000E+00    0.0000000000E+00
    3.5723886060E-01    0.0000000000E+00    0.0000000000E+00    0.0000000000E+00    2.8598504078E+00
    4.4545353070E-01    0.0000000000E+00    0.0000000000E+00    0.0000000000E+00    3.5012396660E-01
    0.0000000000E+00    0.0000000000E+00    0.0000000000E+00    1.9115790530E+00    3.8536521030E-01
    0.0000000000E+00    0.0000000000E+00    0.0000000000E+00    3.0911606160E-01    0.0000000000E+00
    0.0000000000E+00    0.0000000000E+00    1.0309515972E+00    2.2097355710E-01    0.0000000000E+00
    0.0000000000E+00    0.0000000000E+00    1.9453265030E-01    0.0000000000E+00    0.0000000000E+00
    0.0000000000E+00    4.1311560110E-01    5.4834454600E-02    0.0000000000E+00    0.0000000000E+00
    0.0000000000E+00    5.3714257600E-02    0.0000000000E+00    0.0000000000E+00    0.0000000000E+00
    8.8821964700E-02    2.1764066000E-03    0.0000000000E+00    0.0000000000E+00    0.0000000000E+00
    2.2050731000E-03    0.0000000000E+00    0.0000000000E+00    0.0000000000E+00    3.4509560000E-03

 [ LMO centroids ]                                 N= 15
   -2.7068280408E-10    2.2390802443E-01   -5.0908424903E-18    7.3227835120E-01   -3.9362622229E-01
    6.6164884964E-15   -7.3227835086E-01   -3.9362622339E-01    7.8796206880E-15   -7.3227272744E-11
    8.2652014347E-01   -1.1337990535E-13   -3.1436526695E-16    1.6883489312E-01    9.7318930773E-14

 [ Fock matrix ]                                   N= 15
   -1.9768681941E+01   -6.8681535435E-01   -9.2608521970E-01    6.8681540975E-01    1.9325174204E-01
   -9.2608522454E-01   -3.7288663048E+00   -4.0949381444E-01    4.0949382602E-01   -1.6219074160E+00
   -3.8376123036E-13   -3.5621029199E-14    3.6773806070E-14   -1.0906411274E-13   -5.1094975736E-01

 [ AO->LMO matrix ]                                N= 185
    5.6312709915E-01    5.0030672620E-01    4.6012526837E-10   -2.5859424704E-02   -8.8670823485E-18
   -1.0558822388E-01    7.0617437959E-10   -3.4938721402E-02   -8.8951759583E-17   -9.9089120127E-02
    4.1705365447E-10   -3.2908558752E-02    1.9135167392E-16    1.8364061160E-03    2.7493150800E-11
   -7.2632817726E-03   -1.5404825349E-16   -1.9592443827E-03    1.1098715333E-03   -3.6102954223E-04
   -5.7914294722E-11    5.1356428124E-18   -1.5453669051E-17   -5.0579430571E-03    4.4139951621E-03
    2.3330345847E-03   -1.2835914822E-03    5.0955996892E-05   -3.4606356466E-03   -3.2750382198E-17
   -5.0579436610E-03    4.4139942959E-03    2.3330344797E-03   -1.2835915330E-03   -5.0956075095E-05
   -3.4606357509E-03   -3.6959875835E-17   -2.4964242746E-02   -5.7955612975E-02    1.6208040667E-01
   -1.3280218186E-01    3.0165359319E-15    2.1000282651E-01    2.4875165027E-01   -2.0556879990E-01
    5.2652574501E-15    7.0211294930E-02    1.4690697771E-01   -1.4293891818E-01    4.3735984416E-15
   -7.8078692700E-03    9.6871338128E-03   -2.8181777988E-02    1.2425314325E-15    2.9458900041E-03
    9.9250745826E-03   -8.8801588034E-03   -2.0400294204E-02    5.6411605154E-17   -2.8483181754E-16
    1.9759490081E-01    2.6296308809E-01    1.9910668490E-02    1.2834146450E-02   -4.0203480116E-02
    2.1260409382E-02    3.9150635547E-16   -1.5129600225E-02   -4.2168354617E-02   -1.7069222993E-02
   -5.0562588663E-03    1.2656438220E-02   -1.5474751596E-02    4.7462557529E-16    2.4964241216E-02
    5.7955611702E-02    1.6208040623E-01    1.3280218232E-01   -3.9169832668E-15   -2.1000282672E-01
    2.4875164960E-01    2.0556880059E-01   -6.4240420379E-15   -7.0211294776E-02    1.4690697731E-01
    1.4293891869E-01   -5.5669615360E-15    7.8078692856E-03    9.6871337865E-03    2.8181778092E-02
   -1.1357937467E-15   -2.9458900058E-03   -9.9250746143E-03    8.8801588291E-03   -2.0400294148E-02
   -6.7332872014E-17    2.1912257732E-16    1.5129599700E-02    4.2168353881E-02    1.7069222931E-02
    5.0562588357E-03    1.2656438330E-02    1.5474751550E-02   -4.2007434790E-16   -1.9759490075E-01
   -2.6296308800E-01   -1.9910668452E-02   -1.2834146432E-02   -4.0203480152E-02   -2.1260409328E-02
   -3.8841906843E-16    9.7569346827E-03   -7.2435775399E-02   -2.1853832536E-11    1.7392618852E-01
   -3.1145308589E-14    4.7996495172E-01   -3.3539158634E-11    2.6173446369E-01   -4.7367191358E-14
    4.6861100812E-01   -1.9818352742E-11    2.2180844888E-01   -4.4989882685E-14   -3.3348796913E-03
   -1.2844739108E-12    4.7724921668E-02   -8.3209114303E-15    5.8690949508E-03   -1.1809839298E-02
    3.9351171167E-03    2.7511031467E-12   -6.4858425703E-17    1.8447601863E-15   -9.6687205551E-03
   -6.4862863791E-02   -1.3260300376E-02    4.7496414877E-03    9.2866162843E-03    1.6800691081E-02
   -3.4896281510E-15   -9.6687205264E-03   -6.4862863750E-02   -1.3260300371E-02    4.7496414901E-03
   -9.2866162806E-03    1.6800691085E-02   -3.5044626010E-15    1.6803431140E-15   -6.3144827640E-15
    5.4981027703E-17    2.2211963514E-14    2.8721843300E-01    4.5833538652E-14    1.1058612719E-16
    3.2893076444E-14    4.4455713300E-01    5.5430498732E-14    9.5396249190E-16    2.4757271612E-14
    4.1128342400E-01   -3.5877638187E-14    1.9287341974E-15    1.7439285816E-14    8.2351742200E-02
    7.7183427015E-16   -1.4411164442E-15    3.2580924690E-16   -1.1257474525E-16   -3.4929642800E-16
   -1.6474827700E-02   -2.6476762785E-15   -1.4861154787E-14    1.7520851512E-14    4.3237657946E-16
    2.6538019500E-15    1.3924383485E-15    3.3312874600E-02   -3.2859789473E-15   -1.5392048897E-14
    2.2468602120E-14    3.8027389040E-16   -2.1692936148E-15    1.4024830529E-15    3.3312874600E-02

