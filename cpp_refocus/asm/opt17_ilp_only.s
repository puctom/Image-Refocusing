	.file	"opt17_ilp_only.cpp"
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
.LCOLDB8:
	.text
.LHOTB8:
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
	vpxor	xmm1, xmm1, xmm1
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	push	r15
	push	r14
	push	r13
	.cfi_offset 15, -24
	.cfi_offset 14, -32
	.cfi_offset 13, -40
	mov	r13, rsi
	push	r12
	push	rbx
	and	rsp, -32
	sub	rsp, 288
	.cfi_offset 12, -48
	.cfi_offset 3, -56
	mov	rbx, QWORD PTR [rsi]
	vmovss	DWORD PTR 224[rsp], xmm0
	mov	QWORD PTR 64[rsp], rdi
	vmovdqu	xmm0, XMMWORD PTR [rbx]
	mov	QWORD PTR 32[rdi], 0
	vmovdqu	XMMWORD PTR 16[rdi], xmm1
	vmovq	rax, xmm0
	vpextrq	rdx, xmm0, 1
	vmovq	QWORD PTR 56[rsp], xmm0
	mov	r12, rax
	mov	QWORD PTR 256[rsp], rdx
	imul	r12, rdx
	vmovdqu	XMMWORD PTR [rdi], xmm0
	test	r12, r12
	jne	.L2
	mov	rcx, QWORD PTR 8[rsi]
	mov	rdi, rcx
	mov	QWORD PTR 280[rsp], rcx
	sub	rdi, rbx
	mov	QWORD PTR 40[rsp], rdi
	je	.L167
.L4:
	mov	r15, QWORD PTR 40[rsp]
	mov	rdi, r15
.LEHB0:
	call	"_Znwm"@PLT
.LEHE0:
	mov	QWORD PTR 112[rsp], rax
	lea	r13, [rax+r15]
.L8:
	mov	eax, DWORD PTR 56[rsp]
	mov	r14d, DWORD PTR 256[rsp]
	mov	DWORD PTR 84[rsp], eax
	cmp	QWORD PTR 280[rsp], rbx
	je	.L80
.L5:
	mov	r15, QWORD PTR 112[rsp]
.L17:
	vmovss	xmm3, DWORD PTR 224[rsp]
	xor	r8d, r8d
	vmulss	xmm4, xmm3, DWORD PTR 40[rbx]
	vmulss	xmm2, xmm3, DWORD PTR 44[rbx]
	vrndscaless	xmm0, xmm4, xmm4, 9
	vcvttss2si	r10d, xmm0
	vrndscaless	xmm1, xmm2, xmm2, 9
	vcvttss2si	esi, xmm1
	mov	eax, r10d
	neg	eax
	test	r10d, r10d
	cmovs	r8d, eax
	mov	eax, DWORD PTR 84[rsp]
	mov	ecx, eax
	sub	ecx, r10d
	dec	ecx
	cmp	ecx, eax
	cmovg	ecx, eax
	mov	eax, esi
	xor	r9d, r9d
	neg	eax
	test	esi, esi
	cmovs	r9d, eax
	mov	eax, r14d
	sub	eax, esi
	dec	eax
	cmp	eax, r14d
	cmovg	eax, r14d
	mov	r11d, eax
	cmp	r8d, ecx
	jge	.L12
	cmp	r9d, eax
	jge	.L12
	vsubss	xmm5, xmm2, xmm1
	vsubss	xmm3, xmm4, xmm0
	mov	rdi, QWORD PTR 16[rbx]
	mov	rax, QWORD PTR 112[rsp]
	vaddss	xmm0, xmm0, DWORD PTR .LC1[rip]
	vaddss	xmm1, xmm1, DWORD PTR .LC1[rip]
	mov	QWORD PTR 240[rsp], rdi
	vsubss	xmm0, xmm0, xmm4
	vsubss	xmm1, xmm1, xmm2
	vmulss	xmm2, xmm0, xmm1
	vmulss	xmm1, xmm1, xmm3
	vmulss	xmm0, xmm0, xmm5
	vmulss	xmm3, xmm3, xmm5
	cmp	rax, r13
	je	.L13
	vunpcklps	xmm0, xmm0, xmm3
	vunpcklps	xmm2, xmm2, xmm1
	mov	DWORD PTR [rax], r10d
	add	rax, 48
	vmovlhps	xmm2, xmm2, xmm0
	mov	DWORD PTR -44[rax], esi
	vmovups	XMMWORD PTR -40[rax], xmm2
	mov	DWORD PTR -24[rax], r8d
	mov	DWORD PTR -20[rax], ecx
	mov	DWORD PTR -16[rax], r9d
	mov	DWORD PTR -12[rax], r11d
	mov	QWORD PTR -8[rax], rdi
	mov	QWORD PTR 112[rsp], rax
.L12:
	add	rbx, 48
	cmp	rbx, QWORD PTR 280[rsp]
	jne	.L17
	mov	rax, r13
	sub	rax, r15
	mov	QWORD PTR 40[rsp], rax
	mov	rax, QWORD PTR 112[rsp]
	mov	QWORD PTR 112[rsp], r15
	mov	QWORD PTR 152[rsp], rax
.L9:
	mov	rax, r12
	shr	rax, 61
	jne	.L158
	test	r12, r12
	je	.L83
	sal	r12, 2
	mov	rdi, r12
.LEHB1:
	call	"_Znwm"@PLT
.LEHE1:
	mov	rdx, r12
	xor	esi, esi
	mov	rdi, rax
	mov	QWORD PTR 72[rsp], rax
	call	"memset"@PLT
.L18:
	mov	rax, QWORD PTR 56[rsp]
	mov	rbx, QWORD PTR 256[rsp]
	lea	r15, 1[rax]
	inc	rbx
	imul	rbx, r15
	mov	rax, rbx
	shr	rax, 61
	jne	.L159
	test	rbx, rbx
	je	.L168
	sal	rbx, 2
	mov	rdi, rbx
.LEHB2:
	call	"_Znwm"@PLT
	mov	rdi, rax
	mov	rdx, rbx
	xor	esi, esi
	call	"memset"@PLT
	mov	rcx, QWORD PTR 152[rsp]
	mov	rdi, rax
	cmp	QWORD PTR 112[rsp], rcx
	je	.L27
.L24:
	mov	rax, QWORD PTR 112[rsp]
.L28:
	movsxd	rdx, DWORD PTR 32[rax]
	movsxd	rsi, DWORD PTR 24[rax]
	add	rax, 48
	movsxd	r8, DWORD PTR -12[rax]
	imul	rdx, r15
	imul	r8, r15
	lea	rcx, [rdx+rsi]
	inc	DWORD PTR [rdi+rcx*4]
	movsxd	rcx, DWORD PTR -20[rax]
	add	rdx, rcx
	dec	DWORD PTR [rdi+rdx*4]
	lea	rdx, [rsi+r8]
	dec	DWORD PTR [rdi+rdx*4]
	lea	rdx, [rcx+r8]
	inc	DWORD PTR [rdi+rdx*4]
	cmp	rax, QWORD PTR 152[rsp]
	jne	.L28
	test	r14d, r14d
	jle	.L34
	mov	ecx, DWORD PTR 84[rsp]
	test	ecx, ecx
	jle	.L34
.L26:
	mov	rax, QWORD PTR 56[rsp]
	xor	ecx, ecx
	lea	edx, -1[rax]
	xor	eax, eax
	lea	rsi, 1[rdx]
.L30:
	mov	rdx, QWORD PTR 72[rsp]
	add	ecx, DWORD PTR [rdi+rax*4]
	mov	DWORD PTR [rdx+rax*4], ecx
	inc	rax
	cmp	rsi, rax
	jne	.L30
	cmp	r14d, 1
	jle	.L31
	mov	eax, DWORD PTR 84[rsp]
	sal	r15, 2
	xor	r11d, r11d
	mov	r10d, 1
	lea	rdx, [rdi+r15]
	lea	r8, 0[0+rax*4]
	mov	rax, QWORD PTR 72[rsp]
	lea	r9, [rax+r8]
