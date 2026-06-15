	.file	"opt7_5.cpp"
	.intel_syntax noprefix
	.text
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align 8
.LC0:
	.string	"cannot create std::vector larger than max_size()"
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC2:
	.string	"vector::_M_realloc_append"
.LC8:
	.string	"X coordinate out of bounds"
.LC9:
	.string	"Y coordinate out of bounds"
	.section	.text.unlikely,"ax",@progbits
.LCOLDB10:
	.text
.LHOTB10:
	.p2align 4
	.globl	"_Z21refocus_shift_and_sumRSt6vectorI16SubApertureImageSaIS0_EEf"
	.type	"_Z21refocus_shift_and_sumRSt6vectorI16SubApertureImageSaIS0_EEf", @function
"_Z21refocus_shift_and_sumRSt6vectorI16SubApertureImageSaIS0_EEf":
.LFB4421:refocus_shift_and_sum
	.cfi_startproc
	.cfi_personality 0x9b,"DW.ref.__gxx_personality_v0"
	.cfi_lsda 0x1b,.LLSDA4421
	push	r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	vmovaps	xmm4, xmm0
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
	sub	rsp, 152
	.cfi_def_cfa_offset 208
	mov	r15, QWORD PTR [rsi]
	mov	rax, QWORD PTR 8[r15]
	mov	r12, QWORD PTR [r15]
	mov	QWORD PTR 16[rdi], 0
	mov	QWORD PTR 24[rdi], 0
	mov	rcx, rax
	mov	QWORD PTR 40[rsp], rax
	imul	rcx, r12
	mov	QWORD PTR 32[rdi], 0
	mov	QWORD PTR [rdi], r12
	mov	QWORD PTR 8[rdi], rax
	lea	rsi, [rcx+rcx]
	mov	QWORD PTR 48[rsp], rcx
	mov	QWORD PTR 88[rsp], rsi
	add	rsi, rcx
	mov	QWORD PTR 72[rsp], rsi
	test	rcx, rcx
	jne	.L2
	mov	rsi, QWORD PTR 8[rbp]
	mov	rcx, rsi
	mov	QWORD PTR 24[rsp], rsi
	sub	rcx, r15
	mov	QWORD PTR 64[rsp], rcx
	je	.L194
.L4:
	mov	r14, QWORD PTR 64[rsp]
	vmovss	DWORD PTR 16[rsp], xmm4
	mov	rdi, r14
.LEHB0:
	call	"_Znwm"@PLT
.LEHE0:
	mov	QWORD PTR 8[rsp], rax
	add	rax, r14
	vmovss	xmm4, DWORD PTR 16[rsp]
	mov	QWORD PTR 32[rsp], rax
.L8:
	mov	r14d, DWORD PTR 40[rsp]
	mov	ecx, r12d
	cmp	r15, QWORD PTR 24[rsp]
	je	.L91
.L5:
	mov	rax, QWORD PTR 8[rsp]
	xor	r11d, r11d
	mov	QWORD PTR 16[rsp], rax
	.p2align 4,,10
	.p2align 3
.L17:
	vmulss	xmm3, xmm4, DWORD PTR 40[r15]
	mov	ebp, ecx
	mov	r13d, r14d
	vmulss	xmm2, xmm4, DWORD PTR 44[r15]
	vrndscaless	xmm0, xmm3, xmm3, 9
	vcvttss2si	r9d, xmm0
	vrndscaless	xmm1, xmm2, xmm2, 9
	vcvttss2si	r8d, xmm1
	mov	esi, r9d
	neg	esi
	test	r9d, r9d
	mov	r10d, r8d
	cmovns	esi, r11d
	sub	ebp, r9d
	dec	ebp
	cmp	ebp, ecx
	cmovg	ebp, ecx
	neg	r10d
	test	r8d, r8d
	cmovns	r10d, r11d
	sub	r13d, r8d
	dec	r13d
	cmp	r13d, r14d
	cmovg	r13d, r14d
	cmp	esi, ebp
	jge	.L12
	cmp	r10d, r13d
	jge	.L12
	vsubss	xmm6, xmm2, xmm1
	vsubss	xmm5, xmm3, xmm0
	mov	rdx, QWORD PTR 16[r15]
	mov	rax, QWORD PTR 8[rsp]
	vaddss	xmm0, xmm0, DWORD PTR .LC1[rip]
	vaddss	xmm1, xmm1, DWORD PTR .LC1[rip]
	mov	QWORD PTR 56[rsp], rdx
	vsubss	xmm0, xmm0, xmm3
	vsubss	xmm1, xmm1, xmm2
	vmulss	xmm2, xmm0, xmm1
	vmulss	xmm1, xmm1, xmm5
	vmulss	xmm0, xmm0, xmm6
	vmulss	xmm5, xmm5, xmm6
	cmp	QWORD PTR 32[rsp], rax
	je	.L13
	mov	DWORD PTR [rax], r9d
	add	rax, 48
	mov	DWORD PTR -44[rax], r8d
	vmovss	DWORD PTR -40[rax], xmm2
	vmovss	DWORD PTR -36[rax], xmm1
	vmovss	DWORD PTR -32[rax], xmm0
	vmovss	DWORD PTR -28[rax], xmm5
	mov	DWORD PTR -24[rax], esi
	mov	DWORD PTR -20[rax], ebp
	mov	DWORD PTR -16[rax], r10d
	mov	DWORD PTR -12[rax], r13d
	mov	QWORD PTR -8[rax], rdx
	mov	QWORD PTR 8[rsp], rax
