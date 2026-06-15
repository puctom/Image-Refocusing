	.file	"opt17.cpp"
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
	push	r12
	.cfi_offset 15, -24
	.cfi_offset 14, -32
	.cfi_offset 13, -40
	.cfi_offset 12, -48
	mov	r12, rsi
	push	rbx
	and	rsp, -32
	sub	rsp, 512
	.cfi_offset 3, -56
	mov	r14, QWORD PTR [rsi]
	vmovss	DWORD PTR 472[rsp], xmm0
	mov	QWORD PTR 64[rsp], rdi
	vmovdqu	xmm0, XMMWORD PTR [r14]
	mov	QWORD PTR 32[rdi], 0
	vmovdqu	XMMWORD PTR 16[rdi], xmm1
	vpextrq	rbx, xmm0, 1
	vmovq	rax, xmm0
	vmovq	QWORD PTR 184[rsp], xmm0
	imul	rax, rbx
	mov	QWORD PTR 488[rsp], rbx
	vmovdqu	XMMWORD PTR [rdi], xmm0
	mov	QWORD PTR 56[rsp], rax
	test	rax, rax
	jne	.L2
	mov	rax, QWORD PTR 8[rsi]
	mov	QWORD PTR 496[rsp], rax
	sub	rax, r14
	mov	r12, rax
	je	.L223
.L4:
	mov	rdi, r12
.LEHB0:
	call	"_Znwm"@PLT
.LEHE0:
	mov	QWORD PTR 128[rsp], rax
	lea	r15, [rax+r12]
.L8:
	mov	eax, DWORD PTR 184[rsp]
	mov	DWORD PTR 144[rsp], eax
	mov	eax, DWORD PTR 488[rsp]
	mov	DWORD PTR 92[rsp], eax
	cmp	QWORD PTR 496[rsp], r14
	je	.L110
.L5:
	mov	rax, QWORD PTR 128[rsp]
	mov	QWORD PTR 208[rsp], rax
.L19:
	vmovss	xmm7, DWORD PTR 472[rsp]
	mov	ebx, DWORD PTR 144[rsp]
	xor	ecx, ecx
	vmulss	xmm4, xmm7, DWORD PTR 40[r14]
	vmulss	xmm2, xmm7, DWORD PTR 44[r14]
	vrndscaless	xmm0, xmm4, xmm4, 9
	vcvttss2si	r9d, xmm0
	vrndscaless	xmm1, xmm2, xmm2, 9
	vcvttss2si	esi, xmm1
	mov	eax, r9d
	neg	eax
	test	r9d, r9d
	cmovs	ecx, eax
	mov	eax, ebx
	sub	eax, r9d
	dec	eax
	cmp	eax, ebx
	cmovg	eax, ebx
	mov	ebx, DWORD PTR 92[rsp]
	xor	r8d, r8d
	mov	r10d, eax
	mov	eax, esi
	neg	eax
	test	esi, esi
	cmovs	r8d, eax
	mov	eax, ebx
	sub	eax, esi
	dec	eax
	cmp	eax, ebx
	cmovg	eax, ebx
	mov	r11d, eax
	cmp	ecx, r10d
	jge	.L12
	cmp	r8d, eax
	jge	.L12
	vsubss	xmm5, xmm2, xmm1
	vsubss	xmm3, xmm4, xmm0
	mov	rax, QWORD PTR 208[rsp]
	mov	rbx, QWORD PTR 16[r14]
	vaddss	xmm0, xmm0, DWORD PTR .LC1[rip]
	vaddss	xmm1, xmm1, DWORD PTR .LC1[rip]
	vsubss	xmm0, xmm0, xmm4
	vsubss	xmm1, xmm1, xmm2
	vmulss	xmm2, xmm0, xmm1
	vmulss	xmm1, xmm1, xmm3
	vmulss	xmm0, xmm0, xmm5
	vmulss	xmm3, xmm3, xmm5
	cmp	rax, r15
	je	.L13
	vunpcklps	xmm0, xmm0, xmm3
	vunpcklps	xmm2, xmm2, xmm1
	mov	DWORD PTR [rax], r9d
	add	rax, 48
	vmovlhps	xmm2, xmm2, xmm0
	mov	DWORD PTR -44[rax], esi
	vmovups	XMMWORD PTR -40[rax], xmm2
	mov	DWORD PTR -24[rax], ecx
	mov	DWORD PTR -20[rax], r10d
	mov	DWORD PTR -16[rax], r8d
	mov	DWORD PTR -12[rax], r11d
	mov	QWORD PTR -8[rax], rbx
	mov	QWORD PTR 208[rsp], rax
.L12:
	add	r14, 48
	cmp	QWORD PTR 496[rsp], r14
	jne	.L19
.L9:
	mov	rax, QWORD PTR 56[rsp]
	shr	rax, 61
	jne	.L207
	mov	rbx, QWORD PTR 56[rsp]
	test	rbx, rbx
	je	.L113
	sal	rbx, 2
	mov	rdi, rbx
	mov	QWORD PTR 56[rsp], rbx
.LEHB1:
	call	"_Znwm"@PLT
.LEHE1:
	mov	rdx, rbx
	xor	esi, esi
	mov	rdi, rax
	mov	QWORD PTR 80[rsp], rax
	call	"memset"@PLT
.L20:
	mov	rax, QWORD PTR 184[rsp]
	mov	r14, QWORD PTR 488[rsp]
	lea	r13, 1[rax]
	inc	r14
	imul	r14, r13
	mov	rax, r14
	shr	rax, 61
	jne	.L208
	test	r14, r14
	je	.L224
	sal	r14, 2
	mov	rdi, r14
.LEHB2:
	call	"_Znwm"@PLT
	mov	rdi, rax
	mov	rdx, r14
	xor	esi, esi
	call	"memset"@PLT
	mov	rbx, QWORD PTR 208[rsp]
	mov	rdi, rax
	cmp	QWORD PTR 128[rsp], rbx
	je	.L28
.L25:
	mov	rax, QWORD PTR 128[rsp]
.L29:
	movsxd	rdx, DWORD PTR 32[rax]
	movsxd	rsi, DWORD PTR 24[rax]
	add	rax, 48
	movsxd	r8, DWORD PTR -12[rax]
	imul	rdx, r13
	imul	r8, r13
	lea	rcx, [rdx+rsi]
	inc	DWORD PTR [rdi+rcx*4]
	movsxd	rcx, DWORD PTR -20[rax]
	add	rdx, rcx
	dec	DWORD PTR [rdi+rdx*4]
	lea	rdx, [rsi+r8]
	dec	DWORD PTR [rdi+rdx*4]
	lea	rdx, [rcx+r8]
	inc	DWORD PTR [rdi+rdx*4]
	cmp	rax, QWORD PTR 208[rsp]
	jne	.L29
	mov	r9d, DWORD PTR 92[rsp]
	test	r9d, r9d
	jle	.L35
	mov	r8d, DWORD PTR 144[rsp]
	test	r8d, r8d
	jle	.L35
.L27:
	mov	rax, QWORD PTR 184[rsp]
	xor	ecx, ecx
	lea	edx, -1[rax]
	xor	eax, eax
	lea	r9, 1[rdx]
.L31:
	mov	rbx, QWORD PTR 80[rsp]
	add	ecx, DWORD PTR [rdi+rax*4]
	mov	DWORD PTR [rbx+rax*4], ecx
	inc	rax
	cmp	r9, rax
	jne	.L31
	cmp	DWORD PTR 92[rsp], 1
	jle	.L32
	mov	eax, DWORD PTR 144[rsp]
	mov	r11, r13
	xor	ecx, ecx
	mov	r8d, 1
	lea	rsi, 0[0+rax*4]
	lea	r10, [rbx+rsi]
.L34:
	lea	rbx, [rdi+r11*4]
	movsxd	rax, ecx
	xor	edx, edx
	add	ecx, DWORD PTR 184[rsp]
	mov	QWORD PTR 496[rsp], rbx
	mov	rbx, QWORD PTR 80[rsp]
	lea	rbx, [rbx+rax*4]
	xor	eax, eax
.L33:
	mov	r12, QWORD PTR 496[rsp]
	add	edx, DWORD PTR [r12+rax*4]
	mov	r12d, DWORD PTR [rbx+rax*4]
	add	r12d, edx
	mov	DWORD PTR [r10+rax*4], r12d
	inc	rax
	cmp	rax, r9
	jne	.L33
	inc	r8d
	add	r11, r13
	add	r10, rsi
	cmp	DWORD PTR 92[rsp], r8d
	jne	.L34
.L35:
	test	rdi, rdi
	je	.L26
.L32:
	mov	rsi, r14
	call	"_ZdlPvm"@PLT
.L26:
	mov	edi, 195072
	call	"_Znwm"@PLT
.LEHE2:
	mov	DWORD PTR [rax], 0x00000000
	xor	esi, esi
	lea	rdi, 4[rax]
	mov	edx, 195068
	mov	QWORD PTR 216[rsp], rax
	call	"memset"@PLT
	mov	esi, DWORD PTR 92[rsp]
	test	esi, esi
	jle	.L36
	mov	ecx, DWORD PTR 144[rsp]
	test	ecx, ecx
	jle	.L116
	mov	rbx, QWORD PTR 184[rsp]
	mov	DWORD PTR 224[rsp], 0
	xor	r14d, r14d
	vxorps	xmm10, xmm10, xmm10
	vmovss	xmm30, DWORD PTR .LC1[rip]
	vmovss	xmm29, DWORD PTR .LC4[rip]
	mov	QWORD PTR 120[rsp], 0
	lea	rdx, [rbx+rbx*2]
	lea	rax, 0[0+rbx*8]
	mov	QWORD PTR 24[rsp], r15
	lea	rdi, 0[0+rdx*4]
	add	rbx, rax
	mov	QWORD PTR 136[rsp], rdx
	add	rdx, rdx
	mov	QWORD PTR 400[rsp], rdi
	mov	QWORD PTR 96[rsp], rbx
	mov	QWORD PTR 168[rsp], rdx
	neg	rdx
	mov	QWORD PTR 104[rsp], rdx
	mov	edx, 8
.L99:
	mov	ebx, DWORD PTR 92[rsp]
	mov	QWORD PTR 176[rsp], 0
	mov	QWORD PTR 16[rsp], rax
	cmp	edx, ebx
	mov	QWORD PTR 40[rsp], r14
	cmovg	edx, ebx
	mov	ebx, DWORD PTR 120[rsp]
	mov	DWORD PTR 196[rsp], edx
	sub	edx, DWORD PTR 224[rsp]
	mov	DWORD PTR 36[rsp], ebx
	mov	DWORD PTR 32[rsp], edx
.L97:
	mov	rbx, QWORD PTR 176[rsp]
	mov	edx, DWORD PTR 144[rsp]
	lea	eax, 2032[rbx]
	mov	DWORD PTR 204[rsp], ebx
	cmp	eax, edx
	cmovg	eax, edx
	mov	r14d, eax
	mov	DWORD PTR 200[rsp], eax
	mov	eax, DWORD PTR 32[rsp]
	sub	r14d, ebx
	imul	eax, r14d
	movsxd	rbx, r14d
	lea	edx, [rax+rax*2]
	movsxd	rdx, edx
	sal	rdx, 2
	je	.L38
	mov	rdi, QWORD PTR 216[rsp]
	vmovaps	XMMWORD PTR 496[rsp], xmm10
	xor	esi, esi
	vzeroupper
	call	"memset"@PLT
	vmovaps	xmm10, XMMWORD PTR 496[rsp]
	vmovss	xmm29, DWORD PTR .LC4[rip]
	vmovss	xmm30, DWORD PTR .LC1[rip]
.L38:
	mov	rdx, QWORD PTR 128[rsp]
	cmp	rdx, QWORD PTR 208[rsp]
	je	.L39
	lea	rax, [rbx+rbx*2]
	mov	QWORD PTR 48[rsp], rbx
	lea	rdi, 0[0+rax*4]
	mov	QWORD PTR 160[rsp], rax
	mov	QWORD PTR 296[rsp], rdi
	mov	rdi, rax
	add	rax, rax
	mov	QWORD PTR 112[rsp], rax
	mov	eax, DWORD PTR 200[rsp]
	sal	rdi, 4
	mov	QWORD PTR 288[rsp], rdi
	sub	rax, QWORD PTR 176[rsp]
	mov	DWORD PTR 88[rsp], r14d
	mov	QWORD PTR 72[rsp], rax
	.p2align 4,,10
	.p2align 3
.L83:
	mov	eax, DWORD PTR 32[rdx]
	mov	ebx, DWORD PTR 224[rsp]
	mov	edi, DWORD PTR 204[rsp]
	mov	esi, DWORD PTR 200[rsp]
	cmp	ebx, eax
	mov	r8d, eax
	mov	eax, DWORD PTR 36[rdx]
	cmovge	r8d, ebx
	mov	ebx, DWORD PTR 196[rsp]
	mov	r13d, eax
	cmp	ebx, eax
	mov	eax, DWORD PTR 24[rdx]
	mov	DWORD PTR 252[rsp], r8d
	cmovle	r13d, ebx
	cmp	edi, eax
	mov	ebx, eax
	mov	eax, DWORD PTR 28[rdx]
	cmovge	ebx, edi
	mov	DWORD PTR 248[rsp], r13d
	cmp	esi, eax
	cmovle	eax, esi
	mov	DWORD PTR 228[rsp], ebx
	cmp	eax, ebx
	jle	.L40
	cmp	r13d, r8d
	jle	.L40
	vmovss	xmm4, DWORD PTR 8[rdx]
	vmovss	xmm5, DWORD PTR 12[rdx]
	sub	eax, ebx
	vmovss	xmm6, DWORD PTR 16[rdx]
	vmovss	xmm7, DWORD PTR 20[rdx]
	lea	eax, [rax+rax*2]
	mov	DWORD PTR 496[rsp], eax
	vbroadcastss	ymm9, xmm4
	vbroadcastss	ymm17, xmm5
	mov	DWORD PTR 192[rsp], eax
	vbroadcastss	ymm25, xmm6
	vbroadcastss	ymm11, xmm7
	lea	eax, 3[r8]
	vmovaps	ymm0, ymm9
	vmovaps	ymm1, ymm17
	vmovaps	ymm2, ymm25
	vmovaps	ymm3, ymm11
	cmp	r13d, eax
	jle	.L41
	mov	ecx, DWORD PTR [rdx]
	mov	eax, r8d
	mov	r10, QWORD PTR 184[rsp]
	mov	DWORD PTR 432[rsp], 0
	mov	r11, QWORD PTR 40[rdx]
	mov	QWORD PTR 152[rsp], rdx
	add	ecx, ebx
	sub	ebx, edi
	movsxd	rsi, ebx
	movsxd	rcx, ecx
	mov	QWORD PTR 464[rsp], r11
	lea	rdi, [rsi+rsi*2]
	mov	rsi, rax
	sub	rsi, QWORD PTR 120[rsp]
	imul	rsi, QWORD PTR 160[rsp]
	add	rsi, rdi
	mov	rdi, QWORD PTR 216[rsp]
	lea	rbx, [rdi+rsi*4]
	add	rsi, QWORD PTR 112[rsp]
	lea	r12, [rdi+rsi*4]
	movsxd	rsi, DWORD PTR 4[rdx]
	mov	rdi, r11
	add	rsi, rax
	imul	rsi, r10
	lea	rax, [rcx+rsi]
	add	rcx, r10
	add	rcx, rsi
	mov	rsi, QWORD PTR 96[rsp]
	lea	rax, [rax+rax*2]
	lea	rcx, [rcx+rcx*2]
	lea	r11, [r11+rax]
	lea	r9, [rdi+rcx]
	mov	rcx, QWORD PTR 168[rsp]
	add	rcx, rdi
	lea	r14, [rcx+rax]
	lea	rcx, [rdi+rsi]
	mov	rsi, QWORD PTR 400[rsp]
	lea	r10, [rcx+rax]
	lea	rcx, [rdi+rsi]
	lea	esi, -4[r13]
	sub	esi, r8d
	lea	r15, [rcx+rax]
	mov	eax, DWORD PTR 496[rsp]
	mov	rcx, QWORD PTR 168[rsp]
	mov	r8d, esi
	mov	DWORD PTR 148[rsp], esi
	shr	r8d, 2
	sub	eax, 16
	sub	rcx, rdi
	mov	DWORD PTR 304[rsp], r8d
	mov	r8, QWORD PTR 104[rsp]
	mov	QWORD PTR 336[rsp], rcx
	sub	r8, rdi
	mov	QWORD PTR 312[rsp], r8
	mov	r8, QWORD PTR 136[rsp]
	sub	r8, rdi
	mov	edi, eax
	shr	eax, 4
	and	edi, -16
	inc	eax
	mov	QWORD PTR 320[rsp], r8
	mov	r8, r10
	lea	ecx, 23[rdi]
	sal	rax, 4
	mov	DWORD PTR 264[rsp], edi
	add	edi, 16
	mov	DWORD PTR 268[rsp], ecx
	mov	r10, r11
	mov	QWORD PTR 256[rsp], rax
	mov	QWORD PTR 240[rsp], rdi
	sal	rdi, 2
	mov	QWORD PTR 232[rsp], rdi
	mov	rdi, r15
	.p2align 4,,10
	.p2align 3
.L50:
	mov	rax, QWORD PTR 312[rsp]
	lea	rdx, [rax+r14]
	add	rax, rdi
	mov	QWORD PTR 472[rsp], rax
	mov	rax, QWORD PTR 320[rsp]
	mov	QWORD PTR 488[rsp], rdx
	mov	rdx, r9
	add	rax, r14
	sub	rdx, QWORD PTR 464[rsp]
	mov	QWORD PTR 448[rsp], rax
	mov	rax, QWORD PTR 336[rsp]
	mov	QWORD PTR 480[rsp], rdx
	lea	r15, [rax+r14]
	mov	rax, QWORD PTR 296[rsp]
	lea	rdx, [rax+rbx]
	add	rax, r12
	cmp	DWORD PTR 496[rsp], 15
	jle	.L42
	mov	rsi, QWORD PTR 256[rsp]
	xor	ecx, ecx
	.p2align 4,,10
	.p2align 3