.L33:
	mov	rcx, QWORD PTR 72[rsp]
	movsxd	rax, r11d
	add	r11d, DWORD PTR 56[rsp]
	mov	QWORD PTR 272[rsp], rdi
	lea	rax, [rcx+rax*4]
	xor	ecx, ecx
	mov	QWORD PTR 280[rsp], rax
	xor	eax, eax
.L32:
	mov	rdi, QWORD PTR 280[rsp]
	add	ecx, DWORD PTR [rdx+rax*4]
	mov	edi, DWORD PTR [rdi+rax*4]
	add	edi, ecx
	mov	DWORD PTR [r9+rax*4], edi
	inc	rax
	cmp	rax, rsi
	jne	.L32
	inc	r10d
	mov	rdi, QWORD PTR 272[rsp]
	add	rdx, r15
	add	r9, r8
	cmp	r14d, r10d
	jg	.L33
.L34:
	test	rdi, rdi
	je	.L25
.L31:
	mov	rsi, rbx
	call	"_ZdlPvm"@PLT
.L25:
	mov	edi, 195072
	call	"_Znwm"@PLT
.LEHE2:
	mov	DWORD PTR [rax], 0x00000000
	xor	esi, esi
	lea	rdi, 4[rax]
	mov	edx, 195068
	mov	QWORD PTR 248[rsp], rax
	call	"memset"@PLT
	test	r14d, r14d
	jle	.L35
	mov	edx, DWORD PTR 84[rsp]
	test	edx, edx
	jle	.L35
	mov	rax, QWORD PTR 56[rsp]
	vmovss	xmm20, DWORD PTR .LC1[rip]
	mov	QWORD PTR 88[rsp], 0
	vxorps	xmm4, xmm4, xmm4
	vmovss	xmm13, DWORD PTR .LC4[rip]
	mov	QWORD PTR 16[rsp], r12
	lea	rcx, [rax+rax*2]
	lea	r12, 0[0+rax*8]
	mov	QWORD PTR 192[rsp], rcx
	xor	ecx, ecx
.L68:
	mov	rdi, QWORD PTR 88[rsp]
	mov	r10, QWORD PTR 56[rsp]
	mov	DWORD PTR 24[rsp], r14d
	mov	QWORD PTR 32[rsp], rcx
	lea	eax, 8[rdi]
	mov	DWORD PTR 80[rsp], edi
	cmp	eax, r14d
	mov	DWORD PTR 48[rsp], edi
	cmovg	eax, r14d
	mov	QWORD PTR 8[rsp], r12
	xor	r12d, r12d
	mov	r15d, eax
	sub	eax, edi
	mov	DWORD PTR 28[rsp], eax
.L67:
	mov	ecx, DWORD PTR 84[rsp]
	lea	eax, 2032[r12]
	mov	r13d, r12d
	cmp	eax, ecx
	cmovg	eax, ecx
	mov	ecx, eax
	mov	r14d, eax
	mov	eax, DWORD PTR 28[rsp]
	sub	ecx, r12d
	imul	eax, ecx
	movsxd	r11, ecx
	lea	edx, [rax+rax*2]
	movsxd	rdx, edx
	sal	rdx, 2
	je	.L36
	mov	QWORD PTR 240[rsp], r10
	mov	rdi, QWORD PTR 248[rsp]
	xor	esi, esi
	mov	DWORD PTR 272[rsp], ecx
	mov	QWORD PTR 280[rsp], r11
	vmovaps	XMMWORD PTR 256[rsp], xmm4
	vzeroupper
	call	"memset"@PLT
	mov	r10, QWORD PTR 240[rsp]
	vmovaps	xmm4, XMMWORD PTR 256[rsp]
	vmovss	xmm13, DWORD PTR .LC4[rip]
	vmovss	xmm20, DWORD PTR .LC1[rip]
	mov	ecx, DWORD PTR 272[rsp]
	mov	r11, QWORD PTR 280[rsp]
.L36:
	mov	rax, QWORD PTR 112[rsp]
	cmp	rax, QWORD PTR 152[rsp]
	je	.L37
	mov	rdx, rax
	lea	rax, [r11+r11*2]
	mov	QWORD PTR 104[rsp], r11
	mov	r9d, DWORD PTR 80[rsp]
	mov	QWORD PTR 208[rsp], rax
	sal	rax, 2
	mov	QWORD PTR 200[rsp], rax
	mov	DWORD PTR 52[rsp], ecx
	mov	DWORD PTR 148[rsp], r14d
	mov	QWORD PTR 96[rsp], r12
	.p2align 4,,10
	.p2align 3
.L53:
	mov	eax, DWORD PTR 32[rdx]
	mov	ecx, DWORD PTR 28[rdx]
	mov	esi, DWORD PTR 148[rsp]
	cmp	r9d, eax
	mov	edi, eax
	mov	eax, DWORD PTR 36[rdx]
	cmovge	edi, r9d
	cmp	r15d, eax
	cmovle	eax, r15d
	mov	DWORD PTR 280[rsp], edi
	mov	DWORD PTR 216[rsp], eax
	mov	ebx, eax
	mov	eax, DWORD PTR 24[rdx]
	cmp	r13d, eax
	cmovge	rax, r13
	cmp	esi, ecx
	cmovle	ecx, esi
	cmp	ecx, eax
	jle	.L38
	cmp	ebx, edi
	jle	.L38
	mov	r8d, edi
	sub	ecx, eax
	mov	esi, DWORD PTR [rdx]
	mov	r14, QWORD PTR 248[rsp]
	mov	rdi, r8
	lea	ebx, [rcx+rcx*2]
	mov	ecx, eax
	vmovss	xmm19, DWORD PTR 8[rdx]
	sub	rdi, QWORD PTR 88[rsp]
	sub	ecx, r13d
	add	esi, eax
	sub	rax, QWORD PTR 96[rsp]
	imul	rdi, QWORD PTR 104[rsp]
	movsxd	rcx, ecx
	mov	DWORD PTR 272[rsp], ebx
	movsxd	rsi, esi
	vmovss	xmm18, DWORD PTR 12[rdx]
	vmovss	xmm17, DWORD PTR 16[rdx]
	mov	QWORD PTR 136[rsp], rdx
	vbroadcastss	ymm10, xmm19
	vmovss	xmm16, DWORD PTR 20[rdx]
	mov	r12, QWORD PTR 40[rdx]
	mov	QWORD PTR 128[rsp], r10
	vmovaps	ymm3, ymm10
	add	rcx, rdi
	add	rax, rdi
	mov	DWORD PTR 124[rsp], r13d
	vbroadcastss	ymm11, xmm18
	lea	rcx, [rcx+rcx*2]
	lea	rax, [rax+rax*2]
	mov	DWORD PTR 120[rsp], r9d
	vbroadcastss	ymm12, xmm17
	lea	r11, [r14+rcx*4]
	movsxd	rcx, DWORD PTR 4[rdx]
	mov	QWORD PTR 232[rsp], rax
	lea	eax, -16[rbx]
	mov	edi, eax
	shr	eax, 4
	vbroadcastss	ymm9, xmm16
	mov	DWORD PTR 144[rsp], r15d
	add	r8, rcx
	and	edi, -16
	inc	eax
	mov	r15, r11
	imul	r8, r10
	lea	ebx, 23[rdi]
	mov	DWORD PTR 184[rsp], edi
	add	edi, 16
	mov	QWORD PTR 168[rsp], rdi
	sal	rax, 6
	sal	rdi, 2
	vmovaps	ymm2, ymm11
	mov	DWORD PTR 188[rsp], ebx
	vmovaps	ymm1, ymm12
	vmovaps	ymm0, ymm9
	lea	rcx, [rsi+r8]
	mov	QWORD PTR 160[rsp], rdi
	add	rsi, r10
	mov	QWORD PTR 176[rsp], rax
	add	rsi, r8
	lea	rcx, [rcx+rcx*2]
	lea	r14, [rsi+rsi*2]
	.p2align 4,,10
	.p2align 3
