.globl argmax

.text
# =================================================================
# FUNCTION: Maximum Element First Index Finder
#
# Scans an integer array to find its maximum value and returns the
# position of its first occurrence. In cases where multiple elements
# share the maximum value, returns the smallest index.
#
# Arguments:
#   a0 (int *): Pointer to the first element of the array
#   a1 (int):  Number of elements in the array
#
# Returns:
#   a0 (int):  Position of the first maximum element (0-based index)
#
# Preconditions:
#   - Array must contain at least one element
#
# Error Cases:
#   - Terminates program with exit code 36 if array length < 1
# =================================================================
argmax:
    li t6, 1
    blt a1, t6, handle_error

    lui t1, 0x80000 # t1 = max
    addi t3, a1, -1 # t3 = i = n - 1
    add t4, x0, a0  # t4 = base address
    add a0, x0, x0  # a0 = idx = 0
    
loop_start:
    slli t5, t3, 2               # t5 = i * 4
    add t5, t5, t4
    lw t0, 0(t5)                 # t0 = element
    blt t0, t1, if_continue_loop

change_max:
    add t1, x0, t0
    add a0, x0, t3

if_continue_loop:
    addi t3, t3, -1
    blt t3, x0, done

jump_to_loop_start:
    jal x0, loop_start

done:
    jr ra

handle_error:
    li a0, 36
    j exit