.L43:
	vpmovzxbd	ymm19, QWORD PTR [r10+rcx]
	vpmovzxbd	ymm18, QWORD PTR 8[r10+rcx]
	vpmovzxbd	ymm12, QWORD PTR 3[r10+rcx]
	vpmovzxbd	ymm8, QWORD PTR 11[r10+rcx]
	vcvtdq2ps	ymm19, ymm19
	vcvtdq2ps	ymm18, ymm18
	vfmadd213ps	ymm19, ymm0, YMMWORD PTR [rbx+rcx*4]
	vfmadd213ps	ymm18, ymm0, YMMWORD PTR 32[rbx+rcx*4]
	vcvtdq2ps	ymm12, ymm12
	vcvtdq2ps	ymm8, ymm8
	vpmovzxbd	ymm16, QWORD PTR [r9+rcx]
	vpmovzxbd	ymm15, QWORD PTR 8[r9+rcx]
	vpmovzxbd	ymm14, QWORD PTR 3[r9+rcx]
	vpmovzxbd	ymm13, QWORD PTR 11[r9+rcx]
	vcvtdq2ps	ymm16, ymm16
	vcvtdq2ps	ymm15, ymm15
	vcvtdq2ps	ymm14, ymm14
	vcvtdq2ps	ymm13, ymm13
	vfmadd132ps	ymm12, ymm19, ymm1
	vfmadd132ps	ymm8, ymm18, ymm1
	vpmovzxbd	ymm19, QWORD PTR [r14+rcx]
	vpmovzxbd	ymm18, QWORD PTR 8[r14+rcx]
	vcvtdq2ps	ymm19, ymm19
	vcvtdq2ps	ymm18, ymm18
	vfmadd231ps	ymm12, ymm2, ymm16
	vfmadd231ps	ymm8, ymm2, ymm15
	vfmadd231ps	ymm12, ymm3, ymm14
	vfmadd231ps	ymm8, ymm3, ymm13
	vmovups	YMMWORD PTR [rbx+rcx*4], ymm12
	vpmovzxbd	ymm12, QWORD PTR 3[r14+rcx]
	vmovups	YMMWORD PTR 32[rbx+rcx*4], ymm8
	vpmovzxbd	ymm8, QWORD PTR 11[r14+rcx]
	vfmadd213ps	ymm16, ymm0, YMMWORD PTR [rdx+rcx*4]
	vfmadd213ps	ymm15, ymm0, YMMWORD PTR 32[rdx+rcx*4]
	vcvtdq2ps	ymm12, ymm12
	vcvtdq2ps	ymm8, ymm8
	vfmadd132ps	ymm14, ymm16, ymm1
	vfmadd132ps	ymm13, ymm15, ymm1
	vpmovzxbd	ymm16, QWORD PTR [r8+rcx]
	vpmovzxbd	ymm15, QWORD PTR 8[r8+rcx]
	vcvtdq2ps	ymm16, ymm16
	vcvtdq2ps	ymm15, ymm15
	vfmadd231ps	ymm14, ymm2, ymm19
	vfmadd231ps	ymm13, ymm2, ymm18
	vfmadd231ps	ymm14, ymm3, ymm12
	vfmadd231ps	ymm13, ymm3, ymm8
	vmovups	YMMWORD PTR [rdx+rcx*4], ymm14
	vpmovzxbd	ymm14, QWORD PTR 3[r8+rcx]
	vmovups	YMMWORD PTR 32[rdx+rcx*4], ymm13
	vpmovzxbd	ymm13, QWORD PTR 11[r8+rcx]
	vfmadd213ps	ymm19, ymm0, YMMWORD PTR [r12+rcx*4]
	vfmadd213ps	ymm18, ymm0, YMMWORD PTR 32[r12+rcx*4]
	vcvtdq2ps	ymm14, ymm14
	vcvtdq2ps	ymm13, ymm13
	vfmadd132ps	ymm12, ymm19, ymm1
	vfmadd132ps	ymm8, ymm18, ymm1
	vpmovzxbd	ymm19, QWORD PTR [rdi+rcx]
	vpmovzxbd	ymm18, QWORD PTR 8[rdi+rcx]
	vfmadd231ps	ymm12, ymm2, ymm16
	vfmadd231ps	ymm8, ymm2, ymm15
	vfmadd231ps	ymm12, ymm3, ymm14
	vfmadd231ps	ymm8, ymm3, ymm13
	vmovups	YMMWORD PTR [r12+rcx*4], ymm12
	vpmovzxbd	ymm12, QWORD PTR 3[rdi+rcx]
	vmovups	YMMWORD PTR 32[r12+rcx*4], ymm8
	vpmovzxbd	ymm8, QWORD PTR 11[rdi+rcx]
	vfmadd213ps	ymm16, ymm0, YMMWORD PTR [rax+rcx*4]
	vfmadd213ps	ymm15, ymm0, YMMWORD PTR 32[rax+rcx*4]
	vcvtdq2ps	ymm12, ymm12
	vcvtdq2ps	ymm8, ymm8
	vfmadd132ps	ymm14, ymm16, ymm1
	vfmadd132ps	ymm13, ymm15, ymm1
	vcvtdq2ps	ymm16, ymm19
	vcvtdq2ps	ymm15, ymm18
	vfmadd132ps	ymm16, ymm14, ymm2
	vfmadd132ps	ymm15, ymm13, ymm2
	vfmadd132ps	ymm12, ymm16, ymm3
	vfmadd132ps	ymm8, ymm15, ymm3
	vmovups	YMMWORD PTR [rax+rcx*4], ymm12
	vmovups	YMMWORD PTR 32[rax+rcx*4], ymm8
	add	rcx, 16
	cmp	rsi, rcx
	jne	.L43
	mov	r11d, DWORD PTR 264[rsp]
	mov	r13d, DWORD PTR 496[rsp]
	lea	esi, 16[r11]
	cmp	DWORD PTR 268[rsp], r13d
	jge	.L47
	mov	rsi, QWORD PTR 240[rsp]
	mov	rcx, QWORD PTR 488[rsp]
	add	rcx, rsi
	mov	QWORD PTR 424[rsp], rcx
	mov	rcx, QWORD PTR 480[rsp]
	add	rcx, rsi
	mov	QWORD PTR 416[rsp], rcx
	mov	rcx, QWORD PTR 232[rsp]
	lea	r13, [rbx+rcx]
	mov	QWORD PTR 408[rsp], r13
	mov	r13, QWORD PTR 472[rsp]
	add	r13, rsi
	mov	QWORD PTR 384[rsp], r13
	lea	r13, [rdx+rcx]
	mov	QWORD PTR 368[rsp], r13
	mov	r13, QWORD PTR 448[rsp]
	add	r13, rsi
	add	rsi, r15
	mov	QWORD PTR 352[rsp], r13
	lea	r13, [r12+rcx]
	add	rcx, rax
	mov	QWORD PTR 280[rsp], r13
	mov	QWORD PTR 272[rsp], rsi
	lea	esi, 24[r11]
.L45:
	mov	r11, QWORD PTR 464[rsp]
	mov	r13, QWORD PTR 424[rsp]
	vpmovzxbd	ymm14, QWORD PTR [r11+r13]
	vpmovzxbd	ymm8, QWORD PTR 3[r11+r13]
	mov	r13, QWORD PTR 416[rsp]
	vcvtdq2ps	ymm14, ymm14
	vcvtdq2ps	ymm8, ymm8
	vpmovzxbd	ymm13, QWORD PTR [r11+r13]
	vpmovzxbd	ymm12, QWORD PTR 3[r11+r13]
	mov	r13, QWORD PTR 408[rsp]
	vcvtdq2ps	ymm13, ymm13
	vcvtdq2ps	ymm12, ymm12
	vfmadd213ps	ymm14, ymm0, YMMWORD PTR 0[r13]
	vfmadd132ps	ymm8, ymm14, ymm1
	vfmadd231ps	ymm8, ymm2, ymm13
	vfmadd231ps	ymm8, ymm3, ymm12
	vmovups	YMMWORD PTR 0[r13], ymm8
	mov	r13, QWORD PTR 384[rsp]
	vpmovzxbd	ymm14, QWORD PTR [r11+r13]
	vpmovzxbd	ymm8, QWORD PTR 3[r11+r13]
	mov	r13, QWORD PTR 368[rsp]
	vcvtdq2ps	ymm14, ymm14
	vcvtdq2ps	ymm8, ymm8
	vfmadd213ps	ymm13, ymm0, YMMWORD PTR 0[r13]
	vfmadd132ps	ymm12, ymm13, ymm1
	vfmadd231ps	ymm12, ymm2, ymm14
	vfmadd231ps	ymm12, ymm3, ymm8
	vmovups	YMMWORD PTR 0[r13], ymm12
	mov	r13, QWORD PTR 352[rsp]
	vpmovzxbd	ymm13, QWORD PTR [r11+r13]
	vpmovzxbd	ymm12, QWORD PTR 3[r11+r13]
	mov	r13, QWORD PTR 280[rsp]
	vcvtdq2ps	ymm13, ymm13
	vcvtdq2ps	ymm12, ymm12
	vfmadd213ps	ymm14, ymm0, YMMWORD PTR 0[r13]
	vfmadd132ps	ymm8, ymm14, ymm1
	vfmadd231ps	ymm8, ymm2, ymm13
	vfmadd231ps	ymm8, ymm3, ymm12
	vmovups	YMMWORD PTR 0[r13], ymm8
	mov	r13, QWORD PTR 272[rsp]
	vfmadd213ps	ymm13, ymm0, YMMWORD PTR [rcx]
	vpmovzxbd	ymm14, QWORD PTR [r11+r13]
	vpmovzxbd	ymm8, QWORD PTR 3[r11+r13]
	vcvtdq2ps	ymm14, ymm14
	vcvtdq2ps	ymm8, ymm8
	vfmadd132ps	ymm12, ymm13, ymm1
	vfmadd231ps	ymm12, ymm2, ymm14
	vfmadd132ps	ymm8, ymm12, ymm3
	vmovups	YMMWORD PTR [rcx], ymm8
.L47:
	mov	ecx, DWORD PTR 496[rsp]
	sub	ecx, esi
	mov	DWORD PTR 424[rsp], ecx
	test	ecx, ecx
	jle	.L48
	add	QWORD PTR 488[rsp], rsi
	add	r15, rsi
	add	QWORD PTR 480[rsp], rsi
	add	QWORD PTR 472[rsp], rsi
	add	QWORD PTR 448[rsp], rsi
.L46:
	sal	rsi, 2
	mov	rcx, QWORD PTR 488[rsp]
	mov	QWORD PTR 384[rsp], r14
	add	rdx, rsi
	add	rax, rsi
	lea	r11, [rbx+rsi]
	mov	QWORD PTR 368[rsp], r9
	mov	QWORD PTR 408[rsp], rdx
	lea	r13, [r12+rsi]
	mov	rdx, QWORD PTR 480[rsp]
	mov	rsi, QWORD PTR 464[rsp]
	mov	QWORD PTR 416[rsp], rax
	xor	eax, eax
	mov	QWORD PTR 352[rsp], r10
	mov	r10d, DWORD PTR 424[rsp]
	add	rcx, rsi
	add	rdx, rsi
	mov	QWORD PTR 488[rsp], rcx
	mov	rcx, QWORD PTR 472[rsp]
	mov	QWORD PTR 480[rsp], rdx
	mov	rdx, QWORD PTR 448[rsp]
	mov	QWORD PTR 472[rsp], rdi
	mov	rdi, QWORD PTR 416[rsp]
	add	rcx, rsi
	mov	QWORD PTR 448[rsp], r8
	mov	r9, QWORD PTR 488[rsp]
	add	rdx, rsi
	add	rsi, r15
	mov	r8, QWORD PTR 408[rsp]
	mov	r14, QWORD PTR 480[rsp]
	.p2align 4,,10
	.p2align 3
.L49:
	movzx	r15d, BYTE PTR [r14+rax]
	vcvtusi2ss	xmm12, xmm10, r15d
	movzx	r15d, BYTE PTR 3[r14+rax]
	vcvtusi2ss	xmm20, xmm10, r15d
	movzx	r15d, BYTE PTR [rcx+rax]
	vcvtusi2ss	xmm8, xmm10, r15d
	movzx	r15d, BYTE PTR 3[rcx+rax]
	vmulss	xmm22, xmm6, xmm12
	vcvtusi2ss	xmm19, xmm10, r15d
	movzx	r15d, BYTE PTR [rdx+rax]
	vcvtusi2ss	xmm16, xmm10, r15d
	movzx	r15d, BYTE PTR 3[rdx+rax]
	vcvtusi2ss	xmm15, xmm10, r15d
	movzx	r15d, BYTE PTR [rsi+rax]
	vcvtusi2ss	xmm18, xmm10, r15d
	movzx	r15d, BYTE PTR 3[rsi+rax]
	vcvtusi2ss	xmm14, xmm10, r15d
	movzx	r15d, BYTE PTR [r9+rax]
	vcvtusi2ss	xmm13, xmm10, r15d
	movzx	r15d, BYTE PTR 3[r9+rax]
	vmulss	xmm18, xmm6, xmm18
	vcvtusi2ss	xmm21, xmm10, r15d
	vfmadd213ss	xmm13, xmm4, DWORD PTR [r11+rax*4]
	vfmadd132ss	xmm21, xmm22, xmm5
	vfmadd231ss	xmm13, xmm7, xmm20
	vaddss	xmm13, xmm13, xmm21
	vmovss	DWORD PTR [r11+rax*4], xmm13
	vmulss	xmm13, xmm6, xmm8
	vfmadd213ss	xmm12, xmm4, DWORD PTR [r8+rax*4]
	vfmadd132ss	xmm20, xmm13, xmm5
	vfmadd231ss	xmm12, xmm7, xmm19
	vaddss	xmm12, xmm12, xmm20
	vmovss	DWORD PTR [r8+rax*4], xmm12
	vmulss	xmm12, xmm6, xmm16
	vfmadd213ss	xmm8, xmm4, DWORD PTR 0[r13+rax*4]
	vfmadd132ss	xmm19, xmm12, xmm5
	vfmadd231ss	xmm8, xmm7, xmm15
	vfmadd132ss	xmm15, xmm18, xmm5
	vaddss	xmm8, xmm8, xmm19
	vmovss	DWORD PTR 0[r13+rax*4], xmm8
	vfmadd213ss	xmm16, xmm4, DWORD PTR [rdi+rax*4]
	vfmadd132ss	xmm14, xmm16, xmm7
	vaddss	xmm14, xmm14, xmm15
	vmovss	DWORD PTR [rdi+rax*4], xmm14
	inc	rax
	cmp	r10d, eax
	jg	.L49
	mov	rdi, QWORD PTR 472[rsp]
	mov	r8, QWORD PTR 448[rsp]
	mov	r14, QWORD PTR 384[rsp]
	mov	r9, QWORD PTR 368[rsp]
	mov	r10, QWORD PTR 352[rsp]
.L48:
	mov	rax, QWORD PTR 288[rsp]
	mov	edx, DWORD PTR 432[rsp]
	add	rbx, rax
	add	r12, rax
	mov	rax, QWORD PTR 400[rsp]
	add	r10, rax
	add	r9, rax
	add	r14, rax
	add	r8, rax
	add	rdi, rax
	cmp	DWORD PTR 304[rsp], edx
	je	.L225
	mov	eax, edx
	inc	eax
	mov	DWORD PTR 432[rsp], eax
	jmp	.L50
	.p2align 4,,10
	.p2align 3
.L225:
	mov	esi, DWORD PTR 148[rsp]
	mov	eax, DWORD PTR 252[rsp]
	mov	rdx, QWORD PTR 152[rsp]
	and	esi, -4
	lea	eax, 4[rax+rsi]
	mov	DWORD PTR 252[rsp], eax
.L41:
	mov	ebx, DWORD PTR 252[rsp]
	lea	eax, 1[rbx]
	cmp	DWORD PTR 248[rsp], eax
	jle	.L51
	mov	eax, DWORD PTR 4[rdx]
	mov	edi, DWORD PTR 228[rsp]
	mov	ecx, DWORD PTR [rdx]
	mov	r14d, DWORD PTR 496[rsp]
	add	eax, ebx
	sub	ebx, DWORD PTR 224[rsp]
	movsxd	rsi, ebx
	mov	rbx, QWORD PTR 160[rsp]
	cdqe
	add	ecx, edi
	imul	rax, QWORD PTR 184[rsp]
	sub	edi, DWORD PTR 204[rsp]
	movsxd	rcx, ecx
	imul	rbx, rsi
	movsxd	rsi, edi
	mov	rdi, QWORD PTR 216[rsp]
	lea	rsi, [rsi+rsi*2]
	add	rax, rcx
	add	rsi, rbx
	lea	rcx, [rax+rax*2]
	mov	rax, QWORD PTR 136[rsp]
	lea	rsi, [rdi+rsi*4]
	mov	rdi, QWORD PTR 296[rsp]
	mov	QWORD PTR 488[rsp], rcx
	lea	r13, [rax+rcx]
	mov	QWORD PTR 416[rsp], rsi
	lea	r9, [rsi+rdi]
	add	rax, r13
	mov	QWORD PTR 408[rsp], r9
	cmp	r14d, 15
	jle	.L52
	mov	r10d, r14d
	mov	rdi, QWORD PTR 40[rdx]
	lea	r11d, -16[r14]
	shr	r10d, 4
	sal	r10, 6
	mov	QWORD PTR 464[rsp], rdi
	lea	r8, [rdi+r13]
	mov	rdi, rsi
	add	r10, rsi
	.p2align 4,,10
	.p2align 3
