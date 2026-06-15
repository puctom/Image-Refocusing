	.file	"opt17_row_reuse_only.cpp"
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
	.cfi_offset 15, -24
	mov	r15, rdi
	push	r14
	push	r13
	push	r12
	.cfi_offset 14, -32
	.cfi_offset 13, -40
	.cfi_offset 12, -48
	mov	r12, rsi
	push	rbx
	and	rsp, -32
	sub	rsp, 480
	.cfi_offset 3, -56
	mov	rbx, QWORD PTR [rsi]
	vmovss	DWORD PTR 420[rsp], xmm0
	vmovdqu	xmm0, XMMWORD PTR [rbx]
	mov	QWORD PTR 32[rdi], 0
	vmovdqu	XMMWORD PTR 16[rdi], xmm1
	vpextrq	rax, xmm0, 1
	vmovq	r13, xmm0
	vmovq	QWORD PTR 200[rsp], xmm0
	imul	r13, rax
	mov	QWORD PTR 456[rsp], rax
	vmovdqu	XMMWORD PTR [rdi], xmm0
	test	r13, r13
	jne	.L2
	mov	rax, QWORD PTR 8[rsi]
	mov	QWORD PTR 464[rsp], rax
	sub	rax, rbx
	mov	r12, rax
	je	.L205
.L4:
	mov	rdi, r12
.LEHB0:
	call	"_Znwm"@PLT
.LEHE0:
	mov	QWORD PTR 128[rsp], rax
	lea	r14, [rax+r12]
.L8:
	mov	eax, DWORD PTR 200[rsp]
	mov	r12d, DWORD PTR 456[rsp]
	mov	DWORD PTR 152[rsp], eax
	cmp	rbx, QWORD PTR 464[rsp]
	je	.L96
.L5:
	mov	rax, QWORD PTR 128[rsp]
	mov	QWORD PTR 216[rsp], rax
.L19:
	vmovss	xmm7, DWORD PTR 420[rsp]
	mov	edi, DWORD PTR 152[rsp]
	xor	ecx, ecx
	vmulss	xmm4, xmm7, DWORD PTR 40[rbx]
	vmulss	xmm2, xmm7, DWORD PTR 44[rbx]
	vrndscaless	xmm0, xmm4, xmm4, 9
	vcvttss2si	r9d, xmm0
	vrndscaless	xmm1, xmm2, xmm2, 9
	vcvttss2si	esi, xmm1
	mov	eax, r9d
	neg	eax
	test	r9d, r9d
	cmovs	ecx, eax
	mov	eax, edi
	sub	eax, r9d
	dec	eax
	cmp	eax, edi
	cmovg	eax, edi
	xor	r8d, r8d
	mov	r10d, eax
	mov	eax, esi
	neg	eax
	test	esi, esi
	cmovs	r8d, eax
	mov	eax, r12d
	sub	eax, esi
	dec	eax
	cmp	eax, r12d
	cmovg	eax, r12d
	mov	r11d, eax
	cmp	ecx, r10d
	jge	.L12
	cmp	r8d, eax
	jge	.L12
	vsubss	xmm5, xmm2, xmm1
	vsubss	xmm3, xmm4, xmm0
	mov	rdi, QWORD PTR 16[rbx]
	mov	rax, QWORD PTR 216[rsp]
	vaddss	xmm0, xmm0, DWORD PTR .LC1[rip]
	vaddss	xmm1, xmm1, DWORD PTR .LC1[rip]
	mov	QWORD PTR 432[rsp], rdi
	vsubss	xmm0, xmm0, xmm4
	vsubss	xmm1, xmm1, xmm2
	vmulss	xmm2, xmm0, xmm1
	vmulss	xmm1, xmm1, xmm3
	vmulss	xmm0, xmm0, xmm5
	vmulss	xmm3, xmm3, xmm5
	cmp	r14, rax
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
	mov	QWORD PTR -8[rax], rdi
	mov	QWORD PTR 216[rsp], rax
.L12:
	add	rbx, 48
	cmp	rbx, QWORD PTR 464[rsp]
	jne	.L19
.L9:
	mov	rax, r13
	shr	rax, 61
	jne	.L192
	test	r13, r13
	je	.L99
	sal	r13, 2
	mov	rdi, r13
.LEHB1:
	call	"_Znwm"@PLT
.LEHE1:
	mov	rdx, r13
	xor	esi, esi
	mov	rdi, rax
	mov	QWORD PTR 88[rsp], rax
	call	"memset"@PLT
.L20:
	mov	rax, QWORD PTR 200[rsp]
	mov	rbx, QWORD PTR 456[rsp]
	inc	rax
	inc	rbx
	imul	rbx, rax
	mov	QWORD PTR 464[rsp], rax
	mov	rax, rbx
	shr	rax, 61
	jne	.L193
	test	rbx, rbx
	je	.L206
	sal	rbx, 2
	mov	rdi, rbx
.LEHB2:
	call	"_Znwm"@PLT
	mov	rdi, rax
	mov	rdx, rbx
	xor	esi, esi
	call	"memset"@PLT
	mov	rcx, QWORD PTR 216[rsp]
	mov	rdi, rax
	cmp	QWORD PTR 128[rsp], rcx
	je	.L28
.L25:
	mov	rax, QWORD PTR 128[rsp]
.L29:
	movsxd	rdx, DWORD PTR 32[rax]
	mov	r9, QWORD PTR 464[rsp]
	add	rax, 48
	movsxd	rsi, DWORD PTR -24[rax]
	movsxd	r8, DWORD PTR -12[rax]
	imul	rdx, r9
	imul	r8, r9
	lea	rcx, [rdx+rsi]
	inc	DWORD PTR [rdi+rcx*4]
	movsxd	rcx, DWORD PTR -20[rax]
	add	rdx, rcx
	dec	DWORD PTR [rdi+rdx*4]
	lea	rdx, [rsi+r8]
	dec	DWORD PTR [rdi+rdx*4]
	lea	rdx, [rcx+r8]
	inc	DWORD PTR [rdi+rdx*4]
	cmp	rax, QWORD PTR 216[rsp]
	jne	.L29
	test	r12d, r12d
	jle	.L35
	mov	ecx, DWORD PTR 152[rsp]
	test	ecx, ecx
	jle	.L35
.L27:
	mov	rax, QWORD PTR 200[rsp]
	xor	ecx, ecx
	lea	edx, -1[rax]
	xor	eax, eax
	lea	r9, 1[rdx]
.L31:
	mov	rsi, QWORD PTR 88[rsp]
	add	ecx, DWORD PTR [rdi+rax*4]
	mov	DWORD PTR [rsi+rax*4], ecx
	inc	rax
	cmp	rax, r9
	jne	.L31
	cmp	r12d, 1
	jle	.L32
	mov	eax, DWORD PTR 152[rsp]
	mov	r11, QWORD PTR 464[rsp]
	xor	ecx, ecx
	mov	r8d, 1
	lea	rsi, 0[0+rax*4]
	mov	rax, QWORD PTR 88[rsp]
	lea	r10, [rax+rsi]
.L34:
	lea	rdx, [rdi+r11*4]
	movsxd	rax, ecx
	add	ecx, DWORD PTR 200[rsp]
	mov	QWORD PTR 456[rsp], rdx
	mov	rdx, QWORD PTR 88[rsp]
	mov	DWORD PTR 440[rsp], ecx
	lea	rax, [rdx+rax*4]
	xor	edx, edx
	mov	QWORD PTR 448[rsp], rax
	xor	eax, eax
.L33:
	mov	rcx, QWORD PTR 456[rsp]
	add	edx, DWORD PTR [rcx+rax*4]
	mov	rcx, QWORD PTR 448[rsp]
	mov	ecx, DWORD PTR [rcx+rax*4]
	add	ecx, edx
	mov	DWORD PTR [r10+rax*4], ecx
	inc	rax
	cmp	rax, r9
	jne	.L33
	inc	r8d
	mov	ecx, DWORD PTR 440[rsp]
	add	r11, QWORD PTR 464[rsp]
	add	r10, rsi
	cmp	r12d, r8d
	jne	.L34
.L35:
	test	rdi, rdi
	je	.L26
.L32:
	mov	rsi, rbx
	call	"_ZdlPvm"@PLT
.L26:
	mov	edi, 195072
	call	"_Znwm"@PLT
.LEHE2:
	mov	DWORD PTR [rax], 0x00000000
	xor	esi, esi
	lea	rdi, 4[rax]
	mov	edx, 195068
	mov	QWORD PTR 232[rsp], rax
	call	"memset"@PLT
	test	r12d, r12d
	jle	.L36
	mov	edx, DWORD PTR 152[rsp]
	test	edx, edx
	jle	.L102
	mov	rbx, QWORD PTR 200[rsp]
	mov	QWORD PTR 120[rsp], 0
	mov	edx, 8
	vxorps	xmm10, xmm10, xmm10
	vmovss	xmm30, DWORD PTR .LC1[rip]
	vmovss	xmm29, DWORD PTR .LC4[rip]
	mov	DWORD PTR 228[rsp], 0
	lea	rcx, [rbx+rbx*2]
	lea	rax, 0[0+rbx*8]
	mov	QWORD PTR 24[rsp], r14
	lea	rsi, 0[0+rcx*4]
	mov	QWORD PTR 136[rsp], rcx
	add	rcx, rcx
	add	rbx, rax
	mov	QWORD PTR 176[rsp], rcx
	neg	rcx
	mov	QWORD PTR 360[rsp], rsi
	mov	QWORD PTR 96[rsp], rbx
	mov	QWORD PTR 104[rsp], rcx
	mov	QWORD PTR 32[rsp], r13
	xor	r13d, r13d
.L85:
	cmp	edx, r12d
	mov	ebx, DWORD PTR 120[rsp]
	mov	QWORD PTR 184[rsp], 0
	cmovg	edx, r12d
	mov	DWORD PTR 40[rsp], r12d
	mov	DWORD PTR 64[rsp], ebx
	mov	DWORD PTR 208[rsp], edx
	sub	edx, DWORD PTR 228[rsp]
	mov	DWORD PTR 44[rsp], edx
	mov	QWORD PTR 48[rsp], r13
	mov	QWORD PTR 16[rsp], rax
.L83:
	mov	rbx, QWORD PTR 184[rsp]
	mov	ecx, DWORD PTR 152[rsp]
	lea	eax, 2032[rbx]
	mov	DWORD PTR 224[rsp], ebx
	cmp	eax, ecx
	cmovg	eax, ecx
	mov	r12d, eax
	mov	DWORD PTR 212[rsp], eax
	mov	eax, DWORD PTR 44[rsp]
	sub	r12d, ebx
	imul	eax, r12d
	movsxd	rbx, r12d
	lea	edx, [rax+rax*2]
	movsxd	rdx, edx
	sal	rdx, 2
	je	.L38
	mov	rdi, QWORD PTR 232[rsp]
	vmovaps	XMMWORD PTR 464[rsp], xmm10
	xor	esi, esi
	vzeroupper
	call	"memset"@PLT
	vmovaps	xmm10, XMMWORD PTR 464[rsp]
	vmovss	xmm29, DWORD PTR .LC4[rip]
	vmovss	xmm30, DWORD PTR .LC1[rip]
.L38:
	mov	rcx, QWORD PTR 128[rsp]
	cmp	rcx, QWORD PTR 216[rsp]
	je	.L39
	lea	rax, [rbx+rbx*2]
	mov	QWORD PTR 72[rsp], rbx
	lea	rsi, 0[0+rax*4]
	mov	QWORD PTR 168[rsp], rax
	mov	QWORD PTR 296[rsp], rsi
	mov	rsi, rax
	add	rax, rax
	mov	QWORD PTR 112[rsp], rax
	mov	eax, DWORD PTR 212[rsp]
	sal	rsi, 4
	mov	QWORD PTR 288[rsp], rsi
	sub	rax, QWORD PTR 184[rsp]
	mov	DWORD PTR 68[rsp], r12d
	mov	QWORD PTR 80[rsp], rax
	mov	QWORD PTR 56[rsp], r15
	.p2align 4,,10
	.p2align 3
