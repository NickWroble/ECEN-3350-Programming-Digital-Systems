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
    movi r11, -500 #for RES time
    movi r8, -24 #for sending one color word
main:  
    movia r3, violet
    call send24
    call RES
call main

send24:
    mov r10, r31
    send24Int: 
    ldw r7, (r3)
    slli r7, r7, 31 
    srli r7, r7, 31 #extracts LSB from current word color
    beq r7, r0, logicLowBit
    call logicHighBit
    addi r8, r8, 1
    addi r3, r3, 1
    bgt r0, r8, send24Int
    movi r8, -24
callr r10

logicHighBit:
#sends one high bit across the bus, returns where (r9 + 4) points as to skip the "call logicHighBit" instruction before "beq r7, r0, logicLowBit"
    mov r9, r31
    stwio r7, (r2)
    call wait700
    stwio r0, (r2)
    call wait600
callr r9

logicLowBit:
#sends one low bit across the bus, returns where r9 points
    mov r9, r31
    addi r9, r9, 4
    stwio r7, (r2)
    call wait350
    stwio r0, (r2)
    call wait800
callr r9

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

.data
violet: 
    .word 0b100101000000000011010011
indigo: 
    .word 0b010010110000000010000010
blue:
    .word 0b000000000000000011111111
green:
    .word 0b000000001111111100000000
yellow:
    .word 0b111111111111111100000000
orange:
    .word 0b111111110111111100000000
red:
    .word 0b111111110000000000000000

.end