	.file	"opt10_abl_tile_8x256.cpp"
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
	mov	QWORD PTR 72[rsp], rdi
	vmovdqu	xmm0, XMMWORD PTR [rbx]
	mov	QWORD PTR 32[rdi], 0
	vmovdqu	XMMWORD PTR 16[rdi], xmm1
	vmovq	rax, xmm0
	vpextrq	rsi, xmm0, 1
	vmovq	QWORD PTR 64[rsp], xmm0
	mov	r12, rax
	mov	QWORD PTR 272[rsp], rsi
	imul	r12, rsi
	vmovdqu	XMMWORD PTR [rdi], xmm0
	test	r12, r12
	jne	.L2
	mov	rdi, QWORD PTR 8[r13]
	mov	rdx, rdi
	mov	QWORD PTR 280[rsp], rdi
	sub	rdx, rbx
	mov	QWORD PTR 48[rsp], rdx
	je	.L161
.L4:
	mov	r15, QWORD PTR 48[rsp]
	mov	rdi, r15
.LEHB0:
	call	"_Znwm"@PLT
.LEHE0:
	mov	QWORD PTR 96[rsp], rax
	add	r15, rax
.L8:
	mov	eax, DWORD PTR 64[rsp]
	mov	r13d, DWORD PTR 272[rsp]
	mov	DWORD PTR 112[rsp], eax
	cmp	rbx, QWORD PTR 280[rsp]
	je	.L76
.L5:
	mov	r14, QWORD PTR 96[rsp]
.L19:
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
	mov	eax, DWORD PTR 112[rsp]
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
	mov	eax, r13d
	sub	eax, esi
	dec	eax
	cmp	eax, r13d
	cmovg	eax, r13d
	mov	r11d, eax
	cmp	r8d, ecx
	jge	.L12
	cmp	r9d, eax
	jge	.L12
	vsubss	xmm5, xmm2, xmm1
	vsubss	xmm3, xmm4, xmm0
	mov	rdi, QWORD PTR 16[rbx]
	mov	rax, QWORD PTR 96[rsp]
	vaddss	xmm0, xmm0, DWORD PTR .LC1[rip]
	vaddss	xmm1, xmm1, DWORD PTR .LC1[rip]
	mov	QWORD PTR 240[rsp], rdi
	vsubss	xmm0, xmm0, xmm4
	vsubss	xmm1, xmm1, xmm2
	vmulss	xmm2, xmm0, xmm1
	vmulss	xmm1, xmm1, xmm3
	vmulss	xmm0, xmm0, xmm5
	vmulss	xmm3, xmm3, xmm5
	cmp	r15, rax
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
	mov	QWORD PTR 96[rsp], rax
.L12:
	add	rbx, 48
	cmp	rbx, QWORD PTR 280[rsp]
	jne	.L19
	mov	rax, r15
	sub	rax, r14
	mov	QWORD PTR 48[rsp], rax
	mov	rax, QWORD PTR 96[rsp]
	mov	QWORD PTR 96[rsp], r14
	mov	QWORD PTR 152[rsp], rax
.L9:
	mov	rax, r12
	shr	rax, 61
	jne	.L153
	test	r12, r12
	je	.L79
	sal	r12, 2
	mov	rdi, r12
.LEHB1:
	call	"_Znwm"@PLT
.LEHE1:
	mov	rdx, r12
	xor	esi, esi
	mov	rdi, rax
	mov	QWORD PTR 80[rsp], rax
	call	"memset"@PLT
.L20:
	mov	rax, QWORD PTR 64[rsp]
	mov	rbx, QWORD PTR 272[rsp]
	lea	r14, 1[rax]
	inc	rbx
	imul	rbx, r14
	mov	rax, rbx
	shr	rax, 61
	jne	.L154
	test	rbx, rbx
	je	.L162
	sal	rbx, 2
	mov	rdi, rbx
.LEHB2:
	call	"_Znwm"@PLT
	mov	rdi, rax
	mov	rdx, rbx
	xor	esi, esi
	call	"memset"@PLT
	mov	rdx, QWORD PTR 152[rsp]
	mov	rdi, rax
	cmp	QWORD PTR 96[rsp], rdx
	je	.L28
.L25:
	mov	rax, QWORD PTR 96[rsp]
.L29:
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
	cmp	rax, QWORD PTR 152[rsp]
	jne	.L29
	test	r13d, r13d
	jle	.L35
	mov	ecx, DWORD PTR 112[rsp]
	test	ecx, ecx
	jle	.L35
.L27:
	mov	rax, QWORD PTR 64[rsp]
	xor	ecx, ecx
	lea	edx, -1[rax]
	xor	eax, eax
	lea	rsi, 1[rdx]
.L31:
	mov	rdx, QWORD PTR 80[rsp]
	add	ecx, DWORD PTR [rdi+rax*4]
	mov	DWORD PTR [rdx+rax*4], ecx
	inc	rax
	cmp	rsi, rax
	jne	.L31
	cmp	r13d, 1
	jle	.L32
	mov	eax, DWORD PTR 112[rsp]
	sal	r14, 2
	xor	r11d, r11d
	mov	r10d, 1
	lea	rdx, [rdi+r14]
	lea	r8, 0[0+rax*4]
	mov	rax, QWORD PTR 80[rsp]
	lea	r9, [rax+r8]
.L34:
	mov	rcx, QWORD PTR 80[rsp]
	movsxd	rax, r11d
	add	r11d, DWORD PTR 64[rsp]
	mov	QWORD PTR 256[rsp], rdi
	lea	rax, [rcx+rax*4]
	xor	ecx, ecx
	mov	QWORD PTR 280[rsp], rax
	xor	eax, eax
.L33:
	mov	rdi, QWORD PTR 280[rsp]
	add	ecx, DWORD PTR [rdx+rax*4]
	mov	edi, DWORD PTR [rdi+rax*4]
	add	edi, ecx
	mov	DWORD PTR [r9+rax*4], edi
	inc	rax
	cmp	rsi, rax
	jne	.L33
	inc	r10d
	mov	rdi, QWORD PTR 256[rsp]
	add	rdx, r14
	add	r9, r8
	cmp	r13d, r10d
	jg	.L34
.L35:
	test	rdi, rdi
	je	.L26
.L32:
	mov	rsi, rbx
	call	"_ZdlPvm"@PLT
.L26:
	mov	edi, 24576
	call	"_Znwm"@PLT
.LEHE2:
	mov	DWORD PTR [rax], 0x00000000
	xor	esi, esi
	lea	rdi, 4[rax]
	mov	edx, 24572
	mov	QWORD PTR 240[rsp], rax
	call	"memset"@PLT
	test	r13d, r13d
	jle	.L36
	mov	edx, DWORD PTR 112[rsp]
	test	edx, edx
	jle	.L36
	mov	rax, QWORD PTR 64[rsp]
	mov	QWORD PTR 88[rsp], 0
	vxorps	xmm4, xmm4, xmm4
	xor	esi, esi
	vmovss	xmm19, DWORD PTR .LC1[rip]
	vmovss	xmm12, DWORD PTR .LC4[rip]
	mov	ebx, r13d
	lea	rdi, [rax+rax*2]
	lea	r14, 0[0+rax*8]
	mov	QWORD PTR 200[rsp], rdi
