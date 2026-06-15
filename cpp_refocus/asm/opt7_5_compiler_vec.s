	.file	"opt7_5_abl_compiler_vec.cpp"
	.intel_syntax noprefix
	.text
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align 8
.LC0:
	.string	"cannot create std::vector larger than max_size()"
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC2:
	.string	"vector::_M_realloc_append"
	.section	.text.unlikely,"ax",@progbits
.LCOLDB7:
	.text
.LHOTB7:
	.p2align 4
	.globl	"_Z21refocus_shift_and_sumRSt6vectorI16SubApertureImageSaIS0_EEf"
	.type	"_Z21refocus_shift_and_sumRSt6vectorI16SubApertureImageSaIS0_EEf", @function
"_Z21refocus_shift_and_sumRSt6vectorI16SubApertureImageSaIS0_EEf":
.LFB4421:
	.cfi_startproc
	.cfi_personality 0x9b,"DW.ref.__gxx_personality_v0"
	.cfi_lsda 0x1b,.LLSDA4421
	push	r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	vmovaps	xmm4, xmm0
	vpxor	xmm1, xmm1, xmm1
	push	r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	push	r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	push	r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	push	rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	mov	rbp, rsi
	push	rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	mov	rbx, rdi
	sub	rsp, 168
	.cfi_def_cfa_offset 224
	mov	rcx, QWORD PTR [rsi]
	vmovdqu	xmm0, XMMWORD PTR [rcx]
	mov	QWORD PTR 32[rdi], 0
	vmovdqu	XMMWORD PTR 16[rdi], xmm1
	vmovq	rax, xmm0
	vpextrq	rsi, xmm0, 1
	vmovdqu	XMMWORD PTR [rdi], xmm0
	mov	rdx, rax
	mov	QWORD PTR 64[rsp], rsi
	imul	rdx, rsi
	vmovq	QWORD PTR 40[rsp], xmm0
	lea	rdi, [rdx+rdx]
	mov	QWORD PTR 48[rsp], rdx
	mov	QWORD PTR 104[rsp], rdi
	add	rdi, rdx
	mov	QWORD PTR 56[rsp], rdi
	test	rdx, rdx
	jne	.L2
	mov	rdx, QWORD PTR 8[rbp]
	mov	rdi, rdx
	mov	QWORD PTR 16[rsp], rdx
	sub	rdi, rcx
	mov	QWORD PTR 80[rsp], rdi
	je	.L151
.L4:
	mov	r14, QWORD PTR 80[rsp]
	mov	QWORD PTR 8[rsp], rcx
	vmovss	DWORD PTR 88[rsp], xmm4
	mov	rdi, r14
.LEHB0:
	call	"_Znwm"@PLT
.LEHE0:
	mov	rbp, rax
	lea	rax, [rax+r14]
	mov	rcx, QWORD PTR 8[rsp]
	vmovss	xmm4, DWORD PTR 88[rsp]
	mov	QWORD PTR 32[rsp], rax
.L8:
	mov	r15d, DWORD PTR 40[rsp]
	mov	r12d, DWORD PTR 64[rsp]
	cmp	QWORD PTR 16[rsp], rcx
	je	.L76
.L5:
	mov	QWORD PTR 8[rsp], rbp
	xor	r11d, r11d
	.p2align 4,,10
	.p2align 3
