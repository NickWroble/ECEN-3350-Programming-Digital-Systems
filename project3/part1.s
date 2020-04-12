.text

.global sum_two
sum_two:
#a is r4, b is r5, sum is r2
    add r2, r4, r5
ret

.global op_three
op_three:
#a is r4, b is r5, c is r6
    subi sp, sp, 12 #allocating space on the stack for frame pointer and stack pointer and return address
    stw ra, 8(sp)
    stw fp, 4(sp)
    addi fp, sp, 4

    call op_two #operates on r4 and r5 (a and b)

    mov r4, r2 #moving return value of first op_two call to first argument register
    mov r5, r6 #moving c into the second argument register
    call op_two #operates on r4 and r5 (return value and c)

    ldw ra, 8(sp) #restroing stack frame and return address
    ldw fp, 4(sp)
    addi sp, sp, 12
ret

.global fibonacci
fibonacci:
#r4 is n
    mov r8, r4
    mov r10, r0
    fibonacci_intermediate:
    subi r9, r8, 1
    add r10, r8, r9

    
    bgt r4, r0, fibonacci_intermediate
    
ret

.end