.L53:
	mov	rsi, r8
	vpmovzxbd	ymm16, QWORD PTR [r8]
	vpmovzxbd	ymm15, QWORD PTR 8[r8]
	add	rdi, 64
	sub	rsi, r13
	vpmovzxbd	ymm14, QWORD PTR 3[r8]
	vpmovzxbd	ymm13, QWORD PTR 11[r8]
	add	r9, 64
	vpmovzxbd	ymm19, QWORD PTR [rsi+rcx]
	vpmovzxbd	ymm18, QWORD PTR 8[rsi+rcx]
	vcvtdq2ps	ymm16, ymm16
	vcvtdq2ps	ymm15, ymm15
	add	r8, 16
	vpmovzxbd	ymm12, QWORD PTR 3[rsi+rcx]
	vpmovzxbd	ymm8, QWORD PTR 11[rsi+rcx]
	vcvtdq2ps	ymm14, ymm14
	vcvtdq2ps	ymm13, ymm13
	vcvtdq2ps	ymm19, ymm19
	vcvtdq2ps	ymm18, ymm18
	vfmadd213ps	ymm19, ymm0, YMMWORD PTR -64[rdi]
	vfmadd213ps	ymm18, ymm0, YMMWORD PTR -32[rdi]
	vcvtdq2ps	ymm12, ymm12
	vcvtdq2ps	ymm8, ymm8
	vfmadd132ps	ymm12, ymm19, ymm1
	vfmadd132ps	ymm8, ymm18, ymm1
	vpmovzxbd	ymm19, QWORD PTR [rsi+rax]
	vpmovzxbd	ymm18, QWORD PTR 8[rsi+rax]
	vcvtdq2ps	ymm19, ymm19
	vcvtdq2ps	ymm18, ymm18
	vfmadd231ps	ymm12, ymm2, ymm16
	vfmadd231ps	ymm8, ymm2, ymm15
	vfmadd231ps	ymm12, ymm3, ymm14
	vfmadd231ps	ymm8, ymm3, ymm13
	vmovups	YMMWORD PTR -64[rdi], ymm12
	vpmovzxbd	ymm12, QWORD PTR 3[rsi+rax]
	vmovups	YMMWORD PTR -32[rdi], ymm8
	vpmovzxbd	ymm8, QWORD PTR 11[rsi+rax]
	vfmadd213ps	ymm16, ymm0, YMMWORD PTR -64[r9]
	vfmadd213ps	ymm15, ymm0, YMMWORD PTR -32[r9]
	vcvtdq2ps	ymm12, ymm12
	vcvtdq2ps	ymm8, ymm8
	vfmadd132ps	ymm14, ymm16, ymm1
	vfmadd132ps	ymm13, ymm15, ymm1
	vfmadd231ps	ymm14, ymm2, ymm19
	vfmadd231ps	ymm13, ymm2, ymm18
	vfmadd132ps	ymm12, ymm14, ymm3
	vfmadd132ps	ymm8, ymm13, ymm3
	vmovups	YMMWORD PTR -64[r9], ymm12
	vmovups	YMMWORD PTR -32[r9], ymm8
	cmp	r10, rdi
	jne	.L53
	mov	esi, r11d
	and	esi, -16
	lea	edi, 23[rsi]
	cmp	edi, DWORD PTR 496[rsp]
	jl	.L57
	lea	edi, 16[rsi]
	mov	DWORD PTR 424[rsp], edi
.L58:
	mov	edi, DWORD PTR 496[rsp]
	mov	esi, DWORD PTR 424[rsp]
	sub	edi, esi
	mov	DWORD PTR 480[rsp], edi
	test	edi, edi
	jle	.L59
	mov	edi, esi
	lea	rsi, [rcx+rdi]
	mov	QWORD PTR 472[rsp], rdi
	add	r13, rdi
	add	rax, rdi
	mov	QWORD PTR 488[rsp], rsi
	mov	r11, rdi
.L56:
	mov	ecx, DWORD PTR 228[rsp]
	sub	rcx, QWORD PTR 176[rsp]
	lea	rsi, [rcx+rcx*2]
	add	rcx, QWORD PTR 72[rsp]
	lea	rcx, [rcx+rcx*2]
	add	rsi, rbx
	add	rcx, rbx
	lea	rdi, [rsi+r11]
	lea	rbx, [rcx+r11]
	mov	QWORD PTR 448[rsp], rdi
	lea	rsi, 0[0+rdi*4]
	lea	rcx, 0[0+rbx*4]
	lea	rdi, 128[0+rdi*4]
	mov	r15, rbx
	cmp	rcx, rdi
	jge	.L132
	lea	rdi, 128[rcx]
	cmp	rsi, rdi
	jl	.L60
.L132:
	mov	ebx, DWORD PTR 480[rsp]
	lea	edi, -1[rbx]
	cmp	edi, 30
	jbe	.L121
	shr	ebx, 5
	mov	r10, QWORD PTR 488[rsp]
	vmovss	DWORD PTR 384[rsp], xmm4
	mov	edi, ebx
	mov	DWORD PTR 432[rsp], ebx
	mov	rbx, QWORD PTR 464[rsp]
	vmovss	DWORD PTR 368[rsp], xmm5
	lea	r9, 3[rbx+r10]
	lea	r14, [rbx+r10]
	vmovss	DWORD PTR 352[rsp], xmm6
	lea	r8, 3[rbx+r13]
	lea	r11, [rbx+r13]
	vmovss	DWORD PTR 336[rsp], xmm7
	lea	r10, 3[rbx+rax]
	lea	r12, [rbx+rax]
	mov	rbx, QWORD PTR 216[rsp]
	add	rcx, rbx
	add	rsi, rbx
	mov	rbx, rdi
	xor	edi, edi
	sal	rbx, 5
	.p2align 4,,10
	.p2align 3
.L63:
	vmovdqu	ymm5, YMMWORD PTR [r11+rdi]
	vmovdqu	ymm4, YMMWORD PTR [r9+rdi]
	sub	rcx, -128
	sub	rsi, -128
	vmovdqu	ymm13, YMMWORD PTR [r14+rdi]
	vpmovzxbw	ymm7, xmm5
	vextracti32x4	xmm5, ymm5, 0x1
	vpmovzxbw	ymm6, xmm4
	vpmovzxbw	ymm5, xmm5
	vpmovsxwd	ymm27, xmm7
	vextracti32x4	xmm16, ymm7, 0x1
	vpmovsxwd	ymm26, xmm5
	vextracti32x4	xmm8, ymm5, 0x1
	vcvtdq2ps	ymm27, ymm27
	vpmovsxwd	ymm23, xmm6
	vmulps	ymm5, ymm2, ymm27
	vpmovsxwd	ymm16, xmm16
	vcvtdq2ps	ymm23, ymm23
	vextracti32x4	xmm4, ymm4, 0x1
	vcvtdq2ps	ymm26, ymm26
	vcvtdq2ps	ymm16, ymm16
	vpmovzxbw	ymm4, xmm4
	vpmovsxwd	ymm8, xmm8
	vextracti32x4	xmm14, ymm6, 0x1
	vpmovsxwd	ymm22, xmm4
	vextracti32x4	xmm12, ymm4, 0x1
	vcvtdq2ps	ymm8, ymm8
	vpmovsxwd	ymm14, xmm14
	vmulps	ymm4, ymm2, ymm8
	vcvtdq2ps	ymm14, ymm14
	vpmovsxwd	ymm12, xmm12
	vcvtdq2ps	ymm22, ymm22
	vpmovzxbw	ymm15, xmm13
	vcvtdq2ps	ymm12, ymm12
	vpmovsxwd	ymm24, xmm15
	vextracti32x4	xmm15, ymm15, 0x1
	vextracti32x4	xmm13, ymm13, 0x1
	vfmadd132ps	ymm23, ymm5, ymm1
	vpmovsxwd	ymm15, xmm15
	vpmovzxbw	ymm13, xmm13
	vcvtdq2ps	ymm24, ymm24
	vmulps	ymm5, ymm2, ymm16
	vcvtdq2ps	ymm15, ymm15
	vfmadd213ps	ymm15, ymm0, YMMWORD PTR -96[rsi]
	vfmadd213ps	ymm24, ymm0, YMMWORD PTR -128[rsi]
	vfmadd132ps	ymm12, ymm4, ymm1
	vmovdqu	ymm4, YMMWORD PTR [r8+rdi]
	vfmadd132ps	ymm14, ymm5, ymm1
	vmulps	ymm5, ymm2, ymm26
	vfmadd132ps	ymm22, ymm5, ymm1
	vpmovzxbw	ymm5, xmm4
	vextracti32x4	xmm4, ymm4, 0x1
	vpmovsxwd	ymm31, xmm5
	vextracti32x4	xmm21, ymm5, 0x1
	vmovdqu	ymm5, YMMWORD PTR [r12+rdi]
	vpmovzxbw	ymm4, xmm4
	vpmovsxwd	ymm21, xmm21
	vpmovsxwd	ymm28, xmm4
	vextracti32x4	xmm4, ymm4, 0x1
	vcvtdq2ps	ymm31, ymm31
	vpmovzxbw	ymm6, xmm5
	vextracti32x4	xmm5, ymm5, 0x1
	vcvtdq2ps	ymm21, ymm21
	vpmovsxwd	ymm4, xmm4
	vcvtdq2ps	ymm28, ymm28
	vextracti32x4	xmm7, ymm6, 0x1
	vpmovzxbw	ymm5, xmm5
	vpmovsxwd	ymm20, xmm6
	vcvtdq2ps	ymm4, ymm4
	vpmovsxwd	ymm7, xmm7
	vfmadd231ps	ymm15, ymm3, ymm21
	vextracti32x4	xmm6, ymm5, 0x1
	vcvtdq2ps	ymm20, ymm20
	vcvtdq2ps	ymm7, ymm7
	vmulps	ymm7, ymm7, ymm2
	vpmovsxwd	ymm6, xmm6
	vpmovsxwd	ymm19, xmm5
	vmovdqu	ymm5, YMMWORD PTR [r10+rdi]
	vcvtdq2ps	ymm6, ymm6
	vmulps	ymm6, ymm6, ymm2
	vfmadd231ps	ymm24, ymm3, ymm31
	vcvtdq2ps	ymm19, ymm19
	add	rdi, 32
	vmulps	ymm20, ymm20, ymm2
	vpmovzxbw	ymm18, xmm5
	vextracti32x4	xmm5, ymm5, 0x1
	vmulps	ymm19, ymm19, ymm2
	vpmovzxbw	ymm5, xmm5
	vaddps	ymm14, ymm14, ymm15
	vfmadd231ps	ymm7, ymm1, ymm21
	vpmovsxwd	ymm21, xmm13
	vextracti32x4	xmm13, ymm13, 0x1
	vpmovsxwd	ymm13, xmm13
	vcvtdq2ps	ymm21, ymm21
	vfmadd213ps	ymm21, ymm0, YMMWORD PTR -64[rsi]
	vaddps	ymm23, ymm23, ymm24
	vcvtdq2ps	ymm13, ymm13
	vfmadd213ps	ymm13, ymm0, YMMWORD PTR -32[rsi]
	vfmadd231ps	ymm6, ymm1, ymm4
	vmovups	YMMWORD PTR -96[rsi], ymm14
	vfmadd231ps	ymm20, ymm1, ymm31
	vfmadd231ps	ymm19, ymm1, ymm28
	vmovups	YMMWORD PTR -128[rsi], ymm23
	vfmadd231ps	ymm21, ymm3, ymm28
	vfmadd132ps	ymm4, ymm13, ymm3
	vaddps	ymm22, ymm22, ymm21
	vaddps	ymm4, ymm4, ymm12
	vmovups	YMMWORD PTR -64[rsi], ymm22
	vmovups	YMMWORD PTR -32[rsi], ymm4
	vpmovsxwd	ymm4, xmm18
	vfmadd213ps	ymm27, ymm0, YMMWORD PTR -128[rcx]
	vfmadd213ps	ymm16, ymm0, YMMWORD PTR -96[rcx]
	vcvtdq2ps	ymm4, ymm4
	vfmadd213ps	ymm26, ymm0, YMMWORD PTR -64[rcx]
	vfmadd213ps	ymm8, ymm0, YMMWORD PTR -32[rcx]
	vfmadd231ps	ymm27, ymm3, ymm4
	vextracti32x4	xmm4, ymm18, 0x1
	vpmovsxwd	ymm4, xmm4
	vcvtdq2ps	ymm4, ymm4
	vfmadd231ps	ymm16, ymm3, ymm4
	vpmovsxwd	ymm4, xmm5
	vcvtdq2ps	ymm4, ymm4
	vfmadd231ps	ymm26, ymm3, ymm4
	vextracti32x4	xmm4, ymm5, 0x1
	vpmovsxwd	ymm4, xmm4
	vcvtdq2ps	ymm4, ymm4
	vfmadd132ps	ymm4, ymm8, ymm3
	vaddps	ymm20, ymm20, ymm27
	vaddps	ymm7, ymm7, ymm16
	vaddps	ymm19, ymm19, ymm26
	vmovups	YMMWORD PTR -128[rcx], ymm20
	vaddps	ymm4, ymm4, ymm6
	vmovups	YMMWORD PTR -96[rcx], ymm7
	vmovups	YMMWORD PTR -64[rcx], ymm19
	vmovups	YMMWORD PTR -32[rcx], ymm4
	cmp	rbx, rdi
	jne	.L63
	mov	r9d, DWORD PTR 432[rsp]
	vmovss	xmm4, DWORD PTR 384[rsp]
	vmovss	xmm5, DWORD PTR 368[rsp]
	vmovss	xmm6, DWORD PTR 352[rsp]
	sal	r9d, 5
	vmovss	xmm7, DWORD PTR 336[rsp]
	cmp	r9d, DWORD PTR 480[rsp]
	je	.L59
	mov	r8d, r9d
