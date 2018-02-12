	.section	__TEXT,__text,regular,pure_instructions
	.macosx_version_min 10, 13
	.globl	_process
	.p2align	4, 0x90
_process:                               ## @process
## BB#0:
	pushq	%rbp
	movq	%rsp, %rbp
	pushq	%r14
	pushq	%rbx
	movl	%esi, %ebx
	movl	%edi, %r14d
	leaq	L_.str(%rip), %rdi
	xorl	%eax, %eax
	movl	%r14d, %esi
	callq	_printf
	movl	%ebx, %edi
	callq	_sleep
	cmpl	$1, %ebx
	jne	LBB0_3
## BB#1:
	leaq	L_.str.1(%rip), %rdi
	movl	$1, %edx
	xorl	%eax, %eax
	movl	%r14d, %esi
	jmp	LBB0_2
LBB0_3:
	leaq	L_.str.2(%rip), %rdi
	xorl	%eax, %eax
	movl	%r14d, %esi
	movl	%ebx, %edx
LBB0_2:
	popq	%rbx
	popq	%r14
	popq	%rbp
	jmp	_printf                 ## TAILCALL

	.globl	_execute
	.p2align	4, 0x90
_execute:                               ## @execute
## BB#0:
	pushq	%rbp
	movq	%rsp, %rbp
	pushq	%r14
	pushq	%rbx
	movl	%esi, %r14d
	movl	%edi, %ebx
	callq	_fork
	movslq	%ebx, %rcx
	movq	_p@GOTPCREL(%rip), %rdx
	movl	%eax, (%rdx,%rcx,4)
	testl	%eax, %eax
	je	LBB1_2
## BB#1:
	popq	%rbx
	popq	%r14
	popq	%rbp
	retq
LBB1_2:
	movl	%ebx, %edi
	movl	%r14d, %esi
	callq	_process
	xorl	%edi, %edi
	callq	_exit

	.globl	_main
	.p2align	4, 0x90
_main:                                  ## @main
## BB#0:
	pushq	%rbp
	movq	%rsp, %rbp
	pushq	%rbx
	pushq	%rax
	callq	_fork
	movq	_p@GOTPCREL(%rip), %rbx
	movl	%eax, (%rbx)
	testl	%eax, %eax
	je	LBB2_1
## BB#2:
	callq	_fork
	movl	%eax, 8(%rbx)
	testl	%eax, %eax
	je	LBB2_3
## BB#6:
	movl	(%rbx), %edi
	xorl	%esi, %esi
	xorl	%edx, %edx
	callq	_waitpid
	callq	_fork
	movl	%eax, 4(%rbx)
	testl	%eax, %eax
	je	LBB2_7
## BB#9:
	callq	_fork
	movl	%eax, 16(%rbx)
	testl	%eax, %eax
	je	LBB2_10
## BB#11:
	movl	4(%rbx), %edi
	xorl	%esi, %esi
	xorl	%edx, %edx
	callq	_waitpid
	callq	_fork
	movl	%eax, 12(%rbx)
	testl	%eax, %eax
	je	LBB2_12
## BB#13:
	movl	16(%rbx), %edi
	xorl	%esi, %esi
	xorl	%edx, %edx
	callq	_waitpid
	callq	_fork
	movl	%eax, 20(%rbx)
	testl	%eax, %eax
	je	LBB2_14
## BB#15:
	xorl	%esi, %esi
	xorl	%edx, %edx
	movl	%eax, %edi
	callq	_waitpid
	xorl	%eax, %eax
	addq	$8, %rsp
	popq	%rbx
	popq	%rbp
	retq
LBB2_1:
	xorl	%edi, %edi
	movl	$1, %esi
	jmp	LBB2_5
LBB2_3:
	movl	$2, %edi
	jmp	LBB2_4
LBB2_7:
	movl	$1, %edi
	movl	$2, %esi
	jmp	LBB2_5
LBB2_10:
	movl	$4, %edi
	jmp	LBB2_4
LBB2_12:
	movl	$3, %edi
	movl	$2, %esi
	jmp	LBB2_5
LBB2_14:
	movl	$5, %edi
LBB2_4:
	movl	$3, %esi
LBB2_5:
	callq	_process
	xorl	%edi, %edi
	callq	_exit

	.section	__TEXT,__cstring,cstring_literals
L_.str:                                 ## @.str
	.asciz	"Prosess %d kj\303\270rer\n"

L_.str.1:                               ## @.str.1
	.asciz	"Prosess %d kj\303\270rte i %d sekund\n"

L_.str.2:                               ## @.str.2
	.asciz	"Prosess %d kj\303\270rte i %d sekunder\n"

	.comm	_p,24,4                 ## @p

.subsections_via_symbols
