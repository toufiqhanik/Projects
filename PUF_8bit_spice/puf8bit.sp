***Circuit check***

*** Library File****
.INCLUDE '/home/anik/trans_model'
.INCLUDE '/home/anik/all_gates'

*** Simultion Control ****
.OPTION POST BRIEF PROBE RUNLVL=6 ACCURATE INGOLD=2 MEASDGT=8

****Temperature***
.TEMP 45

***Global Node Connection ***
.GLOBAL VDD

*******Source*****
Vsupply VDD 0 1.1

Vinput input GND PULSE(0 1.1 0.1n 0.1n 0.1n 2.5n 5n)


***challenges****
Vc0 c0 GND PWL(0n 0 5ns 0 5.1n 0 10n 0 10.1n 1.1 15n 1.1 15.1n 1.1 20n 1.1 20.1n 1.1 25n 1.1 25.1n 1.1 30n 1.1 30.1n 1.1 35n 1.1 35.1n 1.1 40n 1.1 40.1n 0 45n 0 45.1n 0 50n 0 50.1n 0 55n 0 55.1n 0 60n 0 60.1n 0 65n 0 65.1n 0 70n 0 70.1n 1.1 75n 1.1)
Vc1 c1 GND PWL(0n 1.1 5ns 1.1 5.1n 1.1 10n 1.1 10.1n 0 15n 0 15.1n 0 20n 0 20.1n 1.1 25n 1.1 25.1n 1.1 30n 1.1 30.1n 0 35n 0 35.1n 0 40n 0 40.1n 0 45n 0 45.1n 0 50n 0 50.1n 1.1 55n 1.1 55.1n 1.1 60n 1.1 60.1n 1.1 65n 1.1 65.1n 1.1 70n 1.1 70.1n 0 75n 0)
Vc2 c2 GND PWL(0n 0 5ns 0 5.1n 0 10n 0 10.1n 0 15n 0 15.1n 0 20n 0 20.1n 0 25n 0 25.1n 0 30n 0 30.1n 0 35n 0 35.1n 0 40n 0 40.1n 0 45n 0 45.1n 0 50n 0 50.1n 0 55n 0 55.1n 0 60n 0 60.1n 0 65n 0 65.1n 0 70n 0 70.1n 1.1 75n 1.1)
Vc3 c3 GND PWL(0n 0 5ns 0 5.1n 0 10n 0 10.1n 1.1 15n 1.1 15.1n 0 20n 0 20.1n 1.1 25n 1.1 25.1n 1.1 30n 1.1 30.1n 1.1 35n 1.1 35.1n 1.1 40n 1.1 40.1n 1.1 45n 1.1 45.1n 1.1 50n 1.1 50.1n 1.1 55n 1.1 55.1n 1.1 60n 1.1 60.1n 0 65n 0 65.1n 0 70n 0 70.1n 0 75n 0)
Vc4 c4 GND PWL(0n 0 5ns 0 5.1n 0 10n 0 10.1n 1.1 15n 1.1 15.1n 1.1 20n 1.1 20.1n 1.1 25n 1.1 25.1n 1.1 30n 1.1 30.1n 0 35n 0 35.1n 0 40n 0 40.1n 1.1 45n 1.1 45.1n 1.1 50n 1.1 50.1n 1.1 55n 1.1 55.1n 1.1 60n 1.1 60.1n 0 65n 0 65.1n 0 70n 0 70.1n 1.1 75n 1.1)
Vc5 c5 GND PWL(0n 1.1 5ns 1.1 5.1n 1.1 10n 1.1 10.1n 0 15n 0 15.1n 0 20n 0 20.1n 1.1 25n 1.1 25.1n 1.1 30n 1.1 30.1n 1.1 35n 1.1 35.1n 1.1 40n 1.1 40.1n 1.1 45n 1.1 45.1n 1.1 50n 1.1 50.1n 0 55n 0 55.1n 0 60n 0 60.1n 0 65n 0 65.1n 0 70n 0 70.1n 0 75n 0)
Vc6 c6 GND PWL(0n 0 5ns 0 5.1n 1.1 10n 1.1 10.1n 0 15n 0 15.1n 0 20n 0 20.1n 0 25n 0 25.1n 0 30n 0 30.1n 0 35n 0 35.1n 0 40n 0 40.1n 1.1 45n 1.1 45.1n 1.1 50n 1.1 50.1n 0 55n 0 55.1n 0 60n 0 60.1n 0 65n 0 65.1n 0 70n 0 70.1n 0 75n 0)
Vc7 c7 GND PWL(0n 1.1 5ns 1.1 5.1n 1.1 10n 1.1 10.1n 0 15n 0 15.1n 0 20n 0 20.1n 0 25n 0 25.1n 0 30n 0 30.1n 0 35n 0 35.1n 0 40n 0 40.1n 1.1 45n 1.1 45.1n 1.1 50n 1.1 50.1n 0 55n 0 55.1n 0 60n 0 60.1n 1.1 65n 1.1 65.1n 1.1 70n 1.1 70.1n 1.1 75n 1.1)
Vc8 c8 GND PWL(0n 0 5ns 0 5.1n 0 10n 0 10.1n 0 15n 0 15.1n 0 20n 0 20.1n 0 25n 0 25.1n 0 30n 0 30.1n 0 35n 0 35.1n 0 40n 0 40.1n 0 45n 0 45.1n 0 50n 0 50.1n 1.1 55n 1.1 55.1n 1.1 60n 1.1 60.1n 1.1 65n 1.1 65.1n 1.1 70n 1.1 70.1n 1.1 75n 1.1)
Vc9 c9 GND PWL(0n 1.1 5ns 1.1 5.1n 1.1 10n 1.1 10.1n 1.1 15n 1.1 15.1n 1.1 20n 1.1 20.1n 1.1 25n 1.1 25.1n 1.1 30n 1.1 30.1n 1.1 35n 1.1 35.1n 1.1 40n 1.1 40.1n 0 45n 0 45.1n 0 50n 0 50.1n 0 55n 0 55.1n 0 60n 0 60.1n 1.1 65n 1.1 65.1n 1.1 70n 1.1 70.1n 1.1 75n 1.1)
Vc10 c10 GND PWL(0n 1.1 5ns 1.1 5.1n 1.1 10n 1.1 10.1n 1.1 15n 1.1 15.1n 1.1 20n 1.1 20.1n 0 25n 0 25.1n 0 30n 0 30.1n 0 35n 0 35.1n 0 40n 0 40.1n 1.1 45n 1.1 45.1n 1.1 50n 1.1 50.1n 1.1 55n 1.1 55.1n 1.1 60n 1.1 60.1n 1.1 65n 1.1 65.1n 1.1 70n 1.1 70.1n 1.1 75n 1.1)
Vc11 c11 GND PWL(0n 0 5ns 0 5.1n 0 10n 0 10.1n 0 15n 0 15.1n 0 20n 0 20.1n 1.1 25n 1.1 25.1n 1.1 30n 1.1 30.1n 0 35n 0 35.1n 0 40n 0 40.1n 0 45n 0 45.1n 0 50n 0 50.1n 1.1 55n 1.1 55.1n 0 60n 0 60.1n 1.1 65n 1.1 65.1n 0 70n 0 70.1n 0 75n 0)
Vc12 c12 GND PWL(0n 0 5ns 0 5.1n 0 10n 0 10.1n 1.1 15n 1.1 15.1n 1.1 20n 1.1 20.1n 0 25n 0 25.1n 0 30n 0 30.1n 1.1 35n 1.1 35.1n 0 40n 0 40.1n 1.1 45n 1.1 45.1n 1.1 50n 1.1 50.1n 1.1 55n 1.1 55.1n 1.1 60n 1.1 60.1n 0 65n 0 65.1n 0 70n 0 70.1n 0 75n 0)
Vc13 c13 GND PWL(0n 1.1 5ns 1.1 5.1n 1.1 10n 1.1 10.1n 0 15n 0 15.1n 0 20n 0 20.1n 0 25n 0 25.1n 0 30n 0 30.1n 0 35n 0 35.1n 0 40n 0 40.1n 0 45n 0 45.1n 1.1 50n 1.1 50.1n 0 55n 0 55.1n 0 60n 0 60.1n 0 65n 0 65.1n 0 70n 0 70.1n 0 75n 0)
Vc14 c14 GND PWL(0n 1.1 5ns 1.1 5.1n 1.1 10n 1.1 10.1n 0 15n 0 15.1n 0 20n 0 20.1n 0 25n 0 25.1n 0 30n 0 30.1n 1.1 35n 1.1 35.1n 1.1 40n 1.1 40.1n 0 45n 0 45.1n 0 50n 0 50.1n 1.1 55n 1.1 55.1n 1.1 60n 1.1 60.1n 1.1 65n 1.1 65.1n 1.1 70n 1.1 70.1n 1.1 75n 1.1)
Vc15 c15 GND PWL(0n 1.1 5ns 1.1 5.1n 1.1 10n 1.1 10.1n 1.1 15n 1.1 15.1n 1.1 20n 1.1 20.1n 1.1 25n 1.1 25.1n 0 30n 0 30.1n 0 35n 0 35.1n 0 40n 0 40.1n 1.1 45n 1.1 45.1n 1.1 50n 1.1 50.1n 0 55n 0 55.1n 0 60n 0 60.1n 0 65n 0 65.1n 0 70n 0 70.1n 1.1 75n 1.1)