.L62:
	mov	r10d, DWORD PTR 480[rsp]
	sub	r10d, r9d
	lea	ecx, -1[r10]
	cmp	ecx, 14
	jbe	.L122
	mov	rdi, QWORD PTR 488[rsp]
	mov	ecx, r9d
	mov	r14, QWORD PTR 216[rsp]
	vmovaps	xmm16, xmm17
	lea	rbx, [rcx+r13]
	lea	r11, [rcx+rax]
	lea	rsi, [rcx+rdi]
	mov	rdi, QWORD PTR 448[rsp]
	add	rdi, rcx
	add	rcx, r15
	lea	rcx, [r14+rcx*4]
	lea	rdi, [r14+rdi*4]
	mov	r14, QWORD PTR 464[rsp]
	vmovdqu	xmm12, XMMWORD PTR [r14+rbx]
	vmovdqu	xmm8, XMMWORD PTR [r14+rsi]
	vpmovzxbw	xmm15, xmm12
	vpsrldq	xmm12, xmm12, 8
	vpmovzxbw	xmm18, xmm8
	vpmovzxbw	xmm12, xmm12
	vpsrldq	xmm8, xmm8, 8
	vpmovsxwd	xmm26, xmm15
	vpsrldq	xmm19, xmm15, 8
	vpmovsxwd	xmm24, xmm12
	vcvtdq2ps	xmm26, xmm26
	vpmovzxbw	xmm14, xmm8
	vmovdqu	xmm8, XMMWORD PTR 3[r14+rsi]
	vpsrldq	xmm15, xmm12, 8
	vpmovsxwd	xmm19, xmm19
	vcvtdq2ps	xmm24, xmm24
	vmulps	xmm12, xmm26, xmm25
	vpmovzxbw	xmm13, xmm8
	vcvtdq2ps	xmm19, xmm19
	vpmovsxwd	xmm15, xmm15
	vpmovsxwd	xmm23, xmm13
	vpsrldq	xmm8, xmm8, 8
	vcvtdq2ps	xmm15, xmm15
	vcvtdq2ps	xmm23, xmm23
	vpmovzxbw	xmm8, xmm8
	vfmadd132ps	xmm23, xmm12, xmm17
	vpsrldq	xmm12, xmm13, 8
	vmulps	xmm13, xmm19, xmm25
	vpmovsxwd	xmm12, xmm12
	vcvtdq2ps	xmm12, xmm12
	vfmadd132ps	xmm12, xmm13, xmm17
	vmulps	xmm13, xmm24, xmm25
	vmovaps	XMMWORD PTR 384[rsp], xmm12
	vpmovsxwd	xmm12, xmm8
	vcvtdq2ps	xmm12, xmm12
	vfmadd132ps	xmm12, xmm13, xmm17
	vpsrldq	xmm13, xmm8, 8
	vmulps	xmm8, xmm15, xmm25
	vpmovsxwd	xmm13, xmm13
	vcvtdq2ps	xmm13, xmm13
	vmovaps	XMMWORD PTR 432[rsp], xmm12
	vmovdqu	xmm12, XMMWORD PTR [r14+r11]
	vfmadd132ps	xmm13, xmm8, xmm17
	vmovdqu	xmm8, XMMWORD PTR 3[r14+rbx]
	vpmovzxbw	xmm21, xmm12
	vpsrldq	xmm12, xmm12, 8
	vpmovsxwd	xmm31, xmm21
	vpmovzxbw	xmm22, xmm8
	vpmovzxbw	xmm12, xmm12
	vcvtdq2ps	xmm31, xmm31
	vmulps	xmm31, xmm31, xmm25
	vpsrldq	xmm21, xmm21, 8
	vpmovsxwd	xmm28, xmm22
	vcvtdq2ps	xmm28, xmm28
	vpsrldq	xmm22, xmm22, 8
	vpsrldq	xmm8, xmm8, 8
	vpmovsxwd	xmm21, xmm21
	vcvtdq2ps	xmm21, xmm21
	vmulps	xmm21, xmm21, xmm25
	vpmovsxwd	xmm22, xmm22
	vpmovzxbw	xmm8, xmm8
	vcvtdq2ps	xmm22, xmm22
	vpmovsxwd	xmm27, xmm8
	vpsrldq	xmm8, xmm8, 8
	vpmovsxwd	xmm8, xmm8
	vcvtdq2ps	xmm27, xmm27
	vfmadd231ps	xmm31, xmm17, xmm28
	vcvtdq2ps	xmm8, xmm8
	vfmadd231ps	xmm21, xmm17, xmm22
	vmovaps	XMMWORD PTR 320[rsp], xmm31
	vpmovsxwd	xmm31, xmm18
	vpsrldq	xmm18, xmm18, 8
	vpmovsxwd	xmm18, xmm18
	vcvtdq2ps	xmm31, xmm31
	vfmadd213ps	xmm31, xmm9, XMMWORD PTR [rdi]
	vcvtdq2ps	xmm18, xmm18
	vfmadd213ps	xmm18, xmm9, XMMWORD PTR 16[rdi]
	vmovaps	XMMWORD PTR 336[rsp], xmm21
	vpmovsxwd	xmm21, xmm12
	vpsrldq	xmm12, xmm12, 8
	vcvtdq2ps	xmm21, xmm21
	vmulps	xmm21, xmm21, xmm25
	vpmovsxwd	xmm12, xmm12
	vcvtdq2ps	xmm12, xmm12
	vmulps	xmm12, xmm12, xmm25
	vfmadd231ps	xmm31, xmm28, xmm11
	vfmadd231ps	xmm18, xmm22, xmm11
	vpmovsxwd	xmm22, xmm14
	vpsrldq	xmm14, xmm14, 8
	vcvtdq2ps	xmm22, xmm22
	vfmadd213ps	xmm22, xmm9, XMMWORD PTR 32[rdi]
	vpmovsxwd	xmm14, xmm14
	vfmadd231ps	xmm21, xmm17, xmm27
	vcvtdq2ps	xmm14, xmm14
	vfmadd213ps	xmm14, xmm9, XMMWORD PTR 48[rdi]
	vfmadd132ps	xmm16, xmm12, xmm8
	vmovdqu	xmm12, XMMWORD PTR 3[r14+r11]
	vaddps	xmm23, xmm23, xmm31
	vpmovzxbw	xmm20, xmm12
	vpsrldq	xmm12, xmm12, 8
	vfmadd231ps	xmm22, xmm27, xmm11
	vpmovzxbw	xmm12, xmm12
	vmovups	XMMWORD PTR [rdi], xmm23
	vfmadd132ps	xmm8, xmm14, xmm11
	vmovaps	XMMWORD PTR 368[rsp], xmm16
	vpsrldq	xmm14, xmm20, 8
	vmovaps	xmm16, xmm9
	vpmovsxwd	xmm14, xmm14
	vmovaps	XMMWORD PTR 352[rsp], xmm21
	vcvtdq2ps	xmm14, xmm14
	vaddps	xmm8, xmm8, xmm13
	vaddps	xmm13, xmm18, XMMWORD PTR 384[rsp]
	vpmovsxwd	xmm18, xmm12
	vcvtdq2ps	xmm18, xmm18
	vmovups	XMMWORD PTR 16[rdi], xmm13
	vaddps	xmm13, xmm22, XMMWORD PTR 432[rsp]
	vmovups	XMMWORD PTR 48[rdi], xmm8
	vpsrldq	xmm8, xmm12, 8
	vpmovsxwd	xmm8, xmm8
	vmovups	XMMWORD PTR 32[rdi], xmm13
	vpmovsxwd	xmm13, xmm20
	vcvtdq2ps	xmm8, xmm8
	vfmadd213ps	xmm26, xmm9, XMMWORD PTR [rcx]
	vfmadd213ps	xmm19, xmm9, XMMWORD PTR 16[rcx]
	vcvtdq2ps	xmm13, xmm13
	vfmadd213ps	xmm16, xmm15, XMMWORD PTR 48[rcx]
	vfmadd213ps	xmm24, xmm9, XMMWORD PTR 32[rcx]
	vfmadd132ps	xmm13, xmm26, xmm11
	vfmadd132ps	xmm14, xmm19, xmm11
	vfmadd132ps	xmm8, xmm16, xmm11
	vfmadd132ps	xmm18, xmm24, xmm11
	vaddps	xmm12, xmm13, XMMWORD PTR 320[rsp]
	vaddps	xmm8, xmm8, XMMWORD PTR 368[rsp]
	vmovups	XMMWORD PTR [rcx], xmm12
	vaddps	xmm12, xmm14, XMMWORD PTR 336[rsp]
	vmovups	XMMWORD PTR 48[rcx], xmm8
	vmovups	XMMWORD PTR 16[rcx], xmm12
	vaddps	xmm12, xmm18, XMMWORD PTR 352[rsp]
	vmovups	XMMWORD PTR 32[rcx], xmm12
	mov	ecx, r10d
	and	ecx, -16
	test	r10b, 15
	je	.L59
	add	r8d, ecx
.L64:
	sub	r10d, ecx
	lea	esi, -1[r10]
	cmp	esi, 6
	jbe	.L65
	add	ecx, r9d
	mov	rbx, QWORD PTR 488[rsp]
	mov	r14, QWORD PTR 464[rsp]
	vmovaps	xmm16, xmm17
	mov	ecx, ecx
	mov	rdi, QWORD PTR 448[rsp]
	vmovaps	xmm18, xmm9
	lea	rsi, [rcx+rbx]
	lea	r11, [rcx+r13]
	mov	rbx, QWORD PTR 216[rsp]
	vmovq	xmm8, QWORD PTR [r14+rsi]
	vmovq	xmm12, QWORD PTR [r14+r11]
	add	rdi, rcx
	lea	r9, [rcx+rax]
	add	rcx, r15
	lea	rdi, [rbx+rdi*4]
	vpmovzxbw	xmm15, xmm8
	vpsrlq	xmm8, xmm8, 32
	vpmovzxbw	xmm14, xmm12
	vmovq	r12, xmm15
	vpmovzxbw	xmm15, xmm8
	lea	rcx, [rbx+rcx*4]
	vmovq	xmm8, QWORD PTR 3[r14+rsi]
	vmovq	rbx, xmm15
	vpsrlq	xmm12, xmm12, 32
	vpmovzxwd	xmm15, xmm14
	vpsrlq	xmm14, xmm14, 32
	vmovq	xmm15, xmm15
	vpmovzxbw	xmm12, xmm12
	vpmovzxwd	xmm14, xmm14
	vcvtdq2ps	xmm21, xmm15
	vpmovzxbw	xmm13, xmm8
	vmulps	xmm20, xmm21, xmm25
	vpsrlq	xmm8, xmm8, 32
	vmovq	xmm14, xmm14
	vcvtdq2ps	xmm15, xmm14
	vpmovzxwd	xmm14, xmm12
	vpsrlq	xmm12, xmm12, 32
	vpmovzxbw	xmm8, xmm8
	vmovq	xmm14, xmm14
	vpmovzxwd	xmm12, xmm12
	vcvtdq2ps	xmm19, xmm14
	vpmovzxwd	xmm14, xmm13
	vpsrlq	xmm13, xmm13, 32
	vmovq	xmm12, xmm12
	vmovq	xmm14, xmm14
	vpmovzxwd	xmm13, xmm13
	vcvtdq2ps	xmm12, xmm12
	vcvtdq2ps	xmm14, xmm14
	vfmadd132ps	xmm14, xmm20, xmm17
	vmovq	xmm13, xmm13
	vcvtdq2ps	xmm13, xmm13
	vmovaps	xmm27, xmm14
	vmulps	xmm14, xmm15, xmm25
	vfmadd132ps	xmm13, xmm14, xmm17
	vmulps	xmm14, xmm19, xmm25
	vmovaps	xmm28, xmm13
	vpmovzxwd	xmm13, xmm8
	vmovq	xmm13, xmm13
	vpsrlq	xmm8, xmm8, 32
	vcvtdq2ps	xmm13, xmm13
	vfmadd132ps	xmm13, xmm14, xmm17
	vpmovzxwd	xmm8, xmm8
	vmovq	xmm8, xmm8
	vcvtdq2ps	xmm8, xmm8
	vmovaps	xmm31, xmm13
	vmulps	xmm13, xmm12, xmm25
	vfmadd132ps	xmm8, xmm13, xmm17
	vmovaps	xmm26, xmm8
	vmovq	xmm8, QWORD PTR 3[r14+r11]
	mov	r11, r14
	vpmovzxbw	xmm13, xmm8
	vpsrlq	xmm8, xmm8, 32
	vpmovzxwd	xmm14, xmm13
	vpsrlq	xmm13, xmm13, 32
	vpmovzxbw	xmm8, xmm8
	vpmovzxwd	xmm13, xmm13
	vmovq	xmm14, xmm14
	vmovq	xmm13, xmm13
	vcvtdq2ps	xmm14, xmm14
	vcvtdq2ps	xmm23, xmm13
	vpmovzxwd	xmm13, xmm8
	vpsrlq	xmm8, xmm8, 32
	vpmovzxwd	xmm8, xmm8
	vmovq	xmm13, xmm13
	vmovq	xmm8, xmm8
	vcvtdq2ps	xmm24, xmm13
	vcvtdq2ps	xmm22, xmm8
	vmovq	xmm8, QWORD PTR [r14+r9]
	vpmovzxbw	xmm13, xmm8
	vpsrlq	xmm8, xmm8, 32
	vpmovzxbw	xmm8, xmm8
	vmovq	r14, xmm8
	vpmovzxwd	xmm8, xmm13
	vpsrlq	xmm13, xmm13, 32
	vmovq	xmm20, xmm8
	vmovq	xmm8, r14
	vpmovzxwd	xmm13, xmm13
	vcvtdq2ps	xmm20, xmm20
	vmulps	xmm20, xmm20, xmm25
	vmovq	xmm13, xmm13
	vcvtdq2ps	xmm13, xmm13
	vmulps	xmm13, xmm13, xmm25
	vfmadd231ps	xmm20, xmm17, xmm14
	vfmadd231ps	xmm13, xmm17, xmm23
	vmovaps	XMMWORD PTR 448[rsp], xmm20
	vmovaps	XMMWORD PTR 432[rsp], xmm13
	vpmovzxwd	xmm13, xmm8
	vpsrlq	xmm8, xmm8, 32
	vmovq	xmm13, xmm13
	vpmovzxwd	xmm8, xmm8
	vcvtdq2ps	xmm13, xmm13
	vmulps	xmm13, xmm13, xmm25
	vmovq	xmm8, xmm8
	vcvtdq2ps	xmm8, xmm8
	vmulps	xmm8, xmm8, xmm25
	vfmadd231ps	xmm13, xmm17, xmm24
	vfmadd132ps	xmm16, xmm8, xmm22
	vmovq	xmm8, QWORD PTR 3[r11+r9]
	vmovaps	XMMWORD PTR 384[rsp], xmm13
	vpmovzxbw	xmm13, xmm8
	vpsrlq	xmm8, xmm8, 32
	vpmovzxbw	xmm8, xmm8
	vmovq	rsi, xmm13
	vmovq	r11, xmm8
	vmovq	xmm8, r12
	vpmovzxwd	xmm8, xmm8
	vmovq	xmm8, xmm8
	vcvtdq2ps	xmm13, xmm8
	vmovq	xmm8, QWORD PTR [rdi]
	vfmadd231ps	xmm8, xmm13, xmm9
	vfmadd132ps	xmm14, xmm8, xmm11
	vmovq	xmm8, r12
	vpsrlq	xmm8, xmm8, 32
	vpmovzxwd	xmm8, xmm8
	vmovq	xmm8, xmm8
	vcvtdq2ps	xmm13, xmm8
	vmovq	xmm8, QWORD PTR 8[rdi]
	vaddps	xmm14, xmm27, xmm14
	vfmadd132ps	xmm13, xmm8, xmm9
	vmovq	xmm8, rbx
	vpmovzxwd	xmm8, xmm8
	vmovq	xmm8, xmm8
	vmovlps	QWORD PTR [rdi], xmm14
	vmovq	xmm14, rsi
	vfmadd231ps	xmm13, xmm23, xmm11
	vcvtdq2ps	xmm23, xmm8
	vmovq	xmm8, QWORD PTR 16[rdi]
	vfmadd132ps	xmm23, xmm8, xmm9
	vmovq	xmm8, rbx
	vpsrlq	xmm8, xmm8, 32
	vpmovzxwd	xmm8, xmm8
	vmovq	xmm8, xmm8
	vaddps	xmm13, xmm28, xmm13
	vfmadd231ps	xmm23, xmm24, xmm11
	vcvtdq2ps	xmm24, xmm8
	vmovq	xmm8, QWORD PTR 24[rdi]
	vmovlps	QWORD PTR 8[rdi], xmm13
	vfmadd132ps	xmm24, xmm8, xmm9
	vmovaps	xmm8, xmm22
	vaddps	xmm13, xmm31, xmm23
	vfmadd132ps	xmm8, xmm24, xmm11
	vmovlps	QWORD PTR 16[rdi], xmm13
	vpmovzxwd	xmm13, xmm14
	vmovq	xmm13, xmm13
	vcvtdq2ps	xmm13, xmm13
	vaddps	xmm8, xmm8, xmm26
	vmovlps	QWORD PTR 24[rdi], xmm8
	vmovq	xmm8, QWORD PTR [rcx]
	vfmadd132ps	xmm21, xmm8, xmm9
	vpsrlq	xmm8, xmm14, 32
	vpmovzxwd	xmm8, xmm8
	vmovq	xmm14, xmm8
	vmovq	xmm8, QWORD PTR 8[rcx]
	vcvtdq2ps	xmm14, xmm14
	vfmadd132ps	xmm15, xmm8, xmm9
	vmovq	xmm8, QWORD PTR 16[rcx]
	vfmadd132ps	xmm13, xmm21, xmm11
	vfmadd132ps	xmm19, xmm8, xmm9
	vmovq	xmm8, r11
	vpsrlq	xmm8, xmm8, 32
	vpmovzxwd	xmm8, xmm8
	vfmadd132ps	xmm14, xmm15, xmm11
	vmovq	xmm15, r11
	vmovq	xmm8, xmm8
	vpmovzxwd	xmm15, xmm15
	vaddps	xmm13, xmm13, XMMWORD PTR 448[rsp]
	vmovq	xmm15, xmm15
	vcvtdq2ps	xmm15, xmm15
	vfmadd132ps	xmm15, xmm19, xmm11
	vcvtdq2ps	xmm19, xmm8
	vmovq	xmm8, QWORD PTR 24[rcx]
	vmovlps	QWORD PTR [rcx], xmm13
	vfmadd132ps	xmm18, xmm8, xmm12
	vmovaps	xmm8, xmm19
	vaddps	xmm14, xmm14, XMMWORD PTR 432[rsp]
	vaddps	xmm12, xmm15, XMMWORD PTR 384[rsp]
	vmovlps	QWORD PTR 8[rcx], xmm14
	vfmadd132ps	xmm8, xmm18, xmm11
	vmovlps	QWORD PTR 16[rcx], xmm12
	vaddps	xmm8, xmm8, xmm16
	vmovlps	QWORD PTR 24[rcx], xmm8
	mov	ecx, r10d
	and	ecx, -8
	and	r10d, 7
	je	.L59
	add	r8d, ecx
.L65:
	mov	edi, DWORD PTR 480[rsp]
	lea	r9d, 1[r8]
	lea	ebx, -2[rdi]
	mov	DWORD PTR 384[rsp], ebx
	cmp	r9d, ebx
	jge	.L66
	cmp	r8d, edi
	jge	.L66
	mov	rsi, QWORD PTR 472[rsp]
	mov	rbx, QWORD PTR 416[rsp]
	movsxd	rcx, r8d
	mov	QWORD PTR 280[rsp], rax
	lea	r9, [rcx+r13]
	lea	r8, [rcx+rax]
	mov	r14, QWORD PTR 488[rsp]
	mov	QWORD PTR 312[rsp], rdx
	sal	rsi, 2
	mov	QWORD PTR 304[rsp], r13
	lea	rdi, [rbx+rsi]
	mov	rbx, QWORD PTR 408[rsp]
	lea	r10, [rcx+r14]
	add	rbx, rsi
	mov	QWORD PTR 432[rsp], rbx
	mov	rbx, QWORD PTR 464[rsp]
	movzx	esi, BYTE PTR [rbx+r9]
	movzx	r15d, BYTE PTR [rbx+r10]
	lea	r11, [rbx+r13]
	add	r14, rbx
	lea	r12, [rbx+rax]
	mov	DWORD PTR 448[rsp], esi
	movzx	esi, BYTE PTR [rbx+r8]
	mov	DWORD PTR 472[rsp], esi
	movzx	esi, BYTE PTR 1[rbx+r10]
	movzx	r10d, BYTE PTR 2[rbx+r10]
	mov	DWORD PTR 352[rsp], esi
	movzx	esi, BYTE PTR 1[rbx+r9]
	movzx	r9d, BYTE PTR 2[rbx+r9]
	mov	DWORD PTR 336[rsp], esi
	movzx	esi, BYTE PTR 1[rbx+r8]
	mov	DWORD PTR 368[rsp], r9d
	mov	edx, DWORD PTR 352[rsp]
	mov	DWORD PTR 320[rsp], esi
	mov	rsi, QWORD PTR 432[rsp]
	mov	DWORD PTR 432[rsp], r15d
	movzx	r9d, BYTE PTR 2[rbx+r8]
	mov	ebx, DWORD PTR 368[rsp]
	mov	r8d, DWORD PTR 336[rsp]
	mov	r13d, DWORD PTR 320[rsp]
