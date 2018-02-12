	.section	__TEXT,__text,regular,pure_instructions
	.macosx_version_min 10, 13
	.globl	_process
	.p2align	4, 0x90
_process:                               ## @process
	.cfi_startproc
## BB#0:
	pushq	%rbp
Lcfi0:
	.cfi_def_cfa_offset 16
Lcfi1:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
Lcfi2:
	.cfi_def_cfa_register %rbp
	subq	$32, %rsp
	leaq	L_.str(%rip), %rax
	movl	%edi, -4(%rbp)
	movl	%esi, -8(%rbp)
	movl	-4(%rbp), %esi
	movq	%rax, %rdi
	movb	$0, %al
	callq	_printf
	movl	-8(%rbp), %edi
	movl	%eax, -12(%rbp)         ## 4-byte Spill
	callq	_sleep
	leaq	L_.str.1(%rip), %rdi
	movl	-4(%rbp), %esi
	movl	-8(%rbp), %edx
	movl	%eax, -16(%rbp)         ## 4-byte Spill
	movb	$0, %al
	callq	_printf
	movl	%eax, -20(%rbp)         ## 4-byte Spill
	addq	$32, %rsp
	popq	%rbp
	retq
	.cfi_endproc

	.globl	_main
	.p2align	4, 0x90
_main:                                  ## @main
	.cfi_startproc
## BB#0:
	pushq	%rbp
Lcfi3:
	.cfi_def_cfa_offset 16
Lcfi4:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
Lcfi5:
	.cfi_def_cfa_register %rbp
	subq	$32, %rsp
	movl	$0, -4(%rbp)
	callq	_fork
	movl	%eax, -8(%rbp)
	cmpl	$0, -8(%rbp)
	jne	LBB1_4
## BB#1:
	leaq	L_.str.2(%rip), %rdi
	movb	$0, %al
	callq	_printf
	movl	%eax, -16(%rbp)         ## 4-byte Spill
	callq	_fork
	movl	%eax, -12(%rbp)
	cmpl	$0, -12(%rbp)
	jne	LBB1_3
## BB#2:
	leaq	L_.str.3(%rip), %rdi
	movb	$0, %al
	callq	_printf
	movl	%eax, -20(%rbp)         ## 4-byte Spill
LBB1_3:
	jmp	LBB1_4
LBB1_4:
	xorl	%eax, %eax
	addq	$32, %rsp
	popq	%rbp
	retq
	.cfi_endproc

	.section	__TEXT,__cstring,cstring_literals
L_.str:                                 ## @.str
	.asciz	"Prosess %d kj\303\270rer\n"

L_.str.1:                               ## @.str.1
	.asciz	"Prosess %d kj\303\270rte i %d sekunder\n"

L_.str.2:                               ## @.str.2
	.asciz	"Hvite "

L_.str.3:                               ## @.str.3
	.asciz	"nigger\n"


.subsections_via_symbols