.L12:
	add	r15, 48
	cmp	r15, QWORD PTR 24[rsp]
	jne	.L17
	mov	rax, QWORD PTR 32[rsp]
	sub	rax, QWORD PTR 16[rsp]
	mov	QWORD PTR 64[rsp], rax
.L9:
	mov	rax, QWORD PTR 48[rsp]
	shr	rax, 61
	jne	.L176
	mov	rax, QWORD PTR 48[rsp]
	test	rax, rax
	je	.L94
	lea	rbp, 0[0+rax*4]
	mov	DWORD PTR 24[rsp], ecx
	mov	rdi, rbp
	mov	QWORD PTR 80[rsp], rbp
.LEHB1:
	call	"_Znwm"@PLT
.LEHE1:
	mov	rdx, rbp
	xor	esi, esi
	mov	rdi, rax
	mov	r15, rax
	call	"memset"@PLT
	mov	ecx, DWORD PTR 24[rsp]
.L18:
	mov	rax, QWORD PTR 40[rsp]
	lea	r13, 1[r12]
	inc	rax
	imul	rax, r13
	mov	QWORD PTR 56[rsp], rax
	shr	rax, 61
	jne	.L177
	mov	rax, QWORD PTR 56[rsp]
	test	rax, rax
	je	.L95
	sal	rax, 2
	mov	DWORD PTR 24[rsp], ecx
	mov	rdi, rax
	mov	QWORD PTR 56[rsp], rax
.LEHB2:
	call	"_Znwm"@PLT
.LEHE2:
	mov	rdx, QWORD PTR 56[rsp]
	xor	esi, esi
	mov	rdi, rax
	mov	rbp, rax
	call	"memset"@PLT
	mov	ecx, DWORD PTR 24[rsp]
.L23:
	mov	rax, QWORD PTR 72[rsp]
	shr	rax, 61
	jne	.L178
	cmp	QWORD PTR 48[rsp], 0
	vxorps	xmm0, xmm0, xmm0
	je	.L195
	mov	rdx, QWORD PTR 88[rsp]
	mov	DWORD PTR 96[rsp], ecx
	add	rdx, QWORD PTR 48[rsp]
	sal	rdx, 2
	mov	rdi, rdx
	mov	QWORD PTR 72[rsp], rdx
	mov	QWORD PTR 48[rsp], rdx
.LEHB3:
	call	"_Znwm"@PLT
.LEHE3:
	mov	rdx, QWORD PTR 72[rsp]
	mov	ecx, DWORD PTR 96[rsp]
	mov	QWORD PTR 24[rsp], rax
	vxorps	xmm0, xmm0, xmm0
	mov	DWORD PTR [rax], 0x00000000
	cmp	rdx, 4
	je	.L196
	sub	rdx, 4
	xor	esi, esi
	lea	rdi, 4[rax]
	mov	DWORD PTR 72[rsp], ecx
	call	"memset"@PLT
	mov	rcx, QWORD PTR 16[rsp]
	vxorps	xmm0, xmm0, xmm0
	cmp	QWORD PTR 8[rsp], rcx
	mov	ecx, DWORD PTR 72[rsp]
	je	.L35
.L26:
	mov	rax, QWORD PTR 16[rsp]
	mov	rdi, QWORD PTR 8[rsp]
	.p2align 6
	.p2align 4,,10
	.p2align 3
.L36:
	movsxd	rdx, DWORD PTR 32[rax]
	movsxd	r8, DWORD PTR 24[rax]
	add	rax, 48
	movsxd	r9, DWORD PTR -12[rax]
	imul	rdx, r13
	imul	r9, r13
	lea	rsi, [rdx+r8]
	inc	DWORD PTR 0[rbp+rsi*4]
	movsxd	rsi, DWORD PTR -20[rax]
	add	rdx, rsi
	dec	DWORD PTR 0[rbp+rdx*4]
	lea	rdx, [r8+r9]
	dec	DWORD PTR 0[rbp+rdx*4]
	lea	rdx, [rsi+r9]
	inc	DWORD PTR 0[rbp+rdx*4]
	cmp	rax, rdi
	jne	.L36
	test	r14d, r14d
	jle	.L37
	test	ecx, ecx
	jle	.L183
.L38:
	lea	ecx, -1[r12]
	xor	eax, eax
	xor	edx, edx
	lea	rdi, 1[rcx]
.L40:
	add	edx, DWORD PTR 0[rbp+rax*4]
	mov	DWORD PTR [r15+rax*4], edx
	inc	rax
	cmp	rdi, rax
	jne	.L40
	cmp	r14d, 1
	jle	.L41
	lea	rax, 0[0+r13*4]
	mov	r11, r12
	mov	r10d, 1
	mov	QWORD PTR 72[rsp], rax
	lea	rsi, 0[rbp+rax]
.L43:
	lea	eax, -1[r10]
	lea	r8, [r15+r11*4]
	xor	edx, edx
	imul	rax, r12
	lea	r9, [r15+rax*4]
	xor	eax, eax
	.p2align 5
	.p2align 4,,10
	.p2align 3