.L17:
	vmulss	xmm3, xmm4, DWORD PTR 40[rcx]
	mov	r13d, r15d
	mov	r14d, r12d
	vmulss	xmm2, xmm4, DWORD PTR 44[rcx]
	vrndscaless	xmm0, xmm3, xmm3, 9
	vcvttss2si	r9d, xmm0
	vrndscaless	xmm1, xmm2, xmm2, 9
	vcvttss2si	r8d, xmm1
	mov	esi, r9d
	neg	esi
	test	r9d, r9d
	mov	r10d, r8d
	cmovns	esi, r11d
	sub	r13d, r9d
	dec	r13d
	cmp	r13d, r15d
	cmovg	r13d, r15d
	neg	r10d
	test	r8d, r8d
	cmovns	r10d, r11d
	sub	r14d, r8d
	dec	r14d
	cmp	r14d, r12d
	cmovg	r14d, r12d
	cmp	esi, r13d
	jge	.L12
	cmp	r10d, r14d
	jge	.L12
	vsubss	xmm6, xmm2, xmm1
	vsubss	xmm5, xmm3, xmm0
	mov	rax, QWORD PTR 16[rcx]
	vaddss	xmm0, xmm0, DWORD PTR .LC1[rip]
	vaddss	xmm1, xmm1, DWORD PTR .LC1[rip]
	mov	QWORD PTR 80[rsp], rax
	vsubss	xmm0, xmm0, xmm3
	vsubss	xmm1, xmm1, xmm2
	vmulss	xmm2, xmm0, xmm1
	vmulss	xmm1, xmm1, xmm5
	vmulss	xmm0, xmm0, xmm6
	vmulss	xmm5, xmm5, xmm6
	cmp	QWORD PTR 32[rsp], rbp
	je	.L13
	vunpcklps	xmm0, xmm0, xmm5
	vunpcklps	xmm2, xmm2, xmm1
	mov	DWORD PTR 0[rbp], r9d
	add	rbp, 48
	mov	DWORD PTR -44[rbp], r8d
	vmovlhps	xmm2, xmm2, xmm0
	mov	DWORD PTR -24[rbp], esi
	mov	DWORD PTR -20[rbp], r13d
	mov	DWORD PTR -16[rbp], r10d
	mov	DWORD PTR -12[rbp], r14d
	mov	QWORD PTR -8[rbp], rax
	vmovups	XMMWORD PTR -40[rbp], xmm2
.L12:
	add	rcx, 48
	cmp	rcx, QWORD PTR 16[rsp]
	jne	.L17
	mov	rax, QWORD PTR 32[rsp]
	sub	rax, QWORD PTR 8[rsp]
	mov	QWORD PTR 80[rsp], rax
.L9:
	mov	rax, QWORD PTR 48[rsp]
	shr	rax, 61
	jne	.L143
	mov	rax, QWORD PTR 48[rsp]
	test	rax, rax
	je	.L79
	lea	r14, 0[0+rax*4]
	mov	rdi, r14
	mov	QWORD PTR 88[rsp], r14
.LEHB1:
	call	"_Znwm"@PLT
.LEHE1:
	mov	rdx, r14
	xor	esi, esi
	mov	rdi, rax
	mov	r13, rax
	call	"memset"@PLT
.L18:
	mov	rax, QWORD PTR 40[rsp]
	lea	r14, 1[rax]
	mov	rax, QWORD PTR 64[rsp]
	inc	rax
	imul	rax, r14
	mov	r10, rax
	movabs	rax, 2305843009213693951
	cmp	rax, r10
	jb	.L144
	vxorps	xmm0, xmm0, xmm0
	test	r10, r10
	je	.L152
	sal	r10, 2
	vmovaps	XMMWORD PTR 64[rsp], xmm0
	mov	rdi, r10
	mov	QWORD PTR 16[rsp], r10
.LEHB2:
	call	"_Znwm"@PLT
	mov	rdx, QWORD PTR 16[rsp]
	mov	rdi, rax
	xor	esi, esi
	call	"memset"@PLT
	cmp	QWORD PTR 8[rsp], rbp
	mov	r10, QWORD PTR 16[rsp]
	vmovaps	xmm0, XMMWORD PTR 64[rsp]
	mov	rdi, rax
	je	.L31
.L24:
	mov	rax, QWORD PTR 8[rsp]
	.p2align 6
	.p2align 4,,10
	.p2align 3
.L32:
	movsxd	rdx, DWORD PTR 32[rax]
	movsxd	rsi, DWORD PTR 24[rax]
	add	rax, 48
	movsxd	r8, DWORD PTR -12[rax]
	imul	rdx, r14
	imul	r8, r14
	lea	rcx, [rdx+rsi]
	inc	DWORD PTR [rdi+rcx*4]
	movsxd	rcx, DWORD PTR -20[rax]
	add	rdx, rcx
	dec	DWORD PTR [rdi+rdx*4]
	lea	rdx, [rsi+r8]
	dec	DWORD PTR [rdi+rdx*4]
	lea	rdx, [rcx+r8]
	inc	DWORD PTR [rdi+rdx*4]
	cmp	rax, rbp
	jne	.L32
	test	r12d, r12d
	jle	.L38
	test	r15d, r15d
	jle	.L38
.L29:
	mov	rax, QWORD PTR 40[rsp]
	xor	edx, edx
	lea	ecx, -1[rax]
	xor	eax, eax
	lea	r9, 1[rcx]
