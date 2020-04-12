.text

.global sum_two
sum_two:
#a is r4, b is r5, sum is r2
    add r2, r4, r5
ret


.global op_three
op_three:
#a is r4, b is r5, c is r6
    subi sp, sp, 12 #allocating space on the stack for frame pointer and stack pointer
    stw ra, 8(sp)
    stw fp, 4(sp)
    addi fp, sp, 4

    call op_two #operates on r4 and r5 (a and b)

    mov r4, r2 #moving return value of first op_two call to first argument register
    mov r5, r6 #moving c into the second argument register
    call op_two #operates on r4 and r5 (return value and c)

    ldw ra, 8(sp) #restroing the stack and the frame
    ldw fp, 4(sp)
    addi sp, sp, 12
ret

.global fibbonacci
fibbonacci: 

ret

.end