.L42:
	mov	ecx, DWORD PTR [r9+rax*4]
	add	edx, DWORD PTR [rsi+rax*4]
	add	ecx, edx
	mov	DWORD PTR [r8+rax*4], ecx
	inc	rax
	cmp	rdi, rax
	jne	.L42
	inc	r10d
	add	rsi, QWORD PTR 72[rsp]
	add	r11, r12
	cmp	r10d, r14d
	jl	.L43
.L183:
	mov	rcx, QWORD PTR 16[rsp]
	cmp	QWORD PTR 8[rsp], rcx
	je	.L28
.L39:
	mov	QWORD PTR 72[rsp], r15
	lea	rcx, [r12+r12*2]
	mov	rax, QWORD PTR 16[rsp]
	mov	QWORD PTR 88[rsp], rbp
	lea	r14, 0[0+rcx*4]
	mov	QWORD PTR 96[rsp], r13
	mov	r13, QWORD PTR 24[rsp]
	mov	QWORD PTR 104[rsp], rbx
	mov	rbx, QWORD PTR 8[rsp]
	.p2align 4,,10
	.p2align 3
.L53:
	mov	r10d, DWORD PTR 32[rax]
	mov	r15d, DWORD PTR 36[rax]
	cmp	r10d, r15d
	jge	.L50
	mov	r8d, DWORD PTR 24[rax]
	mov	r11d, DWORD PTR 28[rax]
	cmp	r8d, r11d
	jge	.L50
	movsxd	r9, DWORD PTR 4[rax]
	movsxd	rdx, r10d
	movsxd	rbp, r8d
	sub	r11d, r8d
	movsxd	rdi, DWORD PTR [rax]
	vmovss	xmm16, DWORD PTR 8[rax]
	add	r9, rdx
	imul	rdx, r12
	vmovss	xmm15, DWORD PTR 12[rax]
	vmovss	xmm14, DWORD PTR 16[rax]
	imul	r9, r12
	lea	esi, [r8+rdi]
	add	rdi, rbp
	vmovss	xmm13, DWORD PTR 20[rax]
	movsxd	rsi, esi
	add	rdx, rbp
	lea	rbp, [rdi+rdi*2]
	add	rdx, r11
	add	r9, rsi
	lea	rdx, [rdx+rdx*2]
	lea	r9, [r9+r9*2]
	lea	r8, 0[r13+rdx*4]
	lea	rdx, 0[0+r11*4]
	add	r9, QWORD PTR 40[rax]
	sub	r11, rdx
	lea	rdx, 0[0+rsi*4]
	sub	rsi, rdx
	sal	r11, 2
	add	rbp, rsi
	.p2align 4,,10
	.p2align 3
.L52:
	movzx	edx, BYTE PTR [r9]
	lea	rsi, [r9+rbp]
	vcvtusi2ss	xmm9, xmm0, edx
	movzx	edx, BYTE PTR 1[r9]
	vcvtusi2ss	xmm8, xmm0, edx
	movzx	edx, BYTE PTR 2[r9]
	vcvtusi2ss	xmm7, xmm0, edx
	movzx	edx, BYTE PTR [r9+rcx]
	vcvtusi2ss	xmm6, xmm0, edx
	movzx	edx, BYTE PTR 1[r9+rcx]
	vcvtusi2ss	xmm5, xmm0, edx
	movzx	edx, BYTE PTR 2[r9+rcx]
	vcvtusi2ss	xmm4, xmm0, edx
	lea	rdx, [r11+r8]
	.p2align 4,,10
	.p2align 3
.L51:
	movzx	edi, BYTE PTR 3[rsi]
	vmovaps	xmm3, xmm9
	vmovaps	xmm2, xmm8
	vmovaps	xmm1, xmm7
	vmovaps	xmm12, xmm6
	vmovaps	xmm17, xmm15
	vmovaps	xmm11, xmm5
	add	rdx, 12
	vcvtusi2ss	xmm9, xmm0, edi
	movzx	edi, BYTE PTR 4[rsi]
	vmovaps	xmm10, xmm4
	add	rsi, 3
	vcvtusi2ss	xmm8, xmm0, edi
	movzx	edi, BYTE PTR 2[rsi]
	vcvtusi2ss	xmm7, xmm0, edi
	movzx	edi, BYTE PTR [rsi+rcx]
	vfmadd213ss	xmm17, xmm9, DWORD PTR -12[rdx]
	vcvtusi2ss	xmm6, xmm0, edi
	movzx	edi, BYTE PTR 1[rsi+rcx]
	vcvtusi2ss	xmm5, xmm0, edi
	movzx	edi, BYTE PTR 2[rsi+rcx]
	vmulss	xmm18, xmm13, xmm6
	vcvtusi2ss	xmm4, xmm0, edi
	vfmadd132ss	xmm3, xmm18, xmm16
	vaddss	xmm3, xmm3, xmm17
	vfmadd132ss	xmm12, xmm3, xmm14
	vmovaps	xmm3, xmm15
	vfmadd213ss	xmm3, xmm8, DWORD PTR -8[rdx]
	vmovss	DWORD PTR -12[rdx], xmm12
	vmulss	xmm12, xmm13, xmm5
	vfmadd132ss	xmm2, xmm12, xmm16
	vaddss	xmm2, xmm2, xmm3
	vmulss	xmm3, xmm13, xmm4
	vfmadd132ss	xmm11, xmm2, xmm14
	vmovaps	xmm2, xmm15
	vfmadd213ss	xmm2, xmm7, DWORD PTR -4[rdx]
	vfmadd132ss	xmm1, xmm3, xmm16
	vmovss	DWORD PTR -8[rdx], xmm11
	vaddss	xmm1, xmm1, xmm2
	vfmadd132ss	xmm10, xmm1, xmm14
	vmovss	DWORD PTR -4[rdx], xmm10
	cmp	rdx, r8
	jne	.L51
	inc	r10d
	add	r9, rcx
	add	r8, r14
	cmp	r10d, r15d
	jne	.L52
