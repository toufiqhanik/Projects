.Option ingold=2 accurate
.OPTION MEASDGT=8
.OPTION NUMDGT=10
+ RUNLVL=5 ACCURATE
.op
.PARAM LMIN='50E-9'
.PARAM VDD_VALUE= 1.2
.PARAM VDD_HALF= 0.6
.OPTION BRIEF=1

.OPTION POST=2
.OPTION MEASFORM=3
.OPTION PROBE=1

VSUPPLY VDD 0 VDD_VALUE
VSUPPLYGND GND 0 0

Vinput A0 GND PWL(0n 0 2ns 0 2.00001ns VDD_VALUE 4ns VDD_VALUE 4.00001ns 0 6ns 0 6.00001ns VDD_VALUE 8ns VDD_VALUE 8.00001ns 0 10ns 0 10.00001ns VDD_VALUE 12ns VDD_VALUE 12.00001ns 0 14ns 0 14.00001ns VDD_VALUE)

.TRAN .25N 5N START=0N 

.include './trans_model_nk'
.temp 24

******** BUF MODEL ***********
* The subcircuit for BUF
.SUBCKT BUF_X1
+ A1
+ ZN
+ VDDx GNDx
M_i_2 GNDx A1 Z_neg GNDx NMOS_VTL W=0.210000U L='LMIN'
M_i_0 ZN Z_neg GNDx GNDx NMOS_VTL W=0.415000U L='LMIN'
M_i_10 VDDx A1 Z_neg VDDx PMOS_VTL W=0.315000U L='LMIN'
M_i_1 ZN Z_neg VDDx VDDx PMOS_VTL W=0.630000U L='LMIN'
.ENDS


XG0 A0 Z0 VDD GND BUF_X1

.MEASURE TRAN buff_out TRIG V(A0) VAL=VDD_HALF RISE=3 TARG V(Z0) VAL=VDD_HALF RISE=3
.PRINT TRAN V(A0) V(Z0)
.END