*****GAUSS***
.PARAM vth_pmos_pv=GAUSS(-0.3021,0.1,1)
.PARAM vth_nmos_pv=GAUSS(0.322,0.1,1)
.PARAM toxm_pmos_pv=GAUSS(1.26E-009,0.01,1)
.PARAM toxm_nmos_pv=GAUSS(1.14E-09,0.01,1)
.PARAM LMIN_pv=GAUSS(50E-09,0.1,3)
.PARAM LMIN=GAUSS(50E-09,.5,5)



***Sub Circuit: mux ***
.SUBCKT mux i0 i1 s q VDDm GNDm

xinv_mux s i_s VDDm GNDm INV_X1

xand_0 i0 i_s f_0 VDDm GNDm AND2_X1
xand_1 i1 s f_1 VDDm GNDm AND2_X1
xor_1 f_0 f_1 q VDDm GNDm OR2_X1
.ENDS




***Sub Circuit : PUF_1bit****
.SUBCKT PUF_1bit inputp qout s0p s1p s2p s3p s4p s5p s6p s7p s8p s9p s10p s11p s12p s13p s14p s15p VDDp GNDp

xb001 inputp bf001 VDDp GNDp BUF_X1
xb000 inputp bf000 VDDp GNDp BUF_X1
xb100 inputp bf100 VDDp GNDp BUF_X1
xb101 inputp bf101 VDDp GNDp BUF_X1

