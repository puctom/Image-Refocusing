	.file	"opt9_abl_hand_vec_no_tile.cpp"
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
.LFB11708:
	.cfi_startproc
	.cfi_personality 0x9b,"DW.ref.__gxx_personality_v0"
	.cfi_lsda 0x1b,.LLSDA11708
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	vmovaps	xmm4, xmm0
	vpxor	xmm1, xmm1, xmm1
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	push	r15
	push	r14
	push	r13
	push	r12
	.cfi_offset 15, -24
	.cfi_offset 14, -32
	.cfi_offset 13, -40
	.cfi_offset 12, -48
	mov	r12, rsi
	push	rbx
	.cfi_offset 3, -56
	mov	rbx, rdi
	and	rsp, -32
	sub	rsp, 224
	mov	r8, QWORD PTR [rsi]
	vmovdqu	xmm0, XMMWORD PTR [r8]
	mov	QWORD PTR 32[rdi], 0
	vmovdqu	XMMWORD PTR 16[rdi], xmm1
	vpextrq	rax, xmm0, 1
	vmovq	r15, xmm0
	vmovdqu	XMMWORD PTR [rdi], xmm0
	mov	rdi, rax
	mov	QWORD PTR 168[rsp], rax
	imul	rdi, r15
	lea	rdx, [rdi+rdi]
	mov	QWORD PTR 56[rsp], rdi
	mov	QWORD PTR 144[rsp], rdx
	add	rdx, rdi
	mov	QWORD PTR 192[rsp], rdx
	test	rdi, rdi
	jne	.L2
	mov	rdi, QWORD PTR 8[rsi]
	mov	rdx, rdi
	mov	QWORD PTR 208[rsp], rdi
	sub	rdx, r8
	mov	QWORD PTR 48[rsp], rdx
	je	.L170
.L4:
	mov	r14, QWORD PTR 48[rsp]
	mov	QWORD PTR 176[rsp], r8
	vmovss	DWORD PTR 160[rsp], xmm4
	mov	rdi, r14
.LEHB0:
	call	"_Znwm"@PLT
.LEHE0:
	mov	r13, rax
	lea	rax, [rax+r14]
	mov	r8, QWORD PTR 176[rsp]
	vmovss	xmm4, DWORD PTR 160[rsp]
	mov	QWORD PTR 200[rsp], rax
.L8:
	mov	DWORD PTR 96[rsp], r15d
	mov	r14d, DWORD PTR 168[rsp]
	cmp	r8, QWORD PTR 208[rsp]
	je	.L83
.L5:
	mov	QWORD PTR 80[rsp], r13
	.p2align 4,,10
	.p2align 3
.L19:
	vmulss	xmm3, xmm4, DWORD PTR 40[r8]
	xor	eax, eax
	mov	esi, r14d
	vmulss	xmm2, xmm4, DWORD PTR 44[r8]
	vrndscaless	xmm0, xmm3, xmm3, 9
	vcvttss2si	r11d, xmm0
	vrndscaless	xmm1, xmm2, xmm2, 9
	vcvttss2si	r10d, xmm1
	mov	r9d, r11d
	neg	r9d
	test	r11d, r11d
	cmovns	r9d, eax
	mov	eax, DWORD PTR 96[rsp]
	mov	r12d, eax
	sub	r12d, r11d
	dec	r12d
	cmp	r12d, eax
	cmovg	r12d, eax
	mov	eax, r10d
	xor	ecx, ecx
	neg	eax
	test	r10d, r10d
	cmovs	ecx, eax
	sub	esi, r10d
	dec	esi
	cmp	esi, r14d
	cmovg	esi, r14d
	cmp	r9d, r12d
	jge	.L12
	cmp	ecx, esi
	jge	.L12
	vsubss	xmm6, xmm2, xmm1
	vsubss	xmm5, xmm3, xmm0
	mov	rax, QWORD PTR 16[r8]
	vaddss	xmm0, xmm0, DWORD PTR .LC1[rip]
	vaddss	xmm1, xmm1, DWORD PTR .LC1[rip]
	mov	QWORD PTR 176[rsp], rax
	vsubss	xmm0, xmm0, xmm3
	vsubss	xmm1, xmm1, xmm2
	vmulss	xmm2, xmm0, xmm1
	vmulss	xmm1, xmm1, xmm5
	vmulss	xmm0, xmm0, xmm6
	vmulss	xmm5, xmm5, xmm6
	cmp	r13, QWORD PTR 200[rsp]
	je	.L13
	vunpcklps	xmm0, xmm0, xmm5
	vunpcklps	xmm2, xmm2, xmm1
	mov	DWORD PTR 0[r13], r11d
	add	r13, 48
	mov	DWORD PTR -44[r13], r10d
	vmovlhps	xmm2, xmm2, xmm0
	mov	DWORD PTR -24[r13], r9d
	mov	DWORD PTR -20[r13], r12d
	mov	DWORD PTR -16[r13], ecx
	mov	DWORD PTR -12[r13], esi
	mov	QWORD PTR -8[r13], rax
	vmovups	XMMWORD PTR -40[r13], xmm2
.L12:
	add	r8, 48
	cmp	r8, QWORD PTR 208[rsp]
	jne	.L19
	mov	rax, QWORD PTR 200[rsp]
	sub	rax, QWORD PTR 80[rsp]
	mov	QWORD PTR 48[rsp], rax
.L9:
	mov	rax, QWORD PTR 56[rsp]
	shr	rax, 61
	jne	.L160
	mov	rax, QWORD PTR 56[rsp]
	test	rax, rax
	je	.L86
	lea	r12, 0[0+rax*4]
	mov	rdi, r12
	mov	QWORD PTR 40[rsp], r12
.LEHB1:
	call	"_Znwm"@PLT
.LEHE1:
	mov	rdx, r12
	xor	esi, esi
	mov	rdi, rax
	mov	QWORD PTR 64[rsp], rax
	call	"memset"@PLT
.L20:
	mov	rax, QWORD PTR 168[rsp]
	lea	r12, 1[r15]
	inc	rax
	imul	rax, r12
	mov	r9, rax
	movabs	rax, 2305843009213693951
	cmp	rax, r9
	jb	.L161
	vxorps	xmm4, xmm4, xmm4
	test	r9, r9
	je	.L171
	sal	r9, 2
	vmovaps	XMMWORD PTR 176[rsp], xmm4
	mov	rdi, r9
	mov	QWORD PTR 208[rsp], r9
.LEHB2:
	call	"_Znwm"@PLT
	mov	rdx, QWORD PTR 208[rsp]
	mov	rdi, rax
	xor	esi, esi
	call	"memset"@PLT
	cmp	QWORD PTR 80[rsp], r13
	mov	r9, QWORD PTR 208[rsp]
	vmovaps	xmm4, XMMWORD PTR 176[rsp]
	mov	rdi, rax
	je	.L32
.L25:
	mov	rax, QWORD PTR 80[rsp]
	.p2align 6
	.p2align 4,,10
	.p2align 3
.L33:
	movsxd	rdx, DWORD PTR 32[rax]
	movsxd	rsi, DWORD PTR 24[rax]
	add	rax, 48
	movsxd	r8, DWORD PTR -12[rax]
	imul	rdx, r12
	imul	r8, r12
	lea	rcx, [rdx+rsi]
	inc	DWORD PTR [rdi+rcx*4]
	movsxd	rcx, DWORD PTR -20[rax]
	add	rdx, rcx
	dec	DWORD PTR [rdi+rdx*4]
	lea	rdx, [rsi+r8]
	dec	DWORD PTR [rdi+rdx*4]
	lea	rdx, [rcx+r8]
	inc	DWORD PTR [rdi+rdx*4]
	cmp	rax, r13
	jne	.L33
	test	r14d, r14d
	jle	.L39
	mov	r8d, DWORD PTR 96[rsp]
	test	r8d, r8d
	jle	.L39