.L50:
	add	rax, 48
	cmp	rbx, rax
	jne	.L53
	mov	r15, QWORD PTR 72[rsp]
	mov	rbp, QWORD PTR 88[rsp]
	mov	r13, QWORD PTR 96[rsp]
	mov	rbx, QWORD PTR 104[rsp]
.L49:
	cmp	QWORD PTR 40[rsp], 0
	je	.L54
.L28:
	test	r12, r12
	je	.L55
	vmovss	xmm3, DWORD PTR .LC4[rip]
	vbroadcastss	xmm4, DWORD PTR .LC6[rip]
	lea	r8, 0[0+r12*4]
	mov	rsi, r15
	vmovss	xmm5, DWORD PTR .LC7[rip]
	mov	r9, QWORD PTR 40[rsp]
	xor	edi, edi
	xor	ecx, ecx
	mov	r10, QWORD PTR 24[rsp]
	vandnps	xmm3, xmm4, xmm3
	vxorps	xmm6, xmm6, xmm6
	.p2align 4,,10
	.p2align 3
.L73:
	lea	rax, [rdi+rdi*2]
	lea	rdx, [r10+rax*4]
	xor	eax, eax
	.p2align 4,,10
	.p2align 3
.L72:
	mov	r11d, DWORD PTR [rsi+rax*4]
	test	r11d, r11d
	je	.L56
	vcvtsi2ss	xmm2, xmm0, r11d
	vmovss	xmm1, DWORD PTR [rdx]
	vmovaps	xmm7, xmm4
	mov	r11, QWORD PTR [rbx]
	mov	r14, QWORD PTR 8[rbx]
	vdivss	xmm1, xmm1, xmm2
	vpternlogd	xmm7, xmm1, xmm3, 234
	vaddss	xmm1, xmm1, xmm7
	vrndscaless	xmm1, xmm1, xmm1, 3
	vmaxss	xmm1, xmm1, xmm6
	vminss	xmm1, xmm1, xmm5
	vcvttss2si	r13d, xmm1
	cmp	rax, r11
	jnb	.L179
	cmp	rcx, r14
	jnb	.L180
	vmovss	xmm1, DWORD PTR 4[rdx]
	imul	r11, rcx
	vmovaps	xmm7, xmm4
	vdivss	xmm1, xmm1, xmm2
	add	r11, rax
	lea	r11, [r11+r11*2]
	add	r11, QWORD PTR 16[rbx]
	mov	BYTE PTR [r11], r13b
	mov	r11, QWORD PTR [rbx]
	mov	r14, QWORD PTR 8[rbx]
	vpternlogd	xmm7, xmm1, xmm3, 234
	vaddss	xmm1, xmm1, xmm7
	vrndscaless	xmm1, xmm1, xmm1, 3
	vmaxss	xmm1, xmm1, xmm6
	vminss	xmm1, xmm1, xmm5
	vcvttss2si	r13d, xmm1
	cmp	rax, r11
	jnb	.L197
	cmp	rcx, r14
	jnb	.L181
	vmovss	xmm1, DWORD PTR 8[rdx]
	imul	r11, rcx
	vmovaps	xmm7, xmm4
	vdivss	xmm1, xmm1, xmm2
	add	r11, rax
	lea	r11, [r11+r11*2]
	add	r11, QWORD PTR 16[rbx]
	mov	BYTE PTR 1[r11], r13b
	mov	r11, QWORD PTR [rbx]
	mov	r14, QWORD PTR 8[rbx]
	vpternlogd	xmm7, xmm1, xmm3, 234
	vaddss	xmm1, xmm1, xmm7
	vrndscaless	xmm1, xmm1, xmm1, 3
	vmaxss	xmm1, xmm1, xmm6
	vminss	xmm1, xmm1, xmm5
	vcvttss2si	r13d, xmm1
	cmp	rax, r11
	jnb	.L198
	cmp	rcx, r14
	jnb	.L182
	imul	r11, rcx
	add	r11, rax
	lea	r11, [r11+r11*2]
	add	r11, QWORD PTR 16[rbx]
	mov	BYTE PTR 2[r11], r13b
.L56:
	inc	rax
	add	rdx, 12
	cmp	r12, rax
	jne	.L72
	inc	rcx
	add	rdi, r12
	add	rsi, r8
	cmp	r9, rcx
	jne	.L73
.L54:
	cmp	QWORD PTR 24[rsp], 0
	je	.L29