.L34:
	add	edx, DWORD PTR [rdi+rax*4]
	mov	DWORD PTR 0[r13+rax*4], edx
	inc	rax
	cmp	r9, rax
	jne	.L34
	cmp	r12d, 1
	jle	.L35
	lea	rax, 0[0+r14*4]
	mov	DWORD PTR 96[rsp], r15d
	xor	r14d, r14d
	mov	r11d, 1
	mov	QWORD PTR 64[rsp], rax
	lea	r8, [rdi+rax]
	mov	eax, r15d
	sal	rax, 2
	mov	QWORD PTR 16[rsp], rax
	lea	rsi, 0[r13+rax]
.L37:
	movsxd	rax, r14d
	xor	edx, edx
	add	r14d, DWORD PTR 40[rsp]
	lea	r15, 0[r13+rax*4]
	xor	eax, eax
	.p2align 5
	.p2align 4,,10
	.p2align 3
.L36:
	mov	ecx, DWORD PTR [r15+rax*4]
	add	edx, DWORD PTR [r8+rax*4]
	add	ecx, edx
	mov	DWORD PTR [rsi+rax*4], ecx
	inc	rax
	cmp	r9, rax
	jne	.L36
	inc	r11d
	add	r8, QWORD PTR 64[rsp]
	add	rsi, QWORD PTR 16[rsp]
	cmp	r12d, r11d
	jg	.L37
	mov	r15d, DWORD PTR 96[rsp]
.L38:
	test	rdi, rdi
	je	.L39
.L35:
	mov	rsi, r10
	vmovaps	XMMWORD PTR 16[rsp], xmm0
	call	"_ZdlPvm"@PLT
	vmovaps	xmm0, XMMWORD PTR 16[rsp]
.L39:
	mov	rax, QWORD PTR 56[rsp]
	shr	rax, 61
	jne	.L26
	cmp	QWORD PTR 48[rsp], 0
	je	.L153
.L27:
	mov	r14, QWORD PTR 104[rsp]
	vmovaps	XMMWORD PTR 16[rsp], xmm0
	add	r14, QWORD PTR 48[rsp]
	lea	rdi, 0[0+r14*4]
	mov	QWORD PTR 48[rsp], rdi
	call	"_Znwm"@PLT
.LEHE2:
	xor	esi, esi
	lea	rdx, 0[0+r14*4]
	mov	rdi, rax
	call	"memset"@PLT
	cmp	QWORD PTR 8[rsp], rbp
	vmovaps	xmm0, XMMWORD PTR 16[rsp]
	mov	r10, rax
	je	.L43
.L41:
	mov	rdi, QWORD PTR 40[rsp]
	mov	rax, QWORD PTR 8[rsp]
	mov	DWORD PTR 16[rsp], r15d
	mov	QWORD PTR 32[rsp], r13
	lea	rdx, [rdi+rdi]
	mov	DWORD PTR 56[rsp], r12d
	mov	QWORD PTR 96[rsp], rbx
	lea	rcx, [rdx+rdi]
	mov	QWORD PTR 64[rsp], rdx
	lea	r14, 0[0+rcx*4]
	mov	rdx, rdi
	.p2align 4,,10
	.p2align 3
.L47:
	mov	r11d, DWORD PTR 32[rax]
	mov	r12d, DWORD PTR 36[rax]
	cmp	r11d, r12d
	jge	.L44
	mov	r8d, DWORD PTR 24[rax]
	mov	ebx, DWORD PTR 28[rax]
	cmp	r8d, ebx
	jge	.L44
	movsxd	r9, DWORD PTR 4[rax]
	movsxd	rsi, r11d
	movsxd	r15, r8d
	movsxd	rdi, DWORD PTR [rax]
	sub	ebx, r8d
	vmovss	xmm16, DWORD PTR 8[rax]
	vmovss	xmm15, DWORD PTR 12[rax]
	add	r9, rsi
	imul	rsi, rdx
	lea	r13d, [r8+rdi]
	add	rdi, r15
	imul	r9, rdx
	movsxd	r13, r13d
	vmovss	xmm14, DWORD PTR 16[rax]
	vmovss	xmm13, DWORD PTR 20[rax]
	sub	rdi, r13
	add	rsi, r15
	add	rsi, rbx
	add	r9, r13
	lea	r13, [rdi+rdi*2]
	lea	rsi, [rsi+rsi*2]
	lea	r9, [r9+r9*2]
	lea	r8, [r10+rsi*4]
	lea	rsi, 0[0+rbx*4]
	add	r9, QWORD PTR 40[rax]
	sub	rbx, rsi
	sal	rbx, 2
	.p2align 4,,10
	.p2align 3