.L52:
	cmp	DWORD PTR 272[rsp], 15
	jle	.L39
	mov	rax, QWORD PTR 176[rsp]
	lea	rdx, [r12+r14]
	lea	rdi, [rax+r15]
	mov	rax, r15
	.p2align 4,,10
	.p2align 3
.L40:
	mov	rsi, rdx
	vpmovzxbd	ymm8, QWORD PTR [rdx]
	vpmovzxbd	ymm7, QWORD PTR 8[rdx]
	add	rax, 64
	sub	rsi, r14
	vpmovzxbd	ymm6, QWORD PTR 3[rdx]
	vpmovzxbd	ymm5, QWORD PTR 11[rdx]
	add	rdx, 16
	vpmovzxbd	ymm22, QWORD PTR [rsi+rcx]
	vpmovzxbd	ymm21, QWORD PTR 8[rsi+rcx]
	vcvtdq2ps	ymm8, ymm8
	vcvtdq2ps	ymm7, ymm7
	vpmovzxbd	ymm15, QWORD PTR 3[rsi+rcx]
	vpmovzxbd	ymm14, QWORD PTR 11[rsi+rcx]
	vcvtdq2ps	ymm6, ymm6
	vcvtdq2ps	ymm5, ymm5
	vcvtdq2ps	ymm22, ymm22
	vcvtdq2ps	ymm21, ymm21
	vfmadd213ps	ymm22, ymm3, YMMWORD PTR -64[rax]
	vfmadd213ps	ymm21, ymm3, YMMWORD PTR -32[rax]
	vcvtdq2ps	ymm15, ymm15
	vcvtdq2ps	ymm14, ymm14
	vfmadd132ps	ymm15, ymm22, ymm2
	vfmadd132ps	ymm14, ymm21, ymm2
	vfmadd132ps	ymm8, ymm15, ymm1
	vfmadd132ps	ymm7, ymm14, ymm1
	vfmadd132ps	ymm6, ymm8, ymm0
	vfmadd132ps	ymm5, ymm7, ymm0
	vmovups	YMMWORD PTR -64[rax], ymm6
	vmovups	YMMWORD PTR -32[rax], ymm5
	cmp	rdi, rax
	jne	.L40
	mov	edi, DWORD PTR 184[rsp]
	mov	ebx, DWORD PTR 272[rsp]
	lea	eax, 16[rdi]
	mov	DWORD PTR 256[rsp], eax
	cmp	DWORD PTR 188[rsp], ebx
	jge	.L44
	mov	rax, QWORD PTR 168[rsp]
	add	edi, 24
	mov	DWORD PTR 256[rsp], edi
	lea	rsi, [rcx+rax]
	lea	rdx, [rax+r14]
	mov	rax, QWORD PTR 160[rsp]
	add	rax, r15
.L42:
	vpmovzxbd	ymm8, QWORD PTR [r12+rsi]
	vpmovzxbd	ymm7, QWORD PTR 3[r12+rsi]
	vpmovzxbd	ymm6, QWORD PTR [r12+rdx]
	vpmovzxbd	ymm5, QWORD PTR 3[r12+rdx]
	vcvtdq2ps	ymm8, ymm8
	vfmadd213ps	ymm8, ymm3, YMMWORD PTR [rax]
	vcvtdq2ps	ymm7, ymm7
	vcvtdq2ps	ymm6, ymm6
	vcvtdq2ps	ymm5, ymm5
	vfmadd132ps	ymm7, ymm8, ymm2
	vfmadd132ps	ymm6, ymm7, ymm1
	vfmadd132ps	ymm5, ymm6, ymm0
	vmovups	YMMWORD PTR [rax], ymm5
.L44:
	mov	edi, DWORD PTR 272[rsp]
	mov	eax, DWORD PTR 256[rsp]
	sub	edi, eax
	test	edi, edi
	jle	.L45
	mov	r10d, eax
	lea	r8, [rcx+r10]
	lea	r9, [r10+r14]
.L43:
	mov	rax, QWORD PTR 232[rsp]
	mov	rsi, QWORD PTR 248[rsp]
	mov	r11d, edi
	lea	r13, 3[r11+r9]
	lea	rbx, [rax+r10]
	add	r13, r12
	lea	rax, [rsi+rbx*4]
	lea	rdx, [rbx+r11]
	mov	QWORD PTR 240[rsp], rbx
	cmp	rax, r13
	lea	rbx, [rsi+rdx*4]
	lea	rsi, [r12+r8]
	setnb	BYTE PTR 220[rsp]
	lea	rdx, [r12+r9]
	cmp	rdx, rbx
	mov	QWORD PTR 224[rsp], rsi
	movzx	esi, BYTE PTR 220[rsp]
	setnb	r13b
	or	sil, r13b
	je	.L46
	lea	r11, 3[r11+r8]
	mov	rsi, QWORD PTR 224[rsp]
	add	r11, r12
	cmp	rax, r11
	setnb	r11b
	cmp	rsi, rbx
	setnb	bl
	or	r11b, bl
	je	.L46
	lea	r10d, -1[rdi]
	cmp	r10d, 30
	jbe	.L88
	mov	r10d, edi
	lea	rbx, 3[r12+r9]
	lea	r11, 3[r12+r8]
	shr	r10d, 5
	mov	r13d, r10d
	mov	DWORD PTR 224[rsp], r10d
	xor	r10d, r10d
	sal	r13, 5
	.p2align 4,,10
	.p2align 3