.L30:
	lea	esi, -1[r15]
	mov	rcx, QWORD PTR 64[rsp]
	xor	eax, eax
	xor	edx, edx
	lea	r8, 1[rsi]
.L35:
	add	edx, DWORD PTR [rdi+rax*4]
	mov	DWORD PTR [rcx+rax*4], edx
	inc	rax
	cmp	r8, rax
	jne	.L35
	cmp	r14d, 1
	jle	.L36
	mov	eax, DWORD PTR 96[rsp]
	mov	rdx, QWORD PTR 64[rsp]
	mov	QWORD PTR 176[rsp], r9
	mov	rcx, r12
	mov	QWORD PTR 160[rsp], rbx
	mov	r11d, 1
	sal	rax, 2
	mov	QWORD PTR 168[rsp], r13
	xor	r13d, r13d
	mov	QWORD PTR 208[rsp], rax
	lea	rsi, [rdx+rax]
.L38:
	mov	rdx, QWORD PTR 64[rsp]
	movsxd	rax, r13d
	lea	rbx, [rdi+rcx*4]
	add	r13d, r15d
	lea	r10, [rdx+rax*4]
	xor	eax, eax
	xor	edx, edx
	.p2align 5
	.p2align 4,,10
	.p2align 3
.L37:
	mov	r9d, DWORD PTR [r10+rax*4]
	add	edx, DWORD PTR [rbx+rax*4]
	add	r9d, edx
	mov	DWORD PTR [rsi+rax*4], r9d
	inc	rax
	cmp	r8, rax
	jne	.L37
	inc	r11d
	add	rcx, r12
	add	rsi, QWORD PTR 208[rsp]
	cmp	r14d, r11d
	jne	.L38
	mov	r9, QWORD PTR 176[rsp]
	mov	r13, QWORD PTR 168[rsp]
	mov	rbx, QWORD PTR 160[rsp]
.L39:
	test	rdi, rdi
	je	.L40
.L36:
	mov	rsi, r9
	vmovaps	XMMWORD PTR 208[rsp], xmm4
	call	"_ZdlPvm"@PLT
	vmovaps	xmm4, XMMWORD PTR 208[rsp]
.L40:
	mov	rax, QWORD PTR 192[rsp]
	shr	rax, 61
	jne	.L27
	cmp	QWORD PTR 56[rsp], 0
	je	.L172
.L28:
	mov	r12, QWORD PTR 144[rsp]
	vmovaps	XMMWORD PTR 208[rsp], xmm4
	add	r12, QWORD PTR 56[rsp]
	lea	rdi, 0[0+r12*4]
	mov	QWORD PTR 56[rsp], rdi
	call	"_Znwm"@PLT
.LEHE2:
	xor	esi, esi
	lea	rdx, 0[0+r12*4]
	mov	rdi, rax
	mov	QWORD PTR 168[rsp], rax
	call	"memset"@PLT
	cmp	QWORD PTR 80[rsp], r13
	vmovaps	xmm4, XMMWORD PTR 208[rsp]
	je	.L44
.L42:
	lea	rax, [r15+r15]
	mov	QWORD PTR 72[rsp], r13
	lea	rdi, [rax+r15]
	mov	DWORD PTR 36[rsp], r14d
	mov	QWORD PTR 120[rsp], rdi
	mov	rdi, QWORD PTR 80[rsp]
	mov	QWORD PTR 24[rsp], rax
	mov	QWORD PTR 112[rsp], rdi
	mov	QWORD PTR 16[rsp], rbx
	.p2align 4,,10
	.p2align 3
.L55:
	mov	rax, QWORD PTR 112[rsp]
	mov	ecx, DWORD PTR 32[rax]
	mov	edi, DWORD PTR 36[rax]
	mov	DWORD PTR 160[rsp], ecx
	mov	DWORD PTR 108[rsp], edi
	cmp	ecx, edi
	jge	.L45
	mov	rdi, rax
	movsxd	rsi, DWORD PTR 24[rax]
	vmovss	xmm14, DWORD PTR 8[rax]
	mov	QWORD PTR 88[rsp], r15
	mov	edx, DWORD PTR 28[rdi]
	mov	r9d, DWORD PTR [rdi]
	vmovss	xmm13, DWORD PTR 12[rax]
	vmovss	xmm12, DWORD PTR 16[rax]
	vbroadcastss	ymm18, xmm14
	sub	edx, esi
	vmovss	xmm11, DWORD PTR 20[rax]
	mov	rax, rsi
	vmovaps	ymm3, ymm18
	lea	ebx, [rdx+rdx*2]
	movsxd	rdx, ecx
	movsxd	rcx, DWORD PTR 4[rdi]
	add	eax, r9d
	movsxd	rdi, r9d
	cdqe
	mov	DWORD PTR 128[rsp], ebx
	vbroadcastss	ymm17, xmm13
	add	rcx, rdx
	imul	rdx, r15
	vbroadcastss	ymm16, xmm12
	add	rdi, rsi
	imul	rcx, r15
	lea	r8, [r15+rdi]
	vbroadcastss	ymm19, xmm11
	vmovaps	ymm2, ymm17
	vmovaps	ymm1, ymm16
	vmovaps	ymm0, ymm19
	add	rdx, rsi
	add	rax, rcx
	add	rdi, rcx
	add	r8, rcx
	lea	rax, [rax+rax*2]
	lea	rdi, [rdi+rdi*2]
	mov	QWORD PTR 176[rsp], rax
	lea	eax, -8[rbx]
	lea	r10, [r8+r8*2]
	mov	QWORD PTR 192[rsp], rdi
	lea	rdi, [rdx+rdx*2]
	mov	edx, eax
	and	eax, -8
	add	eax, 8
	shr	edx, 3
	mov	QWORD PTR 208[rsp], rdi
	sub	ebx, eax
	mov	DWORD PTR 104[rsp], eax
	inc	edx
	mov	DWORD PTR 152[rsp], ebx
	shr	ebx, 5
	lea	r12, 0[0+rdx*8]
	mov	eax, ebx
	mov	DWORD PTR 100[rsp], ebx
	sal	rax, 5
	mov	QWORD PTR 200[rsp], r10
	mov	r10, rax
	.p2align 4,,10
	.p2align 3
.L54:
	mov	rax, QWORD PTR 176[rsp]
	mov	rdx, QWORD PTR 208[rsp]
	mov	rdi, rax
	add	rax, QWORD PTR 120[rsp]
	cmp	DWORD PTR 128[rsp], 7
	mov	QWORD PTR 176[rsp], rax
	mov	rax, QWORD PTR 168[rsp]
	lea	rdx, [rax+rdx*4]
	jle	.L173
	mov	rax, QWORD PTR 112[rsp]
	mov	rbx, QWORD PTR 176[rsp]
	xor	ecx, ecx
	mov	rax, QWORD PTR 40[rax]
	lea	r8, [rax+rdi]
	lea	rsi, [rax+rbx]
	.p2align 4,,10
	.p2align 3