.L46:
	movzx	esi, BYTE PTR [r9]
	lea	rdi, [r9+r13]
	vcvtusi2ss	xmm9, xmm0, esi
	movzx	esi, BYTE PTR 1[r9]
	vcvtusi2ss	xmm8, xmm0, esi
	movzx	esi, BYTE PTR 2[r9]
	vcvtusi2ss	xmm7, xmm0, esi
	movzx	esi, BYTE PTR [r9+rcx]
	vcvtusi2ss	xmm6, xmm0, esi
	movzx	esi, BYTE PTR 1[r9+rcx]
	vcvtusi2ss	xmm5, xmm0, esi
	movzx	esi, BYTE PTR 2[r9+rcx]
	vcvtusi2ss	xmm4, xmm0, esi
	lea	rsi, [r8+rbx]
	.p2align 4,,10
	.p2align 3
.L45:
	movzx	r15d, BYTE PTR 3[rdi]
	vmovaps	xmm3, xmm9
	vmovaps	xmm2, xmm8
	vmovaps	xmm1, xmm7
	vmovaps	xmm12, xmm6
	vmovaps	xmm17, xmm15
	vmovaps	xmm11, xmm5
	add	rsi, 12
	vcvtusi2ss	xmm9, xmm0, r15d
	movzx	r15d, BYTE PTR 4[rdi]
	vmovaps	xmm10, xmm4
	add	rdi, 3
	vcvtusi2ss	xmm8, xmm0, r15d
	movzx	r15d, BYTE PTR 2[rdi]
	vcvtusi2ss	xmm7, xmm0, r15d
	movzx	r15d, BYTE PTR [rdi+rcx]
	vfmadd213ss	xmm17, xmm9, DWORD PTR -12[rsi]
	vcvtusi2ss	xmm6, xmm0, r15d
	movzx	r15d, BYTE PTR 1[rdi+rcx]
	vcvtusi2ss	xmm5, xmm0, r15d
	movzx	r15d, BYTE PTR 2[rdi+rcx]
	vmulss	xmm18, xmm13, xmm6
	vcvtusi2ss	xmm4, xmm0, r15d
	vfmadd132ss	xmm3, xmm18, xmm16
	vaddss	xmm3, xmm3, xmm17
	vfmadd132ss	xmm12, xmm3, xmm14
	vmovaps	xmm3, xmm15
	vfmadd213ss	xmm3, xmm8, DWORD PTR -8[rsi]
	vmovss	DWORD PTR -12[rsi], xmm12
	vmulss	xmm12, xmm13, xmm5
	vfmadd132ss	xmm2, xmm12, xmm16
	vaddss	xmm2, xmm2, xmm3
	vmulss	xmm3, xmm13, xmm4
	vfmadd132ss	xmm11, xmm2, xmm14
	vmovaps	xmm2, xmm15
	vfmadd213ss	xmm2, xmm7, DWORD PTR -4[rsi]
	vfmadd132ss	xmm1, xmm3, xmm16
	vmovss	DWORD PTR -8[rsi], xmm11
	vaddss	xmm1, xmm1, xmm2
	vfmadd132ss	xmm10, xmm1, xmm14
	vmovss	DWORD PTR -4[rsi], xmm10
	cmp	rsi, r8
	jne	.L45
	inc	r11d
	add	r9, rcx
	add	r8, r14
	cmp	r11d, r12d
	jne	.L46
.L44:
	add	rax, 48
	cmp	rbp, rax
	jne	.L47
	mov	r12d, DWORD PTR 56[rsp]
	mov	r15d, DWORD PTR 16[rsp]
	mov	r13, QWORD PTR 32[rsp]
	mov	rdx, QWORD PTR 64[rsp]
	mov	rbx, QWORD PTR 96[rsp]
	test	r12d, r12d
	jle	.L49
	test	r15d, r15d
	jle	.L49