.L69:
	mov	ebx, DWORD PTR 228[rsp]
	mov	eax, DWORD PTR 32[rcx]
	mov	edi, DWORD PTR 224[rsp]
	mov	edx, DWORD PTR 212[rsp]
	cmp	ebx, eax
	cmovge	eax, ebx
	mov	ebx, DWORD PTR 208[rsp]
	mov	r9d, eax
	mov	eax, DWORD PTR 36[rcx]
	cmp	ebx, eax
	mov	r8d, eax
	mov	eax, DWORD PTR 24[rcx]
	cmovle	r8d, ebx
	cmp	edi, eax
	cmovge	eax, edi
	mov	DWORD PTR 248[rsp], r8d
	mov	ebx, eax
	mov	eax, DWORD PTR 28[rcx]
	cmp	edx, eax
	cmovle	eax, edx
	cmp	eax, ebx
	jle	.L40
	cmp	r8d, r9d
	jle	.L40
	vmovss	xmm4, DWORD PTR 8[rcx]
	vmovss	xmm5, DWORD PTR 12[rcx]
	sub	eax, ebx
	vmovss	xmm6, DWORD PTR 16[rcx]
	vmovss	xmm7, DWORD PTR 20[rcx]
	lea	eax, [rax+rax*2]
	mov	DWORD PTR 416[rsp], eax
	vbroadcastss	ymm9, xmm4
	vbroadcastss	ymm17, xmm5
	mov	DWORD PTR 196[rsp], eax
	vbroadcastss	ymm25, xmm6
	vbroadcastss	ymm11, xmm7
	lea	eax, 3[r9]
	vmovaps	ymm0, ymm9
	vmovaps	ymm1, ymm17
	vmovaps	ymm2, ymm25
	vmovaps	ymm3, ymm11
	cmp	r8d, eax
	jle	.L41
	mov	esi, ebx
	mov	eax, r9d
	mov	edx, DWORD PTR [rcx]
	lea	r10d, -4[r8]
	sub	esi, edi
	sub	r10d, r9d
	mov	r11, QWORD PTR 40[rcx]
	mov	DWORD PTR 464[rsp], 0
	movsxd	rsi, esi
	add	edx, ebx
	mov	r8d, r10d
	mov	DWORD PTR 192[rsp], ebx
	lea	rdi, [rsi+rsi*2]
	mov	rsi, rax
	movsxd	rdx, edx
	shr	r8d, 2
	sub	rsi, QWORD PTR 120[rsp]
	mov	DWORD PTR 336[rsp], r8d
	imul	rsi, QWORD PTR 168[rsp]
	mov	r8, QWORD PTR 104[rsp]
	mov	DWORD PTR 160[rsp], r9d
	mov	QWORD PTR 144[rsp], rcx
	sub	r8, r11
	mov	DWORD PTR 156[rsp], r10d
	add	rsi, rdi
	mov	rdi, QWORD PTR 232[rsp]
	mov	QWORD PTR 320[rsp], r8
	mov	r8, QWORD PTR 136[rsp]
	mov	QWORD PTR 432[rsp], r11
	lea	r15, [rdi+rsi*4]
	add	rsi, QWORD PTR 112[rsp]
	lea	r14, [rdi+rsi*4]
	movsxd	rsi, DWORD PTR 4[rcx]
	mov	rdi, QWORD PTR 200[rsp]
	sub	r8, r11
	mov	QWORD PTR 304[rsp], r8
	mov	r8d, DWORD PTR 416[rsp]
	add	rsi, rax
	imul	rsi, rdi
	lea	rax, [rdx+rsi]
	add	rdx, rdi
	mov	rdi, QWORD PTR 96[rsp]
	add	rdx, rsi
	lea	rax, [rax+rax*2]
	lea	rdx, [rdx+rdx*2]
	lea	r13, [r11+rax]
	lea	r12, [r11+rdx]
	mov	rdx, QWORD PTR 176[rsp]
	mov	QWORD PTR 456[rsp], r13
	lea	rsi, [r11+rdx]
	lea	rdx, [r11+rdi]
	lea	rdi, [rdx+rax]
	mov	rdx, QWORD PTR 176[rsp]
	add	rsi, rax
	mov	QWORD PTR 448[rsp], rdi
	mov	rdi, QWORD PTR 360[rsp]
	sub	rdx, r11
	add	rdi, r11
	mov	QWORD PTR 352[rsp], rdx
	mov	r11, r12
	add	rdi, rax
	lea	eax, -8[r8]
	mov	r10, QWORD PTR 448[rsp]
	mov	edx, eax
	shr	eax, 3
	mov	r13, rdi
	and	edx, -8
	inc	eax
	add	edx, 8
	sal	rax, 3
	mov	QWORD PTR 256[rsp], rax
	sub	r8d, edx
	mov	eax, edx
	mov	DWORD PTR 252[rsp], edx
	mov	DWORD PTR 272[rsp], r8d
	mov	QWORD PTR 240[rsp], rax
	.p2align 4,,10
	.p2align 3
.L46:
	mov	rax, QWORD PTR 320[rsp]
	mov	r9, r11
	sub	r9, QWORD PTR 432[rsp]
	lea	rdi, [rsi+rax]
	lea	r8, 0[r13+rax]
	mov	rax, QWORD PTR 304[rsp]
	add	rax, rsi
	mov	QWORD PTR 448[rsp], rax
	mov	rax, QWORD PTR 352[rsp]
	add	rax, rsi
	cmp	DWORD PTR 416[rsp], 7
	mov	QWORD PTR 440[rsp], rax
	mov	rax, QWORD PTR 296[rsp]
	lea	rcx, [rax+r15]
	lea	rdx, [rax+r14]
	jle	.L103
	mov	rbx, QWORD PTR 456[rsp]
	mov	r12, QWORD PTR 256[rsp]
	xor	eax, eax
	.p2align 4,,10
	.p2align 3
.L43:
	vpmovzxbd	ymm14, QWORD PTR [rbx+rax]
	vpmovzxbd	ymm8, QWORD PTR 3[rax+rbx]
	vpmovzxbd	ymm13, QWORD PTR [r11+rax]
	vpmovzxbd	ymm12, QWORD PTR 3[rax+r11]
	vcvtdq2ps	ymm14, ymm14
	vfmadd213ps	ymm14, ymm0, YMMWORD PTR [r15+rax*4]
	vcvtdq2ps	ymm8, ymm8
	vcvtdq2ps	ymm13, ymm13
	vcvtdq2ps	ymm12, ymm12
	vfmadd132ps	ymm8, ymm14, ymm1
	vpmovzxbd	ymm14, QWORD PTR [rsi+rax]
	vcvtdq2ps	ymm14, ymm14
	vfmadd231ps	ymm8, ymm2, ymm13
	vfmadd231ps	ymm8, ymm3, ymm12
	vmovups	YMMWORD PTR [r15+rax*4], ymm8
	vpmovzxbd	ymm8, QWORD PTR 3[rax+rsi]
	vfmadd213ps	ymm13, ymm0, YMMWORD PTR [rcx+rax*4]
	vcvtdq2ps	ymm8, ymm8
	vfmadd132ps	ymm12, ymm13, ymm1
	vpmovzxbd	ymm13, QWORD PTR [r10+rax]
	vcvtdq2ps	ymm13, ymm13
	vfmadd231ps	ymm12, ymm2, ymm14
	vfmadd231ps	ymm12, ymm3, ymm8
	vmovups	YMMWORD PTR [rcx+rax*4], ymm12
	vpmovzxbd	ymm12, QWORD PTR 3[rax+r10]
	vfmadd213ps	ymm14, ymm0, YMMWORD PTR [r14+rax*4]
	vcvtdq2ps	ymm12, ymm12
	vfmadd132ps	ymm8, ymm14, ymm1
	vpmovzxbd	ymm14, QWORD PTR 0[r13+rax]
	vcvtdq2ps	ymm14, ymm14
	vfmadd231ps	ymm8, ymm2, ymm13
	vfmadd231ps	ymm8, ymm3, ymm12
	vmovups	YMMWORD PTR [r14+rax*4], ymm8
	vpmovzxbd	ymm8, QWORD PTR 3[rax+r13]
	vfmadd213ps	ymm13, ymm0, YMMWORD PTR [rdx+rax*4]
	vcvtdq2ps	ymm8, ymm8
	vfmadd132ps	ymm12, ymm13, ymm1
	vfmadd231ps	ymm12, ymm2, ymm14
	vfmadd132ps	ymm8, ymm12, ymm3
	vmovups	YMMWORD PTR [rdx+rax*4], ymm8
	add	rax, 8
	cmp	rax, r12
	jne	.L43
	mov	r12d, DWORD PTR 272[rsp]
	mov	QWORD PTR 456[rsp], rbx
	test	r12d, r12d
	jle	.L44
	mov	rax, QWORD PTR 240[rsp]
	mov	DWORD PTR 420[rsp], r12d
	mov	ebx, r12d
	add	QWORD PTR 448[rsp], rax
	add	rdi, rax
	add	r9, rax
	add	r8, rax
	add	QWORD PTR 440[rsp], rax
	mov	eax, DWORD PTR 252[rsp]
.L42:
	sal	rax, 2
	mov	QWORD PTR 368[rsp], rsi
	add	rcx, rax
	lea	r12, [r15+rax]
	mov	QWORD PTR 424[rsp], rcx
	lea	rcx, [r14+rax]
	add	rax, rdx
	mov	rdx, QWORD PTR 432[rsp]
	mov	QWORD PTR 400[rsp], rcx
	mov	QWORD PTR 384[rsp], rax
	lea	rcx, [rdx+rdi]
	mov	rdi, rdx
	lea	rdx, [rdx+r9]
	lea	r9, [rdi+r8]
	mov	r8, QWORD PTR 448[rsp]
	mov	QWORD PTR 448[rsp], r13
	xor	eax, eax
	mov	rsi, QWORD PTR 424[rsp]
	mov	QWORD PTR 424[rsp], r11
	add	r8, rdi
	mov	r11, QWORD PTR 384[rsp]
	add	rdi, QWORD PTR 440[rsp]
	mov	QWORD PTR 440[rsp], r10
	mov	r10, QWORD PTR 400[rsp]
	.p2align 4,,10
	.p2align 3
.L45:
	movzx	r13d, BYTE PTR [rdx+rax]
	vcvtusi2ss	xmm12, xmm10, r13d
	movzx	r13d, BYTE PTR 3[rdx+rax]
	vcvtusi2ss	xmm20, xmm10, r13d
	movzx	r13d, BYTE PTR [r9+rax]
	vcvtusi2ss	xmm8, xmm10, r13d
	movzx	r13d, BYTE PTR 3[r9+rax]
	vmulss	xmm22, xmm6, xmm12
	vcvtusi2ss	xmm19, xmm10, r13d
	movzx	r13d, BYTE PTR [r8+rax]
	vcvtusi2ss	xmm16, xmm10, r13d
	movzx	r13d, BYTE PTR 3[r8+rax]
	vcvtusi2ss	xmm15, xmm10, r13d
	movzx	r13d, BYTE PTR [rdi+rax]
	vcvtusi2ss	xmm18, xmm10, r13d
	movzx	r13d, BYTE PTR 3[rdi+rax]
	vcvtusi2ss	xmm14, xmm10, r13d
	movzx	r13d, BYTE PTR [rcx+rax]
	vcvtusi2ss	xmm13, xmm10, r13d
	movzx	r13d, BYTE PTR 3[rcx+rax]
	vmulss	xmm18, xmm6, xmm18
	vcvtusi2ss	xmm21, xmm10, r13d
	vfmadd213ss	xmm13, xmm4, DWORD PTR [r12+rax*4]
	vfmadd132ss	xmm21, xmm22, xmm5
	vfmadd231ss	xmm13, xmm7, xmm20
	vaddss	xmm13, xmm13, xmm21
	vmovss	DWORD PTR [r12+rax*4], xmm13
	vmulss	xmm13, xmm6, xmm8
	vfmadd213ss	xmm12, xmm4, DWORD PTR [rsi+rax*4]
	vfmadd132ss	xmm20, xmm13, xmm5
	vfmadd231ss	xmm12, xmm7, xmm19
	vaddss	xmm12, xmm12, xmm20
	vmovss	DWORD PTR [rsi+rax*4], xmm12
	vmulss	xmm12, xmm6, xmm16
	vfmadd213ss	xmm8, xmm4, DWORD PTR [r10+rax*4]
	vfmadd132ss	xmm19, xmm12, xmm5
	vfmadd231ss	xmm8, xmm7, xmm15
	vfmadd132ss	xmm15, xmm18, xmm5
	vaddss	xmm8, xmm8, xmm19
	vmovss	DWORD PTR [r10+rax*4], xmm8
	vfmadd213ss	xmm16, xmm4, DWORD PTR [r11+rax*4]
	vfmadd132ss	xmm14, xmm16, xmm7
	vaddss	xmm14, xmm14, xmm15
	vmovss	DWORD PTR [r11+rax*4], xmm14
	inc	rax
	cmp	ebx, eax
	jg	.L45
	mov	r13, QWORD PTR 448[rsp]
	mov	r10, QWORD PTR 440[rsp]
	mov	rsi, QWORD PTR 368[rsp]
	mov	r11, QWORD PTR 424[rsp]
.L44:
	mov	rax, QWORD PTR 288[rsp]
	mov	ecx, DWORD PTR 336[rsp]
	add	r15, rax
	add	r14, rax
	mov	rax, QWORD PTR 360[rsp]
	add	QWORD PTR 456[rsp], rax
	add	r11, rax
	add	rsi, rax
	add	r10, rax
	add	r13, rax
	cmp	DWORD PTR 464[rsp], ecx
	je	.L207
	mov	eax, DWORD PTR 464[rsp]
	inc	eax
	mov	DWORD PTR 464[rsp], eax
	jmp	.L46
	.p2align 4,,10
	.p2align 3
.L207:
	mov	r10d, DWORD PTR 156[rsp]
	mov	r9d, DWORD PTR 160[rsp]
	mov	ebx, DWORD PTR 192[rsp]
	mov	rcx, QWORD PTR 144[rsp]
	and	r10d, -4
	lea	r9d, 4[r9+r10]
