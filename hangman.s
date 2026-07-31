.option norelax
.eqv Write, 64
.eqv Read, 63
.global _start
.section .text
_start:
        /*instantiate a random word*/
        li a0, 1
        la a1, secret
        li a2, 7
        li a7, Write
        ecall

        /*print out line break*/
        li s0, 0
        li s1, 5
start_read_input:
        beq s0, s1, print_failure

        /*read input of same size*/
        li a0, 0
        la a1, guess
        li a2, 8
        li a7, Read
        ecall

        /*if guess != secret loop again */
        la t0, secret
        la t1, guess

        li t5, 7
compare:
        beqz t5, print_success

        lb t2, 0(t0)
        lb t3, 0(t1)

        bne t2, t3, wrong_guess
        beqz t2, print_success

        addi t0, t0, 1
        addi t1, t1, 1
        addi t5, t5, -1
        j compare

wrong_guess:
        addi s0, s0, 1
        j start_read_input

print_success:
        /*print break line*/

        li a0, 1
        la a1, success
        li a2, 7
        li a7, Write
        ecall

        j exit

print_failure:
        /*print break line*/

        li a0, 1
        la a1, failure
        li a2, 7
        li a7, Write
        ecall

exit:
        /*exit program*/
        li a0, 2
        li a7, 93
        ecall


.section .data
secret: .asciz "fragile"
guess: .space 8
success: .asciz "SUCCESS"
failure: .asciz "FAILURE"