.L42:
	mov	r14, QWORD PTR 40[rsp]
	vmovss	xmm6, DWORD PTR .LC1[rip]
	mov	r11, r13
	xor	edi, edi
	vmovss	xmm3, DWORD PTR .LC3[rip]
	vmovss	xmm5, DWORD PTR .LC4[rip]
	xor	r8d, r8d
	lea	eax, -1[r14]
	vmovss	xmm8, DWORD PTR .LC5[rip]
	lea	r9, [rdx+r14]
	lea	rsi, 3[rax+rax*2]
	mov	eax, r15d
	lea	rbp, 0[0+rax*4]
	.p2align 4,,10
	.p2align 3
.L62:
	vmovss	xmm4, DWORD PTR .LC5[rip]
	vmovss	xmm7, DWORD PTR .LC4[rip]
	lea	rax, [rdi+rdi*2]
	mov	rdx, r11
	.p2align 4,,10
	.p2align 3
.L61:
	mov	ecx, DWORD PTR [rdx]
	test	ecx, ecx
	je	.L51
	vcvtsi2ss	xmm1, xmm0, ecx
	mov	rcx, QWORD PTR 16[rbx]
	xor	r15d, r15d
	add	rcx, rax
	vdivss	xmm1, xmm6, xmm1
	vmulss	xmm2, xmm1, DWORD PTR [r10+rax*4]
	vcomiss	xmm3, xmm2
	ja	.L60
	vaddss	xmm2, xmm2, xmm5
	vminss	xmm2, xmm2, xmm8
	vcvttss2si	r15d, xmm2
.L60:
	vmulss	xmm2, xmm1, DWORD PTR 4[r10+rax*4]
	mov	BYTE PTR [rcx], r15b
	xor	r15d, r15d
	vcomiss	xmm3, xmm2
	ja	.L59
	vaddss	xmm2, xmm2, xmm5
	vminss	xmm2, xmm2, xmm4
	vcvttss2si	r15d, xmm2
.L59:
	vmulss	xmm1, xmm1, DWORD PTR 8[r10+rax*4]
	mov	BYTE PTR 1[rcx], r15b
	xor	r15d, r15d
	vcomiss	xmm3, xmm1
	ja	.L58
	vaddss	xmm1, xmm1, xmm7
	vminss	xmm1, xmm1, xmm4
	vcvttss2si	r15d, xmm1
.L58:
	mov	BYTE PTR 2[rcx], r15b
.L51:
	add	rax, 3
	add	rdx, 4
	cmp	rsi, rax
	jne	.L61
	inc	r8d
	add	rsi, r9
	add	r11, rbp
	add	rdi, r14
	cmp	r12d, r8d
	jne	.L62
.L49:
	test	r10, r10
	je	.L28
.L72:
	mov	rsi, QWORD PTR 48[rsp]
	mov	rdi, r10
	call	"_ZdlPvm"@PLT
.L28:
	test	r13, r13
	je	.L63
	mov	rsi, QWORD PTR 88[rsp]
	mov	rdi, r13
	call	"_ZdlPvm"@PLT
.L63:
	mov	rax, QWORD PTR 8[rsp]
	test	rax, rax
	je	.L1
	mov	rsi, QWORD PTR 80[rsp]
	mov	rdi, rax
	call	"_ZdlPvm"@PLT
.L1:
	add	rsp, 168
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	mov	rax, rbx
	pop	rbx
	.cfi_def_cfa_offset 48
	pop	rbp
	.cfi_def_cfa_offset 40
	pop	r12
	.cfi_def_cfa_offset 32
	pop	r13
	.cfi_def_cfa_offset 24
	pop	r14
	.cfi_def_cfa_offset 16
	pop	r15
	.cfi_def_cfa_offset 8
	ret
.L151:
	.cfi_restore_state
	mov	QWORD PTR 32[rsp], 0
	mov	r15d, eax
	mov	r12d, esi
	xor	ebp, ebp
	cmp	rcx, rdx
	jne	.L5
	mov	QWORD PTR 8[rsp], 0
.L79:
	mov	QWORD PTR 88[rsp], 0
	xor	r13d, r13d
	jmp	.L18
.L2:
	cmp	QWORD PTR 56[rsp], 0
	js	.L141
	mov	QWORD PTR 8[rsp], rcx
	mov	r14, rdi
	vmovss	DWORD PTR 32[rsp], xmm4
.LEHB3:
	call	"_Znwm"@PLT