.L65:
	mov	rdi, QWORD PTR 88[rsp]
	mov	r11, QWORD PTR 64[rsp]
	mov	QWORD PTR 16[rsp], r12
	mov	QWORD PTR 8[rsp], r14
	lea	eax, 8[rdi]
	mov	DWORD PTR 60[rsp], edi
	cmp	eax, ebx
	mov	DWORD PTR 32[rsp], edi
	cmovg	eax, ebx
	mov	QWORD PTR 40[rsp], rsi
	mov	DWORD PTR 28[rsp], ebx
	xor	ebx, ebx
	mov	DWORD PTR 148[rsp], eax
	sub	eax, edi
	mov	DWORD PTR 36[rsp], eax
.L64:
	mov	edi, DWORD PTR 112[rsp]
	lea	eax, 256[rbx]
	mov	r14d, ebx
	cmp	eax, edi
	cmovg	eax, edi
	mov	ecx, eax
	mov	r15d, eax
	sub	ecx, ebx
	movsxd	rax, ecx
	mov	QWORD PTR 104[rsp], rax
	mov	eax, DWORD PTR 36[rsp]
	imul	eax, ecx
	lea	edx, [rax+rax*2]
	movsxd	rdx, edx
	sal	rdx, 2
	je	.L37
	mov	QWORD PTR 272[rsp], r11
	mov	rdi, QWORD PTR 240[rsp]
	xor	esi, esi
	mov	DWORD PTR 280[rsp], ecx
	vmovaps	XMMWORD PTR 256[rsp], xmm4
	vzeroupper
	call	"memset"@PLT
	mov	r11, QWORD PTR 272[rsp]
	vmovaps	xmm4, XMMWORD PTR 256[rsp]
	vmovss	xmm12, DWORD PTR .LC4[rip]
	vmovss	xmm19, DWORD PTR .LC1[rip]
	mov	ecx, DWORD PTR 280[rsp]
.L37:
	mov	rax, QWORD PTR 96[rsp]
	cmp	rax, QWORD PTR 152[rsp]
	je	.L38
	mov	rdx, rax
	mov	rax, QWORD PTR 104[rsp]
	mov	r12d, DWORD PTR 60[rsp]
	mov	DWORD PTR 172[rsp], r14d
	mov	DWORD PTR 56[rsp], ecx
	mov	rcx, rdx
	lea	rax, [rax+rax*2]
	mov	QWORD PTR 176[rsp], rax
	.p2align 4,,10
	.p2align 3
.L50:
	mov	eax, DWORD PTR 32[rcx]
	mov	edx, DWORD PTR 148[rsp]
	cmp	r12d, eax
	cmovge	eax, r12d
	mov	DWORD PTR 256[rsp], eax
	mov	edi, eax
	mov	eax, DWORD PTR 36[rcx]
	cmp	edx, eax
	cmovle	eax, edx
	mov	edx, DWORD PTR 24[rcx]
	mov	DWORD PTR 212[rsp], eax
	mov	esi, eax
	mov	eax, DWORD PTR 172[rsp]
	cmp	eax, edx
	cmovge	edx, eax
	mov	eax, DWORD PTR 28[rcx]
	cmp	r15d, eax
	cmovle	eax, r15d
	cmp	eax, edx
	jle	.L39
	cmp	esi, edi
	jle	.L39
	mov	r8d, edi
	mov	rdi, QWORD PTR 104[rsp]
	sub	eax, edx
	mov	r13, QWORD PTR 40[rcx]
	mov	r10, r8
	lea	esi, [rax+rax*2]
	mov	eax, edx
	vmovss	xmm18, DWORD PTR 8[rcx]
	sub	r10, QWORD PTR 88[rsp]
	mov	r9, rax
	mov	DWORD PTR 216[rsp], esi
	lea	rax, [rax+rax*2]
	imul	rdi, r10
	sub	r9, rbx
	mov	esi, DWORD PTR [rcx]
	sal	rax, 2
	vmovss	xmm17, DWORD PTR 12[rcx]
	vmovss	xmm16, DWORD PTR 16[rcx]
	mov	QWORD PTR 136[rsp], rbx
	vbroadcastss	ymm9, xmm18
	add	esi, edx
	sub	edx, DWORD PTR 172[rsp]
	vmovss	xmm15, DWORD PTR 20[rcx]
	mov	QWORD PTR 128[rsp], rcx
	add	rdi, r9
	movsxd	rsi, esi
	movsxd	rdx, edx
	mov	QWORD PTR 120[rsp], r11
	lea	r10, [rdi+rdi*2]
	movsxd	rdi, DWORD PTR 4[rcx]
	add	rdx, rbx
	mov	DWORD PTR 116[rsp], r12d
	mov	QWORD PTR 272[rsp], r10
	vbroadcastss	ymm10, xmm17
	vbroadcastss	ymm11, xmm16
	vbroadcastss	ymm8, xmm15
	add	rdi, r8
	mov	DWORD PTR 144[rsp], r15d
	vmovaps	ymm3, ymm9
	vmovaps	ymm2, ymm10
	imul	rdi, r11
	vmovaps	ymm1, ymm11
	vmovaps	ymm0, ymm8
	lea	r8, [rsi+rdi]
	add	rsi, r11
	add	rsi, rdi
	mov	edi, DWORD PTR 216[rsp]
	lea	r8, [r8+r8*2]
	lea	rsi, [rsi+rsi*2]
	lea	r14, [r8+r13]
	mov	r8, QWORD PTR 200[rsp]
	lea	r10, [rsi+r13]
	lea	rsi, [rdx+rdx*2]
	mov	rdx, QWORD PTR 240[rsp]
	sub	r8, r13
	sub	rdx, rax
	mov	QWORD PTR 192[rsp], r8
	lea	rax, [rdx+rsi*4]
	mov	QWORD PTR 184[rsp], rax
	lea	eax, -8[rdi]
	mov	edx, eax
	shr	eax, 3
	and	edx, -8
	inc	eax
	add	edx, 8
	lea	r15, 0[0+rax*8]
	sub	edi, edx
	mov	DWORD PTR 168[rsp], edx
	mov	DWORD PTR 208[rsp], edi
	mov	edi, edx
	mov	QWORD PTR 160[rsp], rdi
	.p2align 4,,10
	.p2align 3
.L49:
	mov	rax, QWORD PTR 192[rsp]
	mov	rbx, QWORD PTR 272[rsp]
	mov	r8, r14
	sub	r8, r13
	cmp	DWORD PTR 216[rsp], 7
	lea	rdi, [rax+r14]
	mov	rax, QWORD PTR 184[rsp]
	lea	rdx, [rax+rbx*4]
	jle	.L82
	xor	eax, eax
	.p2align 4,,10
	.p2align 3