.L48:
	vmovdqu	ymm5, YMMWORD PTR [rdx+r10]
	vmovdqu	ymm6, YMMWORD PTR [r11+r10]
	sub	rax, -128
	vmovdqu	ymm7, YMMWORD PTR [rsi+r10]
	vpmovzxbw	ymm8, xmm5
	vpmovzxbw	ymm14, xmm6
	vextracti32x4	xmm5, ymm5, 0x1
	vpmovsxwd	ymm21, xmm8
	vpmovsxwd	ymm15, xmm14
	vpmovzxbw	ymm5, xmm5
	vcvtdq2ps	ymm21, ymm21
	vmulps	ymm21, ymm21, ymm1
	vcvtdq2ps	ymm15, ymm15
	vextracti32x4	xmm6, ymm6, 0x1
	vpmovzxbw	ymm22, xmm7
	vpmovzxbw	ymm6, xmm6
	vpmovsxwd	ymm24, xmm22
	vextracti32x4	xmm7, ymm7, 0x1
	vcvtdq2ps	ymm24, ymm24
	vfmadd213ps	ymm24, ymm3, YMMWORD PTR -128[rax]
	vextracti32x4	xmm22, ymm22, 0x1
	vpmovzxbw	ymm7, xmm7
	vpmovsxwd	ymm22, xmm22
	vcvtdq2ps	ymm22, ymm22
	vfmadd213ps	ymm22, ymm3, YMMWORD PTR -96[rax]
	vfmadd132ps	ymm15, ymm21, ymm2
	vextracti32x4	xmm21, ymm14, 0x1
	vextracti32x4	xmm14, ymm8, 0x1
	vpmovsxwd	ymm14, xmm14
	vpmovsxwd	ymm21, xmm21
	vcvtdq2ps	ymm14, ymm14
	vmulps	ymm14, ymm14, ymm1
	vcvtdq2ps	ymm8, ymm21
	vpmovsxwd	ymm21, xmm6
	vextracti32x4	xmm6, ymm6, 0x1
	vpmovsxwd	ymm6, xmm6
	vcvtdq2ps	ymm21, ymm21
	vcvtdq2ps	ymm6, ymm6
	vfmadd132ps	ymm8, ymm14, ymm2
	vpmovsxwd	ymm14, xmm5
	vextracti32x4	xmm5, ymm5, 0x1
	vpmovsxwd	ymm5, xmm5
	vcvtdq2ps	ymm14, ymm14
	vcvtdq2ps	ymm5, ymm5
	vmulps	ymm5, ymm5, ymm1
	vmulps	ymm14, ymm14, ymm1
	vfmadd132ps	ymm6, ymm5, ymm2
	vmovdqu	ymm5, YMMWORD PTR [rbx+r10]
	add	r10, 32
	vfmadd132ps	ymm21, ymm14, ymm2
	vpmovzxbw	ymm14, xmm5
	vextracti32x4	xmm5, ymm5, 0x1
	vpmovsxwd	ymm23, xmm14
	vextracti32x4	xmm14, ymm14, 0x1
	vpmovzxbw	ymm5, xmm5
	vcvtdq2ps	ymm23, ymm23
	vfmadd132ps	ymm23, ymm24, ymm0
	vpmovsxwd	ymm24, xmm7
	vextracti32x4	xmm7, ymm7, 0x1
	vpmovsxwd	ymm7, xmm7
	vcvtdq2ps	ymm24, ymm24
	vfmadd213ps	ymm24, ymm3, YMMWORD PTR -64[rax]
	vpmovsxwd	ymm14, xmm14
	vcvtdq2ps	ymm7, ymm7
	vfmadd213ps	ymm7, ymm3, YMMWORD PTR -32[rax]
	vcvtdq2ps	ymm14, ymm14
	vfmadd132ps	ymm14, ymm22, ymm0
	vpmovsxwd	ymm22, xmm5
	vextracti32x4	xmm5, ymm5, 0x1
	vcvtdq2ps	ymm22, ymm22
	vpmovsxwd	ymm5, xmm5
	vcvtdq2ps	ymm5, ymm5
	vaddps	ymm15, ymm15, ymm23
	vfmadd132ps	ymm22, ymm24, ymm0
	vfmadd132ps	ymm5, ymm7, ymm0
	vaddps	ymm8, ymm8, ymm14
	vmovups	YMMWORD PTR -128[rax], ymm15
	vmovups	YMMWORD PTR -96[rax], ymm8
	vaddps	ymm21, ymm21, ymm22
	vaddps	ymm5, ymm5, ymm6
	vmovups	YMMWORD PTR -64[rax], ymm21
	vmovups	YMMWORD PTR -32[rax], ymm5
	cmp	r10, r13
	jne	.L48
	mov	r10d, DWORD PTR 224[rsp]
	sal	r10d, 5
	cmp	r10d, edi
	je	.L45
	mov	edx, edi
	mov	eax, r10d
	sub	edx, r10d
	lea	esi, -1[rdx]
	cmp	esi, 14
	jbe	.L89
.L169:
	mov	esi, r10d
	mov	r13, QWORD PTR 248[rsp]
	lea	r11, [rsi+r9]
	lea	rbx, [rsi+r8]
	add	rsi, QWORD PTR 240[rsp]
	vmovdqu	xmm5, XMMWORD PTR [r12+r11]
	vmovdqu	xmm6, XMMWORD PTR 3[r12+rbx]
	lea	rsi, 0[r13+rsi*4]
	vmovdqu	xmm7, XMMWORD PTR [r12+rbx]
	vpmovzxbw	xmm14, xmm5
	vpsrldq	xmm5, xmm5, 8
	vpmovzxbw	xmm8, xmm6
	vpmovsxwd	xmm15, xmm14
	vpsrldq	xmm14, xmm14, 8
	vpmovsxwd	xmm21, xmm8
	vpmovsxwd	xmm14, xmm14
	vpsrldq	xmm8, xmm8, 8
	vpmovzxbw	xmm5, xmm5
	vcvtdq2ps	xmm15, xmm15
	vcvtdq2ps	xmm21, xmm21
	vcvtdq2ps	xmm14, xmm14
	vmulps	xmm14, xmm14, xmm12
	vpmovsxwd	xmm8, xmm8
	vpmovzxbw	xmm22, xmm7
	vmulps	xmm15, xmm15, xmm12
	vcvtdq2ps	xmm8, xmm8
	vpsrldq	xmm6, xmm6, 8
	vpmovsxwd	xmm24, xmm22
	vcvtdq2ps	xmm24, xmm24
	vfmadd213ps	xmm24, xmm10, XMMWORD PTR [rsi]
	vpsrldq	xmm7, xmm7, 8
	vpmovzxbw	xmm6, xmm6
	vpsrldq	xmm22, xmm22, 8
	vpmovzxbw	xmm7, xmm7
	vpmovsxwd	xmm22, xmm22
	vfmadd132ps	xmm8, xmm14, xmm11
	vpmovsxwd	xmm14, xmm5
	vcvtdq2ps	xmm22, xmm22
	vpsrldq	xmm5, xmm5, 8
	vcvtdq2ps	xmm14, xmm14
	vfmadd132ps	xmm21, xmm15, xmm11
	vpmovsxwd	xmm15, xmm6
	vmulps	xmm14, xmm14, xmm12
	vpsrldq	xmm6, xmm6, 8
	vpmovsxwd	xmm5, xmm5
	vcvtdq2ps	xmm15, xmm15
	vcvtdq2ps	xmm5, xmm5
	vmulps	xmm5, xmm5, xmm12
	vfmadd213ps	xmm22, xmm10, XMMWORD PTR 16[rsi]
	vpmovsxwd	xmm6, xmm6
	vcvtdq2ps	xmm6, xmm6
	vfmadd132ps	xmm15, xmm14, xmm11
	vfmadd132ps	xmm6, xmm5, xmm11
	vmovdqu	xmm5, XMMWORD PTR 3[r12+r11]
	vpmovzxbw	xmm14, xmm5
	vpsrldq	xmm5, xmm5, 8
	vpmovsxwd	xmm23, xmm14
	vpsrldq	xmm14, xmm14, 8
	vpmovzxbw	xmm5, xmm5
	vcvtdq2ps	xmm23, xmm23
	vfmadd132ps	xmm23, xmm24, xmm9
	vpmovsxwd	xmm24, xmm7
	vpmovsxwd	xmm14, xmm14
	vpsrldq	xmm7, xmm7, 8
	vcvtdq2ps	xmm24, xmm24
	vfmadd213ps	xmm24, xmm10, XMMWORD PTR 32[rsi]
	vcvtdq2ps	xmm14, xmm14
	vpmovsxwd	xmm7, xmm7
	vfmadd132ps	xmm14, xmm22, xmm9
	vpmovsxwd	xmm22, xmm5
	vcvtdq2ps	xmm7, xmm7
	vfmadd213ps	xmm7, xmm10, XMMWORD PTR 48[rsi]
	vpsrldq	xmm5, xmm5, 8
	vcvtdq2ps	xmm22, xmm22
	vpmovsxwd	xmm5, xmm5
	vcvtdq2ps	xmm5, xmm5
	vaddps	xmm21, xmm21, xmm23
	vfmadd132ps	xmm22, xmm24, xmm9
	vaddps	xmm8, xmm8, xmm14
	vfmadd132ps	xmm5, xmm7, xmm9
	vmovups	XMMWORD PTR [rsi], xmm21
	vmovups	XMMWORD PTR 16[rsi], xmm8
	vaddps	xmm15, xmm15, xmm22
	vaddps	xmm5, xmm5, xmm6
	vmovups	XMMWORD PTR 32[rsi], xmm15
	vmovups	XMMWORD PTR 48[rsi], xmm5
	mov	esi, edx
	and	esi, -16
	test	dl, 15
	je	.L45
	add	eax, esi