.L67:
	vcvtusi2ss	xmm8, xmm10, DWORD PTR 432[rsp]
	movzx	eax, BYTE PTR 3[r11+rcx]
	vmovaps	xmm16, xmm6
	mov	QWORD PTR 368[rsp], rcx
	vcvtusi2ss	xmm12, xmm10, DWORD PTR 472[rsp]
	vcvtusi2ss	xmm13, xmm10, DWORD PTR 448[rsp]
	mov	DWORD PTR 448[rsp], eax
	vmovaps	xmm15, xmm8
	vcvtusi2ss	xmm8, xmm10, eax
	movzx	eax, BYTE PTR 3[r14+rcx]
	vmovaps	xmm14, xmm12
	vcvtusi2ss	xmm12, xmm10, eax
	vfmadd213ss	xmm16, xmm13, DWORD PTR [rdi+rcx*4]
	mov	DWORD PTR 432[rsp], eax
	movzx	eax, BYTE PTR 3[r12+rcx]
	vmulss	xmm18, xmm7, xmm8
	mov	DWORD PTR 472[rsp], eax
	vfmadd132ss	xmm12, xmm18, xmm5
	vaddss	xmm12, xmm12, xmm16
	vmovaps	xmm16, xmm6
	vfmadd231ss	xmm12, xmm4, xmm15
	vmovss	DWORD PTR [rdi+rcx*4], xmm12
	vcvtusi2ss	xmm12, xmm10, eax
	vfmadd213ss	xmm13, xmm4, DWORD PTR [rsi+rcx*4]
	vmulss	xmm12, xmm12, xmm7
	vfmadd132ss	xmm8, xmm12, xmm5
	vcvtusi2ss	xmm12, xmm10, r13d
	movzx	r13d, BYTE PTR 4[r12+rcx]
	vaddss	xmm8, xmm8, xmm13
	vcvtusi2ss	xmm13, xmm10, r8d
	movzx	r8d, BYTE PTR 4[r11+rcx]
	vfmadd231ss	xmm8, xmm6, xmm14
	vmovaps	xmm14, xmm12
	vmovss	DWORD PTR [rsi+rcx*4], xmm8
	vcvtusi2ss	xmm8, xmm10, edx
	movzx	edx, BYTE PTR 4[r14+rcx]
	vfmadd213ss	xmm16, xmm13, DWORD PTR 4[rdi+rcx*4]
	vcvtusi2ss	xmm12, xmm10, edx
	vmovaps	xmm15, xmm8
	vcvtusi2ss	xmm8, xmm10, r8d
	vmulss	xmm18, xmm7, xmm8
	vfmadd132ss	xmm12, xmm18, xmm5
	vaddss	xmm12, xmm12, xmm16
	vmovaps	xmm16, xmm6
	vfmadd231ss	xmm12, xmm4, xmm15
	vmovss	DWORD PTR 4[rdi+rcx*4], xmm12
	vcvtusi2ss	xmm12, xmm10, r13d
	vfmadd213ss	xmm13, xmm4, DWORD PTR 4[rsi+rcx*4]
	vmulss	xmm12, xmm12, xmm7
	vfmadd132ss	xmm8, xmm12, xmm5
	vcvtusi2ss	xmm12, xmm10, r9d
	movzx	r9d, BYTE PTR 5[r12+rcx]
	vaddss	xmm8, xmm8, xmm13
	vcvtusi2ss	xmm13, xmm10, ebx
	movzx	ebx, BYTE PTR 5[r11+rcx]
	vfmadd231ss	xmm8, xmm6, xmm14
	vmovaps	xmm14, xmm12
	vmovss	DWORD PTR 4[rsi+rcx*4], xmm8
	vcvtusi2ss	xmm8, xmm10, r10d
	movzx	r10d, BYTE PTR 5[r14+rcx]
	vfmadd213ss	xmm16, xmm13, DWORD PTR 8[rdi+rcx*4]
	vcvtusi2ss	xmm12, xmm10, r10d
	vmovaps	xmm15, xmm8
	vcvtusi2ss	xmm8, xmm10, ebx
	vmulss	xmm18, xmm7, xmm8
	vfmadd132ss	xmm12, xmm18, xmm5
	vaddss	xmm12, xmm12, xmm16
	vfmadd231ss	xmm12, xmm4, xmm15
	vmovss	DWORD PTR 8[rdi+rcx*4], xmm12
	vcvtusi2ss	xmm12, xmm10, r9d
	vfmadd213ss	xmm13, xmm4, DWORD PTR 8[rsi+rcx*4]
	vmulss	xmm12, xmm12, xmm7
	vfmadd132ss	xmm8, xmm12, xmm5
	vaddss	xmm8, xmm8, xmm13
	vfmadd231ss	xmm8, xmm6, xmm14
	vmovss	DWORD PTR 8[rsi+rcx*4], xmm8
	add	rcx, 3
	lea	r15d, 1[rcx]
	cmp	r15d, DWORD PTR 384[rsp]
	jl	.L67
	mov	rbx, QWORD PTR 368[rsp]
	mov	rdx, QWORD PTR 312[rsp]
	mov	r13, QWORD PTR 304[rsp]
	mov	rax, QWORD PTR 280[rsp]
	lea	r8d, 3[rbx]
	lea	r9d, 4[rbx]
.L66:
	mov	rbx, QWORD PTR 464[rsp]
	mov	ecx, r8d
	mov	r11, QWORD PTR 488[rsp]
	lea	rsi, 0[r13+rcx]
	mov	r12d, DWORD PTR 424[rsp]
	mov	r14, QWORD PTR 416[rsp]
	movzx	edi, BYTE PTR [rbx+rsi]
	movzx	esi, BYTE PTR 3[rbx+rsi]
	lea	r10, [r11+rcx]
	add	rcx, rax
	mov	r15, QWORD PTR 408[rsp]
	vcvtusi2ss	xmm13, xmm10, esi
	movzx	esi, BYTE PTR [rbx+rcx]
	movzx	ecx, BYTE PTR 3[rbx+rcx]
	vcvtusi2ss	xmm14, xmm10, edi
	movzx	edi, BYTE PTR [rbx+r10]
	vcvtusi2ss	xmm8, xmm10, esi
	vmulss	xmm18, xmm6, xmm14
	vmulss	xmm15, xmm6, xmm8
	vcvtusi2ss	xmm8, xmm10, ecx
	lea	ecx, [r12+r8]
	sal	rcx, 2
	vmovaps	xmm12, xmm8
	vcvtusi2ss	xmm8, xmm10, edi
	movzx	edi, BYTE PTR 3[rbx+r10]
	vcvtusi2ss	xmm16, xmm10, edi
	vfmadd213ss	xmm8, xmm4, DWORD PTR [r14+rcx]
	vfmadd132ss	xmm16, xmm18, xmm5
	vfmadd231ss	xmm8, xmm7, xmm13
	vfmadd132ss	xmm13, xmm15, xmm5
	vaddss	xmm8, xmm8, xmm16
	vmovss	DWORD PTR [r14+rcx], xmm8
	vmovaps	xmm8, xmm12
	vfmadd213ss	xmm14, xmm4, DWORD PTR [r15+rcx]
	vfmadd132ss	xmm8, xmm14, xmm7
	vaddss	xmm8, xmm8, xmm13
	vmovss	DWORD PTR [r15+rcx], xmm8
	cmp	r9d, DWORD PTR 480[rsp]
	jge	.L59
	mov	ecx, r9d
	lea	rsi, [rcx+r13]
	lea	r10, [rcx+r11]
	add	rcx, rax
	movzx	edi, BYTE PTR [rbx+rsi]
	movzx	esi, BYTE PTR 3[rbx+rsi]
	vcvtusi2ss	xmm13, xmm10, esi
	movzx	esi, BYTE PTR [rbx+rcx]
	movzx	ecx, BYTE PTR 3[rbx+rcx]
	vcvtusi2ss	xmm14, xmm10, edi
	vcvtusi2ss	xmm8, xmm10, esi
	movzx	esi, BYTE PTR [rbx+r10]
	vmulss	xmm18, xmm6, xmm14
	vmulss	xmm15, xmm6, xmm8
	vcvtusi2ss	xmm8, xmm10, ecx
	lea	ecx, [r12+r9]
	lea	rdi, 0[0+rcx*4]
	vmovaps	xmm12, xmm8
	vcvtusi2ss	xmm8, xmm10, esi
	movzx	esi, BYTE PTR 3[rbx+r10]
	vcvtusi2ss	xmm16, xmm10, esi
	vfmadd213ss	xmm8, xmm4, DWORD PTR [r14+rdi]
	vfmadd132ss	xmm16, xmm18, xmm5
	vfmadd231ss	xmm8, xmm7, xmm13
	vfmadd132ss	xmm13, xmm15, xmm5
	vaddss	xmm8, xmm8, xmm16
	vmovss	DWORD PTR [r14+rdi], xmm8
	vmovaps	xmm8, xmm12
	vfmadd213ss	xmm14, xmm4, DWORD PTR [r15+rdi]
	vfmadd132ss	xmm8, xmm14, xmm7
	vaddss	xmm8, xmm8, xmm13
	vmovss	DWORD PTR [r15+rdi], xmm8
	lea	edi, 2[r8]
	cmp	edi, DWORD PTR 480[rsp]
	jge	.L59
	mov	r8d, edi
	lea	rcx, [r8+r13]
	add	rax, r8
	lea	r9, [r11+r8]
	movzx	esi, BYTE PTR [rbx+rcx]
	movzx	ecx, BYTE PTR 3[rbx+rcx]
	vcvtusi2ss	xmm13, xmm10, ecx
	movzx	ecx, BYTE PTR [rbx+rax]
	movzx	eax, BYTE PTR 3[rbx+rax]
	vcvtusi2ss	xmm14, xmm10, esi
	vcvtusi2ss	xmm8, xmm10, ecx
	vmulss	xmm15, xmm6, xmm8
	vcvtusi2ss	xmm8, xmm10, eax
	lea	eax, [r12+rdi]
	lea	rsi, 0[0+rax*4]
	movzx	eax, BYTE PTR [rbx+r9]
	vmovaps	xmm12, xmm8
	vcvtusi2ss	xmm8, xmm10, eax
	movzx	eax, BYTE PTR 3[rbx+r9]
	vfmadd213ss	xmm8, xmm4, DWORD PTR [r14+rsi]
.L221:
	vmulss	xmm18, xmm6, xmm14
	vcvtusi2ss	xmm16, xmm10, eax
	vfmadd231ss	xmm8, xmm7, xmm13
	vfmadd132ss	xmm13, xmm15, xmm5
	vfmadd132ss	xmm16, xmm18, xmm5
	vaddss	xmm8, xmm8, xmm16
	vmovss	DWORD PTR [r14+rsi], xmm8
	vmovaps	xmm8, xmm12
	vfmadd213ss	xmm14, xmm4, DWORD PTR [r15+rsi]
	vfmadd132ss	xmm8, xmm14, xmm7
	vaddss	xmm8, xmm8, xmm13
	vmovss	DWORD PTR [r15+rsi], xmm8
.L59:
	add	DWORD PTR 252[rsp], 2
.L51:
	mov	ebx, DWORD PTR 252[rsp]
	cmp	DWORD PTR 248[rsp], ebx
	jle	.L40
	mov	eax, DWORD PTR 4[rdx]
	mov	ecx, DWORD PTR 228[rsp]
	mov	r11, QWORD PTR 160[rsp]
	mov	esi, DWORD PTR 496[rsp]
	add	eax, ebx
	add	ecx, DWORD PTR [rdx]
	sub	ebx, DWORD PTR 224[rsp]
	cdqe
	movsxd	rcx, ecx
	mov	r8, QWORD PTR 40[rdx]
	imul	rax, QWORD PTR 184[rsp]
	add	rax, rcx
	lea	rdi, [rax+rax*2]
	mov	rax, QWORD PTR 136[rsp]
	mov	r13, rdi
	lea	r9, [rax+rdi]
	movsxd	rax, ebx
	mov	rbx, QWORD PTR 216[rsp]
	imul	r11, rax
	mov	eax, DWORD PTR 228[rsp]
	sub	eax, DWORD PTR 204[rsp]
	cdqe
	lea	rax, [rax+rax*2]
	add	rax, r11
	lea	r14, [rbx+rax*4]
	cmp	esi, 15
	jle	.L70
	mov	r10d, esi
	lea	rcx, [r8+r9]
	lea	ebx, -16[rsi]
	mov	rax, r14
	shr	r10d, 4
	sal	r10, 6
	add	r10, r14
	.p2align 4,,10
	.p2align 3
.L71:
	mov	rsi, rcx
	vpmovzxbd	ymm14, QWORD PTR [rcx]
	vpmovzxbd	ymm13, QWORD PTR 8[rcx]
	add	rax, 64
	sub	rsi, r9
	vpmovzxbd	ymm12, QWORD PTR 3[rcx]
	vpmovzxbd	ymm8, QWORD PTR 11[rcx]
	add	rcx, 16
	vpmovzxbd	ymm19, QWORD PTR [rsi+rdi]
	vpmovzxbd	ymm18, QWORD PTR 8[rsi+rdi]
	vcvtdq2ps	ymm14, ymm14
	vcvtdq2ps	ymm13, ymm13
	vpmovzxbd	ymm16, QWORD PTR 3[rsi+rdi]
	vpmovzxbd	ymm15, QWORD PTR 11[rsi+rdi]
	vcvtdq2ps	ymm12, ymm12
	vcvtdq2ps	ymm8, ymm8
	vcvtdq2ps	ymm19, ymm19
	vcvtdq2ps	ymm18, ymm18
	vfmadd213ps	ymm19, ymm0, YMMWORD PTR -64[rax]
	vfmadd213ps	ymm18, ymm0, YMMWORD PTR -32[rax]
	vcvtdq2ps	ymm16, ymm16
	vcvtdq2ps	ymm15, ymm15
	vfmadd132ps	ymm16, ymm19, ymm1
	vfmadd132ps	ymm15, ymm18, ymm1
	vfmadd132ps	ymm14, ymm16, ymm2
	vfmadd132ps	ymm13, ymm15, ymm2
	vfmadd132ps	ymm12, ymm14, ymm3
	vfmadd132ps	ymm8, ymm13, ymm3
	vmovups	YMMWORD PTR -64[rax], ymm12
	vmovups	YMMWORD PTR -32[rax], ymm8
	cmp	r10, rax
	jne	.L71
	mov	eax, ebx
	and	eax, -16
	lea	ecx, 23[rax]
	lea	r15d, 16[rax]
	cmp	ecx, DWORD PTR 496[rsp]
	jge	.L76
	lea	esi, 16[rax]
	lea	r15d, 24[rax]
	lea	rcx, [rdi+rsi]
	lea	r10, [r9+rsi]
	lea	rsi, [r14+rsi*4]
.L73:
	vpmovzxbd	ymm14, QWORD PTR [r8+rcx]
	vpmovzxbd	ymm13, QWORD PTR 3[r8+rcx]
	vpmovzxbd	ymm12, QWORD PTR [r8+r10]
	vpmovzxbd	ymm8, QWORD PTR 3[r8+r10]
	vcvtdq2ps	ymm14, ymm14
	vfmadd213ps	ymm14, ymm0, YMMWORD PTR [rsi]
	vcvtdq2ps	ymm13, ymm13
	vcvtdq2ps	ymm12, ymm12
	vcvtdq2ps	ymm8, ymm8
	vfmadd132ps	ymm13, ymm14, ymm1
	vfmadd132ps	ymm12, ymm13, ymm2
	vfmadd132ps	ymm8, ymm12, ymm3
	vmovups	YMMWORD PTR [rsi], ymm8
.L76:
	mov	eax, DWORD PTR 496[rsp]
	sub	eax, r15d
	mov	DWORD PTR 192[rsp], eax
	test	eax, eax
	jle	.L40
	mov	ebx, r15d
	lea	r13, [rdi+rbx]
	add	r9, rbx
.L74:
	mov	r12d, DWORD PTR 228[rsp]
	mov	eax, DWORD PTR 192[rsp]
	lea	rsi, [r8+r9]
	mov	rdi, QWORD PTR 216[rsp]
	sub	r12, QWORD PTR 176[rsp]
	lea	r10, 3[rax+r9]
	lea	rcx, [r12+r12*2]
	add	r10, r8
	add	rcx, r11
	lea	r12, [rcx+rbx]
	lea	r11, [rdi+r12*4]
	lea	rcx, [r12+rax]
	cmp	r11, r10
	lea	rcx, [rdi+rcx*4]
	mov	QWORD PTR 496[rsp], r11
	lea	rdi, [r8+r13]
	setnb	r11b
	cmp	rsi, rcx
	setnb	r10b
	or	r11b, r10b
	je	.L77
	lea	rax, 3[rax+r13]
	add	rax, r8
	cmp	QWORD PTR 496[rsp], rax
	setnb	r10b
	cmp	rdi, rcx
	setnb	cl
	or	r10b, cl
	je	.L77
	mov	ebx, DWORD PTR 192[rsp]
	lea	eax, -1[rbx]
	cmp	eax, 30
	jbe	.L125
	shr	ebx, 5
	mov	rax, QWORD PTR 496[rsp]
	lea	r11, 3[r8+r9]
	lea	r10, 3[r8+r13]
	mov	DWORD PTR 488[rsp], ebx
	xor	ecx, ecx
	sal	rbx, 5
	.p2align 4,,10
	.p2align 3