.L49:
	vpmovzxbd	ymm8, QWORD PTR [r8+rcx]
	vpmovzxbd	ymm7, QWORD PTR 3[r8+rcx]
	vpmovzxbd	ymm6, QWORD PTR [rsi+rcx]
	vpmovzxbd	ymm5, QWORD PTR 3[rsi+rcx]
	vcvtdq2ps	ymm8, ymm8
	vfmadd213ps	ymm8, ymm3, YMMWORD PTR [rdx+rcx*4]
	vcvtdq2ps	ymm7, ymm7
	vcvtdq2ps	ymm6, ymm6
	vcvtdq2ps	ymm5, ymm5
	vfmadd132ps	ymm7, ymm8, ymm2
	vfmadd132ps	ymm6, ymm7, ymm1
	vfmadd132ps	ymm5, ymm6, ymm0
	vmovups	YMMWORD PTR [rdx+rcx*4], ymm5
	add	rcx, 8
	cmp	r12, rcx
	jne	.L49
	mov	ecx, DWORD PTR 104[rsp]
	mov	ebx, DWORD PTR 152[rsp]
	mov	r15d, ecx
	mov	DWORD PTR 144[rsp], ebx
	test	ebx, ebx
	jle	.L47
	mov	rsi, QWORD PTR 176[rsp]
	add	rdi, rcx
	add	rsi, rcx
	mov	QWORD PTR 136[rsp], rsi
	lea	esi, -1[rbx]
	cmp	esi, 30
	jbe	.L91
	mov	rbx, QWORD PTR 200[rsp]
	mov	rsi, QWORD PTR 208[rsp]
	xor	r8d, r8d
	mov	r14, QWORD PTR 168[rsp]
	lea	r11, [rcx+rbx]
	mov	rbx, QWORD PTR 192[rsp]
	add	rsi, rcx
	lea	r13, 3[rax+r11]
	lea	rsi, [r14+rsi*4]
	add	r11, rax
	lea	r9, [rcx+rbx]
	lea	rbx, 3[rax+r9]
	add	r9, rax
	.p2align 4,,10
	.p2align 3
.L51:
	vmovdqu	ymm5, YMMWORD PTR [r11+r8]
	vmovdqu	ymm6, YMMWORD PTR [rbx+r8]
	sub	rsi, -128
	vmovdqu	ymm7, YMMWORD PTR [r9+r8]
	vpmovzxbw	ymm9, xmm5
	vpmovzxbw	ymm8, xmm6
	vextracti32x4	xmm5, ymm5, 0x1
	vpmovsxwd	ymm15, xmm9
	vextracti32x4	xmm9, ymm9, 0x1
	vpmovsxwd	ymm10, xmm8
	vpmovsxwd	ymm9, xmm9
	vextracti32x4	xmm8, ymm8, 0x1
	vpmovzxbw	ymm5, xmm5
	vcvtdq2ps	ymm15, ymm15
	vcvtdq2ps	ymm10, ymm10
	vcvtdq2ps	ymm9, ymm9
	vmulps	ymm9, ymm9, ymm1
	vpmovsxwd	ymm8, xmm8
	vextracti32x4	xmm6, ymm6, 0x1
	vmulps	ymm15, ymm15, ymm1
	vcvtdq2ps	ymm8, ymm8
	vpmovzxbw	ymm6, xmm6
	vpmovzxbw	ymm22, xmm7
	vextracti32x4	xmm7, ymm7, 0x1
	vpmovzxbw	ymm7, xmm7
	vfmadd132ps	ymm8, ymm9, ymm2
	vpmovsxwd	ymm9, xmm5
	vextracti32x4	xmm5, ymm5, 0x1
	vcvtdq2ps	ymm9, ymm9
	vmulps	ymm9, ymm9, ymm1
	vfmadd132ps	ymm10, ymm15, ymm2
	vpmovsxwd	ymm5, xmm5
	vcvtdq2ps	ymm5, ymm5
	vmulps	ymm5, ymm5, ymm1
	vpmovsxwd	ymm15, xmm6
	vextracti32x4	xmm6, ymm6, 0x1
	vcvtdq2ps	ymm15, ymm15
	vpmovsxwd	ymm6, xmm6
	vcvtdq2ps	ymm6, ymm6
	vfmadd132ps	ymm15, ymm9, ymm2
	vpmovsxwd	ymm9, xmm22
	vcvtdq2ps	ymm9, ymm9
	vfmadd213ps	ymm9, ymm3, YMMWORD PTR -128[rsi]
	vfmadd132ps	ymm6, ymm5, ymm2
	vmovdqu	ymm5, YMMWORD PTR 0[r13+r8]
	add	r8, 32
	vpmovzxbw	ymm21, xmm5
	vextracti32x4	xmm5, ymm5, 0x1
	vpmovsxwd	ymm20, xmm21
	vextracti32x4	xmm21, ymm21, 0x1
	vpmovzxbw	ymm5, xmm5
	vcvtdq2ps	ymm20, ymm20
	vpmovsxwd	ymm21, xmm21
	vfmadd132ps	ymm20, ymm9, ymm0
	vextracti32x4	xmm9, ymm22, 0x1
	vpmovsxwd	ymm22, xmm7
	vcvtdq2ps	ymm21, ymm21
	vpmovsxwd	ymm9, xmm9
	vextracti32x4	xmm7, ymm7, 0x1
	vcvtdq2ps	ymm22, ymm22
	vcvtdq2ps	ymm9, ymm9
	vfmadd213ps	ymm9, ymm3, YMMWORD PTR -96[rsi]
	vfmadd213ps	ymm22, ymm3, YMMWORD PTR -64[rsi]
	vpmovsxwd	ymm7, xmm7
	vcvtdq2ps	ymm7, ymm7
	vfmadd213ps	ymm7, ymm3, YMMWORD PTR -32[rsi]
	vaddps	ymm10, ymm10, ymm20
	vfmadd132ps	ymm21, ymm9, ymm0
	vpmovsxwd	ymm9, xmm5
	vextracti32x4	xmm5, ymm5, 0x1
	vpmovsxwd	ymm5, xmm5
	vcvtdq2ps	ymm9, ymm9
	vfmadd132ps	ymm9, ymm22, ymm0
	vmovups	YMMWORD PTR -128[rsi], ymm10
	vcvtdq2ps	ymm5, ymm5
	vfmadd132ps	ymm5, ymm7, ymm0
	vaddps	ymm21, ymm21, ymm8
	vaddps	ymm15, ymm15, ymm9
	vaddps	ymm5, ymm5, ymm6
	vmovups	YMMWORD PTR -96[rsi], ymm21
	vmovups	YMMWORD PTR -64[rsi], ymm15
	vmovups	YMMWORD PTR -32[rsi], ymm5
	cmp	r8, r10
	jne	.L51
	mov	r9d, DWORD PTR 100[rsp]
	sal	r9d, 5
	cmp	r9d, DWORD PTR 152[rsp]
	je	.L47
	mov	esi, r9d