.L34:
	mov	rsi, QWORD PTR 48[rsp]
	mov	rdi, QWORD PTR 24[rsp]
	call	"_ZdlPvm"@PLT
.L29:
	test	rbp, rbp
	je	.L75
.L47:
	mov	rsi, QWORD PTR 56[rsp]
	mov	rdi, rbp
	call	"_ZdlPvm"@PLT
.L75:
	test	r15, r15
	je	.L76
	mov	rsi, QWORD PTR 80[rsp]
	mov	rdi, r15
	call	"_ZdlPvm"@PLT
.L76:
	mov	rax, QWORD PTR 16[rsp]
	test	rax, rax
	je	.L1
	mov	rsi, QWORD PTR 64[rsp]
	mov	rdi, rax
	call	"_ZdlPvm"@PLT
.L1:
	add	rsp, 152
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
.L55:
	.cfi_restore_state
	mov	rax, QWORD PTR 40[rsp]
	cmp	rax, r13
	je	.L54
.L199:
	add	r12, 2
	cmp	rax, r12
	je	.L54
	mov	rax, QWORD PTR 40[rsp]
	lea	r13, 1[r12]
	cmp	rax, r13
	jne	.L199
	jmp	.L54
.L194:
	mov	QWORD PTR 8[rsp], 0
	mov	ecx, r12d
	mov	r14d, eax
	mov	QWORD PTR 32[rsp], 0
	cmp	r15, rsi
	jne	.L5
	mov	QWORD PTR 16[rsp], 0
.L94:
	mov	QWORD PTR 80[rsp], 0
	xor	r15d, r15d
	jmp	.L18
.L2:
	cmp	QWORD PTR 72[rsp], 0
	js	.L174
	mov	rdi, rsi
	mov	r14, rsi
	vmovss	DWORD PTR 8[rsp], xmm0
.LEHB4:
	call	"_Znwm"@PLT
.LEHE4:
	xor	esi, esi
	mov	rdx, r14
	mov	rdi, rax
	lea	r13, [rax+r14]
	call	"memset"@PLT
	mov	QWORD PTR 24[rbx], r13
	vmovss	xmm4, DWORD PTR 8[rsp]
	mov	QWORD PTR 16[rbx], rax
	mov	rax, QWORD PTR 8[rbp]
	mov	QWORD PTR 32[rbx], r13
	mov	QWORD PTR 24[rsp], rax
	sub	rax, r15
	mov	QWORD PTR 64[rsp], rax
	jne	.L4
	mov	QWORD PTR 32[rsp], 0
	mov	QWORD PTR 8[rsp], 0
	jmp	.L8
.L195:
	mov	rsi, QWORD PTR 16[rsp]
	mov	QWORD PTR 24[rsp], 0
	cmp	QWORD PTR 8[rsp], rsi
	jne	.L26
	test	r14d, r14d
	jg	.L27
	cmp	QWORD PTR 40[rsp], 0
	jne	.L28
	jmp	.L29
	.p2align 4,,10
	.p2align 3
.L95:
	xor	ebp, ebp
	jmp	.L23
.L13:
	mov	rax, QWORD PTR 32[rsp]
	sub	rax, QWORD PTR 16[rsp]
	mov	QWORD PTR 8[rsp], rax
	sar	rax, 4
	mov	rdx, rax
	movabs	rax, -6148914691236517205
	imul	rdx, rax
	movabs	rax, 192153584101141162
	cmp	rdx, rax
	je	.L175
	test	rdx, rdx
	mov	eax, 1
	mov	DWORD PTR 136[rsp], ecx
	cmovne	rax, rdx
	mov	DWORD PTR 132[rsp], r10d
	mov	DWORD PTR 128[rsp], esi
	add	rax, rdx
	movabs	rdx, 192153584101141162
	mov	DWORD PTR 104[rsp], r8d
	cmp	rax, rdx
	mov	DWORD PTR 96[rsp], r9d
	cmova	rax, rdx
	vmovss	DWORD PTR 140[rsp], xmm4
	vmovss	DWORD PTR 124[rsp], xmm5
	lea	rax, [rax+rax*2]
	vmovss	DWORD PTR 120[rsp], xmm0
	sal	rax, 4
	vmovss	DWORD PTR 116[rsp], xmm1
	mov	rdi, rax
	mov	QWORD PTR 80[rsp], rax
	vmovss	DWORD PTR 112[rsp], xmm2
.LEHB5:
	call	"_Znwm"@PLT