.L49:
	sub	edx, esi
	lea	r11d, -1[rdx]
	cmp	r11d, 6
	jbe	.L50
	add	esi, r10d
	mov	rbx, QWORD PTR 248[rsp]
	mov	esi, esi
	lea	r11, [rsi+r8]
	lea	r10, [rsi+r9]
	add	rsi, QWORD PTR 240[rsp]
	vmovq	xmm5, QWORD PTR [r12+r11]
	lea	rbx, [rbx+rsi*4]
	vpmovzxbw	xmm7, xmm5
	vpsrlq	xmm5, xmm5, 32
	vpmovzxbw	xmm6, xmm5
	vmovq	xmm5, QWORD PTR [r12+r10]
	vmovq	rsi, xmm6
	vmovq	xmm6, QWORD PTR 3[r12+r11]
	vpmovzxbw	xmm8, xmm5
	vpsrlq	xmm5, xmm5, 32
	vpmovzxbw	xmm14, xmm6
	vpsrlq	xmm6, xmm6, 32
	vpmovzxbw	xmm5, xmm5
	vpmovzxwd	xmm15, xmm14
	vpsrlq	xmm14, xmm14, 32
	vpmovzxbw	xmm6, xmm6
	vmovq	xmm15, xmm15
	vpmovzxwd	xmm14, xmm14
	vcvtdq2ps	xmm22, xmm15
	vpmovzxwd	xmm15, xmm8
	vpsrlq	xmm8, xmm8, 32
	vmovq	xmm14, xmm14
	vpmovzxwd	xmm8, xmm8
	vcvtdq2ps	xmm14, xmm14
	vmovq	xmm21, xmm15
	vmovq	xmm8, xmm8
	vcvtdq2ps	xmm21, xmm21
	vcvtdq2ps	xmm8, xmm8
	vmulps	xmm8, xmm8, xmm12
	vmulps	xmm21, xmm21, xmm12
	vfmadd132ps	xmm14, xmm8, xmm11
	vpmovzxwd	xmm8, xmm6
	vpsrlq	xmm6, xmm6, 32
	vfmadd132ps	xmm22, xmm21, xmm11
	vmovq	xmm8, xmm8
	vpmovzxwd	xmm6, xmm6
	vcvtdq2ps	xmm15, xmm8
	vmovq	xmm8, QWORD PTR 3[r12+r10]
	vmovq	xmm6, xmm6
	vcvtdq2ps	xmm6, xmm6
	vmovaps	xmm24, xmm14
	vpmovzxwd	xmm14, xmm5
	vpsrlq	xmm5, xmm5, 32
	vmovq	xmm14, xmm14
	vpmovzxwd	xmm5, xmm5
	vcvtdq2ps	xmm14, xmm14
	vmulps	xmm14, xmm14, xmm12
	vmovq	xmm5, xmm5
	vcvtdq2ps	xmm5, xmm5
	vmulps	xmm5, xmm5, xmm12
	vfmadd132ps	xmm15, xmm14, xmm11
	vmovq	xmm14, QWORD PTR [rbx]
	vfmadd132ps	xmm6, xmm5, xmm11
	vpmovzxbw	xmm5, xmm8
	vpsrlq	xmm8, xmm8, 32
	vpmovzxbw	xmm8, xmm8
	vmovaps	xmm26, xmm15
	vmovaps	xmm21, xmm6
	vpmovzxwd	xmm6, xmm5
	vmovq	xmm6, xmm6
	vpsrlq	xmm5, xmm5, 32
	vcvtdq2ps	xmm15, xmm6
	vpmovzxwd	xmm6, xmm7
	vpmovzxwd	xmm5, xmm5
	vmovq	xmm6, xmm6
	vmovq	xmm25, xmm5
	vpmovzxwd	xmm5, xmm8
	vcvtdq2ps	xmm6, xmm6
	vfmadd231ps	xmm14, xmm6, xmm10
	vpsrlq	xmm6, xmm7, 32
	vmovq	xmm7, rsi
	vcvtdq2ps	xmm25, xmm25
	vpmovzxwd	xmm6, xmm6
	vpmovzxwd	xmm7, xmm7
	vmovq	xmm5, xmm5
	vmovq	xmm6, xmm6
	vcvtdq2ps	xmm5, xmm5
	vpsrlq	xmm8, xmm8, 32
	vmovq	xmm7, xmm7
	vcvtdq2ps	xmm7, xmm7
	vpmovzxwd	xmm8, xmm8
	vmovq	xmm8, xmm8
	vfmadd132ps	xmm15, xmm14, xmm9
	vcvtdq2ps	xmm14, xmm6
	vmovq	xmm6, QWORD PTR 8[rbx]
	vcvtdq2ps	xmm8, xmm8
	vfmadd231ps	xmm6, xmm14, xmm10
	vmovq	xmm14, QWORD PTR 16[rbx]
	vfmadd132ps	xmm7, xmm14, xmm10
	vmovaps	xmm23, xmm15
	vmovq	xmm15, QWORD PTR 24[rbx]
	vfmadd132ps	xmm25, xmm6, xmm9
	vfmadd132ps	xmm5, xmm7, xmm9
	vmovq	xmm7, rsi
	mov	esi, edx
	vpsrlq	xmm14, xmm7, 32
	and	esi, -8
	and	edx, 7
	vpmovzxwd	xmm14, xmm14
	vmovq	xmm14, xmm14
	vaddps	xmm7, xmm24, xmm25
	vcvtdq2ps	xmm14, xmm14
	vfmadd132ps	xmm14, xmm15, xmm10
	vaddps	xmm5, xmm26, xmm5
	vmovlps	QWORD PTR 8[rbx], xmm7
	vmovlps	QWORD PTR 16[rbx], xmm5
	vfmadd132ps	xmm8, xmm14, xmm9
	vaddps	xmm14, xmm8, xmm21
	vaddps	xmm8, xmm22, xmm23
	vmovlps	QWORD PTR 24[rbx], xmm14
	vmovlps	QWORD PTR [rbx], xmm8
	je	.L45
	add	eax, esi