.L41:
	lea	eax, 1[r9]
	cmp	eax, DWORD PTR 248[rsp]
	jge	.L47
	mov	eax, DWORD PTR 4[rcx]
	mov	edx, DWORD PTR [rcx]
	mov	r13, QWORD PTR 168[rsp]
	mov	rsi, QWORD PTR 232[rsp]
	add	eax, r9d
	add	edx, ebx
	mov	rdi, QWORD PTR 296[rsp]
	cdqe
	movsxd	rdx, edx
	imul	rax, QWORD PTR 200[rsp]
	add	rax, rdx
	lea	r11, [rax+rax*2]
	mov	rax, QWORD PTR 136[rsp]
	mov	QWORD PTR 440[rsp], r11
	lea	r15, [rax+r11]
	lea	r12, [rax+r15]
	mov	eax, r9d
	mov	QWORD PTR 456[rsp], r15
	sub	eax, DWORD PTR 228[rsp]
	mov	QWORD PTR 448[rsp], r12
	cdqe
	imul	r13, rax
	mov	eax, ebx
	sub	eax, DWORD PTR 224[rsp]
	cdqe
	lea	rax, [rax+rax*2]
	add	rax, r13
	lea	rdx, [rsi+rax*4]
	lea	rax, [rdx+rdi]
	mov	QWORD PTR 464[rsp], rax
	mov	eax, DWORD PTR 416[rsp]
	cmp	eax, 7
	jle	.L105
	mov	rdi, QWORD PTR 40[rcx]
	lea	r14d, -8[rax]
	shr	eax, 3
	lea	r10d, 0[0+rax*8]
	xor	eax, eax
	mov	rsi, rdi
	mov	QWORD PTR 432[rsp], rdi
	lea	r8, [rdi+r11]
	lea	rdi, [rdi+r15]
	add	rsi, r12
	mov	r12, QWORD PTR 464[rsp]
	.p2align 4,,10
	.p2align 3
.L49:
	vpmovzxbd	ymm14, QWORD PTR [r8+rax]
	vpmovzxbd	ymm8, QWORD PTR 3[r8+rax]
	vpmovzxbd	ymm13, QWORD PTR [rdi+rax]
	vpmovzxbd	ymm12, QWORD PTR 3[rdi+rax]
	vcvtdq2ps	ymm14, ymm14
	vfmadd213ps	ymm14, ymm0, YMMWORD PTR [rdx+rax*4]
	vcvtdq2ps	ymm8, ymm8
	vcvtdq2ps	ymm13, ymm13
	vcvtdq2ps	ymm12, ymm12
	vfmadd132ps	ymm8, ymm14, ymm1
	vpmovzxbd	ymm14, QWORD PTR [rsi+rax]
	vcvtdq2ps	ymm14, ymm14
	vfmadd231ps	ymm8, ymm2, ymm13
	vfmadd231ps	ymm8, ymm3, ymm12
	vmovups	YMMWORD PTR [rdx+rax*4], ymm8
	vpmovzxbd	ymm8, QWORD PTR 3[rsi+rax]
	vfmadd213ps	ymm13, ymm0, YMMWORD PTR [r12+rax*4]
	vcvtdq2ps	ymm8, ymm8
	vfmadd132ps	ymm12, ymm13, ymm1
	vfmadd231ps	ymm12, ymm2, ymm14
	vfmadd132ps	ymm8, ymm12, ymm3
	vmovups	YMMWORD PTR [r12+rax*4], ymm8
	add	rax, 8
	cmp	rax, r10
	jne	.L49
	mov	eax, r14d
	mov	QWORD PTR 464[rsp], r12
	and	eax, -8
	lea	esi, 8[rax]
	mov	eax, DWORD PTR 416[rsp]
	mov	DWORD PTR 420[rsp], esi
	sub	eax, esi
	mov	DWORD PTR 424[rsp], eax
	test	eax, eax
	jle	.L50
	mov	eax, esi
	lea	rsi, [r11+rax]
	add	QWORD PTR 456[rsp], rax
	add	QWORD PTR 448[rsp], rax
	mov	QWORD PTR 440[rsp], rsi
.L48:
	mov	eax, ebx
	mov	edi, DWORD PTR 420[rsp]
	sub	rax, QWORD PTR 184[rsp]
	lea	rsi, [rax+rax*2]
	add	rax, QWORD PTR 80[rsp]
	mov	QWORD PTR 352[rsp], rdi
	add	rsi, r13
	lea	rax, [rax+rax*2]
	add	rsi, rdi
	add	rax, r13
	add	rax, rdi
	mov	rdi, rsi
	mov	QWORD PTR 384[rsp], rsi
	lea	rsi, 0[0+rsi*4]
	mov	QWORD PTR 400[rsp], rax
	lea	rdi, 128[0+rdi*4]
	sal	rax, 2
	cmp	rax, rdi
	jge	.L117
	lea	rdi, 128[rax]
	cmp	rsi, rdi
	jl	.L51
.L117:
	mov	r15d, DWORD PTR 424[rsp]
	lea	edi, -1[r15]
	cmp	edi, 30
	jbe	.L106
	mov	rdi, QWORD PTR 432[rsp]
	mov	r14, QWORD PTR 456[rsp]
	shr	r15d, 5
	mov	DWORD PTR 240[rsp], ebx
	mov	r11, QWORD PTR 440[rsp]
	mov	r13, QWORD PTR 448[rsp]
	mov	DWORD PTR 368[rsp], r15d
	lea	r8, 3[rdi+r14]
	add	r14, rdi
	mov	r12, QWORD PTR 464[rsp]
	vmovss	DWORD PTR 304[rsp], xmm4
	mov	QWORD PTR 336[rsp], r14
	lea	r10, 3[rdi+r11]
	lea	r14, [rdi+r11]
	lea	r11, 3[rdi+r13]
	add	rdi, r13
	vmovss	DWORD PTR 272[rsp], xmm5
	mov	QWORD PTR 320[rsp], rdi
	mov	rdi, QWORD PTR 232[rsp]
	mov	r13, QWORD PTR 336[rsp]
	vmovss	DWORD PTR 256[rsp], xmm6
	add	rax, rdi
	add	rsi, rdi
	mov	edi, r15d
	vmovss	DWORD PTR 252[rsp], xmm7
	sal	rdi, 5
	mov	r15, rdi
	xor	edi, edi
	mov	rbx, r15
	mov	r15, QWORD PTR 320[rsp]
	.p2align 4,,10
	.p2align 3
.L54:
	vmovdqu	ymm5, YMMWORD PTR 0[r13+rdi]
	vmovdqu	ymm4, YMMWORD PTR [r10+rdi]
	sub	rax, -128
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
	vmovdqu	ymm5, YMMWORD PTR [r15+rdi]
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
	vmovdqu	ymm5, YMMWORD PTR [r11+rdi]
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
	vfmadd213ps	ymm27, ymm0, YMMWORD PTR -128[rax]
	vfmadd213ps	ymm16, ymm0, YMMWORD PTR -96[rax]
	vcvtdq2ps	ymm4, ymm4
	vfmadd213ps	ymm26, ymm0, YMMWORD PTR -64[rax]
	vfmadd213ps	ymm8, ymm0, YMMWORD PTR -32[rax]
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
	vmovups	YMMWORD PTR -128[rax], ymm20
	vaddps	ymm4, ymm4, ymm6
	vmovups	YMMWORD PTR -96[rax], ymm7
	vmovups	YMMWORD PTR -64[rax], ymm19
	vmovups	YMMWORD PTR -32[rax], ymm4
	cmp	rdi, rbx
	jne	.L54
	mov	r10d, DWORD PTR 368[rsp]
	vmovss	xmm4, DWORD PTR 304[rsp]
	mov	QWORD PTR 464[rsp], r12
	vmovss	xmm5, DWORD PTR 272[rsp]
	vmovss	xmm6, DWORD PTR 256[rsp]
	sal	r10d, 5
	vmovss	xmm7, DWORD PTR 252[rsp]
	mov	ebx, DWORD PTR 240[rsp]
	cmp	r10d, DWORD PTR 424[rsp]
	je	.L50
	mov	r8d, r10d
.L53:
	mov	r14d, DWORD PTR 424[rsp]
	sub	r14d, r10d
	lea	eax, -1[r14]
	cmp	eax, 14
	jbe	.L107
	mov	rdi, QWORD PTR 456[rsp]
	mov	eax, r10d
	mov	rsi, QWORD PTR 440[rsp]
	vmovaps	xmm16, xmm17
	mov	r13, QWORD PTR 448[rsp]
	mov	r15, QWORD PTR 232[rsp]
	lea	r11, [rax+rdi]
	mov	rdi, QWORD PTR 384[rsp]
	add	rsi, rax
	add	r13, rax
	add	rdi, rax
	add	rax, QWORD PTR 400[rsp]
	lea	rax, [r15+rax*4]
	lea	rdi, [r15+rdi*4]
	mov	r15, QWORD PTR 432[rsp]
	vmovdqu	xmm12, XMMWORD PTR [r15+r11]
	vmovdqu	xmm8, XMMWORD PTR [r15+rsi]
	vpmovzxbw	xmm15, xmm12
	vpsrldq	xmm12, xmm12, 8
	vpmovzxbw	xmm18, xmm8
	vpmovsxwd	xmm26, xmm15
	vpsrldq	xmm8, xmm8, 8
	vpmovzxbw	xmm12, xmm12
	vpsrldq	xmm19, xmm15, 8
	vcvtdq2ps	xmm26, xmm26
	vpmovzxbw	xmm14, xmm8
	vmovdqu	xmm8, XMMWORD PTR 3[r15+rsi]
	vpmovsxwd	xmm24, xmm12
	vmulps	xmm15, xmm26, xmm25
	vcvtdq2ps	xmm24, xmm24
	vpsrldq	xmm12, xmm12, 8
	vpmovsxwd	xmm19, xmm19
	vpmovzxbw	xmm13, xmm8
	vcvtdq2ps	xmm19, xmm19
	vpsrldq	xmm8, xmm8, 8
	vpmovsxwd	xmm12, xmm12
	vpmovsxwd	xmm23, xmm13
	vpsrldq	xmm13, xmm13, 8
	vpmovzxbw	xmm8, xmm8
	vcvtdq2ps	xmm12, xmm12
	vcvtdq2ps	xmm23, xmm23
	vpmovsxwd	xmm13, xmm13
	vcvtdq2ps	xmm13, xmm13
	vfmadd132ps	xmm23, xmm15, xmm17
	vmulps	xmm15, xmm19, xmm25
	vfmadd132ps	xmm13, xmm15, xmm17
	vmulps	xmm15, xmm24, xmm25
	vmovaps	XMMWORD PTR 272[rsp], xmm13
	vpmovsxwd	xmm13, xmm8
	vcvtdq2ps	xmm28, xmm13
	vpsrldq	xmm13, xmm8, 8
	vfmadd132ps	xmm28, xmm15, xmm17
	vmovdqu	xmm15, XMMWORD PTR [r15+r13]
	vmulps	xmm8, xmm12, xmm25
	vpmovsxwd	xmm13, xmm13
	vpmovzxbw	xmm21, xmm15
	vcvtdq2ps	xmm13, xmm13
	vpsrldq	xmm15, xmm15, 8
	vpmovsxwd	xmm31, xmm21
	vpsrldq	xmm21, xmm21, 8
	vpmovzxbw	xmm15, xmm15
	vcvtdq2ps	xmm31, xmm31
	vmulps	xmm31, xmm31, xmm25
	vpmovsxwd	xmm21, xmm21
	vmovaps	XMMWORD PTR 304[rsp], xmm28
	vcvtdq2ps	xmm21, xmm21
	vmulps	xmm21, xmm21, xmm25
	vfmadd132ps	xmm13, xmm8, xmm17
	vmovdqu	xmm8, XMMWORD PTR 3[r15+r11]
	vpmovzxbw	xmm22, xmm8
	vpsrldq	xmm8, xmm8, 8
	vpmovsxwd	xmm28, xmm22
	vpsrldq	xmm22, xmm22, 8
	vpmovzxbw	xmm8, xmm8
	vcvtdq2ps	xmm28, xmm28
	vfmadd231ps	xmm31, xmm17, xmm28
	vpmovsxwd	xmm22, xmm22
	vpmovsxwd	xmm27, xmm8
	vcvtdq2ps	xmm22, xmm22
	vfmadd231ps	xmm21, xmm17, xmm22
	vpsrldq	xmm8, xmm8, 8
	vcvtdq2ps	xmm27, xmm27
	vpmovsxwd	xmm8, xmm8
	vcvtdq2ps	xmm8, xmm8
	vmovaps	XMMWORD PTR 320[rsp], xmm31
	vpmovsxwd	xmm31, xmm18
	vpsrldq	xmm18, xmm18, 8
	vpmovsxwd	xmm18, xmm18
	vmovaps	XMMWORD PTR 336[rsp], xmm21
	vpmovsxwd	xmm21, xmm15
	vcvtdq2ps	xmm31, xmm31
	vcvtdq2ps	xmm18, xmm18
	vfmadd213ps	xmm18, xmm9, XMMWORD PTR 16[rdi]
	vpsrldq	xmm15, xmm15, 8
	vcvtdq2ps	xmm21, xmm21
	vmulps	xmm21, xmm21, xmm25
	vfmadd213ps	xmm31, xmm9, XMMWORD PTR [rdi]
	vpmovsxwd	xmm15, xmm15
	vcvtdq2ps	xmm15, xmm15
	vmulps	xmm15, xmm15, xmm25
	vfmadd231ps	xmm18, xmm22, xmm11
	vpmovsxwd	xmm22, xmm14
	vpsrldq	xmm14, xmm14, 8
	vcvtdq2ps	xmm22, xmm22
	vfmadd213ps	xmm22, xmm9, XMMWORD PTR 32[rdi]
	vfmadd132ps	xmm16, xmm15, xmm8
	vfmadd231ps	xmm31, xmm28, xmm11
	vpmovsxwd	xmm14, xmm14
	vmovdqu	xmm15, XMMWORD PTR 3[r15+r13]
	vcvtdq2ps	xmm14, xmm14
	vfmadd213ps	xmm14, xmm9, XMMWORD PTR 48[rdi]
	vfmadd231ps	xmm21, xmm17, xmm27
	vpmovzxbw	xmm20, xmm15
	vpsrldq	xmm15, xmm15, 8
	vfmadd231ps	xmm22, xmm27, xmm11
	vaddps	xmm23, xmm23, xmm31
	vmovaps	XMMWORD PTR 256[rsp], xmm16
	vpmovzxbw	xmm16, xmm15
	vfmadd132ps	xmm8, xmm14, xmm11
	vpmovsxwd	xmm14, xmm20
	vmovaps	XMMWORD PTR 368[rsp], xmm21
	vcvtdq2ps	xmm14, xmm14
	vmovups	XMMWORD PTR [rdi], xmm23
	vaddps	xmm8, xmm8, xmm13
	vaddps	xmm13, xmm18, XMMWORD PTR 272[rsp]
	vpmovsxwd	xmm18, xmm16
	vcvtdq2ps	xmm18, xmm18
	vmovups	XMMWORD PTR 16[rdi], xmm13
	vaddps	xmm13, xmm22, XMMWORD PTR 304[rsp]
	vmovups	XMMWORD PTR 48[rdi], xmm8
	vpsrldq	xmm8, xmm16, 8
	vpmovsxwd	xmm8, xmm8
	vmovups	XMMWORD PTR 32[rdi], xmm13
	vpsrldq	xmm13, xmm20, 8
	vcvtdq2ps	xmm8, xmm8
	vfmadd213ps	xmm26, xmm9, XMMWORD PTR [rax]
	vfmadd213ps	xmm19, xmm9, XMMWORD PTR 16[rax]
	vpmovsxwd	xmm13, xmm13
	vfmadd213ps	xmm24, xmm9, XMMWORD PTR 32[rax]
	vfmadd213ps	xmm12, xmm9, XMMWORD PTR 48[rax]
	vcvtdq2ps	xmm13, xmm13
	vfmadd132ps	xmm14, xmm26, xmm11
	vfmadd132ps	xmm13, xmm19, xmm11
	vfmadd132ps	xmm8, xmm12, xmm11
	vfmadd132ps	xmm18, xmm24, xmm11
	vaddps	xmm12, xmm14, XMMWORD PTR 320[rsp]
	vaddps	xmm8, xmm8, XMMWORD PTR 256[rsp]
	vmovups	XMMWORD PTR [rax], xmm12
	vaddps	xmm12, xmm13, XMMWORD PTR 336[rsp]
	vmovups	XMMWORD PTR 48[rax], xmm8
	vmovups	XMMWORD PTR 16[rax], xmm12
	vaddps	xmm12, xmm18, XMMWORD PTR 368[rsp]
	vmovups	XMMWORD PTR 32[rax], xmm12
	mov	eax, r14d
	and	eax, -16
	test	r14b, 15
	je	.L50
	add	r8d, eax