.L50:
	mov	r8d, DWORD PTR 152[rsp]
	sub	r8d, r9d
	lea	r11d, -1[r8]
	cmp	r11d, 14
	jbe	.L92
	mov	rbx, QWORD PTR 200[rsp]
	mov	r11d, r9d
	mov	r14, QWORD PTR 192[rsp]
	vmovaps	xmm20, xmm18
	add	rbx, rcx
	lea	r13, [rcx+r14]
	mov	r14, QWORD PTR 208[rsp]
	add	rbx, r11
	add	r13, r11
	vmovdqu	xmm5, XMMWORD PTR [rax+rbx]
	vmovdqu	xmm6, XMMWORD PTR 3[rax+r13]
	add	r14, rcx
	vmovdqu	xmm15, XMMWORD PTR [rax+r13]
	add	r14, r11
	mov	r11, QWORD PTR 168[rsp]
	vpmovzxbw	xmm9, xmm5
	vpsrldq	xmm5, xmm5, 8
	vpmovzxbw	xmm8, xmm6
	vpmovsxwd	xmm24, xmm9
	vpsrldq	xmm9, xmm9, 8
	vpmovzxbw	xmm5, xmm5
	vcvtdq2ps	xmm24, xmm24
	vmulps	xmm24, xmm24, xmm16
	vpmovsxwd	xmm10, xmm8
	vpmovsxwd	xmm9, xmm9
	vcvtdq2ps	xmm10, xmm10
	vcvtdq2ps	xmm9, xmm9
	vmulps	xmm9, xmm9, xmm16
	vpsrldq	xmm6, xmm6, 8
	vpmovzxbw	xmm7, xmm15
	vpsrldq	xmm8, xmm8, 8
	vpmovzxbw	xmm6, xmm6
	lea	r11, [r11+r14*4]
	vpmovsxwd	xmm8, xmm8
	vpsrldq	xmm15, xmm15, 8
	vcvtdq2ps	xmm8, xmm8
	vpmovzxbw	xmm15, xmm15
	vfmadd132ps	xmm10, xmm24, xmm17
	vpmovsxwd	xmm24, xmm5
	vcvtdq2ps	xmm24, xmm24
	vpsrldq	xmm5, xmm5, 8
	vfmadd132ps	xmm8, xmm9, xmm17
	vpmovsxwd	xmm9, xmm6
	vmulps	xmm24, xmm24, xmm16
	vpsrldq	xmm6, xmm6, 8
	vpmovsxwd	xmm5, xmm5
	vcvtdq2ps	xmm9, xmm9
	vcvtdq2ps	xmm5, xmm5
	vmulps	xmm5, xmm5, xmm16
	vpmovsxwd	xmm6, xmm6
	vcvtdq2ps	xmm6, xmm6
	vfmadd132ps	xmm9, xmm24, xmm17
	vpmovsxwd	xmm24, xmm7
	vcvtdq2ps	xmm24, xmm24
	vfmadd213ps	xmm24, xmm18, XMMWORD PTR [r11]
	vfmadd132ps	xmm6, xmm5, xmm17
	vmovdqu	xmm5, XMMWORD PTR 3[rax+rbx]
	vpsrldq	xmm7, xmm7, 8
	vpmovzxbw	xmm23, xmm5
	vpsrldq	xmm5, xmm5, 8
	vpmovsxwd	xmm7, xmm7
	vpmovsxwd	xmm22, xmm23
	vcvtdq2ps	xmm7, xmm7
	vfmadd213ps	xmm7, xmm18, XMMWORD PTR 16[r11]
	vpmovzxbw	xmm5, xmm5
	vcvtdq2ps	xmm22, xmm22
	vpsrldq	xmm23, xmm23, 8
	vfmadd132ps	xmm22, xmm24, xmm19
	vpmovsxwd	xmm24, xmm15
	vpmovsxwd	xmm23, xmm23
	vpsrldq	xmm15, xmm15, 8
	vcvtdq2ps	xmm24, xmm24
	vfmadd213ps	xmm24, xmm18, XMMWORD PTR 32[r11]
	vcvtdq2ps	xmm23, xmm23
	vpmovsxwd	xmm15, xmm15
	vcvtdq2ps	xmm15, xmm15
	vfmadd213ps	xmm20, xmm15, XMMWORD PTR 48[r11]
	vfmadd231ps	xmm7, xmm23, xmm19
	vpmovsxwd	xmm23, xmm5
	vpsrldq	xmm5, xmm5, 8
	vcvtdq2ps	xmm23, xmm23
	vpmovsxwd	xmm5, xmm5
	vaddps	xmm22, xmm22, xmm10
	vfmadd132ps	xmm23, xmm24, xmm19
	vcvtdq2ps	xmm5, xmm5
	vfmadd132ps	xmm5, xmm20, xmm19
	vaddps	xmm8, xmm8, xmm7
	vmovups	XMMWORD PTR [r11], xmm22
	vaddps	xmm9, xmm9, xmm23
	vmovups	XMMWORD PTR 16[r11], xmm8
	vaddps	xmm5, xmm5, xmm6
	vmovups	XMMWORD PTR 32[r11], xmm9
	vmovups	XMMWORD PTR 48[r11], xmm5
	mov	r11d, r8d
	and	r11d, -16
	test	r8b, 15
	je	.L47
	add	esi, r11d
.L52:
	sub	r8d, r11d
	lea	ebx, -1[r8]
	cmp	ebx, 6
	jbe	.L48
	mov	rbx, QWORD PTR 200[rsp]
	add	r9d, r11d
	vmovaps	xmm20, xmm17
	mov	r14, QWORD PTR 208[rsp]
	mov	r9d, r9d
	lea	r11, [rcx+rbx]
	mov	rbx, QWORD PTR 192[rsp]
	lea	r13, [rcx+r14]
	mov	r14, QWORD PTR 168[rsp]
	add	r11, r9
	add	r13, r9
	add	rbx, rcx
	vmovq	xmm5, QWORD PTR [rax+r11]
	add	rbx, r9
	lea	r9, [r14+r13*4]
	vmovq	xmm7, QWORD PTR 3[rax+rbx]
	vpmovzxbw	xmm9, xmm5
	vpsrlq	xmm5, xmm5, 32
	vmovq	xmm6, QWORD PTR [rax+rbx]
	vpmovzxbw	xmm5, xmm5
	vpmovzxbw	xmm10, xmm7
	vpsrlq	xmm7, xmm7, 32
	vpmovzxbw	xmm8, xmm6
	vpmovzxwd	xmm15, xmm10
	vpsrlq	xmm10, xmm10, 32
	vpmovzxbw	xmm7, xmm7
	vmovq	xmm15, xmm15
	vpsrlq	xmm6, xmm6, 32
	vpmovzxwd	xmm10, xmm10
	vcvtdq2ps	xmm23, xmm15
	vpmovzxwd	xmm15, xmm9
	vpsrlq	xmm9, xmm9, 32
	vmovq	xmm10, xmm10
	vpmovzxwd	xmm9, xmm9
	vcvtdq2ps	xmm10, xmm10
	vmovq	xmm22, xmm15
	vpmovzxbw	xmm6, xmm6
	vmovq	xmm9, xmm9
	vcvtdq2ps	xmm22, xmm22
	vcvtdq2ps	xmm9, xmm9
	vmulps	xmm9, xmm9, xmm16
	vmulps	xmm22, xmm22, xmm16
	vfmadd132ps	xmm10, xmm9, xmm17
	vpmovzxwd	xmm9, xmm7
	vpsrlq	xmm7, xmm7, 32
	vfmadd231ps	xmm22, xmm17, xmm23
	vmovq	xmm9, xmm9
	vpmovzxwd	xmm7, xmm7
	vcvtdq2ps	xmm15, xmm9
	vmovq	xmm7, xmm7
	vcvtdq2ps	xmm7, xmm7
	vmovaps	xmm24, xmm10
	vpmovzxwd	xmm10, xmm5
	vpsrlq	xmm5, xmm5, 32
	vmovq	xmm10, xmm10
	vpmovzxwd	xmm5, xmm5
	vcvtdq2ps	xmm10, xmm10
	vmulps	xmm10, xmm10, xmm16
	vmovq	xmm5, xmm5
	vcvtdq2ps	xmm5, xmm5
	vmulps	xmm5, xmm5, xmm16
	vfmadd132ps	xmm15, xmm10, xmm17
	vmovq	xmm10, QWORD PTR [r9]
	vfmadd132ps	xmm20, xmm5, xmm7
	vmovq	xmm5, QWORD PTR 3[rax+r11]
	vpmovzxbw	xmm7, xmm5
	vpsrlq	xmm5, xmm5, 32
	vpmovzxwd	xmm9, xmm7
	vpsrlq	xmm7, xmm7, 32
	vpmovzxbw	xmm5, xmm5
	vmovq	xmm9, xmm9
	vpmovzxwd	xmm7, xmm7
	vmovaps	xmm25, xmm15
	vcvtdq2ps	xmm23, xmm9
	vpmovzxwd	xmm9, xmm8
	vpsrlq	xmm8, xmm8, 32
	vmovq	xmm7, xmm7
	vmovq	xmm9, xmm9
	vpmovzxwd	xmm8, xmm8
	vcvtdq2ps	xmm7, xmm7
	vmovaps	xmm21, xmm20
	vcvtdq2ps	xmm9, xmm9
	vfmadd231ps	xmm10, xmm18, xmm9
	vmovq	xmm9, QWORD PTR 8[r9]
	vmovq	xmm8, xmm8
	vmovaps	xmm20, xmm18
	vcvtdq2ps	xmm8, xmm8
	vmovaps	xmm15, xmm19
	vfmadd132ps	xmm8, xmm9, xmm18
	vpmovzxwd	xmm9, xmm6
	vmovq	xmm9, xmm9
	vpsrlq	xmm6, xmm6, 32
	vcvtdq2ps	xmm9, xmm9
	vpmovzxwd	xmm6, xmm6
	vfmadd132ps	xmm23, xmm10, xmm19
	vmovq	xmm10, QWORD PTR 16[r9]
	vmovq	xmm6, xmm6
	vcvtdq2ps	xmm6, xmm6
	vfmadd132ps	xmm9, xmm10, xmm18
	vfmadd132ps	xmm7, xmm8, xmm19
	vpmovzxwd	xmm8, xmm5
	vmovq	xmm8, xmm8
	vpsrlq	xmm5, xmm5, 32
	vcvtdq2ps	xmm8, xmm8
	vpmovzxwd	xmm5, xmm5
	vmovq	xmm5, xmm5
	vcvtdq2ps	xmm5, xmm5
	vfmadd132ps	xmm8, xmm9, xmm19
	vmovq	xmm9, QWORD PTR 24[r9]
	vaddps	xmm7, xmm24, xmm7
	vfmadd132ps	xmm20, xmm9, xmm6
	vmovlps	QWORD PTR 8[r9], xmm7
	vfmadd132ps	xmm15, xmm20, xmm5
	vaddps	xmm5, xmm22, xmm23
	vmovlps	QWORD PTR [r9], xmm5
	vaddps	xmm5, xmm25, xmm8
	vaddps	xmm15, xmm15, xmm21
	vmovlps	QWORD PTR 16[r9], xmm5
	vmovlps	QWORD PTR 24[r9], xmm15
	mov	r9d, r8d
	and	r9d, -8
	and	r8d, 7
	je	.L47
	add	esi, r9d