.L41:
	vpmovzxbd	ymm13, QWORD PTR [r14+rax]
	vpmovzxbd	ymm7, QWORD PTR 3[rax+r14]
	vpmovzxbd	ymm6, QWORD PTR [r10+rax]
	vpmovzxbd	ymm5, QWORD PTR 3[r10+rax]
	vcvtdq2ps	ymm13, ymm13
	vfmadd213ps	ymm13, ymm3, YMMWORD PTR [rdx+rax*4]
	vcvtdq2ps	ymm7, ymm7
	vcvtdq2ps	ymm6, ymm6
	vcvtdq2ps	ymm5, ymm5
	vfmadd132ps	ymm7, ymm13, ymm2
	vfmadd132ps	ymm6, ymm7, ymm1
	vfmadd132ps	ymm5, ymm6, ymm0
	vmovups	YMMWORD PTR [rdx+rax*4], ymm5
	add	rax, 8
	cmp	rax, r15
	jne	.L41
	mov	eax, DWORD PTR 208[rsp]
	test	eax, eax
	jle	.L42
	mov	DWORD PTR 280[rsp], eax
	mov	eax, DWORD PTR 168[rsp]
	mov	rbx, QWORD PTR 160[rsp]
	mov	DWORD PTR 248[rsp], eax
	add	r8, rbx
	add	rdi, rbx
.L40:
	mov	r9d, DWORD PTR 280[rsp]
	mov	rax, QWORD PTR 272[rsp]
	mov	ebx, DWORD PTR 248[rsp]
	mov	r11, QWORD PTR 240[rsp]
	lea	r12, 3[r9+rdi]
	lea	rsi, [rax+rbx]
	add	r12, r13
	lea	rax, [r11+rsi*4]
	lea	rcx, [rsi+r9]
	mov	QWORD PTR 232[rsp], rsi
	cmp	rax, r12
	lea	r11, [r11+rcx*4]
	lea	rsi, 0[r13+r8]
	setnb	BYTE PTR 220[rsp]
	lea	rcx, 0[r13+rdi]
	cmp	rcx, r11
	mov	QWORD PTR 224[rsp], rsi
	movzx	esi, BYTE PTR 220[rsp]
	setnb	r12b
	or	sil, r12b
	je	.L43
	lea	r9, 3[r9+r8]
	mov	rsi, QWORD PTR 224[rsp]
	add	r9, r13
	cmp	rax, r9
	setnb	r9b
	cmp	rsi, r11
	setnb	r11b
	or	r9b, r11b
	je	.L43
	mov	ebx, DWORD PTR 280[rsp]
	lea	r9d, -1[rbx]
	cmp	r9d, 30
	jbe	.L83
	shr	ebx, 5
	lea	r11, 3[r13+r8]
	xor	r9d, r9d
	mov	r12d, ebx
	mov	DWORD PTR 224[rsp], ebx
	lea	rbx, 3[r13+rdi]
	sal	r12, 5
	.p2align 4,,10
	.p2align 3
.L45:
	vmovdqu	ymm5, YMMWORD PTR [rcx+r9]
	vmovdqu	ymm6, YMMWORD PTR [r11+r9]
	sub	rax, -128
	vmovdqu	ymm7, YMMWORD PTR [rsi+r9]
	vpmovzxbw	ymm13, xmm5
	vpmovzxbw	ymm14, xmm6
	vextracti32x4	xmm5, ymm5, 0x1
	vpmovsxwd	ymm21, xmm13
	vpmovsxwd	ymm20, xmm14
	vpmovzxbw	ymm5, xmm5
	vcvtdq2ps	ymm21, ymm21
	vmulps	ymm21, ymm21, ymm1
	vcvtdq2ps	ymm20, ymm20
	vextracti32x4	xmm6, ymm6, 0x1
	vpmovzxbw	ymm23, xmm7
	vpmovzxbw	ymm6, xmm6
	vpmovsxwd	ymm24, xmm23
	vextracti32x4	xmm7, ymm7, 0x1
	vcvtdq2ps	ymm24, ymm24
	vfmadd213ps	ymm24, ymm3, YMMWORD PTR -128[rax]
	vextracti32x4	xmm23, ymm23, 0x1
	vpmovzxbw	ymm7, xmm7
	vpmovsxwd	ymm23, xmm23
	vcvtdq2ps	ymm23, ymm23
	vfmadd213ps	ymm23, ymm3, YMMWORD PTR -96[rax]
	vfmadd132ps	ymm20, ymm21, ymm2
	vextracti32x4	xmm21, ymm14, 0x1
	vextracti32x4	xmm14, ymm13, 0x1
	vpmovsxwd	ymm14, xmm14
	vpmovsxwd	ymm21, xmm21
	vcvtdq2ps	ymm14, ymm14
	vmulps	ymm14, ymm14, ymm1
	vcvtdq2ps	ymm13, ymm21
	vpmovsxwd	ymm21, xmm6
	vextracti32x4	xmm6, ymm6, 0x1
	vpmovsxwd	ymm6, xmm6
	vcvtdq2ps	ymm21, ymm21
	vcvtdq2ps	ymm6, ymm6
	vfmadd132ps	ymm13, ymm14, ymm2
	vpmovsxwd	ymm14, xmm5
	vextracti32x4	xmm5, ymm5, 0x1
	vpmovsxwd	ymm5, xmm5
	vcvtdq2ps	ymm14, ymm14
	vcvtdq2ps	ymm5, ymm5
	vmulps	ymm5, ymm5, ymm1
	vmulps	ymm14, ymm14, ymm1
	vfmadd132ps	ymm6, ymm5, ymm2
	vmovdqu	ymm5, YMMWORD PTR [rbx+r9]
	add	r9, 32
	vfmadd132ps	ymm21, ymm14, ymm2
	vpmovzxbw	ymm14, xmm5
	vextracti32x4	xmm5, ymm5, 0x1
	vpmovsxwd	ymm22, xmm14
	vextracti32x4	xmm14, ymm14, 0x1
	vpmovzxbw	ymm5, xmm5
	vcvtdq2ps	ymm22, ymm22
	vfmadd132ps	ymm22, ymm24, ymm0
	vpmovsxwd	ymm24, xmm7
	vextracti32x4	xmm7, ymm7, 0x1
	vpmovsxwd	ymm7, xmm7
	vcvtdq2ps	ymm24, ymm24
	vfmadd213ps	ymm24, ymm3, YMMWORD PTR -64[rax]
	vpmovsxwd	ymm14, xmm14
	vcvtdq2ps	ymm7, ymm7
	vfmadd213ps	ymm7, ymm3, YMMWORD PTR -32[rax]
	vcvtdq2ps	ymm14, ymm14
	vfmadd132ps	ymm14, ymm23, ymm0
	vpmovsxwd	ymm23, xmm5
	vextracti32x4	xmm5, ymm5, 0x1
	vcvtdq2ps	ymm23, ymm23
	vpmovsxwd	ymm5, xmm5
	vcvtdq2ps	ymm5, ymm5
	vaddps	ymm22, ymm22, ymm20
	vfmadd132ps	ymm23, ymm24, ymm0
	vfmadd132ps	ymm5, ymm7, ymm0
	vaddps	ymm13, ymm13, ymm14
	vmovups	YMMWORD PTR -128[rax], ymm22
	vmovups	YMMWORD PTR -96[rax], ymm13
	vaddps	ymm21, ymm21, ymm23
	vaddps	ymm5, ymm5, ymm6
	vmovups	YMMWORD PTR -64[rax], ymm21
	vmovups	YMMWORD PTR -32[rax], ymm5
	cmp	r9, r12
	jne	.L45
	mov	r9d, DWORD PTR 224[rsp]
	sal	r9d, 5
	cmp	r9d, DWORD PTR 280[rsp]
	je	.L42
	mov	eax, r9d