.L55:
	mov	r15d, r14d
	sub	r15d, eax
	lea	esi, -1[r15]
	cmp	esi, 6
	jbe	.L56
	mov	rsi, QWORD PTR 456[rsp]
	mov	rdi, QWORD PTR 440[rsp]
	add	eax, r10d
	vmovaps	xmm16, xmm17
	mov	eax, eax
	mov	r11, QWORD PTR 400[rsp]
	mov	r14, QWORD PTR 448[rsp]
	lea	r13, [rsi+rax]
	lea	rsi, [rdi+rax]
	mov	rdi, QWORD PTR 384[rsp]
	mov	r10, QWORD PTR 232[rsp]
	add	r14, rax
	add	rdi, rax
	add	rax, r11
	lea	rax, [r10+rax*4]
	lea	rdi, [r10+rdi*4]
	mov	r10, QWORD PTR 432[rsp]
	vmovq	xmm8, QWORD PTR [r10+rsi]
	vmovq	xmm12, QWORD PTR [r10+r13]
	vpmovzxbw	xmm15, xmm8
	vpsrlq	xmm8, xmm8, 32
	vpmovzxbw	xmm14, xmm12
	vmovq	r12, xmm15
	vpsrlq	xmm12, xmm12, 32
	vpmovzxbw	xmm15, xmm8
	vmovq	xmm8, QWORD PTR 3[r10+rsi]
	vmovq	r11, xmm15
	vpmovzxwd	xmm15, xmm14
	vpmovzxbw	xmm12, xmm12
	vpsrlq	xmm14, xmm14, 32
	vmovq	xmm15, xmm15
	vpmovzxbw	xmm13, xmm8
	vpmovzxwd	xmm14, xmm14
	vcvtdq2ps	xmm21, xmm15
	vpsrlq	xmm8, xmm8, 32
	vmulps	xmm20, xmm25, xmm21
	vmovq	xmm14, xmm14
	vpmovzxbw	xmm8, xmm8
	vcvtdq2ps	xmm15, xmm14
	vpmovzxwd	xmm14, xmm12
	vpsrlq	xmm12, xmm12, 32
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
	vmulps	xmm14, xmm25, xmm15
	vfmadd132ps	xmm13, xmm14, xmm17
	vmulps	xmm14, xmm25, xmm19
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
	vmulps	xmm13, xmm25, xmm12
	vfmadd132ps	xmm8, xmm13, xmm17
	vmovaps	xmm26, xmm8
	vmovq	xmm8, QWORD PTR 3[r10+r13]
	mov	r13, r10
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
	vmovq	xmm8, QWORD PTR [r10+r14]
	vpmovzxbw	xmm13, xmm8
	vpsrlq	xmm8, xmm8, 32
	vpmovzxbw	xmm8, xmm8
	vmovq	r10, xmm8
	vpmovzxwd	xmm8, xmm13
	vpsrlq	xmm13, xmm13, 32
	vmovq	xmm20, xmm8
	vmovq	xmm8, r10
	vpmovzxwd	xmm13, xmm13
	vcvtdq2ps	xmm20, xmm20
	vmulps	xmm20, xmm20, xmm25
	vmovq	xmm13, xmm13
	vcvtdq2ps	xmm13, xmm13
	vmulps	xmm13, xmm13, xmm25
	vfmadd231ps	xmm20, xmm14, xmm17
	vfmadd231ps	xmm13, xmm23, xmm17
	vmovaps	XMMWORD PTR 400[rsp], xmm20
	vmovaps	XMMWORD PTR 384[rsp], xmm13
	vpmovzxwd	xmm13, xmm8
	vpsrlq	xmm8, xmm8, 32
	vmovq	xmm13, xmm13
	vpmovzxwd	xmm8, xmm8
	vcvtdq2ps	xmm13, xmm13
	vmulps	xmm13, xmm13, xmm25
	vmovq	xmm8, xmm8
	vcvtdq2ps	xmm8, xmm8
	vmulps	xmm8, xmm8, xmm25
	vfmadd231ps	xmm13, xmm24, xmm17
	vfmadd132ps	xmm16, xmm8, xmm22
	vmovq	xmm8, QWORD PTR 3[r13+r14]
	vmovaps	XMMWORD PTR 368[rsp], xmm13
	vpmovzxbw	xmm13, xmm8
	vpsrlq	xmm8, xmm8, 32
	vpmovzxbw	xmm8, xmm8
	vmovq	rsi, xmm13
	vmovq	r13, xmm8
	vmovq	xmm8, r12
	vpmovzxwd	xmm8, xmm8
	vmovq	xmm8, xmm8
	vcvtdq2ps	xmm13, xmm8
	vmovq	xmm8, QWORD PTR [rdi]
	vfmadd231ps	xmm8, xmm9, xmm13
	vfmadd132ps	xmm14, xmm8, xmm11
	vmovq	xmm8, r12
	vpsrlq	xmm8, xmm8, 32
	vpmovzxwd	xmm8, xmm8
	vmovq	xmm8, xmm8
	vcvtdq2ps	xmm13, xmm8
	vmovq	xmm8, QWORD PTR 8[rdi]
	vaddps	xmm14, xmm27, xmm14
	vfmadd132ps	xmm13, xmm8, xmm9
	vmovq	xmm8, r11
	vpmovzxwd	xmm8, xmm8
	vmovq	xmm8, xmm8
	vmovlps	QWORD PTR [rdi], xmm14
	vmovq	xmm14, rsi
	vfmadd231ps	xmm13, xmm11, xmm23
	vcvtdq2ps	xmm23, xmm8
	vmovq	xmm8, QWORD PTR 16[rdi]
	vfmadd132ps	xmm23, xmm8, xmm9
	vmovq	xmm8, r11
	vpsrlq	xmm8, xmm8, 32
	vpmovzxwd	xmm8, xmm8
	vmovq	xmm8, xmm8
	vaddps	xmm13, xmm28, xmm13
	vfmadd231ps	xmm23, xmm11, xmm24
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
	vmovq	xmm8, QWORD PTR [rax]
	vfmadd132ps	xmm21, xmm8, xmm9
	vpsrlq	xmm8, xmm14, 32
	vpmovzxwd	xmm8, xmm8
	vmovq	xmm14, xmm8
	vmovq	xmm8, QWORD PTR 8[rax]
	vcvtdq2ps	xmm14, xmm14
	vfmadd132ps	xmm15, xmm8, xmm9
	vmovq	xmm8, QWORD PTR 16[rax]
	vfmadd132ps	xmm13, xmm21, xmm11
	vfmadd132ps	xmm19, xmm8, xmm9
	vmovq	xmm8, r13
	vpsrlq	xmm8, xmm8, 32
	vpmovzxwd	xmm8, xmm8
	vfmadd132ps	xmm14, xmm15, xmm11
	vmovq	xmm15, r13
	vmovq	xmm8, xmm8
	vpmovzxwd	xmm15, xmm15
	vaddps	xmm13, xmm13, XMMWORD PTR 400[rsp]
	vmovq	xmm15, xmm15
	vcvtdq2ps	xmm15, xmm15
	vfmadd132ps	xmm15, xmm19, xmm11
	vcvtdq2ps	xmm19, xmm8
	vmovq	xmm8, QWORD PTR 24[rax]
	vmovlps	QWORD PTR [rax], xmm13
	vfmadd132ps	xmm12, xmm8, xmm9
	vmovaps	xmm8, xmm11
	vaddps	xmm14, xmm14, XMMWORD PTR 384[rsp]
	vmovlps	QWORD PTR 8[rax], xmm14
	vfmadd132ps	xmm8, xmm12, xmm19
	vaddps	xmm12, xmm15, XMMWORD PTR 368[rsp]
	vmovlps	QWORD PTR 16[rax], xmm12
	vaddps	xmm8, xmm8, xmm16
	vmovlps	QWORD PTR 24[rax], xmm8
	mov	eax, r15d
	and	eax, -8
	and	r15d, 7
	je	.L50
	add	r8d, eax
.L56:
	mov	esi, DWORD PTR 424[rsp]
	lea	r10d, 1[r8]
	lea	eax, -2[rsi]
	mov	DWORD PTR 304[rsp], eax
	cmp	eax, r10d
	jle	.L57
	cmp	esi, r8d
	jle	.L57
	mov	r15, QWORD PTR 432[rsp]
	mov	r14, QWORD PTR 456[rsp]
	movsxd	rax, r8d
	mov	QWORD PTR 240[rsp], rdx
	mov	r13, QWORD PTR 448[rsp]
	mov	r12, QWORD PTR 440[rsp]
	mov	QWORD PTR 160[rsp], rcx
	lea	r10, [rax+r14]
	add	r14, r15
	mov	rsi, QWORD PTR 352[rsp]
	mov	DWORD PTR 252[rsp], ebx
	lea	r11, [rax+r12]
	mov	QWORD PTR 336[rsp], r14
	lea	r14, [r15+r12]
	lea	r12, [r15+r13]
	lea	r8, [rax+r13]
	movzx	r13d, BYTE PTR [r15+r10]
	sal	rsi, 2
	mov	QWORD PTR 320[rsp], r12
	movzx	r12d, BYTE PTR [r15+r11]
	lea	rdi, [rdx+rsi]
	mov	DWORD PTR 192[rsp], r9d
	add	rsi, QWORD PTR 464[rsp]
	mov	DWORD PTR 384[rsp], r12d
	movzx	r12d, BYTE PTR [r15+r8]
	mov	DWORD PTR 368[rsp], r13d
	mov	r13, QWORD PTR 336[rsp]
	mov	DWORD PTR 400[rsp], r12d
	movzx	r12d, BYTE PTR 1[r15+r11]
	movzx	r11d, BYTE PTR 2[r15+r11]
	mov	DWORD PTR 352[rsp], r12d
	movzx	r12d, BYTE PTR 1[r15+r10]
	movzx	r10d, BYTE PTR 2[r15+r10]
	mov	DWORD PTR 272[rsp], r12d
	movzx	r12d, BYTE PTR 1[r15+r8]
	mov	DWORD PTR 256[rsp], r12d
	mov	r12d, r10d
	movzx	r10d, BYTE PTR 2[r15+r8]
	mov	r9d, DWORD PTR 272[rsp]
	mov	r15, QWORD PTR 320[rsp]
	mov	r8d, DWORD PTR 352[rsp]
	mov	ebx, DWORD PTR 256[rsp]
