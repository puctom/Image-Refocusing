
asm/opt7_5_scalar.o:     file format elf64-x86-64


Disassembly of section .text:

0000000000000000 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)>:
    int x_begin, x_end, y_begin, y_end;
    const unsigned char* data;
};
}

ImageData refocus_shift_and_sum(std::vector<SubApertureImage>& subapertures, float focus) {
   0:	push   r15
   2:	vmovaps xmm4,xmm0
   6:	push   r14
   8:	push   r13
   a:	push   r12
   c:	push   rbp
   d:	mov    rbp,rsi
  10:	push   rbx
  11:	mov    rbx,rdi
  14:	sub    rsp,0x98
      : _M_current() { }

      __attribute__((__always_inline__))
      explicit _GLIBCXX_CONSTEXPR
      __normal_iterator(const _Iterator& __i) _GLIBCXX_NOEXCEPT
      : _M_current(__i) { }
  1b:	mov    r15,QWORD PTR [rsi]
    const size_t width = subapertures.front().data.width;
    const size_t height = subapertures.front().data.height;
  1e:	mov    rax,QWORD PTR [r15+0x8]
    const size_t width = subapertures.front().data.width;
  22:	mov    r12,QWORD PTR [r15]
	pointer _M_finish;
	pointer _M_end_of_storage;

	_GLIBCXX20_CONSTEXPR
	_Vector_impl_data() _GLIBCXX_NOEXCEPT
	: _M_start(), _M_finish(), _M_end_of_storage()
  25:	mov    QWORD PTR [rdi+0x10],0x0
  2d:	mov    QWORD PTR [rdi+0x18],0x0
    const int h = static_cast<int>(height);

    ImageData output;
    output.width = width;
    output.height = height;
    output.data.assign(width * height * 3, 0);
  35:	mov    rcx,rax
    const size_t height = subapertures.front().data.height;
  38:	mov    QWORD PTR [rsp+0x28],rax
    output.data.assign(width * height * 3, 0);
  3d:	imul   rcx,r12
  41:	mov    QWORD PTR [rdi+0x20],0x0
    output.width = width;
  49:	mov    QWORD PTR [rdi],r12
    output.height = height;
  4c:	mov    QWORD PTR [rdi+0x8],rax
    output.data.assign(width * height * 3, 0);
  50:	lea    rsi,[rcx+rcx*1]
  54:	mov    QWORD PTR [rsp+0x30],rcx
  59:	mov    QWORD PTR [rsp+0x58],rsi
  5e:	add    rsi,rcx
  61:	mov    QWORD PTR [rsp+0x48],rsi
    void
    vector<_Tp, _Alloc>::
    _M_fill_assign(size_t __n, const value_type& __val)
    {
      const size_type __sz = size();
      if (__n > capacity())
  66:	test   rcx,rcx
  69:	jne    8c0 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x8c0>
      /**  Returns the number of elements in the %vector.  */
      _GLIBCXX_NODISCARD _GLIBCXX20_CONSTEXPR
      size_type
      size() const _GLIBCXX_NOEXCEPT
      {
	ptrdiff_t __dif = this->_M_impl._M_finish - this->_M_impl._M_start;
  6f:	mov    rsi,QWORD PTR [rbp+0x8]
      if (this->capacity() < __n)
  73:	mov    rcx,rsi
  76:	mov    QWORD PTR [rsp+0x18],rsi
  7b:	sub    rcx,r15
  7e:	mov    QWORD PTR [rsp+0x40],rcx
  83:	je     885 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x885>
	    return static_cast<_Tp*>(_GLIBCXX_OPERATOR_NEW(__n * sizeof(_Tp),
							   __al));
	  }
#endif
	else
	  return static_cast<_Tp*>(_GLIBCXX_OPERATOR_NEW(__n * sizeof(_Tp)));
  89:	mov    r14,QWORD PTR [rsp+0x40]
  8e:	vmovss DWORD PTR [rsp+0x10],xmm4
  94:	mov    rdi,r14
  97:	call   9c <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x9c>
  9c:	mov    QWORD PTR [rsp+0x8],rax
	  this->_M_impl._M_end_of_storage = this->_M_impl._M_start + __n;
  a1:	add    rax,r14
  a4:	vmovss xmm4,DWORD PTR [rsp+0x10]
  aa:	mov    QWORD PTR [rsp+0x20],rax
    const int h = static_cast<int>(height);
  af:	mov    r14d,DWORD PTR [rsp+0x28]
    const int w = static_cast<int>(width);
  b4:	mov    ecx,r12d

    std::vector<SubParams> params;
    params.reserve(subapertures.size());

    for (SubApertureImage& sub : subapertures) {
  b7:	cmp    r15,QWORD PTR [rsp+0x18]
  bc:	je     b70 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0xb70>
	: _M_start(), _M_finish(), _M_end_of_storage()
  c2:	mov    rax,QWORD PTR [rsp+0x8]
        p.A = (1 - dx) * (1 - dy);
        p.B = dx * (1 - dy);
        p.C = (1 - dx) * dy;
        p.D = dx * dy;

        p.x_begin = std::max(0, -p.sx);
  c7:	xor    r11d,r11d
  ca:	mov    QWORD PTR [rsp+0x10],rax
  cf:	nop
        const float shift_x = focus * sub.u;
  d0:	vmulss xmm3,xmm4,DWORD PTR [r15+0x28]
        p.x_end = std::min(w, w - p.sx - 1);
  d6:	mov    ebp,ecx
        p.y_begin = std::max(0, -p.sy);
        p.y_end = std::min(h, h - p.sy - 1);
  d8:	mov    r13d,r14d
        const float shift_y = focus * sub.v;
  db:	vmulss xmm2,xmm4,DWORD PTR [r15+0x2c]
  using ::floor;

#ifndef __CORRECT_ISO_CPP_MATH_H_PROTO
  inline _GLIBCXX_CONSTEXPR float
  floor(float __x)
  { return __builtin_floorf(__x); }
  e1:	vrndscaless xmm0,xmm3,xmm3,0x9
        p.sx = std::floor(shift_x);
  e8:	vcvttss2si r9d,xmm0
  ec:	vrndscaless xmm1,xmm2,xmm2,0x9
        p.sy = std::floor(shift_y);
  f3:	vcvttss2si r8d,xmm1
        p.x_begin = std::max(0, -p.sx);
  f7:	mov    esi,r9d
  fa:	neg    esi
  fc:	test   r9d,r9d
        p.y_begin = std::max(0, -p.sy);
  ff:	mov    r10d,r8d
        p.x_begin = std::max(0, -p.sx);
 102:	cmovns esi,r11d
        p.x_end = std::min(w, w - p.sx - 1);
 106:	sub    ebp,r9d
 109:	dec    ebp
    min(const _Tp& __a, const _Tp& __b)
    {
      // concept requirements
      __glibcxx_function_requires(_LessThanComparableConcept<_Tp>)
      //return __b < __a ? __b : __a;
      if (__b < __a)
 10b:	cmp    ebp,ecx
 10d:	cmovg  ebp,ecx
        p.y_begin = std::max(0, -p.sy);
 110:	neg    r10d
 113:	test   r8d,r8d
 116:	cmovns r10d,r11d
        p.y_end = std::min(h, h - p.sy - 1);
 11a:	sub    r13d,r8d
 11d:	dec    r13d
 120:	cmp    r13d,r14d
 123:	cmovg  r13d,r14d
        p.data = sub.data.data.data();

        if (p.x_begin >= p.x_end || p.y_begin >= p.y_end) continue;
 127:	cmp    esi,ebp
 129:	jge    1b3 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x1b3>
 12f:	cmp    r10d,r13d
 132:	jge    1b3 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x1b3>
        const float dy = shift_y - p.sy;
 134:	vsubss xmm6,xmm2,xmm1
        const float dx = shift_x - p.sx;
 138:	vsubss xmm5,xmm3,xmm0
       *   range.  For a non-empty %vector, data() == &front().
       */
      _GLIBCXX_NODISCARD _GLIBCXX20_CONSTEXPR
      _Tp*
      data() _GLIBCXX_NOEXCEPT
      { return _M_data_ptr(this->_M_impl._M_start); }
 13c:	mov    rdx,QWORD PTR [r15+0x10]
       */
      _GLIBCXX20_CONSTEXPR
      void
      push_back(const value_type& __x)
      {
	if (this->_M_impl._M_finish != this->_M_impl._M_end_of_storage)
 140:	mov    rax,QWORD PTR [rsp+0x8]
        p.A = (1 - dx) * (1 - dy);
 145:	vaddss xmm0,xmm0,DWORD PTR [rip+0x0]        # 14d <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x14d>
 14d:	vaddss xmm1,xmm1,DWORD PTR [rip+0x0]        # 155 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x155>
      { return _M_data_ptr(this->_M_impl._M_start); }
 155:	mov    QWORD PTR [rsp+0x38],rdx
 15a:	vsubss xmm0,xmm0,xmm3
 15e:	vsubss xmm1,xmm1,xmm2
 162:	vmulss xmm2,xmm0,xmm1
        p.B = dx * (1 - dy);
 166:	vmulss xmm1,xmm1,xmm5
        p.C = (1 - dx) * dy;
 16a:	vmulss xmm0,xmm0,xmm6
        p.D = dx * dy;
 16e:	vmulss xmm5,xmm5,xmm6
	if (this->_M_impl._M_finish != this->_M_impl._M_end_of_storage)
 172:	cmp    QWORD PTR [rsp+0x20],rax
 177:	je     96f <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x96f>
      template<typename _Up, typename... _Args>
	__attribute__((__always_inline__))
	void
	construct(_Up* __p, _Args&&... __args)
	noexcept(__is_nothrow_new_constructible<_Up, _Args...>)
	{ ::new((void *)__p) _Up(std::forward<_Args>(__args)...); }
 17d:	mov    DWORD PTR [rax],r9d
	  {
	    _GLIBCXX_ASAN_ANNOTATE_GROW(1);
	    _Alloc_traits::construct(this->_M_impl, this->_M_impl._M_finish,
				     __x);
	    ++this->_M_impl._M_finish;
 180:	add    rax,0x30
 184:	mov    DWORD PTR [rax-0x2c],r8d
 188:	vmovss DWORD PTR [rax-0x28],xmm2
 18d:	vmovss DWORD PTR [rax-0x24],xmm1
 192:	vmovss DWORD PTR [rax-0x20],xmm0
 197:	vmovss DWORD PTR [rax-0x1c],xmm5
 19c:	mov    DWORD PTR [rax-0x18],esi
 19f:	mov    DWORD PTR [rax-0x14],ebp
 1a2:	mov    DWORD PTR [rax-0x10],r10d
 1a6:	mov    DWORD PTR [rax-0xc],r13d
 1aa:	mov    QWORD PTR [rax-0x8],rdx
 1ae:	mov    QWORD PTR [rsp+0x8],rax
      __attribute__((__always_inline__))
      _GLIBCXX14_CONSTEXPR
      __normal_iterator&
      operator++() _GLIBCXX_NOEXCEPT
      {
	++_M_current;
 1b3:	add    r15,0x30
    for (SubApertureImage& sub : subapertures) {
 1b7:	cmp    r15,QWORD PTR [rsp+0x18]
 1bc:	jne    d0 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0xd0>
	ptrdiff_t __n = _M_impl._M_end_of_storage - _M_impl._M_start;
 1c2:	mov    rax,QWORD PTR [rsp+0x20]
 1c7:	sub    rax,QWORD PTR [rsp+0x10]
 1cc:	mov    QWORD PTR [rsp+0x40],rax

      // Called by constructors to check initial size.
      static _GLIBCXX20_CONSTEXPR size_type
      _S_check_init_len(size_type __n, const allocator_type& __a)
      {
	if (__n > _S_max_size(_Tp_alloc_type(__a)))
 1d1:	mov    rax,QWORD PTR [rsp+0x30]
 1d6:	shr    rax,0x3d
 1da:	jne    1e0 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x1e0>
	return __n != 0 ? _Tr::allocate(_M_impl, __n) : pointer();
 1e0:	mov    rax,QWORD PTR [rsp+0x30]
 1e5:	test   rax,rax
 1e8:	je     8af <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x8af>
	  return static_cast<_Tp*>(_GLIBCXX_OPERATOR_NEW(__n * sizeof(_Tp)));
 1ee:	lea    rbp,[rax*4+0x0]
 1f6:	mov    DWORD PTR [rsp+0x18],ecx
 1fa:	mov    rdi,rbp
 1fd:	mov    QWORD PTR [rsp+0x50],rbp
 202:	call   207 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x207>
	  // Allow std::_Construct to be used in constant expressions.
	  std::construct_at(__p, std::forward<_Args>(__args)...);
	  return;
	}
#endif
      ::new(static_cast<void*>(__p)) _Tp(std::forward<_Args>(__args)...);
 207:	mov    rdx,rbp
 20a:	xor    esi,esi
 20c:	mov    rdi,rax
 20f:	mov    r15,rax
 212:	call   217 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x217>
 217:	mov    ecx,DWORD PTR [rsp+0x18]
        params.push_back(p);
    }

    std::vector<int> counts(width * height, 0);
    std::vector<int> diff((width + 1) * (height + 1), 0);
 21b:	mov    rax,QWORD PTR [rsp+0x28]
 220:	lea    r13,[r12+0x1]
 225:	inc    rax
 228:	imul   rax,r13
 22c:	mov    QWORD PTR [rsp+0x38],rax
	if (__n > _S_max_size(_Tp_alloc_type(__a)))
 231:	shr    rax,0x3d
 235:	jne    23b <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x23b>
	return __n != 0 ? _Tr::allocate(_M_impl, __n) : pointer();
 23b:	mov    rax,QWORD PTR [rsp+0x38]
 240:	test   rax,rax
 243:	je     968 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x968>
 249:	shl    rax,0x2
 24d:	mov    DWORD PTR [rsp+0x18],ecx
 251:	mov    rdi,rax
 254:	mov    QWORD PTR [rsp+0x38],rax
 259:	call   25e <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x25e>
 25e:	mov    rdx,QWORD PTR [rsp+0x38]
 263:	xor    esi,esi
 265:	mov    rdi,rax
 268:	mov    rbp,rax
 26b:	call   270 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x270>
 270:	mov    ecx,DWORD PTR [rsp+0x18]
	if (__n > _S_max_size(_Tp_alloc_type(__a)))
 274:	mov    rax,QWORD PTR [rsp+0x48]
 279:	shr    rax,0x3d
 27d:	jne    283 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x283>
	return __n != 0 ? _Tr::allocate(_M_impl, __n) : pointer();
 283:	cmp    QWORD PTR [rsp+0x30],0x0
 289:	vxorps xmm0,xmm0,xmm0
 28d:	je     92e <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x92e>
 293:	mov    rdx,QWORD PTR [rsp+0x58]
 298:	mov    DWORD PTR [rsp+0x60],ecx
 29c:	add    rdx,QWORD PTR [rsp+0x30]
 2a1:	shl    rdx,0x2
 2a5:	mov    rdi,rdx
 2a8:	mov    QWORD PTR [rsp+0x48],rdx
 2ad:	mov    QWORD PTR [rsp+0x30],rdx
 2b2:	call   2b7 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x2b7>
      // otherwise we just use another reference.
      typedef typename __gnu_cxx::__conditional_type<__load_outside_loop,
						     const _Tp,
						     const _Tp&>::__type _Up;
      _Up __val(__value);
      for (; __first != __last; ++__first)
 2b7:	mov    rdx,QWORD PTR [rsp+0x48]
 2bc:	mov    ecx,DWORD PTR [rsp+0x60]
 2c0:	mov    QWORD PTR [rsp+0x18],rax
 2c5:	vxorps xmm0,xmm0,xmm0
 2c9:	mov    DWORD PTR [rax],0x0
 2cf:	cmp    rdx,0x4
 2d3:	je     b49 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0xb49>
	*__first = __val;
 2d9:	sub    rdx,0x4
 2dd:	xor    esi,esi
	  if (__n > 0)
	    {
	      typename iterator_traits<_ForwardIterator>::value_type* __val
		= std::addressof(*__first);
	      std::_Construct(__val);
	      ++__first;
 2df:	lea    rdi,[rax+0x4]
 2e3:	mov    DWORD PTR [rsp+0x48],ecx
 2e7:	call   2ec <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x2ec>
    std::vector<float> vals(width * height * 3);

    for (const SubParams& p : params) {
 2ec:	mov    rcx,QWORD PTR [rsp+0x10]
 2f1:	vxorps xmm0,xmm0,xmm0
 2f5:	cmp    QWORD PTR [rsp+0x8],rcx
 2fa:	mov    ecx,DWORD PTR [rsp+0x48]
 2fe:	je     b59 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0xb59>
 304:	mov    rax,QWORD PTR [rsp+0x10]
 309:	mov    rdi,QWORD PTR [rsp+0x8]
 30e:	data16 cs nop WORD PTR [rax+rax*1+0x0]
 319:	data16 cs nop WORD PTR [rax+rax*1+0x0]
 324:	data16 cs nop WORD PTR [rax+rax*1+0x0]
 32f:	data16 cs nop WORD PTR [rax+rax*1+0x0]
 33a:	nop    WORD PTR [rax+rax*1+0x0]
        diff[static_cast<size_t>(p.y_begin) * (width + 1) + p.x_begin] += 1;
 340:	movsxd rdx,DWORD PTR [rax+0x20]
 344:	movsxd r8,DWORD PTR [rax+0x18]
 348:	add    rax,0x30
        diff[static_cast<size_t>(p.y_begin) * (width + 1) + p.x_end] -= 1;
        diff[static_cast<size_t>(p.y_end) * (width + 1) + p.x_begin] -= 1;
 34c:	movsxd r9,DWORD PTR [rax-0xc]
        diff[static_cast<size_t>(p.y_begin) * (width + 1) + p.x_begin] += 1;
 350:	imul   rdx,r13
        diff[static_cast<size_t>(p.y_end) * (width + 1) + p.x_begin] -= 1;
 354:	imul   r9,r13
        diff[static_cast<size_t>(p.y_begin) * (width + 1) + p.x_begin] += 1;
 358:	lea    rsi,[rdx+r8*1]
 35c:	inc    DWORD PTR [rbp+rsi*4+0x0]
        diff[static_cast<size_t>(p.y_begin) * (width + 1) + p.x_end] -= 1;
 360:	movsxd rsi,DWORD PTR [rax-0x14]
 364:	add    rdx,rsi
 367:	dec    DWORD PTR [rbp+rdx*4+0x0]
        diff[static_cast<size_t>(p.y_end) * (width + 1) + p.x_begin] -= 1;
 36b:	lea    rdx,[r8+r9*1]
 36f:	dec    DWORD PTR [rbp+rdx*4+0x0]
        diff[static_cast<size_t>(p.y_end) * (width + 1) + p.x_end] += 1;
 373:	lea    rdx,[rsi+r9*1]
 377:	inc    DWORD PTR [rbp+rdx*4+0x0]
    for (const SubParams& p : params) {
 37b:	cmp    rax,rdi
 37e:	jne    340 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x340>
    }

    for (int y = 0; y < h; ++y) {
 380:	test   r14d,r14d
 383:	jle    b34 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0xb34>
 389:	test   ecx,ecx
 38b:	jle    425 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x425>
        int row = 0;
        for (int x = 0; x < w; ++x) {
 391:	lea    ecx,[r12-0x1]
    for (const SubParams& p : params) {
 396:	xor    eax,eax
        int row = 0;
 398:	xor    edx,edx
 39a:	lea    rdi,[rcx+0x1]
            row += diff[static_cast<size_t>(y) * (width + 1) + x];
 39e:	add    edx,DWORD PTR [rbp+rax*4+0x0]
            counts[static_cast<size_t>(y) * width + x] =
 3a2:	mov    DWORD PTR [r15+rax*4],edx
        for (int x = 0; x < w; ++x) {
 3a6:	inc    rax
 3a9:	cmp    rdi,rax
 3ac:	jne    39e <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x39e>
    for (int y = 0; y < h; ++y) {
 3ae:	cmp    r14d,0x1
 3b2:	jle    b7f <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0xb7f>
 3b8:	lea    rax,[r13*4+0x0]
        for (int x = 0; x < w; ++x) {
 3c0:	mov    r11,r12
    for (int y = 0; y < h; ++y) {
 3c3:	mov    r10d,0x1
 3c9:	mov    QWORD PTR [rsp+0x48],rax
 3ce:	lea    rsi,[rbp+rax*1+0x0]
                row + (y > 0 ? counts[static_cast<size_t>(y - 1) * width + x] : 0);
 3d3:	lea    eax,[r10-0x1]
 3d7:	lea    r8,[r15+r11*4]
        int row = 0;
 3db:	xor    edx,edx
 3dd:	imul   rax,r12
 3e1:	lea    r9,[r15+rax*4]
                row + (y > 0 ? counts[static_cast<size_t>(y - 1) * width + x] : 0);
 3e5:	xor    eax,eax
 3e7:	data16 cs nop WORD PTR [rax+rax*1+0x0]
 3f2:	data16 cs nop WORD PTR [rax+rax*1+0x0]
 3fd:	nop    DWORD PTR [rax]
 400:	mov    ecx,DWORD PTR [r9+rax*4]
            row += diff[static_cast<size_t>(y) * (width + 1) + x];
 404:	add    edx,DWORD PTR [rsi+rax*4]
                row + (y > 0 ? counts[static_cast<size_t>(y - 1) * width + x] : 0);
 407:	add    ecx,edx
            counts[static_cast<size_t>(y) * width + x] =
 409:	mov    DWORD PTR [r8+rax*4],ecx
        for (int x = 0; x < w; ++x) {
 40d:	inc    rax
 410:	cmp    rdi,rax
 413:	jne    400 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x400>
    for (int y = 0; y < h; ++y) {
 415:	inc    r10d
 418:	add    rsi,QWORD PTR [rsp+0x48]
 41d:	add    r11,r12
 420:	cmp    r10d,r14d
 423:	jl     3d3 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x3d3>
        }
    }

    for (const SubParams& p : params) {
 425:	mov    rcx,QWORD PTR [rsp+0x10]
 42a:	cmp    QWORD PTR [rsp+0x8],rcx
 42f:	je     663 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x663>
 435:	mov    QWORD PTR [rsp+0x48],r15
        for (int y = p.y_begin; y < p.y_end; ++y) {
            // Prime the "left column" with x = x_begin.
            size_t ind_top = ((y + p.sy) * width + (p.x_begin + p.sx)) * 3;
            size_t ind_bot = ind_top + width * 3;
 43a:	lea    rcx,[r12+r12*2]
 43e:	mov    rax,QWORD PTR [rsp+0x10]
 443:	mov    QWORD PTR [rsp+0x58],rbp
 448:	lea    r14,[rcx*4+0x0]
 450:	mov    QWORD PTR [rsp+0x60],r13
 455:	mov    r13,QWORD PTR [rsp+0x18]
 45a:	mov    QWORD PTR [rsp+0x68],rbx
 45f:	mov    rbx,QWORD PTR [rsp+0x8]
 464:	nop    DWORD PTR [rax+0x0]
        for (int y = p.y_begin; y < p.y_end; ++y) {
 468:	mov    r10d,DWORD PTR [rax+0x20]
 46c:	mov    r15d,DWORD PTR [rax+0x24]
 470:	cmp    r10d,r15d
 473:	jge    636 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x636>
            size_t ind_top = ((y + p.sy) * width + (p.x_begin + p.sx)) * 3;
 479:	mov    r8d,DWORD PTR [rax+0x18]
            float pBLb = p.data[ind_bot + 2];

            float* vals_row = vals.data()
                + (static_cast<size_t>(y) * width + static_cast<size_t>(p.x_begin)) * 3;

            for (int x = p.x_begin; x < p.x_end; ++x) {
 47d:	mov    r11d,DWORD PTR [rax+0x1c]
 481:	cmp    r8d,r11d
 484:	jge    636 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x636>
 48a:	movsxd r9,DWORD PTR [rax+0x4]
 48e:	movsxd rdx,r10d
                + (static_cast<size_t>(y) * width + static_cast<size_t>(p.x_begin)) * 3;
 491:	movsxd rbp,r8d
 494:	sub    r11d,r8d
            size_t ind_top = ((y + p.sy) * width + (p.x_begin + p.sx)) * 3;
 497:	movsxd rdi,DWORD PTR [rax]

                const float pBRr = p.data[ind_bot_r];
                const float pBRg = p.data[ind_bot_r + 1];
                const float pBRb = p.data[ind_bot_r + 2];

                vals_row[0] += p.A*pTLr + p.B*pTRr + p.C*pBLr + p.D*pBRr;
 49a:	vmovss xmm16,DWORD PTR [rax+0x8]
 4a1:	add    r9,rdx
 4a4:	imul   rdx,r12
 4a8:	vmovss xmm15,DWORD PTR [rax+0xc]
 4ad:	vmovss xmm14,DWORD PTR [rax+0x10]
 4b2:	imul   r9,r12
            size_t ind_top = ((y + p.sy) * width + (p.x_begin + p.sx)) * 3;
 4b6:	lea    esi,[r8+rdi*1]
 4ba:	add    rdi,rbp
                vals_row[0] += p.A*pTLr + p.B*pTRr + p.C*pBLr + p.D*pBRr;
 4bd:	vmovss xmm13,DWORD PTR [rax+0x14]
            size_t ind_top = ((y + p.sy) * width + (p.x_begin + p.sx)) * 3;
 4c2:	movsxd rsi,esi
 4c5:	add    rdx,rbp
 4c8:	lea    rbp,[rdi+rdi*2]
 4cc:	add    rdx,r11
 4cf:	add    r9,rsi
 4d2:	lea    rdx,[rdx+rdx*2]
 4d6:	lea    r9,[r9+r9*2]
 4da:	lea    r8,[r13+rdx*4+0x0]
 4df:	lea    rdx,[r11*4+0x0]
 4e7:	add    r9,QWORD PTR [rax+0x28]
 4eb:	sub    r11,rdx
 4ee:	lea    rdx,[rsi*4+0x0]
 4f6:	sub    rsi,rdx
 4f9:	shl    r11,0x2
 4fd:	add    rbp,rsi
            float pTLr = p.data[ind_top];
 500:	movzx  edx,BYTE PTR [r9]
 504:	lea    rsi,[r9+rbp*1]
 508:	vcvtusi2ss xmm9,xmm0,edx
            float pTLg = p.data[ind_top + 1];
 50e:	movzx  edx,BYTE PTR [r9+0x1]
 513:	vcvtusi2ss xmm8,xmm0,edx
            float pTLb = p.data[ind_top + 2];
 519:	movzx  edx,BYTE PTR [r9+0x2]
 51e:	vcvtusi2ss xmm7,xmm0,edx
            float pBLr = p.data[ind_bot];
 524:	movzx  edx,BYTE PTR [r9+rcx*1]
 529:	vcvtusi2ss xmm6,xmm0,edx
            float pBLg = p.data[ind_bot + 1];
 52f:	movzx  edx,BYTE PTR [r9+rcx*1+0x1]
 535:	vcvtusi2ss xmm5,xmm0,edx
            float pBLb = p.data[ind_bot + 2];
 53b:	movzx  edx,BYTE PTR [r9+rcx*1+0x2]
 541:	vcvtusi2ss xmm4,xmm0,edx
                + (static_cast<size_t>(y) * width + static_cast<size_t>(p.x_begin)) * 3;
 547:	lea    rdx,[r11+r8*1]
 54b:	nop    DWORD PTR [rax+rax*1+0x0]
                const float pTRr = p.data[ind_top_r];
 550:	movzx  edi,BYTE PTR [rsi+0x3]
 554:	vmovaps xmm3,xmm9
 558:	vmovaps xmm2,xmm8
 55c:	vmovaps xmm1,xmm7
 560:	vmovaps xmm12,xmm6
 564:	vmovaps xmm17,xmm15
 56a:	vmovaps xmm11,xmm5
                vals_row[2] += p.A*pTLb + p.B*pTRb + p.C*pBLb + p.D*pBRb;

                // Right column becomes left column for next iteration.
                pTLr = pTRr; pTLg = pTRg; pTLb = pTRb;
                pBLr = pBRr; pBLg = pBRg; pBLb = pBRb;
                vals_row += 3;
 56e:	add    rdx,0xc
                const float pTRr = p.data[ind_top_r];
 572:	vcvtusi2ss xmm9,xmm0,edi
                const float pTRg = p.data[ind_top_r + 1];
 578:	movzx  edi,BYTE PTR [rsi+0x4]
 57c:	vmovaps xmm10,xmm4
            for (int x = p.x_begin; x < p.x_end; ++x) {
 580:	add    rsi,0x3
                const float pTRg = p.data[ind_top_r + 1];
 584:	vcvtusi2ss xmm8,xmm0,edi
                const float pTRb = p.data[ind_top_r + 2];
 58a:	movzx  edi,BYTE PTR [rsi+0x2]
 58e:	vcvtusi2ss xmm7,xmm0,edi
                const float pBRr = p.data[ind_bot_r];
 594:	movzx  edi,BYTE PTR [rsi+rcx*1]
 598:	vfmadd213ss xmm17,xmm9,DWORD PTR [rdx-0xc]
 59f:	vcvtusi2ss xmm6,xmm0,edi
                const float pBRg = p.data[ind_bot_r + 1];
 5a5:	movzx  edi,BYTE PTR [rsi+rcx*1+0x1]
 5aa:	vcvtusi2ss xmm5,xmm0,edi
                const float pBRb = p.data[ind_bot_r + 2];
 5b0:	movzx  edi,BYTE PTR [rsi+rcx*1+0x2]
                vals_row[0] += p.A*pTLr + p.B*pTRr + p.C*pBLr + p.D*pBRr;
 5b5:	vmulss xmm18,xmm13,xmm6
                const float pBRb = p.data[ind_bot_r + 2];
 5bb:	vcvtusi2ss xmm4,xmm0,edi
                vals_row[0] += p.A*pTLr + p.B*pTRr + p.C*pBLr + p.D*pBRr;
 5c1:	vfmadd132ss xmm3,xmm18,xmm16
 5c7:	vaddss xmm3,xmm3,xmm17
 5cd:	vfmadd132ss xmm12,xmm3,xmm14
 5d2:	vmovaps xmm3,xmm15
 5d6:	vfmadd213ss xmm3,xmm8,DWORD PTR [rdx-0x8]
 5dc:	vmovss DWORD PTR [rdx-0xc],xmm12
                vals_row[1] += p.A*pTLg + p.B*pTRg + p.C*pBLg + p.D*pBRg;
 5e1:	vmulss xmm12,xmm13,xmm5
 5e5:	vfmadd132ss xmm2,xmm12,xmm16
 5eb:	vaddss xmm2,xmm2,xmm3
                vals_row[2] += p.A*pTLb + p.B*pTRb + p.C*pBLb + p.D*pBRb;
 5ef:	vmulss xmm3,xmm13,xmm4
                vals_row[1] += p.A*pTLg + p.B*pTRg + p.C*pBLg + p.D*pBRg;
 5f3:	vfmadd132ss xmm11,xmm2,xmm14
 5f8:	vmovaps xmm2,xmm15
 5fc:	vfmadd213ss xmm2,xmm7,DWORD PTR [rdx-0x4]
                vals_row[2] += p.A*pTLb + p.B*pTRb + p.C*pBLb + p.D*pBRb;
 602:	vfmadd132ss xmm1,xmm3,xmm16
                vals_row[1] += p.A*pTLg + p.B*pTRg + p.C*pBLg + p.D*pBRg;
 608:	vmovss DWORD PTR [rdx-0x8],xmm11
                vals_row[2] += p.A*pTLb + p.B*pTRb + p.C*pBLb + p.D*pBRb;
 60d:	vaddss xmm1,xmm1,xmm2
 611:	vfmadd132ss xmm10,xmm1,xmm14
 616:	vmovss DWORD PTR [rdx-0x4],xmm10
            for (int x = p.x_begin; x < p.x_end; ++x) {
 61b:	cmp    rdx,r8
 61e:	jne    550 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x550>
        for (int y = p.y_begin; y < p.y_end; ++y) {
 624:	inc    r10d
 627:	add    r9,rcx
 62a:	add    r8,r14
 62d:	cmp    r10d,r15d
 630:	jne    500 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x500>
    for (const SubParams& p : params) {
 636:	add    rax,0x30
 63a:	cmp    rbx,rax
 63d:	jne    468 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x468>
 643:	mov    r15,QWORD PTR [rsp+0x48]
 648:	mov    rbp,QWORD PTR [rsp+0x58]
 64d:	mov    r13,QWORD PTR [rsp+0x60]
 652:	mov    rbx,QWORD PTR [rsp+0x68]
            }
        }
    }

    for (size_t y = 0; y < height; ++y) {
 657:	cmp    QWORD PTR [rsp+0x28],0x0
 65d:	je     7f7 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x7f7>
        for (size_t x = 0; x < width; ++x) {
 663:	test   r12,r12
 666:	je     85e <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x85e>
#endif

#ifndef __CORRECT_ISO_CPP11_MATH_H_PROTO_FP
  constexpr float
  round(float __x)
  { return __builtin_roundf(__x); }
 66c:	vmovss xmm3,DWORD PTR [rip+0x0]        # 674 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x674>
 674:	vbroadcastss xmm4,DWORD PTR [rip+0x0]        # 67d <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x67d>
 67d:	lea    r8,[r12*4+0x0]
 685:	mov    rsi,r15
      if (__b < __a)
 688:	vmovss xmm5,DWORD PTR [rip+0x0]        # 690 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x690>
 690:	mov    r9,QWORD PTR [rsp+0x28]
 695:	xor    edi,edi
 697:	xor    ecx,ecx
 699:	mov    r10,QWORD PTR [rsp+0x18]
 69e:	vandnps xmm3,xmm4,xmm3
      if (__a < __b)
 6a2:	vxorps xmm6,xmm6,xmm6
 6a6:	cs nop WORD PTR [rax+rax*1+0x0]
 6b0:	lea    rax,[rdi+rdi*2]
 6b4:	lea    rdx,[r10+rax*4]
 6b8:	xor    eax,eax
 6ba:	nop    WORD PTR [rax+rax*1+0x0]
            const int c = counts[y * width + x];
 6c0:	mov    r11d,DWORD PTR [rsi+rax*4]
            if (c == 0) continue;
 6c4:	test   r11d,r11d
 6c7:	je     7d5 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x7d5>

            // scale_round_clamp inlining
            output.at(x, y, 0) = (unsigned char) std::clamp(std::round(vals[(y*width + x)*3]     / c), 0.0f, 255.0f);
 6cd:	vcvtsi2ss xmm2,xmm0,r11d
 6d2:	vmovss xmm1,DWORD PTR [rdx]
 6d6:	vmovaps xmm7,xmm4
 6da:	mov    r11,QWORD PTR [rbx]
 6dd:	mov    r14,QWORD PTR [rbx+0x8]
 6e1:	vdivss xmm1,xmm1,xmm2
 6e5:	vpternlogd xmm7,xmm1,xmm3,0xea
 6ec:	vaddss xmm1,xmm1,xmm7
 6f0:	vrndscaless xmm1,xmm1,xmm1,0x3
 6f7:	vmaxss xmm1,xmm1,xmm6
      if (__b < __a)
 6fb:	vminss xmm1,xmm1,xmm5
 6ff:	vcvttss2si r13d,xmm1
    size_t width = 0;
    size_t height = 0;
    std::vector<unsigned char> data; // RGB

    inline size_t index(size_t x, size_t y, size_t c) const {
        if (x >= width) {
 703:	cmp    rax,r11
 706:	jae    70c <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x70c>
            throw std::out_of_range("X coordinate out of bounds");
        }
        if (y >= height) {
 70c:	cmp    rcx,r14
 70f:	jae    715 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x715>
            output.at(x, y, 1) = (unsigned char) std::clamp(std::round(vals[(y*width + x)*3 + 1] / c), 0.0f, 255.0f);
 715:	vmovss xmm1,DWORD PTR [rdx+0x4]
            throw std::out_of_range("Y coordinate out of bounds");
        }
        if (c >= 3) {
            throw std::out_of_range("Colour channel index out of bounds");
        }
        return (y * width + x) * 3 + c;
 71a:	imul   r11,rcx
 71e:	vmovaps xmm7,xmm4
 722:	vdivss xmm1,xmm1,xmm2
 726:	add    r11,rax
            output.at(x, y, 0) = (unsigned char) std::clamp(std::round(vals[(y*width + x)*3]     / c), 0.0f, 255.0f);
 729:	lea    r11,[r11+r11*2]
 72d:	add    r11,QWORD PTR [rbx+0x10]
 731:	mov    BYTE PTR [r11],r13b
 734:	mov    r11,QWORD PTR [rbx]
 737:	mov    r14,QWORD PTR [rbx+0x8]
 73b:	vpternlogd xmm7,xmm1,xmm3,0xea
 742:	vaddss xmm1,xmm1,xmm7
 746:	vrndscaless xmm1,xmm1,xmm1,0x3
      if (__a < __b)
 74d:	vmaxss xmm1,xmm1,xmm6
      if (__b < __a)
 751:	vminss xmm1,xmm1,xmm5
            output.at(x, y, 1) = (unsigned char) std::clamp(std::round(vals[(y*width + x)*3 + 1] / c), 0.0f, 255.0f);
 755:	vcvttss2si r13d,xmm1
        if (x >= width) {
 759:	cmp    rax,r11
 75c:	jae    be0 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0xbe0>
        if (y >= height) {
 762:	cmp    rcx,r14
 765:	jae    76b <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x76b>
            output.at(x, y, 2) = (unsigned char) std::clamp(std::round(vals[(y*width + x)*3 + 2] / c), 0.0f, 255.0f);
 76b:	vmovss xmm1,DWORD PTR [rdx+0x8]
        return (y * width + x) * 3 + c;
 770:	imul   r11,rcx
 774:	vmovaps xmm7,xmm4
 778:	vdivss xmm1,xmm1,xmm2
 77c:	add    r11,rax
            output.at(x, y, 1) = (unsigned char) std::clamp(std::round(vals[(y*width + x)*3 + 1] / c), 0.0f, 255.0f);
 77f:	lea    r11,[r11+r11*2]
 783:	add    r11,QWORD PTR [rbx+0x10]
 787:	mov    BYTE PTR [r11+0x1],r13b
 78b:	mov    r11,QWORD PTR [rbx]
 78e:	mov    r14,QWORD PTR [rbx+0x8]
 792:	vpternlogd xmm7,xmm1,xmm3,0xea
 799:	vaddss xmm1,xmm1,xmm7
 79d:	vrndscaless xmm1,xmm1,xmm1,0x3
      if (__a < __b)
 7a4:	vmaxss xmm1,xmm1,xmm6
      if (__b < __a)
 7a8:	vminss xmm1,xmm1,xmm5
            output.at(x, y, 2) = (unsigned char) std::clamp(std::round(vals[(y*width + x)*3 + 2] / c), 0.0f, 255.0f);
 7ac:	vcvttss2si r13d,xmm1
        if (x >= width) {
 7b0:	cmp    rax,r11
 7b3:	jae    bdb <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0xbdb>
        if (y >= height) {
 7b9:	cmp    rcx,r14
 7bc:	jae    7c2 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x7c2>
        return (y * width + x) * 3 + c;
 7c2:	imul   r11,rcx
 7c6:	add    r11,rax
 7c9:	lea    r11,[r11+r11*2]
 7cd:	add    r11,QWORD PTR [rbx+0x10]
 7d1:	mov    BYTE PTR [r11+0x2],r13b
        for (size_t x = 0; x < width; ++x) {
 7d5:	inc    rax
 7d8:	add    rdx,0xc
 7dc:	cmp    r12,rax
 7df:	jne    6c0 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x6c0>
    for (size_t y = 0; y < height; ++y) {
 7e5:	inc    rcx
 7e8:	add    rdi,r12
 7eb:	add    rsi,r8
 7ee:	cmp    r9,rcx
 7f1:	jne    6b0 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x6b0>
	if (__p)
 7f7:	cmp    QWORD PTR [rsp+0x18],0x0
 7fd:	je     80e <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x80e>
	_GLIBCXX_OPERATOR_DELETE(_GLIBCXX_SIZED_DEALLOC(__p, __n));
 7ff:	mov    rsi,QWORD PTR [rsp+0x30]
 804:	mov    rdi,QWORD PTR [rsp+0x18]
 809:	call   80e <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x80e>
 80e:	test   rbp,rbp
 811:	je     820 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x820>
 813:	mov    rsi,QWORD PTR [rsp+0x38]
 818:	mov    rdi,rbp
 81b:	call   820 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x820>
 820:	test   r15,r15
 823:	je     832 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x832>
 825:	mov    rsi,QWORD PTR [rsp+0x50]
 82a:	mov    rdi,r15
 82d:	call   832 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x832>
 832:	mov    rax,QWORD PTR [rsp+0x10]
 837:	test   rax,rax
 83a:	je     849 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x849>
 83c:	mov    rsi,QWORD PTR [rsp+0x40]
 841:	mov    rdi,rax
 844:	call   849 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x849>
        }
    }

    return output;
}
 849:	add    rsp,0x98
 850:	mov    rax,rbx
 853:	pop    rbx
 854:	pop    rbp
 855:	pop    r12
 857:	pop    r13
 859:	pop    r14
 85b:	pop    r15
 85d:	ret
    for (size_t y = 0; y < height; ++y) {
 85e:	mov    rax,QWORD PTR [rsp+0x28]
 863:	cmp    rax,r13
 866:	je     7f7 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x7f7>
 868:	add    r12,0x2
 86c:	cmp    rax,r12
 86f:	je     7f7 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x7f7>
 871:	mov    rax,QWORD PTR [rsp+0x28]
 876:	lea    r13,[r12+0x1]
 87b:	cmp    rax,r13
 87e:	jne    868 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x868>
 880:	jmp    7f7 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x7f7>
	: _M_start(), _M_finish(), _M_end_of_storage()
 885:	mov    QWORD PTR [rsp+0x8],0x0
    const int w = static_cast<int>(width);
 88e:	mov    ecx,r12d
    const int h = static_cast<int>(height);
 891:	mov    r14d,eax
 894:	mov    QWORD PTR [rsp+0x20],0x0
    for (SubApertureImage& sub : subapertures) {
 89d:	cmp    r15,rsi
 8a0:	jne    c2 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0xc2>
 8a6:	mov    QWORD PTR [rsp+0x10],0x0
	this->_M_impl._M_end_of_storage = this->_M_impl._M_start + __n;
 8af:	mov    QWORD PTR [rsp+0x50],0x0
	return __n != 0 ? _Tr::allocate(_M_impl, __n) : pointer();
 8b8:	xor    r15d,r15d
 8bb:	jmp    21b <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x21b>
	if (__n > _S_max_size(_Tp_alloc_type(__a)))
 8c0:	cmp    QWORD PTR [rsp+0x48],0x0
 8c6:	js     8cc <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x8cc>
	  return static_cast<_Tp*>(_GLIBCXX_OPERATOR_NEW(__n * sizeof(_Tp)));
 8cc:	mov    rdi,rsi
 8cf:	mov    r14,rsi
 8d2:	vmovss DWORD PTR [rsp+0x8],xmm0
 8d8:	call   8dd <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x8dd>
		      __builtin_memset(__dest, (unsigned char)__x, __n);
 8dd:	xor    esi,esi
	this->_M_impl._M_end_of_storage = this->_M_impl._M_start + __n;
 8df:	mov    rdx,r14
 8e2:	mov    rdi,rax
 8e5:	lea    r13,[rax+r14*1]
 8e9:	call   8ee <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x8ee>
	  _M_finish = __x._M_finish;
 8ee:	mov    QWORD PTR [rbx+0x18],r13
      if (this->capacity() < __n)
 8f2:	vmovss xmm4,DWORD PTR [rsp+0x8]
	  _M_start = __x._M_start;
 8f8:	mov    QWORD PTR [rbx+0x10],rax
	ptrdiff_t __dif = this->_M_impl._M_finish - this->_M_impl._M_start;
 8fc:	mov    rax,QWORD PTR [rbp+0x8]
	  _M_end_of_storage = __x._M_end_of_storage;
 900:	mov    QWORD PTR [rbx+0x20],r13
	ptrdiff_t __dif = this->_M_impl._M_finish - this->_M_impl._M_start;
 904:	mov    QWORD PTR [rsp+0x18],rax
 909:	sub    rax,r15
 90c:	mov    QWORD PTR [rsp+0x40],rax
 911:	jne    89 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x89>
	: _M_start(), _M_finish(), _M_end_of_storage()
 917:	mov    QWORD PTR [rsp+0x20],0x0
 920:	mov    QWORD PTR [rsp+0x8],0x0
 929:	jmp    af <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0xaf>
    for (const SubParams& p : params) {
 92e:	mov    rsi,QWORD PTR [rsp+0x10]
	return __n != 0 ? _Tr::allocate(_M_impl, __n) : pointer();
 933:	mov    QWORD PTR [rsp+0x18],0x0
 93c:	cmp    QWORD PTR [rsp+0x8],rsi
 941:	jne    304 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x304>
    for (int y = 0; y < h; ++y) {
 947:	test   r14d,r14d
 94a:	jg     b5e <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0xb5e>
    for (size_t y = 0; y < height; ++y) {
 950:	cmp    QWORD PTR [rsp+0x28],0x0
 956:	jne    663 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x663>
 95c:	jmp    80e <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x80e>
 961:	nop    DWORD PTR [rax+0x0]
 968:	xor    ebp,ebp
 96a:	jmp    274 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x274>
	ptrdiff_t __dif = this->_M_impl._M_finish - this->_M_impl._M_start;
 96f:	mov    rax,QWORD PTR [rsp+0x20]
 974:	sub    rax,QWORD PTR [rsp+0x10]
 979:	mov    QWORD PTR [rsp+0x8],rax
 97e:	sar    rax,0x4
 982:	mov    rdx,rax
 985:	movabs rax,0xaaaaaaaaaaaaaaab
 98f:	imul   rdx,rax
	if (max_size() - size() < __n)
 993:	movabs rax,0x2aaaaaaaaaaaaaa
 99d:	cmp    rdx,rax
 9a0:	je     9a6 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x9a6>
      if (__a < __b)
 9a6:	test   rdx,rdx
 9a9:	mov    eax,0x1
 9ae:	mov    DWORD PTR [rsp+0x88],ecx
 9b5:	cmovne rax,rdx
 9b9:	mov    DWORD PTR [rsp+0x84],r10d
 9c1:	mov    DWORD PTR [rsp+0x80],esi
	const size_type __len = size() + (std::max)(size(), __n);
 9c8:	add    rax,rdx
	return (__len < size() || __len > max_size()) ? max_size() : __len;
 9cb:	movabs rdx,0x2aaaaaaaaaaaaaa
 9d5:	mov    DWORD PTR [rsp+0x68],r8d
 9da:	cmp    rax,rdx
 9dd:	mov    DWORD PTR [rsp+0x60],r9d
 9e2:	cmova  rax,rdx
 9e6:	vmovss DWORD PTR [rsp+0x8c],xmm4
 9ef:	vmovss DWORD PTR [rsp+0x7c],xmm5
 9f5:	lea    rax,[rax+rax*2]
 9f9:	vmovss DWORD PTR [rsp+0x78],xmm0
 9ff:	shl    rax,0x4
 a03:	vmovss DWORD PTR [rsp+0x74],xmm1
 a09:	mov    rdi,rax
 a0c:	mov    QWORD PTR [rsp+0x50],rax
 a11:	vmovss DWORD PTR [rsp+0x70],xmm2
 a17:	call   a1c <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0xa1c>
	// taking the element by lvalue ref (see last bullet of C++11
	// [res.on.arguments]).

	// If this throws, the existing elements are unchanged.
#if __cplusplus >= 201103L
	_Alloc_traits::construct(this->_M_impl,
 a1c:	mov    rdx,QWORD PTR [rsp+0x8]
	{ ::new((void *)__p) _Up(std::forward<_Args>(__args)...); }
 a21:	mov    esi,DWORD PTR [rsp+0x80]
	  return static_cast<_Tp*>(_GLIBCXX_OPERATOR_NEW(__n * sizeof(_Tp)));
 a28:	mov    QWORD PTR [rsp+0x40],rax
 a2d:	mov    rdi,rax
	{ ::new((void *)__p) _Up(std::forward<_Args>(__args)...); }
 a30:	mov    r9d,DWORD PTR [rsp+0x60]
 a35:	mov    r8d,DWORD PTR [rsp+0x68]
    __relocate_a_1(_Tp* __first, _Tp* __last,
		   _Tp* __result,
		   [[__maybe_unused__]] allocator<_Up>& __alloc) noexcept
    {
      ptrdiff_t __count = __last - __first;
      if (__count > 0)
 a3a:	mov    r11d,0x0
 a40:	vmovss xmm2,DWORD PTR [rsp+0x70]
 a46:	vmovss xmm1,DWORD PTR [rsp+0x74]
 a4c:	mov    DWORD PTR [rax+rdx*1+0x18],esi
 a50:	test   rdx,rdx
 a53:	vmovss xmm0,DWORD PTR [rsp+0x78]
 a59:	vmovss xmm5,DWORD PTR [rsp+0x7c]
 a5f:	mov    DWORD PTR [rax+rdx*1],r9d
 a63:	mov    r10d,DWORD PTR [rsp+0x84]
 a6b:	mov    rsi,QWORD PTR [rsp+0x38]
 a70:	mov    DWORD PTR [rax+rdx*1+0x4],r8d
 a75:	mov    ecx,DWORD PTR [rsp+0x88]
 a7c:	vmovss xmm4,DWORD PTR [rsp+0x8c]
 a85:	mov    DWORD PTR [rax+rdx*1+0x1c],ebp
 a89:	mov    DWORD PTR [rax+rdx*1+0x20],r10d
 a8e:	mov    DWORD PTR [rax+rdx*1+0x24],r13d
 a93:	mov    QWORD PTR [rax+rdx*1+0x28],rsi
 a98:	vmovss DWORD PTR [rax+rdx*1+0x8],xmm2
 a9e:	vmovss DWORD PTR [rax+rdx*1+0xc],xmm1
 aa4:	vmovss DWORD PTR [rax+rdx*1+0x10],xmm0
 aaa:	vmovss DWORD PTR [rax+rdx*1+0x14],xmm5
 ab0:	je     ad3 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0xad3>
	      __gnu_cxx::__normal_iterator<_Tp*, void> __out(__result);
	      __out = std::__relocate_a_1(__first, __last, __out, __alloc);
	      return __out.base();
	    }
#endif
	  __builtin_memcpy(__result, __first, __count * sizeof(_Tp));
 ab2:	mov    rsi,QWORD PTR [rsp+0x10]
 ab7:	mov    DWORD PTR [rsp+0x38],ecx
 abb:	vmovss DWORD PTR [rsp+0x60],xmm4
 ac1:	call   ac6 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0xac6>
 ac6:	vmovss xmm4,DWORD PTR [rsp+0x60]
 acc:	mov    ecx,DWORD PTR [rsp+0x38]
 ad0:	xor    r11d,r11d
	  {
	    // Relocation cannot throw.
	    __new_finish = std::__relocate_a(__old_start, __old_finish,
					     __new_start,
					     _M_get_Tp_allocator());
	    ++__new_finish;
 ad3:	mov    rsi,QWORD PTR [rsp+0x8]
 ad8:	mov    rax,QWORD PTR [rsp+0x40]
 add:	lea    rax,[rax+rsi*1+0x30]
 ae2:	mov    QWORD PTR [rsp+0x8],rax
	  if (_M_storage)
 ae7:	mov    rax,QWORD PTR [rsp+0x10]
 aec:	test   rax,rax
 aef:	je     b18 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0xb18>
	    // New storage has been fully initialized, destroy the old elements.
	    __guard_elts._M_first = __old_start;
	    __guard_elts._M_last = __old_finish;
	  }
	__guard._M_storage = __old_start;
	__guard._M_len = this->_M_impl._M_end_of_storage - __old_start;
 af1:	mov    rsi,QWORD PTR [rsp+0x20]
	_GLIBCXX_OPERATOR_DELETE(_GLIBCXX_SIZED_DEALLOC(__p, __n));
 af6:	mov    rdi,rax
 af9:	mov    DWORD PTR [rsp+0x10],ecx
      deallocate(_Tp* __p, size_type __n __attribute__ ((__unused__)))
 afd:	vmovss DWORD PTR [rsp+0x38],xmm4
 b03:	sub    rsi,rax
	_GLIBCXX_OPERATOR_DELETE(_GLIBCXX_SIZED_DEALLOC(__p, __n));
 b06:	call   b0b <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0xb0b>
 b0b:	vmovss xmm4,DWORD PTR [rsp+0x38]
 b11:	mov    ecx,DWORD PTR [rsp+0x10]
 b15:	xor    r11d,r11d
      // deallocate should be called before assignments to _M_impl,
      // to avoid call-clobbering

      this->_M_impl._M_start = __new_start;
      this->_M_impl._M_finish = __new_finish;
      this->_M_impl._M_end_of_storage = __new_start + __len;
 b18:	mov    rsi,QWORD PTR [rsp+0x40]
 b1d:	mov    rax,QWORD PTR [rsp+0x50]
 b22:	add    rax,rsi
      this->_M_impl._M_start = __new_start;
 b25:	mov    QWORD PTR [rsp+0x10],rsi
      this->_M_impl._M_end_of_storage = __new_start + __len;
 b2a:	mov    QWORD PTR [rsp+0x20],rax
 b2f:	jmp    1b3 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x1b3>
    for (const SubParams& p : params) {
 b34:	mov    rcx,QWORD PTR [rsp+0x10]
 b39:	cmp    QWORD PTR [rsp+0x8],rcx
 b3e:	jne    435 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x435>
 b44:	jmp    657 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x657>
    for (const SubParams& p : params) {
 b49:	mov    rsi,QWORD PTR [rsp+0x10]
 b4e:	cmp    QWORD PTR [rsp+0x8],rsi
 b53:	jne    304 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x304>
    for (int y = 0; y < h; ++y) {
 b59:	test   r14d,r14d
 b5c:	jle    bb0 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0xbb0>
 b5e:	test   ecx,ecx
 b60:	jg     391 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x391>
 b66:	jmp    663 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x663>
 b6b:	nop    DWORD PTR [rax+rax*1+0x0]
    for (SubApertureImage& sub : subapertures) {
 b70:	mov    rax,QWORD PTR [rsp+0x8]
 b75:	mov    QWORD PTR [rsp+0x10],rax
 b7a:	jmp    1d1 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x1d1>
    for (const SubParams& p : params) {
 b7f:	mov    rcx,QWORD PTR [rsp+0x10]
 b84:	cmp    QWORD PTR [rsp+0x8],rcx
 b89:	jne    435 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x435>
    for (size_t y = 0; y < height; ++y) {
 b8f:	cmp    QWORD PTR [rsp+0x28],0x0
 b95:	jne    663 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x663>
	if (__p)
 b9b:	cmp    QWORD PTR [rsp+0x18],0x0
 ba1:	jne    7ff <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x7ff>
 ba7:	jmp    813 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x813>
 bac:	nop    DWORD PTR [rax+0x0]
 bb0:	cmp    QWORD PTR [rsp+0x28],0x0
 bb6:	jne    663 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x663>
 bbc:	jmp    7ff <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x7ff>
 bc1:	jmp    bc6 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0xbc6>
 bc6:	jmp    bcb <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0xbcb>
 bcb:	jmp    bd0 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0xbd0>
 bd0:	mov    rbp,rax
 bd3:	vzeroupper
 bd6:	jmp    bdb <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0xbdb>
 bdb:	jmp    be0 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0xbe0>
 be0:	jmp    be5 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0xbe5>
 be5:	jmp    bea <.LC9+0xbb5>

Disassembly of section .text.unlikely:

0000000000000000 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float) [clone .cold]>:
	  __throw_length_error(
   0:	lea    rdi,[rip+0x0]        # 7 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float) [clone .cold]+0x7>
   7:	call   c <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float) [clone .cold]+0xc>
	if (__p)
   c:	mov    rbp,rax
   f:	vzeroupper
  12:	test   r15,r15
  15:	je     24 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float) [clone .cold]+0x24>
  17:	mov    rsi,QWORD PTR [rsp+0x50]
  1c:	mov    rdi,r15
  1f:	call   24 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float) [clone .cold]+0x24>
  24:	cmp    QWORD PTR [rsp+0x10],0x0
  2a:	je     144 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float) [clone .cold]+0x144>
	ptrdiff_t __n = _M_impl._M_end_of_storage - _M_impl._M_start;
  30:	mov    rsi,QWORD PTR [rsp+0x20]
  35:	mov    rdi,QWORD PTR [rsp+0x10]
  3a:	sub    rsi,rdi
  3d:	call   42 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float) [clone .cold]+0x42>
      ~__new_allocator() _GLIBCXX_USE_NOEXCEPT { }
  42:	jmp    144 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float) [clone .cold]+0x144>
	if (__p)
  47:	mov    r12,rax
  4a:	vzeroupper
  4d:	test   rbp,rbp
  50:	je     5f <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float) [clone .cold]+0x5f>
	_GLIBCXX_OPERATOR_DELETE(_GLIBCXX_SIZED_DEALLOC(__p, __n));
  52:	mov    rsi,QWORD PTR [rsp+0x38]
  57:	mov    rdi,rbp
  5a:	call   5f <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float) [clone .cold]+0x5f>
      ~__new_allocator() _GLIBCXX_USE_NOEXCEPT { }
  5f:	mov    rbp,r12
  62:	jmp    12 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float) [clone .cold]+0x12>
	  __throw_length_error(
  64:	lea    rdi,[rip+0x0]        # 6b <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float) [clone .cold]+0x6b>
  6b:	call   70 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float) [clone .cold]+0x70>
            throw std::out_of_range("Y coordinate out of bounds");
  70:	mov    edi,0x10
  75:	call   7a <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float) [clone .cold]+0x7a>
  7a:	lea    rsi,[rip+0x0]        # 81 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float) [clone .cold]+0x81>
  81:	mov    rdi,rax
  84:	mov    r12,rax
  87:	call   8c <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float) [clone .cold]+0x8c>
  8c:	mov    rdx,QWORD PTR [rip+0x0]        # 93 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float) [clone .cold]+0x93>
  93:	lea    rsi,[rip+0x0]        # 9a <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float) [clone .cold]+0x9a>
  9a:	mov    rdi,r12
  9d:	call   a2 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float) [clone .cold]+0xa2>
            throw std::out_of_range("X coordinate out of bounds");
  a2:	mov    edi,0x10
  a7:	call   ac <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float) [clone .cold]+0xac>
  ac:	lea    rsi,[rip+0x0]        # b3 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float) [clone .cold]+0xb3>
  b3:	mov    rdi,rax
  b6:	mov    r12,rax
  b9:	call   be <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float) [clone .cold]+0xbe>
  be:	mov    rdx,QWORD PTR [rip+0x0]        # c5 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float) [clone .cold]+0xc5>
  c5:	lea    rsi,[rip+0x0]        # cc <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float) [clone .cold]+0xcc>
  cc:	mov    rdi,r12
  cf:	call   d4 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float) [clone .cold]+0xd4>
  d4:	mov    rbp,rax
  d7:	vzeroupper
  da:	jmp    24 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float) [clone .cold]+0x24>
            throw std::out_of_range("Y coordinate out of bounds");
  df:	mov    rdi,r12
  e2:	mov    r13,rax
  e5:	vzeroupper
  e8:	call   ed <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float) [clone .cold]+0xed>
  ed:	jmp    1db <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float) [clone .cold]+0x1db>
  f2:	lea    rdi,[rip+0x0]        # f9 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float) [clone .cold]+0xf9>
  f9:	call   fe <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float) [clone .cold]+0xfe>
  fe:	mov    edi,0x10
 103:	call   108 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float) [clone .cold]+0x108>
 108:	lea    rsi,[rip+0x0]        # 10f <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float) [clone .cold]+0x10f>
 10f:	mov    rdi,rax
 112:	mov    r12,rax
 115:	call   11a <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float) [clone .cold]+0x11a>
 11a:	mov    rdx,QWORD PTR [rip+0x0]        # 121 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float) [clone .cold]+0x121>
 121:	lea    rsi,[rip+0x0]        # 128 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float) [clone .cold]+0x128>
 128:	mov    rdi,r12
 12b:	call   130 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float) [clone .cold]+0x130>
 130:	lea    rdi,[rip+0x0]        # 137 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float) [clone .cold]+0x137>
 137:	call   13c <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float) [clone .cold]+0x13c>
 13c:	jmp    df <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float) [clone .cold]+0xdf>
	ptrdiff_t __n = _M_impl._M_end_of_storage - _M_impl._M_start;
 13e:	mov    rbp,rax
 141:	vzeroupper
 144:	mov    rdi,QWORD PTR [rbx+0x10]
	if (__p)
 148:	test   rdi,rdi
 14b:	je     159 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float) [clone .cold]+0x159>
	ptrdiff_t __n = _M_impl._M_end_of_storage - _M_impl._M_start;
 14d:	mov    rsi,QWORD PTR [rbx+0x20]
 151:	sub    rsi,rdi
	_GLIBCXX_OPERATOR_DELETE(_GLIBCXX_SIZED_DEALLOC(__p, __n));
 154:	call   159 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float) [clone .cold]+0x159>
      ~__new_allocator() _GLIBCXX_USE_NOEXCEPT { }
 159:	mov    rdi,rbp
 15c:	call   161 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float) [clone .cold]+0x161>
	if (__p)
 161:	mov    rbp,rax
 164:	vzeroupper
 167:	jmp    24 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float) [clone .cold]+0x24>
 16c:	mov    edi,0x10
 171:	call   176 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float) [clone .cold]+0x176>
 176:	lea    rsi,[rip+0x0]        # 17d <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float) [clone .cold]+0x17d>
 17d:	mov    rdi,rax
 180:	mov    r12,rax
 183:	call   188 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float) [clone .cold]+0x188>
 188:	mov    rdx,QWORD PTR [rip+0x0]        # 18f <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float) [clone .cold]+0x18f>
 18f:	lea    rsi,[rip+0x0]        # 196 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float) [clone .cold]+0x196>
 196:	mov    rdi,r12
 199:	call   19e <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float) [clone .cold]+0x19e>
 19e:	jmp    df <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float) [clone .cold]+0xdf>
            throw std::out_of_range("X coordinate out of bounds");
 1a3:	mov    edi,0x10
 1a8:	call   1ad <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float) [clone .cold]+0x1ad>
 1ad:	lea    rsi,[rip+0x0]        # 1b4 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float) [clone .cold]+0x1b4>
 1b4:	mov    rdi,rax
 1b7:	mov    r12,rax
 1ba:	call   1bf <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float) [clone .cold]+0x1bf>
 1bf:	mov    rdx,QWORD PTR [rip+0x0]        # 1c6 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float) [clone .cold]+0x1c6>
 1c6:	lea    rsi,[rip+0x0]        # 1cd <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float) [clone .cold]+0x1cd>
 1cd:	mov    rdi,r12
 1d0:	call   1d5 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float) [clone .cold]+0x1d5>
 1d5:	mov    r13,rax
 1d8:	vzeroupper
 1db:	cmp    QWORD PTR [rsp+0x18],0x0
 1e1:	je     1f2 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float) [clone .cold]+0x1f2>
	_GLIBCXX_OPERATOR_DELETE(_GLIBCXX_SIZED_DEALLOC(__p, __n));
 1e3:	mov    rsi,QWORD PTR [rsp+0x30]
 1e8:	mov    rdi,QWORD PTR [rsp+0x18]
 1ed:	call   1f2 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float) [clone .cold]+0x1f2>
      ~__new_allocator() _GLIBCXX_USE_NOEXCEPT { }
 1f2:	mov    r12,r13
 1f5:	jmp    4d <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float) [clone .cold]+0x4d>
 1fa:	jmp    df <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float) [clone .cold]+0xdf>
 1ff:	jmp    df <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float) [clone .cold]+0xdf>
 204:	mov    edi,0x10
 209:	call   20e <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float) [clone .cold]+0x20e>
 20e:	lea    rsi,[rip+0x0]        # 215 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float) [clone .cold]+0x215>
 215:	mov    rdi,rax
 218:	mov    r12,rax
 21b:	call   220 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float) [clone .cold]+0x220>
 220:	mov    rdx,QWORD PTR [rip+0x0]        # 227 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float) [clone .cold]+0x227>
 227:	lea    rsi,[rip+0x0]        # 22e <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float) [clone .cold]+0x22e>
 22e:	mov    rdi,r12
 231:	call   236 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float) [clone .cold]+0x236>
 236:	jmp    df <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float) [clone .cold]+0xdf>
	  __throw_length_error(__N(__s));
 23b:	lea    rdi,[rip+0x0]        # 242 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float) [clone .cold]+0x242>
 242:	call   247 <.LC9+0x212>