.LEHE3:
	xor	esi, esi
	mov	rdi, rax
	lea	r12, [rax+r14]
	mov	rdx, r14
	call	"memset"@PLT
	mov	rcx, QWORD PTR 8[rsp]
	vmovss	xmm4, DWORD PTR 32[rsp]
	mov	QWORD PTR 24[rbx], r12
	mov	QWORD PTR 16[rbx], rax
	mov	rax, QWORD PTR 8[rbp]
	mov	QWORD PTR 32[rbx], r12
	mov	QWORD PTR 16[rsp], rax
	sub	rax, rcx
	mov	QWORD PTR 80[rsp], rax
	jne	.L4
	mov	QWORD PTR 32[rsp], 0
	xor	ebp, ebp
	jmp	.L8
.L153:
	xor	r10d, r10d
	cmp	QWORD PTR 8[rsp], rbp
	jne	.L41
	test	r12d, r12d
	jg	.L30
	jmp	.L28
	.p2align 4,,10
	.p2align 3
.L152:
	xor	edi, edi
	cmp	QWORD PTR 8[rsp], rbp
	jne	.L24
	test	r12d, r12d
	jle	.L154
	test	r15d, r15d
	jg	.L29
	cmp	rax, QWORD PTR 56[rsp]
	jb	.L26
	cmp	QWORD PTR 48[rsp], 0
	jne	.L27
.L30:
	mov	rax, QWORD PTR 40[rsp]
	mov	QWORD PTR 48[rsp], 0
	xor	r10d, r10d
	lea	rdx, [rax+rax]
	test	r15d, r15d
	jg	.L42
	jmp	.L28
	.p2align 4,,10
	.p2align 3
.L13:
	mov	rbp, QWORD PTR 32[rsp]
	movabs	rax, -6148914691236517205
	sub	rbp, QWORD PTR 8[rsp]
	mov	rdx, rbp
	sar	rdx, 4
	imul	rdx, rax
	movabs	rax, 192153584101141162
	cmp	rdx, rax
	je	.L142
	test	rdx, rdx
	mov	eax, 1
	mov	QWORD PTR 144[rsp], rcx
	cmovne	rax, rdx
	mov	DWORD PTR 152[rsp], r10d
	mov	DWORD PTR 140[rsp], esi
	add	rax, rdx
	movabs	rdx, 192153584101141162
	mov	DWORD PTR 120[rsp], r8d
	cmp	rax, rdx
	mov	DWORD PTR 116[rsp], r9d
	cmova	rax, rdx
	vmovss	DWORD PTR 156[rsp], xmm4
	vmovss	DWORD PTR 136[rsp], xmm5
	lea	rax, [rax+rax*2]
	vmovss	DWORD PTR 132[rsp], xmm0
	sal	rax, 4
	vmovss	DWORD PTR 128[rsp], xmm1
	mov	rdi, rax
	mov	QWORD PTR 96[rsp], rax
	vmovss	DWORD PTR 124[rsp], xmm2
.LEHB4:
	call	"_Znwm"@PLT
.LEHE4:
	vmovss	xmm0, DWORD PTR 132[rsp]
	vmovss	xmm2, DWORD PTR 124[rsp]
	test	rbp, rbp
	mov	QWORD PTR 88[rsp], rax
	mov	r9d, DWORD PTR 116[rsp]
	mov	r8d, DWORD PTR 120[rsp]
	mov	DWORD PTR 28[rax+rbp], r13d
	mov	rdi, rax
	vinsertps	xmm0, xmm0, DWORD PTR 136[rsp], 0x10
	vinsertps	xmm2, xmm2, DWORD PTR 128[rsp], 0x10
	mov	DWORD PTR 36[rax+rbp], r14d
	mov	r11d, 0
	mov	esi, DWORD PTR 140[rsp]
	mov	r10d, DWORD PTR 152[rsp]
	mov	DWORD PTR [rax+rbp], r9d
	mov	rdx, QWORD PTR 80[rsp]
	vmovlhps	xmm2, xmm2, xmm0
	mov	rcx, QWORD PTR 144[rsp]
	mov	DWORD PTR 4[rax+rbp], r8d
	mov	DWORD PTR 24[rax+rbp], esi
	vmovss	xmm4, DWORD PTR 156[rsp]
	mov	DWORD PTR 32[rax+rbp], r10d
	mov	QWORD PTR 40[rax+rbp], rdx
	vmovups	XMMWORD PTR 8[rax+rbp], xmm2
	je	.L15
	mov	rsi, QWORD PTR 8[rsp]
	mov	rdx, rbp
	mov	QWORD PTR 80[rsp], rcx
	vmovss	DWORD PTR 116[rsp], xmm4
	call	"memcpy"@PLT
	vmovss	xmm4, DWORD PTR 116[rsp]
	mov	rcx, QWORD PTR 80[rsp]
	xor	r11d, r11d