.LEHE5:
	mov	rdx, QWORD PTR 8[rsp]
	mov	esi, DWORD PTR 128[rsp]
	mov	QWORD PTR 64[rsp], rax
	mov	rdi, rax
	mov	r9d, DWORD PTR 96[rsp]
	mov	r8d, DWORD PTR 104[rsp]
	mov	r11d, 0
	vmovss	xmm2, DWORD PTR 112[rsp]
	vmovss	xmm1, DWORD PTR 116[rsp]
	mov	DWORD PTR 24[rax+rdx], esi
	test	rdx, rdx
	vmovss	xmm0, DWORD PTR 120[rsp]
	vmovss	xmm5, DWORD PTR 124[rsp]
	mov	DWORD PTR [rax+rdx], r9d
	mov	r10d, DWORD PTR 132[rsp]
	mov	rsi, QWORD PTR 56[rsp]
	mov	DWORD PTR 4[rax+rdx], r8d
	mov	ecx, DWORD PTR 136[rsp]
	vmovss	xmm4, DWORD PTR 140[rsp]
	mov	DWORD PTR 28[rax+rdx], ebp
	mov	DWORD PTR 32[rax+rdx], r10d
	mov	DWORD PTR 36[rax+rdx], r13d
	mov	QWORD PTR 40[rax+rdx], rsi
	vmovss	DWORD PTR 8[rax+rdx], xmm2
	vmovss	DWORD PTR 12[rax+rdx], xmm1
	vmovss	DWORD PTR 16[rax+rdx], xmm0
	vmovss	DWORD PTR 20[rax+rdx], xmm5
	je	.L15
	mov	rsi, QWORD PTR 16[rsp]
	mov	DWORD PTR 56[rsp], ecx
	vmovss	DWORD PTR 96[rsp], xmm4
	call	"memcpy"@PLT
	vmovss	xmm4, DWORD PTR 96[rsp]
	mov	ecx, DWORD PTR 56[rsp]
	xor	r11d, r11d
.L15:
	mov	rsi, QWORD PTR 8[rsp]
	mov	rax, QWORD PTR 64[rsp]
	lea	rax, 48[rax+rsi]
	mov	QWORD PTR 8[rsp], rax
	mov	rax, QWORD PTR 16[rsp]
	test	rax, rax
	je	.L16
	mov	rsi, QWORD PTR 32[rsp]
	mov	rdi, rax
	mov	DWORD PTR 16[rsp], ecx
	vmovss	DWORD PTR 56[rsp], xmm4
	sub	rsi, rax
	call	"_ZdlPvm"@PLT
	vmovss	xmm4, DWORD PTR 56[rsp]
	mov	ecx, DWORD PTR 16[rsp]
	xor	r11d, r11d
.L16:
	mov	rsi, QWORD PTR 64[rsp]
	mov	rax, QWORD PTR 80[rsp]
	add	rax, rsi
	mov	QWORD PTR 16[rsp], rsi
	mov	QWORD PTR 32[rsp], rax
	jmp	.L12
.L37:
	mov	rcx, QWORD PTR 16[rsp]
	cmp	QWORD PTR 8[rsp], rcx
	jne	.L39
	jmp	.L49
.L196:
	mov	rsi, QWORD PTR 16[rsp]
	cmp	QWORD PTR 8[rsp], rsi
	jne	.L26
.L35:
	test	r14d, r14d
	jle	.L200
.L27:
	test	ecx, ecx
	jg	.L38
	jmp	.L28
	.p2align 4,,10
	.p2align 3
.L91:
	mov	rax, QWORD PTR 8[rsp]
	mov	QWORD PTR 16[rsp], rax
	jmp	.L9
.L41:
	mov	rcx, QWORD PTR 16[rsp]
	cmp	QWORD PTR 8[rsp], rcx
	jne	.L39
	cmp	QWORD PTR 40[rsp], 0
	jne	.L28
	cmp	QWORD PTR 24[rsp], 0
	jne	.L34
	jmp	.L47
	.p2align 4,,10
	.p2align 3
.L200:
	cmp	QWORD PTR 40[rsp], 0
	jne	.L28
	jmp	.L34
.L168:
	jmp	.L169
.L170:
	jmp	.L171
.L172:
	jmp	.L173
.L110:
	mov	rbp, rax
	vzeroupper
	jmp	.L21
.L198:
	jmp	.L65
.L197:
	jmp	.L59
.L166:
	jmp	.L167
	.section	.gcc_except_table,"a",@progbits
.LLSDA4421:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSE4421-.LLSDACSB4421
.LLSDACSB4421:
	.uleb128 .LEHB0-.LFB4421
	.uleb128 .LEHE0-.LEHB0
	.uleb128 .L166-.LFB4421
	.uleb128 0
	.uleb128 .LEHB1-.LFB4421
	.uleb128 .LEHE1-.LEHB1
	.uleb128 .L110-.LFB4421
	.uleb128 0
	.uleb128 .LEHB2-.LFB4421
	.uleb128 .LEHE2-.LEHB2
	.uleb128 .L168-.LFB4421
	.uleb128 0
	.uleb128 .LEHB3-.LFB4421
	.uleb128 .LEHE3-.LEHB3
	.uleb128 .L170-.LFB4421
	.uleb128 0
	.uleb128 .LEHB4-.LFB4421
	.uleb128 .LEHE4-.LEHB4
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB5-.LFB4421
	.uleb128 .LEHE5-.LEHB5
	.uleb128 .L172-.LFB4421
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
.L178:
	.cfi_def_cfa_offset 208
	.cfi_offset 3, -56
	.cfi_offset 6, -48
	.cfi_offset 12, -40
	.cfi_offset 13, -32
	.cfi_offset 14, -24
	.cfi_offset 15, -16
	lea	rdi, .LC0[rip]
.LEHB6:
	call	"_ZSt20__throw_length_errorPKc"@PLT
.LEHE6:
.L101:
.L169:
	mov	rbp, rax
	vzeroupper
.L81:
	test	r15, r15
	je	.L21
	mov	rsi, QWORD PTR 80[rsp]
	mov	rdi, r15
	call	"_ZdlPvm"@PLT
