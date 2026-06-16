
asm/opt7_5_abl_compiler_vec.o:     file format elf64-x86-64


Disassembly of section .text:

0000000000000000 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)>:
    int x_begin, x_end, y_begin, y_end;
    const unsigned char* data;
};
}

ImageData refocus_shift_and_sum(std::vector<SubApertureImage>& subapertures, float focus) {
   0:	push   r15
   2:	vmovaps xmm4,xmm0
	pointer _M_finish;
	pointer _M_end_of_storage;

	_GLIBCXX20_CONSTEXPR
	_Vector_impl_data() _GLIBCXX_NOEXCEPT
	: _M_start(), _M_finish(), _M_end_of_storage()
   6:	vpxor  xmm1,xmm1,xmm1
   a:	push   r14
   c:	push   r13
   e:	push   r12
  10:	push   rbp
  11:	mov    rbp,rsi
  14:	push   rbx
  15:	mov    rbx,rdi
  18:	sub    rsp,0xa8
      : _M_current() { }

      __attribute__((__always_inline__))
      explicit _GLIBCXX_CONSTEXPR
      __normal_iterator(const _Iterator& __i) _GLIBCXX_NOEXCEPT
      : _M_current(__i) { }
  1f:	mov    rcx,QWORD PTR [rsi]
    const size_t width = subapertures.front().data.width;
  22:	vmovdqu xmm0,XMMWORD PTR [rcx]
  26:	mov    QWORD PTR [rdi+0x20],0x0
  2e:	vmovdqu XMMWORD PTR [rdi+0x10],xmm1
  33:	vmovq  rax,xmm0
  38:	vpextrq rsi,xmm0,0x1
    const size_t height = subapertures.front().data.height;
    const int w = static_cast<int>(width);
    const int h = static_cast<int>(height);

    ImageData output;
    output.width = width;
  3e:	vmovdqu XMMWORD PTR [rdi],xmm0
    output.height = height;
    output.data.assign(width * height * 3, 0);
  42:	mov    rdx,rax
  45:	mov    QWORD PTR [rsp+0x40],rsi
  4a:	imul   rdx,rsi
  4e:	vmovq  QWORD PTR [rsp+0x28],xmm0
  54:	lea    rdi,[rdx+rdx*1]
  58:	mov    QWORD PTR [rsp+0x30],rdx
  5d:	mov    QWORD PTR [rsp+0x68],rdi
  62:	add    rdi,rdx
  65:	mov    QWORD PTR [rsp+0x38],rdi
    void
    vector<_Tp, _Alloc>::
    _M_fill_assign(size_t __n, const value_type& __val)
    {
      const size_type __sz = size();
      if (__n > capacity())
  6a:	test   rdx,rdx
  6d:	jne    7ee <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x7ee>
      /**  Returns the number of elements in the %vector.  */
      _GLIBCXX_NODISCARD _GLIBCXX20_CONSTEXPR
      size_type
      size() const _GLIBCXX_NOEXCEPT
      {
	ptrdiff_t __dif = this->_M_impl._M_finish - this->_M_impl._M_start;
  73:	mov    rdx,QWORD PTR [rbp+0x8]
      if (this->capacity() < __n)
  77:	mov    rdi,rdx
  7a:	mov    QWORD PTR [rsp+0x10],rdx
  7f:	sub    rdi,rcx
  82:	mov    QWORD PTR [rsp+0x50],rdi
  87:	je     7ba <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x7ba>
	    return static_cast<_Tp*>(_GLIBCXX_OPERATOR_NEW(__n * sizeof(_Tp),
							   __al));
	  }
#endif
	else
	  return static_cast<_Tp*>(_GLIBCXX_OPERATOR_NEW(__n * sizeof(_Tp)));
  8d:	mov    r14,QWORD PTR [rsp+0x50]
  92:	mov    QWORD PTR [rsp+0x8],rcx
      allocate(size_type __n, const void* = static_cast<const void*>(0))
  97:	vmovss DWORD PTR [rsp+0x58],xmm4
	  return static_cast<_Tp*>(_GLIBCXX_OPERATOR_NEW(__n * sizeof(_Tp)));
  9d:	mov    rdi,r14
  a0:	call   a5 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0xa5>
  a5:	mov    rbp,rax
	  this->_M_impl._M_end_of_storage = this->_M_impl._M_start + __n;
  a8:	lea    rax,[rax+r14*1]
  ac:	mov    rcx,QWORD PTR [rsp+0x8]
  b1:	vmovss xmm4,DWORD PTR [rsp+0x58]
  b7:	mov    QWORD PTR [rsp+0x20],rax
    const int w = static_cast<int>(width);
  bc:	mov    r15d,DWORD PTR [rsp+0x28]
    const int h = static_cast<int>(height);
  c1:	mov    r12d,DWORD PTR [rsp+0x40]

    std::vector<SubParams> params;
    params.reserve(subapertures.size());

    for (SubApertureImage& sub : subapertures) {
  c6:	cmp    QWORD PTR [rsp+0x10],rcx
  cb:	je     ad7 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0xad7>
	: _M_start(), _M_finish(), _M_end_of_storage()
  d1:	mov    QWORD PTR [rsp+0x8],rbp
        p.A = (1.0f - dx) * (1.0f - dy);
        p.B = dx           * (1.0f - dy);
        p.C = (1.0f - dx) * dy;
        p.D = dx           * dy;

        p.x_begin = std::max(0, -p.sx);
  d6:	xor    r11d,r11d
  d9:	nop    DWORD PTR [rax+0x0]
        const float shift_x = focus * sub.u;
  e0:	vmulss xmm3,xmm4,DWORD PTR [rcx+0x28]
        p.x_end   = std::min(w, w - p.sx - 1);
  e5:	mov    r13d,r15d
        p.y_begin = std::max(0, -p.sy);
        p.y_end   = std::min(h, h - p.sy - 1);
  e8:	mov    r14d,r12d
        const float shift_y = focus * sub.v;
  eb:	vmulss xmm2,xmm4,DWORD PTR [rcx+0x2c]
  using ::floor;

#ifndef __CORRECT_ISO_CPP_MATH_H_PROTO
  inline _GLIBCXX_CONSTEXPR float
  floor(float __x)
  { return __builtin_floorf(__x); }
  f0:	vrndscaless xmm0,xmm3,xmm3,0x9
        p.sx = static_cast<int>(std::floor(shift_x));
  f7:	vcvttss2si r9d,xmm0
  fb:	vrndscaless xmm1,xmm2,xmm2,0x9
        p.sy = static_cast<int>(std::floor(shift_y));
 102:	vcvttss2si r8d,xmm1
        p.x_begin = std::max(0, -p.sx);
 106:	mov    esi,r9d
 109:	neg    esi
 10b:	test   r9d,r9d
        p.y_begin = std::max(0, -p.sy);
 10e:	mov    r10d,r8d
        p.x_begin = std::max(0, -p.sx);
 111:	cmovns esi,r11d
        p.x_end   = std::min(w, w - p.sx - 1);
 115:	sub    r13d,r9d
 118:	dec    r13d
    min(const _Tp& __a, const _Tp& __b)
    {
      // concept requirements
      __glibcxx_function_requires(_LessThanComparableConcept<_Tp>)
      //return __b < __a ? __b : __a;
      if (__b < __a)
 11b:	cmp    r13d,r15d
 11e:	cmovg  r13d,r15d
        p.y_begin = std::max(0, -p.sy);
 122:	neg    r10d
 125:	test   r8d,r8d
 128:	cmovns r10d,r11d
        p.y_end   = std::min(h, h - p.sy - 1);
 12c:	sub    r14d,r8d
 12f:	dec    r14d
 132:	cmp    r14d,r12d
 135:	cmovg  r14d,r12d
        p.data    = sub.data.data.data();

        if (p.x_begin >= p.x_end || p.y_begin >= p.y_end) continue;
 139:	cmp    esi,r13d
 13c:	jge    1b7 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x1b7>
 13e:	cmp    r10d,r14d
 141:	jge    1b7 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x1b7>
        const float dy = shift_y - p.sy;
 143:	vsubss xmm6,xmm2,xmm1
        const float dx = shift_x - p.sx;
 147:	vsubss xmm5,xmm3,xmm0
       *   range.  For a non-empty %vector, data() == &front().
       */
      _GLIBCXX_NODISCARD _GLIBCXX20_CONSTEXPR
      _Tp*
      data() _GLIBCXX_NOEXCEPT
      { return _M_data_ptr(this->_M_impl._M_start); }
 14b:	mov    rax,QWORD PTR [rcx+0x10]
        p.A = (1.0f - dx) * (1.0f - dy);
 14f:	vaddss xmm0,xmm0,DWORD PTR [rip+0x0]        # 157 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x157>
 157:	vaddss xmm1,xmm1,DWORD PTR [rip+0x0]        # 15f <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x15f>
 15f:	mov    QWORD PTR [rsp+0x50],rax
 164:	vsubss xmm0,xmm0,xmm3
 168:	vsubss xmm1,xmm1,xmm2
 16c:	vmulss xmm2,xmm0,xmm1
        p.B = dx           * (1.0f - dy);
 170:	vmulss xmm1,xmm1,xmm5
        p.C = (1.0f - dx) * dy;
 174:	vmulss xmm0,xmm0,xmm6
        p.D = dx           * dy;
 178:	vmulss xmm5,xmm5,xmm6
       */
      _GLIBCXX20_CONSTEXPR
      void
      push_back(const value_type& __x)
      {
	if (this->_M_impl._M_finish != this->_M_impl._M_end_of_storage)
 17c:	cmp    QWORD PTR [rsp+0x20],rbp
 181:	je     8d8 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x8d8>
      template<typename _Up, typename... _Args>
	__attribute__((__always_inline__))
	void
	construct(_Up* __p, _Args&&... __args)
	noexcept(__is_nothrow_new_constructible<_Up, _Args...>)
	{ ::new((void *)__p) _Up(std::forward<_Args>(__args)...); }
 187:	vunpcklps xmm0,xmm0,xmm5
 18b:	vunpcklps xmm2,xmm2,xmm1
 18f:	mov    DWORD PTR [rbp+0x0],r9d
	  {
	    _GLIBCXX_ASAN_ANNOTATE_GROW(1);
	    _Alloc_traits::construct(this->_M_impl, this->_M_impl._M_finish,
				     __x);
	    ++this->_M_impl._M_finish;
 193:	add    rbp,0x30
 197:	mov    DWORD PTR [rbp-0x2c],r8d
 19b:	vmovlhps xmm2,xmm2,xmm0
 19f:	mov    DWORD PTR [rbp-0x18],esi
 1a2:	mov    DWORD PTR [rbp-0x14],r13d
 1a6:	mov    DWORD PTR [rbp-0x10],r10d
 1aa:	mov    DWORD PTR [rbp-0xc],r14d
 1ae:	mov    QWORD PTR [rbp-0x8],rax
 1b2:	vmovups XMMWORD PTR [rbp-0x28],xmm2
      __attribute__((__always_inline__))
      _GLIBCXX14_CONSTEXPR
      __normal_iterator&
      operator++() _GLIBCXX_NOEXCEPT
      {
	++_M_current;
 1b7:	add    rcx,0x30
    for (SubApertureImage& sub : subapertures) {
 1bb:	cmp    rcx,QWORD PTR [rsp+0x10]
 1c0:	jne    e0 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0xe0>
	ptrdiff_t __n = _M_impl._M_end_of_storage - _M_impl._M_start;
 1c6:	mov    rax,QWORD PTR [rsp+0x20]
 1cb:	sub    rax,QWORD PTR [rsp+0x8]
 1d0:	mov    QWORD PTR [rsp+0x50],rax

      // Called by constructors to check initial size.
      static _GLIBCXX20_CONSTEXPR size_type
      _S_check_init_len(size_type __n, const allocator_type& __a)
      {
	if (__n > _S_max_size(_Tp_alloc_type(__a)))
 1d5:	mov    rax,QWORD PTR [rsp+0x30]
 1da:	shr    rax,0x3d
 1de:	jne    1e4 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x1e4>
	return __n != 0 ? _Tr::allocate(_M_impl, __n) : pointer();
 1e4:	mov    rax,QWORD PTR [rsp+0x30]
 1e9:	test   rax,rax
 1ec:	je     7dd <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x7dd>
	  return static_cast<_Tp*>(_GLIBCXX_OPERATOR_NEW(__n * sizeof(_Tp)));
 1f2:	lea    r14,[rax*4+0x0]
 1fa:	mov    rdi,r14
 1fd:	mov    QWORD PTR [rsp+0x58],r14
 202:	call   207 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x207>
	  // Allow std::_Construct to be used in constant expressions.
	  std::construct_at(__p, std::forward<_Args>(__args)...);
	  return;
	}
#endif
      ::new(static_cast<void*>(__p)) _Tp(std::forward<_Args>(__args)...);
 207:	mov    rdx,r14
 20a:	xor    esi,esi
 20c:	mov    rdi,rax
 20f:	mov    r13,rax
 212:	call   217 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x217>
        params.push_back(p);
    }

    std::vector<int> counts(width * height, 0);
    {
        std::vector<int> diff((width + 1) * (height + 1), 0);
 217:	mov    rax,QWORD PTR [rsp+0x28]
 21c:	lea    r14,[rax+0x1]
 220:	mov    rax,QWORD PTR [rsp+0x40]
 225:	inc    rax
 228:	imul   rax,r14
 22c:	mov    r10,rax
	if (__n > _S_max_size(_Tp_alloc_type(__a)))
 22f:	movabs rax,0x1fffffffffffffff
 239:	cmp    rax,r10
 23c:	jb     242 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x242>
      _M_allocate(size_t __n)
 242:	vxorps xmm0,xmm0,xmm0
	return __n != 0 ? _Tr::allocate(_M_impl, __n) : pointer();
 246:	test   r10,r10
 249:	je     878 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x878>
 24f:	shl    r10,0x2
 253:	vmovaps XMMWORD PTR [rsp+0x40],xmm0
 259:	mov    rdi,r10
 25c:	mov    QWORD PTR [rsp+0x10],r10
 261:	call   266 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x266>
 266:	mov    rdx,QWORD PTR [rsp+0x10]
 26b:	mov    rdi,rax
 26e:	xor    esi,esi
 270:	call   275 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x275>
        for (const SubParams& p : params) {
 275:	cmp    QWORD PTR [rsp+0x8],rbp
 27a:	mov    r10,QWORD PTR [rsp+0x10]
 27f:	vmovaps xmm0,XMMWORD PTR [rsp+0x40]
 285:	mov    rdi,rax
 288:	je     ac0 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0xac0>
 28e:	mov    rax,QWORD PTR [rsp+0x8]
 293:	data16 cs nop WORD PTR [rax+rax*1+0x0]
 29e:	data16 cs nop WORD PTR [rax+rax*1+0x0]
 2a9:	data16 cs nop WORD PTR [rax+rax*1+0x0]
 2b4:	data16 cs nop WORD PTR [rax+rax*1+0x0]
 2bf:	nop
            diff[p.y_begin * (width + 1) + p.x_begin] += 1;
 2c0:	movsxd rdx,DWORD PTR [rax+0x20]
 2c4:	movsxd rsi,DWORD PTR [rax+0x18]
 2c8:	add    rax,0x30
            diff[p.y_begin * (width + 1) + p.x_end  ] -= 1;
            diff[p.y_end   * (width + 1) + p.x_begin] -= 1;
 2cc:	movsxd r8,DWORD PTR [rax-0xc]
            diff[p.y_begin * (width + 1) + p.x_begin] += 1;
 2d0:	imul   rdx,r14
            diff[p.y_end   * (width + 1) + p.x_begin] -= 1;
 2d4:	imul   r8,r14
            diff[p.y_begin * (width + 1) + p.x_begin] += 1;
 2d8:	lea    rcx,[rdx+rsi*1]
 2dc:	inc    DWORD PTR [rdi+rcx*4]
            diff[p.y_begin * (width + 1) + p.x_end  ] -= 1;
 2df:	movsxd rcx,DWORD PTR [rax-0x14]
 2e3:	add    rdx,rcx
 2e6:	dec    DWORD PTR [rdi+rdx*4]
            diff[p.y_end   * (width + 1) + p.x_begin] -= 1;
 2e9:	lea    rdx,[rsi+r8*1]
 2ed:	dec    DWORD PTR [rdi+rdx*4]
            diff[p.y_end   * (width + 1) + p.x_end  ] += 1;
 2f0:	lea    rdx,[rcx+r8*1]
 2f4:	inc    DWORD PTR [rdi+rdx*4]
        for (const SubParams& p : params) {
 2f7:	cmp    rax,rbp
 2fa:	jne    2c0 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x2c0>
        }
        for (int y = 0; y < h; ++y) {
 2fc:	test   r12d,r12d
 2ff:	jle    3ac <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x3ac>
 305:	test   r15d,r15d
 308:	jle    3ac <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x3ac>
            int row = 0;
            for (int x = 0; x < w; ++x) {
 30e:	mov    rax,QWORD PTR [rsp+0x28]
            int row = 0;
 313:	xor    edx,edx
 315:	lea    ecx,[rax-0x1]
        for (const SubParams& p : params) {
 318:	xor    eax,eax
 31a:	lea    r9,[rcx+0x1]
                row += diff[y * (width + 1) + x];
 31e:	add    edx,DWORD PTR [rdi+rax*4]
                counts[y * w + x] = row + (y > 0 ? counts[(y - 1) * w + x] : 0);
 321:	mov    DWORD PTR [r13+rax*4+0x0],edx
            for (int x = 0; x < w; ++x) {
 326:	inc    rax
 329:	cmp    r9,rax
 32c:	jne    31e <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x31e>
        for (int y = 0; y < h; ++y) {
 32e:	cmp    r12d,0x1
 332:	jle    3b1 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x3b1>
 334:	lea    rax,[r14*4+0x0]
 33c:	mov    DWORD PTR [rsp+0x60],r15d
            for (int x = 0; x < w; ++x) {
 341:	xor    r14d,r14d
        for (int y = 0; y < h; ++y) {
 344:	mov    r11d,0x1
 34a:	mov    QWORD PTR [rsp+0x40],rax
 34f:	lea    r8,[rdi+rax*1]
 353:	mov    eax,r15d
 356:	shl    rax,0x2
 35a:	mov    QWORD PTR [rsp+0x10],rax
 35f:	lea    rsi,[r13+rax*1+0x0]
            for (int x = 0; x < w; ++x) {
 364:	movsxd rax,r14d
            int row = 0;
 367:	xor    edx,edx
 369:	add    r14d,DWORD PTR [rsp+0x28]
 36e:	lea    r15,[r13+rax*4+0x0]
        for (int y = 0; y < h; ++y) {
 373:	xor    eax,eax
 375:	data16 cs nop WORD PTR [rax+rax*1+0x0]
                counts[y * w + x] = row + (y > 0 ? counts[(y - 1) * w + x] : 0);
 380:	mov    ecx,DWORD PTR [r15+rax*4]
                row += diff[y * (width + 1) + x];
 384:	add    edx,DWORD PTR [r8+rax*4]
                counts[y * w + x] = row + (y > 0 ? counts[(y - 1) * w + x] : 0);
 388:	add    ecx,edx
 38a:	mov    DWORD PTR [rsi+rax*4],ecx
            for (int x = 0; x < w; ++x) {
 38d:	inc    rax
 390:	cmp    r9,rax
 393:	jne    380 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x380>
        for (int y = 0; y < h; ++y) {
 395:	inc    r11d
 398:	add    r8,QWORD PTR [rsp+0x40]
 39d:	add    rsi,QWORD PTR [rsp+0x10]
 3a2:	cmp    r12d,r11d
 3a5:	jg     364 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x364>
 3a7:	mov    r15d,DWORD PTR [rsp+0x60]
	if (__p)
 3ac:	test   rdi,rdi
 3af:	je     3c5 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x3c5>
	_GLIBCXX_OPERATOR_DELETE(_GLIBCXX_SIZED_DEALLOC(__p, __n));
 3b1:	mov    rsi,r10
 3b4:	vmovaps XMMWORD PTR [rsp+0x10],xmm0
 3ba:	call   3bf <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x3bf>
 3bf:	vmovaps xmm0,XMMWORD PTR [rsp+0x10]
	if (__n > _S_max_size(_Tp_alloc_type(__a)))
 3c5:	mov    rax,QWORD PTR [rsp+0x38]
 3ca:	shr    rax,0x3d
 3ce:	jne    3d4 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x3d4>
	return __n != 0 ? _Tr::allocate(_M_impl, __n) : pointer();
 3d4:	cmp    QWORD PTR [rsp+0x30],0x0
 3da:	je     85c <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x85c>
	  return static_cast<_Tp*>(_GLIBCXX_OPERATOR_NEW(__n * sizeof(_Tp)));
 3e0:	mov    r14,QWORD PTR [rsp+0x68]
 3e5:	vmovaps XMMWORD PTR [rsp+0x10],xmm0
 3eb:	add    r14,QWORD PTR [rsp+0x30]
 3f0:	lea    rdi,[r14*4+0x0]
 3f8:	mov    QWORD PTR [rsp+0x30],rdi
 3fd:	call   402 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x402>
 402:	xor    esi,esi
 404:	lea    rdx,[r14*4+0x0]
 40c:	mov    rdi,rax
 40f:	call   414 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x414>
        }
    }

    std::vector<float> vals(width * height * 3, 0.0f);

    for (const SubParams& p : params) {
 414:	cmp    QWORD PTR [rsp+0x8],rbp
 419:	vmovaps xmm0,XMMWORD PTR [rsp+0x10]
 41f:	mov    r10,rax
 422:	je     a9b <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0xa9b>
        for (int y = p.y_begin; y < p.y_end; ++y) {
            size_t ind_top = ((size_t)(y + p.sy) * width + (size_t)(p.x_begin + p.sx)) * 3;
            size_t ind_bot = ind_top + width * 3;
 428:	mov    rdi,QWORD PTR [rsp+0x28]
 42d:	mov    rax,QWORD PTR [rsp+0x8]
 432:	mov    DWORD PTR [rsp+0x10],r15d
 437:	mov    QWORD PTR [rsp+0x20],r13
 43c:	lea    rdx,[rdi+rdi*1]
 440:	mov    DWORD PTR [rsp+0x38],r12d
 445:	mov    QWORD PTR [rsp+0x60],rbx
 44a:	lea    rcx,[rdx+rdi*1]
 44e:	mov    QWORD PTR [rsp+0x40],rdx
 453:	lea    r14,[rcx*4+0x0]
 45b:	mov    rdx,rdi
 45e:	xchg   ax,ax
        for (int y = p.y_begin; y < p.y_end; ++y) {
 460:	mov    r11d,DWORD PTR [rax+0x20]
 464:	mov    r12d,DWORD PTR [rax+0x24]
 468:	cmp    r11d,r12d
 46b:	jge    62c <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x62c>
            size_t ind_top = ((size_t)(y + p.sy) * width + (size_t)(p.x_begin + p.sx)) * 3;
 471:	mov    r8d,DWORD PTR [rax+0x18]
            float pBLg = p.data[ind_bot + 1];
            float pBLb = p.data[ind_bot + 2];

            float* vrow = vals.data() + ((size_t)y * width + (size_t)p.x_begin) * 3;

            for (int x = p.x_begin; x < p.x_end; ++x) {
 475:	mov    ebx,DWORD PTR [rax+0x1c]
 478:	cmp    r8d,ebx
 47b:	jge    62c <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x62c>
 481:	movsxd r9,DWORD PTR [rax+0x4]
 485:	movsxd rsi,r11d
            float* vrow = vals.data() + ((size_t)y * width + (size_t)p.x_begin) * 3;
 488:	movsxd r15,r8d
            size_t ind_top = ((size_t)(y + p.sy) * width + (size_t)(p.x_begin + p.sx)) * 3;
 48b:	movsxd rdi,DWORD PTR [rax]
 48e:	sub    ebx,r8d
                const float pTRb = p.data[ir + 2];
                const float pBRr = p.data[br    ];
                const float pBRg = p.data[br + 1];
                const float pBRb = p.data[br + 2];

                vrow[0] += p.A*pTLr + p.B*pTRr + p.C*pBLr + p.D*pBRr;
 491:	vmovss xmm16,DWORD PTR [rax+0x8]
 498:	vmovss xmm15,DWORD PTR [rax+0xc]
 49d:	add    r9,rsi
 4a0:	imul   rsi,rdx
            size_t ind_top = ((size_t)(y + p.sy) * width + (size_t)(p.x_begin + p.sx)) * 3;
 4a4:	lea    r13d,[r8+rdi*1]
 4a8:	add    rdi,r15
 4ab:	imul   r9,rdx
 4af:	movsxd r13,r13d
                vrow[0] += p.A*pTLr + p.B*pTRr + p.C*pBLr + p.D*pBRr;
 4b2:	vmovss xmm14,DWORD PTR [rax+0x10]
 4b7:	vmovss xmm13,DWORD PTR [rax+0x14]
 4bc:	sub    rdi,r13
 4bf:	add    rsi,r15
 4c2:	add    rsi,rbx
 4c5:	add    r9,r13
 4c8:	lea    r13,[rdi+rdi*2]
 4cc:	lea    rsi,[rsi+rsi*2]
 4d0:	lea    r9,[r9+r9*2]
 4d4:	lea    r8,[r10+rsi*4]
 4d8:	lea    rsi,[rbx*4+0x0]
 4e0:	add    r9,QWORD PTR [rax+0x28]
 4e4:	sub    rbx,rsi
 4e7:	shl    rbx,0x2
 4eb:	nop    DWORD PTR [rax+rax*1+0x0]
            float pTLr = p.data[ind_top    ];
 4f0:	movzx  esi,BYTE PTR [r9]
 4f4:	lea    rdi,[r9+r13*1]
 4f8:	vcvtusi2ss xmm9,xmm0,esi
            float pTLg = p.data[ind_top + 1];
 4fe:	movzx  esi,BYTE PTR [r9+0x1]
 503:	vcvtusi2ss xmm8,xmm0,esi
            float pTLb = p.data[ind_top + 2];
 509:	movzx  esi,BYTE PTR [r9+0x2]
 50e:	vcvtusi2ss xmm7,xmm0,esi
            float pBLr = p.data[ind_bot    ];
 514:	movzx  esi,BYTE PTR [r9+rcx*1]
 519:	vcvtusi2ss xmm6,xmm0,esi
            float pBLg = p.data[ind_bot + 1];
 51f:	movzx  esi,BYTE PTR [r9+rcx*1+0x1]
 525:	vcvtusi2ss xmm5,xmm0,esi
            float pBLb = p.data[ind_bot + 2];
 52b:	movzx  esi,BYTE PTR [r9+rcx*1+0x2]
 531:	vcvtusi2ss xmm4,xmm0,esi
            float* vrow = vals.data() + ((size_t)y * width + (size_t)p.x_begin) * 3;
 537:	lea    rsi,[r8+rbx*1]
 53b:	nop    DWORD PTR [rax+rax*1+0x0]
                const float pTRr = p.data[ir    ];
 540:	movzx  r15d,BYTE PTR [rdi+0x3]
 545:	vmovaps xmm3,xmm9
 549:	vmovaps xmm2,xmm8
 54d:	vmovaps xmm1,xmm7
 551:	vmovaps xmm12,xmm6
 555:	vmovaps xmm17,xmm15
 55b:	vmovaps xmm11,xmm5
                vrow[1] += p.A*pTLg + p.B*pTRg + p.C*pBLg + p.D*pBRg;
                vrow[2] += p.A*pTLb + p.B*pTRb + p.C*pBLb + p.D*pBRb;

                pTLr = pTRr; pTLg = pTRg; pTLb = pTRb;
                pBLr = pBRr; pBLg = pBRg; pBLb = pBRb;
                vrow += 3;
 55f:	add    rsi,0xc
                const float pTRr = p.data[ir    ];
 563:	vcvtusi2ss xmm9,xmm0,r15d
                const float pTRg = p.data[ir + 1];
 569:	movzx  r15d,BYTE PTR [rdi+0x4]
 56e:	vmovaps xmm10,xmm4
            for (int x = p.x_begin; x < p.x_end; ++x) {
 572:	add    rdi,0x3
                const float pTRg = p.data[ir + 1];
 576:	vcvtusi2ss xmm8,xmm0,r15d
                const float pTRb = p.data[ir + 2];
 57c:	movzx  r15d,BYTE PTR [rdi+0x2]
 581:	vcvtusi2ss xmm7,xmm0,r15d
                const float pBRr = p.data[br    ];
 587:	movzx  r15d,BYTE PTR [rdi+rcx*1]
 58c:	vfmadd213ss xmm17,xmm9,DWORD PTR [rsi-0xc]
 593:	vcvtusi2ss xmm6,xmm0,r15d
                const float pBRg = p.data[br + 1];
 599:	movzx  r15d,BYTE PTR [rdi+rcx*1+0x1]
 59f:	vcvtusi2ss xmm5,xmm0,r15d
                const float pBRb = p.data[br + 2];
 5a5:	movzx  r15d,BYTE PTR [rdi+rcx*1+0x2]
                vrow[0] += p.A*pTLr + p.B*pTRr + p.C*pBLr + p.D*pBRr;
 5ab:	vmulss xmm18,xmm13,xmm6
                const float pBRb = p.data[br + 2];
 5b1:	vcvtusi2ss xmm4,xmm0,r15d
                vrow[0] += p.A*pTLr + p.B*pTRr + p.C*pBLr + p.D*pBRr;
 5b7:	vfmadd132ss xmm3,xmm18,xmm16
 5bd:	vaddss xmm3,xmm3,xmm17
 5c3:	vfmadd132ss xmm12,xmm3,xmm14
 5c8:	vmovaps xmm3,xmm15
 5cc:	vfmadd213ss xmm3,xmm8,DWORD PTR [rsi-0x8]
 5d2:	vmovss DWORD PTR [rsi-0xc],xmm12
                vrow[1] += p.A*pTLg + p.B*pTRg + p.C*pBLg + p.D*pBRg;
 5d7:	vmulss xmm12,xmm13,xmm5
 5db:	vfmadd132ss xmm2,xmm12,xmm16
 5e1:	vaddss xmm2,xmm2,xmm3
                vrow[2] += p.A*pTLb + p.B*pTRb + p.C*pBLb + p.D*pBRb;
 5e5:	vmulss xmm3,xmm13,xmm4
                vrow[1] += p.A*pTLg + p.B*pTRg + p.C*pBLg + p.D*pBRg;
 5e9:	vfmadd132ss xmm11,xmm2,xmm14
 5ee:	vmovaps xmm2,xmm15
 5f2:	vfmadd213ss xmm2,xmm7,DWORD PTR [rsi-0x4]
                vrow[2] += p.A*pTLb + p.B*pTRb + p.C*pBLb + p.D*pBRb;
 5f8:	vfmadd132ss xmm1,xmm3,xmm16
                vrow[1] += p.A*pTLg + p.B*pTRg + p.C*pBLg + p.D*pBRg;
 5fe:	vmovss DWORD PTR [rsi-0x8],xmm11
                vrow[2] += p.A*pTLb + p.B*pTRb + p.C*pBLb + p.D*pBRb;
 603:	vaddss xmm1,xmm1,xmm2
 607:	vfmadd132ss xmm10,xmm1,xmm14
 60c:	vmovss DWORD PTR [rsi-0x4],xmm10
            for (int x = p.x_begin; x < p.x_end; ++x) {
 611:	cmp    rsi,r8
 614:	jne    540 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x540>
        for (int y = p.y_begin; y < p.y_end; ++y) {
 61a:	inc    r11d
 61d:	add    r9,rcx
 620:	add    r8,r14
 623:	cmp    r11d,r12d
 626:	jne    4f0 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x4f0>
    for (const SubParams& p : params) {
 62c:	add    rax,0x30
 630:	cmp    rbp,rax
 633:	jne    460 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x460>
            }
        }
    }

    for (int y = 0; y < h; ++y) {
 639:	mov    r12d,DWORD PTR [rsp+0x38]
 63e:	mov    r15d,DWORD PTR [rsp+0x10]
 643:	mov    r13,QWORD PTR [rsp+0x20]
 648:	mov    rdx,QWORD PTR [rsp+0x40]
 64d:	mov    rbx,QWORD PTR [rsp+0x60]
 652:	test   r12d,r12d
 655:	jle    76a <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x76a>
 65b:	test   r15d,r15d
 65e:	jle    76a <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x76a>
 664:	mov    r14,QWORD PTR [rsp+0x28]
        for (int x = 0; x < w; ++x) {
            const int c = counts[y * w + x];
            if (c == 0) continue;
            float inv_c = 1.0f / (float)c;
 669:	vmovss xmm6,DWORD PTR [rip+0x0]        # 671 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x671>
 671:	mov    r11,r13
 674:	xor    edi,edi
    max(const _Tp& __a, const _Tp& __b)
    {
      // concept requirements
      __glibcxx_function_requires(_LessThanComparableConcept<_Tp>)
      //return  __a < __b ? __b : __a;
      if (__a < __b)
 676:	vmovss xmm3,DWORD PTR [rip+0x0]        # 67e <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x67e>
            const float* vp = vals.data() + ((size_t)y * width + x) * 3;
            unsigned char* outp = output.data.data() + ((size_t)y * width + x) * 3;
            outp[0] = (unsigned char)std::clamp(vp[0] * inv_c + 0.5f, 0.0f, 255.0f);
 67e:	vmovss xmm5,DWORD PTR [rip+0x0]        # 686 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x686>
    for (int y = 0; y < h; ++y) {
 686:	xor    r8d,r8d
 689:	lea    eax,[r14-0x1]
      if (__b < __a)
 68d:	vmovss xmm8,DWORD PTR [rip+0x0]        # 695 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x695>
 695:	lea    r9,[rdx+r14*1]
 699:	lea    rsi,[rax+rax*2+0x3]
 69e:	mov    eax,r15d
 6a1:	lea    rbp,[rax*4+0x0]
 6a9:	nop    DWORD PTR [rax+0x0]
 6b0:	vmovss xmm4,DWORD PTR [rip+0x0]        # 6b8 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x6b8>
            outp[1] = (unsigned char)std::clamp(vp[1] * inv_c + 0.5f, 0.0f, 255.0f);
            outp[2] = (unsigned char)std::clamp(vp[2] * inv_c + 0.5f, 0.0f, 255.0f);
 6b8:	vmovss xmm7,DWORD PTR [rip+0x0]        # 6c0 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x6c0>
 6c0:	lea    rax,[rdi+rdi*2]
    for (int y = 0; y < h; ++y) {
 6c4:	mov    rdx,r11
 6c7:	nop    WORD PTR [rax+rax*1+0x0]
            const int c = counts[y * w + x];
 6d0:	mov    ecx,DWORD PTR [rdx]
            if (c == 0) continue;
 6d2:	test   ecx,ecx
 6d4:	je     744 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x744>
            float inv_c = 1.0f / (float)c;
 6d6:	vcvtsi2ss xmm1,xmm0,ecx
            unsigned char* outp = output.data.data() + ((size_t)y * width + x) * 3;
 6da:	mov    rcx,QWORD PTR [rbx+0x10]
      if (__a < __b)
 6de:	xor    r15d,r15d
 6e1:	add    rcx,rax
            float inv_c = 1.0f / (float)c;
 6e4:	vdivss xmm1,xmm6,xmm1
            outp[0] = (unsigned char)std::clamp(vp[0] * inv_c + 0.5f, 0.0f, 255.0f);
 6e8:	vmulss xmm2,xmm1,DWORD PTR [r10+rax*4]
 6ee:	vcomiss xmm3,xmm2
 6f2:	ja     701 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x701>
 6f4:	vaddss xmm2,xmm2,xmm5
      if (__b < __a)
 6f8:	vminss xmm2,xmm2,xmm8
 6fd:	vcvttss2si r15d,xmm2
            outp[1] = (unsigned char)std::clamp(vp[1] * inv_c + 0.5f, 0.0f, 255.0f);
 701:	vmulss xmm2,xmm1,DWORD PTR [r10+rax*4+0x4]
            outp[0] = (unsigned char)std::clamp(vp[0] * inv_c + 0.5f, 0.0f, 255.0f);
 708:	mov    BYTE PTR [rcx],r15b
      if (__a < __b)
 70b:	xor    r15d,r15d
 70e:	vcomiss xmm3,xmm2
 712:	ja     720 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x720>
            outp[1] = (unsigned char)std::clamp(vp[1] * inv_c + 0.5f, 0.0f, 255.0f);
 714:	vaddss xmm2,xmm2,xmm5
      if (__b < __a)
 718:	vminss xmm2,xmm2,xmm4
 71c:	vcvttss2si r15d,xmm2
            outp[2] = (unsigned char)std::clamp(vp[2] * inv_c + 0.5f, 0.0f, 255.0f);
 720:	vmulss xmm1,xmm1,DWORD PTR [r10+rax*4+0x8]
            outp[1] = (unsigned char)std::clamp(vp[1] * inv_c + 0.5f, 0.0f, 255.0f);
 727:	mov    BYTE PTR [rcx+0x1],r15b
      if (__a < __b)
 72b:	xor    r15d,r15d
 72e:	vcomiss xmm3,xmm1
 732:	ja     740 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x740>
            outp[2] = (unsigned char)std::clamp(vp[2] * inv_c + 0.5f, 0.0f, 255.0f);
 734:	vaddss xmm1,xmm1,xmm7
      if (__b < __a)
 738:	vminss xmm1,xmm1,xmm4
 73c:	vcvttss2si r15d,xmm1
 740:	mov    BYTE PTR [rcx+0x2],r15b
        for (int x = 0; x < w; ++x) {
 744:	add    rax,0x3
 748:	add    rdx,0x4
 74c:	cmp    rsi,rax
 74f:	jne    6d0 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x6d0>
    for (int y = 0; y < h; ++y) {
 755:	inc    r8d
 758:	add    rsi,r9
 75b:	add    r11,rbp
 75e:	add    rdi,r14
 761:	cmp    r12d,r8d
 764:	jne    6b0 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x6b0>
	if (__p)
 76a:	test   r10,r10
 76d:	je     77c <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x77c>
	_GLIBCXX_OPERATOR_DELETE(_GLIBCXX_SIZED_DEALLOC(__p, __n));
 76f:	mov    rsi,QWORD PTR [rsp+0x30]
 774:	mov    rdi,r10
 777:	call   77c <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x77c>
 77c:	test   r13,r13
 77f:	je     78e <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x78e>
 781:	mov    rsi,QWORD PTR [rsp+0x58]
 786:	mov    rdi,r13
 789:	call   78e <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x78e>
 78e:	mov    rax,QWORD PTR [rsp+0x8]
 793:	test   rax,rax
 796:	je     7a5 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x7a5>
 798:	mov    rsi,QWORD PTR [rsp+0x50]
 79d:	mov    rdi,rax
 7a0:	call   7a5 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x7a5>
        }
    }

    return output;
}
 7a5:	add    rsp,0xa8
 7ac:	mov    rax,rbx
 7af:	pop    rbx
 7b0:	pop    rbp
 7b1:	pop    r12
 7b3:	pop    r13
 7b5:	pop    r14
 7b7:	pop    r15
 7b9:	ret
	: _M_start(), _M_finish(), _M_end_of_storage()
 7ba:	mov    QWORD PTR [rsp+0x20],0x0
    const int w = static_cast<int>(width);
 7c3:	mov    r15d,eax
    const int h = static_cast<int>(height);
 7c6:	mov    r12d,esi
 7c9:	xor    ebp,ebp
    for (SubApertureImage& sub : subapertures) {
 7cb:	cmp    rcx,rdx
 7ce:	jne    d1 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0xd1>
 7d4:	mov    QWORD PTR [rsp+0x8],0x0
	this->_M_impl._M_end_of_storage = this->_M_impl._M_start + __n;
 7dd:	mov    QWORD PTR [rsp+0x58],0x0
	return __n != 0 ? _Tr::allocate(_M_impl, __n) : pointer();
 7e6:	xor    r13d,r13d
 7e9:	jmp    217 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x217>
	if (__n > _S_max_size(_Tp_alloc_type(__a)))
 7ee:	cmp    QWORD PTR [rsp+0x38],0x0
 7f4:	js     7fa <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x7fa>
 7fa:	mov    QWORD PTR [rsp+0x8],rcx
      allocate(size_type __n, const void* = static_cast<const void*>(0))
 7ff:	mov    r14,rdi
 802:	vmovss DWORD PTR [rsp+0x20],xmm4
	  return static_cast<_Tp*>(_GLIBCXX_OPERATOR_NEW(__n * sizeof(_Tp)));
 808:	call   80d <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x80d>
	      if constexpr (is_pointer<_BasePtr>::value)
		{
		  void* __dest = std::__niter_base(__first);
		  if (__n > 0) [[__likely__]]
		    {
		      __builtin_memset(__dest, (unsigned char)__x, __n);
 80d:	xor    esi,esi
 80f:	mov    rdi,rax
	this->_M_impl._M_end_of_storage = this->_M_impl._M_start + __n;
 812:	lea    r12,[rax+r14*1]
 816:	mov    rdx,r14
 819:	call   81e <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x81e>
      if (this->capacity() < __n)
 81e:	mov    rcx,QWORD PTR [rsp+0x8]
 823:	vmovss xmm4,DWORD PTR [rsp+0x20]
	  _M_finish = __x._M_finish;
 829:	mov    QWORD PTR [rbx+0x18],r12
	  _M_start = __x._M_start;
 82d:	mov    QWORD PTR [rbx+0x10],rax
	ptrdiff_t __dif = this->_M_impl._M_finish - this->_M_impl._M_start;
 831:	mov    rax,QWORD PTR [rbp+0x8]
	  _M_end_of_storage = __x._M_end_of_storage;
 835:	mov    QWORD PTR [rbx+0x20],r12
	ptrdiff_t __dif = this->_M_impl._M_finish - this->_M_impl._M_start;
 839:	mov    QWORD PTR [rsp+0x10],rax
 83e:	sub    rax,rcx
 841:	mov    QWORD PTR [rsp+0x50],rax
 846:	jne    8d <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x8d>
	: _M_start(), _M_finish(), _M_end_of_storage()
 84c:	mov    QWORD PTR [rsp+0x20],0x0
 855:	xor    ebp,ebp
 857:	jmp    bc <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0xbc>
	return __n != 0 ? _Tr::allocate(_M_impl, __n) : pointer();
 85c:	xor    r10d,r10d
    for (const SubParams& p : params) {
 85f:	cmp    QWORD PTR [rsp+0x8],rbp
 864:	jne    428 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x428>
    for (int y = 0; y < h; ++y) {
 86a:	test   r12d,r12d
 86d:	jg     8ae <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x8ae>
 86f:	jmp    77c <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x77c>
 874:	nop    DWORD PTR [rax+0x0]
 878:	xor    edi,edi
        for (const SubParams& p : params) {
 87a:	cmp    QWORD PTR [rsp+0x8],rbp
 87f:	jne    28e <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x28e>
        for (int y = 0; y < h; ++y) {
 885:	test   r12d,r12d
 888:	jle    ae1 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0xae1>
 88e:	test   r15d,r15d
 891:	jg     30e <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x30e>
	if (__n > _S_max_size(_Tp_alloc_type(__a)))
 897:	cmp    rax,QWORD PTR [rsp+0x38]
 89c:	jb     8a2 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x8a2>
	return __n != 0 ? _Tr::allocate(_M_impl, __n) : pointer();
 8a2:	cmp    QWORD PTR [rsp+0x30],0x0
 8a8:	jne    3e0 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x3e0>
 8ae:	mov    rax,QWORD PTR [rsp+0x28]
	this->_M_impl._M_end_of_storage = this->_M_impl._M_start + __n;
 8b3:	mov    QWORD PTR [rsp+0x30],0x0
	return __n != 0 ? _Tr::allocate(_M_impl, __n) : pointer();
 8bc:	xor    r10d,r10d
 8bf:	lea    rdx,[rax+rax*1]
 8c3:	test   r15d,r15d
 8c6:	jg     664 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x664>
 8cc:	jmp    77c <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x77c>
 8d1:	nop    DWORD PTR [rax+0x0]
	ptrdiff_t __dif = this->_M_impl._M_finish - this->_M_impl._M_start;
 8d8:	mov    rbp,QWORD PTR [rsp+0x20]
 8dd:	movabs rax,0xaaaaaaaaaaaaaaab
 8e7:	sub    rbp,QWORD PTR [rsp+0x8]
 8ec:	mov    rdx,rbp
 8ef:	sar    rdx,0x4
 8f3:	imul   rdx,rax
	if (max_size() - size() < __n)
 8f7:	movabs rax,0x2aaaaaaaaaaaaaa
 901:	cmp    rdx,rax
 904:	je     90a <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x90a>
      if (__a < __b)
 90a:	test   rdx,rdx
 90d:	mov    eax,0x1
 912:	mov    QWORD PTR [rsp+0x90],rcx
 91a:	cmovne rax,rdx
 91e:	mov    DWORD PTR [rsp+0x98],r10d
 926:	mov    DWORD PTR [rsp+0x8c],esi
	const size_type __len = size() + (std::max)(size(), __n);
 92d:	add    rax,rdx
	return (__len < size() || __len > max_size()) ? max_size() : __len;
 930:	movabs rdx,0x2aaaaaaaaaaaaaa
 93a:	mov    DWORD PTR [rsp+0x78],r8d
 93f:	cmp    rax,rdx
 942:	mov    DWORD PTR [rsp+0x74],r9d
 947:	cmova  rax,rdx
 94b:	vmovss DWORD PTR [rsp+0x9c],xmm4
 954:	vmovss DWORD PTR [rsp+0x88],xmm5
 95d:	lea    rax,[rax+rax*2]
 961:	vmovss DWORD PTR [rsp+0x84],xmm0
 96a:	shl    rax,0x4
 96e:	vmovss DWORD PTR [rsp+0x80],xmm1
 977:	mov    rdi,rax
 97a:	mov    QWORD PTR [rsp+0x60],rax
 97f:	vmovss DWORD PTR [rsp+0x7c],xmm2
 985:	call   98a <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x98a>
	{ ::new((void *)__p) _Up(std::forward<_Args>(__args)...); }
 98a:	vmovss xmm0,DWORD PTR [rsp+0x84]
 993:	vmovss xmm2,DWORD PTR [rsp+0x7c]
    __relocate_a_1(_Tp* __first, _Tp* __last,
		   _Tp* __result,
		   [[__maybe_unused__]] allocator<_Up>& __alloc) noexcept
    {
      ptrdiff_t __count = __last - __first;
      if (__count > 0)
 999:	test   rbp,rbp
	  return static_cast<_Tp*>(_GLIBCXX_OPERATOR_NEW(__n * sizeof(_Tp)));
 99c:	mov    QWORD PTR [rsp+0x58],rax
	{ ::new((void *)__p) _Up(std::forward<_Args>(__args)...); }
 9a1:	mov    r9d,DWORD PTR [rsp+0x74]
 9a6:	mov    r8d,DWORD PTR [rsp+0x78]
 9ab:	mov    DWORD PTR [rax+rbp*1+0x1c],r13d
	  return static_cast<_Tp*>(_GLIBCXX_OPERATOR_NEW(__n * sizeof(_Tp)));
 9b0:	mov    rdi,rax
	{ ::new((void *)__p) _Up(std::forward<_Args>(__args)...); }
 9b3:	vinsertps xmm0,xmm0,DWORD PTR [rsp+0x88],0x10
 9be:	vinsertps xmm2,xmm2,DWORD PTR [rsp+0x80],0x10
 9c9:	mov    DWORD PTR [rax+rbp*1+0x24],r14d
 9ce:	mov    r11d,0x0
 9d4:	mov    esi,DWORD PTR [rsp+0x8c]
 9db:	mov    r10d,DWORD PTR [rsp+0x98]
 9e3:	mov    DWORD PTR [rax+rbp*1],r9d
 9e7:	mov    rdx,QWORD PTR [rsp+0x50]
 9ec:	vmovlhps xmm2,xmm2,xmm0
 9f0:	mov    rcx,QWORD PTR [rsp+0x90]
 9f8:	mov    DWORD PTR [rax+rbp*1+0x4],r8d
 9fd:	mov    DWORD PTR [rax+rbp*1+0x18],esi
 a01:	vmovss xmm4,DWORD PTR [rsp+0x9c]
 a0a:	mov    DWORD PTR [rax+rbp*1+0x20],r10d
 a0f:	mov    QWORD PTR [rax+rbp*1+0x28],rdx
 a14:	vmovups XMMWORD PTR [rax+rbp*1+0x8],xmm2
 a1a:	je     a42 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0xa42>
	      __gnu_cxx::__normal_iterator<_Tp*, void> __out(__result);
	      __out = std::__relocate_a_1(__first, __last, __out, __alloc);
	      return __out.base();
	    }
#endif
	  __builtin_memcpy(__result, __first, __count * sizeof(_Tp));
 a1c:	mov    rsi,QWORD PTR [rsp+0x8]
 a21:	mov    rdx,rbp
 a24:	mov    QWORD PTR [rsp+0x50],rcx
 a29:	vmovss DWORD PTR [rsp+0x74],xmm4
 a2f:	call   a34 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0xa34>
 a34:	vmovss xmm4,DWORD PTR [rsp+0x74]
 a3a:	mov    rcx,QWORD PTR [rsp+0x50]
 a3f:	xor    r11d,r11d
	  {
	    // Relocation cannot throw.
	    __new_finish = std::__relocate_a(__old_start, __old_finish,
					     __new_start,
					     _M_get_Tp_allocator());
	    ++__new_finish;
 a42:	mov    rax,QWORD PTR [rsp+0x58]
 a47:	lea    rbp,[rax+rbp*1+0x30]
	  if (_M_storage)
 a4c:	mov    rax,QWORD PTR [rsp+0x8]
 a51:	test   rax,rax
 a54:	je     a7f <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0xa7f>
	    // New storage has been fully initialized, destroy the old elements.
	    __guard_elts._M_first = __old_start;
	    __guard_elts._M_last = __old_finish;
	  }
	__guard._M_storage = __old_start;
	__guard._M_len = this->_M_impl._M_end_of_storage - __old_start;
 a56:	mov    rsi,QWORD PTR [rsp+0x20]
	_GLIBCXX_OPERATOR_DELETE(_GLIBCXX_SIZED_DEALLOC(__p, __n));
 a5b:	mov    rdi,rax
 a5e:	mov    QWORD PTR [rsp+0x8],rcx
      deallocate(_Tp* __p, size_type __n __attribute__ ((__unused__)))
 a63:	vmovss DWORD PTR [rsp+0x50],xmm4
 a69:	sub    rsi,rax
	_GLIBCXX_OPERATOR_DELETE(_GLIBCXX_SIZED_DEALLOC(__p, __n));
 a6c:	call   a71 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0xa71>
 a71:	vmovss xmm4,DWORD PTR [rsp+0x50]
 a77:	mov    rcx,QWORD PTR [rsp+0x8]
 a7c:	xor    r11d,r11d
      // deallocate should be called before assignments to _M_impl,
      // to avoid call-clobbering

      this->_M_impl._M_start = __new_start;
      this->_M_impl._M_finish = __new_finish;
      this->_M_impl._M_end_of_storage = __new_start + __len;
 a7f:	mov    rdx,QWORD PTR [rsp+0x58]
 a84:	mov    rax,QWORD PTR [rsp+0x60]
 a89:	add    rax,rdx
      this->_M_impl._M_start = __new_start;
 a8c:	mov    QWORD PTR [rsp+0x8],rdx
      this->_M_impl._M_end_of_storage = __new_start + __len;
 a91:	mov    QWORD PTR [rsp+0x20],rax
 a96:	jmp    1b7 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x1b7>
    for (int y = 0; y < h; ++y) {
 a9b:	test   r12d,r12d
 a9e:	jle    76f <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x76f>
 aa4:	mov    rax,QWORD PTR [rsp+0x28]
 aa9:	lea    rdx,[rax+rax*1]
 aad:	test   r15d,r15d
 ab0:	jg     664 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x664>
 ab6:	jmp    76f <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x76f>
 abb:	nop    DWORD PTR [rax+rax*1+0x0]
        for (int y = 0; y < h; ++y) {
 ac0:	test   r12d,r12d
 ac3:	jle    3b1 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x3b1>
 ac9:	test   r15d,r15d
 acc:	jg     30e <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x30e>
 ad2:	jmp    3b1 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x3b1>
    for (SubApertureImage& sub : subapertures) {
 ad7:	mov    QWORD PTR [rsp+0x8],rbp
 adc:	jmp    1d5 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x1d5>
	if (__n > _S_max_size(_Tp_alloc_type(__a)))
 ae1:	cmp    rax,QWORD PTR [rsp+0x38]
 ae6:	jb     aec <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0xaec>
	return __n != 0 ? _Tr::allocate(_M_impl, __n) : pointer();
 aec:	cmp    QWORD PTR [rsp+0x30],0x0
 af2:	jne    3e0 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x3e0>
 af8:	jmp    77c <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x77c>
 afd:	mov    rbp,rax
 b00:	vzeroupper
 b03:	jmp    b08 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0xb08>
 b08:	jmp    b0d <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0xb0d>
 b0d:	jmp    b12 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0xb12>
 b12:	jmp    b17 <.LC5+0xb0b>

Disassembly of section .text.unlikely:

0000000000000000 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float) [clone .cold]>:
	  __throw_length_error(
   0:	lea    rdi,[rip+0x0]        # 7 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float) [clone .cold]+0x7>
   7:	call   c <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float) [clone .cold]+0xc>
   c:	lea    rdi,[rip+0x0]        # 13 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float) [clone .cold]+0x13>
  13:	call   18 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float) [clone .cold]+0x18>
	  __throw_length_error(__N(__s));
  18:	lea    rdi,[rip+0x0]        # 1f <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float) [clone .cold]+0x1f>
  1f:	call   24 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float) [clone .cold]+0x24>
	  __throw_length_error(
  24:	lea    rdi,[rip+0x0]        # 2b <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float) [clone .cold]+0x2b>
  2b:	call   30 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float) [clone .cold]+0x30>
  30:	lea    rdi,[rip+0x0]        # 37 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float) [clone .cold]+0x37>
  37:	call   3c <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float) [clone .cold]+0x3c>
	if (__p)
  3c:	mov    rbp,rax
  3f:	vzeroupper
  42:	cmp    QWORD PTR [rsp+0x8],0x0
  48:	je     5c <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float) [clone .cold]+0x5c>
	ptrdiff_t __n = _M_impl._M_end_of_storage - _M_impl._M_start;
  4a:	mov    rsi,QWORD PTR [rsp+0x20]
  4f:	mov    rdi,QWORD PTR [rsp+0x8]
  54:	sub    rsi,rdi
  57:	call   5c <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float) [clone .cold]+0x5c>
  5c:	mov    rdi,QWORD PTR [rbx+0x10]
	if (__p)
  60:	test   rdi,rdi
  63:	je     71 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float) [clone .cold]+0x71>
	ptrdiff_t __n = _M_impl._M_end_of_storage - _M_impl._M_start;
  65:	mov    rsi,QWORD PTR [rbx+0x20]
  69:	sub    rsi,rdi
  6c:	call   71 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float) [clone .cold]+0x71>
      ~__new_allocator() _GLIBCXX_USE_NOEXCEPT { }
  71:	mov    rdi,rbp
  74:	call   79 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float) [clone .cold]+0x79>
	if (__p)
  79:	mov    rbp,rax
  7c:	test   r13,r13
  7f:	je     a3 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float) [clone .cold]+0xa3>
	_GLIBCXX_OPERATOR_DELETE(_GLIBCXX_SIZED_DEALLOC(__p, __n));
  81:	mov    rsi,QWORD PTR [rsp+0x58]
  86:	mov    rdi,r13
  89:	vzeroupper
  8c:	call   91 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float) [clone .cold]+0x91>
      ~__new_allocator() _GLIBCXX_USE_NOEXCEPT { }
  91:	jmp    42 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float) [clone .cold]+0x42>
  93:	mov    rbp,rax
  96:	vzeroupper
  99:	jmp    42 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float) [clone .cold]+0x42>
	ptrdiff_t __n = _M_impl._M_end_of_storage - _M_impl._M_start;
  9b:	mov    rbp,rax
  9e:	vzeroupper
  a1:	jmp    5c <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float) [clone .cold]+0x5c>
  a3:	vzeroupper
  a6:	jmp    42 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float) [clone .cold]+0x42>
