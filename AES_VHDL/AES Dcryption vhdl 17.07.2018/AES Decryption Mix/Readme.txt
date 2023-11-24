############
For mixed vhdl + verilog do:

python work.py

vlogan -full64 droundkey.v dsubbytes.v dsoftbox.v softbox.v  dfirstround.v dmixcolumn.v dround.v 

vhdlan -full64 dshiftrow.vhd daes.vhd daes_tb.vhd

vcs -full64 daes_tb
 
./simv

###########



>>Key in  "keyin.txt" file

>>ciperkey in" cipertext.txt" file

>>new Plaintext  in "newplaintext.txt" file