.L44:
	mov	esi, DWORD PTR 280[rsp]
	sub	esi, r9d
	lea	ecx, -1[rsi]
	cmp	ecx, 14
	jbe	.L84
	mov	ecx, r9d
	mov	r12, QWORD PTR 240[rsp]
	lea	r11, [rcx+rdi]
	lea	rbx, [rcx+r8]
	add	rcx, QWORD PTR 232[rsp]
	vmovdqu	xmm5, XMMWORD PTR 0[r13+r11]
	vmovdqu	xmm6, XMMWORD PTR 3[r13+rbx]
	lea	rcx, [r12+rcx*4]
	vmovdqu	xmm7, XMMWORD PTR 0[r13+rbx]
	vpmovzxbw	xmm14, xmm5
	vpsrldq	xmm5, xmm5, 8
	vpmovzxbw	xmm13, xmm6
	vpmovsxwd	xmm20, xmm14
	vpsrldq	xmm14, xmm14, 8
	vpmovsxwd	xmm21, xmm13
	vpmovsxwd	xmm14, xmm14
	vpsrldq	xmm13, xmm13, 8
	vpmovzxbw	xmm5, xmm5
	vcvtdq2ps	xmm20, xmm20
	vcvtdq2ps	xmm21, xmm21
	vcvtdq2ps	xmm14, xmm14
	vmulps	xmm14, xmm14, xmm11
	vpmovsxwd	xmm13, xmm13
	vpmovzxbw	xmm22, xmm7
	vmulps	xmm20, xmm20, xmm11
	vcvtdq2ps	xmm13, xmm13
	vpsrldq	xmm6, xmm6, 8
	vpmovsxwd	xmm24, xmm22
	vcvtdq2ps	xmm24, xmm24
	vfmadd213ps	xmm24, xmm9, XMMWORD PTR [rcx]
	vpsrldq	xmm7, xmm7, 8
	vpmovzxbw	xmm6, xmm6
	vpsrldq	xmm22, xmm22, 8
	vpmovzxbw	xmm7, xmm7
	vpmovsxwd	xmm22, xmm22
	vfmadd132ps	xmm13, xmm14, xmm10
	vpmovsxwd	xmm14, xmm5
	vcvtdq2ps	xmm22, xmm22
	vpsrldq	xmm5, xmm5, 8
	vcvtdq2ps	xmm14, xmm14
	vfmadd132ps	xmm21, xmm20, xmm10
	vpmovsxwd	xmm20, xmm6
	vmulps	xmm14, xmm14, xmm11
	vpsrldq	xmm6, xmm6, 8
	vpmovsxwd	xmm5, xmm5
	vcvtdq2ps	xmm20, xmm20
	vcvtdq2ps	xmm5, xmm5
	vmulps	xmm5, xmm5, xmm11
	vfmadd213ps	xmm22, xmm9, XMMWORD PTR 16[rcx]
	vpmovsxwd	xmm6, xmm6
	vcvtdq2ps	xmm6, xmm6
	vfmadd132ps	xmm20, xmm14, xmm10
	vfmadd132ps	xmm6, xmm5, xmm10
	vmovdqu	xmm5, XMMWORD PTR 3[r13+r11]
	vpmovzxbw	xmm14, xmm5
	vpsrldq	xmm5, xmm5, 8
	vpmovsxwd	xmm23, xmm14
	vpsrldq	xmm14, xmm14, 8
	vpmovzxbw	xmm5, xmm5
	vcvtdq2ps	xmm23, xmm23
	vfmadd132ps	xmm23, xmm24, xmm8
	vpmovsxwd	xmm24, xmm7
	vpmovsxwd	xmm14, xmm14
	vpsrldq	xmm7, xmm7, 8
	vcvtdq2ps	xmm24, xmm24
	vfmadd213ps	xmm24, xmm9, XMMWORD PTR 32[rcx]
	vcvtdq2ps	xmm14, xmm14
	vpmovsxwd	xmm7, xmm7
	vfmadd132ps	xmm14, xmm22, xmm8
	vpmovsxwd	xmm22, xmm5
	vcvtdq2ps	xmm7, xmm7
	vfmadd213ps	xmm7, xmm9, XMMWORD PTR 48[rcx]
	vpsrldq	xmm5, xmm5, 8
	vcvtdq2ps	xmm22, xmm22
	vpmovsxwd	xmm5, xmm5
	vcvtdq2ps	xmm5, xmm5
	vaddps	xmm21, xmm21, xmm23
	vfmadd132ps	xmm22, xmm24, xmm8
	vaddps	xmm13, xmm13, xmm14
	vfmadd132ps	xmm5, xmm7, xmm8
	vmovups	XMMWORD PTR [rcx], xmm21
	vmovups	XMMWORD PTR 16[rcx], xmm13
	vaddps	xmm20, xmm20, xmm22
	vaddps	xmm5, xmm5, xmm6
	vmovups	XMMWORD PTR 32[rcx], xmm20
	vmovups	XMMWORD PTR 48[rcx], xmm5
	mov	ecx, esi
	and	ecx, -16
	test	sil, 15
	je	.L42
	add	eax, ecx
