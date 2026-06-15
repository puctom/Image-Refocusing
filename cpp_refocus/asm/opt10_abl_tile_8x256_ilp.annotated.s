
asm/opt10_abl_tile_8x256_ilp.o:     file format elf64-x86-64


Disassembly of section .text:

0000000000000000 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)>:
    int x_begin, x_end, y_begin, y_end;
    const unsigned char* SUB;
};
}

ImageData refocus_shift_and_sum(std::vector<SubApertureImage>& subapertures, float focus) {
       0:	push   rbp
	pointer _M_finish;
	pointer _M_end_of_storage;

	_GLIBCXX20_CONSTEXPR
	_Vector_impl_data() _GLIBCXX_NOEXCEPT
	: _M_start(), _M_finish(), _M_end_of_storage()
       1:	vpxor  xmm1,xmm1,xmm1
       5:	mov    rbp,rsp
       8:	push   r15
       a:	push   r14
       c:	push   r13
       e:	push   r12
      10:	mov    r12,rsi
      13:	push   rbx
      14:	and    rsp,0xffffffffffffffe0
      18:	sub    rsp,0x100
      : _M_current() { }

      __attribute__((__always_inline__))
      explicit _GLIBCXX_CONSTEXPR
      __normal_iterator(const _Iterator& __i) _GLIBCXX_NOEXCEPT
      : _M_current(__i) { }
      1f:	mov    rbx,QWORD PTR [rsi]
      22:	vmovss DWORD PTR [rsp+0xc0],xmm0
      2b:	mov    QWORD PTR [rsp+0x78],rdi
    const size_t width  = subapertures.front().data.width;
      30:	vmovdqu xmm0,XMMWORD PTR [rbx]
      34:	mov    QWORD PTR [rdi+0x20],0x0
      3c:	vmovdqu XMMWORD PTR [rdi+0x10],xmm1
      41:	vmovq  rax,xmm0
      46:	vpextrq rdx,xmm0,0x1
      4c:	vmovq  QWORD PTR [rsp+0x90],xmm0
    const int h = static_cast<int>(height);

    ImageData output;
    output.width = width;
    output.height = height;
    output.data.assign(width * height * 3, 0);
      55:	mov    r14,rax
      58:	mov    QWORD PTR [rsp+0xe0],rdx
      60:	imul   r14,rdx
    output.width = width;
      64:	vmovdqu XMMWORD PTR [rdi],xmm0
    void
    vector<_Tp, _Alloc>::
    _M_fill_assign(size_t __n, const value_type& __val)
    {
      const size_type __sz = size();
      if (__n > capacity())
      68:	test   r14,r14
      6b:	jne    133c <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x133c>
      /**  Returns the number of elements in the %vector.  */
      _GLIBCXX_NODISCARD _GLIBCXX20_CONSTEXPR
      size_type
      size() const _GLIBCXX_NOEXCEPT
      {
	ptrdiff_t __dif = this->_M_impl._M_finish - this->_M_impl._M_start;
      71:	mov    rdi,QWORD PTR [rsi+0x8]
      if (this->capacity() < __n)
      75:	mov    rcx,rdi
      78:	mov    QWORD PTR [rsp+0xf0],rdi
      80:	sub    rcx,rbx
      83:	mov    QWORD PTR [rsp+0x38],rcx
      88:	je     13e0 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x13e0>
	    return static_cast<_Tp*>(_GLIBCXX_OPERATOR_NEW(__n * sizeof(_Tp),
							   __al));
	  }
#endif
	else
	  return static_cast<_Tp*>(_GLIBCXX_OPERATOR_NEW(__n * sizeof(_Tp)));
      8e:	mov    r15,QWORD PTR [rsp+0x38]
      93:	mov    rdi,r15
      96:	call   9b <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x9b>
      9b:	mov    QWORD PTR [rsp+0x50],rax
	  this->_M_impl._M_end_of_storage = this->_M_impl._M_start + __n;
      a0:	add    r15,rax
    const int w = static_cast<int>(width);
      a3:	mov    eax,DWORD PTR [rsp+0x90]
    const int h = static_cast<int>(height);
      aa:	mov    r13d,DWORD PTR [rsp+0xe0]
    const int w = static_cast<int>(width);
      b2:	mov    DWORD PTR [rsp+0x4c],eax

    // Precalculate subaperture parameters
    std::vector<SubParams> params;
    params.reserve(subapertures.size());
    for (auto& sub : subapertures) {
      b6:	cmp    rbx,QWORD PTR [rsp+0xf0]
      be:	je     15c1 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x15c1>
	: _M_start(), _M_finish(), _M_end_of_storage()
      c4:	mov    r12,QWORD PTR [rsp+0x50]
        SubParams p;
        float shift_x = focus * sub.u;
      c9:	vmovss xmm5,DWORD PTR [rsp+0xc0]
        float dy = shift_y - p.sy;
        p.A = (1 - dx) * (1 - dy);
        p.B = dx       * (1 - dy);
        p.C = (1 - dx) * dy;
        p.D = dx       * dy;
        p.x_begin = std::max(0, -p.sx);
      d2:	xor    r8d,r8d
        float shift_x = focus * sub.u;
      d5:	vmulss xmm4,xmm5,DWORD PTR [rbx+0x28]
        float shift_y = focus * sub.v;
      da:	vmulss xmm2,xmm5,DWORD PTR [rbx+0x2c]
  using ::floor;

#ifndef __CORRECT_ISO_CPP_MATH_H_PROTO
  inline _GLIBCXX_CONSTEXPR float
  floor(float __x)
  { return __builtin_floorf(__x); }
      df:	vrndscaless xmm0,xmm4,xmm4,0x9
        p.sx = static_cast<int>(std::floor(shift_x));
      e6:	vcvttss2si r10d,xmm0
      ea:	vrndscaless xmm1,xmm2,xmm2,0x9
        p.sy = static_cast<int>(std::floor(shift_y));
      f1:	vcvttss2si esi,xmm1
        p.x_begin = std::max(0, -p.sx);
      f5:	mov    eax,r10d
      f8:	neg    eax
      fa:	test   r10d,r10d
      fd:	cmovs  r8d,eax
        p.x_end   = std::min(w, w - p.sx - 1);
     101:	mov    eax,DWORD PTR [rsp+0x4c]
     105:	mov    ecx,eax
     107:	sub    ecx,r10d
     10a:	dec    ecx
    min(const _Tp& __a, const _Tp& __b)
    {
      // concept requirements
      __glibcxx_function_requires(_LessThanComparableConcept<_Tp>)
      //return __b < __a ? __b : __a;
      if (__b < __a)
     10c:	cmp    ecx,eax
     10e:	cmovg  ecx,eax
        p.y_begin = std::max(0, -p.sy);
     111:	mov    eax,esi
     113:	xor    r9d,r9d
     116:	neg    eax
     118:	test   esi,esi
     11a:	cmovs  r9d,eax
        p.y_end   = std::min(h, h - p.sy - 1);
     11e:	mov    eax,r13d
     121:	sub    eax,esi
     123:	dec    eax
     125:	cmp    eax,r13d
     128:	cmovg  eax,r13d
     12c:	mov    r11d,eax
        p.SUB = sub.data.data.data();
        if (p.x_begin >= p.x_end || p.y_begin >= p.y_end) continue;  // skip degenerate
     12f:	cmp    r8d,ecx
     132:	jge    1ba <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x1ba>
     138:	cmp    r9d,eax
     13b:	jge    1ba <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x1ba>
        float dy = shift_y - p.sy;
     13d:	vsubss xmm5,xmm2,xmm1
        float dx = shift_x - p.sx;
     141:	vsubss xmm3,xmm4,xmm0
       *   range.  For a non-empty %vector, data() == &front().
       */
      _GLIBCXX_NODISCARD _GLIBCXX20_CONSTEXPR
      _Tp*
      data() _GLIBCXX_NOEXCEPT
      { return _M_data_ptr(this->_M_impl._M_start); }
     145:	mov    rdi,QWORD PTR [rbx+0x10]
       */
      _GLIBCXX20_CONSTEXPR
      void
      push_back(const value_type& __x)
      {
	if (this->_M_impl._M_finish != this->_M_impl._M_end_of_storage)
     149:	mov    rax,QWORD PTR [rsp+0x50]
        p.A = (1 - dx) * (1 - dy);
     14e:	vaddss xmm0,xmm0,DWORD PTR [rip+0x0]        # 156 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x156>
     156:	vaddss xmm1,xmm1,DWORD PTR [rip+0x0]        # 15e <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x15e>
      { return _M_data_ptr(this->_M_impl._M_start); }
     15e:	mov    QWORD PTR [rsp+0xd0],rdi
     166:	vsubss xmm0,xmm0,xmm4
     16a:	vsubss xmm1,xmm1,xmm2
     16e:	vmulss xmm2,xmm0,xmm1
        p.B = dx       * (1 - dy);
     172:	vmulss xmm1,xmm1,xmm3
        p.C = (1 - dx) * dy;
     176:	vmulss xmm0,xmm0,xmm5
        p.D = dx       * dy;
     17a:	vmulss xmm3,xmm3,xmm5
	if (this->_M_impl._M_finish != this->_M_impl._M_end_of_storage)
     17e:	cmp    rax,r15
     181:	je     1420 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x1420>
      template<typename _Up, typename... _Args>
	__attribute__((__always_inline__))
	void
	construct(_Up* __p, _Args&&... __args)
	noexcept(__is_nothrow_new_constructible<_Up, _Args...>)
	{ ::new((void *)__p) _Up(std::forward<_Args>(__args)...); }
     187:	vunpcklps xmm0,xmm0,xmm3
     18b:	vunpcklps xmm2,xmm2,xmm1
     18f:	mov    DWORD PTR [rax],r10d
	  {
	    _GLIBCXX_ASAN_ANNOTATE_GROW(1);
	    _Alloc_traits::construct(this->_M_impl, this->_M_impl._M_finish,
				     __x);
	    ++this->_M_impl._M_finish;
     192:	add    rax,0x30
     196:	vmovlhps xmm2,xmm2,xmm0
     19a:	mov    DWORD PTR [rax-0x2c],esi
     19d:	vmovups XMMWORD PTR [rax-0x28],xmm2
     1a2:	mov    DWORD PTR [rax-0x18],r8d
     1a6:	mov    DWORD PTR [rax-0x14],ecx
     1a9:	mov    DWORD PTR [rax-0x10],r9d
     1ad:	mov    DWORD PTR [rax-0xc],r11d
     1b1:	mov    QWORD PTR [rax-0x8],rdi
     1b5:	mov    QWORD PTR [rsp+0x50],rax
      __attribute__((__always_inline__))
      _GLIBCXX14_CONSTEXPR
      __normal_iterator&
      operator++() _GLIBCXX_NOEXCEPT
      {
	++_M_current;
     1ba:	add    rbx,0x30
    for (auto& sub : subapertures) {
     1be:	cmp    rbx,QWORD PTR [rsp+0xf0]
     1c6:	jne    c9 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0xc9>
	ptrdiff_t __n = _M_impl._M_end_of_storage - _M_impl._M_start;
     1cc:	mov    rax,r15
     1cf:	sub    rax,r12
     1d2:	mov    QWORD PTR [rsp+0x38],rax
     1d7:	mov    rax,QWORD PTR [rsp+0x50]
     1dc:	mov    QWORD PTR [rsp+0x50],r12
     1e1:	mov    QWORD PTR [rsp+0x80],rax

      // Called by constructors to check initial size.
      static _GLIBCXX20_CONSTEXPR size_type
      _S_check_init_len(size_type __n, const allocator_type& __a)
      {
	if (__n > _S_max_size(_Tp_alloc_type(__a)))
     1e9:	mov    rax,r14
     1ec:	shr    rax,0x3d
     1f0:	jne    1f6 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x1f6>
	return __n != 0 ? _Tr::allocate(_M_impl, __n) : pointer();
     1f6:	test   r14,r14
     1f9:	je     140a <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x140a>
	  return static_cast<_Tp*>(_GLIBCXX_OPERATOR_NEW(__n * sizeof(_Tp)));
     1ff:	shl    r14,0x2
     203:	mov    rdi,r14
     206:	call   20b <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x20b>
	  // Allow std::_Construct to be used in constant expressions.
	  std::construct_at(__p, std::forward<_Args>(__args)...);
	  return;
	}
#endif
      ::new(static_cast<void*>(__p)) _Tp(std::forward<_Args>(__args)...);
     20b:	mov    rdx,r14
     20e:	xor    esi,esi
     210:	mov    rdi,rax
     213:	mov    QWORD PTR [rsp+0x40],rax
     218:	call   21d <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x21d>
        params.push_back(p);
    }

    // Precalculate counts
    std::vector<int> counts(width * height, 0);
    std::vector<int> diff((width + 1) * (height + 1), 0);
     21d:	mov    rax,QWORD PTR [rsp+0x90]
     225:	lea    r9,[rax+0x1]
     229:	mov    rax,QWORD PTR [rsp+0xe0]
     231:	inc    rax
     234:	imul   rax,r9
     238:	mov    rbx,rax
	if (__n > _S_max_size(_Tp_alloc_type(__a)))
     23b:	shr    rax,0x3d
     23f:	jne    245 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x245>
	return __n != 0 ? _Tr::allocate(_M_impl, __n) : pointer();
     245:	test   rbx,rbx
     248:	je     1418 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x1418>
     24e:	shl    rbx,0x2
     252:	mov    QWORD PTR [rsp+0xf0],r9
     25a:	mov    rdi,rbx
     25d:	call   262 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x262>
     262:	mov    rdx,rbx
     265:	xor    esi,esi
     267:	mov    rdi,rax
     26a:	mov    r12,rax
     26d:	call   272 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x272>
     272:	mov    r9,QWORD PTR [rsp+0xf0]

    for (const auto& p : params) {
     27a:	mov    rax,QWORD PTR [rsp+0x50]
     27f:	cmp    rax,QWORD PTR [rsp+0x80]
     287:	je     2ce <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x2ce>
        diff[p.y_begin * (width + 1) + p.x_begin] += 1;
     289:	movsxd rdx,DWORD PTR [rax+0x20]
     28d:	movsxd rsi,DWORD PTR [rax+0x18]
     291:	add    rax,0x30
        diff[p.y_begin * (width + 1) + p.x_end  ] -= 1;
        diff[p.y_end   * (width + 1) + p.x_begin] -= 1;
     295:	movsxd rdi,DWORD PTR [rax-0xc]
        diff[p.y_begin * (width + 1) + p.x_begin] += 1;
     299:	imul   rdx,r9
        diff[p.y_end   * (width + 1) + p.x_begin] -= 1;
     29d:	imul   rdi,r9
        diff[p.y_begin * (width + 1) + p.x_begin] += 1;
     2a1:	lea    rcx,[rdx+rsi*1]
     2a5:	inc    DWORD PTR [r12+rcx*4]
        diff[p.y_begin * (width + 1) + p.x_end  ] -= 1;
     2a9:	movsxd rcx,DWORD PTR [rax-0x14]
     2ad:	add    rdx,rcx
     2b0:	dec    DWORD PTR [r12+rdx*4]
        diff[p.y_end   * (width + 1) + p.x_begin] -= 1;
     2b4:	lea    rdx,[rsi+rdi*1]
     2b8:	dec    DWORD PTR [r12+rdx*4]
        diff[p.y_end   * (width + 1) + p.x_end  ] += 1;
     2bc:	lea    rdx,[rcx+rdi*1]
     2c0:	inc    DWORD PTR [r12+rdx*4]
    for (const auto& p : params) {
     2c4:	cmp    rax,QWORD PTR [rsp+0x80]
     2cc:	jne    289 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x289>
    }

    for (int y = 0; y < h; ++y) {
     2ce:	test   r13d,r13d
     2d1:	jle    388 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x388>
     2d7:	mov    r8d,DWORD PTR [rsp+0x4c]
     2dc:	test   r8d,r8d
     2df:	jle    388 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x388>
        int row = 0;
        for (int x = 0; x < w; ++x) {
     2e5:	mov    rax,QWORD PTR [rsp+0x90]
        int row = 0;
     2ed:	xor    esi,esi
     2ef:	lea    edx,[rax-0x1]
    for (int y = 0; y < h; ++y) {
     2f2:	xor    eax,eax
     2f4:	lea    r11,[rdx+0x1]
            row += diff[y * (width + 1) + x];
            counts[y * w + x] = row + (y > 0 ? counts[(y - 1) * w + x] : 0);
     2f8:	mov    rdi,QWORD PTR [rsp+0x40]
            row += diff[y * (width + 1) + x];
     2fd:	add    esi,DWORD PTR [r12+rax*4]
            counts[y * w + x] = row + (y > 0 ? counts[(y - 1) * w + x] : 0);
     301:	mov    DWORD PTR [rdi+rax*4],esi
        for (int x = 0; x < w; ++x) {
     304:	inc    rax
     307:	cmp    rax,r11
     30a:	jne    2f8 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x2f8>
    for (int y = 0; y < h; ++y) {
     30c:	cmp    r13d,0x1
     310:	je     388 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x388>
     312:	mov    eax,DWORD PTR [rsp+0x4c]
     316:	shl    r9,0x2
        for (int x = 0; x < w; ++x) {
     31a:	xor    r10d,r10d
    for (int y = 0; y < h; ++y) {
     31d:	mov    edx,0x1
     322:	lea    rsi,[r12+r9*1]
     326:	lea    r8,[rax*4+0x0]
     32e:	lea    rcx,[rdi+r8*1]
        for (int x = 0; x < w; ++x) {
     332:	mov    rdi,QWORD PTR [rsp+0x40]
     337:	movsxd rax,r10d
     33a:	add    r10d,DWORD PTR [rsp+0x90]
        int row = 0;
     342:	mov    DWORD PTR [rsp+0xe8],edx
     349:	lea    rax,[rdi+rax*4]
     34d:	xor    edi,edi
     34f:	mov    QWORD PTR [rsp+0xf0],rax
    for (int y = 0; y < h; ++y) {
     357:	xor    eax,eax
            counts[y * w + x] = row + (y > 0 ? counts[(y - 1) * w + x] : 0);
     359:	mov    rdx,QWORD PTR [rsp+0xf0]
            row += diff[y * (width + 1) + x];
     361:	add    edi,DWORD PTR [rsi+rax*4]
            counts[y * w + x] = row + (y > 0 ? counts[(y - 1) * w + x] : 0);
     364:	mov    edx,DWORD PTR [rdx+rax*4]
     367:	add    edx,edi
     369:	mov    DWORD PTR [rcx+rax*4],edx
        for (int x = 0; x < w; ++x) {
     36c:	inc    rax
     36f:	cmp    rax,r11
     372:	jne    359 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x359>
    for (int y = 0; y < h; ++y) {
     374:	mov    edx,DWORD PTR [rsp+0xe8]
     37b:	add    rsi,r9
     37e:	add    rcx,r8
     381:	inc    edx
     383:	cmp    r13d,edx
     386:	jg     332 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x332>
     388:	mov    edi,0x6000
     38d:	call   392 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x392>
     392:	mov    DWORD PTR [rax],0x0
      typedef typename __gnu_cxx::__conditional_type<__load_outside_loop,
						     const _Tp,
						     const _Tp&>::__type _Up;
      _Up __val(__value);
      for (; __first != __last; ++__first)
	*__first = __val;
     398:	xor    esi,esi
	  if (__n > 0)
	    {
	      typename iterator_traits<_ForwardIterator>::value_type* __val
		= std::addressof(*__first);
	      std::_Construct(__val);
	      ++__first;
     39a:	lea    rdi,[rax+0x4]
     39e:	mov    edx,0x5ffc
     3a3:	mov    QWORD PTR [rsp+0x28],rax
     3a8:	call   3ad <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x3ad>
    const int TILE_W = 256;

    // Per-tile vals accumulator
    std::vector<float> tile_vals(TILE_H * TILE_W * 3);

    for (int ty = 0; ty < h; ty += TILE_H) {
     3ad:	test   r13d,r13d
     3b0:	jle    12dd <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x12dd>
     3b6:	mov    edi,DWORD PTR [rsp+0x4c]
     3ba:	test   edi,edi
     3bc:	jle    12dd <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x12dd>
                const __m256 Cvx = _mm256_set1_ps(p.C);
                const __m256 Dvx = _mm256_set1_ps(p.D);

                for (int y = y_begin; y < y_end; ++y) {
                    size_t ind_ltop = ((y + p.sy) * width + (x_begin + p.sx)) * 3;
                    size_t ind_lbot = ind_ltop + width * 3;
     3c2:	mov    rdi,QWORD PTR [rsp+0x90]
                    int c = counts[y * width + (tx + x)];
                    if (c == 0) {
                        outp[x*3] = outp[x*3+1] = outp[x*3+2] = 0;
                        continue;
                    }
                    float inv_c = 1.0f / static_cast<float>(c);
     3ca:	vmovss xmm23,DWORD PTR [rip+0x0]        # 3d4 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x3d4>
     3d4:	mov    QWORD PTR [rsp+0x20],r14
     3d9:	vxorps xmm5,xmm5,xmm5
     3dd:	mov    r8,QWORD PTR [rsp+0x28]
     3e2:	mov    QWORD PTR [rsp+0x18],rbx
                    size_t ind_lbot = ind_ltop + width * 3;
     3e7:	xor    edx,edx
                    float inv_c = 1.0f / static_cast<float>(c);
     3e9:	xor    ebx,ebx
                    size_t ind_lbot = ind_ltop + width * 3;
     3eb:	lea    rcx,[rdi+rdi*2]
     3ef:	lea    rax,[rdi*8+0x0]
     3f7:	lea    rdi,[rcx+0x3]
     3fb:	mov    QWORD PTR [rsp+0xb8],rcx
                    float inv_c = 1.0f / static_cast<float>(c);
     403:	mov    r14,rax
     406:	mov    QWORD PTR [rsp+0xb0],rdi
        const int tile_y_end = std::min(ty + TILE_H, h);
     40e:	mov    r15d,ebx
     411:	add    ebx,0x8
      if (__b < __a)
     414:	mov    eax,r13d
        const int tile_h_actual = tile_y_end - ty;
     417:	mov    QWORD PTR [rsp+0x88],0x0
     423:	cmp    ebx,r13d
     426:	mov    DWORD PTR [rsp+0x14],r13d
     42b:	cmovle eax,ebx
     42e:	mov    DWORD PTR [rsp+0x10],ebx
     432:	mov    QWORD PTR [rsp+0x30],rdx
     437:	mov    DWORD PTR [rsp+0xa8],eax
     43e:	sub    eax,r15d
     441:	mov    DWORD PTR [rsp+0x48],eax
     445:	mov    QWORD PTR [rsp+0x8],r14
     44a:	mov    QWORD PTR [rsp],r12
            const int tile_x_end = std::min(tx + TILE_W, w);
     44e:	mov    eax,DWORD PTR [rsp+0x88]
     455:	mov    ecx,DWORD PTR [rsp+0x4c]
     459:	mov    ebx,DWORD PTR [rsp+0x88]
     460:	add    eax,0x100
     465:	cmp    eax,ecx
     467:	cmovg  eax,ecx
            const int tile_w_actual = tile_x_end - tx;
     46a:	mov    r13d,eax
     46d:	mov    r12d,eax
                      tile_vals.begin() + tile_h_actual * tile_w_actual * 3,
     470:	mov    eax,DWORD PTR [rsp+0x48]
            const int tile_w_actual = tile_x_end - tx;
     474:	sub    r13d,DWORD PTR [rsp+0x88]
                      tile_vals.begin() + tile_h_actual * tile_w_actual * 3,
     47c:	imul   eax,r13d
     480:	lea    edx,[rax+rax*2]

      _GLIBCXX_NODISCARD __attribute__((__always_inline__))
      _GLIBCXX_CONSTEXPR
      __normal_iterator
      operator+(difference_type __n) const _GLIBCXX_NOEXCEPT
      { return __normal_iterator(_M_current + __n); }
     483:	movsxd rdx,edx
      for (; __first != __last; ++__first)
     486:	shl    rdx,0x2
     48a:	je     4b8 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x4b8>
     48c:	vmovaps XMMWORD PTR [rsp+0xf0],xmm5
	*__first = __val;
     495:	xor    esi,esi
     497:	mov    rdi,r8
     49a:	vzeroupper
     49d:	call   4a2 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x4a2>
     4a2:	vmovaps xmm5,XMMWORD PTR [rsp+0xf0]
     4ab:	vmovss xmm23,DWORD PTR [rip+0x0]        # 4b5 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x4b5>
     4b5:	mov    r8,rax
            for (const SubParams& p : params) {
     4b8:	mov    rax,QWORD PTR [rsp+0x50]
     4bd:	cmp    rax,QWORD PTR [rsp+0x80]
     4c5:	je     116a <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x116a>
     4cb:	mov    r14,rax
     4ce:	lea    eax,[r13+r13*2+0x0]
     4d3:	mov    DWORD PTR [rsp+0x60],r13d
     4d8:	mov    r11d,r15d
     4db:	cdqe
     4dd:	mov    QWORD PTR [rsp+0x58],r8
     4e2:	mov    r8d,DWORD PTR [rsp+0xa8]
     4ea:	mov    r15,r14
     4ed:	shl    rax,0x2
     4f1:	mov    QWORD PTR [rsp+0xc0],rax
     4f9:	nop    DWORD PTR [rax+0x0]
      if (__a < __b)
     500:	mov    eax,DWORD PTR [r15+0x20]
      if (__b < __a)
     504:	mov    edx,DWORD PTR [r15+0x1c]
      if (__a < __b)
     508:	cmp    r11d,eax
     50b:	mov    edi,eax
      if (__b < __a)
     50d:	mov    eax,DWORD PTR [r15+0x24]
      if (__a < __b)
     511:	cmovge edi,r11d
      if (__b < __a)
     515:	cmp    r8d,eax
     518:	cmovle eax,r8d
      if (__a < __b)
     51c:	mov    DWORD PTR [rsp+0xf0],edi
      if (__b < __a)
     523:	mov    DWORD PTR [rsp+0xd0],eax
     52a:	mov    ecx,eax
      if (__a < __b)
     52c:	mov    eax,DWORD PTR [r15+0x18]
     530:	cmp    ebx,eax
     532:	cmovge eax,ebx
      if (__b < __a)
     535:	cmp    r12d,edx
     538:	cmovle edx,r12d
                if (x_begin >= x_end || y_begin >= y_end) continue;
     53c:	cmp    eax,edx
     53e:	jge    114b <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x114b>
     544:	mov    r14d,edi
     547:	cmp    ecx,edi
     549:	jle    114b <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x114b>
                                + (x_begin - tx) * 3;
     54f:	mov    ecx,eax
                    const int x_stop = (x_end - tx) * 3;
     551:	sub    edx,ebx
     553:	mov    esi,edi
                    size_t ind_ltop = ((y + p.sy) * width + (x_begin + p.sx)) * 3;
     555:	add    eax,DWORD PTR [r15]
                                + (x_begin - tx) * 3;
     558:	sub    ecx,ebx
                    const int x_stop = (x_end - tx) * 3;
     55a:	lea    r10d,[rdx+rdx*2]
                    size_t ind_ltop = ((y + p.sy) * width + (x_begin + p.sx)) * 3;
     55e:	cdqe
                const __m256 Avx = _mm256_set1_ps(p.A);
     560:	vmovss xmm18,DWORD PTR [r15+0x8]
                                + (x_begin - tx) * 3;
     567:	lea    r9d,[rcx+rcx*2]
     56b:	movsxd rcx,ecx
                const __m256 Bvx = _mm256_set1_ps(p.B);
     56e:	vmovss xmm17,DWORD PTR [r15+0xc]
                const __m256 Cvx = _mm256_set1_ps(p.C);
     575:	vmovss xmm16,DWORD PTR [r15+0x10]
                    for (; x + 16 <= x_stop; x += 16) {
     57c:	lea    edx,[r9+0xf]
                const __m256 Dvx = _mm256_set1_ps(p.D);
     580:	vmovss xmm15,DWORD PTR [r15+0x14]
                                + (x_begin - tx) * 3;
     586:	mov    DWORD PTR [rsp+0x74],r9d
                const __m256 Avx = _mm256_set1_ps(p.A);
     58b:	vbroadcastss ymm11,xmm18
                    for (; x + 16 <= x_stop; x += 16) {
     591:	mov    DWORD PTR [rsp+0xc8],edx
     598:	movsxd rdx,DWORD PTR [r15+0x4]
                const __m256 Bvx = _mm256_set1_ps(p.B);
     59c:	vbroadcastss ymm12,xmm17
                const __m256 Cvx = _mm256_set1_ps(p.C);
     5a2:	vbroadcastss ymm13,xmm16
                    const int x_stop = (x_end - tx) * 3;
     5a8:	mov    DWORD PTR [rsp+0xe8],r10d
                const __m256 Dvx = _mm256_set1_ps(p.D);
     5b0:	vbroadcastss ymm10,xmm15
/* Create a vector with all elements equal to A.  */
extern __inline __m256 __attribute__((__gnu_inline__, __always_inline__, __artificial__))
_mm256_set1_ps (float __A)
{
  return __extension__ (__m256){ __A, __A, __A, __A,
				 __A, __A, __A, __A };
     5b5:	vmovaps ymm3,ymm11
     5b9:	vmovaps ymm2,ymm12
  return __extension__ (__m256){ __A, __A, __A, __A,
     5bd:	add    rdx,rsi
     5c0:	mov    DWORD PTR [rsp+0x70],r12d
				 __A, __A, __A, __A };
     5c5:	vmovaps ymm1,ymm13
     5c9:	vmovaps ymm0,ymm10
                for (int y = y_begin; y < y_end; ++y) {
     5cd:	imul   rdx,QWORD PTR [rsp+0x90]
     5d6:	mov    QWORD PTR [rsp+0xe0],r15
     5de:	mov    DWORD PTR [rsp+0x6c],r8d
     5e3:	mov    DWORD PTR [rsp+0x68],ebx
     5e7:	add    rdx,rax
     5ea:	mov    eax,r14d
     5ed:	mov    DWORD PTR [rsp+0x64],r11d
     5f2:	sub    eax,r11d
     5f5:	lea    rdi,[rdx+rdx*2]
     5f9:	imul   eax,DWORD PTR [rsp+0x60]
     5fe:	cdqe
     600:	add    rax,rcx
     603:	mov    rcx,QWORD PTR [rsp+0x58]
     608:	lea    rax,[rax+rax*2]
     60c:	lea    rax,[rcx+rax*4]
     610:	mov    QWORD PTR [rsp+0xd8],rax
     618:	lea    eax,[r10-0x10]
     61c:	sub    eax,r9d
     61f:	mov    edx,eax
     621:	shr    eax,0x4
     624:	and    edx,0xfffffff0
     627:	inc    rax
     62a:	lea    ecx,[r9+rdx*1+0x10]
     62f:	mov    DWORD PTR [rsp+0xac],ecx
     636:	mov    rcx,rax
     639:	shl    rax,0x4
     63d:	shl    rcx,0x6
     641:	mov    QWORD PTR [rsp+0x98],rax
     649:	mov    QWORD PTR [rsp+0xa0],rcx
     651:	nop    DWORD PTR [rax+0x0]
                    size_t ind_rbot = ind_lbot + 3;
     658:	mov    rax,QWORD PTR [rsp+0xb0]
                                + (x_begin - tx) * 3;
     660:	mov    rbx,QWORD PTR [rsp+0xd8]
     668:	mov    rdx,rdi
                    for (; x + 16 <= x_stop; x += 16) {
     66b:	mov    r15d,DWORD PTR [rsp+0xe8]
                    size_t ind_lbot = ind_ltop + width * 3;
     673:	add    rdi,QWORD PTR [rsp+0xb8]
                    size_t ind_rtop = ind_ltop + 3;
     67b:	lea    rcx,[rdx+0x3]
                    size_t ind_rbot = ind_lbot + 3;
     67f:	lea    r12,[rax+rdx*1]
                                + (x_begin - tx) * 3;
     683:	mov    rax,rbx
                    for (; x + 16 <= x_stop; x += 16) {
     686:	cmp    DWORD PTR [rsp+0xc8],r15d
     68e:	jge    13a8 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x13a8>
     694:	mov    r15,QWORD PTR [rsp+0xe0]
     69c:	mov    rsi,QWORD PTR [r15+0x28]
     6a0:	mov    r15,QWORD PTR [rsp+0xa0]
     6a8:	add    rsi,rdi
     6ab:	lea    r9,[rbx+r15*1]
     6af:	nop
}

extern __inline __m128i __attribute__((__gnu_inline__, __always_inline__, __artificial__))
_mm_loadl_epi64 (__m128i_u const *__P)
{
  return _mm_set_epi64 ((__m64)0LL, *(__m64_u *)__P);
     6b0:	mov    r8,rsi

extern __inline __m256i
__attribute__ ((__gnu_inline__, __always_inline__, __artificial__))
_mm256_cvtepu8_epi32 (__m128i __X)
{
  return (__m256i) __builtin_ia32_pmovzxbd256 ((__v16qi)__X);
     6b3:	vpmovzxbd ymm8,QWORD PTR [rsi]
     6b8:	vpmovzxbd ymm7,QWORD PTR [rsi+0x8]
                        vp += 16;
     6be:	add    rax,0x40
     6c2:	sub    r8,rdi
     6c5:	vpmovzxbd ymm6,QWORD PTR [rsi+0x3]
     6cb:	vpmovzxbd ymm4,QWORD PTR [rsi+0xb]
                    for (; x + 16 <= x_stop; x += 16) {
     6d1:	add    rsi,0x10
     6d5:	vpmovzxbd ymm20,QWORD PTR [r8+rdx*1]
     6dc:	vpmovzxbd ymm19,QWORD PTR [r8+rdx*1+0x8]
  return (__m256)__builtin_ia32_cvtdq2ps256 ((__v8si) __A);
     6e4:	vcvtdq2ps ymm8,ymm8
     6e9:	vcvtdq2ps ymm7,ymm7
     6ed:	vpmovzxbd ymm14,QWORD PTR [r8+rdx*1+0x3]
     6f4:	vpmovzxbd ymm9,QWORD PTR [r8+rdx*1+0xb]
     6fb:	vcvtdq2ps ymm6,ymm6
     6ff:	vcvtdq2ps ymm4,ymm4
     703:	vcvtdq2ps ymm20,ymm20
     709:	vcvtdq2ps ymm19,ymm19

extern __inline __m256
__attribute__((__gnu_inline__, __always_inline__, __artificial__))
_mm256_fmadd_ps (__m256 __A, __m256 __B, __m256 __C)
{
  return (__m256)__builtin_ia32_vfmaddps256 ((__v8sf)__A, (__v8sf)__B,
     70f:	vfmadd213ps ymm20,ymm3,YMMWORD PTR [rax-0x40]
     716:	vfmadd213ps ymm19,ymm3,YMMWORD PTR [rax-0x20]
     71d:	vcvtdq2ps ymm14,ymm14
     722:	vcvtdq2ps ymm9,ymm9
     727:	vfmadd132ps ymm14,ymm20,ymm2
     72d:	vfmadd132ps ymm9,ymm19,ymm2
     733:	vfmadd132ps ymm8,ymm14,ymm1
     738:	vfmadd132ps ymm7,ymm9,ymm1
     73d:	vfmadd132ps ymm6,ymm8,ymm0
     742:	vfmadd132ps ymm4,ymm7,ymm0
  *(__m256_u *)__P = __A;
     747:	vmovups YMMWORD PTR [rax-0x40],ymm6
     74c:	vmovups YMMWORD PTR [rax-0x20],ymm4
     751:	cmp    rax,r9
     754:	jne    6b0 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x6b0>
     75a:	mov    rbx,QWORD PTR [rsp+0x98]
     762:	mov    r8d,DWORD PTR [rsp+0xac]
     76a:	add    r12,rbx
     76d:	add    rcx,rbx
     770:	lea    rsi,[rdi+rbx*1]
     774:	add    rdx,rbx
                    if(x + 8 <= x_stop) {
     777:	lea    r9d,[r8+0x7]
     77b:	cmp    r9d,DWORD PTR [rsp+0xe8]
     783:	jge    7ec <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x7ec>
                        __m128i ltop_b = _mm_loadl_epi64(reinterpret_cast<const __m128i*>(p.SUB + ind_ltop));
     785:	mov    rbx,QWORD PTR [rsp+0xe0]
                        vp += 8;
     78d:	add    rax,0x20
                        x += 8;
     791:	add    r8d,0x8
                        __m128i ltop_b = _mm_loadl_epi64(reinterpret_cast<const __m128i*>(p.SUB + ind_ltop));
     795:	mov    r9,QWORD PTR [rbx+0x28]
     799:	vpmovzxbd ymm8,QWORD PTR [r9+rdx*1]
     79f:	vpmovzxbd ymm7,QWORD PTR [r9+rcx*1]
                        ind_ltop += 8; ind_lbot += 8;
     7a5:	add    rdx,0x8
                        ind_rtop += 8; ind_rbot += 8;
     7a9:	add    rcx,0x8
     7ad:	vpmovzxbd ymm6,QWORD PTR [r9+rsi*1]
     7b3:	vpmovzxbd ymm4,QWORD PTR [r9+r12*1]
                        ind_ltop += 8; ind_lbot += 8;
     7b9:	add    rsi,0x8
                        ind_rtop += 8; ind_rbot += 8;
     7bd:	add    r12,0x8
  return (__m256)__builtin_ia32_cvtdq2ps256 ((__v8si) __A);
     7c1:	vcvtdq2ps ymm8,ymm8
     7c6:	vfmadd213ps ymm8,ymm3,YMMWORD PTR [rax-0x20]
     7cc:	vcvtdq2ps ymm7,ymm7
     7d0:	vcvtdq2ps ymm6,ymm6
     7d4:	vcvtdq2ps ymm4,ymm4
     7d8:	vfmadd132ps ymm7,ymm8,ymm2
     7dd:	vfmadd132ps ymm6,ymm7,ymm1
     7e2:	vfmadd132ps ymm4,ymm6,ymm0
  *(__m256_u *)__P = __A;
     7e7:	vmovups YMMWORD PTR [rax-0x20],ymm4
                    int remaining = x_stop - x;
     7ec:	mov    ebx,DWORD PTR [rsp+0xe8]
     7f3:	sub    ebx,r8d
                    for (int k = 0; k < remaining; ++k) {
     7f6:	test   ebx,ebx
     7f8:	jle    1105 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x1105>
                        float TL = p.SUB[ind_ltop + k];
     7fe:	mov    r15,QWORD PTR [rsp+0xe0]
     806:	lea    r9d,[rbx-0x1]
     80a:	mov    r8,QWORD PTR [r15+0x28]
     80e:	cmp    r9d,0x1e
     812:	jbe    13b5 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x13b5>
     818:	mov    r11d,ebx
     81b:	lea    r14,[r8+r12*1]
     81f:	add    rsi,r8
     822:	add    rcx,r8
     825:	shr    r11d,0x5
     829:	add    rdx,r8
     82c:	mov    r9,rax
     82f:	xor    r10d,r10d
     832:	mov    r13d,r11d
     835:	shl    r13,0x5
     839:	nop    DWORD PTR [rax+0x0]
                        float BL = p.SUB[ind_lbot + k];
     840:	vmovdqu ymm8,YMMWORD PTR [rsi+r10*1]
                        float TR = p.SUB[ind_rtop + k];
     846:	vmovdqu ymm4,YMMWORD PTR [rcx+r10*1]
     84c:	sub    r9,0xffffffffffffff80
                        float TL = p.SUB[ind_ltop + k];
     850:	vmovdqu ymm7,YMMWORD PTR [rdx+r10*1]
                        float BL = p.SUB[ind_lbot + k];
     856:	vpmovzxbw ymm6,xmm8
                        float TR = p.SUB[ind_rtop + k];
     85b:	vpmovzxbw ymm9,xmm4
                        float BL = p.SUB[ind_lbot + k];
     860:	vextracti32x4 xmm8,ymm8,0x1
     867:	vpmovsxwd ymm19,xmm6
     86d:	vextracti32x4 xmm6,ymm6,0x1
                        float TR = p.SUB[ind_rtop + k];
     874:	vpmovsxwd ymm14,xmm9
                        float BL = p.SUB[ind_lbot + k];
     879:	vpmovsxwd ymm6,xmm6
                        float TR = p.SUB[ind_rtop + k];
     87e:	vextracti32x4 xmm9,ymm9,0x1
                        float BL = p.SUB[ind_lbot + k];
     885:	vpmovzxbw ymm8,xmm8
     88a:	vcvtdq2ps ymm19,ymm19
                        float TR = p.SUB[ind_rtop + k];
     890:	vcvtdq2ps ymm14,ymm14
                        float BL = p.SUB[ind_lbot + k];
     895:	vcvtdq2ps ymm6,ymm6
                        vp[k] += p.A*TL + p.B*TR + p.C*BL + p.D*BR;
     899:	vmulps ymm6,ymm6,ymm1
                        float TR = p.SUB[ind_rtop + k];
     89d:	vpmovsxwd ymm9,xmm9
                        float BL = p.SUB[ind_lbot + k];
     8a2:	vextracti32x4 xmm20,ymm8,0x1
                        vp[k] += p.A*TL + p.B*TR + p.C*BL + p.D*BR;
     8a9:	vmulps ymm19,ymm19,ymm1
                        float TR = p.SUB[ind_rtop + k];
     8af:	vcvtdq2ps ymm9,ymm9
                        float TL = p.SUB[ind_ltop + k];
     8b4:	vpmovzxbw ymm22,xmm7
                        float TR = p.SUB[ind_rtop + k];
     8ba:	vextracti32x4 xmm4,ymm4,0x1
                        float BL = p.SUB[ind_lbot + k];
     8c1:	vpmovsxwd ymm20,xmm20
                        float TR = p.SUB[ind_rtop + k];
     8c7:	vpmovzxbw ymm4,xmm4
                        float TL = p.SUB[ind_ltop + k];
     8cc:	vextracti32x4 xmm7,ymm7,0x1
                        float BL = p.SUB[ind_lbot + k];
     8d3:	vcvtdq2ps ymm20,ymm20
                        vp[k] += p.A*TL + p.B*TR + p.C*BL + p.D*BR;
     8d9:	vmulps ymm20,ymm20,ymm1
                        float TL = p.SUB[ind_ltop + k];
     8df:	vpmovzxbw ymm7,xmm7
                        float BL = p.SUB[ind_lbot + k];
     8e4:	vfmadd132ps ymm9,ymm6,ymm2
     8e9:	vpmovsxwd ymm6,xmm8
                        float TL = p.SUB[ind_ltop + k];
     8ee:	vpmovsxwd ymm8,xmm22
                        float BL = p.SUB[ind_lbot + k];
     8f4:	vcvtdq2ps ymm6,ymm6
                        vp[k] += p.A*TL + p.B*TR + p.C*BL + p.D*BR;
     8f8:	vmulps ymm6,ymm6,ymm1
     8fc:	vfmadd132ps ymm14,ymm19,ymm2
                        float TL = p.SUB[ind_ltop + k];
     902:	vcvtdq2ps ymm8,ymm8
                        float TR = p.SUB[ind_rtop + k];
     907:	vpmovsxwd ymm19,xmm4
     90d:	vfmadd213ps ymm8,ymm3,YMMWORD PTR [r9-0x80]
     913:	vcvtdq2ps ymm19,ymm19
     919:	vfmadd132ps ymm19,ymm6,ymm2
     91f:	vextracti32x4 xmm6,ymm4,0x1
                        float BR = p.SUB[ind_rbot + k];
     926:	vmovdqu ymm4,YMMWORD PTR [r14+r10*1]
     92c:	add    r10,0x20
                        float TR = p.SUB[ind_rtop + k];
     930:	vpmovsxwd ymm6,xmm6
                        float BR = p.SUB[ind_rbot + k];
     935:	vpmovzxbw ymm21,xmm4
                        float TR = p.SUB[ind_rtop + k];
     93b:	vcvtdq2ps ymm6,ymm6
     93f:	vfmadd132ps ymm6,ymm20,ymm2
                        float BR = p.SUB[ind_rbot + k];
     945:	vextracti32x4 xmm4,ymm4,0x1
     94c:	vpmovsxwd ymm20,xmm21
     952:	vextracti32x4 xmm21,ymm21,0x1
     959:	vpmovzxbw ymm4,xmm4
     95e:	vcvtdq2ps ymm20,ymm20
     964:	vfmadd132ps ymm20,ymm8,ymm0
                        float TL = p.SUB[ind_ltop + k];
     96a:	vextracti32x4 xmm8,ymm22,0x1
                        float BR = p.SUB[ind_rbot + k];
     971:	vpmovsxwd ymm21,xmm21
                        float TL = p.SUB[ind_ltop + k];
     977:	vpmovsxwd ymm8,xmm8
                        float BR = p.SUB[ind_rbot + k];
     97c:	vcvtdq2ps ymm21,ymm21
     982:	vpmovsxwd ymm22,xmm4
     988:	vextracti32x4 xmm4,ymm4,0x1
                        float TL = p.SUB[ind_ltop + k];
     98f:	vcvtdq2ps ymm8,ymm8
     994:	vfmadd213ps ymm8,ymm3,YMMWORD PTR [r9-0x60]
                        float BR = p.SUB[ind_rbot + k];
     99a:	vpmovsxwd ymm4,xmm4
     99f:	vcvtdq2ps ymm22,ymm22
     9a5:	vcvtdq2ps ymm4,ymm4
                        vp[k] += p.A*TL + p.B*TR + p.C*BL + p.D*BR;
     9a9:	vaddps ymm14,ymm14,ymm20
     9af:	vfmadd132ps ymm21,ymm8,ymm0
                        float TL = p.SUB[ind_ltop + k];
     9b5:	vpmovsxwd ymm8,xmm7
     9ba:	vextracti32x4 xmm7,ymm7,0x1
     9c1:	vpmovsxwd ymm7,xmm7
     9c6:	vcvtdq2ps ymm8,ymm8
     9cb:	vfmadd213ps ymm8,ymm3,YMMWORD PTR [r9-0x40]
                        vp[k] += p.A*TL + p.B*TR + p.C*BL + p.D*BR;
     9d1:	vmovups YMMWORD PTR [r9-0x80],ymm14
                        float TL = p.SUB[ind_ltop + k];
     9d7:	vcvtdq2ps ymm7,ymm7
                        vp[k] += p.A*TL + p.B*TR + p.C*BL + p.D*BR;
     9db:	vfmadd213ps ymm7,ymm3,YMMWORD PTR [r9-0x20]
     9e1:	vaddps ymm9,ymm9,ymm21
     9e7:	vfmadd132ps ymm22,ymm8,ymm0
     9ed:	vfmadd132ps ymm4,ymm7,ymm0
     9f2:	vmovups YMMWORD PTR [r9-0x60],ymm9
     9f8:	vaddps ymm22,ymm22,ymm19
     9fe:	vaddps ymm4,ymm4,ymm6
     a02:	vmovups YMMWORD PTR [r9-0x40],ymm22
     a09:	vmovups YMMWORD PTR [r9-0x20],ymm4
                    for (int k = 0; k < remaining; ++k) {
     a0f:	cmp    r13,r10
     a12:	jne    840 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x840>
     a18:	shl    r11d,0x5
     a1c:	cmp    r11d,ebx
     a1f:	je     1105 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x1105>
     a25:	mov    r14d,ebx
     a28:	mov    r9d,r11d
     a2b:	sub    r14d,r11d
     a2e:	lea    r10d,[r14-0x1]
     a32:	cmp    r10d,0xe
     a36:	jbe    13d8 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x13d8>
     a3c:	mov    r13d,r11d
                        float BL = p.SUB[ind_lbot + k];
     a3f:	vmovdqu xmm8,XMMWORD PTR [rsi+r13*1]
                        float TR = p.SUB[ind_rtop + k];
     a45:	vmovdqu xmm4,XMMWORD PTR [rcx+r13*1]
     a4b:	lea    r10,[rax+r13*4]
                        float TL = p.SUB[ind_ltop + k];
     a4f:	lea    r15,[r12+r13*1]
     a53:	vmovdqu xmm7,XMMWORD PTR [rdx+r13*1]
                        float BL = p.SUB[ind_lbot + k];
     a59:	vpmovzxbw xmm6,xmm8
     a5e:	vpsrldq xmm8,xmm8,0x8
                        float TR = p.SUB[ind_rtop + k];
     a64:	vpmovzxbw xmm9,xmm4
                        float BL = p.SUB[ind_lbot + k];
     a69:	vpmovsxwd xmm14,xmm6
     a6e:	vpsrldq xmm6,xmm6,0x8
                        float TR = p.SUB[ind_rtop + k];
     a73:	vpmovsxwd xmm19,xmm9
                        float BL = p.SUB[ind_lbot + k];
     a79:	vpmovsxwd xmm6,xmm6
                        float TR = p.SUB[ind_rtop + k];
     a7e:	vpsrldq xmm9,xmm9,0x8
                        float BL = p.SUB[ind_lbot + k];
     a84:	vpmovzxbw xmm8,xmm8
     a89:	vcvtdq2ps xmm14,xmm14
                        float TR = p.SUB[ind_rtop + k];
     a8e:	vcvtdq2ps xmm19,xmm19
                        float BL = p.SUB[ind_lbot + k];
     a94:	vcvtdq2ps xmm6,xmm6
                        vp[k] += p.A*TL + p.B*TR + p.C*BL + p.D*BR;
     a98:	vmulps xmm6,xmm6,xmm13
                        float TR = p.SUB[ind_rtop + k];
     a9d:	vpmovsxwd xmm9,xmm9
                        float TL = p.SUB[ind_ltop + k];
     aa2:	vpmovzxbw xmm21,xmm7
                        vp[k] += p.A*TL + p.B*TR + p.C*BL + p.D*BR;
     aa8:	vmulps xmm14,xmm14,xmm13
                        float TR = p.SUB[ind_rtop + k];
     aad:	vcvtdq2ps xmm9,xmm9
                        float BL = p.SUB[ind_lbot + k];
     ab2:	vpsrldq xmm20,xmm8,0x8
                        float TL = p.SUB[ind_ltop + k];
     ab9:	vpmovsxwd xmm22,xmm21
                        float TR = p.SUB[ind_rtop + k];
     abf:	vpsrldq xmm4,xmm4,0x8
                        float TL = p.SUB[ind_ltop + k];
     ac4:	vcvtdq2ps xmm22,xmm22
     aca:	vfmadd213ps xmm22,xmm11,XMMWORD PTR [r10]
                        float BL = p.SUB[ind_lbot + k];
     ad0:	vpmovsxwd xmm20,xmm20
                        float TR = p.SUB[ind_rtop + k];
     ad6:	vpmovzxbw xmm4,xmm4
                        float BL = p.SUB[ind_lbot + k];
     adb:	vcvtdq2ps xmm20,xmm20
                        float TL = p.SUB[ind_ltop + k];
     ae1:	vpsrldq xmm7,xmm7,0x8
                        vp[k] += p.A*TL + p.B*TR + p.C*BL + p.D*BR;
     ae6:	vmulps xmm20,xmm20,xmm13
                        float TL = p.SUB[ind_ltop + k];
     aec:	vpmovzxbw xmm7,xmm7
                        float BL = p.SUB[ind_lbot + k];
     af1:	vfmadd132ps xmm9,xmm6,xmm12
     af6:	vpmovsxwd xmm6,xmm8
     afb:	vcvtdq2ps xmm6,xmm6
                        vp[k] += p.A*TL + p.B*TR + p.C*BL + p.D*BR;
     aff:	vmulps xmm6,xmm6,xmm13
     b04:	vfmadd132ps xmm19,xmm14,xmm12
                        float TR = p.SUB[ind_rtop + k];
     b0a:	vpmovsxwd xmm14,xmm4
     b0f:	vcvtdq2ps xmm14,xmm14
     b14:	vfmadd132ps xmm14,xmm6,xmm12
     b19:	vpsrldq xmm6,xmm4,0x8
                        float BR = p.SUB[ind_rbot + k];
     b1e:	vmovdqu xmm4,XMMWORD PTR [r8+r15*1]
                        float TR = p.SUB[ind_rtop + k];
     b24:	vpmovsxwd xmm6,xmm6
                        float BR = p.SUB[ind_rbot + k];
     b29:	vpmovzxbw xmm8,xmm4
                        float TR = p.SUB[ind_rtop + k];
     b2e:	vcvtdq2ps xmm6,xmm6
     b32:	vfmadd132ps xmm6,xmm20,xmm12
                        float BR = p.SUB[ind_rbot + k];
     b38:	vpmovsxwd xmm20,xmm8
     b3e:	vpsrldq xmm4,xmm4,0x8
     b43:	vcvtdq2ps xmm20,xmm20
     b49:	vfmadd132ps xmm20,xmm22,xmm10
     b4f:	vpsrldq xmm22,xmm8,0x8
     b56:	vpmovzxbw xmm4,xmm4
                        float TL = p.SUB[ind_ltop + k];
     b5b:	vpsrldq xmm8,xmm21,0x8
     b62:	vpmovsxwd xmm21,xmm7
                        float BR = p.SUB[ind_rbot + k];
     b68:	vpmovsxwd xmm22,xmm22
                        float TL = p.SUB[ind_ltop + k];
     b6e:	vpmovsxwd xmm8,xmm8
     b73:	vpsrldq xmm7,xmm7,0x8
     b78:	vcvtdq2ps xmm21,xmm21
                        float BR = p.SUB[ind_rbot + k];
     b7e:	vcvtdq2ps xmm22,xmm22
                        float TL = p.SUB[ind_ltop + k];
     b84:	vcvtdq2ps xmm8,xmm8
     b89:	vfmadd213ps xmm8,xmm11,XMMWORD PTR [r10+0x10]
     b8f:	vfmadd213ps xmm21,xmm11,XMMWORD PTR [r10+0x20]
     b96:	vpmovsxwd xmm7,xmm7
     b9b:	vcvtdq2ps xmm7,xmm7
                        vp[k] += p.A*TL + p.B*TR + p.C*BL + p.D*BR;
     b9f:	vfmadd213ps xmm7,xmm11,XMMWORD PTR [r10+0x30]
     ba5:	vaddps xmm19,xmm19,xmm20
     bab:	vfmadd132ps xmm22,xmm8,xmm10
                        float BR = p.SUB[ind_rbot + k];
     bb1:	vpmovsxwd xmm8,xmm4
                        vp[k] += p.A*TL + p.B*TR + p.C*BL + p.D*BR;
     bb6:	vmovups XMMWORD PTR [r10],xmm19
                        float BR = p.SUB[ind_rbot + k];
     bbc:	vpsrldq xmm4,xmm4,0x8
     bc1:	vcvtdq2ps xmm8,xmm8
     bc6:	vfmadd132ps xmm8,xmm21,xmm10
     bcc:	vpmovsxwd xmm4,xmm4
     bd1:	vcvtdq2ps xmm4,xmm4
                        vp[k] += p.A*TL + p.B*TR + p.C*BL + p.D*BR;
     bd5:	vfmadd132ps xmm4,xmm7,xmm10
     bda:	vaddps xmm9,xmm9,xmm22
     be0:	vaddps xmm14,xmm14,xmm8
     be5:	vaddps xmm4,xmm4,xmm6
     be9:	vmovups XMMWORD PTR [r10+0x10],xmm9
     bef:	vmovups XMMWORD PTR [r10+0x20],xmm14
     bf5:	vmovups XMMWORD PTR [r10+0x30],xmm4
                    for (int k = 0; k < remaining; ++k) {
     bfb:	mov    r10d,r14d
     bfe:	and    r10d,0xfffffff0
     c02:	test   r14b,0xf
     c06:	je     1105 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x1105>
     c0c:	add    r9d,r10d
     c0f:	sub    r14d,r10d
     c12:	lea    r13d,[r14-0x1]
     c16:	cmp    r13d,0x6
     c1a:	jbe    e60 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0xe60>
     c20:	add    r10d,r11d
     c23:	mov    r10d,r10d
                        float TL = p.SUB[ind_ltop + k];
     c26:	vmovq  xmm4,QWORD PTR [rdx+r10*1]
     c2c:	lea    r15,[r12+r10*1]
     c30:	lea    r13,[rax+r10*4]
     c34:	vpmovzxbw xmm7,xmm4
     c39:	vpsrlq xmm4,xmm4,0x20
     c3e:	vpmovzxbw xmm6,xmm4
                        float TR = p.SUB[ind_rtop + k];
     c43:	vmovq  xmm4,QWORD PTR [rcx+r10*1]
                        float TL = p.SUB[ind_ltop + k];
     c49:	vmovq  r11,xmm6
                        float BL = p.SUB[ind_lbot + k];
     c4e:	vmovq  xmm6,QWORD PTR [rsi+r10*1]
     c54:	mov    r10d,r14d
                        float TR = p.SUB[ind_rtop + k];
     c57:	vpmovzxbw xmm9,xmm4
     c5c:	vpsrlq xmm4,xmm4,0x20
     c61:	and    r10d,0xfffffff8
     c65:	and    r14d,0x7
     c69:	vpmovzxwd xmm14,xmm9
                        float BL = p.SUB[ind_lbot + k];
     c6e:	vpmovzxbw xmm8,xmm6
                        float TR = p.SUB[ind_rtop + k];
     c73:	vpmovzxbw xmm4,xmm4
     c78:	vpsrlq xmm9,xmm9,0x20
                        float BL = p.SUB[ind_lbot + k];
     c7e:	vpsrlq xmm6,xmm6,0x20
                        float TR = p.SUB[ind_rtop + k];
     c83:	vmovq  xmm14,xmm14
     c88:	vcvtdq2ps xmm20,xmm14
                        float BL = p.SUB[ind_lbot + k];
     c8e:	vpmovzxwd xmm14,xmm8
     c93:	vpsrlq xmm8,xmm8,0x20
                        float TR = p.SUB[ind_rtop + k];
     c99:	vpmovzxwd xmm9,xmm9
                        float BL = p.SUB[ind_lbot + k];
     c9e:	vpmovzxwd xmm8,xmm8
                        float TR = p.SUB[ind_rtop + k];
     ca3:	vmovq  xmm9,xmm9
                        float BL = p.SUB[ind_lbot + k];
     ca8:	vpmovzxbw xmm6,xmm6
     cad:	vmovq  xmm8,xmm8
                        float TR = p.SUB[ind_rtop + k];
     cb2:	vcvtdq2ps xmm9,xmm9
                        float BL = p.SUB[ind_lbot + k];
     cb7:	vmovq  xmm19,xmm14
     cbd:	vcvtdq2ps xmm8,xmm8
                        vp[k] += p.A*TL + p.B*TR + p.C*BL + p.D*BR;
     cc2:	vmulps xmm8,xmm8,xmm13
                        float BL = p.SUB[ind_lbot + k];
     cc7:	vcvtdq2ps xmm19,xmm19
                        vp[k] += p.A*TL + p.B*TR + p.C*BL + p.D*BR;
     ccd:	vmulps xmm19,xmm19,xmm13
     cd3:	vfmadd132ps xmm9,xmm8,xmm12
                        float TR = p.SUB[ind_rtop + k];
     cd8:	vpmovzxwd xmm8,xmm4
     cdd:	vmovq  xmm8,xmm8
     ce2:	vfmadd231ps xmm19,xmm20,xmm12
     ce8:	vcvtdq2ps xmm14,xmm8
     ced:	vmovaps xmm21,xmm9
                        float BL = p.SUB[ind_lbot + k];
     cf3:	vpmovzxwd xmm9,xmm6
     cf8:	vmovq  xmm9,xmm9
     cfd:	vpsrlq xmm6,xmm6,0x20
     d02:	vcvtdq2ps xmm9,xmm9
                        vp[k] += p.A*TL + p.B*TR + p.C*BL + p.D*BR;
     d07:	vmulps xmm9,xmm9,xmm13
                        float BL = p.SUB[ind_lbot + k];
     d0c:	vpmovzxwd xmm6,xmm6
     d11:	vmovq  xmm6,xmm6
     d15:	vcvtdq2ps xmm6,xmm6
                        vp[k] += p.A*TL + p.B*TR + p.C*BL + p.D*BR;
     d19:	vmulps xmm6,xmm6,xmm13
     d1e:	vfmadd132ps xmm14,xmm9,xmm12
     d23:	vmovq  xmm9,QWORD PTR [r13+0x0]
     d29:	vmovaps xmm22,xmm14
                        float TR = p.SUB[ind_rtop + k];
     d2f:	vpsrlq xmm14,xmm4,0x20
                        float BR = p.SUB[ind_rbot + k];
     d34:	vmovq  xmm4,QWORD PTR [r8+r15*1]
                        float TR = p.SUB[ind_rtop + k];
     d3a:	vpmovzxwd xmm14,xmm14
     d3f:	vmovq  xmm14,xmm14
     d44:	vcvtdq2ps xmm14,xmm14
     d49:	vfmadd132ps xmm14,xmm6,xmm12
                        float BR = p.SUB[ind_rbot + k];
     d4e:	vpmovzxbw xmm6,xmm4
     d53:	vpmovzxwd xmm8,xmm6
     d58:	vpsrlq xmm6,xmm6,0x20
     d5d:	vmovq  xmm8,xmm8
     d62:	vpsrlq xmm4,xmm4,0x20
     d67:	vpmovzxwd xmm6,xmm6
     d6c:	vcvtdq2ps xmm20,xmm8
                        float TL = p.SUB[ind_ltop + k];
     d72:	vpmovzxwd xmm8,xmm7
     d77:	vpsrlq xmm7,xmm7,0x20
                        float BR = p.SUB[ind_rbot + k];
     d7c:	vpmovzxbw xmm4,xmm4
                        float TL = p.SUB[ind_ltop + k];
     d81:	vmovq  xmm8,xmm8
     d86:	vpmovzxwd xmm7,xmm7
                        float BR = p.SUB[ind_rbot + k];
     d8b:	vmovq  xmm6,xmm6
                        float TL = p.SUB[ind_ltop + k];
     d8f:	vcvtdq2ps xmm8,xmm8
     d94:	vfmadd231ps xmm9,xmm11,xmm8
                        vp[k] += p.A*TL + p.B*TR + p.C*BL + p.D*BR;
     d99:	vmovq  xmm8,QWORD PTR [r13+0x8]
                        float TL = p.SUB[ind_ltop + k];
     d9f:	vmovq  xmm7,xmm7
                        float BR = p.SUB[ind_rbot + k];
     da3:	vcvtdq2ps xmm6,xmm6
                        float TL = p.SUB[ind_ltop + k];
     da7:	vcvtdq2ps xmm7,xmm7
     dab:	vfmadd132ps xmm7,xmm8,xmm11
     db0:	vfmadd132ps xmm20,xmm9,xmm10
     db6:	vmovq  xmm9,r11
     dbb:	vpmovzxwd xmm8,xmm9
                        vp[k] += p.A*TL + p.B*TR + p.C*BL + p.D*BR;
     dc0:	vmovq  xmm9,QWORD PTR [r13+0x10]
                        float TL = p.SUB[ind_ltop + k];
     dc6:	vmovq  xmm8,xmm8
     dcb:	vfmadd132ps xmm6,xmm7,xmm10
                        float BR = p.SUB[ind_rbot + k];
     dd0:	vpmovzxwd xmm7,xmm4
                        float TL = p.SUB[ind_ltop + k];
     dd5:	vcvtdq2ps xmm8,xmm8
     dda:	vfmadd132ps xmm8,xmm9,xmm11
                        float BR = p.SUB[ind_rbot + k];
     ddf:	vmovq  xmm7,xmm7
                        float TL = p.SUB[ind_ltop + k];
     de3:	vmovq  xmm9,r11
                        float BR = p.SUB[ind_rbot + k];
     de8:	vcvtdq2ps xmm7,xmm7
     dec:	vpsrlq xmm4,xmm4,0x20
     df1:	vpmovzxwd xmm4,xmm4
     df6:	vmovq  xmm4,xmm4
     dfa:	vcvtdq2ps xmm4,xmm4
                        vp[k] += p.A*TL + p.B*TR + p.C*BL + p.D*BR;
     dfe:	vaddps xmm6,xmm21,xmm6
     e04:	vfmadd132ps xmm7,xmm8,xmm10
                        float TL = p.SUB[ind_ltop + k];
     e09:	vpsrlq xmm8,xmm9,0x20
                        vp[k] += p.A*TL + p.B*TR + p.C*BL + p.D*BR;
     e0f:	vmovq  xmm9,QWORD PTR [r13+0x18]
                        float TL = p.SUB[ind_ltop + k];
     e15:	vpmovzxwd xmm8,xmm8
     e1a:	vmovq  xmm8,xmm8
                        vp[k] += p.A*TL + p.B*TR + p.C*BL + p.D*BR;
     e1f:	vmovlps QWORD PTR [r13+0x8],xmm6
                        float TL = p.SUB[ind_ltop + k];
     e25:	vcvtdq2ps xmm8,xmm8
                        vp[k] += p.A*TL + p.B*TR + p.C*BL + p.D*BR;
     e2a:	vfmadd132ps xmm8,xmm9,xmm11
     e2f:	vaddps xmm6,xmm22,xmm7
     e35:	vfmadd132ps xmm4,xmm8,xmm10
     e3a:	vaddps xmm8,xmm19,xmm20
     e40:	vmovlps QWORD PTR [r13+0x10],xmm6
     e46:	vmovlps QWORD PTR [r13+0x0],xmm8
     e4c:	vaddps xmm4,xmm4,xmm14
     e51:	vmovlps QWORD PTR [r13+0x18],xmm4
                    for (int k = 0; k < remaining; ++k) {
     e57:	je     1105 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x1105>
     e5d:	add    r9d,r10d
                        float TL = p.SUB[ind_ltop + k];
     e60:	movsxd r10,r9d
                        float BR = p.SUB[ind_rbot + k];
     e63:	add    r8,r12
                        float TL = p.SUB[ind_ltop + k];
     e66:	movzx  r14d,BYTE PTR [rdx+r10*1]
                        vp[k] += p.A*TL + p.B*TR + p.C*BL + p.D*BR;
     e6b:	lea    r11,[r10*4+0x0]
                        float TL = p.SUB[ind_ltop + k];
     e73:	vcvtusi2ss xmm4,xmm5,r14d
                        float TR = p.SUB[ind_rtop + k];
     e79:	movzx  r14d,BYTE PTR [rcx+r10*1]
     e7e:	vmovaps xmm7,xmm4
     e82:	vcvtusi2ss xmm4,xmm5,r14d
                        float BL = p.SUB[ind_lbot + k];
     e88:	movzx  r14d,BYTE PTR [rsi+r10*1]
                        float BR = p.SUB[ind_rbot + k];
     e8d:	movzx  r10d,BYTE PTR [r8+r10*1]
     e92:	vfmadd213ss xmm7,xmm18,DWORD PTR [rax+r11*1]
                        float BL = p.SUB[ind_lbot + k];
     e99:	vcvtusi2ss xmm6,xmm5,r14d
                        vp[k] += p.A*TL + p.B*TR + p.C*BL + p.D*BR;
     e9f:	vmulss xmm6,xmm6,xmm16
     ea5:	vfmadd231ss xmm6,xmm17,xmm4
                        float BR = p.SUB[ind_rbot + k];
     eab:	vcvtusi2ss xmm4,xmm5,r10d
                    for (int k = 0; k < remaining; ++k) {
     eb1:	lea    r10d,[r9+0x1]
                        vp[k] += p.A*TL + p.B*TR + p.C*BL + p.D*BR;
     eb5:	vfmadd132ss xmm4,xmm7,xmm15
     eba:	vaddss xmm4,xmm4,xmm6
     ebe:	vmovss DWORD PTR [rax+r11*1],xmm4
                    for (int k = 0; k < remaining; ++k) {
     ec4:	cmp    r10d,ebx
     ec7:	jge    1105 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x1105>
                        float TL = p.SUB[ind_ltop + k];
     ecd:	movzx  r13d,BYTE PTR [rdx+r10*1]
     ed2:	vcvtusi2ss xmm4,xmm5,r13d
                        float TR = p.SUB[ind_rtop + k];
     ed8:	movzx  r13d,BYTE PTR [rcx+r10*1]
     edd:	vmovaps xmm7,xmm4
     ee1:	vcvtusi2ss xmm4,xmm5,r13d
                        float BL = p.SUB[ind_lbot + k];
     ee7:	movzx  r13d,BYTE PTR [rsi+r10*1]
                        float BR = p.SUB[ind_rbot + k];
     eec:	movzx  r10d,BYTE PTR [r8+r10*1]
     ef1:	vfmadd213ss xmm7,xmm18,DWORD PTR [rax+r11*1+0x4]
                        float BL = p.SUB[ind_lbot + k];
     ef9:	vcvtusi2ss xmm6,xmm5,r13d
                        vp[k] += p.A*TL + p.B*TR + p.C*BL + p.D*BR;
     eff:	vmulss xmm6,xmm6,xmm16
     f05:	vfmadd231ss xmm6,xmm17,xmm4
                        float BR = p.SUB[ind_rbot + k];
     f0b:	vcvtusi2ss xmm4,xmm5,r10d
                    for (int k = 0; k < remaining; ++k) {
     f11:	lea    r10d,[r9+0x2]
                        vp[k] += p.A*TL + p.B*TR + p.C*BL + p.D*BR;
     f15:	vfmadd132ss xmm4,xmm7,xmm15
     f1a:	vaddss xmm4,xmm4,xmm6
     f1e:	vmovss DWORD PTR [rax+r11*1+0x4],xmm4
                    for (int k = 0; k < remaining; ++k) {
     f25:	cmp    ebx,r10d
     f28:	jle    1105 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x1105>
                        float TL = p.SUB[ind_ltop + k];
     f2e:	movzx  r13d,BYTE PTR [rdx+r10*1]
     f33:	vcvtusi2ss xmm4,xmm5,r13d
                        float TR = p.SUB[ind_rtop + k];
     f39:	movzx  r13d,BYTE PTR [rcx+r10*1]
     f3e:	vmovaps xmm7,xmm4
     f42:	vcvtusi2ss xmm4,xmm5,r13d
                        float BL = p.SUB[ind_lbot + k];
     f48:	movzx  r13d,BYTE PTR [rsi+r10*1]
                        float BR = p.SUB[ind_rbot + k];
     f4d:	movzx  r10d,BYTE PTR [r8+r10*1]
     f52:	vfmadd213ss xmm7,xmm18,DWORD PTR [rax+r11*1+0x8]
                        float BL = p.SUB[ind_lbot + k];
     f5a:	vcvtusi2ss xmm6,xmm5,r13d
                        vp[k] += p.A*TL + p.B*TR + p.C*BL + p.D*BR;
     f60:	vmulss xmm6,xmm6,xmm16
     f66:	vfmadd231ss xmm6,xmm17,xmm4
                        float BR = p.SUB[ind_rbot + k];
     f6c:	vcvtusi2ss xmm4,xmm5,r10d
                    for (int k = 0; k < remaining; ++k) {
     f72:	lea    r10d,[r9+0x3]
                        vp[k] += p.A*TL + p.B*TR + p.C*BL + p.D*BR;
     f76:	vfmadd132ss xmm4,xmm7,xmm15
     f7b:	vaddss xmm4,xmm4,xmm6
     f7f:	vmovss DWORD PTR [rax+r11*1+0x8],xmm4
                    for (int k = 0; k < remaining; ++k) {
     f86:	cmp    ebx,r10d
     f89:	jle    1105 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x1105>
                        float TL = p.SUB[ind_ltop + k];
     f8f:	movzx  r13d,BYTE PTR [rdx+r10*1]
                        vp[k] += p.A*TL + p.B*TR + p.C*BL + p.D*BR;
     f94:	lea    r12,[rax+r11*1+0xc]
                        float TL = p.SUB[ind_ltop + k];
     f99:	vcvtusi2ss xmm4,xmm5,r13d
                        float TR = p.SUB[ind_rtop + k];
     f9f:	movzx  r13d,BYTE PTR [rcx+r10*1]
     fa4:	vmovaps xmm7,xmm4
     fa8:	vcvtusi2ss xmm4,xmm5,r13d
                        float BL = p.SUB[ind_lbot + k];
     fae:	movzx  r13d,BYTE PTR [rsi+r10*1]
                        float BR = p.SUB[ind_rbot + k];
     fb3:	movzx  r10d,BYTE PTR [r8+r10*1]
     fb8:	vfmadd213ss xmm7,xmm18,DWORD PTR [r12]
                        float BL = p.SUB[ind_lbot + k];
     fbf:	vcvtusi2ss xmm6,xmm5,r13d
                        vp[k] += p.A*TL + p.B*TR + p.C*BL + p.D*BR;
     fc5:	vmulss xmm6,xmm6,xmm16
     fcb:	vfmadd231ss xmm6,xmm17,xmm4
                        float BR = p.SUB[ind_rbot + k];
     fd1:	vcvtusi2ss xmm4,xmm5,r10d
                    for (int k = 0; k < remaining; ++k) {
     fd7:	lea    r10d,[r9+0x4]
                        vp[k] += p.A*TL + p.B*TR + p.C*BL + p.D*BR;
     fdb:	vfmadd132ss xmm4,xmm7,xmm15
     fe0:	vaddss xmm4,xmm4,xmm6
     fe4:	vmovss DWORD PTR [r12],xmm4
                    for (int k = 0; k < remaining; ++k) {
     fea:	cmp    ebx,r10d
     fed:	jle    1105 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x1105>
                        float TL = p.SUB[ind_ltop + k];
     ff3:	movzx  r13d,BYTE PTR [rdx+r10*1]
     ff8:	vcvtusi2ss xmm4,xmm5,r13d
                        float TR = p.SUB[ind_rtop + k];
     ffe:	movzx  r13d,BYTE PTR [rcx+r10*1]
    1003:	vmovaps xmm7,xmm4
    1007:	vcvtusi2ss xmm4,xmm5,r13d
                        float BL = p.SUB[ind_lbot + k];
    100d:	movzx  r13d,BYTE PTR [rsi+r10*1]
                        float BR = p.SUB[ind_rbot + k];
    1012:	movzx  r10d,BYTE PTR [r8+r10*1]
    1017:	vfmadd213ss xmm7,xmm18,DWORD PTR [rax+r11*1+0x10]
                        float BL = p.SUB[ind_lbot + k];
    101f:	vcvtusi2ss xmm6,xmm5,r13d
                        vp[k] += p.A*TL + p.B*TR + p.C*BL + p.D*BR;
    1025:	vmulss xmm6,xmm6,xmm16
    102b:	vfmadd231ss xmm6,xmm17,xmm4
                        float BR = p.SUB[ind_rbot + k];
    1031:	vcvtusi2ss xmm4,xmm5,r10d
                    for (int k = 0; k < remaining; ++k) {
    1037:	lea    r10d,[r9+0x5]
                        vp[k] += p.A*TL + p.B*TR + p.C*BL + p.D*BR;
    103b:	vfmadd132ss xmm4,xmm7,xmm15
    1040:	vaddss xmm4,xmm4,xmm6
    1044:	vmovss DWORD PTR [rax+r11*1+0x10],xmm4
                    for (int k = 0; k < remaining; ++k) {
    104b:	cmp    ebx,r10d
    104e:	jle    1105 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x1105>
                        float TL = p.SUB[ind_ltop + k];
    1054:	movzx  r13d,BYTE PTR [rdx+r10*1]
                    for (int k = 0; k < remaining; ++k) {
    1059:	add    r9d,0x6
                        float TL = p.SUB[ind_ltop + k];
    105d:	vcvtusi2ss xmm4,xmm5,r13d
                        float TR = p.SUB[ind_rtop + k];
    1063:	movzx  r13d,BYTE PTR [rcx+r10*1]
    1068:	vmovaps xmm7,xmm4
    106c:	vcvtusi2ss xmm4,xmm5,r13d
                        float BL = p.SUB[ind_lbot + k];
    1072:	movzx  r13d,BYTE PTR [rsi+r10*1]
                        float BR = p.SUB[ind_rbot + k];
    1077:	movzx  r10d,BYTE PTR [r8+r10*1]
    107c:	vfmadd213ss xmm7,xmm18,DWORD PTR [rax+r11*1+0x14]
                        float BL = p.SUB[ind_lbot + k];
    1084:	vcvtusi2ss xmm6,xmm5,r13d
                        vp[k] += p.A*TL + p.B*TR + p.C*BL + p.D*BR;
    108a:	vmulss xmm6,xmm6,xmm16
    1090:	vfmadd231ss xmm6,xmm17,xmm4
                        float BR = p.SUB[ind_rbot + k];
    1096:	vcvtusi2ss xmm4,xmm5,r10d
                        vp[k] += p.A*TL + p.B*TR + p.C*BL + p.D*BR;
    109c:	vfmadd132ss xmm4,xmm7,xmm15
    10a1:	vaddss xmm4,xmm4,xmm6
    10a5:	vmovss DWORD PTR [rax+r11*1+0x14],xmm4
                    for (int k = 0; k < remaining; ++k) {
    10ac:	cmp    ebx,r9d
    10af:	jle    1105 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x1105>
                        float TL = p.SUB[ind_ltop + k];
    10b1:	movzx  edx,BYTE PTR [rdx+r9*1]
    10b6:	vcvtusi2ss xmm4,xmm5,edx
                        float TR = p.SUB[ind_rtop + k];
    10bc:	movzx  edx,BYTE PTR [rcx+r9*1]
    10c1:	vmovaps xmm7,xmm4
    10c5:	vcvtusi2ss xmm4,xmm5,edx
                        float BL = p.SUB[ind_lbot + k];
    10cb:	movzx  edx,BYTE PTR [rsi+r9*1]
    10d0:	vfmadd213ss xmm7,xmm18,DWORD PTR [rax+r11*1+0x18]
    10d8:	vcvtusi2ss xmm6,xmm5,edx
                        float BR = p.SUB[ind_rbot + k];
    10de:	movzx  edx,BYTE PTR [r8+r9*1]
                        vp[k] += p.A*TL + p.B*TR + p.C*BL + p.D*BR;
    10e3:	vmulss xmm6,xmm6,xmm16
    10e9:	vfmadd231ss xmm6,xmm17,xmm4
                        float BR = p.SUB[ind_rbot + k];
    10ef:	vcvtusi2ss xmm4,xmm5,edx
                        vp[k] += p.A*TL + p.B*TR + p.C*BL + p.D*BR;
    10f5:	vfmadd132ss xmm4,xmm7,xmm15
    10fa:	vaddss xmm4,xmm4,xmm6
    10fe:	vmovss DWORD PTR [rax+r11*1+0x18],xmm4
                for (int y = y_begin; y < y_end; ++y) {
    1105:	inc    DWORD PTR [rsp+0xf0]
    110c:	mov    rbx,QWORD PTR [rsp+0xc0]
    1114:	add    QWORD PTR [rsp+0xd8],rbx
    111c:	mov    eax,DWORD PTR [rsp+0xf0]
    1123:	cmp    eax,DWORD PTR [rsp+0xd0]
    112a:	jl     658 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x658>
    1130:	mov    r12d,DWORD PTR [rsp+0x70]
    1135:	mov    r15,QWORD PTR [rsp+0xe0]
    113d:	mov    r8d,DWORD PTR [rsp+0x6c]
    1142:	mov    ebx,DWORD PTR [rsp+0x68]
    1146:	mov    r11d,DWORD PTR [rsp+0x64]
            for (const SubParams& p : params) {
    114b:	add    r15,0x30
    114f:	cmp    QWORD PTR [rsp+0x80],r15
    1157:	jne    500 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x500>
    115d:	mov    r13d,DWORD PTR [rsp+0x60]
    1162:	mov    r8,QWORD PTR [rsp+0x58]
    1167:	mov    r15d,r11d
            for (int y = ty; y < tile_y_end; ++y) {
    116a:	cmp    DWORD PTR [rsp+0xa8],r15d
    1172:	jle    128f <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x128f>
    1178:	test   r13d,r13d
    117b:	jle    128f <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x128f>
    1181:	lea    r12d,[r13+r13*2+0x0]
    1186:	mov    rdi,QWORD PTR [rsp+0x88]
    118e:	mov    rax,QWORD PTR [rsp+0x40]
    1193:	lea    r9,[r13+r13*2+0x0]
    1198:	movsxd r12,r12d
    119b:	mov    r11,QWORD PTR [rsp+0x30]
    11a0:	lea    r14,[r9*4+0x0]
    11a8:	mov    r10,r8
    11ab:	mov    QWORD PTR [rsp+0xf0],r12
    11b3:	lea    r13,[rax+rdi*4]
    11b7:	mov    ebx,r15d
    11ba:	xor    edi,edi
    11bc:	nop    DWORD PTR [rax+0x0]
                unsigned char* outp = output.data.data() + (y * width + tx) * 3;
    11c0:	mov    rax,QWORD PTR [rsp+0x88]
    11c8:	lea    rdx,[r13+r11*4+0x0]
    11cd:	add    rax,r11
    11d0:	lea    rcx,[rax+rax*2]
    11d4:	mov    rax,QWORD PTR [rsp+0x78]
    11d9:	add    rcx,QWORD PTR [rax+0x10]
    11dd:	xor    eax,eax
    11df:	jmp    1218 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x1218>
    11e1:	data16 cs nop WORD PTR [rax+rax*1+0x0]
    11ec:	data16 cs nop WORD PTR [rax+rax*1+0x0]
    11f7:	nop    WORD PTR [rax+rax*1+0x0]
                        outp[x*3] = outp[x*3+1] = outp[x*3+2] = 0;
    1200:	xor    esi,esi
    1202:	mov    BYTE PTR [rcx+rax*1+0x2],0x0
                for (int x = 0; x < tile_w_actual; ++x) {
    1207:	add    rdx,0x4
                        outp[x*3] = outp[x*3+1] = outp[x*3+2] = 0;
    120b:	mov    WORD PTR [rcx+rax*1],si
                for (int x = 0; x < tile_w_actual; ++x) {
    120f:	add    rax,0x3
    1213:	cmp    r9,rax
    1216:	je     126d <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x126d>
                    int c = counts[y * width + (tx + x)];
    1218:	mov    esi,DWORD PTR [rdx]
                    if (c == 0) {
    121a:	test   esi,esi
    121c:	je     1200 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x1200>
                    float inv_c = 1.0f / static_cast<float>(c);
    121e:	vcvtsi2ss xmm0,xmm5,esi
                for (int x = 0; x < tile_w_actual; ++x) {
    1222:	add    rdx,0x4
                    float inv_c = 1.0f / static_cast<float>(c);
    1226:	vdivss xmm0,xmm23,xmm0
                    for (int ch = 0; ch < 3; ++ch) {
                        float v = vp[x*3 + ch] * inv_c;
    122c:	vmulss xmm1,xmm0,DWORD PTR [r10+rax*4]
                        outp[x*3 + ch] = static_cast<unsigned char>(v);
    1232:	vcvttss2si esi,xmm1
    1236:	mov    BYTE PTR [rcx+rax*1],sil
                        float v = vp[x*3 + ch] * inv_c;
    123a:	lea    esi,[rax+0x1]
    123d:	lea    r12,[rdi+rsi*1]
    1241:	vmulss xmm1,xmm0,DWORD PTR [r8+r12*4]
                        outp[x*3 + ch] = static_cast<unsigned char>(v);
    1247:	vcvttss2si r12d,xmm1
    124b:	mov    BYTE PTR [rcx+rsi*1],r12b
                        float v = vp[x*3 + ch] * inv_c;
    124f:	lea    esi,[rax+0x2]
                for (int x = 0; x < tile_w_actual; ++x) {
    1252:	add    rax,0x3
                        float v = vp[x*3 + ch] * inv_c;
    1256:	lea    r12,[rdi+rsi*1]
    125a:	vmulss xmm0,xmm0,DWORD PTR [r8+r12*4]
                        outp[x*3 + ch] = static_cast<unsigned char>(v);
    1260:	vcvttss2si r12d,xmm0
    1264:	mov    BYTE PTR [rcx+rsi*1],r12b
                for (int x = 0; x < tile_w_actual; ++x) {
    1268:	cmp    r9,rax
    126b:	jne    1218 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x1218>
            for (int y = ty; y < tile_y_end; ++y) {
    126d:	inc    ebx
    126f:	add    rdi,QWORD PTR [rsp+0xf0]
    1277:	add    r10,r14
    127a:	add    r11,QWORD PTR [rsp+0x90]
    1282:	cmp    DWORD PTR [rsp+0xa8],ebx
    1289:	jne    11c0 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x11c0>
        for (int tx = 0; tx < w; tx += TILE_W) {
    128f:	add    QWORD PTR [rsp+0x88],0x100
    129b:	mov    rax,QWORD PTR [rsp+0x88]
    12a3:	cmp    DWORD PTR [rsp+0x4c],eax
    12a7:	jg     44e <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x44e>
    for (int ty = 0; ty < h; ty += TILE_H) {
    12ad:	mov    rdx,QWORD PTR [rsp+0x30]
    12b2:	mov    r14,QWORD PTR [rsp+0x8]
    12b7:	mov    r13d,DWORD PTR [rsp+0x14]
    12bc:	mov    ebx,DWORD PTR [rsp+0x10]
    12c0:	mov    r12,QWORD PTR [rsp]
    12c4:	add    rdx,r14
    12c7:	cmp    ebx,r13d
    12ca:	jl     40e <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x40e>
    12d0:	mov    r14,QWORD PTR [rsp+0x20]
    12d5:	mov    rbx,QWORD PTR [rsp+0x18]
    12da:	vzeroupper
	_GLIBCXX_OPERATOR_DELETE(_GLIBCXX_SIZED_DEALLOC(__p, __n));
    12dd:	mov    rdi,QWORD PTR [rsp+0x28]
    12e2:	mov    esi,0x6000
    12e7:	call   12ec <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x12ec>
	if (__p)
    12ec:	test   r12,r12
    12ef:	je     12fc <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x12fc>
    12f1:	mov    rsi,rbx
    12f4:	mov    rdi,r12
    12f7:	call   12fc <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x12fc>
    12fc:	mov    rax,QWORD PTR [rsp+0x40]
    1301:	test   rax,rax
    1304:	je     1311 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x1311>
    1306:	mov    rsi,r14
    1309:	mov    rdi,rax
    130c:	call   1311 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x1311>
    1311:	mov    rax,QWORD PTR [rsp+0x50]
    1316:	test   rax,rax
    1319:	je     1328 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x1328>
    131b:	mov    rsi,QWORD PTR [rsp+0x38]
    1320:	mov    rdi,rax
    1323:	call   1328 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x1328>
            }
        }
    }

    return output;
}
    1328:	mov    rax,QWORD PTR [rsp+0x78]
    132d:	lea    rsp,[rbp-0x28]
    1331:	pop    rbx
    1332:	pop    r12
    1334:	pop    r13
    1336:	pop    r14
    1338:	pop    r15
    133a:	pop    rbp
    133b:	ret
    output.data.assign(width * height * 3, 0);
    133c:	lea    r13,[r14+r14*2]
	if (__n > _S_max_size(_Tp_alloc_type(__a)))
    1340:	test   r13,r13
    1343:	js     1349 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x1349>
	  return static_cast<_Tp*>(_GLIBCXX_OPERATOR_NEW(__n * sizeof(_Tp)));
    1349:	mov    rdi,r13
    134c:	call   1351 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x1351>
		      __builtin_memset(__dest, (unsigned char)__x, __n);
    1351:	xor    esi,esi
    1353:	mov    rdx,r13
	this->_M_impl._M_end_of_storage = this->_M_impl._M_start + __n;
    1356:	lea    r15,[rax+r13*1]
    135a:	mov    rdi,rax
    135d:	call   1362 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x1362>
    1362:	mov    rcx,rax
	  _M_start = __x._M_start;
    1365:	mov    rax,QWORD PTR [rsp+0x78]
    136a:	mov    QWORD PTR [rax+0x10],rcx
	  _M_finish = __x._M_finish;
    136e:	mov    QWORD PTR [rax+0x18],r15
	  _M_end_of_storage = __x._M_end_of_storage;
    1372:	mov    QWORD PTR [rax+0x20],r15
	ptrdiff_t __dif = this->_M_impl._M_finish - this->_M_impl._M_start;
    1376:	mov    rax,QWORD PTR [r12+0x8]
    137b:	mov    QWORD PTR [rsp+0xf0],rax
      if (this->capacity() < __n)
    1383:	sub    rax,rbx
    1386:	mov    QWORD PTR [rsp+0x38],rax
    138b:	jne    8e <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x8e>
	: _M_start(), _M_finish(), _M_end_of_storage()
    1391:	mov    QWORD PTR [rsp+0x50],0x0
    139a:	xor    r15d,r15d
    139d:	jmp    a3 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0xa3>
    13a2:	nop    WORD PTR [rax+rax*1+0x0]
                    int x = (x_begin - tx) * 3;
    13a8:	mov    r8d,DWORD PTR [rsp+0x74]
                    size_t ind_lbot = ind_ltop + width * 3;
    13ad:	mov    rsi,rdi
    13b0:	jmp    777 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x777>
                        float TL = p.SUB[ind_ltop + k];
    13b5:	xor    r11d,r11d
    13b8:	mov    r14d,ebx
                    for (int k = 0; k < remaining; ++k) {
    13bb:	xor    r9d,r9d
    13be:	add    rsi,r8
    13c1:	sub    r14d,r11d
    13c4:	add    rcx,r8
    13c7:	add    rdx,r8
    13ca:	lea    r10d,[r14-0x1]
    13ce:	cmp    r10d,0xe
    13d2:	ja     a3c <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0xa3c>
    13d8:	xor    r10d,r10d
    13db:	jmp    c0f <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0xc0f>
    13e0:	mov    QWORD PTR [rsp+0x50],0x0
    const int h = static_cast<int>(height);
    13e9:	mov    r13d,edx
    13ec:	xor    r15d,r15d
    const int w = static_cast<int>(width);
    13ef:	vmovd  DWORD PTR [rsp+0x4c],xmm0
    for (auto& sub : subapertures) {
    13f5:	cmp    rbx,rdi
    13f8:	jne    c4 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0xc4>
    13fe:	mov    QWORD PTR [rsp+0x80],0x0
	return __n != 0 ? _Tr::allocate(_M_impl, __n) : pointer();
    140a:	mov    QWORD PTR [rsp+0x40],0x0
    1413:	jmp    21d <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x21d>
    1418:	xor    r12d,r12d
    141b:	jmp    27a <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x27a>
	ptrdiff_t __dif = this->_M_impl._M_finish - this->_M_impl._M_start;
    1420:	mov    rax,r15
    1423:	sub    rax,r12
    1426:	mov    QWORD PTR [rsp+0xe8],rax
    142e:	sar    rax,0x4
    1432:	mov    rdx,rax
    1435:	movabs rax,0xaaaaaaaaaaaaaaab
    143f:	imul   rdx,rax
	if (max_size() - size() < __n)
    1443:	movabs rax,0x2aaaaaaaaaaaaaa
    144d:	cmp    rdx,rax
    1450:	je     1456 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x1456>
      if (__a < __b)
    1456:	test   rdx,rdx
    1459:	mov    eax,0x1
    145e:	mov    DWORD PTR [rsp+0x70],r11d
    1463:	cmovne rax,rdx
    1467:	mov    DWORD PTR [rsp+0x74],ecx
    146b:	mov    DWORD PTR [rsp+0xa8],r9d
	const size_type __len = size() + (std::max)(size(), __n);
    1473:	add    rax,rdx
	return (__len < size() || __len > max_size()) ? max_size() : __len;
    1476:	movabs rdx,0x2aaaaaaaaaaaaaa
    1480:	mov    DWORD PTR [rsp+0x80],r8d
    1488:	cmp    rax,rdx
    148b:	mov    DWORD PTR [rsp+0xb0],esi
    1492:	cmova  rax,rdx
    1496:	mov    DWORD PTR [rsp+0xb8],r10d
      allocate(size_type __n, const void* = static_cast<const void*>(0))
    149e:	vmovss DWORD PTR [rsp+0x88],xmm3
	  return static_cast<_Tp*>(_GLIBCXX_OPERATOR_NEW(__n * sizeof(_Tp)));
    14a7:	lea    rax,[rax+rax*2]
    14ab:	vmovss DWORD PTR [rsp+0x98],xmm0
    14b4:	shl    rax,0x4
    14b8:	vmovss DWORD PTR [rsp+0xa0],xmm1
    14c1:	mov    rdi,rax
    14c4:	mov    QWORD PTR [rsp+0xc8],rax
    14cc:	vmovss DWORD PTR [rsp+0xac],xmm2
    14d5:	call   14da <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x14da>
	// taking the element by lvalue ref (see last bullet of C++11
	// [res.on.arguments]).

	// If this throws, the existing elements are unchanged.
#if __cplusplus >= 201103L
	_Alloc_traits::construct(this->_M_impl,
    14da:	mov    rdx,QWORD PTR [rsp+0xe8]
	{ ::new((void *)__p) _Up(std::forward<_Args>(__args)...); }
    14e2:	mov    ecx,DWORD PTR [rsp+0x74]
	  return static_cast<_Tp*>(_GLIBCXX_OPERATOR_NEW(__n * sizeof(_Tp)));
    14e6:	mov    QWORD PTR [rsp+0xd8],rax
    14ee:	mov    rdi,rax
	{ ::new((void *)__p) _Up(std::forward<_Args>(__args)...); }
    14f1:	vmovss xmm0,DWORD PTR [rsp+0x98]
    14fa:	vmovss xmm2,DWORD PTR [rsp+0xac]
    1503:	mov    r10d,DWORD PTR [rsp+0xb8]
    150b:	mov    esi,DWORD PTR [rsp+0xb0]
    1512:	mov    DWORD PTR [rax+rdx*1+0x1c],ecx
    1516:	vinsertps xmm0,xmm0,DWORD PTR [rsp+0x88],0x10
    1521:	vinsertps xmm2,xmm2,DWORD PTR [rsp+0xa0],0x10
    152c:	mov    r8d,DWORD PTR [rsp+0x80]
    1534:	mov    r9d,DWORD PTR [rsp+0xa8]
    153c:	mov    DWORD PTR [rax+rdx*1],r10d
    1540:	mov    r11d,DWORD PTR [rsp+0x70]
    1545:	mov    rcx,QWORD PTR [rsp+0xd0]
    154d:	vmovlhps xmm2,xmm2,xmm0
    1551:	mov    DWORD PTR [rax+rdx*1+0x4],esi
    1555:	mov    DWORD PTR [rax+rdx*1+0x18],r8d
    155a:	mov    DWORD PTR [rax+rdx*1+0x20],r9d
    155f:	mov    DWORD PTR [rax+rdx*1+0x24],r11d
    1564:	mov    QWORD PTR [rax+rdx*1+0x28],rcx
    1569:	vmovups XMMWORD PTR [rax+rdx*1+0x8],xmm2
    __relocate_a_1(_Tp* __first, _Tp* __last,
		   _Tp* __result,
		   [[__maybe_unused__]] allocator<_Up>& __alloc) noexcept
    {
      ptrdiff_t __count = __last - __first;
      if (__count > 0)
    156f:	test   rdx,rdx
    1572:	je     157c <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x157c>
	      __gnu_cxx::__normal_iterator<_Tp*, void> __out(__result);
	      __out = std::__relocate_a_1(__first, __last, __out, __alloc);
	      return __out.base();
	    }
#endif
	  __builtin_memcpy(__result, __first, __count * sizeof(_Tp));
    1574:	mov    rsi,r12
    1577:	call   157c <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x157c>
	  {
	    // Relocation cannot throw.
	    __new_finish = std::__relocate_a(__old_start, __old_finish,
					     __new_start,
					     _M_get_Tp_allocator());
	    ++__new_finish;
    157c:	mov    rax,QWORD PTR [rsp+0xd8]
    1584:	mov    rdi,QWORD PTR [rsp+0xe8]
    158c:	lea    rax,[rax+rdi*1+0x30]
    1591:	mov    QWORD PTR [rsp+0x50],rax
	  if (_M_storage)
    1596:	test   r12,r12
    1599:	je     15a9 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x15a9>
	    // New storage has been fully initialized, destroy the old elements.
	    __guard_elts._M_first = __old_start;
	    __guard_elts._M_last = __old_finish;
	  }
	__guard._M_storage = __old_start;
	__guard._M_len = this->_M_impl._M_end_of_storage - __old_start;
    159b:	mov    rsi,r15
	_GLIBCXX_OPERATOR_DELETE(_GLIBCXX_SIZED_DEALLOC(__p, __n));
    159e:	mov    rdi,r12
    15a1:	sub    rsi,r12
    15a4:	call   15a9 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x15a9>
      // deallocate should be called before assignments to _M_impl,
      // to avoid call-clobbering

      this->_M_impl._M_start = __new_start;
      this->_M_impl._M_finish = __new_finish;
      this->_M_impl._M_end_of_storage = __new_start + __len;
    15a9:	mov    r15,QWORD PTR [rsp+0xc8]
    15b1:	mov    r12,QWORD PTR [rsp+0xd8]
    15b9:	add    r15,r12
    15bc:	jmp    1ba <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x1ba>
    15c1:	mov    rax,QWORD PTR [rsp+0x50]
    15c6:	mov    QWORD PTR [rsp+0x80],rax
    15ce:	jmp    1e9 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x1e9>
	if (__p)
    15d3:	mov    r13,rax
    15d6:	jmp    15db <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x15db>
    15db:	jmp    15e0 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x15e0>
    15e0:	mov    rbx,rax
    15e3:	vzeroupper
    15e6:	jmp    15eb <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x15eb>
    15eb:	jmp    15f0 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x15f0>
    15f0:	jmp    15f5 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x15f5>

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
	if (__p)
  30:	test   r12,r12
  33:	jne    9a <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float) [clone .cold]+0x9a>
  35:	vzeroupper
      ~__new_allocator() _GLIBCXX_USE_NOEXCEPT { }
  38:	mov    rbx,r13
  3b:	jmp    43 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float) [clone .cold]+0x43>
  3d:	mov    rbx,rax
  40:	vzeroupper
  43:	cmp    QWORD PTR [rsp+0x40],0x0
  49:	je     58 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float) [clone .cold]+0x58>
	_GLIBCXX_OPERATOR_DELETE(_GLIBCXX_SIZED_DEALLOC(__p, __n));
  4b:	mov    rdi,QWORD PTR [rsp+0x40]
  50:	mov    rsi,r14
  53:	call   58 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float) [clone .cold]+0x58>
  58:	cmp    QWORD PTR [rsp+0x50],0x0
  5e:	je     78 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float) [clone .cold]+0x78>
	ptrdiff_t __n = _M_impl._M_end_of_storage - _M_impl._M_start;
  60:	mov    rdi,QWORD PTR [rsp+0x50]
  65:	mov    rsi,r15
  68:	sub    rsi,rdi
  6b:	call   70 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float) [clone .cold]+0x70>
      ~__new_allocator() _GLIBCXX_USE_NOEXCEPT { }
  70:	jmp    78 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float) [clone .cold]+0x78>
  72:	mov    rbx,rax
  75:	vzeroupper
  78:	mov    rax,QWORD PTR [rsp+0x78]
  7d:	mov    rdi,QWORD PTR [rax+0x10]
	if (__p)
  81:	test   rdi,rdi
  84:	je     92 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float) [clone .cold]+0x92>
	ptrdiff_t __n = _M_impl._M_end_of_storage - _M_impl._M_start;
  86:	mov    rsi,QWORD PTR [rax+0x20]
  8a:	sub    rsi,rdi
	_GLIBCXX_OPERATOR_DELETE(_GLIBCXX_SIZED_DEALLOC(__p, __n));
  8d:	call   92 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float) [clone .cold]+0x92>
      ~__new_allocator() _GLIBCXX_USE_NOEXCEPT { }
  92:	mov    rdi,rbx
  95:	call   9a <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float) [clone .cold]+0x9a>
	_GLIBCXX_OPERATOR_DELETE(_GLIBCXX_SIZED_DEALLOC(__p, __n));
  9a:	mov    rsi,rbx
  9d:	mov    rdi,r12
  a0:	vzeroupper
  a3:	call   a8 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float) [clone .cold]+0xa8>
  a8:	jmp    38 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float) [clone .cold]+0x38>
                unsigned char* outp = output.data.data() + (y * width + tx) * 3;
  aa:	mov    QWORD PTR [rsp+0x50],r12
  af:	mov    rbx,rax
  b2:	vzeroupper
  b5:	jmp    58 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float) [clone .cold]+0x58>
	if (__p)
  b7:	mov    rbx,rax
  ba:	vzeroupper
  bd:	jmp    58 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float) [clone .cold]+0x58>