.L58:
	vcvtusi2ss	xmm8, xmm10, DWORD PTR 384[rsp]
	movzx	ecx, BYTE PTR 3[r13+rax]
	vmovaps	xmm16, xmm6
	movzx	edx, BYTE PTR 3[r15+rax]
	vcvtusi2ss	xmm12, xmm10, DWORD PTR 400[rsp]
	mov	QWORD PTR 336[rsp], rax
	vcvtusi2ss	xmm13, xmm10, DWORD PTR 368[rsp]
	mov	DWORD PTR 368[rsp], ecx
	mov	DWORD PTR 400[rsp], edx
	vmovaps	xmm15, xmm8
	vcvtusi2ss	xmm8, xmm10, ecx
	movzx	ecx, BYTE PTR 3[r14+rax]
	vmovaps	xmm14, xmm12
	vcvtusi2ss	xmm12, xmm10, ecx
	vfmadd213ss	xmm16, xmm13, DWORD PTR [rdi+rax*4]
	mov	DWORD PTR 384[rsp], ecx
	vmulss	xmm18, xmm7, xmm8
	vfmadd132ss	xmm12, xmm18, xmm5
	vaddss	xmm12, xmm12, xmm16
	vmovaps	xmm16, xmm6
	vfmadd231ss	xmm12, xmm4, xmm15
	vmovss	DWORD PTR [rdi+rax*4], xmm12
	vcvtusi2ss	xmm12, xmm10, edx
	vfmadd213ss	xmm13, xmm4, DWORD PTR [rsi+rax*4]
	vmulss	xmm12, xmm12, xmm7
	vfmadd132ss	xmm8, xmm12, xmm5
	vcvtusi2ss	xmm12, xmm10, ebx
	movzx	ebx, BYTE PTR 4[r15+rax]
	vaddss	xmm8, xmm8, xmm13
	vcvtusi2ss	xmm13, xmm10, r9d
	movzx	r9d, BYTE PTR 4[r13+rax]
	vfmadd231ss	xmm8, xmm6, xmm14
	vmovaps	xmm14, xmm12
	vmovss	DWORD PTR [rsi+rax*4], xmm8
	vcvtusi2ss	xmm8, xmm10, r8d
	movzx	r8d, BYTE PTR 4[r14+rax]
	vfmadd213ss	xmm16, xmm13, DWORD PTR 4[rdi+rax*4]
	vcvtusi2ss	xmm12, xmm10, r8d
	vmovaps	xmm15, xmm8
	vcvtusi2ss	xmm8, xmm10, r9d
	vmulss	xmm18, xmm7, xmm8
	vfmadd132ss	xmm12, xmm18, xmm5
	vaddss	xmm12, xmm12, xmm16
	vmovaps	xmm16, xmm6
	vfmadd231ss	xmm12, xmm4, xmm15
	vmovss	DWORD PTR 4[rdi+rax*4], xmm12
	vcvtusi2ss	xmm12, xmm10, ebx
	vfmadd213ss	xmm13, xmm4, DWORD PTR 4[rsi+rax*4]
	vmulss	xmm12, xmm12, xmm7
	vfmadd132ss	xmm8, xmm12, xmm5
	vcvtusi2ss	xmm12, xmm10, r10d
	movzx	r10d, BYTE PTR 5[r15+rax]
	vaddss	xmm8, xmm8, xmm13
	vcvtusi2ss	xmm13, xmm10, r12d
	movzx	r12d, BYTE PTR 5[r13+rax]
	vfmadd231ss	xmm8, xmm6, xmm14
	vmovaps	xmm14, xmm12
	vmovss	DWORD PTR 4[rsi+rax*4], xmm8
	vcvtusi2ss	xmm8, xmm10, r11d
	movzx	r11d, BYTE PTR 5[r14+rax]
	vfmadd213ss	xmm16, xmm13, DWORD PTR 8[rdi+rax*4]
	vcvtusi2ss	xmm12, xmm10, r11d
	vmovaps	xmm15, xmm8
	vcvtusi2ss	xmm8, xmm10, r12d
	vmulss	xmm18, xmm7, xmm8
	vfmadd132ss	xmm12, xmm18, xmm5
	vaddss	xmm12, xmm12, xmm16
	vfmadd231ss	xmm12, xmm4, xmm15
	vmovss	DWORD PTR 8[rdi+rax*4], xmm12
	vcvtusi2ss	xmm12, xmm10, r10d
	vfmadd213ss	xmm13, xmm4, DWORD PTR 8[rsi+rax*4]
	vmulss	xmm12, xmm12, xmm7
	vfmadd132ss	xmm8, xmm12, xmm5
	vaddss	xmm8, xmm8, xmm13
	vfmadd231ss	xmm8, xmm6, xmm14
	vmovss	DWORD PTR 8[rsi+rax*4], xmm8
	add	rax, 3
	lea	edx, 1[rax]
	cmp	edx, DWORD PTR 304[rsp]
	jl	.L58
	mov	rax, QWORD PTR 336[rsp]
	mov	ebx, DWORD PTR 252[rsp]
	mov	rdx, QWORD PTR 240[rsp]
	mov	r9d, DWORD PTR 192[rsp]
	mov	rcx, QWORD PTR 160[rsp]
	lea	r8d, 3[rax]
	lea	r10d, 4[rax]
.L57:
	mov	r13, QWORD PTR 456[rsp]
	mov	r14, QWORD PTR 432[rsp]
	mov	eax, r8d
	mov	r15, QWORD PTR 440[rsp]
	mov	r12d, DWORD PTR 424[rsp]
	lea	rsi, [rax+r13]
	movzx	edi, BYTE PTR [r14+rsi]
	movzx	esi, BYTE PTR 3[r14+rsi]
	lea	r11, [rax+r15]
	add	rax, QWORD PTR 448[rsp]
	vcvtusi2ss	xmm13, xmm10, esi
	movzx	esi, BYTE PTR [r14+rax]
	movzx	eax, BYTE PTR 3[r14+rax]
	vcvtusi2ss	xmm14, xmm10, edi
	movzx	edi, BYTE PTR [r14+r11]
	vcvtusi2ss	xmm8, xmm10, esi
	vmulss	xmm18, xmm6, xmm14
	vmulss	xmm15, xmm6, xmm8
	vcvtusi2ss	xmm8, xmm10, eax
	mov	eax, DWORD PTR 420[rsp]
	add	eax, r8d
	mov	eax, eax
	vmovaps	xmm12, xmm8
	vcvtusi2ss	xmm8, xmm10, edi
	sal	rax, 2
	movzx	edi, BYTE PTR 3[r14+r11]
	vcvtusi2ss	xmm16, xmm10, edi
	vfmadd213ss	xmm8, xmm4, DWORD PTR [rdx+rax]
	vfmadd132ss	xmm16, xmm18, xmm5
	vfmadd231ss	xmm8, xmm7, xmm13
	vfmadd132ss	xmm13, xmm15, xmm5
	vaddss	xmm8, xmm8, xmm16
	vmovss	DWORD PTR [rdx+rax], xmm8
	add	rax, QWORD PTR 464[rsp]
	vfmadd213ss	xmm14, xmm4, DWORD PTR [rax]
	vfmadd132ss	xmm12, xmm14, xmm7
	vaddss	xmm8, xmm12, xmm13
	vmovss	DWORD PTR [rax], xmm8
	cmp	r12d, r10d
	jle	.L50
	mov	eax, r10d
	lea	rsi, 0[r13+rax]
	lea	r11, [r15+rax]
	add	rax, QWORD PTR 448[rsp]
	movzx	edi, BYTE PTR [r14+rsi]
	movzx	esi, BYTE PTR 3[r14+rsi]
	vcvtusi2ss	xmm13, xmm10, esi
	movzx	esi, BYTE PTR [r14+rax]
	movzx	eax, BYTE PTR 3[r14+rax]
	vcvtusi2ss	xmm14, xmm10, edi
	vcvtusi2ss	xmm8, xmm10, esi
	movzx	esi, BYTE PTR [r14+r11]
	vmulss	xmm18, xmm6, xmm14
	vmulss	xmm15, xmm6, xmm8
	vcvtusi2ss	xmm8, xmm10, eax
	mov	eax, DWORD PTR 420[rsp]
	add	eax, r10d
	mov	eax, eax
	vmovaps	xmm12, xmm8
	vcvtusi2ss	xmm8, xmm10, esi
	lea	rdi, 0[0+rax*4]
	movzx	esi, BYTE PTR 3[r14+r11]
	mov	r11, QWORD PTR 464[rsp]
	vcvtusi2ss	xmm16, xmm10, esi
	vfmadd213ss	xmm8, xmm4, DWORD PTR [rdx+rdi]
	vfmadd132ss	xmm16, xmm18, xmm5
	vfmadd231ss	xmm8, xmm7, xmm13
	vfmadd132ss	xmm13, xmm15, xmm5
	vaddss	xmm8, xmm8, xmm16
	vmovss	DWORD PTR [rdx+rdi], xmm8
	vfmadd213ss	xmm14, xmm4, DWORD PTR [r11+rdi]
	vfmadd132ss	xmm12, xmm14, xmm7
	vaddss	xmm8, xmm12, xmm13
	vmovss	DWORD PTR [r11+rdi], xmm8
	lea	edi, 2[r8]
	cmp	r12d, edi
	jle	.L50
	mov	r8d, edi
	lea	rax, 0[r13+r8]
	lea	r10, [r15+r8]
	movzx	esi, BYTE PTR [r14+rax]
	movzx	eax, BYTE PTR 3[r14+rax]
	vcvtusi2ss	xmm14, xmm10, esi
	mov	rsi, QWORD PTR 448[rsp]
	vcvtusi2ss	xmm13, xmm10, eax
	lea	rax, [rsi+r8]
	movzx	esi, BYTE PTR [r14+rax]
	movzx	eax, BYTE PTR 3[r14+rax]
	vcvtusi2ss	xmm8, xmm10, esi
	vmulss	xmm15, xmm6, xmm8
	vcvtusi2ss	xmm8, xmm10, eax
	mov	eax, DWORD PTR 420[rsp]
	add	eax, edi
	mov	eax, eax
	vmovaps	xmm12, xmm8
.L203:
	lea	rsi, 0[0+rax*4]
	movzx	eax, BYTE PTR [r14+r10]
	vmulss	xmm18, xmm6, xmm14
	vcvtusi2ss	xmm8, xmm10, eax
	movzx	eax, BYTE PTR 3[r14+r10]
	vcvtusi2ss	xmm16, xmm10, eax
	vfmadd213ss	xmm8, xmm4, DWORD PTR [rdx+rsi]
	vfmadd132ss	xmm16, xmm18, xmm5
	vfmadd231ss	xmm8, xmm7, xmm13
	vfmadd132ss	xmm13, xmm15, xmm5
	vaddss	xmm8, xmm8, xmm16
	vmovss	DWORD PTR [rdx+rsi], xmm8
	vfmadd213ss	xmm14, xmm4, DWORD PTR [r11+rsi]
	vfmadd132ss	xmm12, xmm14, xmm7
	vaddss	xmm8, xmm12, xmm13
	vmovss	DWORD PTR [r11+rsi], xmm8
.L50:
	add	r9d, 2
.L47:
	cmp	DWORD PTR 248[rsp], r9d
	jle	.L40
	mov	eax, DWORD PTR 4[rcx]
	mov	edx, DWORD PTR [rcx]
	mov	r11, QWORD PTR 168[rsp]
	mov	rdi, QWORD PTR 232[rsp]
	add	eax, r9d
	add	edx, ebx
	sub	r9d, DWORD PTR 228[rsp]
	mov	rsi, QWORD PTR 40[rcx]
	cdqe
	movsxd	rdx, edx
	imul	rax, QWORD PTR 200[rsp]
	add	rax, rdx
	lea	r10, [rax+rax*2]
	mov	rax, QWORD PTR 136[rsp]
	mov	r13, r10
	lea	r12, [rax+r10]
	movsxd	rax, r9d
	imul	r11, rax
	mov	eax, ebx
	sub	eax, DWORD PTR 224[rsp]
	cdqe
	lea	rax, [rax+rax*2]
	add	rax, r11
	lea	rdi, [rdi+rax*4]
	mov	eax, DWORD PTR 416[rsp]
	cmp	eax, 7
	jle	.L109
	lea	r13d, -8[rax]
	shr	eax, 3
	lea	r8, [rsi+r10]
	lea	r9d, 0[0+rax*8]
	lea	rdx, [rsi+r12]
	xor	eax, eax
	.p2align 4,,10
	.p2align 3
.L62:
	vpmovzxbd	ymm14, QWORD PTR [r8+rax]
	vpmovzxbd	ymm13, QWORD PTR 3[r8+rax]
	vpmovzxbd	ymm12, QWORD PTR [rdx+rax]
	vpmovzxbd	ymm8, QWORD PTR 3[rdx+rax]
	vcvtdq2ps	ymm14, ymm14
	vfmadd213ps	ymm14, ymm0, YMMWORD PTR [rdi+rax*4]
	vcvtdq2ps	ymm13, ymm13
	vcvtdq2ps	ymm12, ymm12
	vcvtdq2ps	ymm8, ymm8
	vfmadd132ps	ymm13, ymm14, ymm1
	vfmadd132ps	ymm12, ymm13, ymm2
	vfmadd132ps	ymm8, ymm12, ymm3
	vmovups	YMMWORD PTR [rdi+rax*4], ymm8
	add	rax, 8
	cmp	rax, r9
	jne	.L62
	mov	eax, r13d
	and	eax, -8
	lea	r14d, 8[rax]
	mov	eax, DWORD PTR 416[rsp]
	sub	eax, r14d
	mov	DWORD PTR 196[rsp], eax
	test	eax, eax
	jle	.L40
	mov	eax, r14d
	lea	r13, [r10+rax]
	add	r12, rax