.L48:
	mov	r14d, DWORD PTR 144[rsp]
	lea	ebx, 1[rsi]
	lea	r11d, -2[r14]
	cmp	r14d, esi
	jle	.L93
	mov	DWORD PTR 132[rsp], r11d
	cmp	r11d, ebx
	jle	.L93
	mov	r11, QWORD PTR 200[rsp]
	movsxd	r14, esi
	lea	r8, [r11+rcx]
	add	rcx, QWORD PTR 192[rsp]
	lea	r11, 3[rax+rdi]
	add	rcx, r14
	movzx	r9d, BYTE PTR [r11+r14]
	add	r8, r14
	movzx	r13d, BYTE PTR [rax+rcx]
	vcvtusi2ss	xmm7, xmm4, r9d
	mov	r9, QWORD PTR 136[rsp]
	vcvtusi2ss	xmm5, xmm4, r13d
	movzx	r13d, BYTE PTR [rax+r8]
	lea	r9, 3[rax+r9]
	vcvtusi2ss	xmm6, xmm4, r13d
	movzx	r14d, BYTE PTR [r9+r14]
	vcvtusi2ss	xmm8, xmm4, r14d
	lea	r14d, [rsi+r15]
	vfmadd213ss	xmm5, xmm14, DWORD PTR [rdx+r14*4]
	vmulss	xmm6, xmm6, xmm12
	vfmadd231ss	xmm5, xmm11, xmm8
	vfmadd231ss	xmm6, xmm13, xmm7
	vaddss	xmm5, xmm5, xmm6
	vmovss	DWORD PTR [rdx+r14*4], xmm5
	movsxd	r14, ebx
	add	ebx, r15d
	movzx	r13d, BYTE PTR [r11+r14]
	movzx	r14d, BYTE PTR [r9+r14]
	mov	ebx, ebx
	vcvtusi2ss	xmm10, xmm4, r14d
	movzx	r14d, BYTE PTR 1[rax+rcx]
	movzx	ecx, BYTE PTR 2[rax+rcx]
	vcvtusi2ss	xmm9, xmm4, r13d
	vcvtusi2ss	xmm5, xmm4, r14d
	movzx	r14d, BYTE PTR 1[rax+r8]
	vcvtusi2ss	xmm6, xmm4, r14d
	vfmadd213ss	xmm5, xmm14, DWORD PTR [rdx+rbx*4]
	vmulss	xmm6, xmm6, xmm12
	vfmadd231ss	xmm5, xmm11, xmm10
	vfmadd231ss	xmm6, xmm13, xmm9
	vaddss	xmm5, xmm5, xmm6
	vmovss	DWORD PTR [rdx+rbx*4], xmm5
	vcvtusi2ss	xmm5, xmm4, ecx
	movzx	ecx, BYTE PTR 2[rax+r8]
	lea	ebx, 2[rsi]
	movzx	r14d, BYTE PTR [r11+rbx]
	movzx	ebx, BYTE PTR [r9+rbx]
	lea	r8d, 4[rsi]
	vcvtusi2ss	xmm6, xmm4, ecx
	lea	ecx, 3[rsi]
	vcvtusi2ss	xmm20, xmm4, ebx
	lea	ebx, 2[rsi+r15]
	vfmadd213ss	xmm5, xmm14, DWORD PTR [rdx+rbx*4]
	vcvtusi2ss	xmm15, xmm4, r14d
	vmulss	xmm6, xmm6, xmm12
	vfmadd231ss	xmm5, xmm11, xmm20
	vfmadd231ss	xmm6, xmm13, xmm15
	vaddss	xmm5, xmm5, xmm6
	vmovss	DWORD PTR [rdx+rbx*4], xmm5
	cmp	r8d, DWORD PTR 132[rsp]
	jge	.L53
	vmulss	xmm8, xmm12, xmm8
	mov	ebx, ecx
	add	ecx, r15d
	movzx	r13d, BYTE PTR [r11+rbx]
	movzx	ebx, BYTE PTR [r9+rbx]
	vmulss	xmm10, xmm12, xmm10
	mov	ecx, ecx
	vmulss	xmm20, xmm12, xmm20
	vfmadd213ss	xmm7, xmm14, DWORD PTR [rdx+rcx*4]
	vcvtusi2ss	xmm5, xmm4, r13d
	vfmadd231ss	xmm8, xmm13, xmm5
	vcvtusi2ss	xmm5, xmm4, ebx
	movsxd	rbx, r8d
	vfmadd132ss	xmm5, xmm7, xmm11
	vaddss	xmm5, xmm5, xmm8
	vmovss	DWORD PTR [rdx+rcx*4], xmm5
	lea	ecx, [r8+r15]
	movzx	r8d, BYTE PTR [r11+rbx]
	vfmadd213ss	xmm9, xmm14, DWORD PTR [rdx+rcx*4]
	vcvtusi2ss	xmm5, xmm4, r8d
	movzx	r8d, BYTE PTR [r9+rbx]
	vfmadd231ss	xmm10, xmm13, xmm5
	vcvtusi2ss	xmm5, xmm4, r8d
	lea	r8d, 5[rsi]
	movzx	r11d, BYTE PTR [r11+r8]
	movzx	r8d, BYTE PTR [r9+r8]
	vfmadd132ss	xmm5, xmm9, xmm11
	vaddss	xmm5, xmm5, xmm10
	vmovss	DWORD PTR [rdx+rcx*4], xmm5
	vcvtusi2ss	xmm5, xmm4, r11d
	lea	ecx, 5[rsi+r15]
	vfmadd213ss	xmm15, xmm14, DWORD PTR [rdx+rcx*4]
	vfmadd231ss	xmm20, xmm13, xmm5
	vcvtusi2ss	xmm5, xmm4, r8d
	vfmadd132ss	xmm5, xmm15, xmm11
	vaddss	xmm5, xmm5, xmm20
	vmovss	DWORD PTR [rdx+rcx*4], xmm5
	lea	ecx, 6[rsi]
