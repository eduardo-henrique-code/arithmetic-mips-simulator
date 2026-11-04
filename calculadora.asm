.data
num1:          .asciiz "\nDigite o 1o numero: "
num2:          .asciiz "Digite o 2o numero: "
limpa:         .asciiz "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n"
operacao:      .asciiz "\n==============================\n|     CALCULADORA ASSEMBLY   |\n==============================\n"
opcaocalculo:  .asciiz "|  C - Calculo               |\n"
opcaosair:     .asciiz "|  X - Sair                  |\n"
linha:         .asciiz "==============================\n"
soma:          .asciiz "|  A - Soma                  |\n"
subtracao:     .asciiz "|  S - Subtracao             |\n"
multiplicacao: .asciiz "|  M - Multiplicacao         |\n"
divisao:       .asciiz "|  D - Divisao               |\n"
prompt:        .asciiz "==============================\n>> Digite a opcao: "
erro:          .asciiz "\n==============================\n|   OPCAO INVALIDA!          |\n|   Tente novamente...       |\n==============================\n"
divisao_zero:  .asciiz "\n==============================\n|        DIVISAO POR 0!      |\n|     Tente novamente...     |\n==============================\n"
estouro:       .asciiz "\n==============================\n|     ESTOURO DE VALOR!      |\n|     Tente novamente...     |\n==============================\n"
resultado:     .asciiz "\n==============================\n  Resultado: "
resto:         .asciiz "\n  Resto: "
barran:        .asciiz "\n"

.text
.globl main

main:
	li $v0, 4
	la $a0, operacao
	syscall
	
	li $v0, 4
	la $a0, opcaocalculo
	syscall
	
	li $v0, 4
	la $a0, opcaosair
	syscall
	
	li $v0, 4
	la $a0, prompt
	syscall
	
	li $v0, 12
	syscall
	move $t4, $v0
	
	li $v0, 4
	la $a0, barran
	syscall
	
	beq $t4, 'C', loop
	beq $t4, 'c', loop
	beq $t4, 'X', fim
	beq $t4, 'x', fim
	j error
	
loop:
	li $v0, 4
	la $a0, linha
	syscall
	
	li $v0, 4
	la $a0, num1
	syscall
	
	li $v0, 5
	syscall
	
	move $t0, $v0
	
	li $v0, 4
	la $a0, num2
	syscall
	
	li $v0, 5
	syscall
	
	move $t1, $v0
	
	li $v0, 4
	la $a0, operacao
	syscall
	
	li $v0, 4
	la $a0, soma
	syscall
	
	li $v0, 4
	la $a0, subtracao
	syscall
	
	li $v0, 4
	la $a0, multiplicacao
	syscall
	
	li $v0, 4
	la $a0, divisao
	syscall
	
	li $v0, 4
	la $a0, prompt
	syscall
	
	li $v0, 12
	syscall
	move $t2, $v0
	
	beq $t2, 'A', chamar_soma
	beq $t2, 'a', chamar_soma
	beq $t2, 'S', chamar_subtracao
	beq $t2, 's', chamar_subtracao
	beq $t2, 'M', chamar_multiplicacao
	beq $t2, 'm', chamar_multiplicacao
	beq $t2, 'D', chamar_divisao
	beq $t2, 'd', chamar_divisao
	j error
	
chamar_soma:
	addu $t3, $t0, $t1
	xor $t5, $t0, $t3
	xor $t6, $t1, $t3
	and $t5, $t5, $t6
	bltz $t5, overflow
	j exibe
	
chamar_subtracao:
	subu $t3, $t0, $t1
	xor $t5, $t0, $t1
	xor $t6, $t0, $t3
	and $t5, $t5, $t6
	bltz $t5, overflow
	j exibe
	
chamar_multiplicacao:
	mult $t0, $t1
	mflo $t3
	mfhi $t5
	sra $t6, $t3, 31
	bne $t5, $t6, overflow
	j exibe

chamar_divisao:
	beq $t1, 0, divisor_zero
	div $t0, $t1
	mflo $t3
	mfhi $t5
	j exibe_divisao
	
exibe:
	li $v0, 4
	la $a0, limpa
	syscall
	
	li $v0, 4
	la $a0, resultado
	syscall
	
	li $v0, 1
	move $a0, $t3
	syscall
	
	j main

exibe_divisao:
	li $v0, 4
	la $a0, limpa
	syscall
	
	li $v0, 4
	la $a0, resultado
	syscall
	
	li $v0, 1
	move $a0, $t3
	syscall
	
	li $v0, 4
	la $a0, resto
	syscall
	
	li $v0, 1
	move $a0, $t5
	syscall
	
	j main

error:
	li $v0, 4
	la $a0, limpa
	syscall
	
	li $v0, 4
	la $a0, erro
	syscall
	
	j main
	
divisor_zero:
	li $v0, 4
	la $a0, limpa
	syscall
	
	li $v0, 4
	la $a0, divisao_zero
	syscall
	
	j main

overflow:
	li $v0, 4
	la $a0, limpa
	syscall
	
	li $v0, 4
	la $a0, estouro
	syscall
	
	j main

fim:
	li $v0, 10
	syscall