.L61:
	sub	rbx, QWORD PTR 184[rsp]
	mov	eax, DWORD PTR 196[rsp]
	mov	r15d, r14d
	lea	r9, [rsi+r13]
	lea	rdx, [rbx+rbx*2]
	mov	r8, QWORD PTR 232[rsp]
	mov	QWORD PTR 464[rsp], r15
	add	rdx, r11
	lea	r10, 3[rax+r12]
	add	r15, rdx
	add	r10, rsi
	lea	rbx, [r8+r15*4]
	lea	rdx, [r15+rax]
	cmp	rbx, r10
	lea	rdx, [r8+rdx*4]
	lea	r8, [rsi+r12]
	setnb	r11b
	cmp	r8, rdx
	setnb	r10b
	or	r11b, r10b
	je	.L63
	lea	rax, 3[rax+r13]
	add	rax, rsi
	cmp	rbx, rax
	setnb	al
	cmp	r9, rdx
	setnb	dl
	or	al, dl
	je	.L63
	mov	edx, DWORD PTR 196[rsp]
	lea	eax, -1[rdx]
	cmp	eax, 30
	jbe	.L110
	shr	edx, 5
	lea	r11, 3[rsi+r12]
	lea	r10, 3[rsi+r13]
	mov	rax, rbx
	mov	ebx, edx
	mov	DWORD PTR 464[rsp], edx
	xor	edx, edx
	sal	rbx, 5
	.p2align 4,,10
	.p2align 3
.L65:
	vmovdqu	ymm8, YMMWORD PTR [r8+rdx]
	vmovdqu	ymm12, YMMWORD PTR [r10+rdx]
	sub	rax, -128
	vmovdqu	ymm13, YMMWORD PTR [r9+rdx]
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
	vmovdqu	ymm8, YMMWORD PTR [r11+rdx]
	add	rdx, 32
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
	cmp	rdx, rbx
	jne	.L65
	mov	r9d, DWORD PTR 464[rsp]
	sal	r9d, 5
	cmp	r9d, DWORD PTR 196[rsp]
	je	.L40
	mov	r8d, r9d
.L64:
	mov	r11d, DWORD PTR 196[rsp]
	sub	r11d, r9d
	lea	eax, -1[r11]
	cmp	eax, 14
	jbe	.L111
	mov	eax, r9d
	mov	rbx, QWORD PTR 232[rsp]
	lea	r10, [rax+r12]
	lea	rdx, [rax+r13]
	add	rax, r15
	vmovdqu	xmm3, XMMWORD PTR [rsi+r10]
	vmovdqu	xmm0, XMMWORD PTR [rsi+rdx]
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
	vmovdqu	xmm0, XMMWORD PTR 3[rsi+rdx]
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
	vmovdqu	xmm0, XMMWORD PTR 3[rsi+r10]
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
	add	r8d, eax
.L66:
	mov	r10d, r11d
	sub	r10d, eax
	lea	edx, -1[r10]
	cmp	edx, 6
	jbe	.L67
	add	eax, r9d
	mov	rbx, QWORD PTR 232[rsp]
	vmovaps	xmm16, xmm9
	mov	eax, eax
	lea	r9, [rax+r12]
	lea	rdx, [rax+r13]
	add	rax, r15
	vmovq	xmm1, QWORD PTR [rsi+r9]
	vmovq	xmm0, QWORD PTR [rsi+rdx]
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
	vmovq	xmm0, QWORD PTR 3[rsi+rdx]
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
	vmovq	xmm0, QWORD PTR 3[rsi+r9]
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
	mov	eax, r10d
	and	eax, -8
	and	r10d, 7
	je	.L40
	add	r8d, eax
.L67:
	movsxd	rdx, r8d
	mov	ebx, DWORD PTR 196[rsp]
	lea	rax, 0[r13+rdx]
	lea	r10, [r12+rdx]
	lea	edx, [r14+r8]
	lea	r9, [rdi+rdx*4]
	movzx	edx, BYTE PTR [rsi+rax]
	movzx	eax, BYTE PTR 3[rsi+rax]
	vcvtusi2ss	xmm0, xmm10, edx
	vmovaps	xmm2, xmm0
	vcvtusi2ss	xmm0, xmm10, eax
	movzx	eax, BYTE PTR [rsi+r10]
	vfmadd213ss	xmm2, xmm4, DWORD PTR [r9]
	vcvtusi2ss	xmm1, xmm10, eax
	movzx	eax, BYTE PTR 3[rsi+r10]
	vmulss	xmm1, xmm1, xmm6
	vfmadd231ss	xmm1, xmm5, xmm0
	vcvtusi2ss	xmm0, xmm10, eax
	lea	eax, 1[r8]
	vfmadd132ss	xmm0, xmm2, xmm7
	vaddss	xmm0, xmm0, xmm1
	vmovss	DWORD PTR [r9], xmm0
	cmp	eax, ebx
	jge	.L40
	mov	edx, eax
	add	eax, r14d
	lea	r9, [rdx+r13]
	mov	eax, eax
	lea	r10, [rdx+r12]
	lea	rdx, [rdi+rax*4]
	movzx	eax, BYTE PTR [rsi+r9]
	vcvtusi2ss	xmm0, xmm10, eax
	movzx	eax, BYTE PTR 3[rsi+r9]
	vmovaps	xmm2, xmm0
	vcvtusi2ss	xmm0, xmm10, eax
	movzx	eax, BYTE PTR [rsi+r10]
	vfmadd213ss	xmm2, xmm4, DWORD PTR [rdx]
	vcvtusi2ss	xmm1, xmm10, eax
	movzx	eax, BYTE PTR 3[rsi+r10]
	vmulss	xmm1, xmm1, xmm6
	vfmadd231ss	xmm1, xmm5, xmm0
	vcvtusi2ss	xmm0, xmm10, eax
	lea	eax, 2[r8]
	vfmadd132ss	xmm0, xmm2, xmm7
	vaddss	xmm0, xmm0, xmm1
	vmovss	DWORD PTR [rdx], xmm0
	cmp	eax, ebx
	jge	.L40
	mov	edx, eax
	add	eax, r14d
	lea	r9, [rdx+r13]
	mov	eax, eax
	lea	r10, [rdx+r12]
	lea	rdx, [rdi+rax*4]
	movzx	eax, BYTE PTR [rsi+r9]
	vcvtusi2ss	xmm0, xmm10, eax
	movzx	eax, BYTE PTR 3[rsi+r9]
	vmovaps	xmm2, xmm0
	vcvtusi2ss	xmm0, xmm10, eax
	movzx	eax, BYTE PTR [rsi+r10]
	vfmadd213ss	xmm2, xmm4, DWORD PTR [rdx]
	vcvtusi2ss	xmm1, xmm10, eax
	movzx	eax, BYTE PTR 3[rsi+r10]
	vmulss	xmm1, xmm1, xmm6
	vfmadd231ss	xmm1, xmm5, xmm0
	vcvtusi2ss	xmm0, xmm10, eax
	lea	eax, 3[r8]
	vfmadd132ss	xmm0, xmm2, xmm7
	vaddss	xmm0, xmm0, xmm1
	vmovss	DWORD PTR [rdx], xmm0
	cmp	ebx, eax
	jle	.L40
	mov	edx, eax
	add	eax, r14d
	lea	r9, 0[r13+rdx]
	mov	eax, eax
	lea	r10, [r12+rdx]
	lea	rdx, [rdi+rax*4]
	movzx	eax, BYTE PTR [rsi+r9]
	vcvtusi2ss	xmm0, xmm10, eax
	movzx	eax, BYTE PTR 3[rsi+r9]
	vmovaps	xmm2, xmm0
	vcvtusi2ss	xmm0, xmm10, eax
	movzx	eax, BYTE PTR [rsi+r10]
	vfmadd213ss	xmm2, xmm4, DWORD PTR [rdx]
	vcvtusi2ss	xmm1, xmm10, eax
	movzx	eax, BYTE PTR 3[rsi+r10]
	vmulss	xmm1, xmm1, xmm6
	vfmadd231ss	xmm1, xmm5, xmm0
	vcvtusi2ss	xmm0, xmm10, eax
	lea	eax, 4[r8]
	vfmadd132ss	xmm0, xmm2, xmm7
	vaddss	xmm0, xmm0, xmm1
	vmovss	DWORD PTR [rdx], xmm0
	cmp	eax, ebx
	jge	.L40
	mov	edx, eax
	add	eax, r14d
	lea	r9, [rdx+r13]
	mov	eax, eax
	lea	r10, [rdx+r12]
	lea	rdx, [rdi+rax*4]
	movzx	eax, BYTE PTR [rsi+r9]
	vcvtusi2ss	xmm0, xmm10, eax
	movzx	eax, BYTE PTR 3[rsi+r9]
	vmovaps	xmm2, xmm0
	vcvtusi2ss	xmm0, xmm10, eax
	movzx	eax, BYTE PTR [rsi+r10]
	vfmadd213ss	xmm2, xmm4, DWORD PTR [rdx]
	vcvtusi2ss	xmm1, xmm10, eax
	movzx	eax, BYTE PTR 3[rsi+r10]
	vmulss	xmm1, xmm1, xmm6
	vfmadd231ss	xmm1, xmm5, xmm0
	vcvtusi2ss	xmm0, xmm10, eax
	lea	eax, 5[r8]
	vfmadd132ss	xmm0, xmm2, xmm7
	vaddss	xmm0, xmm0, xmm1
	vmovss	DWORD PTR [rdx], xmm0
	cmp	eax, ebx
	jge	.L40
	mov	edx, eax
	add	eax, r14d
	lea	r9, [rdx+r13]
	mov	eax, eax
	lea	r10, [rdx+r12]
	lea	rdx, [rdi+rax*4]
	movzx	eax, BYTE PTR [rsi+r9]
	vcvtusi2ss	xmm0, xmm10, eax
	movzx	eax, BYTE PTR 3[rsi+r9]
	vmovaps	xmm2, xmm0
	vcvtusi2ss	xmm0, xmm10, eax
	movzx	eax, BYTE PTR [rsi+r10]
	vfmadd213ss	xmm2, xmm4, DWORD PTR [rdx]
	vcvtusi2ss	xmm1, xmm10, eax
	movzx	eax, BYTE PTR 3[rsi+r10]
	vmulss	xmm1, xmm1, xmm6
	vfmadd231ss	xmm1, xmm5, xmm0
	vcvtusi2ss	xmm0, xmm10, eax
	lea	eax, 6[r8]
	vfmadd132ss	xmm0, xmm2, xmm7
	vaddss	xmm0, xmm0, xmm1
	vmovss	DWORD PTR [rdx], xmm0
	cmp	eax, ebx
	jge	.L40
	mov	edx, eax
	add	eax, r14d
	lea	r8, [rdx+r13]
	mov	eax, eax
	lea	r9, [rdx+r12]
	lea	rdx, [rdi+rax*4]
	movzx	eax, BYTE PTR [rsi+r8]
	vcvtusi2ss	xmm0, xmm10, eax
	movzx	eax, BYTE PTR 3[rsi+r8]
	vfmadd213ss	xmm4, xmm0, DWORD PTR [rdx]
	vcvtusi2ss	xmm0, xmm10, eax
	movzx	eax, BYTE PTR [rsi+r9]
	vcvtusi2ss	xmm1, xmm10, eax
	movzx	eax, BYTE PTR 3[rsi+r9]
	vmulss	xmm1, xmm1, xmm6
	vfmadd231ss	xmm1, xmm5, xmm0
	vcvtusi2ss	xmm0, xmm10, eax
	vfmadd132ss	xmm0, xmm4, xmm7
	vaddss	xmm0, xmm0, xmm1
	vmovss	DWORD PTR [rdx], xmm0
	.p2align 4,,10
	.p2align 3
.L40:
	add	rcx, 48
	cmp	QWORD PTR 216[rsp], rcx
	jne	.L69
.L208:
	mov	rbx, QWORD PTR 72[rsp]
	mov	r12d, DWORD PTR 68[rsp]
	mov	r15, QWORD PTR 56[rsp]
.L39:
	mov	r13d, DWORD PTR 208[rsp]
	cmp	r13d, DWORD PTR 64[rsp]
	jle	.L70
	test	r12d, r12d
	jle	.L70
	lea	rax, [rbx+rbx*2]
	mov	rcx, QWORD PTR 88[rsp]
	mov	rdi, QWORD PTR 232[rsp]
	lea	r8d, [r12+r12*2]
	lea	rbx, 0[0+rax*4]
	mov	rax, QWORD PTR 184[rsp]
	mov	r9, QWORD PTR 48[rsp]
	mov	r10d, DWORD PTR 228[rsp]
	vmovss	xmm3, DWORD PTR .LC5[rip]
	vmovss	xmm5, DWORD PTR .LC6[rip]
	mov	r14, QWORD PTR 200[rsp]
	lea	r11, [rcx+rax*4]
	mov	r12, rax
	.p2align 4,,10
	.p2align 3
.L82:
	lea	rax, [r9+r12]
	mov	QWORD PTR 464[rsp], r9
	vmovss	xmm2, DWORD PTR .LC6[rip]
	lea	rcx, [r11+r9*4]
	lea	rsi, [rax+rax*2]
	vmovss	xmm4, DWORD PTR .LC5[rip]
	xor	edx, edx
	add	rsi, QWORD PTR 16[r15]
	.p2align 4,,10
	.p2align 3