.L46:
	sub	esi, ecx
	lea	r11d, -1[rsi]
	cmp	r11d, 6
	jbe	.L47
	add	ecx, r9d
	mov	r9, QWORD PTR 232[rsp]
	mov	ecx, ecx
	lea	rbx, [r8+rcx]
	lea	r11, [rdi+rcx]
	add	rcx, r9
	mov	r9, QWORD PTR 240[rsp]
	vmovq	xmm5, QWORD PTR 0[r13+rbx]
	vmovq	xmm6, QWORD PTR 3[r13+rbx]
	lea	r9, [r9+rcx*4]
	vpmovzxbw	xmm7, xmm5
	vpsrlq	xmm5, xmm5, 32
	vpmovzxbw	xmm13, xmm6
	vmovq	r12, xmm7
	vpmovzxbw	xmm7, xmm5
	vmovq	xmm5, QWORD PTR 0[r13+r11]
	vpmovzxwd	xmm14, xmm13
	vmovq	rcx, xmm7
	vpsrlq	xmm13, xmm13, 32
	vmovq	xmm14, xmm14
	vpmovzxbw	xmm7, xmm5
	vcvtdq2ps	xmm21, xmm14
	vpsrlq	xmm5, xmm5, 32
	vpmovzxwd	xmm13, xmm13
	vpmovzxwd	xmm14, xmm7
	vpsrlq	xmm7, xmm7, 32
	vmovq	xmm13, xmm13
	vpmovzxwd	xmm7, xmm7
	vcvtdq2ps	xmm13, xmm13
	vpmovzxbw	xmm5, xmm5
	vmovq	xmm20, xmm14
	vmovq	xmm7, xmm7
	vpsrlq	xmm6, xmm6, 32
	vcvtdq2ps	xmm20, xmm20
	vcvtdq2ps	xmm7, xmm7
	vmulps	xmm7, xmm7, xmm11
	vpmovzxbw	xmm6, xmm6
	vmulps	xmm20, xmm20, xmm11
	vfmadd132ps	xmm13, xmm7, xmm10
	vpmovzxwd	xmm7, xmm6
	vpsrlq	xmm6, xmm6, 32
	vfmadd132ps	xmm21, xmm20, xmm10
	vmovq	xmm7, xmm7
	vpmovzxwd	xmm6, xmm6
	vcvtdq2ps	xmm14, xmm7
	vmovq	xmm7, QWORD PTR 3[r13+r11]
	vmovq	xmm6, xmm6
	vcvtdq2ps	xmm6, xmm6
	vmovaps	xmm23, xmm13
	vpmovzxwd	xmm13, xmm5
	vpsrlq	xmm5, xmm5, 32
	vmovq	xmm13, xmm13
	vpmovzxwd	xmm5, xmm5
	vcvtdq2ps	xmm13, xmm13
	vmulps	xmm13, xmm13, xmm11
	vmovq	xmm5, xmm5
	vcvtdq2ps	xmm5, xmm5
	vmulps	xmm5, xmm5, xmm11
	vfmadd132ps	xmm14, xmm13, xmm10
	vmovq	xmm13, QWORD PTR [r9]
	vfmadd132ps	xmm6, xmm5, xmm10
	vpmovzxbw	xmm5, xmm7
	vpsrlq	xmm7, xmm7, 32
	vpmovzxbw	xmm7, xmm7
	vmovaps	xmm25, xmm14
	vmovaps	xmm20, xmm6
	vpmovzxwd	xmm6, xmm5
	vmovq	xmm6, xmm6
	vpsrlq	xmm5, xmm5, 32
	vcvtdq2ps	xmm14, xmm6
	vmovq	xmm6, r12
	vpmovzxwd	xmm5, xmm5
	vpmovzxwd	xmm6, xmm6
	vmovq	xmm24, xmm5
	vpmovzxwd	xmm5, xmm7
	vmovq	xmm6, xmm6
	vcvtdq2ps	xmm24, xmm24
	vpsrlq	xmm7, xmm7, 32
	vmovq	xmm5, xmm5
	vcvtdq2ps	xmm6, xmm6
	vfmadd231ps	xmm13, xmm9, xmm6
	vmovq	xmm6, r12
	vcvtdq2ps	xmm5, xmm5
	vpmovzxwd	xmm7, xmm7
	vpsrlq	xmm6, xmm6, 32
	vmovq	xmm7, xmm7
	vpmovzxwd	xmm6, xmm6
	vcvtdq2ps	xmm7, xmm7
	vmovq	xmm6, xmm6
	vcvtdq2ps	xmm6, xmm6
	vfmadd132ps	xmm14, xmm13, xmm8
	vmovq	xmm13, QWORD PTR 8[r9]
	vfmadd132ps	xmm6, xmm13, xmm9
	vmovaps	xmm22, xmm14
	vmovq	xmm14, QWORD PTR 16[r9]
	vfmadd132ps	xmm24, xmm6, xmm8
	vmovq	xmm6, rcx
	mov	ecx, esi
	vpmovzxwd	xmm13, xmm6
	and	ecx, -8
	and	esi, 7
	vmovq	xmm13, xmm13
	vcvtdq2ps	xmm13, xmm13
	vfmadd132ps	xmm13, xmm14, xmm9
	vmovq	xmm14, QWORD PTR 24[r9]
	vfmadd132ps	xmm5, xmm13, xmm8
	vpsrlq	xmm13, xmm6, 32
	vpmovzxwd	xmm13, xmm13
	vmovq	xmm13, xmm13
	vcvtdq2ps	xmm13, xmm13
	vfmadd132ps	xmm13, xmm14, xmm9
	vaddps	xmm5, xmm25, xmm5
	vfmadd132ps	xmm7, xmm13, xmm8
	vaddps	xmm13, xmm21, xmm22
	vmovlps	QWORD PTR 16[r9], xmm5
	vmovlps	QWORD PTR [r9], xmm13
	vaddps	xmm14, xmm7, xmm20
	vaddps	xmm7, xmm23, xmm24
	vmovlps	QWORD PTR 24[r9], xmm14
	vmovlps	QWORD PTR 8[r9], xmm7
	je	.L42
	add	eax, ecx