.L50:
	movsxd	rdx, eax
	mov	ebx, DWORD PTR 256[rsp]
	lea	r10, [rdx+r8]
	add	rdx, r9
	movzx	r11d, BYTE PTR [r12+r10]
	movzx	r10d, BYTE PTR 3[r12+r10]
	lea	esi, [rbx+rax]
	vcvtusi2ss	xmm5, xmm4, r11d
	vmovaps	xmm7, xmm5
	vcvtusi2ss	xmm5, xmm4, r10d
	movzx	r10d, BYTE PTR [r12+rdx]
	movzx	edx, BYTE PTR 3[r12+rdx]
	vfmadd213ss	xmm7, xmm19, DWORD PTR [r15+rsi*4]
	vcvtusi2ss	xmm6, xmm4, r10d
	vmulss	xmm6, xmm6, xmm17
	vfmadd231ss	xmm6, xmm18, xmm5
	vcvtusi2ss	xmm5, xmm4, edx
	vfmadd132ss	xmm5, xmm7, xmm16
	vaddss	xmm5, xmm5, xmm6
	vmovss	DWORD PTR [r15+rsi*4], xmm5
	lea	esi, 1[rax]
	cmp	esi, edi
	jge	.L45
	mov	edx, esi
	add	esi, ebx
	lea	r10, [rdx+r8]
	add	rdx, r9
	mov	esi, esi
	movzx	r11d, BYTE PTR [r12+r10]
	movzx	r10d, BYTE PTR 3[r12+r10]
	vcvtusi2ss	xmm5, xmm4, r11d
	vmovaps	xmm7, xmm5
	vcvtusi2ss	xmm5, xmm4, r10d
	movzx	r10d, BYTE PTR [r12+rdx]
	movzx	edx, BYTE PTR 3[r12+rdx]
	vfmadd213ss	xmm7, xmm19, DWORD PTR [r15+rsi*4]
	vcvtusi2ss	xmm6, xmm4, r10d
	vmulss	xmm6, xmm6, xmm17
	vfmadd231ss	xmm6, xmm18, xmm5
	vcvtusi2ss	xmm5, xmm4, edx
	vfmadd132ss	xmm5, xmm7, xmm16
	vaddss	xmm5, xmm5, xmm6
	vmovss	DWORD PTR [r15+rsi*4], xmm5
	lea	esi, 2[rax]
	cmp	esi, edi
	jge	.L45
	mov	edx, esi
	add	esi, ebx
	lea	r10, [rdx+r8]
	add	rdx, r9
	mov	esi, esi
	movzx	r11d, BYTE PTR [r12+r10]
	movzx	r10d, BYTE PTR 3[r12+r10]
	vcvtusi2ss	xmm5, xmm4, r11d
	vmovaps	xmm7, xmm5
	vcvtusi2ss	xmm5, xmm4, r10d
	movzx	r10d, BYTE PTR [r12+rdx]
	movzx	edx, BYTE PTR 3[r12+rdx]
	vfmadd213ss	xmm7, xmm19, DWORD PTR [r15+rsi*4]
	vcvtusi2ss	xmm6, xmm4, r10d
	vmulss	xmm6, xmm6, xmm17
	vfmadd231ss	xmm6, xmm18, xmm5
	vcvtusi2ss	xmm5, xmm4, edx
	vfmadd132ss	xmm5, xmm7, xmm16
	vaddss	xmm5, xmm5, xmm6
	vmovss	DWORD PTR [r15+rsi*4], xmm5
	lea	esi, 3[rax]
	cmp	esi, edi
	jge	.L45
	mov	edx, esi
	add	esi, ebx
	lea	r10, [rdx+r8]
	add	rdx, r9
	mov	esi, esi
	movzx	r11d, BYTE PTR [r12+r10]
	movzx	r10d, BYTE PTR 3[r12+r10]
	vcvtusi2ss	xmm5, xmm4, r11d
	vmovaps	xmm7, xmm5
	vcvtusi2ss	xmm5, xmm4, r10d
	movzx	r10d, BYTE PTR [r12+rdx]
	movzx	edx, BYTE PTR 3[r12+rdx]
	vfmadd213ss	xmm7, xmm19, DWORD PTR [r15+rsi*4]
	vcvtusi2ss	xmm6, xmm4, r10d
	vmulss	xmm6, xmm6, xmm17
	vfmadd231ss	xmm6, xmm18, xmm5
	vcvtusi2ss	xmm5, xmm4, edx
	vfmadd132ss	xmm5, xmm7, xmm16
	vaddss	xmm5, xmm5, xmm6
	vmovss	DWORD PTR [r15+rsi*4], xmm5
	lea	esi, 4[rax]
	cmp	esi, edi
	jge	.L45
	mov	edx, esi
	add	esi, ebx
	lea	r10, [rdx+r8]
	add	rdx, r9
	mov	esi, esi
	movzx	r11d, BYTE PTR [r12+r10]
	movzx	r10d, BYTE PTR 3[r12+r10]
	vcvtusi2ss	xmm5, xmm4, r11d
	vmovaps	xmm7, xmm5
	vcvtusi2ss	xmm5, xmm4, r10d
	movzx	r10d, BYTE PTR [r12+rdx]
	movzx	edx, BYTE PTR 3[r12+rdx]
	vfmadd213ss	xmm7, xmm19, DWORD PTR [r15+rsi*4]
	vcvtusi2ss	xmm6, xmm4, r10d
	vmulss	xmm6, xmm6, xmm17
	vfmadd231ss	xmm6, xmm18, xmm5
	vcvtusi2ss	xmm5, xmm4, edx
	vfmadd132ss	xmm5, xmm7, xmm16
	vaddss	xmm5, xmm5, xmm6
	vmovss	DWORD PTR [r15+rsi*4], xmm5
	lea	esi, 5[rax]
	cmp	edi, esi
	jle	.L45
	mov	edx, esi
	add	esi, ebx
	add	eax, 6
	lea	r10, [r8+rdx]
	add	rdx, r9
	mov	esi, esi
	movzx	r11d, BYTE PTR [r12+r10]
	movzx	r10d, BYTE PTR 3[r12+r10]
	vcvtusi2ss	xmm5, xmm4, r11d
	vmovaps	xmm7, xmm5
	vcvtusi2ss	xmm5, xmm4, r10d
	movzx	r10d, BYTE PTR [r12+rdx]
	movzx	edx, BYTE PTR 3[r12+rdx]
	vfmadd213ss	xmm7, xmm19, DWORD PTR [r15+rsi*4]
	vcvtusi2ss	xmm6, xmm4, r10d
	vmulss	xmm6, xmm6, xmm17
	vfmadd231ss	xmm6, xmm18, xmm5
	vcvtusi2ss	xmm5, xmm4, edx
	vfmadd132ss	xmm5, xmm7, xmm16
	vaddss	xmm5, xmm5, xmm6
	vmovss	DWORD PTR [r15+rsi*4], xmm5
	cmp	edi, eax
	jle	.L45
	mov	edx, eax
	add	eax, ebx
	add	r8, rdx
	add	rdx, r9
	mov	eax, eax
	movzx	esi, BYTE PTR [r12+r8]
	vcvtusi2ss	xmm5, xmm4, esi
	movzx	esi, BYTE PTR 3[r12+r8]
	vmovaps	xmm7, xmm5
	vcvtusi2ss	xmm5, xmm4, esi
	movzx	esi, BYTE PTR [r12+rdx]
	movzx	edx, BYTE PTR 3[r12+rdx]
	vfmadd213ss	xmm7, xmm19, DWORD PTR [r15+rax*4]
	vcvtusi2ss	xmm6, xmm4, esi
	vmulss	xmm6, xmm6, xmm17
	vfmadd231ss	xmm6, xmm18, xmm5
	vcvtusi2ss	xmm5, xmm4, edx
	vfmadd132ss	xmm5, xmm7, xmm16
	vaddss	xmm5, xmm5, xmm6
	vmovss	DWORD PTR [r15+rax*4], xmm5
.L45:
	inc	DWORD PTR 280[rsp]
	mov	rdi, QWORD PTR 192[rsp]
	mov	rbx, QWORD PTR 208[rsp]
	add	r15, QWORD PTR 200[rsp]
	add	rcx, rdi
	add	r14, rdi
	add	QWORD PTR 232[rsp], rbx
	mov	eax, DWORD PTR 280[rsp]
	cmp	eax, DWORD PTR 216[rsp]
	jl	.L52
	mov	rdx, QWORD PTR 136[rsp]
	mov	r10, QWORD PTR 128[rsp]
	mov	r15d, DWORD PTR 144[rsp]
	mov	r13d, DWORD PTR 124[rsp]
	mov	r9d, DWORD PTR 120[rsp]
.L38:
	add	rdx, 48
	cmp	QWORD PTR 152[rsp], rdx
	jne	.L53
	mov	r11, QWORD PTR 104[rsp]
	mov	ecx, DWORD PTR 52[rsp]
	mov	r12, QWORD PTR 96[rsp]
.L37:
	cmp	DWORD PTR 48[rsp], r15d
	jge	.L54
	test	ecx, ecx
	jle	.L54
	lea	rax, [r11+r11*2]
	mov	rdi, QWORD PTR 248[rsp]
	mov	r9, QWORD PTR 32[rsp]
	lea	r8d, [rcx+rcx*2]
	lea	r13, 0[0+rax*4]
	mov	rax, QWORD PTR 72[rsp]
	mov	r11d, DWORD PTR 80[rsp]
	vmovss	xmm3, DWORD PTR .LC5[rip]
	vmovss	xmm6, DWORD PTR .LC6[rip]
	mov	r14, QWORD PTR 64[rsp]
	lea	rbx, [rax+r12*4]
	.p2align 4,,10
	.p2align 3
