.globl relu

.text
# ==============================================================================
# FUNCTION: Array ReLU Activation
#
# Applies ReLU (Rectified Linear Unit) operation in-place:
# For each element x in array: x = max(0, x)
#
# Arguments:
#   a0: Pointer to integer array to be modified
#   a1: Number of elements in array
#
# Returns:
#   None - Original array is modified directly
#
# Validation:
#   Requires non-empty array (length ≥ 1)
#   Terminates (code 36) if validation fails
#
# Example:
#   Input:  [-2, 0, 3, -1, 5]
#   Result: [ 0, 0, 3,  0, 5]
# ==============================================================================
relu:
    li t0, 1             
    blt a1, t0, error                
    li t1, 0
    li t4, 0

loop_start:
    add, t2, a0, t4 # t2 = pointer
    lw t3, 0(t2)    # t3 = element
    bgt t3, zero, if_continue_loop

clear:
    sw zero, 0(t2)

if_continue_loop:
    addi t1, t1, 1
    bgt t1, a1, done

jump_to_loop_start:
    addi t4, t4, 4
    jal x0, loop_start

done:
    jr ra

error:
    li a0, 36          
    j exit          