xm00 bf000 bf001 s0p q00 VDDp GNDp mux
xm10 bf100 bf101 s0p q10 VDDp GNDp mux

xb011 q00 bf011 VDDp GNDp BUF_X1
xb010 q10 bf010 VDDp GNDp BUF_X1
xb110 q00 bf110 VDDp GNDp BUF_X1
xb111 q10 bf111 VDDp GNDp BUF_X1

xm01 bf010 bf011 s1p q01 VDDp GNDp mux
xm11 bf110 bf111 s1p q11 VDDp GNDp mux

xb021 q01 bf021 VDDp GNDp BUF_X1
xb020 q11 bf020 VDDp GNDp BUF_X1
xb120 q01 bf120 VDDp GNDp BUF_X1
xb121 q11 bf121 VDDp GNDp BUF_X1

xm02 bf020 bf021 s2p q02 VDDp GNDp mux
xm12 bf120 bf121 s2p q12 VDDp GNDp mux

xb031 q02 bf031 VDDp GNDp BUF_X1
xb030 q12 bf030 VDDp GNDp BUF_X1
xb130 q02 bf130 VDDp GNDp BUF_X1
xb131 q12 bf131 VDDp GNDp BUF_X1

xm03 bf030 bf031 s3p q03 VDDp GNDp mux
xm13 bf130 bf131 s3p q13 VDDp GNDp mux

xb041 q03 bf041 VDDp GNDp BUF_X1
xb040 q13 bf040 VDDp GNDp BUF_X1
xb140 q03 bf140 VDDp GNDp BUF_X1
xb141 q13 bf141 VDDp GNDp BUF_X1

xm04 bf040 bf041 s4p q04 VDDp GNDp mux
xm14 bf140 bf141 s4p q14 VDDp GNDp mux

xb051 q04 bf051 VDDp GNDp BUF_X1
xb050 q14 bf050 VDDp GNDp BUF_X1
xb150 q04 bf150 VDDp GNDp BUF_X1
xb151 q14 bf151 VDDp GNDp BUF_X1

xm05 bf050 bf051 s5p q05 VDDp GNDp mux
xm15 bf150 bf151 s5p q15 VDDp GNDp mux

xb061 q05 bf061 VDDp GNDp BUF_X1
xb060 q15 bf060 VDDp GNDp BUF_X1
xb160 q05 bf160 VDDp GNDp BUF_X1
xb161 q15 bf161 VDDp GNDp BUF_X1

xm06 bf060 bf061 s6p q06 VDDp GNDp mux
xm16 bf160 bf161 s6p q16 VDDp GNDp mux

xb071 q06 bf071 VDDp GNDp BUF_X1
xb070 q16 bf070 VDDp GNDp BUF_X1
xb170 q06 bf170 VDDp GNDp BUF_X1
xb171 q16 bf171 VDDp GNDp BUF_X1

xm07 bf070 bf071 s7p q07 VDDp GNDp mux
xm17 bf170 bf171 s7p q17 VDDp GNDp mux

xb081 q07 bf081 VDDp GNDp BUF_X1
xb080 q17 bf080 VDDp GNDp BUF_X1
xb180 q07 bf180 VDDp GNDp BUF_X1
xb181 q17 bf181 VDDp GNDp BUF_X1

xm08 bf080 bf081 s8p q08 VDDp GNDp mux
xm18 bf180 bf181 s8p q18 VDDp GNDp mux