.L53:
	mov	esi, ecx
	mov	rbx, QWORD PTR 136[rsp]
	lea	r8d, [rcx+r15]
	mov	r14d, DWORD PTR 144[rsp]
	lea	r9, [rsi+rdi]
	movzx	r11d, BYTE PTR [rax+r9]
	movzx	r9d, BYTE PTR 3[rax+r9]
	add	rsi, rbx
	vcvtusi2ss	xmm5, xmm4, r11d
	vmovaps	xmm7, xmm5
	vcvtusi2ss	xmm5, xmm4, r9d
	movzx	r9d, BYTE PTR [rax+rsi]
	movzx	esi, BYTE PTR 3[rax+rsi]
	vfmadd213ss	xmm7, xmm14, DWORD PTR [rdx+r8*4]
	vcvtusi2ss	xmm6, xmm4, r9d
	vmulss	xmm6, xmm6, xmm12
	vfmadd231ss	xmm6, xmm13, xmm5
	vcvtusi2ss	xmm5, xmm4, esi
	vfmadd132ss	xmm5, xmm7, xmm11
	vaddss	xmm5, xmm5, xmm6
	vmovss	DWORD PTR [rdx+r8*4], xmm5
	lea	r8d, 1[rcx]
	cmp	r8d, r14d
	jge	.L47
	mov	esi, r8d
	add	r8d, r15d
	add	ecx, 2
	lea	r9, [rsi+rdi]
	add	rsi, rbx
	mov	r8d, r8d
	movzx	r11d, BYTE PTR [rax+r9]
	movzx	r9d, BYTE PTR 3[rax+r9]
	vcvtusi2ss	xmm5, xmm4, r11d
	vmovaps	xmm7, xmm5
	vcvtusi2ss	xmm5, xmm4, r9d
	movzx	r9d, BYTE PTR [rax+rsi]
	movzx	esi, BYTE PTR 3[rax+rsi]
	vfmadd213ss	xmm7, xmm14, DWORD PTR [rdx+r8*4]
	vcvtusi2ss	xmm6, xmm4, r9d
	vmulss	xmm6, xmm6, xmm12
	vfmadd231ss	xmm6, xmm13, xmm5
	vcvtusi2ss	xmm5, xmm4, esi
	vfmadd132ss	xmm5, xmm7, xmm11
	vaddss	xmm5, xmm5, xmm6
	vmovss	DWORD PTR [rdx+r8*4], xmm5
	cmp	r14d, ecx
	jle	.L47
	mov	esi, ecx
	add	ecx, r15d
	add	rdi, rsi
	mov	ecx, ecx
	add	rsi, rbx
	lea	rdx, [rdx+rcx*4]
	movzx	ecx, BYTE PTR [rax+rdi]
	vcvtusi2ss	xmm5, xmm4, ecx
	movzx	ecx, BYTE PTR 3[rax+rdi]
	vmovaps	xmm7, xmm5
	vcvtusi2ss	xmm5, xmm4, ecx
	movzx	ecx, BYTE PTR [rax+rsi]
	movzx	eax, BYTE PTR 3[rax+rsi]
	vfmadd213ss	xmm7, xmm14, DWORD PTR [rdx]
	vcvtusi2ss	xmm6, xmm4, ecx
	vmulss	xmm6, xmm6, xmm12
	vfmadd231ss	xmm6, xmm13, xmm5
	vcvtusi2ss	xmm5, xmm4, eax
	vfmadd132ss	xmm5, xmm7, xmm11
	vaddss	xmm5, xmm5, xmm6
	vmovss	DWORD PTR [rdx], xmm5
.L47:
	inc	DWORD PTR 160[rsp]
	mov	rdi, QWORD PTR 120[rsp]
	add	QWORD PTR 200[rsp], rdi
	add	QWORD PTR 192[rsp], rdi
	mov	eax, DWORD PTR 160[rsp]
	add	QWORD PTR 208[rsp], rdi
	cmp	eax, DWORD PTR 108[rsp]
	jne	.L54
	mov	r15, QWORD PTR 88[rsp]
.L45:
	add	QWORD PTR 112[rsp], 48
	mov	rax, QWORD PTR 112[rsp]
	cmp	QWORD PTR 72[rsp], rax
	jne	.L55
	mov	r14d, DWORD PTR 36[rsp]
	mov	rax, QWORD PTR 24[rsp]
	mov	rbx, QWORD PTR 16[rsp]
	test	r14d, r14d
	jle	.L166
	mov	ecx, DWORD PTR 96[rsp]
	test	ecx, ecx
	jle	.L166
	vzeroupper
.L43:
	lea	r10, [rax+r15]
	lea	eax, -1[r15]
	mov	r9, QWORD PTR 64[rsp]
	vmovss	xmm6, DWORD PTR .LC1[rip]
	lea	rsi, 3[rax+rax*2]
	mov	eax, DWORD PTR 96[rsp]
	vmovss	xmm2, DWORD PTR .LC3[rip]
	xor	edi, edi
	vmovss	xmm5, DWORD PTR .LC4[rip]
	vmovss	xmm8, DWORD PTR .LC5[rip]
	xor	r8d, r8d
	mov	r12, QWORD PTR 168[rsp]
	lea	r11, 0[0+rax*4]
	.p2align 4,,10
	.p2align 3
.L70:
	vmovss	xmm3, DWORD PTR .LC5[rip]
	vmovss	xmm7, DWORD PTR .LC4[rip]
	lea	rax, [rdi+rdi*2]
	mov	rdx, r9
	.p2align 4,,10
	.p2align 3
.L69:
	mov	ecx, DWORD PTR [rdx]
	test	ecx, ecx
	je	.L59
	vcvtsi2ss	xmm0, xmm4, ecx
	mov	rcx, QWORD PTR 16[rbx]
	xor	r13d, r13d
	add	rcx, rax
	vdivss	xmm0, xmm6, xmm0
	vmulss	xmm1, xmm0, DWORD PTR [r12+rax*4]
	vcomiss	xmm2, xmm1
	ja	.L68
	vaddss	xmm1, xmm1, xmm5
	vminss	xmm1, xmm1, xmm8
	vcvttss2si	r13d, xmm1
.L68:
	vmulss	xmm1, xmm0, DWORD PTR 4[r12+rax*4]
	mov	BYTE PTR [rcx], r13b
	xor	r13d, r13d
	vcomiss	xmm2, xmm1
	ja	.L67
	vaddss	xmm1, xmm1, xmm5
	vminss	xmm1, xmm1, xmm3
	vcvttss2si	r13d, xmm1