.L47:
	movsxd	rcx, eax
	mov	ebx, DWORD PTR 248[rsp]
	mov	r12d, DWORD PTR 280[rsp]
	lea	r9, [rcx+r8]
	add	rcx, rdi
	movzx	r11d, BYTE PTR 0[r13+r9]
	movzx	r9d, BYTE PTR 3[r13+r9]
	lea	esi, [rbx+rax]
	vcvtusi2ss	xmm5, xmm4, r11d
	vmovaps	xmm7, xmm5
	vcvtusi2ss	xmm5, xmm4, r9d
	movzx	r9d, BYTE PTR 0[r13+rcx]
	movzx	ecx, BYTE PTR 3[r13+rcx]
	vfmadd213ss	xmm7, xmm18, DWORD PTR [rdx+rsi*4]
	vcvtusi2ss	xmm6, xmm4, r9d
	vmulss	xmm6, xmm6, xmm16
	vfmadd231ss	xmm6, xmm17, xmm5
	vcvtusi2ss	xmm5, xmm4, ecx
	vfmadd132ss	xmm5, xmm7, xmm15
	vaddss	xmm5, xmm5, xmm6
	vmovss	DWORD PTR [rdx+rsi*4], xmm5
	lea	esi, 1[rax]
	cmp	esi, r12d
	jge	.L42
	mov	ecx, esi
	add	esi, ebx
	lea	r9, [rcx+r8]
	add	rcx, rdi
	mov	esi, esi
	movzx	r11d, BYTE PTR 0[r13+r9]
	movzx	r9d, BYTE PTR 3[r13+r9]
	vcvtusi2ss	xmm5, xmm4, r11d
	vmovaps	xmm7, xmm5
	vcvtusi2ss	xmm5, xmm4, r9d
	movzx	r9d, BYTE PTR 0[r13+rcx]
	movzx	ecx, BYTE PTR 3[r13+rcx]
	vfmadd213ss	xmm7, xmm18, DWORD PTR [rdx+rsi*4]
	vcvtusi2ss	xmm6, xmm4, r9d
	vmulss	xmm6, xmm6, xmm16
	vfmadd231ss	xmm6, xmm17, xmm5
	vcvtusi2ss	xmm5, xmm4, ecx
	vfmadd132ss	xmm5, xmm7, xmm15
	vaddss	xmm5, xmm5, xmm6
	vmovss	DWORD PTR [rdx+rsi*4], xmm5
	lea	esi, 2[rax]
	cmp	esi, r12d
	jge	.L42
	mov	ecx, esi
	add	esi, ebx
	lea	r9, [rcx+r8]
	add	rcx, rdi
	mov	esi, esi
	movzx	r11d, BYTE PTR 0[r13+r9]
	movzx	r9d, BYTE PTR 3[r13+r9]
	vcvtusi2ss	xmm5, xmm4, r11d
	vmovaps	xmm7, xmm5
	vcvtusi2ss	xmm5, xmm4, r9d
	movzx	r9d, BYTE PTR 0[r13+rcx]
	movzx	ecx, BYTE PTR 3[r13+rcx]
	vfmadd213ss	xmm7, xmm18, DWORD PTR [rdx+rsi*4]
	vcvtusi2ss	xmm6, xmm4, r9d
	vmulss	xmm6, xmm6, xmm16
	vfmadd231ss	xmm6, xmm17, xmm5
	vcvtusi2ss	xmm5, xmm4, ecx
	vfmadd132ss	xmm5, xmm7, xmm15
	vaddss	xmm5, xmm5, xmm6
	vmovss	DWORD PTR [rdx+rsi*4], xmm5
	lea	esi, 3[rax]
	cmp	esi, r12d
	jge	.L42
	mov	ecx, esi
	add	esi, ebx
	lea	r9, [rcx+r8]
	add	rcx, rdi
	mov	esi, esi
	movzx	r11d, BYTE PTR 0[r13+r9]
	movzx	r9d, BYTE PTR 3[r13+r9]
	vcvtusi2ss	xmm5, xmm4, r11d
	vmovaps	xmm7, xmm5
	vcvtusi2ss	xmm5, xmm4, r9d
	movzx	r9d, BYTE PTR 0[r13+rcx]
	movzx	ecx, BYTE PTR 3[r13+rcx]
	vfmadd213ss	xmm7, xmm18, DWORD PTR [rdx+rsi*4]
	vcvtusi2ss	xmm6, xmm4, r9d
	vmulss	xmm6, xmm6, xmm16
	vfmadd231ss	xmm6, xmm17, xmm5
	vcvtusi2ss	xmm5, xmm4, ecx
	vfmadd132ss	xmm5, xmm7, xmm15
	vaddss	xmm5, xmm5, xmm6
	vmovss	DWORD PTR [rdx+rsi*4], xmm5
	lea	esi, 4[rax]
	cmp	esi, r12d
	jge	.L42
	mov	ecx, esi
	add	esi, ebx
	lea	r9, [rcx+r8]
	add	rcx, rdi
	mov	esi, esi
	movzx	r11d, BYTE PTR 0[r13+r9]
	movzx	r9d, BYTE PTR 3[r13+r9]
	vcvtusi2ss	xmm5, xmm4, r11d
	vmovaps	xmm7, xmm5
	vcvtusi2ss	xmm5, xmm4, r9d
	movzx	r9d, BYTE PTR 0[r13+rcx]
	movzx	ecx, BYTE PTR 3[r13+rcx]
	vfmadd213ss	xmm7, xmm18, DWORD PTR [rdx+rsi*4]
	vcvtusi2ss	xmm6, xmm4, r9d
	vmulss	xmm6, xmm6, xmm16
	vfmadd231ss	xmm6, xmm17, xmm5
	vcvtusi2ss	xmm5, xmm4, ecx
	vfmadd132ss	xmm5, xmm7, xmm15
	vaddss	xmm5, xmm5, xmm6
	vmovss	DWORD PTR [rdx+rsi*4], xmm5
	lea	esi, 5[rax]
	cmp	r12d, esi
	jle	.L42
	mov	ecx, esi
	add	esi, ebx
	add	eax, 6
	lea	r9, [r8+rcx]
	add	rcx, rdi
	mov	esi, esi
	movzx	r11d, BYTE PTR 0[r13+r9]
	movzx	r9d, BYTE PTR 3[r13+r9]
	vcvtusi2ss	xmm5, xmm4, r11d
	vmovaps	xmm7, xmm5
	vcvtusi2ss	xmm5, xmm4, r9d
	movzx	r9d, BYTE PTR 0[r13+rcx]
	movzx	ecx, BYTE PTR 3[r13+rcx]
	vfmadd213ss	xmm7, xmm18, DWORD PTR [rdx+rsi*4]
	vcvtusi2ss	xmm6, xmm4, r9d
	vmulss	xmm6, xmm6, xmm16
	vfmadd231ss	xmm6, xmm17, xmm5
	vcvtusi2ss	xmm5, xmm4, ecx
	vfmadd132ss	xmm5, xmm7, xmm15
	vaddss	xmm5, xmm5, xmm6
	vmovss	DWORD PTR [rdx+rsi*4], xmm5
	cmp	r12d, eax
	jle	.L42
	mov	ecx, eax
	add	eax, ebx
	add	r8, rcx
	mov	eax, eax
	add	rdi, rcx
	lea	rax, [rdx+rax*4]
	movzx	edx, BYTE PTR 0[r13+r8]
	vcvtusi2ss	xmm5, xmm4, edx
	movzx	edx, BYTE PTR 3[r13+r8]
	vmovaps	xmm7, xmm5
	vcvtusi2ss	xmm5, xmm4, edx
	movzx	edx, BYTE PTR 0[r13+rdi]
	vfmadd213ss	xmm7, xmm18, DWORD PTR [rax]
	vcvtusi2ss	xmm6, xmm4, edx
	movzx	edx, BYTE PTR 3[r13+rdi]
	vmulss	xmm6, xmm6, xmm16
	vfmadd231ss	xmm6, xmm17, xmm5
	vcvtusi2ss	xmm5, xmm4, edx
	vfmadd132ss	xmm5, xmm7, xmm15
	vaddss	xmm5, xmm5, xmm6
	vmovss	DWORD PTR [rax], xmm5
.L42:
	inc	DWORD PTR 256[rsp]
	mov	rdi, QWORD PTR 200[rsp]
	mov	rdx, QWORD PTR 176[rsp]
	add	r14, rdi
	add	r10, rdi
	add	QWORD PTR 272[rsp], rdx
	mov	eax, DWORD PTR 256[rsp]
	cmp	eax, DWORD PTR 212[rsp]
	jl	.L49
	mov	rbx, QWORD PTR 136[rsp]
	mov	rcx, QWORD PTR 128[rsp]
	mov	r11, QWORD PTR 120[rsp]
	mov	r15d, DWORD PTR 144[rsp]
	mov	r12d, DWORD PTR 116[rsp]
.L39:
	add	rcx, 48
	cmp	QWORD PTR 152[rsp], rcx
	jne	.L50
	mov	ecx, DWORD PTR 56[rsp]
.L38:
	mov	r12d, DWORD PTR 148[rsp]
	cmp	r12d, DWORD PTR 32[rsp]
	jle	.L51
	test	ecx, ecx
	jle	.L51
	mov	rax, QWORD PTR 104[rsp]
	mov	rdi, QWORD PTR 240[rsp]
	lea	r8d, [rcx+rcx*2]
	mov	r9, QWORD PTR 40[rsp]
	mov	r10d, DWORD PTR 60[rsp]
	lea	rax, [rax+rax*2]
	vmovss	xmm3, DWORD PTR .LC5[rip]
	vmovss	xmm6, DWORD PTR .LC6[rip]
	lea	r14, 0[0+rax*4]
	mov	rax, QWORD PTR 80[rsp]
	mov	r15, QWORD PTR 72[rsp]
	lea	r13, [rax+rbx*4]
	.p2align 4,,10
	.p2align 3