.L21:
	cmp	QWORD PTR 16[rsp], 0
	je	.L85
	mov	rsi, QWORD PTR 32[rsp]
	mov	rdi, QWORD PTR 16[rsp]
	sub	rsi, rdi
	call	"_ZdlPvm"@PLT
	jmp	.L85
.L102:
.L171:
	mov	r12, rax
	vzeroupper
.L79:
	test	rbp, rbp
	je	.L80
	mov	rsi, QWORD PTR 56[rsp]
	mov	rdi, rbp
	call	"_ZdlPvm"@PLT
.L80:
	mov	rbp, r12
	jmp	.L81
.L176:
	lea	rdi, .LC0[rip]
.LEHB7:
	call	"_ZSt20__throw_length_errorPKc"@PLT
.LEHE7:
.L181:
	mov	edi, 16
	call	"__cxa_allocate_exception"@PLT
	lea	rsi, .LC9[rip]
	mov	rdi, rax
	mov	r12, rax
.LEHB8:
	call	"_ZNSt12out_of_rangeC1EPKc"@PLT
.LEHE8:
	mov	rdx, QWORD PTR "_ZNSt12out_of_rangeD1Ev"@GOTPCREL[rip]
	lea	rsi, "_ZTISt12out_of_range"[rip]
	mov	rdi, r12
.LEHB9:
	call	"__cxa_throw"@PLT
.LEHE9:
.L179:
	mov	edi, 16
	call	"__cxa_allocate_exception"@PLT
	lea	rsi, .LC8[rip]
	mov	rdi, rax
	mov	r12, rax
.LEHB10:
	call	"_ZNSt12out_of_rangeC1EPKc"@PLT
.LEHE10:
	mov	rdx, QWORD PTR "_ZNSt12out_of_rangeD1Ev"@GOTPCREL[rip]
	lea	rsi, "_ZTISt12out_of_range"[rip]
	mov	rdi, r12
.LEHB11:
	call	"__cxa_throw"@PLT
.LEHE11:
.L111:
.L173:
	mov	rbp, rax
	vzeroupper
	jmp	.L21
.L105:
.L191:
	mov	rdi, r12
	mov	r13, rax
	vzeroupper
	call	"__cxa_free_exception"@PLT
	jmp	.L62
.L177:
	lea	rdi, .LC0[rip]
.LEHB12:
	call	"_ZSt20__throw_length_errorPKc"@PLT
.LEHE12:
.L182:
	mov	edi, 16
	call	"__cxa_allocate_exception"@PLT
	lea	rsi, .LC9[rip]
	mov	rdi, rax
	mov	r12, rax
.LEHB13:
	call	"_ZNSt12out_of_rangeC1EPKc"@PLT
.LEHE13:
	mov	rdx, QWORD PTR "_ZNSt12out_of_rangeD1Ev"@GOTPCREL[rip]
	lea	rsi, "_ZTISt12out_of_range"[rip]
	mov	rdi, r12
.LEHB14:
	call	"__cxa_throw"@PLT
.LEHE14:
.L174:
	lea	rdi, .LC0[rip]
.LEHB15:
	call	"_ZSt20__throw_length_errorPKc"@PLT
.LEHE15:
.L108:
	jmp	.L191
.L99:
.L167:
	mov	rbp, rax
	vzeroupper
.L85:
	mov	rdi, QWORD PTR 16[rbx]
	test	rdi, rdi
	je	.L86
	mov	rsi, QWORD PTR 32[rbx]
	sub	rsi, rdi
	call	"_ZdlPvm"@PLT
.L86:
	mov	rdi, rbp
.LEHB16:
	call	"_Unwind_Resume"@PLT
.LEHE16:
.L100:
	mov	rbp, rax
	vzeroupper
	jmp	.L21
.L180:
	mov	edi, 16
	call	"__cxa_allocate_exception"@PLT
	lea	rsi, .LC9[rip]
	mov	rdi, rax
	mov	r12, rax
.LEHB17:
	call	"_ZNSt12out_of_rangeC1EPKc"@PLT
.LEHE17:
	mov	rdx, QWORD PTR "_ZNSt12out_of_rangeD1Ev"@GOTPCREL[rip]
	lea	rsi, "_ZTISt12out_of_range"[rip]
	mov	rdi, r12
.LEHB18:
	call	"__cxa_throw"@PLT
.LEHE18:
.L104:
	jmp	.L191
.L59:
	mov	edi, 16
	call	"__cxa_allocate_exception"@PLT
	lea	rsi, .LC8[rip]
	mov	rdi, rax
	mov	r12, rax
.LEHB19:
	call	"_ZNSt12out_of_rangeC1EPKc"@PLT
.LEHE19:
	mov	rdx, QWORD PTR "_ZNSt12out_of_rangeD1Ev"@GOTPCREL[rip]
	lea	rsi, "_ZTISt12out_of_range"[rip]
	mov	rdi, r12
.LEHB20:
	call	"__cxa_throw"@PLT
.LEHE20:
.L103:
	mov	r13, rax
	vzeroupper
.L62:
	cmp	QWORD PTR 24[rsp], 0
	je	.L78
	mov	rsi, QWORD PTR 48[rsp]
	mov	rdi, QWORD PTR 24[rsp]
	call	"_ZdlPvm"@PLT