.L81:
	mov	eax, DWORD PTR [rcx]
	test	eax, eax
	je	.L71
	vcvtsi2ss	xmm0, xmm10, eax
	mov	eax, edx
	xor	r9d, r9d
	vdivss	xmm0, xmm30, xmm0
	vmulss	xmm1, xmm0, DWORD PTR [rdi+rax*4]
	vcomiss	xmm29, xmm1
	ja	.L80
	vaddss	xmm1, xmm1, xmm3
	vminss	xmm1, xmm1, xmm5
	vcvttss2si	r9d, xmm1
.L80:
	vmulss	xmm1, xmm0, DWORD PTR 4[rdi+rax*4]
	mov	BYTE PTR [rsi+rax], r9b
	xor	r9d, r9d
	vcomiss	xmm29, xmm1
	ja	.L79
	vaddss	xmm1, xmm1, xmm3
	vminss	xmm1, xmm1, xmm2
	vcvttss2si	r9d, xmm1
.L79:
	vmulss	xmm0, xmm0, DWORD PTR 8[rdi+rax*4]
	mov	BYTE PTR 1[rsi+rax], r9b
	xor	r9d, r9d
	vcomiss	xmm29, xmm0
	ja	.L78
	vaddss	xmm0, xmm0, xmm4
	vminss	xmm0, xmm0, xmm2
	vcvttss2si	r9d, xmm0
.L78:
	mov	BYTE PTR 2[rsi+rax], r9b
.L71:
	add	edx, 3
	add	rcx, 4
	cmp	edx, r8d
	jne	.L81
	mov	r9, QWORD PTR 464[rsp]
	inc	r10d
	add	rdi, rbx
	add	r9, r14
	cmp	r13d, r10d
	jne	.L82
.L70:
	add	QWORD PTR 184[rsp], 2032
	mov	rax, QWORD PTR 184[rsp]
	cmp	DWORD PTR 152[rsp], eax
	jg	.L83
	add	QWORD PTR 120[rsp], 8
	mov	r12d, DWORD PTR 40[rsp]
	mov	r13, QWORD PTR 48[rsp]
	mov	rax, QWORD PTR 16[rsp]
	mov	rbx, QWORD PTR 120[rsp]
	cmp	r12d, ebx
	jle	.L199
	mov	DWORD PTR 228[rsp], ebx
	add	r13, rax
	lea	edx, 8[rbx]
	jmp	.L85
	.p2align 4,,10
	.p2align 3
.L103:
	mov	eax, DWORD PTR 416[rsp]
	mov	DWORD PTR 420[rsp], eax
	xor	eax, eax
	mov	ebx, DWORD PTR 420[rsp]
	jmp	.L42
.L51:
	mov	eax, DWORD PTR 424[rsp]
	cmp	eax, 3
	jle	.L108
	sub	eax, 2
	mov	r8, QWORD PTR 432[rsp]
	mov	r12, QWORD PTR 456[rsp]
	mov	DWORD PTR 192[rsp], r9d
	mov	r10, QWORD PTR 448[rsp]
	mov	rdi, QWORD PTR 440[rsp]
	mov	DWORD PTR 368[rsp], eax
	mov	rax, QWORD PTR 352[rsp]
	lea	r13, [r8+r12]
	mov	DWORD PTR 252[rsp], ebx
	lea	r14, [r8+r10]
	lea	r11, [r8+rdi]
	mov	QWORD PTR 240[rsp], rdx
	lea	rsi, 0[0+rax*4]
	movzx	r15d, BYTE PTR [r11]
	lea	rax, [rdx+rsi]
	mov	QWORD PTR 336[rsp], rax
	mov	rax, QWORD PTR 464[rsp]
	add	rax, rsi
	movzx	esi, BYTE PTR 0[r13]
	mov	QWORD PTR 320[rsp], rax
	mov	eax, 3
	mov	DWORD PTR 384[rsp], esi
	movzx	esi, BYTE PTR [r14]
	mov	DWORD PTR 352[rsp], esi
	mov	rsi, rdi
	movzx	edi, BYTE PTR 1[r8+rdi]
	mov	DWORD PTR 304[rsp], edi
	movzx	edi, BYTE PTR 1[r8+r12]
	mov	r12, r10
	movzx	r10d, BYTE PTR 1[r8+r10]
	mov	DWORD PTR 272[rsp], edi
	mov	rdi, QWORD PTR 336[rsp]
	mov	DWORD PTR 400[rsp], r10d
	movzx	r10d, BYTE PTR 2[r8+rsi]
	mov	rsi, QWORD PTR 456[rsp]
	mov	DWORD PTR 256[rsp], r10d
	mov	r10, r8
	movzx	r10d, BYTE PTR 2[r10+r12]
	movzx	r8d, BYTE PTR 2[r8+rsi]
	mov	r12d, DWORD PTR 304[rsp]
	mov	rsi, QWORD PTR 320[rsp]
	mov	QWORD PTR 320[rsp], rcx
	mov	ebx, DWORD PTR 352[rsp]
	mov	ecx, DWORD PTR 272[rsp]
	mov	r9d, DWORD PTR 256[rsp]
.L60:
	vcvtusi2ss	xmm8, xmm10, r15d
	movzx	edx, BYTE PTR 0[r13+rax]
	movzx	r15d, BYTE PTR [r11+rax]
	vmovaps	xmm16, xmm6
	vcvtusi2ss	xmm12, xmm10, ebx
	movzx	ebx, BYTE PTR [r14+rax]
	mov	QWORD PTR 336[rsp], rax
	add	rdi, 12
	vcvtusi2ss	xmm13, xmm10, DWORD PTR 384[rsp]
	mov	DWORD PTR 384[rsp], edx
	add	rsi, 12
	vmovaps	xmm15, xmm8
	vcvtusi2ss	xmm8, xmm10, edx
	movzx	edx, BYTE PTR 1[r14+rax]
	vmovaps	xmm14, xmm12
	vcvtusi2ss	xmm12, xmm10, r15d
	vfmadd213ss	xmm16, xmm13, DWORD PTR -12[rdi]
	vmulss	xmm18, xmm7, xmm8
	vfmadd132ss	xmm12, xmm18, xmm5
	vaddss	xmm12, xmm12, xmm16
	vmovaps	xmm16, xmm6
	vfmadd231ss	xmm12, xmm4, xmm15
	vmovss	DWORD PTR -12[rdi], xmm12
	vcvtusi2ss	xmm12, xmm10, ebx
	vfmadd213ss	xmm13, xmm4, DWORD PTR -12[rsi]
	vmulss	xmm12, xmm12, xmm7
	vfmadd132ss	xmm8, xmm12, xmm5
	vcvtusi2ss	xmm12, xmm10, DWORD PTR 400[rsp]
	mov	DWORD PTR 400[rsp], edx
	vaddss	xmm8, xmm8, xmm13
	vcvtusi2ss	xmm13, xmm10, ecx
	movzx	ecx, BYTE PTR 1[r13+rax]
	vfmadd231ss	xmm8, xmm6, xmm14
	vmovaps	xmm14, xmm12
	vmovss	DWORD PTR -12[rsi], xmm8
	vcvtusi2ss	xmm8, xmm10, r12d
	movzx	r12d, BYTE PTR 1[r11+rax]
	vfmadd213ss	xmm16, xmm13, DWORD PTR -8[rdi]
	vcvtusi2ss	xmm12, xmm10, r12d
	vmovaps	xmm15, xmm8
	vcvtusi2ss	xmm8, xmm10, ecx
	vmulss	xmm18, xmm7, xmm8
	vfmadd132ss	xmm12, xmm18, xmm5
	vaddss	xmm12, xmm12, xmm16
	vmovaps	xmm16, xmm6
	vfmadd231ss	xmm12, xmm4, xmm15
	vmovss	DWORD PTR -8[rdi], xmm12
	vcvtusi2ss	xmm12, xmm10, edx
	vfmadd213ss	xmm13, xmm4, DWORD PTR -8[rsi]
	vmulss	xmm12, xmm12, xmm7
	vfmadd132ss	xmm8, xmm12, xmm5
	vcvtusi2ss	xmm12, xmm10, r10d
	movzx	r10d, BYTE PTR 2[r14+rax]
	vaddss	xmm8, xmm8, xmm13
	vcvtusi2ss	xmm13, xmm10, r8d
	movzx	r8d, BYTE PTR 2[r13+rax]
	vfmadd231ss	xmm8, xmm6, xmm14
	vmovaps	xmm14, xmm12
	vmovss	DWORD PTR -8[rsi], xmm8
	vcvtusi2ss	xmm8, xmm10, r9d
	movzx	r9d, BYTE PTR 2[r11+rax]
	add	rax, 3
	vfmadd213ss	xmm16, xmm13, DWORD PTR -4[rdi]
	lea	edx, -2[rax]
	vcvtusi2ss	xmm12, xmm10, r9d
	vmovaps	xmm15, xmm8
	vcvtusi2ss	xmm8, xmm10, r8d
	vmulss	xmm18, xmm7, xmm8
	vfmadd132ss	xmm12, xmm18, xmm5
	vaddss	xmm12, xmm12, xmm16
	vfmadd231ss	xmm12, xmm4, xmm15
	vmovss	DWORD PTR -4[rdi], xmm12
	vcvtusi2ss	xmm12, xmm10, r10d
	vfmadd213ss	xmm13, xmm4, DWORD PTR -4[rsi]
	vmulss	xmm12, xmm12, xmm7
	vfmadd132ss	xmm8, xmm12, xmm5
	vaddss	xmm8, xmm8, xmm13
	vfmadd231ss	xmm8, xmm6, xmm14
	vmovss	DWORD PTR -4[rsi], xmm8
	cmp	DWORD PTR 368[rsp], edx
	jg	.L60
	mov	ebx, DWORD PTR 252[rsp]
	mov	rdx, QWORD PTR 240[rsp]
	mov	r9d, DWORD PTR 192[rsp]
	mov	rcx, QWORD PTR 320[rsp]
	mov	edi, DWORD PTR 336[rsp]
.L59:
	mov	r12, QWORD PTR 456[rsp]
	mov	r14, QWORD PTR 432[rsp]
	mov	r8d, edi
	mov	r13, QWORD PTR 448[rsp]
	mov	r15, QWORD PTR 440[rsp]
	lea	rax, [r8+r12]
	mov	r11, QWORD PTR 464[rsp]
	movzx	esi, BYTE PTR [r14+rax]
	movzx	eax, BYTE PTR 3[r14+rax]
	lea	r10, [r8+r15]
	vcvtusi2ss	xmm13, xmm10, eax
	lea	rax, [r8+r13]
	vcvtusi2ss	xmm14, xmm10, esi
	movzx	esi, BYTE PTR [r14+rax]
	movzx	eax, BYTE PTR 3[r14+rax]
	vcvtusi2ss	xmm8, xmm10, esi
	vmulss	xmm18, xmm6, xmm14
	vmulss	xmm15, xmm6, xmm8
	vcvtusi2ss	xmm8, xmm10, eax
	mov	eax, DWORD PTR 420[rsp]
	add	eax, edi
	mov	eax, eax
	lea	r8, 0[0+rax*4]
	movzx	eax, BYTE PTR [r14+r10]
	vmovaps	xmm12, xmm8
	vcvtusi2ss	xmm8, xmm10, eax
	movzx	eax, BYTE PTR 3[r14+r10]
	lea	r10d, 1[rdi]
	vcvtusi2ss	xmm16, xmm10, eax
	vfmadd213ss	xmm8, xmm4, DWORD PTR [rdx+r8]
	vfmadd132ss	xmm16, xmm18, xmm5
	vfmadd231ss	xmm8, xmm7, xmm13
	vfmadd132ss	xmm13, xmm15, xmm5
	vaddss	xmm8, xmm8, xmm16
	vmovss	DWORD PTR [rdx+r8], xmm8
	vfmadd213ss	xmm14, xmm4, DWORD PTR [r11+r8]
	vfmadd132ss	xmm12, xmm14, xmm7
	vaddss	xmm8, xmm12, xmm13
	vmovss	DWORD PTR [r11+r8], xmm8
	cmp	r10d, DWORD PTR 424[rsp]
	jge	.L50
	mov	r8d, r10d
	lea	rax, [r8+r12]
	lea	r11, [r8+r15]
	movzx	esi, BYTE PTR [r14+rax]
	movzx	eax, BYTE PTR 3[r14+rax]
	vcvtusi2ss	xmm13, xmm10, eax
	lea	rax, [r8+r13]
	vcvtusi2ss	xmm14, xmm10, esi
	movzx	esi, BYTE PTR [r14+rax]
	movzx	eax, BYTE PTR 3[r14+rax]
	vcvtusi2ss	xmm8, xmm10, esi
	vmulss	xmm18, xmm6, xmm14
	vmulss	xmm15, xmm6, xmm8
	vcvtusi2ss	xmm8, xmm10, eax
	mov	eax, DWORD PTR 420[rsp]
	add	eax, r10d
	mov	eax, eax
	lea	r8, 0[0+rax*4]
	movzx	eax, BYTE PTR [r14+r11]
	vmovaps	xmm12, xmm8
	vcvtusi2ss	xmm8, xmm10, eax
	movzx	eax, BYTE PTR 3[r14+r11]
	mov	r11, QWORD PTR 464[rsp]
	vcvtusi2ss	xmm16, xmm10, eax
	vfmadd213ss	xmm8, xmm4, DWORD PTR [rdx+r8]
	vfmadd132ss	xmm16, xmm18, xmm5
	vfmadd231ss	xmm8, xmm7, xmm13
	vfmadd132ss	xmm13, xmm15, xmm5
	vaddss	xmm8, xmm8, xmm16
	vmovss	DWORD PTR [rdx+r8], xmm8
	vfmadd213ss	xmm14, xmm4, DWORD PTR [r11+r8]
	vfmadd132ss	xmm12, xmm14, xmm7
	vaddss	xmm8, xmm12, xmm13
	vmovss	DWORD PTR [r11+r8], xmm8
	lea	r8d, 2[rdi]
	cmp	r8d, DWORD PTR 424[rsp]
	jge	.L50
	mov	edi, r8d
	lea	rax, [r12+rdi]
	lea	r10, [r15+rdi]
	movzx	esi, BYTE PTR [r14+rax]
	movzx	eax, BYTE PTR 3[r14+rax]
	vcvtusi2ss	xmm13, xmm10, eax
	lea	rax, 0[r13+rdi]
	vcvtusi2ss	xmm14, xmm10, esi
	movzx	esi, BYTE PTR [r14+rax]
	movzx	eax, BYTE PTR 3[r14+rax]
	vcvtusi2ss	xmm8, xmm10, esi
	vmulss	xmm15, xmm6, xmm8
	vcvtusi2ss	xmm8, xmm10, eax
	mov	eax, DWORD PTR 420[rsp]
	add	eax, r8d
	mov	eax, eax
	vmovaps	xmm12, xmm8
	jmp	.L203