.L15:
	mov	rax, QWORD PTR 88[rsp]
	lea	rbp, 48[rax+rbp]
	mov	rax, QWORD PTR 8[rsp]
	test	rax, rax
	je	.L16
	mov	rsi, QWORD PTR 32[rsp]
	mov	rdi, rax
	mov	QWORD PTR 8[rsp], rcx
	vmovss	DWORD PTR 80[rsp], xmm4
	sub	rsi, rax
	call	"_ZdlPvm"@PLT
	vmovss	xmm4, DWORD PTR 80[rsp]
	mov	rcx, QWORD PTR 8[rsp]
	xor	r11d, r11d
.L16:
	mov	rdx, QWORD PTR 88[rsp]
	mov	rax, QWORD PTR 96[rsp]
	add	rax, rdx
	mov	QWORD PTR 8[rsp], rdx
	mov	QWORD PTR 32[rsp], rax
	jmp	.L12
.L43:
	test	r12d, r12d
	jle	.L72
	mov	rax, QWORD PTR 40[rsp]
	lea	rdx, [rax+rax]
	test	r15d, r15d
	jg	.L42
	jmp	.L72
	.p2align 4,,10
	.p2align 3
.L31:
	test	r12d, r12d
	jle	.L35
	test	r15d, r15d
	jg	.L29
	jmp	.L35
.L76:
	mov	QWORD PTR 8[rsp], rbp
	jmp	.L9
.L154:
	cmp	rax, QWORD PTR 56[rsp]
	jb	.L26
	cmp	QWORD PTR 48[rsp], 0
	jne	.L27
	jmp	.L28
.L87:
	mov	rbp, rax
	vzeroupper
	jmp	.L21
.L137:
	jmp	.L138
.L139:
	jmp	.L140
.L135:
	jmp	.L136
	.section	.gcc_except_table,"a",@progbits
.LLSDA4421:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSE4421-.LLSDACSB4421
.LLSDACSB4421:
	.uleb128 .LEHB0-.LFB4421
	.uleb128 .LEHE0-.LEHB0
	.uleb128 .L135-.LFB4421
	.uleb128 0
	.uleb128 .LEHB1-.LFB4421
	.uleb128 .LEHE1-.LEHB1
	.uleb128 .L87-.LFB4421
	.uleb128 0
	.uleb128 .LEHB2-.LFB4421
	.uleb128 .LEHE2-.LEHB2
	.uleb128 .L137-.LFB4421
	.uleb128 0
	.uleb128 .LEHB3-.LFB4421
	.uleb128 .LEHE3-.LEHB3
	.uleb128 .L135-.LFB4421
	.uleb128 0
	.uleb128 .LEHB4-.LFB4421
	.uleb128 .LEHE4-.LEHB4
	.uleb128 .L139-.LFB4421
	.uleb128 0
.LLSDACSE4421:
	.text
	.cfi_endproc
	.section	.text.unlikely
	.cfi_startproc
	.cfi_personality 0x9b,"DW.ref.__gxx_personality_v0"
	.cfi_lsda 0x1b,.LLSDAC4421
	.type	"_Z21refocus_shift_and_sumRSt6vectorI16SubApertureImageSaIS0_EEf.cold", @function
"_Z21refocus_shift_and_sumRSt6vectorI16SubApertureImageSaIS0_EEf.cold":
.LFSB4421:
.L143:
	.cfi_def_cfa_offset 224
	.cfi_offset 3, -56
	.cfi_offset 6, -48
	.cfi_offset 12, -40
	.cfi_offset 13, -32
	.cfi_offset 14, -24
	.cfi_offset 15, -16
	lea	rdi, .LC0[rip]
.LEHB5:
	call	"_ZSt20__throw_length_errorPKc"@PLT
.LEHE5:
.L26:
	lea	rdi, .LC0[rip]
.LEHB6:
	call	"_ZSt20__throw_length_errorPKc"@PLT
.LEHE6:
.L142:
	lea	rdi, .LC2[rip]
.LEHB7:
	call	"_ZSt20__throw_length_errorPKc"@PLT
.LEHE7:
.L141:
	lea	rdi, .LC0[rip]