.L67:
	vmulss	xmm0, xmm0, DWORD PTR 8[r12+rax*4]
	mov	BYTE PTR 1[rcx], r13b
	xor	r13d, r13d
	vcomiss	xmm2, xmm0
	ja	.L66
	vaddss	xmm0, xmm0, xmm7
	vminss	xmm0, xmm0, xmm3
	vcvttss2si	r13d, xmm0
.L66:
	mov	BYTE PTR 2[rcx], r13b
.L59:
	add	rax, 3
	add	rdx, 4
	cmp	rsi, rax
	jne	.L69
	inc	r8d
	add	rsi, r10
	add	r9, r11
	add	rdi, r15
	cmp	r14d, r8d
	jne	.L70
.L57:
	cmp	QWORD PTR 168[rsp], 0
	je	.L29
.L79:
	mov	rsi, QWORD PTR 56[rsp]
	mov	rdi, QWORD PTR 168[rsp]
	call	"_ZdlPvm"@PLT
.L29:
	mov	rax, QWORD PTR 64[rsp]
	test	rax, rax
	je	.L71
	mov	rsi, QWORD PTR 40[rsp]
	mov	rdi, rax
	call	"_ZdlPvm"@PLT
.L71:
	mov	rax, QWORD PTR 80[rsp]
	test	rax, rax
	je	.L1
	mov	rsi, QWORD PTR 48[rsp]
	mov	rdi, rax
	call	"_ZdlPvm"@PLT
.L1:
	lea	rsp, -40[rbp]
	mov	rax, rbx
	pop	rbx
	pop	r12
	pop	r13
	pop	r14
	pop	r15
	pop	rbp
	.cfi_remember_state
	.cfi_def_cfa 7, 8
	ret
.L170:
	.cfi_restore_state
	mov	QWORD PTR 200[rsp], 0
	mov	r14d, eax
	xor	r13d, r13d
	vmovd	DWORD PTR 96[rsp], xmm0
	cmp	r8, rdi
	jne	.L5
	mov	QWORD PTR 80[rsp], 0
.L86:
	mov	QWORD PTR 40[rsp], 0
	mov	QWORD PTR 64[rsp], 0
	jmp	.L20
	.p2align 4,,10
	.p2align 3
.L173:
	mov	ebx, DWORD PTR 128[rsp]
	test	ebx, ebx
	jle	.L47
	mov	rcx, QWORD PTR 176[rsp]
	mov	rax, QWORD PTR 112[rsp]
	mov	DWORD PTR 144[rsp], ebx
	xor	r15d, r15d
	xor	esi, esi
	mov	QWORD PTR 136[rsp], rcx
	mov	rax, QWORD PTR 40[rax]
	xor	ecx, ecx
	jmp	.L48
.L92:
	xor	r11d, r11d
	jmp	.L52
.L93:
	mov	ecx, esi
	jmp	.L53
.L91:
	xor	r9d, r9d
	xor	esi, esi
	jmp	.L50
.L2:
	cmp	QWORD PTR 192[rsp], 0
	js	.L158
	mov	rdi, rdx
	mov	QWORD PTR 200[rsp], r8
	mov	r14, rdx
	vmovss	DWORD PTR 176[rsp], xmm4
.LEHB3:
	call	"_Znwm"@PLT
.LEHE3:
	xor	esi, esi
	mov	rdx, r14
	lea	r13, [rax+r14]
	mov	rdi, rax
	call	"memset"@PLT
	mov	r8, QWORD PTR 200[rsp]
	vmovss	xmm4, DWORD PTR 176[rsp]
	mov	QWORD PTR 24[rbx], r13
	mov	QWORD PTR 16[rbx], rax
	mov	rax, QWORD PTR 8[r12]
	mov	QWORD PTR 32[rbx], r13
	mov	QWORD PTR 208[rsp], rax
	sub	rax, r8
	mov	QWORD PTR 48[rsp], rax
	jne	.L4
	mov	QWORD PTR 200[rsp], 0
	xor	r13d, r13d
	jmp	.L8
.L13:
	mov	r13, QWORD PTR 200[rsp]
	movabs	rax, -6148914691236517205
	sub	r13, QWORD PTR 80[rsp]
	mov	rdx, r13
	sar	rdx, 4
	imul	rdx, rax
	movabs	rax, 192153584101141162
	cmp	rdx, rax
	je	.L159
	test	rdx, rdx
	mov	eax, 1
	mov	DWORD PTR 72[rsp], esi
	cmovne	rax, rdx
	mov	QWORD PTR 88[rsp], r8
	mov	DWORD PTR 100[rsp], ecx
	add	rax, rdx
	movabs	rdx, 192153584101141162
	mov	DWORD PTR 104[rsp], r9d
	cmp	rax, rdx
	mov	DWORD PTR 132[rsp], r10d
	cmova	rax, rdx
	mov	DWORD PTR 136[rsp], r11d
	vmovss	DWORD PTR 64[rsp], xmm4
	lea	rax, [rax+rax*2]
	vmovss	DWORD PTR 108[rsp], xmm5
	sal	rax, 4
	vmovss	DWORD PTR 128[rsp], xmm0
	mov	rdi, rax
	mov	QWORD PTR 152[rsp], rax
	vmovss	DWORD PTR 112[rsp], xmm1
	vmovss	DWORD PTR 120[rsp], xmm2
.LEHB4:
	call	"_Znwm"@PLT
.LEHE4:
	vmovss	xmm0, DWORD PTR 128[rsp]
	vmovss	xmm2, DWORD PTR 120[rsp]
	test	r13, r13
	mov	QWORD PTR 160[rsp], rax
	mov	r11d, DWORD PTR 136[rsp]
	mov	r10d, DWORD PTR 132[rsp]
	mov	DWORD PTR 28[rax+r13], r12d
	mov	rdi, rax
	vinsertps	xmm0, xmm0, DWORD PTR 108[rsp], 0x10
	vinsertps	xmm2, xmm2, DWORD PTR 112[rsp], 0x10
	mov	r9d, DWORD PTR 104[rsp]
	mov	ecx, DWORD PTR 100[rsp]
	mov	DWORD PTR [rax+r13], r11d
	mov	esi, DWORD PTR 72[rsp]
	mov	rdx, QWORD PTR 176[rsp]
	vmovlhps	xmm2, xmm2, xmm0
	mov	DWORD PTR 4[rax+r13], r10d
	mov	r8, QWORD PTR 88[rsp]
	vmovss	xmm4, DWORD PTR 64[rsp]
	mov	DWORD PTR 24[rax+r13], r9d
	mov	DWORD PTR 32[rax+r13], ecx
	mov	DWORD PTR 36[rax+r13], esi
	mov	QWORD PTR 40[rax+r13], rdx
	vmovups	XMMWORD PTR 8[rax+r13], xmm2
	je	.L17
	mov	rsi, QWORD PTR 80[rsp]
	mov	rdx, r13
	mov	QWORD PTR 176[rsp], r8
	vmovss	DWORD PTR 136[rsp], xmm4
	call	"memcpy"@PLT
	vmovss	xmm4, DWORD PTR 136[rsp]
	mov	r8, QWORD PTR 176[rsp]
.L17:
	mov	rax, QWORD PTR 160[rsp]
	lea	r13, 48[rax+r13]
	mov	rax, QWORD PTR 80[rsp]
	test	rax, rax
	je	.L18
	mov	rsi, QWORD PTR 200[rsp]
	mov	rdi, rax
	mov	QWORD PTR 176[rsp], r8
	vmovss	DWORD PTR 136[rsp], xmm4
	sub	rsi, rax
	call	"_ZdlPvm"@PLT
	vmovss	xmm4, DWORD PTR 136[rsp]
	mov	r8, QWORD PTR 176[rsp]
