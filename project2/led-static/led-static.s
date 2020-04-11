.text
.global _start 
.equ ADDR_JP1PORT, 0xFF200060
.equ ADDR_JP1PORT_DIR, 0xFF200064

_start:
    movia r2, ADDR_JP1PORT_DIR
    movia r3, 0xffffffff
    movia r3, 0x00000001
    stwio r3, 0(r2)  # Set direction of all 32-bits to output 
    movia r2, ADDR_JP1PORT
    movi r4, -23 #for 800 ns
    movi r5, -19 #for 700 ns
    movi r6, -15 #for 600 ns
    movi r1, -9 #for 350 ns
    movi r8, 0x1
    movi r9, -8 #-8
    movi r11, -500
    movi r12, -60
    movi r13, -32768
main:  
    LOOP:
    call eightHigh
    call eightLow
    call eightLow

    call eightLow
    call eightHigh
    call eightLow

    call eightLow
    call eightLow
    call eightHigh

    call RES
    addi r12, r12, 1
    bgt r0, r12, LOOP
    movi r12, -60
    wait:
    addi r13, r13, 1
    bgt r0, r13, wait
    movi r13, -32768
call main

eightHigh:
#0-bit: 700 ns high, 600 ns low
    mov r10, r31 #saves return address for eightLow label; nested wait subroutines clear proper return address
    eightHighInt:
    stwio r8, (r2)
    call wait700 #waits 700 ns
    stwio r0, (r2)
    call wait600 #waits 600 ns
    addi r9, r9, 1
    bgt r0, r9, eightHighInt
    movi r9, -8
callr r10

eightLow:
#0-bit: 350 ns high, 800 ns low
    mov r10, r31 #saves return address for eightLow label; nested wait subroutines clear proper return address
    eightLowInt:
    stwio r8, (r2)
    call wait350 #waits 350 ns
    stwio r0, (r2)
    call wait800 #waits 800 ns
    addi r9, r9, 1
    bgt r0, r9, eightLowInt
    movi r9, -8
callr r10

wait800:
#waits for 800 ns
    addi r4, r4, 1
    bgt r0, r4, wait800
    movi r4, -23
ret

wait700:
#waits for 700 ns
    addi r5, r5, 1
    bgt r0, r5, wait700
    movi r5, -19
ret

wait600:
#waits for 600 ns
    addi r4, r4, 1
    bgt r0, r4, wait600
    movi r4, -16
ret

wait350: 
#waits for 350 ns
    addi r1, r1, 1
    bgt r0, r1, wait350
    movi r1, -9
ret

RES:
#reset between colors
    stwio r0, (r2)
    addi r11, r11, 1
    bgt r0, r11, RES
    movi r11, -500
ret

.end