.L63:
	lea	rax, [rbx+r9]
	mov	QWORD PTR 280[rsp], r9
	vmovss	xmm2, DWORD PTR .LC6[rip]
	lea	rcx, 0[r13+r9*4]
	lea	rsi, [rax+rax*2]
	vmovss	xmm5, DWORD PTR .LC5[rip]
	xor	edx, edx
	add	rsi, QWORD PTR 16[r15]
	.p2align 4,,10
	.p2align 3
.L62:
	mov	eax, DWORD PTR [rcx]
	test	eax, eax
	je	.L52
	vcvtsi2ss	xmm0, xmm4, eax
	mov	eax, edx
	xor	r9d, r9d
	vdivss	xmm0, xmm19, xmm0
	vmulss	xmm1, xmm0, DWORD PTR [rdi+rax*4]
	vcomiss	xmm12, xmm1
	ja	.L61
	vaddss	xmm1, xmm1, xmm3
	vminss	xmm1, xmm1, xmm6
	vcvttss2si	r9d, xmm1
.L61:
	vmulss	xmm1, xmm0, DWORD PTR 4[rdi+rax*4]
	mov	BYTE PTR [rsi+rax], r9b
	xor	r9d, r9d
	vcomiss	xmm12, xmm1
	ja	.L60
	vaddss	xmm1, xmm1, xmm3
	vminss	xmm1, xmm1, xmm2
	vcvttss2si	r9d, xmm1
.L60:
	vmulss	xmm0, xmm0, DWORD PTR 8[rdi+rax*4]
	mov	BYTE PTR 1[rsi+rax], r9b
	xor	r9d, r9d
	vcomiss	xmm12, xmm0
	ja	.L59
	vaddss	xmm0, xmm0, xmm5
	vminss	xmm0, xmm0, xmm2
	vcvttss2si	r9d, xmm0
.L59:
	mov	BYTE PTR 2[rsi+rax], r9b
.L52:
	add	edx, 3
	add	rcx, 4
	cmp	r8d, edx
	jne	.L62
	mov	r9, QWORD PTR 280[rsp]
	inc	r10d
	add	rdi, r14
	add	r9, r11
	cmp	r12d, r10d
	jne	.L63
.L51:
	add	rbx, 256
	cmp	DWORD PTR 112[rsp], ebx
	jg	.L64
	add	QWORD PTR 88[rsp], 8
	mov	r14, QWORD PTR 8[rsp]
	mov	rsi, QWORD PTR 40[rsp]
	mov	ebx, DWORD PTR 28[rsp]
	mov	r12, QWORD PTR 16[rsp]
	add	rsi, r14
	cmp	ebx, DWORD PTR 88[rsp]
	jg	.L65
	vzeroupper
.L36:
	mov	rdi, QWORD PTR 240[rsp]
	mov	esi, 24576
	call	"_ZdlPvm"@PLT
	mov	rax, QWORD PTR 80[rsp]
	test	rax, rax
	je	.L66
	mov	rsi, r12
	mov	rdi, rax
	call	"_ZdlPvm"@PLT
.L66:
	mov	rax, QWORD PTR 96[rsp]
	test	rax, rax
	je	.L1
	mov	rsi, QWORD PTR 48[rsp]
	mov	rdi, rax
	call	"_ZdlPvm"@PLT
.L1:
	mov	rax, QWORD PTR 72[rsp]
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
.L43:
	.cfi_restore_state
	mov	rsi, QWORD PTR 224[rsp]
	mov	edi, DWORD PTR 280[rsp]
	lea	rdx, [rdx+rbx*4]
	xor	eax, eax
	.p2align 4,,10
	.p2align 3
.L48:
	movzx	r8d, BYTE PTR [rsi+rax]
	vcvtusi2ss	xmm5, xmm4, r8d
	movzx	r8d, BYTE PTR 3[rsi+rax]
	vmovaps	xmm7, xmm5
	vcvtusi2ss	xmm5, xmm4, r8d
	movzx	r8d, BYTE PTR [rcx+rax]
	vfmadd213ss	xmm7, xmm18, DWORD PTR [rdx+rax*4]
	vcvtusi2ss	xmm6, xmm4, r8d
	movzx	r8d, BYTE PTR 3[rcx+rax]
	vmulss	xmm6, xmm6, xmm16
	vfmadd231ss	xmm6, xmm17, xmm5
	vcvtusi2ss	xmm5, xmm4, r8d
	vfmadd132ss	xmm5, xmm7, xmm15
	vaddss	xmm5, xmm5, xmm6
	vmovss	DWORD PTR [rdx+rax*4], xmm5
	inc	rax
	cmp	edi, eax
	jg	.L48
	jmp	.L42
	.p2align 4,,10
	.p2align 3
.L82:
	mov	eax, DWORD PTR 216[rsp]
	mov	DWORD PTR 248[rsp], 0
	mov	DWORD PTR 280[rsp], eax
	jmp	.L40
.L83:
	xor	r9d, r9d
	xor	eax, eax
	jmp	.L44
.L84:
	xor	ecx, ecx
	jmp	.L46
.L162:
	mov	rdx, QWORD PTR 152[rsp]
	xor	edi, edi
	cmp	QWORD PTR 96[rsp], rdx
	jne	.L25
	test	r13d, r13d
	jle	.L26
	mov	esi, DWORD PTR 112[rsp]
	test	esi, esi
	jg	.L27
	jmp	.L26
	.p2align 4,,10
	.p2align 3
.L161:
	mov	QWORD PTR 96[rsp], 0
	mov	r13d, esi
	xor	r15d, r15d
	vmovd	DWORD PTR 112[rsp], xmm0
	cmp	rbx, rdi
	jne	.L5
	mov	QWORD PTR 152[rsp], 0
.L79:
	mov	QWORD PTR 80[rsp], 0
	jmp	.L20
.L13:
	mov	rax, r15
	sub	rax, r14
	mov	QWORD PTR 256[rsp], rax
	sar	rax, 4
	mov	rdx, rax
	movabs	rax, -6148914691236517205
	imul	rdx, rax
	movabs	rax, 192153584101141162
	cmp	rdx, rax
	je	.L152
	test	rdx, rdx
	mov	eax, 1
	mov	DWORD PTR 160[rsp], r11d
	cmovne	rax, rdx
	mov	DWORD PTR 172[rsp], ecx
	mov	DWORD PTR 208[rsp], r9d
	add	rax, rdx
	movabs	rdx, 192153584101141162
	mov	DWORD PTR 176[rsp], r8d
	cmp	rax, rdx
	mov	DWORD PTR 216[rsp], esi
	cmova	rax, rdx
	mov	DWORD PTR 220[rsp], r10d
	vmovss	DWORD PTR 184[rsp], xmm3
	lea	rax, [rax+rax*2]
	vmovss	DWORD PTR 192[rsp], xmm0
	sal	rax, 4
	vmovss	DWORD PTR 200[rsp], xmm1
	mov	rdi, rax
	mov	QWORD PTR 232[rsp], rax
	vmovss	DWORD PTR 212[rsp], xmm2