.L79:
	vmovdqu	ymm8, YMMWORD PTR [rsi+rcx]
	vmovdqu	ymm12, YMMWORD PTR [r10+rcx]
	sub	rax, -128
	vmovdqu	ymm13, YMMWORD PTR [rdi+rcx]
	vpmovzxbw	ymm14, xmm8
	vpmovzxbw	ymm15, xmm12
	vextracti32x4	xmm8, ymm8, 0x1
	vpmovsxwd	ymm18, xmm14
	vpmovsxwd	ymm16, xmm15
	vpmovzxbw	ymm8, xmm8
	vcvtdq2ps	ymm18, ymm18
	vmulps	ymm18, ymm18, ymm2
	vcvtdq2ps	ymm16, ymm16
	vextracti32x4	xmm12, ymm12, 0x1
	vpmovzxbw	ymm19, xmm13
	vpmovzxbw	ymm12, xmm12
	vpmovsxwd	ymm21, xmm19
	vextracti32x4	xmm13, ymm13, 0x1
	vcvtdq2ps	ymm21, ymm21
	vfmadd213ps	ymm21, ymm0, YMMWORD PTR -128[rax]
	vextracti32x4	xmm19, ymm19, 0x1
	vpmovzxbw	ymm13, xmm13
	vpmovsxwd	ymm19, xmm19
	vcvtdq2ps	ymm19, ymm19
	vfmadd213ps	ymm19, ymm0, YMMWORD PTR -96[rax]
	vfmadd132ps	ymm16, ymm18, ymm1
	vextracti32x4	xmm18, ymm15, 0x1
	vextracti32x4	xmm15, ymm14, 0x1
	vpmovsxwd	ymm15, xmm15
	vpmovsxwd	ymm18, xmm18
	vcvtdq2ps	ymm15, ymm15
	vmulps	ymm15, ymm15, ymm2
	vcvtdq2ps	ymm14, ymm18
	vpmovsxwd	ymm18, xmm12
	vextracti32x4	xmm12, ymm12, 0x1
	vpmovsxwd	ymm12, xmm12
	vcvtdq2ps	ymm18, ymm18
	vcvtdq2ps	ymm12, ymm12
	vfmadd132ps	ymm14, ymm15, ymm1
	vpmovsxwd	ymm15, xmm8
	vextracti32x4	xmm8, ymm8, 0x1
	vpmovsxwd	ymm8, xmm8
	vcvtdq2ps	ymm15, ymm15
	vcvtdq2ps	ymm8, ymm8
	vmulps	ymm8, ymm8, ymm2
	vmulps	ymm15, ymm15, ymm2
	vfmadd132ps	ymm12, ymm8, ymm1
	vmovdqu	ymm8, YMMWORD PTR [r11+rcx]
	add	rcx, 32
	vfmadd132ps	ymm18, ymm15, ymm1
	vpmovzxbw	ymm15, xmm8
	vextracti32x4	xmm8, ymm8, 0x1
	vpmovsxwd	ymm20, xmm15
	vextracti32x4	xmm15, ymm15, 0x1
	vpmovzxbw	ymm8, xmm8
	vcvtdq2ps	ymm20, ymm20
	vfmadd132ps	ymm20, ymm21, ymm3
	vpmovsxwd	ymm21, xmm13
	vextracti32x4	xmm13, ymm13, 0x1
	vpmovsxwd	ymm13, xmm13
	vcvtdq2ps	ymm21, ymm21
	vfmadd213ps	ymm21, ymm0, YMMWORD PTR -64[rax]
	vpmovsxwd	ymm15, xmm15
	vcvtdq2ps	ymm13, ymm13
	vfmadd213ps	ymm13, ymm0, YMMWORD PTR -32[rax]
	vcvtdq2ps	ymm15, ymm15
	vfmadd132ps	ymm15, ymm19, ymm3
	vpmovsxwd	ymm19, xmm8
	vextracti32x4	xmm8, ymm8, 0x1
	vcvtdq2ps	ymm19, ymm19
	vpmovsxwd	ymm8, xmm8
	vcvtdq2ps	ymm8, ymm8
	vaddps	ymm16, ymm16, ymm20
	vfmadd132ps	ymm19, ymm21, ymm3
	vfmadd132ps	ymm8, ymm13, ymm3
	vaddps	ymm14, ymm14, ymm15
	vmovups	YMMWORD PTR -128[rax], ymm16
	vmovups	YMMWORD PTR -96[rax], ymm14
	vaddps	ymm18, ymm18, ymm19
	vaddps	ymm8, ymm8, ymm12
	vmovups	YMMWORD PTR -64[rax], ymm18
	vmovups	YMMWORD PTR -32[rax], ymm8
	cmp	rcx, rbx
	jne	.L79
	mov	edi, DWORD PTR 488[rsp]
	sal	edi, 5
	cmp	edi, DWORD PTR 192[rsp]
	je	.L40
	mov	esi, edi
.L78:
	mov	r11d, DWORD PTR 192[rsp]
	sub	r11d, edi
	lea	eax, -1[r11]
	cmp	eax, 14
	jbe	.L126
	mov	eax, edi
	mov	rbx, QWORD PTR 216[rsp]
	lea	r10, [rax+r9]
	lea	rcx, [rax+r13]
	add	rax, r12
	vmovdqu	xmm3, XMMWORD PTR [r8+r10]
	vmovdqu	xmm0, XMMWORD PTR [r8+rcx]
	lea	rax, [rbx+rax*4]
	vpmovzxbw	xmm1, xmm3
	vpsrldq	xmm3, xmm3, 8
	vpmovzxbw	xmm16, xmm0
	vpmovsxwd	xmm12, xmm1
	vpsrldq	xmm1, xmm1, 8
	vpmovzxbw	xmm3, xmm3
	vpsrldq	xmm0, xmm0, 8
	vpmovsxwd	xmm1, xmm1
	vcvtdq2ps	xmm12, xmm12
	vcvtdq2ps	xmm1, xmm1
	vmulps	xmm1, xmm1, xmm25
	vpmovzxbw	xmm2, xmm0
	vmovdqu	xmm0, XMMWORD PTR 3[r8+rcx]
	vmulps	xmm12, xmm12, xmm25
	vpmovzxbw	xmm8, xmm0
	vpsrldq	xmm0, xmm0, 8
	vpmovsxwd	xmm13, xmm8
	vpsrldq	xmm8, xmm8, 8
	vpmovzxbw	xmm0, xmm0
	vpmovsxwd	xmm8, xmm8
	vcvtdq2ps	xmm13, xmm13
	vcvtdq2ps	xmm8, xmm8
	vfmadd132ps	xmm8, xmm1, xmm17
	vpmovsxwd	xmm1, xmm3
	vcvtdq2ps	xmm1, xmm1
	vmulps	xmm1, xmm1, xmm25
	vfmadd132ps	xmm13, xmm12, xmm17
	vpmovsxwd	xmm12, xmm0
	vcvtdq2ps	xmm12, xmm12
	vfmadd132ps	xmm12, xmm1, xmm17
	vpsrldq	xmm1, xmm0, 8
	vpsrldq	xmm0, xmm3, 8
	vpmovsxwd	xmm3, xmm16
	vpmovsxwd	xmm1, xmm1
	vpmovsxwd	xmm0, xmm0
	vcvtdq2ps	xmm3, xmm3
	vfmadd213ps	xmm3, xmm9, XMMWORD PTR [rax]
	vcvtdq2ps	xmm1, xmm1
	vcvtdq2ps	xmm0, xmm0
	vmulps	xmm0, xmm0, xmm25
	vfmadd132ps	xmm1, xmm0, xmm17
	vmovdqu	xmm0, XMMWORD PTR 3[r8+r10]
	vpmovzxbw	xmm14, xmm0
	vpsrldq	xmm0, xmm0, 8
	vpmovsxwd	xmm15, xmm14
	vpsrldq	xmm14, xmm14, 8
	vpmovzxbw	xmm0, xmm0
	vcvtdq2ps	xmm15, xmm15
	vfmadd132ps	xmm15, xmm3, xmm11
	vpsrldq	xmm3, xmm16, 8
	vpmovsxwd	xmm16, xmm2
	vpmovsxwd	xmm3, xmm3
	vpsrldq	xmm2, xmm2, 8
	vcvtdq2ps	xmm16, xmm16
	vpmovsxwd	xmm14, xmm14
	vcvtdq2ps	xmm3, xmm3
	vfmadd213ps	xmm3, xmm9, XMMWORD PTR 16[rax]
	vfmadd213ps	xmm16, xmm9, XMMWORD PTR 32[rax]
	vpmovsxwd	xmm2, xmm2
	vcvtdq2ps	xmm14, xmm14
	vcvtdq2ps	xmm2, xmm2
	vfmadd213ps	xmm2, xmm9, XMMWORD PTR 48[rax]
	vaddps	xmm13, xmm13, xmm15
	vfmadd132ps	xmm14, xmm3, xmm11
	vpmovsxwd	xmm3, xmm0
	vpsrldq	xmm0, xmm0, 8
	vcvtdq2ps	xmm3, xmm3
	vfmadd132ps	xmm3, xmm16, xmm11
	vmovups	XMMWORD PTR [rax], xmm13
	vpmovsxwd	xmm0, xmm0
	vcvtdq2ps	xmm0, xmm0
	vfmadd132ps	xmm0, xmm2, xmm11
	vaddps	xmm8, xmm8, xmm14
	vaddps	xmm12, xmm12, xmm3
	vaddps	xmm0, xmm0, xmm1
	vmovups	XMMWORD PTR 16[rax], xmm8
	vmovups	XMMWORD PTR 32[rax], xmm12
	vmovups	XMMWORD PTR 48[rax], xmm0
	mov	eax, r11d
	and	eax, -16
	test	r11b, 15
	je	.L40
	add	esi, eax
.L80:
	sub	r11d, eax
	lea	ecx, -1[r11]
	cmp	ecx, 6
	jbe	.L81
	add	eax, edi
	mov	rbx, QWORD PTR 216[rsp]
	vmovaps	xmm16, xmm9
	mov	eax, eax
	lea	rdi, [rax+r9]
	lea	rcx, [rax+r13]
	add	rax, r12
	vmovq	xmm1, QWORD PTR [r8+rdi]
	vmovq	xmm0, QWORD PTR [r8+rcx]
	lea	rax, [rbx+rax*4]
	vpmovzxbw	xmm12, xmm1
	vpsrlq	xmm1, xmm1, 32
	vpmovzxbw	xmm8, xmm0
	vpmovzxwd	xmm14, xmm12
	vpsrlq	xmm0, xmm0, 32
	vpmovzxbw	xmm1, xmm1
	vmovq	xmm14, xmm14
	vpsrlq	xmm12, xmm12, 32
	vpmovzxbw	xmm2, xmm0
	vmovq	xmm0, QWORD PTR 3[r8+rcx]
	vcvtdq2ps	xmm14, xmm14
	vmulps	xmm14, xmm14, xmm25
	vpmovzxwd	xmm12, xmm12
	vpmovzxbw	xmm3, xmm0
	vpsrlq	xmm0, xmm0, 32
	vmovq	xmm12, xmm12
	vpmovzxwd	xmm13, xmm3
	vcvtdq2ps	xmm12, xmm12
	vpsrlq	xmm3, xmm3, 32
	vpmovzxbw	xmm0, xmm0
	vmulps	xmm12, xmm12, xmm25
	vmovq	xmm13, xmm13
	vpmovzxwd	xmm3, xmm3
	vcvtdq2ps	xmm13, xmm13
	vmovq	xmm3, xmm3
	vfmadd132ps	xmm13, xmm14, xmm17
	vpmovzxwd	xmm14, xmm1
	vcvtdq2ps	xmm3, xmm3
	vmovq	xmm14, xmm14
	vcvtdq2ps	xmm14, xmm14
	vmulps	xmm14, xmm14, xmm25
	vfmadd132ps	xmm3, xmm12, xmm17
	vpmovzxwd	xmm12, xmm0
	vmovq	xmm12, xmm12
	vcvtdq2ps	xmm12, xmm12
	vfmadd132ps	xmm12, xmm14, xmm17
	vpsrlq	xmm14, xmm0, 32
	vpsrlq	xmm0, xmm1, 32
	vpmovzxwd	xmm14, xmm14
	vpmovzxwd	xmm0, xmm0
	vmovq	xmm14, xmm14
	vmovq	xmm0, xmm0
	vcvtdq2ps	xmm14, xmm14
	vcvtdq2ps	xmm0, xmm0
	vmulps	xmm0, xmm0, xmm25
	vfmadd132ps	xmm14, xmm0, xmm17
	vmovq	xmm0, QWORD PTR 3[r8+rdi]
	vpmovzxbw	xmm1, xmm0
	vpsrlq	xmm0, xmm0, 32
	vpmovzxwd	xmm15, xmm1
	vpmovzxbw	xmm0, xmm0
	vmovq	xmm18, xmm15
	vpmovzxwd	xmm15, xmm8
	vmovq	xmm15, xmm15
	vcvtdq2ps	xmm17, xmm15
	vmovq	xmm15, QWORD PTR [rax]
	vfmadd231ps	xmm15, xmm17, xmm9
	vcvtdq2ps	xmm9, xmm18
	vfmadd132ps	xmm9, xmm15, xmm11
	vpsrlq	xmm15, xmm1, 32
	vpsrlq	xmm1, xmm8, 32
	vmovq	xmm8, QWORD PTR 8[rax]
	vpmovzxwd	xmm15, xmm15
	vpmovzxwd	xmm1, xmm1
	vmovq	xmm15, xmm15
	vmovq	xmm1, xmm1
	vcvtdq2ps	xmm15, xmm15
	vcvtdq2ps	xmm1, xmm1
	vfmadd132ps	xmm1, xmm8, xmm16
	vpmovzxwd	xmm8, xmm0
	vmovq	xmm8, xmm8
	vpsrlq	xmm0, xmm0, 32
	vaddps	xmm13, xmm13, xmm9
	vcvtdq2ps	xmm8, xmm8
	vpmovzxwd	xmm0, xmm0
	vmovq	xmm0, xmm0
	vcvtdq2ps	xmm0, xmm0
	vmovlps	QWORD PTR [rax], xmm13
	vfmadd132ps	xmm15, xmm1, xmm11
	vpmovzxwd	xmm1, xmm2
	vmovq	xmm1, xmm1
	vcvtdq2ps	xmm17, xmm1
	vmovq	xmm1, QWORD PTR 16[rax]
	vfmadd231ps	xmm1, xmm17, xmm16
	vaddps	xmm3, xmm3, xmm15
	vmovlps	QWORD PTR 8[rax], xmm3
	vfmadd132ps	xmm8, xmm1, xmm11
	vpsrlq	xmm1, xmm2, 32
	vmovq	xmm2, QWORD PTR 24[rax]
	vpmovzxwd	xmm1, xmm1
	vmovq	xmm1, xmm1
	vcvtdq2ps	xmm1, xmm1
	vfmadd132ps	xmm1, xmm2, xmm16
	vaddps	xmm12, xmm12, xmm8
	vfmadd132ps	xmm0, xmm1, xmm11
	vmovlps	QWORD PTR 16[rax], xmm12
	vaddps	xmm0, xmm0, xmm14
	vmovlps	QWORD PTR 24[rax], xmm0
	mov	eax, r11d
	and	eax, -8
	and	r11d, 7
	je	.L40
	add	esi, eax
