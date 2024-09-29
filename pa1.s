.data
get_input_string: .asciz "Enter two decimal integers and an operator (+ - / *):\n"
invalid_operand_string: .asciz "Error: invalid operator \n"
divide_by_zero_string: .asciz "Error: divide by zero \n"
result_string: .asciz "Result: %d\n"
charFormat:     .asciz "%c"
intFormat:      .asciz "%d"
stringFormat:   .asciz "%s"
inputFormat:    .asciz "%d %d %s"


int1:            .space 4
int2:            .space 4
sign:            .space 1
output:          .space 8


.text
.global main

main:
	#Isabelle Carminati


	#gets string
	ldr x0, =get_input_string
	bl printf

	#reads input and stores into memory address
	ldr x0, =inputFormat
	ldr x1, =int1
	ldr x2, =int2
	ldr x3, =sign 
	bl scanf

	ldr x1, =int1
	ldr x2, =int2
	ldr x3, =sign 

	#loads input from memory
	ldrsw x9, [x1]
	ldrsw x10, [x2]
	ldrsw x11, [x3]

	#checks operands with ASCII values
	cmp x11, #0x2B
	b.eq addition

	cmp x11, #0x2D
	b.eq subtraction

	cmp x11, #0x2A
	b.eq multiplication

	cmp x11, #0x2F
	b.eq division

	#handles error
	ldr x0, =invalid_operand_string
	bl printf
	b exit

	#operations
	addition:
	add x1, x9, x10
	b output_result

	subtraction:
	sub x1, x9, x10
	b output_result

	multiplication:
	mul x1, x9, x10
	b output_result
 
	division:
	cbz x10, zero_division
	sdiv x1, x9, x10
	b output_result
	
	zero_division:
	ldr x0, =divide_by_zero_string
	bl printf
	b exit

	#results
	output_result:
	ldr x0, =result_string
	bl printf
	b exit
exit:
    mov x0, #0
    mov x8, #93
    svc #0