.L66:
	lea	rax, [r9+r12]
	mov	QWORD PTR 280[rsp], r9
	vmovss	xmm2, DWORD PTR .LC6[rip]
	lea	rcx, [rbx+r9*4]
	lea	rsi, [rax+rax*2]
	vmovss	xmm5, DWORD PTR .LC5[rip]
	xor	edx, edx
	add	rsi, QWORD PTR 16[r14]
	.p2align 4,,10
	.p2align 3
.L65:
	mov	eax, DWORD PTR [rcx]
	test	eax, eax
	je	.L55
	vcvtsi2ss	xmm0, xmm4, eax
	mov	eax, edx
	xor	r9d, r9d
	vdivss	xmm0, xmm20, xmm0
	vmulss	xmm1, xmm0, DWORD PTR [rdi+rax*4]
	vcomiss	xmm13, xmm1
	ja	.L64
	vaddss	xmm1, xmm1, xmm3
	vminss	xmm1, xmm1, xmm6
	vcvttss2si	r9d, xmm1
.L64:
	vmulss	xmm1, xmm0, DWORD PTR 4[rdi+rax*4]
	mov	BYTE PTR [rsi+rax], r9b
	xor	r9d, r9d
	vcomiss	xmm13, xmm1
	ja	.L63
	vaddss	xmm1, xmm1, xmm3
	vminss	xmm1, xmm1, xmm2
	vcvttss2si	r9d, xmm1
.L63:
	vmulss	xmm0, xmm0, DWORD PTR 8[rdi+rax*4]
	mov	BYTE PTR 1[rsi+rax], r9b
	xor	r9d, r9d
	vcomiss	xmm13, xmm0
	ja	.L62
	vaddss	xmm0, xmm0, xmm5
	vminss	xmm0, xmm0, xmm2
	vcvttss2si	r9d, xmm0
.L62:
	mov	BYTE PTR 2[rsi+rax], r9b
.L55:
	add	edx, 3
	add	rcx, 4
	cmp	edx, r8d
	jne	.L65
	mov	r9, QWORD PTR 280[rsp]
	inc	r11d
	add	rdi, r13
	add	r9, r10
	cmp	r15d, r11d
	jne	.L66
.L54:
	add	r12, 2032
	cmp	DWORD PTR 84[rsp], r12d
	jg	.L67
	add	QWORD PTR 88[rsp], 8
	mov	rcx, QWORD PTR 32[rsp]
	mov	r12, QWORD PTR 8[rsp]
	mov	r14d, DWORD PTR 24[rsp]
	add	rcx, r12
	cmp	r14d, DWORD PTR 88[rsp]
	jg	.L68
	mov	r12, QWORD PTR 16[rsp]
	vzeroupper
.L35:
	mov	rdi, QWORD PTR 248[rsp]
	mov	esi, 195072
	call	"_ZdlPvm"@PLT
	mov	rax, QWORD PTR 72[rsp]
	test	rax, rax
	je	.L69
	mov	rsi, r12
	mov	rdi, rax
	call	"_ZdlPvm"@PLT
.L69:
	mov	rax, QWORD PTR 112[rsp]
	test	rax, rax
	je	.L1
	mov	rsi, QWORD PTR 40[rsp]
	mov	rdi, rax
	call	"_ZdlPvm"@PLT
.L1:
	mov	rax, QWORD PTR 64[rsp]
	lea	rsp, -40[rbp]
	pop	rbx
	pop	r12
	pop	r13
	pop	r14
	pop	r15
	pop	rbp
	.cfi_remember_state
	.cfi_def_cfa 7, 8
	ret
	.p2align 4,,10
	.p2align 3
.L46:
	.cfi_restore_state
	mov	rsi, QWORD PTR 224[rsp]
	lea	r8, [r15+r10*4]
	xor	eax, eax
	.p2align 4,,10
	.p2align 3
.L51:
	movzx	r9d, BYTE PTR [rsi+rax]
	vcvtusi2ss	xmm5, xmm4, r9d
	movzx	r9d, BYTE PTR 3[rsi+rax]
	vmovaps	xmm7, xmm5
	vcvtusi2ss	xmm5, xmm4, r9d
	movzx	r9d, BYTE PTR [rdx+rax]
	vfmadd213ss	xmm7, xmm19, DWORD PTR [r8+rax*4]
	vcvtusi2ss	xmm6, xmm4, r9d
	movzx	r9d, BYTE PTR 3[rdx+rax]
	vmulss	xmm6, xmm6, xmm17
	vfmadd231ss	xmm6, xmm18, xmm5
	vcvtusi2ss	xmm5, xmm4, r9d
	vfmadd132ss	xmm5, xmm7, xmm16
	vaddss	xmm5, xmm5, xmm6
	vmovss	DWORD PTR [r8+rax*4], xmm5
	inc	rax
	cmp	edi, eax
	jg	.L51
	jmp	.L45
	.p2align 4,,10
	.p2align 3
.L39:
	mov	edi, DWORD PTR 272[rsp]
	cmp	edi, 7
	jg	.L86
	mov	DWORD PTR 256[rsp], 0
	mov	r9, r14
	mov	r8, rcx
	xor	r10d, r10d
	jmp	.L43
.L88:
	xor	r10d, r10d
	mov	edx, edi
	xor	eax, eax
	sub	edx, r10d
	lea	esi, -1[rdx]
	cmp	esi, 14
	ja	.L169
.L89:
	xor	esi, esi
	jmp	.L49
.L86:
	mov	DWORD PTR 256[rsp], 8
	mov	rax, r15
	mov	rdx, r14
	mov	rsi, rcx
	jmp	.L42
.L168:
	mov	rcx, QWORD PTR 152[rsp]
	xor	edi, edi
	cmp	QWORD PTR 112[rsp], rcx
	jne	.L24
	test	r14d, r14d
	jle	.L25
	mov	esi, DWORD PTR 84[rsp]
	test	esi, esi
	jg	.L26
	jmp	.L25
	.p2align 4,,10
	.p2align 3
.L167:
	mov	QWORD PTR 112[rsp], 0
	mov	r14d, edx
	xor	r13d, r13d
	vmovd	DWORD PTR 84[rsp], xmm0
	cmp	rbx, rcx
	jne	.L5
	mov	QWORD PTR 152[rsp], 0
.L83:
	mov	QWORD PTR 72[rsp], 0
	jmp	.L18
.L13:
	mov	rax, r13
	sub	rax, r15
	mov	QWORD PTR 272[rsp], rax
	sar	rax, 4
	mov	rdx, rax
	movabs	rax, -6148914691236517205
	imul	rdx, rax
	movabs	rax, 192153584101141162
	cmp	rdx, rax
	je	.L157
	test	rdx, rdx
	mov	eax, 1
	mov	DWORD PTR 160[rsp], r11d
	cmovne	rax, rdx
	mov	DWORD PTR 168[rsp], ecx
	mov	DWORD PTR 176[rsp], r9d
	add	rax, rdx
	movabs	rdx, 192153584101141162
	mov	DWORD PTR 184[rsp], r8d
	cmp	rax, rdx
	mov	DWORD PTR 216[rsp], esi
	cmova	rax, rdx
	mov	DWORD PTR 220[rsp], r10d
	vmovss	DWORD PTR 188[rsp], xmm3
	lea	rax, [rax+rax*2]
	vmovss	DWORD PTR 192[rsp], xmm0
	sal	rax, 4
	vmovss	DWORD PTR 200[rsp], xmm1
	mov	rdi, rax
	mov	QWORD PTR 232[rsp], rax
	vmovss	DWORD PTR 208[rsp], xmm2
.LEHB3:
	call	"_Znwm"@PLT