.L81:
	movsxd	rcx, esi
	mov	ebx, DWORD PTR 192[rsp]
	lea	rax, [rcx+r13]
	lea	r10, [rcx+r9]
	lea	ecx, [r15+rsi]
	lea	rdi, [r14+rcx*4]
	movzx	ecx, BYTE PTR [r8+rax]
	movzx	eax, BYTE PTR 3[r8+rax]
	vcvtusi2ss	xmm0, xmm10, ecx
	vmovaps	xmm2, xmm0
	vcvtusi2ss	xmm0, xmm10, eax
	movzx	eax, BYTE PTR [r8+r10]
	vfmadd213ss	xmm2, xmm4, DWORD PTR [rdi]
	vcvtusi2ss	xmm1, xmm10, eax
	movzx	eax, BYTE PTR 3[r8+r10]
	vmulss	xmm1, xmm1, xmm6
	vfmadd231ss	xmm1, xmm5, xmm0
	vcvtusi2ss	xmm0, xmm10, eax
	lea	eax, 1[rsi]
	vfmadd132ss	xmm0, xmm2, xmm7
	vaddss	xmm0, xmm0, xmm1
	vmovss	DWORD PTR [rdi], xmm0
	cmp	eax, ebx
	jge	.L40
	mov	ecx, eax
	add	eax, r15d
	lea	rdi, [rcx+r13]
	mov	eax, eax
	lea	r10, [rcx+r9]
	lea	rcx, [r14+rax*4]
	movzx	eax, BYTE PTR [r8+rdi]
	vcvtusi2ss	xmm0, xmm10, eax
	movzx	eax, BYTE PTR 3[r8+rdi]
	vmovaps	xmm2, xmm0
	vcvtusi2ss	xmm0, xmm10, eax
	movzx	eax, BYTE PTR [r8+r10]
	vfmadd213ss	xmm2, xmm4, DWORD PTR [rcx]
	vcvtusi2ss	xmm1, xmm10, eax
	movzx	eax, BYTE PTR 3[r8+r10]
	vmulss	xmm1, xmm1, xmm6
	vfmadd231ss	xmm1, xmm5, xmm0
	vcvtusi2ss	xmm0, xmm10, eax
	lea	eax, 2[rsi]
	vfmadd132ss	xmm0, xmm2, xmm7
	vaddss	xmm0, xmm0, xmm1
	vmovss	DWORD PTR [rcx], xmm0
	cmp	eax, ebx
	jge	.L40
	mov	ecx, eax
	add	eax, r15d
	lea	rdi, [rcx+r13]
	mov	eax, eax
	lea	r10, [rcx+r9]
	lea	rcx, [r14+rax*4]
	movzx	eax, BYTE PTR [r8+rdi]
	vcvtusi2ss	xmm0, xmm10, eax
	movzx	eax, BYTE PTR 3[r8+rdi]
	vmovaps	xmm2, xmm0
	vcvtusi2ss	xmm0, xmm10, eax
	movzx	eax, BYTE PTR [r8+r10]
	vfmadd213ss	xmm2, xmm4, DWORD PTR [rcx]
	vcvtusi2ss	xmm1, xmm10, eax
	movzx	eax, BYTE PTR 3[r8+r10]
	vmulss	xmm1, xmm1, xmm6
	vfmadd231ss	xmm1, xmm5, xmm0
	vcvtusi2ss	xmm0, xmm10, eax
	lea	eax, 3[rsi]
	vfmadd132ss	xmm0, xmm2, xmm7
	vaddss	xmm0, xmm0, xmm1
	vmovss	DWORD PTR [rcx], xmm0
	cmp	eax, ebx
	jge	.L40
	mov	ecx, eax
	add	eax, r15d
	lea	rdi, [rcx+r13]
	mov	eax, eax
	lea	r10, [rcx+r9]
	lea	rcx, [r14+rax*4]
	movzx	eax, BYTE PTR [r8+rdi]
	vcvtusi2ss	xmm0, xmm10, eax
	movzx	eax, BYTE PTR 3[r8+rdi]
	vmovaps	xmm2, xmm0
	vcvtusi2ss	xmm0, xmm10, eax
	movzx	eax, BYTE PTR [r8+r10]
	vfmadd213ss	xmm2, xmm4, DWORD PTR [rcx]
	vcvtusi2ss	xmm1, xmm10, eax
	movzx	eax, BYTE PTR 3[r8+r10]
	vmulss	xmm1, xmm1, xmm6
	vfmadd231ss	xmm1, xmm5, xmm0
	vcvtusi2ss	xmm0, xmm10, eax
	lea	eax, 4[rsi]
	vfmadd132ss	xmm0, xmm2, xmm7
	vaddss	xmm0, xmm0, xmm1
	vmovss	DWORD PTR [rcx], xmm0
	cmp	eax, ebx
	jge	.L40
	mov	ecx, eax
	add	eax, r15d
	lea	rdi, [rcx+r13]
	mov	eax, eax
	lea	r10, [rcx+r9]
	lea	rcx, [r14+rax*4]
	movzx	eax, BYTE PTR [r8+rdi]
	vcvtusi2ss	xmm0, xmm10, eax
	movzx	eax, BYTE PTR 3[r8+rdi]
	vmovaps	xmm2, xmm0
	vcvtusi2ss	xmm0, xmm10, eax
	movzx	eax, BYTE PTR [r8+r10]
	vfmadd213ss	xmm2, xmm4, DWORD PTR [rcx]
	vcvtusi2ss	xmm1, xmm10, eax
	movzx	eax, BYTE PTR 3[r8+r10]
	vmulss	xmm1, xmm1, xmm6
	vfmadd231ss	xmm1, xmm5, xmm0
	vcvtusi2ss	xmm0, xmm10, eax
	lea	eax, 5[rsi]
	vfmadd132ss	xmm0, xmm2, xmm7
	vaddss	xmm0, xmm0, xmm1
	vmovss	DWORD PTR [rcx], xmm0
	cmp	eax, ebx
	jge	.L40
	mov	ecx, eax
	add	eax, r15d
	lea	rdi, [rcx+r13]
	mov	eax, eax
	lea	r10, [rcx+r9]
	lea	rcx, [r14+rax*4]
	movzx	eax, BYTE PTR [r8+rdi]
	vcvtusi2ss	xmm0, xmm10, eax
	movzx	eax, BYTE PTR 3[r8+rdi]
	vmovaps	xmm2, xmm0
	vcvtusi2ss	xmm0, xmm10, eax
	movzx	eax, BYTE PTR [r8+r10]
	vfmadd213ss	xmm2, xmm4, DWORD PTR [rcx]
	vcvtusi2ss	xmm1, xmm10, eax
	movzx	eax, BYTE PTR 3[r8+r10]
	vmulss	xmm1, xmm1, xmm6
	vfmadd231ss	xmm1, xmm5, xmm0
	vcvtusi2ss	xmm0, xmm10, eax
	lea	eax, 6[rsi]
	vfmadd132ss	xmm0, xmm2, xmm7
	vaddss	xmm0, xmm0, xmm1
	vmovss	DWORD PTR [rcx], xmm0
	cmp	eax, ebx
	jge	.L40
	mov	ecx, eax
	add	eax, r15d
	lea	rsi, [rcx+r13]
	mov	eax, eax
	lea	rdi, [rcx+r9]
	lea	rcx, [r14+rax*4]
	movzx	eax, BYTE PTR [r8+rsi]
	vcvtusi2ss	xmm0, xmm10, eax
	movzx	eax, BYTE PTR 3[r8+rsi]
	vfmadd213ss	xmm4, xmm0, DWORD PTR [rcx]
	vcvtusi2ss	xmm0, xmm10, eax
	movzx	eax, BYTE PTR [r8+rdi]
	vcvtusi2ss	xmm1, xmm10, eax
	movzx	eax, BYTE PTR 3[r8+rdi]
	vmulss	xmm1, xmm1, xmm6
	vfmadd231ss	xmm1, xmm5, xmm0
	vcvtusi2ss	xmm0, xmm10, eax
	vfmadd132ss	xmm0, xmm4, xmm7
	vaddss	xmm0, xmm0, xmm1
	vmovss	DWORD PTR [rcx], xmm0
	.p2align 4,,10
	.p2align 3
.L40:
	add	rdx, 48
	cmp	QWORD PTR 208[rsp], rdx
	jne	.L83
.L226:
	mov	rbx, QWORD PTR 48[rsp]
	mov	r14d, DWORD PTR 88[rsp]
.L39:
	mov	r13d, DWORD PTR 196[rsp]
	cmp	DWORD PTR 36[rsp], r13d
	jge	.L84
	test	r14d, r14d
	jle	.L84
	lea	rax, [rbx+rbx*2]
	mov	r12, QWORD PTR 176[rsp]
	lea	r8d, [r14+r14*2]
	mov	rdi, QWORD PTR 216[rsp]
	lea	rbx, 0[0+rax*4]
	mov	rax, QWORD PTR 80[rsp]
	mov	r9, QWORD PTR 40[rsp]
	mov	r10d, DWORD PTR 224[rsp]
	vmovss	xmm3, DWORD PTR .LC5[rip]
	vmovss	xmm5, DWORD PTR .LC6[rip]
	mov	r14, QWORD PTR 184[rsp]
	lea	r11, [rax+r12*4]
	mov	r15, QWORD PTR 64[rsp]
	.p2align 4,,10
	.p2align 3
.L96:
	lea	rax, [r12+r9]
	mov	QWORD PTR 496[rsp], r9
	vmovss	xmm2, DWORD PTR .LC6[rip]
	lea	rcx, [r11+r9*4]
	lea	rsi, [rax+rax*2]
	vmovss	xmm4, DWORD PTR .LC5[rip]
	xor	edx, edx
	add	rsi, QWORD PTR 16[r15]
	.p2align 4,,10
	.p2align 3
.L95:
	mov	eax, DWORD PTR [rcx]
	test	eax, eax
	je	.L85
	vcvtsi2ss	xmm0, xmm10, eax
	mov	eax, edx
	xor	r9d, r9d
	vdivss	xmm0, xmm30, xmm0
	vmulss	xmm1, xmm0, DWORD PTR [rdi+rax*4]
	vcomiss	xmm29, xmm1
	ja	.L94
	vaddss	xmm1, xmm1, xmm3
	vminss	xmm1, xmm1, xmm5
	vcvttss2si	r9d, xmm1
.L94:
	vmulss	xmm1, xmm0, DWORD PTR 4[rdi+rax*4]
	mov	BYTE PTR [rsi+rax], r9b
	xor	r9d, r9d
	vcomiss	xmm29, xmm1
	ja	.L93
	vaddss	xmm1, xmm1, xmm3
	vminss	xmm1, xmm1, xmm2
	vcvttss2si	r9d, xmm1
.L93:
	vmulss	xmm0, xmm0, DWORD PTR 8[rdi+rax*4]
	mov	BYTE PTR 1[rsi+rax], r9b
	xor	r9d, r9d
	vcomiss	xmm29, xmm0
	ja	.L92
	vaddss	xmm0, xmm0, xmm4
	vminss	xmm0, xmm0, xmm2
	vcvttss2si	r9d, xmm0
.L92:
	mov	BYTE PTR 2[rsi+rax], r9b
.L85:
	add	edx, 3
	add	rcx, 4
	cmp	edx, r8d
	jne	.L95
	mov	r9, QWORD PTR 496[rsp]
	inc	r10d
	add	rdi, rbx
	add	r9, r14
	cmp	r13d, r10d
	jne	.L96
.L84:
	add	QWORD PTR 176[rsp], 2032
	mov	rax, QWORD PTR 176[rsp]
	cmp	DWORD PTR 144[rsp], eax
	jg	.L97
	add	QWORD PTR 120[rsp], 8
	mov	rax, QWORD PTR 16[rsp]
	mov	r14, QWORD PTR 40[rsp]
	mov	rbx, QWORD PTR 120[rsp]
	cmp	DWORD PTR 92[rsp], ebx
	jle	.L217
	mov	DWORD PTR 224[rsp], ebx
	add	r14, rax
	lea	edx, 8[rbx]
	jmp	.L99
	.p2align 4,,10
	.p2align 3
.L42:
	mov	esi, DWORD PTR 496[rsp]
	cmp	esi, 7
	jg	.L117
	mov	DWORD PTR 424[rsp], esi
	xor	esi, esi
	jmp	.L46
.L117:
	mov	rsi, QWORD PTR 448[rsp]
	mov	QWORD PTR 272[rsp], r15
	mov	rcx, rax
	mov	QWORD PTR 280[rsp], r12
	mov	QWORD PTR 352[rsp], rsi
	mov	rsi, QWORD PTR 472[rsp]
	mov	QWORD PTR 368[rsp], rdx
	mov	QWORD PTR 384[rsp], rsi
	mov	rsi, QWORD PTR 480[rsp]
	mov	QWORD PTR 408[rsp], rbx
	mov	QWORD PTR 416[rsp], rsi
	mov	rsi, QWORD PTR 488[rsp]
	mov	QWORD PTR 424[rsp], rsi
	mov	esi, 8
	jmp	.L45
.L57:
	lea	edi, 16[rsi]
	add	esi, 24
	mov	r14, QWORD PTR 416[rsp]
	mov	DWORD PTR 424[rsp], esi
	lea	r11, 0[0+rdi*4]
	lea	r10, [rcx+rdi]
	lea	r9, 0[r13+rdi]
	lea	r8, [r14+r11]
	add	rdi, rax
	add	r11, QWORD PTR 408[rsp]
.L55:
	mov	rsi, QWORD PTR 464[rsp]
	vpmovzxbd	ymm14, QWORD PTR [rsi+r10]
	vpmovzxbd	ymm8, QWORD PTR 3[rsi+r10]
	vpmovzxbd	ymm13, QWORD PTR [rsi+r9]
	vpmovzxbd	ymm12, QWORD PTR 3[rsi+r9]
	vcvtdq2ps	ymm14, ymm14
	vfmadd213ps	ymm14, ymm0, YMMWORD PTR [r8]
	vcvtdq2ps	ymm8, ymm8
	vcvtdq2ps	ymm13, ymm13
	vcvtdq2ps	ymm12, ymm12
	vfmadd132ps	ymm8, ymm14, ymm1
	vpmovzxbd	ymm14, QWORD PTR [rsi+rdi]
	vcvtdq2ps	ymm14, ymm14
	vfmadd231ps	ymm8, ymm2, ymm13
	vfmadd231ps	ymm8, ymm3, ymm12
	vmovups	YMMWORD PTR [r8], ymm8
	vpmovzxbd	ymm8, QWORD PTR 3[rsi+rdi]
	vfmadd213ps	ymm13, ymm0, YMMWORD PTR [r11]
	vcvtdq2ps	ymm8, ymm8
	vfmadd132ps	ymm12, ymm13, ymm1
	vfmadd231ps	ymm12, ymm2, ymm14
	vfmadd132ps	ymm8, ymm12, ymm3
	vmovups	YMMWORD PTR [r11], ymm8
	jmp	.L58
.L60:
	mov	edi, DWORD PTR 480[rsp]
	cmp	edi, 3
	jle	.L123
	mov	rbx, QWORD PTR 464[rsp]
	mov	rsi, r11
	mov	r14, QWORD PTR 488[rsp]
	sub	edi, 2
	mov	DWORD PTR 432[rsp], edi
	mov	rdi, QWORD PTR 416[rsp]
	sal	rsi, 2
	mov	ecx, 3
	lea	r11, [rbx+r13]
	lea	r8, [rbx+rax]
	mov	QWORD PTR 312[rsp], rax
	movzx	r9d, BYTE PTR [r11]
	movzx	r12d, BYTE PTR [r8]
	lea	r10, [rbx+r14]
	mov	QWORD PTR 336[rsp], rdx
	mov	QWORD PTR 320[rsp], r13
	movzx	r15d, BYTE PTR [r10]
	add	rdi, rsi
	mov	DWORD PTR 384[rsp], r12d
	movzx	r12d, BYTE PTR 1[rbx+r14]
	movzx	r14d, BYTE PTR 2[rbx+r14]
	add	rsi, QWORD PTR 408[rsp]
	mov	DWORD PTR 448[rsp], r9d
	movzx	r9d, BYTE PTR 1[rbx+r13]
	mov	DWORD PTR 352[rsp], r14d
	movzx	r14d, BYTE PTR 2[rbx+r13]
	mov	DWORD PTR 368[rsp], r9d
	movzx	r9d, BYTE PTR 1[rbx+rax]
	mov	r13d, DWORD PTR 384[rsp]
	mov	DWORD PTR 472[rsp], r9d
	movzx	r9d, BYTE PTR 2[rbx+rax]
	mov	edx, DWORD PTR 368[rsp]
	mov	ebx, DWORD PTR 352[rsp]
.L69:
	vcvtusi2ss	xmm8, xmm10, r15d
	movzx	eax, BYTE PTR [r11+rcx]
	movzx	r15d, BYTE PTR [r10+rcx]
	vmovaps	xmm16, xmm6
	vcvtusi2ss	xmm12, xmm10, r13d
	movzx	r13d, BYTE PTR [r8+rcx]
	mov	QWORD PTR 384[rsp], rcx
	add	rdi, 12
	vcvtusi2ss	xmm13, xmm10, DWORD PTR 448[rsp]
	mov	DWORD PTR 448[rsp], eax
	add	rsi, 12
	vmovaps	xmm15, xmm8
	vcvtusi2ss	xmm8, xmm10, eax
	movzx	eax, BYTE PTR 1[r8+rcx]
	vmovaps	xmm14, xmm12
	vcvtusi2ss	xmm12, xmm10, r15d
	vfmadd213ss	xmm16, xmm13, DWORD PTR -12[rdi]
	vmulss	xmm18, xmm7, xmm8
	vfmadd132ss	xmm12, xmm18, xmm5
	vaddss	xmm12, xmm12, xmm16
	vmovaps	xmm16, xmm6
	vfmadd231ss	xmm12, xmm4, xmm15
	vmovss	DWORD PTR -12[rdi], xmm12
	vcvtusi2ss	xmm12, xmm10, r13d
	vfmadd213ss	xmm13, xmm4, DWORD PTR -12[rsi]
	vmulss	xmm12, xmm12, xmm7
	vfmadd132ss	xmm8, xmm12, xmm5
	vcvtusi2ss	xmm12, xmm10, DWORD PTR 472[rsp]
	mov	DWORD PTR 472[rsp], eax
	vaddss	xmm8, xmm8, xmm13
	vcvtusi2ss	xmm13, xmm10, edx
	movzx	edx, BYTE PTR 1[r11+rcx]
	vfmadd231ss	xmm8, xmm6, xmm14
	vmovaps	xmm14, xmm12
	vmovss	DWORD PTR -12[rsi], xmm8
	vcvtusi2ss	xmm8, xmm10, r12d
	movzx	r12d, BYTE PTR 1[r10+rcx]
	vfmadd213ss	xmm16, xmm13, DWORD PTR -8[rdi]
	vcvtusi2ss	xmm12, xmm10, r12d
	vmovaps	xmm15, xmm8
	vcvtusi2ss	xmm8, xmm10, edx
	vmulss	xmm18, xmm7, xmm8
	vfmadd132ss	xmm12, xmm18, xmm5
	vaddss	xmm12, xmm12, xmm16
	vmovaps	xmm16, xmm6
	vfmadd231ss	xmm12, xmm4, xmm15
	vmovss	DWORD PTR -8[rdi], xmm12
	vcvtusi2ss	xmm12, xmm10, eax
	vfmadd213ss	xmm13, xmm4, DWORD PTR -8[rsi]
	vmulss	xmm12, xmm12, xmm7
	vfmadd132ss	xmm8, xmm12, xmm5
	vcvtusi2ss	xmm12, xmm10, r9d
	movzx	r9d, BYTE PTR 2[r8+rcx]
	vaddss	xmm8, xmm8, xmm13
	vcvtusi2ss	xmm13, xmm10, r14d
	movzx	r14d, BYTE PTR 2[r11+rcx]
	vfmadd231ss	xmm8, xmm6, xmm14
	vmovaps	xmm14, xmm12
	vmovss	DWORD PTR -8[rsi], xmm8
	vcvtusi2ss	xmm8, xmm10, ebx
	movzx	ebx, BYTE PTR 2[r10+rcx]
	add	rcx, 3
	vfmadd213ss	xmm16, xmm13, DWORD PTR -4[rdi]
	lea	eax, -2[rcx]
	vcvtusi2ss	xmm12, xmm10, ebx
	vmovaps	xmm15, xmm8
	vcvtusi2ss	xmm8, xmm10, r14d
	vmulss	xmm18, xmm7, xmm8
	vfmadd132ss	xmm12, xmm18, xmm5
	vaddss	xmm12, xmm12, xmm16
	vfmadd231ss	xmm12, xmm4, xmm15
	vmovss	DWORD PTR -4[rdi], xmm12
	vcvtusi2ss	xmm12, xmm10, r9d
	vfmadd213ss	xmm13, xmm4, DWORD PTR -4[rsi]
	vmulss	xmm12, xmm12, xmm7
	vfmadd132ss	xmm8, xmm12, xmm5
	vaddss	xmm8, xmm8, xmm13
	vfmadd231ss	xmm8, xmm6, xmm14
	vmovss	DWORD PTR -4[rsi], xmm8
	cmp	DWORD PTR 432[rsp], eax
	jg	.L69
	mov	rdx, QWORD PTR 336[rsp]
	mov	r13, QWORD PTR 320[rsp]
	mov	rax, QWORD PTR 312[rsp]
	mov	edi, DWORD PTR 384[rsp]