xb091 q08 bf091 VDDp GNDp BUF_X1
xb090 q18 bf090 VDDp GNDp BUF_X1
xb190 q08 bf190 VDDp GNDp BUF_X1
xb191 q18 bf191 VDDp GNDp BUF_X1

xm09 bf090 bf091 s9p q09 VDDp GNDp mux
xm19 bf190 bf191 s9p q19 VDDp GNDp mux

xb0101 q09 bf0101 VDDp GNDp BUF_X1
xb0100 q19 bf0100 VDDp GNDp BUF_X1
xb1100 q09 bf1100 VDDp GNDp BUF_X1
xb1101 q19 bf1101 VDDp GNDp BUF_X1

xm010 bf0100 bf0101 s10p q010 VDDp GNDp mux
xm110 bf1100 bf1101 s10p q110 VDDp GNDp mux

xb0111 q010 bf0111 VDDp GNDp BUF_X1
xb0110 q110 bf0110 VDDp GNDp BUF_X1
xb1110 q010 bf1110 VDDp GNDp BUF_X1
xb1111 q110 bf1111 VDDp GNDp BUF_X1

xm011 bf0110 bf0111 s11p q011 VDDp GNDp mux
xm111 bf1110 bf1111 s11p q111 VDDp GNDp mux


xb0121 q011 bf0121 VDDp GNDp BUF_X1
xb0120 q111 bf0120 VDDp GNDp BUF_X1
xb1120 q011 bf1120 VDDp GNDp BUF_X1
xb1121 q111 bf1121 VDDp GNDp BUF_X1

xm012 bf0120 bf0121 s12p q012 VDDp GNDp mux
xm112 bf1120 bf1121 s12p q112 VDDp GNDp mux

xb0131 q012 bf0131 VDDp GNDp BUF_X1
xb0130 q112 bf0130 VDDp GNDp BUF_X1
xb1130 q012 bf1130 VDDp GNDp BUF_X1
xb1131 q112 bf1131 VDDp GNDp BUF_X1

xm013 bf0130 bf0131 s13p q013 VDDp GNDp mux
xm113 bf1130 bf1131 s13p q113 VDDp GNDp mux

xb0141 q013 bf0141 VDDp GNDp BUF_X1
xb0140 q113 bf0140 VDDp GNDp BUF_X1
xb1140 q013 bf1140 VDDp GNDp BUF_X1
xb1141 q113 bf1141 VDDp GNDp BUF_X1

xm014 bf0140 bf0141 s14p q014 VDDp GNDp mux
xm114 bf1140 bf1141 s14p q114 VDDp GNDp mux

xb0151 q014 bf0151 VDDp GNDp BUF_X1
xb0150 q114 bf0150 VDDp GNDp BUF_X1
xb1150 q014 bf1150 VDDp GNDp BUF_X1
xb1151 q114 bf1151 VDDp GNDp BUF_X1

xm015 bf0150 bf0151 s15p q015 VDDp GNDp mux
xm115 bf1150 bf1151 s15p q115 VDDp GNDp mux

xdflip_flop q015 q115 qout i_qout VDDp GNDp DFF_X1

.ENDS

****Netlist: Main PUF Circuit 8bit ***

xpuf_1 input v0 c0 c1 c2 c3 c4 c5 c6 c7 c8 c9 c10 c11 c12 c13 c14 c15 VDD GND PUF_1bit

xpuf_2 input v1 c0 c1 c2 c3 c4 c5 c6 c7 c8 c9 c10 c11 c12 c13 c14 c15 VDD GND PUF_1bit

xpuf_3 input v2 c0 c1 c2 c3 c4 c5 c6 c7 c8 c9 c10 c11 c12 c13 c14 c15 VDD GND PUF_1bit

xpuf_4 input v3 c0 c1 c2 c3 c4 c5 c6 c7 c8 c9 c10 c11 c12 c13 c14 c15 VDD GND PUF_1bit

xpuf_5 input v4 c0 c1 c2 c3 c4 c5 c6 c7 c8 c9 c10 c11 c12 c13 c14 c15 VDD GND PUF_1bit

xpuf_6 input v5 c0 c1 c2 c3 c4 c5 c6 c7 c8 c9 c10 c11 c12 c13 c14 c15 VDD GND PUF_1bit

xpuf_7 input v6 c0 c1 c2 c3 c4 c5 c6 c7 c8 c9 c10 c11 c12 c13 c14 c15 VDD GND PUF_1bit

xpuf_8 input v7 c0 c1 c2 c3 c4 c5 c6 c7 c8 c9 c10 c11 c12 c13 c14 c15 VDD GND PUF_1bit


*** Transistor analysis***
.TRAN 2.5n 80n START=0n SWEEP MONTE=8
.PRINT TRAN V(input) V(v0) V(v1) V(v2) V(v3) V(v4) V(v5) V(v6) V(v7)


.END

