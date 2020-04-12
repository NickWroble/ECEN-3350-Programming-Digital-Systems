.text

.global sum_two

sum_two:
#a is r4, b is r5, sum is r2
    add r2, r4, r5
ret


.global op_three
op_three:
#a is r4, b is r5, c is r6
    call op_two
    mov r4, r2
    mov r5, r6
    call op_two
ret

.global fibbonacci
fibbonacci: 
ret

.end