.L105:
	mov	DWORD PTR 424[rsp], eax
	mov	rax, QWORD PTR 40[rcx]
	mov	DWORD PTR 420[rsp], 0
	mov	QWORD PTR 432[rsp], rax
	jmp	.L48
.L63:
	mov	rax, QWORD PTR 464[rsp]
	mov	edx, DWORD PTR 196[rsp]
	lea	rsi, [rdi+rax*4]
	xor	eax, eax
.L68:
	movzx	edi, BYTE PTR [r9+rax]
	vcvtusi2ss	xmm0, xmm10, edi
	movzx	edi, BYTE PTR 3[r9+rax]
	vmovaps	xmm2, xmm0
	vcvtusi2ss	xmm0, xmm10, edi
	movzx	edi, BYTE PTR [r8+rax]
	vfmadd213ss	xmm2, xmm4, DWORD PTR [rsi+rax*4]
	vcvtusi2ss	xmm1, xmm10, edi
	movzx	edi, BYTE PTR 3[r8+rax]
	vmulss	xmm1, xmm1, xmm6
	vfmadd231ss	xmm1, xmm5, xmm0
	vcvtusi2ss	xmm0, xmm10, edi
	vfmadd132ss	xmm0, xmm2, xmm7
	vaddss	xmm0, xmm0, xmm1
	vmovss	DWORD PTR [rsi+rax*4], xmm0
	inc	rax
	cmp	edx, eax
	jg	.L68
	add	rcx, 48
	cmp	QWORD PTR 216[rsp], rcx
	jne	.L69
	jmp	.L208
.L107:
	xor	eax, eax
	jmp	.L55
.L106:
	xor	r10d, r10d
	xor	r8d, r8d
	jmp	.L53
.L109:
	xor	r14d, r14d
	jmp	.L61
.L111:
	xor	eax, eax
	jmp	.L66
.L110:
	xor	r9d, r9d
	xor	r8d, r8d
	jmp	.L64
.L108:
	xor	edi, edi
	jmp	.L59
.L199:
	mov	r13, QWORD PTR 32[rsp]
	mov	r14, QWORD PTR 24[rsp]
	vzeroupper
.L36:
	mov	rdi, QWORD PTR 232[rsp]
	mov	esi, 195072
	call	"_ZdlPvm"@PLT
	mov	rax, QWORD PTR 88[rsp]
	test	rax, rax
	je	.L86
	mov	rsi, r13
	mov	rdi, rax
	call	"_ZdlPvm"@PLT
.L86:
	mov	rdi, QWORD PTR 128[rsp]
	test	rdi, rdi
	je	.L1
	mov	rsi, r14
	sub	rsi, rdi
	call	"_ZdlPvm"@PLT
.L1:
	lea	rsp, -40[rbp]
	mov	rax, r15
	pop	rbx
	pop	r12
	pop	r13
	pop	r14
	pop	r15
	pop	rbp
	.cfi_remember_state
	.cfi_def_cfa 7, 8
	ret
.L206:
	.cfi_restore_state
	mov	rcx, QWORD PTR 216[rsp]
	xor	edi, edi
	cmp	QWORD PTR 128[rsp], rcx
	jne	.L25
	test	r12d, r12d
	jle	.L26
	mov	esi, DWORD PTR 152[rsp]
	test	esi, esi
	jg	.L27
	jmp	.L26
	.p2align 4,,10
	.p2align 3
.L205:
	mov	eax, DWORD PTR 200[rsp]
	mov	r12d, DWORD PTR 456[rsp]
	mov	QWORD PTR 128[rsp], 0
	xor	r14d, r14d
	mov	DWORD PTR 152[rsp], eax
	cmp	rbx, QWORD PTR 464[rsp]
	jne	.L5
	mov	QWORD PTR 216[rsp], 0
.L99:
	mov	QWORD PTR 88[rsp], 0
	jmp	.L20
.L13:
	mov	rax, r14
	sub	rax, QWORD PTR 128[rsp]
	mov	QWORD PTR 448[rsp], rax
	sar	rax, 4
	mov	rdx, rax
	movabs	rax, -6148914691236517205
	imul	rdx, rax
	movabs	rax, 192153584101141162
	cmp	rdx, rax
	je	.L191
	test	rdx, rdx
	mov	eax, 1
	mov	DWORD PTR 296[rsp], r11d
	cmovne	rax, rdx
	mov	DWORD PTR 352[rsp], r10d
	mov	DWORD PTR 304[rsp], r8d
	add	rax, rdx
	movabs	rdx, 192153584101141162
	mov	DWORD PTR 320[rsp], ecx
	cmp	rax, rdx
	mov	DWORD PTR 384[rsp], esi
	cmova	rax, rdx
	mov	DWORD PTR 400[rsp], r9d
	vmovss	DWORD PTR 336[rsp], xmm3
	lea	rax, [rax+rax*2]
	vmovss	DWORD PTR 360[rsp], xmm0
	sal	rax, 4
	vmovss	DWORD PTR 416[rsp], xmm1
	mov	rdi, rax
	mov	QWORD PTR 424[rsp], rax
	vmovss	DWORD PTR 368[rsp], xmm2
.LEHB3:
	call	"_Znwm"@PLT
.LEHE3:
	mov	rdx, QWORD PTR 448[rsp]
	mov	ecx, DWORD PTR 320[rsp]
	mov	QWORD PTR 440[rsp], rax
	mov	rdi, rax
	vmovss	xmm0, DWORD PTR 360[rsp]
	vmovss	xmm2, DWORD PTR 368[rsp]
	mov	r9d, DWORD PTR 400[rsp]
	mov	esi, DWORD PTR 384[rsp]
	mov	DWORD PTR 24[rax+rdx], ecx
	vinsertps	xmm0, xmm0, DWORD PTR 336[rsp], 0x10
	vinsertps	xmm2, xmm2, DWORD PTR 416[rsp], 0x10
	mov	r10d, DWORD PTR 352[rsp]
	mov	r8d, DWORD PTR 304[rsp]
	mov	DWORD PTR [rax+rdx], r9d
	mov	r11d, DWORD PTR 296[rsp]
	mov	rcx, QWORD PTR 432[rsp]
	vmovlhps	xmm2, xmm2, xmm0
	mov	DWORD PTR 4[rax+rdx], esi
	mov	DWORD PTR 28[rax+rdx], r10d
	mov	DWORD PTR 32[rax+rdx], r8d
	mov	DWORD PTR 36[rax+rdx], r11d
	mov	QWORD PTR 40[rax+rdx], rcx
	vmovups	XMMWORD PTR 8[rax+rdx], xmm2
	test	rdx, rdx
	je	.L17
	mov	rsi, QWORD PTR 128[rsp]
	call	"memcpy"@PLT
.L17:
	mov	rax, QWORD PTR 440[rsp]
	mov	rcx, QWORD PTR 448[rsp]
	mov	rdi, QWORD PTR 128[rsp]
	lea	rax, 48[rax+rcx]
	mov	QWORD PTR 216[rsp], rax
	test	rdi, rdi
	je	.L18
	mov	rsi, r14
	sub	rsi, rdi
	call	"_ZdlPvm"@PLT
.L18:
	mov	rax, QWORD PTR 440[rsp]
	mov	r14, QWORD PTR 424[rsp]
	mov	QWORD PTR 128[rsp], rax
	add	r14, rax
	jmp	.L12
.L2:
	lea	r14, 0[r13+r13*2]
	test	r14, r14
	js	.L190
	mov	rdi, r14
.LEHB4:
	call	"_Znwm"@PLT
.LEHE4:
	lea	r8, [rax+r14]
	xor	esi, esi
	mov	rdx, r14
	mov	rdi, rax
	mov	QWORD PTR 464[rsp], r8
	call	"memset"@PLT
	mov	r8, QWORD PTR 464[rsp]
	mov	QWORD PTR 16[r15], rax
	mov	rax, QWORD PTR 8[r12]
	mov	QWORD PTR 24[r15], r8
	mov	QWORD PTR 464[rsp], rax
	sub	rax, rbx
	mov	QWORD PTR 32[r15], r8
	mov	r12, rax
	jne	.L4
	mov	QWORD PTR 128[rsp], 0
	xor	r14d, r14d
	jmp	.L8
.L28:
	test	r12d, r12d
	jle	.L32
	mov	eax, DWORD PTR 152[rsp]
	test	eax, eax
	jg	.L27
	jmp	.L32
.L96:
	mov	rax, QWORD PTR 128[rsp]
	mov	QWORD PTR 216[rsp], rax
	jmp	.L9
.L102:
	xor	eax, eax
.L37:
	lea	rdx, 8[rax]
	cmp	r12d, edx
	jle	.L36
	add	rax, 16
	cmp	r12d, eax
	jg	.L37
	jmp	.L36
.L186:
	jmp	.L187
.L184:
	jmp	.L185
.L188:
	jmp	.L189
.L116:
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
	.uleb128 .L184-.LFB11708
	.uleb128 0
	.uleb128 .LEHB1-.LFB11708
	.uleb128 .LEHE1-.LEHB1
	.uleb128 .L116-.LFB11708
	.uleb128 0
	.uleb128 .LEHB2-.LFB11708
	.uleb128 .LEHE2-.LEHB2
	.uleb128 .L186-.LFB11708
	.uleb128 0
	.uleb128 .LEHB3-.LFB11708
	.uleb128 .LEHE3-.LEHB3
	.uleb128 .L188-.LFB11708
	.uleb128 0
	.uleb128 .LEHB4-.LFB11708
	.uleb128 .LEHE4-.LEHB4
	.uleb128 .L184-.LFB11708
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
.L193:
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
.L114:
.L187:
	cmp	QWORD PTR 88[rsp], 0
	mov	rbx, rax
	jne	.L209
	vzeroupper
.L16:
	cmp	QWORD PTR 128[rsp], 0
	je	.L91
	mov	rdi, QWORD PTR 128[rsp]
	mov	rsi, r14
	sub	rsi, rdi
	call	"_ZdlPvm"@PLT
	jmp	.L91
.L190:
	lea	rdi, .LC0[rip]
.LEHB6:
	call	"_ZSt20__throw_length_errorPKc"@PLT
.LEHE6:
.L112:
.L185:
	mov	rbx, rax
	vzeroupper
.L91:
	mov	rdi, QWORD PTR 16[r15]
	test	rdi, rdi
	je	.L92
	mov	rsi, QWORD PTR 32[r15]
	sub	rsi, rdi
	call	"_ZdlPvm"@PLT
.L92:
	mov	rdi, rbx
.LEHB7:
	call	"_Unwind_Resume"@PLT
.LEHE7:
.L209:
	mov	rdi, QWORD PTR 88[rsp]
	mov	rsi, r13
	vzeroupper
	call	"_ZdlPvm"@PLT
	jmp	.L16
.L191:
	lea	rdi, .LC2[rip]
.LEHB8:
	call	"_ZSt20__throw_length_errorPKc"@PLT
.LEHE8:
.L115:
.L189:
	mov	rbx, rax
	vzeroupper
	jmp	.L16
.L192:
	lea	rdi, .LC0[rip]
.LEHB9:
	call	"_ZSt20__throw_length_errorPKc"@PLT
.LEHE9:
.L113:
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
	.uleb128 .L114-.LCOLDB8
	.uleb128 0
	.uleb128 .LEHB6-.LCOLDB8
	.uleb128 .LEHE6-.LEHB6
	.uleb128 .L112-.LCOLDB8
	.uleb128 0
	.uleb128 .LEHB7-.LCOLDB8
	.uleb128 .LEHE7-.LEHB7
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB8-.LCOLDB8
	.uleb128 .LEHE8-.LEHB8
	.uleb128 .L115-.LCOLDB8
	.uleb128 0
	.uleb128 .LEHB9-.LCOLDB8
	.uleb128 .LEHE9-.LEHB9
	.uleb128 .L113-.LCOLDB8
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