.L18:
	mov	rdi, QWORD PTR 160[rsp]
	mov	rax, QWORD PTR 152[rsp]
	add	rax, rdi
	mov	QWORD PTR 80[rsp], rdi
	mov	QWORD PTR 200[rsp], rax
	jmp	.L12
.L172:
	mov	QWORD PTR 168[rsp], 0
	cmp	QWORD PTR 80[rsp], r13
	jne	.L42
	test	r14d, r14d
	jg	.L31
	jmp	.L29
	.p2align 4,,10
	.p2align 3
.L171:
	xor	edi, edi
	cmp	QWORD PTR 80[rsp], r13
	jne	.L25
	test	r14d, r14d
	jle	.L174
	mov	r10d, DWORD PTR 96[rsp]
	test	r10d, r10d
	jg	.L30
	cmp	rax, QWORD PTR 192[rsp]
	jb	.L27
	cmp	QWORD PTR 56[rsp], 0
	jne	.L28
.L31:
	mov	esi, DWORD PTR 96[rsp]
	mov	QWORD PTR 168[rsp], 0
	lea	rax, [r15+r15]
	mov	QWORD PTR 56[rsp], 0
	test	esi, esi
	jg	.L43
	jmp	.L29
	.p2align 4,,10
	.p2align 3
.L166:
	vzeroupper
	jmp	.L57
.L44:
	test	r14d, r14d
	jle	.L79
	mov	edx, DWORD PTR 96[rsp]
	lea	rax, [r15+r15]
	test	edx, edx
	jg	.L43
	jmp	.L79
	.p2align 4,,10
	.p2align 3
.L32:
	test	r14d, r14d
	jle	.L36
	mov	eax, DWORD PTR 96[rsp]
	test	eax, eax
	jg	.L30
	jmp	.L36
.L83:
	mov	QWORD PTR 80[rsp], r13
	jmp	.L9
.L174:
	cmp	rax, QWORD PTR 192[rsp]
	jb	.L27
	cmp	QWORD PTR 56[rsp], 0
	jne	.L28
	jmp	.L29
.L98:
	mov	r12, rax
	vzeroupper
	jmp	.L16
.L154:
	jmp	.L155
.L156:
	jmp	.L157
.L152:
	jmp	.L153
	.section	.gcc_except_table,"a",@progbits
.LLSDA11708:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSE11708-.LLSDACSB11708
.LLSDACSB11708:
	.uleb128 .LEHB0-.LFB11708
	.uleb128 .LEHE0-.LEHB0
	.uleb128 .L152-.LFB11708
	.uleb128 0
	.uleb128 .LEHB1-.LFB11708
	.uleb128 .LEHE1-.LEHB1
	.uleb128 .L98-.LFB11708
	.uleb128 0
	.uleb128 .LEHB2-.LFB11708
	.uleb128 .LEHE2-.LEHB2
	.uleb128 .L154-.LFB11708
	.uleb128 0
	.uleb128 .LEHB3-.LFB11708
	.uleb128 .LEHE3-.LEHB3
	.uleb128 .L152-.LFB11708
	.uleb128 0
	.uleb128 .LEHB4-.LFB11708
	.uleb128 .LEHE4-.LEHB4
	.uleb128 .L156-.LFB11708
	.uleb128 0
.LLSDACSE11708:
	.text
	.cfi_endproc
	.section	.text.unlikely
	.cfi_startproc
	.cfi_personality 0x9b,"DW.ref.__gxx_personality_v0"
	.cfi_lsda 0x1b,.LLSDAC11708
	.type	"_Z21refocus_shift_and_sumRSt6vectorI16SubApertureImageSaIS0_EEf.cold", @function
"_Z21refocus_shift_and_sumRSt6vectorI16SubApertureImageSaIS0_EEf.cold":
.LFSB11708:
.L160:
	.cfi_def_cfa 6, 16
	.cfi_offset 3, -56
	.cfi_offset 6, -16
	.cfi_offset 12, -48
	.cfi_offset 13, -40
	.cfi_offset 14, -32
	.cfi_offset 15, -24
	lea	rdi, .LC0[rip]
.LEHB5:
	call	"_ZSt20__throw_length_errorPKc"@PLT
.LEHE5:
.L27:
	lea	rdi, .LC0[rip]
.LEHB6:
	call	"_ZSt20__throw_length_errorPKc"@PLT
.LEHE6:
.L159:
	lea	rdi, .LC2[rip]
.LEHB7:
	call	"_ZSt20__throw_length_errorPKc"@PLT
.LEHE7:
.L158:
	lea	rdi, .LC0[rip]
.LEHB8:
	call	"_ZSt20__throw_length_errorPKc"@PLT
.LEHE8:
.L161:
	lea	rdi, .LC0[rip]
.LEHB9:
	call	"_ZSt20__throw_length_errorPKc"@PLT
.LEHE9:
.L95:
	mov	r12, rax
	vzeroupper
.L16:
	cmp	QWORD PTR 80[rsp], 0
	je	.L76
	mov	rsi, QWORD PTR 200[rsp]
	mov	rdi, QWORD PTR 80[rsp]
	sub	rsi, rdi
	call	"_ZdlPvm"@PLT
.L76:
	mov	rdi, QWORD PTR 16[rbx]
	test	rdi, rdi
	je	.L77
	mov	rsi, QWORD PTR 32[rbx]
	sub	rsi, rdi
	call	"_ZdlPvm"@PLT
.L77:
	mov	rdi, r12
.LEHB10:
	call	"_Unwind_Resume"@PLT
.LEHE10:
.L96:
.L155:
	cmp	QWORD PTR 64[rsp], 0
	mov	r12, rax
	je	.L167
	mov	rsi, QWORD PTR 40[rsp]
	mov	rdi, QWORD PTR 64[rsp]
	vzeroupper
	call	"_ZdlPvm"@PLT
	jmp	.L16
.L97:
.L157:
	mov	r12, rax
	vzeroupper
	jmp	.L16
.L94:
.L153:
	mov	r12, rax
	vzeroupper
	jmp	.L76
.L167:
	vzeroupper
	jmp	.L16
	.cfi_endproc
.LFE11708:
	.section	.gcc_except_table
.LLSDAC11708:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSEC11708-.LLSDACSBC11708
.LLSDACSBC11708:
	.uleb128 .LEHB5-.LCOLDB7
	.uleb128 .LEHE5-.LEHB5
	.uleb128 .L95-.LCOLDB7
	.uleb128 0
	.uleb128 .LEHB6-.LCOLDB7
	.uleb128 .LEHE6-.LEHB6
	.uleb128 .L96-.LCOLDB7
	.uleb128 0
	.uleb128 .LEHB7-.LCOLDB7
	.uleb128 .LEHE7-.LEHB7
	.uleb128 .L97-.LCOLDB7
	.uleb128 0
	.uleb128 .LEHB8-.LCOLDB7
	.uleb128 .LEHE8-.LEHB8
	.uleb128 .L94-.LCOLDB7
	.uleb128 0
	.uleb128 .LEHB9-.LCOLDB7
	.uleb128 .LEHE9-.LEHB9
	.uleb128 .L96-.LCOLDB7
	.uleb128 0
	.uleb128 .LEHB10-.LCOLDB7
	.uleb128 .LEHE10-.LEHB10
	.uleb128 0
	.uleb128 0
.LLSDACSEC11708:
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
