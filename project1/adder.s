.text
.equ LEDs, 0xFF200000
.equ SWITCHES, 0xFF200040
.global _start
#r2 -> LEDs
#r3 -> Switches
#r4 -> Switch register
#r5 -> right switches
#r6 -> left switches
#r7 -> sum register
_start:
    movia r2, LEDs  #assigns LEDs to r2 reg
    movia r3, SWITCHES #assign switch inputs to r3 reg
LOOP:
    ldwio r4, (r3) #stores switches into r4 reg
    slli r5, r4, 27  #shifts r4 left and stores into r5; extracts rightmost switch inputs so r5 is 32'bxxxxx000...
    srli r5, r5, 27 #shifts r5 right so r5 is 32'b...000xxxxx
    srli r6, r4, 5 #shifts r4 left and stores in r6 so r6 is 32'b...000xxxxx
    add r7, r6, r5 #adds r5 and r6, stores in r7 reg
    stwio r7, (r2) #output sum register to LEDs
    br LOOP
.end