.L68:
	mov	rbx, QWORD PTR 464[rsp]
	mov	r8d, edi
	mov	r11, QWORD PTR 488[rsp]
	lea	rcx, [r8+r13]
	mov	r12d, DWORD PTR 424[rsp]
	mov	r14, QWORD PTR 416[rsp]
	movzx	esi, BYTE PTR [rbx+rcx]
	movzx	ecx, BYTE PTR 3[rbx+rcx]
	lea	r9, [r8+r11]
	mov	r15, QWORD PTR 408[rsp]
	vcvtusi2ss	xmm13, xmm10, ecx
	lea	rcx, [r8+rax]
	vcvtusi2ss	xmm14, xmm10, esi
	movzx	esi, BYTE PTR [rbx+rcx]
	movzx	ecx, BYTE PTR 3[rbx+rcx]
	vcvtusi2ss	xmm8, xmm10, esi
	vmulss	xmm18, xmm6, xmm14
	vmulss	xmm15, xmm6, xmm8
	vcvtusi2ss	xmm8, xmm10, ecx
	lea	ecx, [rdi+r12]
	lea	r8, 0[0+rcx*4]
	movzx	ecx, BYTE PTR [rbx+r9]
	vmovaps	xmm12, xmm8
	vcvtusi2ss	xmm8, xmm10, ecx
	movzx	ecx, BYTE PTR 3[rbx+r9]
	lea	r9d, 1[rdi]
	vcvtusi2ss	xmm16, xmm10, ecx
	vfmadd213ss	xmm8, xmm4, DWORD PTR [r14+r8]
	vfmadd132ss	xmm16, xmm18, xmm5
	vfmadd231ss	xmm8, xmm7, xmm13
	vfmadd132ss	xmm13, xmm15, xmm5
	vaddss	xmm8, xmm8, xmm16
	vmovss	DWORD PTR [r14+r8], xmm8
	vmovaps	xmm8, xmm12
	vfmadd213ss	xmm14, xmm4, DWORD PTR [r15+r8]
	vfmadd132ss	xmm8, xmm14, xmm7
	vaddss	xmm8, xmm8, xmm13
	vmovss	DWORD PTR [r15+r8], xmm8
	cmp	r9d, DWORD PTR 480[rsp]
	jge	.L59
	mov	r8d, r9d
	add	edi, 2
	lea	rcx, [r8+r13]
	lea	r10, [r8+r11]
	movzx	esi, BYTE PTR [rbx+rcx]
	movzx	ecx, BYTE PTR 3[rbx+rcx]
	vcvtusi2ss	xmm13, xmm10, ecx
	lea	rcx, [r8+rax]
	vcvtusi2ss	xmm14, xmm10, esi
	movzx	esi, BYTE PTR [rbx+rcx]
	movzx	ecx, BYTE PTR 3[rbx+rcx]
	vcvtusi2ss	xmm8, xmm10, esi
	vmulss	xmm18, xmm6, xmm14
	vmulss	xmm15, xmm6, xmm8
	vcvtusi2ss	xmm8, xmm10, ecx
	lea	ecx, [r12+r9]
	lea	r8, 0[0+rcx*4]
	movzx	ecx, BYTE PTR [rbx+r10]
	vmovaps	xmm12, xmm8
	vcvtusi2ss	xmm8, xmm10, ecx
	movzx	ecx, BYTE PTR 3[rbx+r10]
	vcvtusi2ss	xmm16, xmm10, ecx
	vfmadd213ss	xmm8, xmm4, DWORD PTR [r14+r8]
	vfmadd132ss	xmm16, xmm18, xmm5
	vfmadd231ss	xmm8, xmm7, xmm13
	vfmadd132ss	xmm13, xmm15, xmm5
	vaddss	xmm8, xmm8, xmm16
	vmovss	DWORD PTR [r14+r8], xmm8
	vmovaps	xmm8, xmm12
	vfmadd213ss	xmm14, xmm4, DWORD PTR [r15+r8]
	vfmadd132ss	xmm8, xmm14, xmm7
	vaddss	xmm8, xmm8, xmm13
	vmovss	DWORD PTR [r15+r8], xmm8
	cmp	edi, DWORD PTR 480[rsp]
	jge	.L59
	mov	esi, edi
	add	r13, rsi
	add	rax, rsi
	lea	r8, [r11+rsi]
	movzx	ecx, BYTE PTR [rbx+r13]
	vcvtusi2ss	xmm14, xmm10, ecx
	movzx	ecx, BYTE PTR 3[rbx+r13]
	vcvtusi2ss	xmm13, xmm10, ecx
	movzx	ecx, BYTE PTR [rbx+rax]
	movzx	eax, BYTE PTR 3[rbx+rax]
	vcvtusi2ss	xmm8, xmm10, ecx
	vmulss	xmm15, xmm6, xmm8
	vcvtusi2ss	xmm8, xmm10, eax
	lea	eax, [r12+rdi]
	lea	rsi, 0[0+rax*4]
	movzx	eax, BYTE PTR [rbx+r8]
	vmovaps	xmm12, xmm8
	vcvtusi2ss	xmm8, xmm10, eax
	movzx	eax, BYTE PTR 3[rbx+r8]
	vfmadd213ss	xmm8, xmm4, DWORD PTR [r14+rsi]
	jmp	.L221
.L52:
	cmp	r14d, 7
	jg	.L120
	mov	QWORD PTR 472[rsp], 0
	mov	rdi, QWORD PTR 40[rdx]
	mov	DWORD PTR 480[rsp], r14d
	mov	DWORD PTR 424[rsp], 0
	mov	QWORD PTR 464[rsp], rdi
	mov	r11, QWORD PTR 472[rsp]
	jmp	.L56
.L77:
	mov	ecx, DWORD PTR 192[rsp]
	lea	r8, [r14+rbx*4]
	xor	eax, eax
.L82:
	movzx	r9d, BYTE PTR [rdi+rax]
	vcvtusi2ss	xmm0, xmm10, r9d
	movzx	r9d, BYTE PTR 3[rdi+rax]
	vmovaps	xmm2, xmm0
	vcvtusi2ss	xmm0, xmm10, r9d
	movzx	r9d, BYTE PTR [rsi+rax]
	vfmadd213ss	xmm2, xmm4, DWORD PTR [r8+rax*4]
	vcvtusi2ss	xmm1, xmm10, r9d
	movzx	r9d, BYTE PTR 3[rsi+rax]
	vmulss	xmm1, xmm1, xmm6
	vfmadd231ss	xmm1, xmm5, xmm0
	vcvtusi2ss	xmm0, xmm10, r9d
	vfmadd132ss	xmm0, xmm2, xmm7
	vaddss	xmm0, xmm0, xmm1
	vmovss	DWORD PTR [r8+rax*4], xmm0
	inc	rax
	cmp	ecx, eax
	jg	.L82
	add	rdx, 48
	cmp	QWORD PTR 208[rsp], rdx
	jne	.L83
	jmp	.L226
.L122:
	xor	ecx, ecx
	jmp	.L64
.L121:
	xor	r9d, r9d
	xor	r8d, r8d
	jmp	.L62
.L70:
	cmp	DWORD PTR 496[rsp], 7
	jg	.L124
	xor	r15d, r15d
	xor	ebx, ebx
	jmp	.L74
.L120:
	mov	r8, rsi
	mov	rsi, QWORD PTR 40[rdx]
	mov	r11, r9
	mov	DWORD PTR 424[rsp], 8
	mov	rdi, rax
	mov	r9, r13
	mov	r10, rcx
	mov	QWORD PTR 464[rsp], rsi
	jmp	.L55
.L126:
	xor	eax, eax
	jmp	.L80
.L125:
	xor	edi, edi
	xor	esi, esi
	jmp	.L78
.L124:
	mov	rsi, r14
	mov	r10, r9
	mov	rcx, rdi
	mov	r15d, 8
	jmp	.L73
.L123:
	xor	edi, edi
	jmp	.L68
.L217:
	mov	r15, QWORD PTR 24[rsp]
	vzeroupper
.L36:
	mov	rdi, QWORD PTR 216[rsp]
	mov	esi, 195072
	call	"_ZdlPvm"@PLT
	mov	rax, QWORD PTR 80[rsp]
	test	rax, rax
	je	.L100
	mov	rsi, QWORD PTR 56[rsp]
	mov	rdi, rax
	call	"_ZdlPvm"@PLT
.L100:
	mov	rdi, QWORD PTR 128[rsp]
	test	rdi, rdi
	je	.L1
	mov	rsi, r15
	sub	rsi, rdi
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
.L224:
	.cfi_restore_state
	mov	rbx, QWORD PTR 208[rsp]
	xor	edi, edi
	cmp	QWORD PTR 128[rsp], rbx
	jne	.L25
	mov	r11d, DWORD PTR 92[rsp]
	test	r11d, r11d
	jle	.L26
	mov	r10d, DWORD PTR 144[rsp]
	test	r10d, r10d
	jg	.L27
	jmp	.L26
	.p2align 4,,10
	.p2align 3
.L223:
	mov	eax, DWORD PTR 184[rsp]
	mov	QWORD PTR 128[rsp], 0
	xor	r15d, r15d
	mov	DWORD PTR 144[rsp], eax
	mov	eax, DWORD PTR 488[rsp]
	mov	DWORD PTR 92[rsp], eax
	cmp	QWORD PTR 496[rsp], r14
	jne	.L5
	mov	QWORD PTR 208[rsp], 0
.L113:
	mov	QWORD PTR 80[rsp], 0
	jmp	.L20
.L13:
	mov	r13, r15
	movabs	rax, -6148914691236517205
	sub	r13, QWORD PTR 128[rsp]
	mov	rdx, r13
	sar	rdx, 4
	imul	rdx, rax
	movabs	rax, 192153584101141162
	cmp	rdx, rax
	je	.L206
	test	rdx, rdx
	mov	eax, 1
	mov	DWORD PTR 400[rsp], r11d
	cmovne	rax, rdx
	mov	DWORD PTR 352[rsp], r10d
	mov	DWORD PTR 368[rsp], r8d
	add	rax, rdx
	movabs	rdx, 192153584101141162
	mov	DWORD PTR 384[rsp], ecx
	cmp	rax, rdx
	mov	DWORD PTR 432[rsp], esi
	cmova	rax, rdx
	mov	DWORD PTR 448[rsp], r9d
	vmovss	DWORD PTR 408[rsp], xmm3
	lea	rax, [rax+rax*2]
	vmovss	DWORD PTR 416[rsp], xmm0
	sal	rax, 4
	vmovss	DWORD PTR 424[rsp], xmm1
	mov	rdi, rax
	mov	QWORD PTR 480[rsp], rax
	vmovss	DWORD PTR 464[rsp], xmm2
.LEHB3:
	call	"_Znwm"@PLT
.LEHE3:
	vmovss	xmm0, DWORD PTR 416[rsp]
	vmovss	xmm2, DWORD PTR 464[rsp]
	mov	QWORD PTR 40[rax+r13], rbx
	mov	r12, rax
	mov	r9d, DWORD PTR 448[rsp]
	mov	esi, DWORD PTR 432[rsp]
	vinsertps	xmm0, xmm0, DWORD PTR 408[rsp], 0x10
	vinsertps	xmm2, xmm2, DWORD PTR 424[rsp], 0x10
	mov	ecx, DWORD PTR 384[rsp]
	mov	r10d, DWORD PTR 352[rsp]
	mov	DWORD PTR [rax+r13], r9d
	mov	r8d, DWORD PTR 368[rsp]
	mov	r11d, DWORD PTR 400[rsp]
	vmovlhps	xmm2, xmm2, xmm0
	mov	DWORD PTR 4[rax+r13], esi
	mov	DWORD PTR 24[rax+r13], ecx
	mov	DWORD PTR 28[rax+r13], r10d
	mov	DWORD PTR 32[rax+r13], r8d
	mov	DWORD PTR 36[rax+r13], r11d
	vmovups	XMMWORD PTR 8[rax+r13], xmm2
	test	r13, r13
	je	.L17
	mov	rsi, QWORD PTR 128[rsp]
	mov	rdx, r13
	mov	rdi, rax
	call	"memcpy"@PLT
.L17:
	mov	rdi, QWORD PTR 128[rsp]
	lea	rax, 48[r12+r13]
	mov	QWORD PTR 208[rsp], rax
	test	rdi, rdi
	je	.L18
	mov	rsi, r15
	sub	rsi, rdi
	call	"_ZdlPvm"@PLT
.L18:
	mov	r15, QWORD PTR 480[rsp]
	mov	QWORD PTR 128[rsp], r12
	add	r15, r12
	jmp	.L12
.L2:
	lea	r13, [rax+rax*2]
	test	r13, r13
	js	.L205
	mov	rdi, r13
.LEHB4:
	call	"_Znwm"@PLT
.LEHE4:
	lea	r8, [rax+r13]
	xor	esi, esi
	mov	rdx, r13
	mov	rdi, rax
	mov	QWORD PTR 496[rsp], r8
	call	"memset"@PLT
	mov	r8, QWORD PTR 496[rsp]
	mov	rcx, rax
	mov	rax, QWORD PTR 64[rsp]
	mov	QWORD PTR 16[rax], rcx
	mov	QWORD PTR 24[rax], r8
	mov	QWORD PTR 32[rax], r8
	mov	rax, QWORD PTR 8[r12]
	mov	QWORD PTR 496[rsp], rax
	sub	rax, r14
	mov	r12, rax
	jne	.L4
	mov	QWORD PTR 128[rsp], 0
	xor	r15d, r15d
	jmp	.L8
.L28:
	mov	edx, DWORD PTR 92[rsp]
	test	edx, edx
	jle	.L32
	mov	eax, DWORD PTR 144[rsp]
	test	eax, eax
	jg	.L27
	jmp	.L32
.L110:
	mov	rax, QWORD PTR 128[rsp]
	mov	QWORD PTR 208[rsp], rax
	jmp	.L9
.L116:
	xor	eax, eax
.L37:
	mov	ebx, DWORD PTR 92[rsp]
	lea	rdx, 8[rax]
	cmp	ebx, edx
	jle	.L36
	add	rax, 16
	cmp	ebx, eax
	jg	.L37
	jmp	.L36
.L201:
	jmp	.L202
.L199:
	jmp	.L200
.L203:
	jmp	.L204
.L131:
	mov	rbx, rax
	vzeroupper
	jmp	.L16
	.section	.gcc_except_table,"a",@progbits
.LLSDA11708:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSE11708-.LLSDACSB11708
.LLSDACSB11708:
	.uleb128 .LEHB0-.LFB11708
	.uleb128 .LEHE0-.LEHB0
	.uleb128 .L199-.LFB11708
	.uleb128 0
	.uleb128 .LEHB1-.LFB11708
	.uleb128 .LEHE1-.LEHB1
	.uleb128 .L131-.LFB11708
	.uleb128 0
	.uleb128 .LEHB2-.LFB11708
	.uleb128 .LEHE2-.LEHB2
	.uleb128 .L201-.LFB11708
	.uleb128 0
	.uleb128 .LEHB3-.LFB11708
	.uleb128 .LEHE3-.LEHB3
	.uleb128 .L203-.LFB11708
	.uleb128 0
	.uleb128 .LEHB4-.LFB11708
	.uleb128 .LEHE4-.LEHB4
	.uleb128 .L199-.LFB11708
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
.L208:
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
.L129:
.L202:
	cmp	QWORD PTR 80[rsp], 0
	mov	r12, rax
	jne	.L227
	vzeroupper
.L103:
	mov	rbx, r12
.L16:
	cmp	QWORD PTR 128[rsp], 0
	je	.L105
	mov	rdi, QWORD PTR 128[rsp]
	mov	rsi, r15
	sub	rsi, rdi
	call	"_ZdlPvm"@PLT
	jmp	.L105
.L205:
	lea	rdi, .LC0[rip]
.LEHB6:
	call	"_ZSt20__throw_length_errorPKc"@PLT
.LEHE6:
.L127:
.L200:
	mov	rbx, rax
	vzeroupper
.L105:
	mov	rax, QWORD PTR 64[rsp]
	mov	rdi, QWORD PTR 16[rax]
	test	rdi, rdi
	je	.L106
	mov	rsi, QWORD PTR 32[rax]
	sub	rsi, rdi
	call	"_ZdlPvm"@PLT
.L106:
	mov	rdi, rbx
.LEHB7:
	call	"_Unwind_Resume"@PLT
.LEHE7:
.L227:
	mov	rsi, QWORD PTR 56[rsp]
	mov	rdi, QWORD PTR 80[rsp]
	vzeroupper
	call	"_ZdlPvm"@PLT
	jmp	.L103
.L206:
	lea	rdi, .LC2[rip]
.LEHB8:
	call	"_ZSt20__throw_length_errorPKc"@PLT
.LEHE8:
.L207:
	lea	rdi, .LC0[rip]
.LEHB9:
	call	"_ZSt20__throw_length_errorPKc"@PLT
.LEHE9:
.L128:
	mov	rbx, rax
	vzeroupper
	jmp	.L16
.L130:
.L204:
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
	.uleb128 .L129-.LCOLDB8
	.uleb128 0
	.uleb128 .LEHB6-.LCOLDB8
	.uleb128 .LEHE6-.LEHB6
	.uleb128 .L127-.LCOLDB8
	.uleb128 0
	.uleb128 .LEHB7-.LCOLDB8
	.uleb128 .LEHE7-.LEHB7
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB8-.LCOLDB8
	.uleb128 .LEHE8-.LEHB8
	.uleb128 .L130-.LCOLDB8
	.uleb128 0
	.uleb128 .LEHB9-.LCOLDB8
	.uleb128 .LEHE9-.LEHB9
	.uleb128 .L128-.LCOLDB8
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