.LEHE3:
	mov	rdx, QWORD PTR 272[rsp]
	mov	ecx, DWORD PTR 168[rsp]
	mov	QWORD PTR 248[rsp], rax
	mov	rdi, rax
	vmovss	xmm0, DWORD PTR 192[rsp]
	vmovss	xmm2, DWORD PTR 208[rsp]
	mov	r10d, DWORD PTR 220[rsp]
	mov	esi, DWORD PTR 216[rsp]
	mov	DWORD PTR 28[rax+rdx], ecx
	vinsertps	xmm0, xmm0, DWORD PTR 188[rsp], 0x10
	vinsertps	xmm2, xmm2, DWORD PTR 200[rsp], 0x10
	mov	r8d, DWORD PTR 184[rsp]
	mov	r9d, DWORD PTR 176[rsp]
	mov	DWORD PTR [rax+rdx], r10d
	mov	r11d, DWORD PTR 160[rsp]
	mov	rcx, QWORD PTR 240[rsp]
	vmovlhps	xmm2, xmm2, xmm0
	mov	DWORD PTR 4[rax+rdx], esi
	mov	DWORD PTR 24[rax+rdx], r8d
	mov	DWORD PTR 32[rax+rdx], r9d
	mov	DWORD PTR 36[rax+rdx], r11d
	mov	QWORD PTR 40[rax+rdx], rcx
	vmovups	XMMWORD PTR 8[rax+rdx], xmm2
	test	rdx, rdx
	je	.L15
	mov	rsi, r15
	call	"memcpy"@PLT
.L15:
	mov	rax, QWORD PTR 248[rsp]
	mov	rcx, QWORD PTR 272[rsp]
	lea	rax, 48[rax+rcx]
	mov	QWORD PTR 112[rsp], rax
	test	r15, r15
	je	.L16
	mov	rsi, r13
	mov	rdi, r15
	sub	rsi, r15
	call	"_ZdlPvm"@PLT
.L16:
	mov	r13, QWORD PTR 232[rsp]
	mov	r15, QWORD PTR 248[rsp]
	add	r13, r15
	jmp	.L12
.L2:
	lea	r14, [r12+r12*2]
	test	r14, r14
	js	.L156
	mov	rdi, r14
.LEHB4:
	call	"_Znwm"@PLT
.LEHE4:
	xor	esi, esi
	mov	rdx, r14
	lea	r15, [rax+r14]
	mov	rdi, rax
	call	"memset"@PLT
	mov	rcx, rax
	mov	rax, QWORD PTR 64[rsp]
	mov	QWORD PTR 16[rax], rcx
	mov	QWORD PTR 24[rax], r15
	mov	QWORD PTR 32[rax], r15
	mov	rax, QWORD PTR 8[r13]
	mov	QWORD PTR 280[rsp], rax
	sub	rax, rbx
	mov	QWORD PTR 40[rsp], rax
	jne	.L4
	mov	QWORD PTR 112[rsp], 0
	xor	r13d, r13d
	jmp	.L8
.L27:
	test	r14d, r14d
	jle	.L31
	mov	eax, DWORD PTR 84[rsp]
	test	eax, eax
	jg	.L26
	jmp	.L31
.L80:
	mov	rax, QWORD PTR 112[rsp]
	mov	QWORD PTR 152[rsp], rax
	jmp	.L9
.L150:
	jmp	.L151
.L152:
	jmp	.L153
.L93:
	mov	rbx, rax
	vzeroupper
	jmp	.L21
.L154:
	jmp	.L155
	.section	.gcc_except_table,"a",@progbits
.LLSDA11708:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSE11708-.LLSDACSB11708
.LLSDACSB11708:
	.uleb128 .LEHB0-.LFB11708
	.uleb128 .LEHE0-.LEHB0
	.uleb128 .L150-.LFB11708
	.uleb128 0
	.uleb128 .LEHB1-.LFB11708
	.uleb128 .LEHE1-.LEHB1
	.uleb128 .L93-.LFB11708
	.uleb128 0
	.uleb128 .LEHB2-.LFB11708
	.uleb128 .LEHE2-.LEHB2
	.uleb128 .L152-.LFB11708
	.uleb128 0
	.uleb128 .LEHB3-.LFB11708
	.uleb128 .LEHE3-.LEHB3
	.uleb128 .L154-.LFB11708
	.uleb128 0
	.uleb128 .LEHB4-.LFB11708
	.uleb128 .LEHE4-.LEHB4
	.uleb128 .L150-.LFB11708
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
.L158:
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
.L91:
	mov	rbx, rax
	vzeroupper
.L21:
	cmp	QWORD PTR 112[rsp], 0
	je	.L75
	mov	rdi, QWORD PTR 112[rsp]
	mov	rsi, r13
	sub	rsi, rdi
	call	"_ZdlPvm"@PLT
	jmp	.L75
.L90:
.L151:
	mov	rbx, rax
	vzeroupper
.L75:
	mov	rax, QWORD PTR 64[rsp]
	mov	rdi, QWORD PTR 16[rax]
	test	rdi, rdi
	je	.L76
	mov	rsi, QWORD PTR 32[rax]
	sub	rsi, rdi
	call	"_ZdlPvm"@PLT
.L76:
	mov	rdi, rbx
.LEHB6:
	call	"_Unwind_Resume"@PLT
.LEHE6:
.L156:
	lea	rdi, .LC0[rip]
.LEHB7:
	call	"_ZSt20__throw_length_errorPKc"@PLT
.LEHE7:
.L92:
.L153:
	cmp	QWORD PTR 72[rsp], 0
	mov	rbx, rax
	je	.L164
	mov	rdi, QWORD PTR 72[rsp]
	mov	rsi, r12
	vzeroupper
	call	"_ZdlPvm"@PLT
	jmp	.L21
.L164:
	vzeroupper
	jmp	.L21
.L157:
	lea	rdi, .LC2[rip]
.LEHB8:
	call	"_ZSt20__throw_length_errorPKc"@PLT
.LEHE8:
.L159:
	lea	rdi, .LC0[rip]
.LEHB9:
	call	"_ZSt20__throw_length_errorPKc"@PLT
.LEHE9:
.L94:
.L155:
	mov	QWORD PTR 112[rsp], r15
	mov	rbx, rax
	vzeroupper
	jmp	.L21
	.cfi_endproc
.LFE11708:
	.section	.gcc_except_table
.LLSDAC11708:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSEC11708-.LLSDACSBC11708
.LLSDACSBC11708:
	.uleb128 .LEHB5-.LCOLDB8
	.uleb128 .LEHE5-.LEHB5
	.uleb128 .L91-.LCOLDB8
	.uleb128 0
	.uleb128 .LEHB6-.LCOLDB8
	.uleb128 .LEHE6-.LEHB6
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB7-.LCOLDB8
	.uleb128 .LEHE7-.LEHB7
	.uleb128 .L90-.LCOLDB8
	.uleb128 0
	.uleb128 .LEHB8-.LCOLDB8
	.uleb128 .LEHE8-.LEHB8
	.uleb128 .L94-.LCOLDB8
	.uleb128 0
	.uleb128 .LEHB9-.LCOLDB8
	.uleb128 .LEHE9-.LEHB9
	.uleb128 .L92-.LCOLDB8
	.uleb128 0
.LLSDACSEC11708:
	.section	.text.unlikely
	.text
	.size	"_Z21refocus_shift_and_sumRSt6vectorI16SubApertureImageSaIS0_EEf", .-"_Z21refocus_shift_and_sumRSt6vectorI16SubApertureImageSaIS0_EEf"
	.section	.text.unlikely
	.size	"_Z21refocus_shift_and_sumRSt6vectorI16SubApertureImageSaIS0_EEf.cold", .-"_Z21refocus_shift_and_sumRSt6vectorI16SubApertureImageSaIS0_EEf.cold"
.LCOLDE8:
	.text
.LHOTE8:
	.section	.rodata.cst4,"aM",@progbits,4
	.align 4
.LC1:
	.long	1065353216
	.align 4
.LC4:
	.long	-1090519040
	.align 4
.LC5:
	.long	1056964608
	.align 4
.LC6:
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