.L78:
	mov	r12, r13
	jmp	.L79
.L106:
	jmp	.L191
.L107:
	jmp	.L191
.L65:
	mov	edi, 16
	call	"__cxa_allocate_exception"@PLT
	lea	rsi, .LC8[rip]
	mov	rdi, rax
	mov	r12, rax
.LEHB21:
	call	"_ZNSt12out_of_rangeC1EPKc"@PLT
.LEHE21:
	mov	rdx, QWORD PTR "_ZNSt12out_of_rangeD1Ev"@GOTPCREL[rip]
	lea	rsi, "_ZTISt12out_of_range"[rip]
	mov	rdi, r12
.LEHB22:
	call	"__cxa_throw"@PLT
.LEHE22:
.L109:
	jmp	.L191
.L175:
	lea	rdi, .LC2[rip]
.LEHB23:
	call	"_ZSt20__throw_length_errorPKc"@PLT
.LEHE23:
	.cfi_endproc
.LFE4421:
	.section	.gcc_except_table
.LLSDAC4421:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSEC4421-.LLSDACSBC4421
.LLSDACSBC4421:
	.uleb128 .LEHB6-.LCOLDB10
	.uleb128 .LEHE6-.LEHB6
	.uleb128 .L102-.LCOLDB10
	.uleb128 0
	.uleb128 .LEHB7-.LCOLDB10
	.uleb128 .LEHE7-.LEHB7
	.uleb128 .L100-.LCOLDB10
	.uleb128 0
	.uleb128 .LEHB8-.LCOLDB10
	.uleb128 .LEHE8-.LEHB8
	.uleb128 .L106-.LCOLDB10
	.uleb128 0
	.uleb128 .LEHB9-.LCOLDB10
	.uleb128 .LEHE9-.LEHB9
	.uleb128 .L103-.LCOLDB10
	.uleb128 0
	.uleb128 .LEHB10-.LCOLDB10
	.uleb128 .LEHE10-.LEHB10
	.uleb128 .L105-.LCOLDB10
	.uleb128 0
	.uleb128 .LEHB11-.LCOLDB10
	.uleb128 .LEHE11-.LEHB11
	.uleb128 .L103-.LCOLDB10
	.uleb128 0
	.uleb128 .LEHB12-.LCOLDB10
	.uleb128 .LEHE12-.LEHB12
	.uleb128 .L101-.LCOLDB10
	.uleb128 0
	.uleb128 .LEHB13-.LCOLDB10
	.uleb128 .LEHE13-.LEHB13
	.uleb128 .L108-.LCOLDB10
	.uleb128 0
	.uleb128 .LEHB14-.LCOLDB10
	.uleb128 .LEHE14-.LEHB14
	.uleb128 .L103-.LCOLDB10
	.uleb128 0
	.uleb128 .LEHB15-.LCOLDB10
	.uleb128 .LEHE15-.LEHB15
	.uleb128 .L99-.LCOLDB10
	.uleb128 0
	.uleb128 .LEHB16-.LCOLDB10
	.uleb128 .LEHE16-.LEHB16
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB17-.LCOLDB10
	.uleb128 .LEHE17-.LEHB17
	.uleb128 .L104-.LCOLDB10
	.uleb128 0
	.uleb128 .LEHB18-.LCOLDB10
	.uleb128 .LEHE18-.LEHB18
	.uleb128 .L103-.LCOLDB10
	.uleb128 0
	.uleb128 .LEHB19-.LCOLDB10
	.uleb128 .LEHE19-.LEHB19
	.uleb128 .L107-.LCOLDB10
	.uleb128 0
	.uleb128 .LEHB20-.LCOLDB10
	.uleb128 .LEHE20-.LEHB20
	.uleb128 .L103-.LCOLDB10
	.uleb128 0
	.uleb128 .LEHB21-.LCOLDB10
	.uleb128 .LEHE21-.LEHB21
	.uleb128 .L109-.LCOLDB10
	.uleb128 0
	.uleb128 .LEHB22-.LCOLDB10
	.uleb128 .LEHE22-.LEHB22
	.uleb128 .L103-.LCOLDB10
	.uleb128 0
	.uleb128 .LEHB23-.LCOLDB10
	.uleb128 .LEHE23-.LEHB23
	.uleb128 .L111-.LCOLDB10
	.uleb128 0
.LLSDACSEC4421:
	.section	.text.unlikely
	.text
	.size	"_Z21refocus_shift_and_sumRSt6vectorI16SubApertureImageSaIS0_EEf", .-"_Z21refocus_shift_and_sumRSt6vectorI16SubApertureImageSaIS0_EEf"
	.section	.text.unlikely
	.size	"_Z21refocus_shift_and_sumRSt6vectorI16SubApertureImageSaIS0_EEf.cold", .-"_Z21refocus_shift_and_sumRSt6vectorI16SubApertureImageSaIS0_EEf.cold"
.LCOLDE10:
	.text
.LHOTE10:
	.section	.rodata.cst4,"aM",@progbits,4
	.align 4
.LC1:
	.long	1065353216
	.align 4
.LC4:
	.long	1056964607
	.align 4
.LC6:
	.long	-2147483648
	.align 4
.LC7:
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
