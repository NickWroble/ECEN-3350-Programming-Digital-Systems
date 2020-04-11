.text
.global _start
_start:
  movia r2, 0xFF200020
  movia r10, PATTA
  movia r11, PATTB
  movia r12, PATTC
  movi r14, 0
  
main:
  movia r5, TEXT
  movi r4, -32768
  movi r8, -400
  movi r6, 0
  movi r7, 0
  movi r9, -17
  movi r13, -3
  stwio r0, (r2)
  call wait
  call scrolling

scrolling:
  ldw		r7, (r5)
  add		r6, r6, r7
  stwio r6, (r2)
  call wait
  addi r5, r5, 4
  addi r9, r9, 1
  slli r6, r6, 8
  movi r13, -3
  bgt r9, r0, patterns
  call scrolling

patterns:
  ldw r7, (r10)
  stwio r7, (r2)
  call wait
  ldw r7, (r11)
  stwio r7, (r2)
  call wait
  addi r13, r13, 1
  bgt r0, r13, patterns
  movi r13, -3
  call all    

all: 
  ldw r7, (r12)
  stwio r7, (r2)
  call wait
  stwio r0, (r2)
  call wait
  addi r13, r13, 1
  bgt r0, r13, all
  call main  

wait:
  addi r4, r4, 1
  bgt r0, r4, wait
  movi r4, -32768
  addi r8, r8, 1
  bgt r0, r8, wait
  movi r8, -400
ret

.data
TEXT:
  .word 0b01110110, 0b01111001, 0b00111000, 0b00111000, 0b00111111, 0b00000000, 0b01111100, 0b00111110, 0b01110001, 0b01110001, 0b01101101, 0b01000000, 0b01000000, 0b01000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000
PATTA: 
  .word 0b01001001010010010100100101001001
PATTB: 
  .word 0b00110110001101100011011000110110
PATTC:
  .word 0b01111111011111110111111101111111

.end