.LEHB3:
	call	"_Znwm"@PLT
.LEHE3:
	mov	rdx, QWORD PTR 256[rsp]
	mov	esi, DWORD PTR 216[rsp]
	mov	QWORD PTR 248[rsp], rax
	mov	rdi, rax
	vmovss	xmm0, DWORD PTR 192[rsp]
	vmovss	xmm2, DWORD PTR 212[rsp]
	mov	r10d, DWORD PTR 220[rsp]
	mov	r8d, DWORD PTR 176[rsp]
	mov	DWORD PTR 4[rax+rdx], esi
	vinsertps	xmm0, xmm0, DWORD PTR 184[rsp], 0x10
	vinsertps	xmm2, xmm2, DWORD PTR 200[rsp], 0x10
	mov	ecx, DWORD PTR 172[rsp]
	mov	r9d, DWORD PTR 208[rsp]
	mov	DWORD PTR [rax+rdx], r10d
	mov	r11d, DWORD PTR 160[rsp]
	mov	rsi, QWORD PTR 240[rsp]
	vmovlhps	xmm2, xmm2, xmm0
	mov	DWORD PTR 24[rax+rdx], r8d
	mov	DWORD PTR 28[rax+rdx], ecx
	mov	DWORD PTR 32[rax+rdx], r9d
	mov	DWORD PTR 36[rax+rdx], r11d
	mov	QWORD PTR 40[rax+rdx], rsi
	vmovups	XMMWORD PTR 8[rax+rdx], xmm2
	test	rdx, rdx
	je	.L17
	mov	rsi, r14
	call	"memcpy"@PLT
.L17:
	mov	rax, QWORD PTR 248[rsp]
	mov	rdi, QWORD PTR 256[rsp]
	lea	rax, 48[rax+rdi]
	mov	QWORD PTR 96[rsp], rax
	test	r14, r14
	je	.L18
	mov	rsi, r15
	mov	rdi, r14
	sub	rsi, r14
	call	"_ZdlPvm"@PLT
.L18:
	mov	r15, QWORD PTR 232[rsp]
	mov	r14, QWORD PTR 248[rsp]
	add	r15, r14
	jmp	.L12
.L2:
	lea	r14, [r12+r12*2]
	test	r14, r14
	js	.L151
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
	mov	rax, QWORD PTR 72[rsp]
	mov	QWORD PTR 16[rax], rcx
	mov	QWORD PTR 24[rax], r15
	mov	QWORD PTR 32[rax], r15
	mov	rax, QWORD PTR 8[r13]
	mov	QWORD PTR 280[rsp], rax
	sub	rax, rbx
	mov	QWORD PTR 48[rsp], rax
	jne	.L4
	mov	QWORD PTR 96[rsp], 0
	xor	r15d, r15d
	jmp	.L8
.L28:
	test	r13d, r13d
	jle	.L32
	mov	eax, DWORD PTR 112[rsp]
	test	eax, eax
	jg	.L27
	jmp	.L32
.L76:
	mov	rax, QWORD PTR 96[rsp]
	mov	QWORD PTR 152[rsp], rax
	jmp	.L9
.L145:
	jmp	.L146
.L147:
	jmp	.L148
.L89:
	mov	rbx, rax
	vzeroupper
	jmp	.L16
.L149:
	jmp	.L150
	.section	.gcc_except_table,"a",@progbits
.LLSDA11708:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSE11708-.LLSDACSB11708
.LLSDACSB11708:
	.uleb128 .LEHB0-.LFB11708
	.uleb128 .LEHE0-.LEHB0
	.uleb128 .L145-.LFB11708
	.uleb128 0
	.uleb128 .LEHB1-.LFB11708
	.uleb128 .LEHE1-.LEHB1
	.uleb128 .L89-.LFB11708
	.uleb128 0
	.uleb128 .LEHB2-.LFB11708
	.uleb128 .LEHE2-.LEHB2
	.uleb128 .L147-.LFB11708
	.uleb128 0
	.uleb128 .LEHB3-.LFB11708
	.uleb128 .LEHE3-.LEHB3
	.uleb128 .L149-.LFB11708
	.uleb128 0
	.uleb128 .LEHB4-.LFB11708
	.uleb128 .LEHE4-.LEHB4
	.uleb128 .L145-.LFB11708
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
.L153:
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
.L86:
	mov	rbx, rax
	vzeroupper
.L16:
	cmp	QWORD PTR 96[rsp], 0
	je	.L71
	mov	rdi, QWORD PTR 96[rsp]
	mov	rsi, r15
	sub	rsi, rdi
	call	"_ZdlPvm"@PLT
	jmp	.L71
.L85:
.L146:
	mov	rbx, rax
	vzeroupper
.L71:
	mov	rax, QWORD PTR 72[rsp]
	mov	rdi, QWORD PTR 16[rax]
	test	rdi, rdi
	je	.L72
	mov	rsi, QWORD PTR 32[rax]
	sub	rsi, rdi
	call	"_ZdlPvm"@PLT
.L72:
	mov	rdi, rbx
.LEHB6:
	call	"_Unwind_Resume"@PLT
.LEHE6:
.L151:
	lea	rdi, .LC0[rip]
.LEHB7:
	call	"_ZSt20__throw_length_errorPKc"@PLT
.LEHE7:
.L87:
.L148:
	cmp	QWORD PTR 80[rsp], 0
	mov	rbx, rax
	je	.L158
	mov	rdi, QWORD PTR 80[rsp]
	mov	rsi, r12
	vzeroupper
	call	"_ZdlPvm"@PLT
	jmp	.L16
.L158:
	vzeroupper
	jmp	.L16
.L152:
	lea	rdi, .LC2[rip]
.LEHB8:
	call	"_ZSt20__throw_length_errorPKc"@PLT
.LEHE8:
.L154:
	lea	rdi, .LC0[rip]
.LEHB9:
	call	"_ZSt20__throw_length_errorPKc"@PLT
.LEHE9:
.L88:
.L150:
	mov	QWORD PTR 96[rsp], r14
	mov	rbx, rax
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
	.uleb128 .LEHB5-.LCOLDB8
	.uleb128 .LEHE5-.LEHB5
	.uleb128 .L86-.LCOLDB8
	.uleb128 0
	.uleb128 .LEHB6-.LCOLDB8
	.uleb128 .LEHE6-.LEHB6
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB7-.LCOLDB8
	.uleb128 .LEHE7-.LEHB7
	.uleb128 .L85-.LCOLDB8
	.uleb128 0
	.uleb128 .LEHB8-.LCOLDB8
	.uleb128 .LEHE8-.LEHB8
	.uleb128 .L88-.LCOLDB8
	.uleb128 0
	.uleb128 .LEHB9-.LCOLDB8
	.uleb128 .LEHE9-.LEHB9
	.uleb128 .L87-.LCOLDB8
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