.LEHB8:
	call	"_ZSt20__throw_length_errorPKc"@PLT
.LEHE8:
.L144:
	lea	rdi, .LC0[rip]
.LEHB9:
	call	"_ZSt20__throw_length_errorPKc"@PLT
.LEHE9:
.L85:
	mov	rbp, rax
	vzeroupper
.L21:
	cmp	QWORD PTR 8[rsp], 0
	je	.L69
	mov	rsi, QWORD PTR 32[rsp]
	mov	rdi, QWORD PTR 8[rsp]
	sub	rsi, rdi
	call	"_ZdlPvm"@PLT
.L69:
	mov	rdi, QWORD PTR 16[rbx]
	test	rdi, rdi
	je	.L70
	mov	rsi, QWORD PTR 32[rbx]
	sub	rsi, rdi
	call	"_ZdlPvm"@PLT
.L70:
	mov	rdi, rbp
.LEHB10:
	call	"_Unwind_Resume"@PLT
.LEHE10:
.L86:
.L138:
	mov	rbp, rax
	test	r13, r13
	je	.L148
	mov	rsi, QWORD PTR 88[rsp]
	mov	rdi, r13
	vzeroupper
	call	"_ZdlPvm"@PLT
	jmp	.L21
.L88:
.L140:
	mov	rbp, rax
	vzeroupper
	jmp	.L21
.L84:
.L136:
	mov	rbp, rax
	vzeroupper
	jmp	.L69
.L148:
	vzeroupper
	jmp	.L21
	.cfi_endproc
.LFE4421:
	.section	.gcc_except_table
.LLSDAC4421:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSEC4421-.LLSDACSBC4421
.LLSDACSBC4421:
	.uleb128 .LEHB5-.LCOLDB7
	.uleb128 .LEHE5-.LEHB5
	.uleb128 .L85-.LCOLDB7
	.uleb128 0
	.uleb128 .LEHB6-.LCOLDB7
	.uleb128 .LEHE6-.LEHB6
	.uleb128 .L86-.LCOLDB7
	.uleb128 0
	.uleb128 .LEHB7-.LCOLDB7
	.uleb128 .LEHE7-.LEHB7
	.uleb128 .L88-.LCOLDB7
	.uleb128 0
	.uleb128 .LEHB8-.LCOLDB7
	.uleb128 .LEHE8-.LEHB8
	.uleb128 .L84-.LCOLDB7
	.uleb128 0
	.uleb128 .LEHB9-.LCOLDB7
	.uleb128 .LEHE9-.LEHB9
	.uleb128 .L86-.LCOLDB7
	.uleb128 0
	.uleb128 .LEHB10-.LCOLDB7
	.uleb128 .LEHE10-.LEHB10
	.uleb128 0
	.uleb128 0
.LLSDACSEC4421:
	.section	.text.unlikely
	.text
	.size	"_Z21refocus_shift_and_sumRSt6vectorI16SubApertureImageSaIS0_EEf", .-"_Z21refocus_shift_and_sumRSt6vectorI16SubApertureImageSaIS0_EEf"
	.section	.text.unlikely
	.size	"_Z21refocus_shift_and_sumRSt6vectorI16SubApertureImageSaIS0_EEf.cold", .-"_Z21refocus_shift_and_sumRSt6vectorI16SubApertureImageSaIS0_EEf.cold"
.LCOLDE7:
	.text
.LHOTE7:
	.section	.rodata.cst4,"aM",@progbits,4
	.align 4
.LC1:
	.long	1065353216
	.align 4
.LC3:
	.long	-1090519040
	.align 4
.LC4:
	.long	1056964608
	.align 4
.LC5:
	.long	1132396544
	.hidden	"DW.ref.__gxx_personality_v0"
	.weak	"DW.ref.__gxx_personality_v0"
	.section	.data.rel.local.DW.ref.__gxx_personality_v0,"awG",@progbits,DW.ref.__gxx_personality_v0,comdat
	.align 8
	.type	"DW.ref.__gxx_personality_v0", @object
	.size	"DW.ref.__gxx_personality_v0", 8
"DW.ref.__gxx_personality_v0":
	.quad	"__gxx_personality_v0"
	.globl	"__gxx_personality_v0"
	.ident	"GCC: (Debian 16-20260425-1) 16.0.1 20260425 (prerelease) [gcc-16 r16-8812-gd9c07462a22]"
	.section	.note.GNU-stack,"",@progbits
