
asm/opt9_abl_hand_vec_no_tile.o:     file format elf64-x86-64


Disassembly of section .text:

0000000000000000 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)>:
    int x_begin, x_end, y_begin, y_end;
    const unsigned char* SUB;
};
}

ImageData refocus_shift_and_sum(std::vector<SubApertureImage>& subapertures, float focus) {
       0:	push   rbp
       1:	vmovaps xmm4,xmm0
	pointer _M_finish;
	pointer _M_end_of_storage;

	_GLIBCXX20_CONSTEXPR
	_Vector_impl_data() _GLIBCXX_NOEXCEPT
	: _M_start(), _M_finish(), _M_end_of_storage()
       5:	vpxor  xmm1,xmm1,xmm1
       9:	mov    rbp,rsp
       c:	push   r15
       e:	push   r14
      10:	push   r13
      12:	push   r12
      14:	push   rbx
      15:	mov    rbx,rsi
      18:	and    rsp,0xffffffffffffffe0
      1c:	sub    rsp,0x100
      : _M_current() { }

      __attribute__((__always_inline__))
      explicit _GLIBCXX_CONSTEXPR
      __normal_iterator(const _Iterator& __i) _GLIBCXX_NOEXCEPT
      : _M_current(__i) { }
      23:	mov    rcx,QWORD PTR [rsi]
      26:	mov    QWORD PTR [rsp+0x48],rdi
    const size_t width  = subapertures.front().data.width;
      2b:	vmovdqu xmm0,XMMWORD PTR [rcx]
      2f:	mov    QWORD PTR [rdi+0x20],0x0
      37:	vmovdqu XMMWORD PTR [rdi+0x10],xmm1
      3c:	vmovq  rax,xmm0
    const size_t height = subapertures.front().data.height;
    const int w = static_cast<int>(width);
    const int h = static_cast<int>(height);

    ImageData output;
    output.width = width;
      41:	vmovdqu XMMWORD PTR [rdi],xmm0
    output.height = height;
    output.data.assign(width * height * 3, 0);
      45:	vpextrq rdi,xmm0,0x1
      4b:	vpextrq QWORD PTR [rsp+0xd0],xmm0,0x1
      56:	mov    rsi,rax
      59:	vmovq  QWORD PTR [rsp+0x78],xmm0
      5f:	imul   rsi,rdi
      63:	lea    rdx,[rsi+rsi*1]
      67:	mov    QWORD PTR [rsp+0x50],rsi
      6c:	mov    QWORD PTR [rsp+0xb8],rdx
      74:	add    rdx,rsi
      77:	mov    QWORD PTR [rsp+0xe0],rdx
    void
    vector<_Tp, _Alloc>::
    _M_fill_assign(size_t __n, const value_type& __val)
    {
      const size_type __sz = size();
      if (__n > capacity())
      7f:	test   rsi,rsi
      82:	jne    12a9 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x12a9>
      /**  Returns the number of elements in the %vector.  */
      _GLIBCXX_NODISCARD _GLIBCXX20_CONSTEXPR
      size_type
      size() const _GLIBCXX_NOEXCEPT
      {
	ptrdiff_t __dif = this->_M_impl._M_finish - this->_M_impl._M_start;
      88:	mov    rsi,QWORD PTR [rbx+0x8]
      if (this->capacity() < __n)
      8c:	mov    rdx,rsi
      8f:	mov    QWORD PTR [rsp+0xf8],rsi
      97:	sub    rdx,rcx
      9a:	mov    QWORD PTR [rsp+0x38],rdx
      9f:	je     11fc <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x11fc>
	    return static_cast<_Tp*>(_GLIBCXX_OPERATOR_NEW(__n * sizeof(_Tp),
							   __al));
	  }
#endif
	else
	  return static_cast<_Tp*>(_GLIBCXX_OPERATOR_NEW(__n * sizeof(_Tp)));
      a5:	mov    rbx,QWORD PTR [rsp+0x38]
      aa:	mov    QWORD PTR [rsp+0xd8],rcx
      allocate(size_type __n, const void* = static_cast<const void*>(0))
      b2:	vmovss DWORD PTR [rsp+0xc8],xmm4
	  return static_cast<_Tp*>(_GLIBCXX_OPERATOR_NEW(__n * sizeof(_Tp)));
      bb:	mov    rdi,rbx
      be:	call   c3 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0xc3>
      c3:	mov    rcx,QWORD PTR [rsp+0xd8]
      cb:	vmovss xmm4,DWORD PTR [rsp+0xc8]
      d4:	mov    QWORD PTR [rsp+0x80],rax
	  this->_M_impl._M_end_of_storage = this->_M_impl._M_start + __n;
      dc:	add    rax,rbx
      df:	mov    QWORD PTR [rsp+0xf0],rax
    const int w = static_cast<int>(width);
      e7:	mov    r15d,DWORD PTR [rsp+0x78]
    const int h = static_cast<int>(height);
      ec:	mov    r13d,DWORD PTR [rsp+0xd0]

    // Precalculate subaperture parameters
    std::vector<SubParams> params;
    params.reserve(subapertures.size());
    for (auto& sub : subapertures) {
      f4:	cmp    rcx,QWORD PTR [rsp+0xf8]
      fc:	je     15c8 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x15c8>
	: _M_start(), _M_finish(), _M_end_of_storage()
     102:	mov    rax,QWORD PTR [rsp+0x80]
        float dy = shift_y - p.sy;
        p.A = (1 - dx) * (1 - dy);
        p.B = dx       * (1 - dy);
        p.C = (1 - dx) * dy;
        p.D = dx       * dy;
        p.x_begin = std::max(0, -p.sx);
     10a:	xor    r10d,r10d
     10d:	mov    QWORD PTR [rsp+0x70],rax
     112:	nop    WORD PTR [rax+rax*1+0x0]
        float shift_x = focus * sub.u;
     118:	vmulss xmm3,xmm4,DWORD PTR [rcx+0x28]
        p.x_end   = std::min(w, w - p.sx - 1);
     11d:	mov    ebx,r15d
        p.y_begin = std::max(0, -p.sy);
        p.y_end   = std::min(h, h - p.sy - 1);
     120:	mov    r14d,r13d
        float shift_y = focus * sub.v;
     123:	vmulss xmm2,xmm4,DWORD PTR [rcx+0x2c]
  using ::floor;

#ifndef __CORRECT_ISO_CPP_MATH_H_PROTO
  inline _GLIBCXX_CONSTEXPR float
  floor(float __x)
  { return __builtin_floorf(__x); }
     128:	vrndscaless xmm0,xmm3,xmm3,0x9
        p.sx = static_cast<int>(std::floor(shift_x));
     12f:	vcvttss2si r9d,xmm0
     133:	vrndscaless xmm1,xmm2,xmm2,0x9
        p.sy = static_cast<int>(std::floor(shift_y));
     13a:	vcvttss2si r8d,xmm1
        p.x_begin = std::max(0, -p.sx);
     13e:	mov    esi,r9d
     141:	neg    esi
     143:	test   r9d,r9d
        p.y_begin = std::max(0, -p.sy);
     146:	mov    r11d,r8d
        p.x_begin = std::max(0, -p.sx);
     149:	cmovns esi,r10d
        p.x_end   = std::min(w, w - p.sx - 1);
     14d:	sub    ebx,r9d
     150:	dec    ebx
    min(const _Tp& __a, const _Tp& __b)
    {
      // concept requirements
      __glibcxx_function_requires(_LessThanComparableConcept<_Tp>)
      //return __b < __a ? __b : __a;
      if (__b < __a)
     152:	cmp    ebx,r15d
     155:	cmovg  ebx,r15d
        p.y_begin = std::max(0, -p.sy);
     159:	neg    r11d
     15c:	test   r8d,r8d
     15f:	cmovns r11d,r10d
        p.y_end   = std::min(h, h - p.sy - 1);
     163:	sub    r14d,r8d
     166:	dec    r14d
     169:	cmp    r14d,r13d
     16c:	cmovg  r14d,r13d
        p.SUB = sub.data.data.data();
        if (p.x_begin >= p.x_end || p.y_begin >= p.y_end) continue;  // skip degenerate
     170:	cmp    ebx,esi
     172:	jle    209 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x209>
     178:	cmp    r11d,r14d
     17b:	jge    209 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x209>
        float dy = shift_y - p.sy;
     181:	vsubss xmm6,xmm2,xmm1
        float dx = shift_x - p.sx;
     185:	vsubss xmm5,xmm3,xmm0
       *   range.  For a non-empty %vector, data() == &front().
       */
      _GLIBCXX_NODISCARD _GLIBCXX20_CONSTEXPR
      _Tp*
      data() _GLIBCXX_NOEXCEPT
      { return _M_data_ptr(this->_M_impl._M_start); }
     189:	mov    rdx,QWORD PTR [rcx+0x10]
       */
      _GLIBCXX20_CONSTEXPR
      void
      push_back(const value_type& __x)
      {
	if (this->_M_impl._M_finish != this->_M_impl._M_end_of_storage)
     18d:	mov    rax,QWORD PTR [rsp+0x80]
        p.A = (1 - dx) * (1 - dy);
     195:	vaddss xmm0,xmm0,DWORD PTR [rip+0x0]        # 19d <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x19d>
     19d:	vaddss xmm1,xmm1,DWORD PTR [rip+0x0]        # 1a5 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x1a5>
      { return _M_data_ptr(this->_M_impl._M_start); }
     1a5:	mov    QWORD PTR [rsp+0xd8],rdx
     1ad:	vsubss xmm0,xmm0,xmm3
     1b1:	vsubss xmm1,xmm1,xmm2
     1b5:	vmulss xmm2,xmm0,xmm1
        p.B = dx       * (1 - dy);
     1b9:	vmulss xmm1,xmm1,xmm5
        p.C = (1 - dx) * dy;
     1bd:	vmulss xmm0,xmm0,xmm6
        p.D = dx       * dy;
     1c1:	vmulss xmm5,xmm5,xmm6
	if (this->_M_impl._M_finish != this->_M_impl._M_end_of_storage)
     1c5:	cmp    QWORD PTR [rsp+0xf0],rax
     1cd:	je     1341 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x1341>
      template<typename _Up, typename... _Args>
	__attribute__((__always_inline__))
	void
	construct(_Up* __p, _Args&&... __args)
	noexcept(__is_nothrow_new_constructible<_Up, _Args...>)
	{ ::new((void *)__p) _Up(std::forward<_Args>(__args)...); }
     1d3:	vunpcklps xmm0,xmm0,xmm5
     1d7:	vunpcklps xmm2,xmm2,xmm1
     1db:	mov    DWORD PTR [rax],r9d
	  {
	    _GLIBCXX_ASAN_ANNOTATE_GROW(1);
	    _Alloc_traits::construct(this->_M_impl, this->_M_impl._M_finish,
				     __x);
	    ++this->_M_impl._M_finish;
     1de:	add    rax,0x30
     1e2:	vmovlhps xmm2,xmm2,xmm0
     1e6:	mov    DWORD PTR [rax-0x2c],r8d
     1ea:	vmovups XMMWORD PTR [rax-0x28],xmm2
     1ef:	mov    DWORD PTR [rax-0x18],esi
     1f2:	mov    DWORD PTR [rax-0x14],ebx
     1f5:	mov    DWORD PTR [rax-0x10],r11d
     1f9:	mov    DWORD PTR [rax-0xc],r14d
     1fd:	mov    QWORD PTR [rax-0x8],rdx
     201:	mov    QWORD PTR [rsp+0x80],rax
      __attribute__((__always_inline__))
      _GLIBCXX14_CONSTEXPR
      __normal_iterator&
      operator++() _GLIBCXX_NOEXCEPT
      {
	++_M_current;
     209:	add    rcx,0x30
    for (auto& sub : subapertures) {
     20d:	cmp    rcx,QWORD PTR [rsp+0xf8]
     215:	jne    118 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x118>
	ptrdiff_t __n = _M_impl._M_end_of_storage - _M_impl._M_start;
     21b:	mov    rax,QWORD PTR [rsp+0xf0]
     223:	sub    rax,QWORD PTR [rsp+0x70]
     228:	mov    QWORD PTR [rsp+0x38],rax

      // Called by constructors to check initial size.
      static _GLIBCXX20_CONSTEXPR size_type
      _S_check_init_len(size_type __n, const allocator_type& __a)
      {
	if (__n > _S_max_size(_Tp_alloc_type(__a)))
     22d:	mov    rax,QWORD PTR [rsp+0x50]
     232:	shr    rax,0x3d
     236:	jne    23c <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x23c>
	return __n != 0 ? _Tr::allocate(_M_impl, __n) : pointer();
     23c:	mov    rax,QWORD PTR [rsp+0x50]
     241:	test   rax,rax
     244:	je     122c <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x122c>
	  return static_cast<_Tp*>(_GLIBCXX_OPERATOR_NEW(__n * sizeof(_Tp)));
     24a:	lea    rbx,[rax*4+0x0]
     252:	mov    rdi,rbx
     255:	mov    QWORD PTR [rsp+0x30],rbx
     25a:	call   25f <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x25f>
	  // Allow std::_Construct to be used in constant expressions.
	  std::construct_at(__p, std::forward<_Args>(__args)...);
	  return;
	}
#endif
      ::new(static_cast<void*>(__p)) _Tp(std::forward<_Args>(__args)...);
     25f:	mov    rdx,rbx
     262:	xor    esi,esi
     264:	mov    rdi,rax
     267:	mov    QWORD PTR [rsp+0x58],rax
     26c:	call   271 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x271>
        params.push_back(p);
    }

    // Precalculate counts
    std::vector<int> counts(width * height, 0);
    std::vector<int> diff((width + 1) * (height + 1), 0);
     271:	mov    rax,QWORD PTR [rsp+0x78]
     276:	lea    r12,[rax+0x1]
     27a:	mov    rax,QWORD PTR [rsp+0xd0]
     282:	inc    rax
     285:	imul   rax,r12
     289:	mov    QWORD PTR [rsp+0x40],rax
	if (__n > _S_max_size(_Tp_alloc_type(__a)))
     28e:	shr    rax,0x3d
     292:	jne    298 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x298>
	return __n != 0 ? _Tr::allocate(_M_impl, __n) : pointer();
     298:	mov    r14,QWORD PTR [rsp+0x40]
     29d:	test   r14,r14
     2a0:	je     1547 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x1547>
     2a6:	shl    r14,0x2
     2aa:	mov    rdi,r14
     2ad:	mov    QWORD PTR [rsp+0x40],r14
     2b2:	call   2b7 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x2b7>
     2b7:	mov    rdx,r14
     2ba:	xor    esi,esi
     2bc:	mov    rdi,rax
     2bf:	mov    rbx,rax
     2c2:	call   2c7 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x2c7>

    for (const auto& p : params) {
     2c7:	mov    rax,QWORD PTR [rsp+0x70]
     2cc:	mov    r8,QWORD PTR [rsp+0x80]
     2d4:	cmp    rax,r8
     2d7:	je     33c <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x33c>
     2d9:	data16 cs nop WORD PTR [rax+rax*1+0x0]
     2e4:	data16 cs nop WORD PTR [rax+rax*1+0x0]
     2ef:	data16 cs nop WORD PTR [rax+rax*1+0x0]
     2fa:	nop    WORD PTR [rax+rax*1+0x0]
        diff[p.y_begin * (width + 1) + p.x_begin] += 1;
     300:	movsxd rdx,DWORD PTR [rax+0x20]
     304:	movsxd rsi,DWORD PTR [rax+0x18]
     308:	add    rax,0x30
        diff[p.y_begin * (width + 1) + p.x_end  ] -= 1;
        diff[p.y_end   * (width + 1) + p.x_begin] -= 1;
     30c:	movsxd rdi,DWORD PTR [rax-0xc]
        diff[p.y_begin * (width + 1) + p.x_begin] += 1;
     310:	imul   rdx,r12
        diff[p.y_end   * (width + 1) + p.x_begin] -= 1;
     314:	imul   rdi,r12
        diff[p.y_begin * (width + 1) + p.x_begin] += 1;
     318:	lea    rcx,[rdx+rsi*1]
     31c:	inc    DWORD PTR [rbx+rcx*4]
        diff[p.y_begin * (width + 1) + p.x_end  ] -= 1;
     31f:	movsxd rcx,DWORD PTR [rax-0x14]
     323:	add    rdx,rcx
     326:	dec    DWORD PTR [rbx+rdx*4]
        diff[p.y_end   * (width + 1) + p.x_begin] -= 1;
     329:	lea    rdx,[rsi+rdi*1]
     32d:	dec    DWORD PTR [rbx+rdx*4]
        diff[p.y_end   * (width + 1) + p.x_end  ] += 1;
     330:	lea    rdx,[rcx+rdi*1]
     334:	inc    DWORD PTR [rbx+rdx*4]
    for (const auto& p : params) {
     337:	cmp    rax,r8
     33a:	jne    300 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x300>
    }

    for (int y = 0; y < h; ++y) {
     33c:	vxorps xmm4,xmm4,xmm4
     340:	test   r13d,r13d
     343:	jle    1590 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x1590>
     349:	test   r15d,r15d
     34c:	jle    3e9 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x3e9>
        int row = 0;
        for (int x = 0; x < w; ++x) {
     352:	mov    rax,QWORD PTR [rsp+0x78]
        int row = 0;
     357:	xor    edx,edx
     359:	lea    ecx,[rax-0x1]
    for (int y = 0; y < h; ++y) {
     35c:	xor    eax,eax
     35e:	lea    r8,[rcx+0x1]
     362:	mov    rcx,QWORD PTR [rsp+0x58]
            row += diff[y * (width + 1) + x];
     367:	add    edx,DWORD PTR [rbx+rax*4]
            counts[y * w + x] = row + (y > 0 ? counts[(y - 1) * w + x] : 0);
     36a:	mov    DWORD PTR [rcx+rax*4],edx
        for (int x = 0; x < w; ++x) {
     36d:	inc    rax
     370:	cmp    rax,r8
     373:	jne    367 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x367>
    for (int y = 0; y < h; ++y) {
     375:	cmp    r13d,0x1
     379:	je     3e9 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x3e9>
     37b:	lea    rax,[r12*4+0x0]
        for (int x = 0; x < w; ++x) {
     383:	xor    ecx,ecx
    for (int y = 0; y < h; ++y) {
     385:	mov    r11d,0x1
     38b:	mov    QWORD PTR [rsp+0xf8],rax
     393:	lea    rdi,[rbx+rax*1]
     397:	mov    eax,r15d
     39a:	lea    r14,[rax*4+0x0]
     3a2:	mov    rax,QWORD PTR [rsp+0x58]
     3a7:	lea    rsi,[rax+r14*1]
        for (int x = 0; x < w; ++x) {
     3ab:	mov    rdx,QWORD PTR [rsp+0x58]
     3b0:	movsxd rax,ecx
     3b3:	add    ecx,DWORD PTR [rsp+0x78]
     3b7:	lea    r10,[rdx+rax*4]
    for (int y = 0; y < h; ++y) {
     3bb:	xor    eax,eax
        int row = 0;
     3bd:	xor    edx,edx
     3bf:	nop
            counts[y * w + x] = row + (y > 0 ? counts[(y - 1) * w + x] : 0);
     3c0:	mov    r9d,DWORD PTR [r10+rax*4]
            row += diff[y * (width + 1) + x];
     3c4:	add    edx,DWORD PTR [rdi+rax*4]
            counts[y * w + x] = row + (y > 0 ? counts[(y - 1) * w + x] : 0);
     3c7:	add    r9d,edx
     3ca:	mov    DWORD PTR [rsi+rax*4],r9d
        for (int x = 0; x < w; ++x) {
     3ce:	inc    rax
     3d1:	cmp    r8,rax
     3d4:	jne    3c0 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x3c0>
    for (int y = 0; y < h; ++y) {
     3d6:	inc    r11d
     3d9:	add    rdi,QWORD PTR [rsp+0xf8]
     3e1:	add    rsi,r14
     3e4:	cmp    r11d,r13d
     3e7:	jl     3ab <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x3ab>
	if (__n > _S_max_size(_Tp_alloc_type(__a)))
     3e9:	mov    rax,QWORD PTR [rsp+0xe0]
     3f1:	shr    rax,0x3d
     3f5:	jne    3fb <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x3fb>
	return __n != 0 ? _Tr::allocate(_M_impl, __n) : pointer();
     3fb:	cmp    QWORD PTR [rsp+0x50],0x0
     401:	je     154e <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x154e>
     407:	mov    rdx,QWORD PTR [rsp+0xb8]
     40f:	vmovaps XMMWORD PTR [rsp+0xe0],xmm4
     418:	add    rdx,QWORD PTR [rsp+0x50]
     41d:	shl    rdx,0x2
     421:	mov    rdi,rdx
     424:	mov    QWORD PTR [rsp+0xf8],rdx
     42c:	mov    QWORD PTR [rsp+0x50],rdx
     431:	call   436 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x436>
     436:	mov    rdx,QWORD PTR [rsp+0xf8]
     43e:	mov    rdi,rax
     441:	xor    esi,esi
     443:	call   448 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x448>
    }

    // Full-image float accumulator (no tiling)
    std::vector<float> vals(width * height * 3, 0.0f);

    for (const SubParams& p : params) {
     448:	mov    rcx,QWORD PTR [rsp+0x80]
     450:	vmovaps xmm4,XMMWORD PTR [rsp+0xe0]
     459:	mov    rdi,rax
     45c:	cmp    QWORD PTR [rsp+0x70],rcx
     461:	je     156c <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x156c>
        const __m256 Cvx = _mm256_set1_ps(p.C);
        const __m256 Dvx = _mm256_set1_ps(p.D);

        for (int y = p.y_begin; y < p.y_end; ++y) {
            size_t ind_ltop = ((y + p.sy) * width + (p.x_begin + p.sx)) * 3;
            size_t ind_lbot = ind_ltop + width * 3;
     467:	mov    rcx,QWORD PTR [rsp+0x78]
     46c:	mov    rsi,QWORD PTR [rsp+0x70]
     471:	mov    DWORD PTR [rsp+0x2c],r15d
     476:	mov    DWORD PTR [rsp+0x28],r13d
     47b:	lea    rax,[rcx+rcx*1]
     47f:	mov    QWORD PTR [rsp+0xc8],rsi
     487:	add    rcx,rax
     48a:	mov    QWORD PTR [rsp+0x60],r12
     48f:	mov    QWORD PTR [rsp+0xb0],rcx
     497:	shl    rcx,0x2
     49b:	mov    QWORD PTR [rsp+0xa8],rcx
     4a3:	mov    QWORD PTR [rsp+0x20],rbx
     4a8:	mov    QWORD PTR [rsp+0x68],rdi
     4ad:	mov    QWORD PTR [rsp+0x18],rax
     4b2:	nop    WORD PTR [rax+rax*1+0x0]
        for (int y = p.y_begin; y < p.y_end; ++y) {
     4b8:	mov    rax,QWORD PTR [rsp+0xc8]
     4c0:	mov    ebx,DWORD PTR [rax+0x20]
     4c3:	mov    ecx,DWORD PTR [rax+0x24]
     4c6:	mov    rdx,rax
     4c9:	mov    DWORD PTR [rsp+0xf0],ebx
     4d0:	mov    DWORD PTR [rsp+0xb8],ecx
     4d7:	cmp    ebx,ecx
     4d9:	jge    1021 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x1021>
            size_t ind_ltop = ((y + p.sy) * width + (p.x_begin + p.sx)) * 3;
     4df:	movsxd rsi,DWORD PTR [rax+0x18]
        const __m256 Avx = _mm256_set1_ps(p.A);
     4e3:	vmovss xmm16,DWORD PTR [rax+0x8]
        const __m256 Bvx = _mm256_set1_ps(p.B);
     4ea:	vmovss xmm15,DWORD PTR [rax+0xc]
        const __m256 Cvx = _mm256_set1_ps(p.C);
     4ef:	vmovss xmm14,DWORD PTR [rax+0x10]
        const __m256 Dvx = _mm256_set1_ps(p.D);
     4f4:	vmovss xmm13,DWORD PTR [rax+0x14]
            size_t ind_ltop = ((y + p.sy) * width + (p.x_begin + p.sx)) * 3;
     4f9:	mov    ecx,DWORD PTR [rax]
        const __m256 Avx = _mm256_set1_ps(p.A);
     4fb:	vbroadcastss ymm18,xmm16
            float* vp = vals.data()
                        + (size_t)y * width * 3
                        + (size_t)p.x_begin * 3;

            int x = 0;
            const int x_stop = (p.x_end - p.x_begin) * 3;
     501:	mov    eax,DWORD PTR [rax+0x1c]
     504:	movsxd r8,DWORD PTR [rdx+0x4]
        const __m256 Bvx = _mm256_set1_ps(p.B);
     508:	vbroadcastss ymm17,xmm15
        const __m256 Cvx = _mm256_set1_ps(p.C);
     50e:	vbroadcastss ymm11,xmm14
     513:	mov    rdx,QWORD PTR [rsp+0x78]
            size_t ind_ltop = ((y + p.sy) * width + (p.x_begin + p.sx)) * 3;
     518:	add    ecx,esi
        const __m256 Dvx = _mm256_set1_ps(p.D);
     51a:	vbroadcastss ymm19,xmm13
/* Create a vector with all elements equal to A.  */
extern __inline __m256 __attribute__((__gnu_inline__, __always_inline__, __artificial__))
_mm256_set1_ps (float __A)
{
  return __extension__ (__m256){ __A, __A, __A, __A,
				 __A, __A, __A, __A };
     520:	vmovaps ymm3,ymm18
            const int x_stop = (p.x_end - p.x_begin) * 3;
     526:	sub    eax,esi
     528:	vmovaps ymm2,ymm17
     52e:	vmovaps ymm1,ymm11
            size_t ind_ltop = ((y + p.sy) * width + (p.x_begin + p.sx)) * 3;
     532:	movsxd rcx,ecx
            const int x_stop = (p.x_end - p.x_begin) * 3;
     535:	lea    edi,[rax+rax*2]
     538:	movsxd rax,ebx
     53b:	vmovaps ymm0,ymm19
     541:	add    r8,rax
     544:	imul   rax,rdx
     548:	mov    DWORD PTR [rsp+0xc0],edi
     54f:	imul   r8,rdx
     553:	add    rax,rsi
     556:	lea    r9,[rcx+r8*1]
     55a:	add    rcx,QWORD PTR [rsp+0x60]
     55f:	lea    rax,[rax+rax*2]
     563:	add    rcx,r8
     566:	lea    r15,[r9+r9*2]
     56a:	lea    rcx,[rcx+rcx*2]
     56e:	mov    QWORD PTR [rsp+0xe0],rcx
     576:	mov    rcx,QWORD PTR [rsp+0x68]
     57b:	lea    rax,[rcx+rax*4]
     57f:	mov    QWORD PTR [rsp+0xd8],rax
     587:	lea    eax,[rdi-0x8]
                ind_ltop += 8; ind_lbot += 8;
                ind_rtop += 8; ind_rbot += 8;
            }

            // Handle tail
            int remaining = x_stop - x;
     58a:	mov    ecx,eax
     58c:	shr    eax,0x3
     58f:	and    ecx,0xfffffff8
     592:	inc    rax
     595:	add    ecx,0x8
     598:	sub    edi,ecx
     59a:	mov    rcx,rax
     59d:	shl    rax,0x3
     5a1:	mov    DWORD PTR [rsp+0xf8],edi
     5a8:	shl    rcx,0x5
     5ac:	mov    QWORD PTR [rsp+0x88],rax
     5b4:	lea    eax,[rdi-0x1]
     5b7:	shr    edi,0x5
     5ba:	mov    DWORD PTR [rsp+0x98],eax
     5c1:	mov    eax,edi
     5c3:	shl    rax,0x5
     5c7:	mov    QWORD PTR [rsp+0xa0],rcx
     5cf:	mov    DWORD PTR [rsp+0x9c],edi
     5d6:	mov    QWORD PTR [rsp+0x90],rax
     5de:	xchg   ax,ax
            size_t ind_lbot = ind_ltop + width * 3;
     5e0:	mov    rax,QWORD PTR [rsp+0xe0]
            for (; x + 8 <= x_stop; x += 8) {
     5e8:	cmp    DWORD PTR [rsp+0xc0],0x7
            size_t ind_rtop = ind_ltop + 3;
     5f0:	lea    rcx,[r15+0x3]
            size_t ind_lbot = ind_ltop + width * 3;
     5f4:	lea    rdx,[rax-0x3]
                        + (size_t)p.x_begin * 3;
     5f8:	mov    rax,QWORD PTR [rsp+0xd8]
            for (; x + 8 <= x_stop; x += 8) {
     600:	jle    1248 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x1248>
                __m128i ltop_b = _mm_loadl_epi64(reinterpret_cast<const __m128i*>(p.SUB + ind_ltop));
     606:	mov    rsi,QWORD PTR [rsp+0xc8]
     60e:	mov    rdi,QWORD PTR [rsp+0xa0]
     616:	mov    rsi,QWORD PTR [rsi+0x28]
     61a:	add    rdi,rax
     61d:	lea    r8,[rsi+rdx*1]
     621:	nop    DWORD PTR [rax+0x0]
}

extern __inline __m128i __attribute__((__gnu_inline__, __always_inline__, __artificial__))
_mm_loadl_epi64 (__m128i_u const *__P)
{
  return _mm_set_epi64 ((__m64)0LL, *(__m64_u *)__P);
     628:	mov    r9,r8

extern __inline __m256i
__attribute__ ((__gnu_inline__, __always_inline__, __artificial__))
_mm256_cvtepu8_epi32 (__m128i __X)
{
  return (__m256i) __builtin_ia32_pmovzxbd256 ((__v16qi)__X);
     62b:	vpmovzxbd ymm6,QWORD PTR [r8]
     630:	vpmovzxbd ymm5,QWORD PTR [r8+0x3]
                vp += 8;
     636:	add    rax,0x20
     63a:	sub    r9,rdx
            for (; x + 8 <= x_stop; x += 8) {
     63d:	add    r8,0x8
     641:	vpmovzxbd ymm8,QWORD PTR [r9+r15*1]
     647:	vpmovzxbd ymm7,QWORD PTR [r9+r15*1+0x3]
  return (__m256)__builtin_ia32_cvtdq2ps256 ((__v8si) __A);
     64e:	vcvtdq2ps ymm6,ymm6
     652:	vcvtdq2ps ymm5,ymm5
     656:	vcvtdq2ps ymm8,ymm8

extern __inline __m256
__attribute__((__gnu_inline__, __always_inline__, __artificial__))
_mm256_fmadd_ps (__m256 __A, __m256 __B, __m256 __C)
{
  return (__m256)__builtin_ia32_vfmaddps256 ((__v8sf)__A, (__v8sf)__B,
     65b:	vfmadd213ps ymm8,ymm3,YMMWORD PTR [rax-0x20]
     661:	vcvtdq2ps ymm7,ymm7
     665:	vfmadd132ps ymm7,ymm8,ymm2
     66a:	vfmadd132ps ymm6,ymm7,ymm1
     66f:	vfmadd132ps ymm5,ymm6,ymm0
  *(__m256_u *)__P = __A;
     674:	vmovups YMMWORD PTR [rax-0x20],ymm5
     679:	cmp    rax,rdi
     67c:	jne    628 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x628>
            for (int k = 0; k < remaining; ++k) {
     67e:	mov    r8d,DWORD PTR [rsp+0xf8]
     686:	test   r8d,r8d
     689:	jle    fe3 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0xfe3>
     68f:	mov    rax,QWORD PTR [rsp+0x88]
     697:	mov    rbx,QWORD PTR [rsp+0xe0]
     69f:	add    rcx,rax
     6a2:	lea    r14,[rbx+rax*1]
     6a6:	lea    r11,[r15+rax*1]
     6aa:	add    rdx,rax
     6ad:	cmp    DWORD PTR [rsp+0x98],0x1e
     6b5:	jbe    129c <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x129c>
     6bb:	mov    r12,QWORD PTR [rsp+0x90]
     6c3:	lea    r10,[rsi+r14*1]
     6c7:	lea    r9,[rsi+rdx*1]
     6cb:	add    rcx,rsi
     6ce:	lea    rbx,[rsi+r11*1]
     6d2:	mov    rax,rdi
     6d5:	xor    r8d,r8d
     6d8:	nop    DWORD PTR [rax+rax*1+0x0]
                float TL = p.SUB[ind_ltop + k];
                float TR = p.SUB[ind_rtop + k];
                float BL = p.SUB[ind_lbot + k];
     6e0:	vmovdqu ymm5,YMMWORD PTR [r9+r8*1]
                float TR = p.SUB[ind_rtop + k];
     6e6:	vmovdqu ymm6,YMMWORD PTR [rcx+r8*1]
     6ec:	sub    rax,0xffffffffffffff80
                float TL = p.SUB[ind_ltop + k];
     6f0:	vmovdqu ymm7,YMMWORD PTR [rbx+r8*1]
                float BL = p.SUB[ind_lbot + k];
     6f6:	vpmovzxbw ymm9,xmm5
                float TR = p.SUB[ind_rtop + k];
     6fb:	vpmovzxbw ymm8,xmm6
                float BL = p.SUB[ind_lbot + k];
     700:	vextracti32x4 xmm5,ymm5,0x1
     707:	vpmovsxwd ymm12,xmm9
     70c:	vextracti32x4 xmm9,ymm9,0x1
                float TR = p.SUB[ind_rtop + k];
     713:	vpmovsxwd ymm10,xmm8
                float BL = p.SUB[ind_lbot + k];
     718:	vpmovsxwd ymm9,xmm9
                float TR = p.SUB[ind_rtop + k];
     71d:	vextracti32x4 xmm8,ymm8,0x1
                float BL = p.SUB[ind_lbot + k];
     724:	vpmovzxbw ymm5,xmm5
     729:	vcvtdq2ps ymm12,ymm12
                float TR = p.SUB[ind_rtop + k];
     72e:	vcvtdq2ps ymm10,ymm10
                float BL = p.SUB[ind_lbot + k];
     733:	vcvtdq2ps ymm9,ymm9
                float BR = p.SUB[ind_rbot + k];
                vp[k] += p.A*TL + p.B*TR + p.C*BL + p.D*BR;
     738:	vmulps ymm9,ymm9,ymm1
                float TR = p.SUB[ind_rtop + k];
     73c:	vpmovsxwd ymm8,xmm8
     741:	vextracti32x4 xmm6,ymm6,0x1
                vp[k] += p.A*TL + p.B*TR + p.C*BL + p.D*BR;
     748:	vmulps ymm12,ymm12,ymm1
                float TR = p.SUB[ind_rtop + k];
     74c:	vcvtdq2ps ymm8,ymm8
     751:	vpmovzxbw ymm6,xmm6
                float TL = p.SUB[ind_ltop + k];
     756:	vpmovzxbw ymm22,xmm7
     75c:	vextracti32x4 xmm7,ymm7,0x1
     763:	vpmovzxbw ymm7,xmm7
                float BL = p.SUB[ind_lbot + k];
     768:	vfmadd132ps ymm8,ymm9,ymm2
     76d:	vpmovsxwd ymm9,xmm5
     772:	vextracti32x4 xmm5,ymm5,0x1
     779:	vcvtdq2ps ymm9,ymm9
                vp[k] += p.A*TL + p.B*TR + p.C*BL + p.D*BR;
     77e:	vmulps ymm9,ymm9,ymm1
     782:	vfmadd132ps ymm10,ymm12,ymm2
                float BL = p.SUB[ind_lbot + k];
     787:	vpmovsxwd ymm5,xmm5
     78c:	vcvtdq2ps ymm5,ymm5
                vp[k] += p.A*TL + p.B*TR + p.C*BL + p.D*BR;
     790:	vmulps ymm5,ymm5,ymm1
                float TR = p.SUB[ind_rtop + k];
     794:	vpmovsxwd ymm12,xmm6
     799:	vextracti32x4 xmm6,ymm6,0x1
     7a0:	vcvtdq2ps ymm12,ymm12
     7a5:	vpmovsxwd ymm6,xmm6
     7aa:	vcvtdq2ps ymm6,ymm6
     7ae:	vfmadd132ps ymm12,ymm9,ymm2
                float TL = p.SUB[ind_ltop + k];
     7b3:	vpmovsxwd ymm9,xmm22
     7b9:	vcvtdq2ps ymm9,ymm9
     7be:	vfmadd213ps ymm9,ymm3,YMMWORD PTR [rax-0x80]
     7c4:	vfmadd132ps ymm6,ymm5,ymm2
                float BR = p.SUB[ind_rbot + k];
     7c9:	vmovdqu ymm5,YMMWORD PTR [r10+r8*1]
     7cf:	add    r8,0x20
     7d3:	vpmovzxbw ymm21,xmm5
     7d9:	vextracti32x4 xmm5,ymm5,0x1
     7e0:	vpmovsxwd ymm20,xmm21
     7e6:	vextracti32x4 xmm21,ymm21,0x1
     7ed:	vpmovzxbw ymm5,xmm5
     7f2:	vcvtdq2ps ymm20,ymm20
     7f8:	vpmovsxwd ymm21,xmm21
     7fe:	vfmadd132ps ymm20,ymm9,ymm0
                float TL = p.SUB[ind_ltop + k];
     804:	vextracti32x4 xmm9,ymm22,0x1
     80b:	vpmovsxwd ymm22,xmm7
                float BR = p.SUB[ind_rbot + k];
     811:	vcvtdq2ps ymm21,ymm21
                float TL = p.SUB[ind_ltop + k];
     817:	vpmovsxwd ymm9,xmm9
     81c:	vextracti32x4 xmm7,ymm7,0x1
     823:	vcvtdq2ps ymm22,ymm22
     829:	vcvtdq2ps ymm9,ymm9
     82e:	vfmadd213ps ymm9,ymm3,YMMWORD PTR [rax-0x60]
     834:	vfmadd213ps ymm22,ymm3,YMMWORD PTR [rax-0x40]
     83b:	vpmovsxwd ymm7,xmm7
     840:	vcvtdq2ps ymm7,ymm7
                vp[k] += p.A*TL + p.B*TR + p.C*BL + p.D*BR;
     844:	vfmadd213ps ymm7,ymm3,YMMWORD PTR [rax-0x20]
     84a:	vaddps ymm10,ymm10,ymm20
     850:	vfmadd132ps ymm21,ymm9,ymm0
                float BR = p.SUB[ind_rbot + k];
     856:	vpmovsxwd ymm9,xmm5
     85b:	vextracti32x4 xmm5,ymm5,0x1
     862:	vpmovsxwd ymm5,xmm5
     867:	vcvtdq2ps ymm9,ymm9
     86c:	vfmadd132ps ymm9,ymm22,ymm0
                vp[k] += p.A*TL + p.B*TR + p.C*BL + p.D*BR;
     872:	vmovups YMMWORD PTR [rax-0x80],ymm10
                float BR = p.SUB[ind_rbot + k];
     877:	vcvtdq2ps ymm5,ymm5
                vp[k] += p.A*TL + p.B*TR + p.C*BL + p.D*BR;
     87b:	vfmadd132ps ymm5,ymm7,ymm0
     880:	vaddps ymm8,ymm8,ymm21
     886:	vaddps ymm12,ymm12,ymm9
     88b:	vaddps ymm5,ymm5,ymm6
     88f:	vmovups YMMWORD PTR [rax-0x60],ymm8
     894:	vmovups YMMWORD PTR [rax-0x40],ymm12
     899:	vmovups YMMWORD PTR [rax-0x20],ymm5
            for (int k = 0; k < remaining; ++k) {
     89e:	cmp    r12,r8
     8a1:	jne    6e0 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x6e0>
     8a7:	mov    ebx,DWORD PTR [rsp+0x9c]
     8ae:	shl    ebx,0x5
     8b1:	cmp    ebx,DWORD PTR [rsp+0xf8]
     8b8:	je     fe3 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0xfe3>
     8be:	mov    r8d,ebx
     8c1:	mov    r10d,DWORD PTR [rsp+0xf8]
     8c9:	mov    rax,rdi
     8cc:	sub    r10d,ebx
     8cf:	lea    r9d,[r10-0x1]
     8d3:	cmp    r9d,0xe
     8d7:	jbe    127b <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x127b>
     8dd:	mov    r12d,ebx
                float TL = p.SUB[ind_ltop + k];
     8e0:	lea    r13,[rsi+r12*1]
                float TR = p.SUB[ind_rtop + k];
     8e4:	vmovdqu xmm6,XMMWORD PTR [rcx+r12*1]
     8ea:	lea    r9,[r12+r14*1]
                float BL = p.SUB[ind_lbot + k];
     8ee:	vmovdqu xmm5,XMMWORD PTR [r13+rdx*1+0x0]
                float TL = p.SUB[ind_ltop + k];
     8f5:	vmovdqu xmm7,XMMWORD PTR [r13+r11*1+0x0]
     8fc:	mov    QWORD PTR [rsp+0xd0],r9
     904:	lea    r9,[rdi+r12*4]
                float TR = p.SUB[ind_rtop + k];
     908:	vpmovzxbw xmm8,xmm6
     90d:	vpsrldq xmm6,xmm6,0x8
                float BL = p.SUB[ind_lbot + k];
     912:	vpmovzxbw xmm9,xmm5
                float TR = p.SUB[ind_rtop + k];
     917:	vpmovsxwd xmm20,xmm8
                float TL = p.SUB[ind_ltop + k];
     91d:	vpmovzxbw xmm10,xmm7
                float BL = p.SUB[ind_lbot + k];
     922:	vpmovsxwd xmm12,xmm9
     927:	vpsrldq xmm9,xmm9,0x8
                float TR = p.SUB[ind_rtop + k];
     92d:	vpmovzxbw xmm6,xmm6
                float BR = p.SUB[ind_rbot + k];
     932:	mov    r13,QWORD PTR [rsp+0xd0]
                float TR = p.SUB[ind_rtop + k];
     93a:	vcvtdq2ps xmm20,xmm20
                float BL = p.SUB[ind_lbot + k];
     940:	vpmovsxwd xmm9,xmm9
     945:	vpsrldq xmm5,xmm5,0x8
     94a:	vcvtdq2ps xmm12,xmm12
                float TL = p.SUB[ind_ltop + k];
     94f:	vpmovsxwd xmm24,xmm10
                float BL = p.SUB[ind_lbot + k];
     955:	vcvtdq2ps xmm9,xmm9
                vp[k] += p.A*TL + p.B*TR + p.C*BL + p.D*BR;
     95a:	vmulps xmm9,xmm9,xmm11
                float TR = p.SUB[ind_rtop + k];
     95f:	vpsrldq xmm8,xmm8,0x8
                float BL = p.SUB[ind_lbot + k];
     965:	vpmovzxbw xmm5,xmm5
                float TL = p.SUB[ind_ltop + k];
     96a:	vcvtdq2ps xmm24,xmm24
                vp[k] += p.A*TL + p.B*TR + p.C*BL + p.D*BR;
     970:	vmulps xmm12,xmm12,xmm11
     975:	vfmadd213ps xmm24,xmm18,XMMWORD PTR [r9]
                float TR = p.SUB[ind_rtop + k];
     97b:	vpmovsxwd xmm8,xmm8
     980:	vcvtdq2ps xmm8,xmm8
                float TL = p.SUB[ind_ltop + k];
     985:	vpsrldq xmm7,xmm7,0x8
     98a:	vpsrldq xmm10,xmm10,0x8
     990:	vpmovzxbw xmm7,xmm7
     995:	vpmovsxwd xmm10,xmm10
     99a:	vcvtdq2ps xmm10,xmm10
     99f:	vfmadd213ps xmm10,xmm18,XMMWORD PTR [r9+0x10]
     9a6:	vfmadd132ps xmm8,xmm9,xmm17
                float BL = p.SUB[ind_lbot + k];
     9ac:	vpmovsxwd xmm9,xmm5
     9b1:	vpsrldq xmm5,xmm5,0x8
     9b6:	vcvtdq2ps xmm9,xmm9
     9bb:	vfmadd132ps xmm20,xmm12,xmm17
                float TR = p.SUB[ind_rtop + k];
     9c1:	vpmovsxwd xmm12,xmm6
                vp[k] += p.A*TL + p.B*TR + p.C*BL + p.D*BR;
     9c6:	vmulps xmm9,xmm9,xmm11
                float TR = p.SUB[ind_rtop + k];
     9cb:	vpsrldq xmm6,xmm6,0x8
                float BL = p.SUB[ind_lbot + k];
     9d0:	vpmovsxwd xmm5,xmm5
                float TR = p.SUB[ind_rtop + k];
     9d5:	vcvtdq2ps xmm12,xmm12
                float BL = p.SUB[ind_lbot + k];
     9da:	vcvtdq2ps xmm5,xmm5
                vp[k] += p.A*TL + p.B*TR + p.C*BL + p.D*BR;
     9de:	vmulps xmm5,xmm5,xmm11
                float TR = p.SUB[ind_rtop + k];
     9e3:	vpmovsxwd xmm6,xmm6
     9e8:	vcvtdq2ps xmm6,xmm6
     9ec:	vfmadd132ps xmm12,xmm9,xmm17
     9f2:	vfmadd132ps xmm6,xmm5,xmm17
                float BR = p.SUB[ind_rbot + k];
     9f8:	vmovdqu xmm5,XMMWORD PTR [rsi+r13*1]
     9fe:	vpmovzxbw xmm9,xmm5
     a03:	vpsrldq xmm5,xmm5,0x8
     a08:	vpmovsxwd xmm21,xmm9
     a0e:	vpsrldq xmm9,xmm9,0x8
     a14:	vpmovzxbw xmm5,xmm5
     a19:	vcvtdq2ps xmm21,xmm21
     a1f:	vfmadd132ps xmm21,xmm24,xmm19
                float TL = p.SUB[ind_ltop + k];
     a25:	vpmovsxwd xmm24,xmm7
                float BR = p.SUB[ind_rbot + k];
     a2b:	vpmovsxwd xmm9,xmm9
                float TL = p.SUB[ind_ltop + k];
     a30:	vpsrldq xmm7,xmm7,0x8
     a35:	vcvtdq2ps xmm24,xmm24
     a3b:	vfmadd213ps xmm24,xmm18,XMMWORD PTR [r9+0x20]
                float BR = p.SUB[ind_rbot + k];
     a42:	vcvtdq2ps xmm9,xmm9
                float TL = p.SUB[ind_ltop + k];
     a47:	vpmovsxwd xmm7,xmm7
     a4c:	vfmadd132ps xmm9,xmm10,xmm19
                float BR = p.SUB[ind_rbot + k];
     a52:	vpmovsxwd xmm10,xmm5
                float TL = p.SUB[ind_ltop + k];
     a57:	vcvtdq2ps xmm7,xmm7
                vp[k] += p.A*TL + p.B*TR + p.C*BL + p.D*BR;
     a5b:	vfmadd213ps xmm7,xmm18,XMMWORD PTR [r9+0x30]
                float BR = p.SUB[ind_rbot + k];
     a62:	vpsrldq xmm5,xmm5,0x8
     a67:	vcvtdq2ps xmm10,xmm10
     a6c:	vpmovsxwd xmm5,xmm5
     a71:	vcvtdq2ps xmm5,xmm5
                vp[k] += p.A*TL + p.B*TR + p.C*BL + p.D*BR;
     a75:	vaddps xmm20,xmm20,xmm21
     a7b:	vfmadd132ps xmm10,xmm24,xmm19
     a81:	vaddps xmm8,xmm8,xmm9
     a86:	vfmadd132ps xmm5,xmm7,xmm19
     a8c:	vmovups XMMWORD PTR [r9],xmm20
     a92:	vmovups XMMWORD PTR [r9+0x10],xmm8
     a98:	vaddps xmm12,xmm12,xmm10
     a9d:	vaddps xmm5,xmm5,xmm6
     aa1:	vmovups XMMWORD PTR [r9+0x20],xmm12
     aa7:	vmovups XMMWORD PTR [r9+0x30],xmm5
            for (int k = 0; k < remaining; ++k) {
     aad:	mov    r9d,r10d
     ab0:	and    r9d,0xfffffff0
     ab4:	test   r10b,0xf
     ab8:	je     fe3 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0xfe3>
     abe:	sub    r10d,r9d
     ac1:	add    r8d,r9d
     ac4:	lea    r12d,[r10-0x1]
     ac8:	cmp    r12d,0x6
     acc:	jbe    128f <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x128f>
     ad2:	add    r9d,ebx
                float TL = p.SUB[ind_ltop + k];
     ad5:	lea    r12,[rsi+r11*1]
     ad9:	vmovaps xmm20,xmm17
     adf:	mov    r9d,r9d
                float TR = p.SUB[ind_rtop + k];
     ae2:	vmovq  xmm7,QWORD PTR [rcx+r9*1]
                float TL = p.SUB[ind_ltop + k];
     ae8:	vmovq  xmm6,QWORD PTR [r12+r9*1]
                float BL = p.SUB[ind_lbot + k];
     aee:	lea    r12,[rsi+rdx*1]
     af2:	lea    rbx,[r14+r9*1]
     af6:	vmovq  xmm5,QWORD PTR [r12+r9*1]
     afc:	lea    rdi,[rdi+r9*4]
                float TR = p.SUB[ind_rtop + k];
     b00:	vpmovzxbw xmm10,xmm7
     b05:	vpsrlq xmm7,xmm7,0x20
                float TL = p.SUB[ind_ltop + k];
     b0a:	vpmovzxbw xmm8,xmm6
                float TR = p.SUB[ind_rtop + k];
     b0f:	vpmovzxwd xmm12,xmm10
                float BL = p.SUB[ind_lbot + k];
     b14:	vpmovzxbw xmm9,xmm5
                float TR = p.SUB[ind_rtop + k];
     b19:	vpmovzxbw xmm7,xmm7
     b1e:	vpsrlq xmm10,xmm10,0x20
                float BL = p.SUB[ind_lbot + k];
     b24:	vpsrlq xmm5,xmm5,0x20
                float TR = p.SUB[ind_rtop + k];
     b29:	vmovq  xmm12,xmm12
     b2e:	vcvtdq2ps xmm22,xmm12
                float BL = p.SUB[ind_lbot + k];
     b34:	vpmovzxwd xmm12,xmm9
     b39:	vpsrlq xmm9,xmm9,0x20
                float TR = p.SUB[ind_rtop + k];
     b3f:	vpmovzxwd xmm10,xmm10
                float BL = p.SUB[ind_lbot + k];
     b44:	vpmovzxwd xmm9,xmm9
                float TR = p.SUB[ind_rtop + k];
     b49:	vmovq  xmm10,xmm10
                float BL = p.SUB[ind_lbot + k];
     b4e:	vpmovzxbw xmm5,xmm5
     b53:	vmovq  xmm9,xmm9
                float TR = p.SUB[ind_rtop + k];
     b58:	vcvtdq2ps xmm10,xmm10
                float TL = p.SUB[ind_ltop + k];
     b5d:	vpsrlq xmm6,xmm6,0x20
                float BL = p.SUB[ind_lbot + k];
     b62:	vmovq  xmm21,xmm12
     b68:	vcvtdq2ps xmm9,xmm9
                vp[k] += p.A*TL + p.B*TR + p.C*BL + p.D*BR;
     b6d:	vmulps xmm9,xmm9,xmm11
                float TL = p.SUB[ind_ltop + k];
     b72:	vpmovzxbw xmm6,xmm6
                float BL = p.SUB[ind_lbot + k];
     b77:	vcvtdq2ps xmm21,xmm21
                vp[k] += p.A*TL + p.B*TR + p.C*BL + p.D*BR;
     b7d:	vmulps xmm21,xmm21,xmm11
     b83:	vfmadd132ps xmm10,xmm9,xmm17
                float TR = p.SUB[ind_rtop + k];
     b89:	vpmovzxwd xmm9,xmm7
     b8e:	vpsrlq xmm7,xmm7,0x20
     b93:	vfmadd132ps xmm22,xmm21,xmm17
     b99:	vmovq  xmm9,xmm9
     b9e:	vpmovzxwd xmm7,xmm7
     ba3:	vcvtdq2ps xmm12,xmm9
     ba8:	vmovq  xmm7,xmm7
     bac:	vcvtdq2ps xmm7,xmm7
     bb0:	vmovaps xmm24,xmm10
                float BL = p.SUB[ind_lbot + k];
     bb6:	vpmovzxwd xmm10,xmm5
     bbb:	vpsrlq xmm5,xmm5,0x20
     bc0:	vmovq  xmm10,xmm10
     bc5:	vpmovzxwd xmm5,xmm5
     bca:	vcvtdq2ps xmm10,xmm10
                vp[k] += p.A*TL + p.B*TR + p.C*BL + p.D*BR;
     bcf:	vmulps xmm10,xmm10,xmm11
                float BL = p.SUB[ind_lbot + k];
     bd4:	vmovq  xmm5,xmm5
     bd8:	vcvtdq2ps xmm5,xmm5
                vp[k] += p.A*TL + p.B*TR + p.C*BL + p.D*BR;
     bdc:	vmulps xmm5,xmm5,xmm11
     be1:	vfmadd132ps xmm12,xmm10,xmm17
     be7:	vmovq  xmm10,QWORD PTR [rdi]
     beb:	vfmadd132ps xmm20,xmm5,xmm7
                float BR = p.SUB[ind_rbot + k];
     bf1:	vmovq  xmm5,QWORD PTR [rsi+rbx*1]
     bf6:	vpmovzxbw xmm7,xmm5
     bfb:	vpsrlq xmm5,xmm5,0x20
     c00:	vpmovzxwd xmm9,xmm7
     c05:	vpsrlq xmm7,xmm7,0x20
     c0a:	vpmovzxbw xmm5,xmm5
     c0f:	vmovq  xmm9,xmm9
     c14:	vpmovzxwd xmm7,xmm7
     c19:	vmovaps xmm25,xmm12
     c1f:	vcvtdq2ps xmm23,xmm9
                float TL = p.SUB[ind_ltop + k];
     c25:	vpmovzxwd xmm9,xmm8
     c2a:	vpsrlq xmm8,xmm8,0x20
                float BR = p.SUB[ind_rbot + k];
     c30:	vmovq  xmm7,xmm7
                float TL = p.SUB[ind_ltop + k];
     c34:	vmovq  xmm9,xmm9
     c39:	vpmovzxwd xmm8,xmm8
                float BR = p.SUB[ind_rbot + k];
     c3e:	vcvtdq2ps xmm7,xmm7
     c42:	vmovaps xmm21,xmm20
                float TL = p.SUB[ind_ltop + k];
     c48:	vcvtdq2ps xmm9,xmm9
     c4d:	vfmadd231ps xmm10,xmm18,xmm9
                vp[k] += p.A*TL + p.B*TR + p.C*BL + p.D*BR;
     c53:	vmovq  xmm9,QWORD PTR [rdi+0x8]
                float TL = p.SUB[ind_ltop + k];
     c58:	vmovq  xmm8,xmm8
     c5d:	vmovaps xmm20,xmm18
     c63:	vcvtdq2ps xmm8,xmm8
     c68:	vmovaps xmm12,xmm19
     c6e:	vfmadd132ps xmm8,xmm9,xmm18
     c74:	vpmovzxwd xmm9,xmm6
     c79:	vmovq  xmm9,xmm9
     c7e:	vpsrlq xmm6,xmm6,0x20
     c83:	vcvtdq2ps xmm9,xmm9
     c88:	vpmovzxwd xmm6,xmm6
     c8d:	vfmadd132ps xmm23,xmm10,xmm19
                vp[k] += p.A*TL + p.B*TR + p.C*BL + p.D*BR;
     c93:	vmovq  xmm10,QWORD PTR [rdi+0x10]
                float TL = p.SUB[ind_ltop + k];
     c98:	vmovq  xmm6,xmm6
     c9c:	vcvtdq2ps xmm6,xmm6
     ca0:	vfmadd132ps xmm9,xmm10,xmm18
     ca6:	vfmadd132ps xmm7,xmm8,xmm19
                float BR = p.SUB[ind_rbot + k];
     cac:	vpmovzxwd xmm8,xmm5
     cb1:	vmovq  xmm8,xmm8
     cb6:	vpsrlq xmm5,xmm5,0x20
     cbb:	vcvtdq2ps xmm8,xmm8
     cc0:	vpmovzxwd xmm5,xmm5
     cc5:	vmovq  xmm5,xmm5
     cc9:	vcvtdq2ps xmm5,xmm5
     ccd:	vfmadd132ps xmm8,xmm9,xmm19
                vp[k] += p.A*TL + p.B*TR + p.C*BL + p.D*BR;
     cd3:	vmovq  xmm9,QWORD PTR [rdi+0x18]
     cd8:	vaddps xmm7,xmm24,xmm7
     cde:	vfmadd132ps xmm20,xmm9,xmm6
     ce4:	vmovlps QWORD PTR [rdi+0x8],xmm7
     ce9:	vfmadd132ps xmm12,xmm20,xmm5
     cef:	vaddps xmm5,xmm22,xmm23
     cf5:	vmovlps QWORD PTR [rdi],xmm5
     cf9:	vaddps xmm5,xmm25,xmm8
     cff:	vaddps xmm12,xmm12,xmm21
     d05:	vmovlps QWORD PTR [rdi+0x10],xmm5
     d0a:	vmovlps QWORD PTR [rdi+0x18],xmm12
            for (int k = 0; k < remaining; ++k) {
     d0f:	mov    edi,r10d
     d12:	and    edi,0xfffffff8
     d15:	and    r10d,0x7
     d19:	je     fe3 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0xfe3>
                vp[k] += p.A*TL + p.B*TR + p.C*BL + p.D*BR;
     d1f:	mov    r9d,DWORD PTR [rsp+0xf8]
     d27:	add    r8d,edi
                float TL = p.SUB[ind_ltop + k];
     d2a:	movsxd rbx,r8d
     d2d:	lea    r10,[rsi+rbx*1]
                vp[k] += p.A*TL + p.B*TR + p.C*BL + p.D*BR;
     d31:	lea    rdi,[rbx*4+0x0]
                float TR = p.SUB[ind_rtop + k];
     d39:	movzx  ebx,BYTE PTR [rcx+rbx*1]
                float TL = p.SUB[ind_ltop + k];
     d3d:	movzx  r13d,BYTE PTR [r10+r11*1]
     d42:	vcvtusi2ss xmm5,xmm4,r13d
     d48:	vmovaps xmm7,xmm5
                float TR = p.SUB[ind_rtop + k];
     d4c:	vcvtusi2ss xmm5,xmm4,ebx
                float BL = p.SUB[ind_lbot + k];
     d52:	movzx  ebx,BYTE PTR [r10+rdx*1]
                float BR = p.SUB[ind_rbot + k];
     d57:	movzx  r10d,BYTE PTR [r10+r14*1]
     d5c:	vfmadd213ss xmm7,xmm16,DWORD PTR [rax+rdi*1]
                float BL = p.SUB[ind_lbot + k];
     d63:	vcvtusi2ss xmm6,xmm4,ebx
                vp[k] += p.A*TL + p.B*TR + p.C*BL + p.D*BR;
     d69:	vmulss xmm6,xmm6,xmm14
     d6e:	vfmadd231ss xmm6,xmm15,xmm5
                float BR = p.SUB[ind_rbot + k];
     d73:	vcvtusi2ss xmm5,xmm4,r10d
            for (int k = 0; k < remaining; ++k) {
     d79:	lea    r10d,[r8+0x1]
                vp[k] += p.A*TL + p.B*TR + p.C*BL + p.D*BR;
     d7d:	vfmadd132ss xmm5,xmm7,xmm13
     d82:	vaddss xmm5,xmm5,xmm6
     d86:	vmovss DWORD PTR [rax+rdi*1],xmm5
            for (int k = 0; k < remaining; ++k) {
     d8b:	cmp    r10d,r9d
     d8e:	jge    fe3 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0xfe3>
                float TL = p.SUB[ind_ltop + k];
     d94:	lea    rbx,[rsi+r11*1]
     d98:	movzx  r13d,BYTE PTR [rbx+r10*1]
     d9d:	vcvtusi2ss xmm5,xmm4,r13d
                float TR = p.SUB[ind_rtop + k];
     da3:	movzx  r13d,BYTE PTR [rcx+r10*1]
                float BL = p.SUB[ind_lbot + k];
     da8:	add    r10,rsi
     dab:	vmovaps xmm7,xmm5
                float TR = p.SUB[ind_rtop + k];
     daf:	vcvtusi2ss xmm5,xmm4,r13d
                float BL = p.SUB[ind_lbot + k];
     db5:	movzx  r13d,BYTE PTR [r10+rdx*1]
                float BR = p.SUB[ind_rbot + k];
     dba:	movzx  r10d,BYTE PTR [r10+r14*1]
     dbf:	vfmadd213ss xmm7,xmm16,DWORD PTR [rax+rdi*1+0x4]
                float BL = p.SUB[ind_lbot + k];
     dc7:	vcvtusi2ss xmm6,xmm4,r13d
                vp[k] += p.A*TL + p.B*TR + p.C*BL + p.D*BR;
     dcd:	vmulss xmm6,xmm6,xmm14
     dd2:	vfmadd231ss xmm6,xmm15,xmm5
                float BR = p.SUB[ind_rbot + k];
     dd7:	vcvtusi2ss xmm5,xmm4,r10d
            for (int k = 0; k < remaining; ++k) {
     ddd:	lea    r10d,[r8+0x2]
                vp[k] += p.A*TL + p.B*TR + p.C*BL + p.D*BR;
     de1:	vfmadd132ss xmm5,xmm7,xmm13
     de6:	vaddss xmm5,xmm5,xmm6
     dea:	vmovss DWORD PTR [rax+rdi*1+0x4],xmm5
            for (int k = 0; k < remaining; ++k) {
     df0:	cmp    r10d,r9d
     df3:	jge    fe3 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0xfe3>
                float TL = p.SUB[ind_ltop + k];
     df9:	movzx  r13d,BYTE PTR [rbx+r10*1]
     dfe:	vcvtusi2ss xmm5,xmm4,r13d
                float TR = p.SUB[ind_rtop + k];
     e04:	movzx  r13d,BYTE PTR [rcx+r10*1]
                float BL = p.SUB[ind_lbot + k];
     e09:	add    r10,rsi
     e0c:	vmovaps xmm7,xmm5
                float TR = p.SUB[ind_rtop + k];
     e10:	vcvtusi2ss xmm5,xmm4,r13d
                float BL = p.SUB[ind_lbot + k];
     e16:	movzx  r13d,BYTE PTR [r10+rdx*1]
                float BR = p.SUB[ind_rbot + k];
     e1b:	movzx  r10d,BYTE PTR [r10+r14*1]
     e20:	vfmadd213ss xmm7,xmm16,DWORD PTR [rax+rdi*1+0x8]
                float BL = p.SUB[ind_lbot + k];
     e28:	vcvtusi2ss xmm6,xmm4,r13d
                vp[k] += p.A*TL + p.B*TR + p.C*BL + p.D*BR;
     e2e:	vmulss xmm6,xmm6,xmm14
     e33:	vfmadd231ss xmm6,xmm15,xmm5
                float BR = p.SUB[ind_rbot + k];
     e38:	vcvtusi2ss xmm5,xmm4,r10d
            for (int k = 0; k < remaining; ++k) {
     e3e:	lea    r10d,[r8+0x3]
                vp[k] += p.A*TL + p.B*TR + p.C*BL + p.D*BR;
     e42:	vfmadd132ss xmm5,xmm7,xmm13
     e47:	vaddss xmm5,xmm5,xmm6
     e4b:	vmovss DWORD PTR [rax+rdi*1+0x8],xmm5
            for (int k = 0; k < remaining; ++k) {
     e51:	cmp    r10d,r9d
     e54:	jge    fe3 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0xfe3>
                float TL = p.SUB[ind_ltop + k];
     e5a:	lea    r12,[rsi+r10*1]
     e5e:	mov    QWORD PTR [rsp+0xd0],r10
     e66:	movzx  r10d,BYTE PTR [r12+r11*1]
     e6b:	vcvtusi2ss xmm5,xmm4,r10d
                float TR = p.SUB[ind_rtop + k];
     e71:	mov    r10,QWORD PTR [rsp+0xd0]
     e79:	movzx  r10d,BYTE PTR [rcx+r10*1]
     e7e:	vmovaps xmm7,xmm5
     e82:	vcvtusi2ss xmm5,xmm4,r10d
                float BL = p.SUB[ind_lbot + k];
     e88:	movzx  r10d,BYTE PTR [r12+rdx*1]
     e8d:	vfmadd213ss xmm7,xmm16,DWORD PTR [rax+rdi*1+0xc]
     e95:	vcvtusi2ss xmm6,xmm4,r10d
                float BR = p.SUB[ind_rbot + k];
     e9b:	movzx  r10d,BYTE PTR [r12+r14*1]
                vp[k] += p.A*TL + p.B*TR + p.C*BL + p.D*BR;
     ea0:	vmulss xmm6,xmm6,xmm14
     ea5:	vfmadd231ss xmm6,xmm15,xmm5
                float BR = p.SUB[ind_rbot + k];
     eaa:	vcvtusi2ss xmm5,xmm4,r10d
            for (int k = 0; k < remaining; ++k) {
     eb0:	lea    r10d,[r8+0x4]
                vp[k] += p.A*TL + p.B*TR + p.C*BL + p.D*BR;
     eb4:	vfmadd132ss xmm5,xmm7,xmm13
     eb9:	vaddss xmm5,xmm5,xmm6
     ebd:	vmovss DWORD PTR [rax+rdi*1+0xc],xmm5
            for (int k = 0; k < remaining; ++k) {
     ec3:	cmp    r9d,r10d
     ec6:	jle    fe3 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0xfe3>
                float TL = p.SUB[ind_ltop + k];
     ecc:	movzx  r13d,BYTE PTR [rbx+r10*1]
     ed1:	vcvtusi2ss xmm5,xmm4,r13d
                float TR = p.SUB[ind_rtop + k];
     ed7:	movzx  r13d,BYTE PTR [rcx+r10*1]
                float BL = p.SUB[ind_lbot + k];
     edc:	add    r10,rsi
     edf:	vmovaps xmm7,xmm5
                float TR = p.SUB[ind_rtop + k];
     ee3:	vcvtusi2ss xmm5,xmm4,r13d
                float BL = p.SUB[ind_lbot + k];
     ee9:	movzx  r13d,BYTE PTR [r10+rdx*1]
                float BR = p.SUB[ind_rbot + k];
     eee:	movzx  r10d,BYTE PTR [r10+r14*1]
     ef3:	vfmadd213ss xmm7,xmm16,DWORD PTR [rax+rdi*1+0x10]
                float BL = p.SUB[ind_lbot + k];
     efb:	vcvtusi2ss xmm6,xmm4,r13d
                vp[k] += p.A*TL + p.B*TR + p.C*BL + p.D*BR;
     f01:	vmulss xmm6,xmm6,xmm14
     f06:	vfmadd231ss xmm6,xmm5,xmm15
                float BR = p.SUB[ind_rbot + k];
     f0b:	vcvtusi2ss xmm5,xmm4,r10d
            for (int k = 0; k < remaining; ++k) {
     f11:	lea    r10d,[r8+0x5]
                vp[k] += p.A*TL + p.B*TR + p.C*BL + p.D*BR;
     f15:	vfmadd132ss xmm5,xmm7,xmm13
     f1a:	vaddss xmm5,xmm5,xmm6
     f1e:	vmovss DWORD PTR [rax+rdi*1+0x10],xmm5
            for (int k = 0; k < remaining; ++k) {
     f24:	cmp    r9d,r10d
     f27:	jle    fe3 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0xfe3>
                float TL = p.SUB[ind_ltop + k];
     f2d:	lea    r12,[rsi+r10*1]
                float TR = p.SUB[ind_rtop + k];
     f31:	movzx  r10d,BYTE PTR [rcx+r10*1]
            for (int k = 0; k < remaining; ++k) {
     f36:	add    r8d,0x6
                float TL = p.SUB[ind_ltop + k];
     f3a:	movzx  r11d,BYTE PTR [r12+r11*1]
     f3f:	vcvtusi2ss xmm5,xmm4,r11d
     f45:	vmovaps xmm7,xmm5
                float TR = p.SUB[ind_rtop + k];
     f49:	vcvtusi2ss xmm5,xmm4,r10d
                float BL = p.SUB[ind_lbot + k];
     f4f:	movzx  r10d,BYTE PTR [r12+rdx*1]
     f54:	vfmadd213ss xmm7,xmm16,DWORD PTR [rax+rdi*1+0x14]
     f5c:	vcvtusi2ss xmm6,xmm4,r10d
                float BR = p.SUB[ind_rbot + k];
     f62:	movzx  r10d,BYTE PTR [r12+r14*1]
                vp[k] += p.A*TL + p.B*TR + p.C*BL + p.D*BR;
     f67:	vmulss xmm6,xmm6,xmm14
     f6c:	vfmadd231ss xmm6,xmm15,xmm5
                float BR = p.SUB[ind_rbot + k];
     f71:	vcvtusi2ss xmm5,xmm4,r10d
                vp[k] += p.A*TL + p.B*TR + p.C*BL + p.D*BR;
     f77:	vfmadd132ss xmm5,xmm7,xmm13
     f7c:	vaddss xmm5,xmm5,xmm6
     f80:	vmovss DWORD PTR [rax+rdi*1+0x14],xmm5
            for (int k = 0; k < remaining; ++k) {
     f86:	cmp    r8d,r9d
     f89:	jge    fe3 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0xfe3>
                float BL = p.SUB[ind_lbot + k];
     f8b:	add    rdx,rsi
                vp[k] += p.A*TL + p.B*TR + p.C*BL + p.D*BR;
     f8e:	lea    rax,[rax+rdi*1+0x18]
                float TL = p.SUB[ind_ltop + k];
     f93:	movzx  edi,BYTE PTR [rbx+r8*1]
                float TR = p.SUB[ind_rtop + k];
     f98:	movzx  ecx,BYTE PTR [rcx+r8*1]
                float BL = p.SUB[ind_lbot + k];
     f9d:	movzx  edx,BYTE PTR [rdx+r8*1]
                float BR = p.SUB[ind_rbot + k];
     fa2:	add    rsi,r14
                float TL = p.SUB[ind_ltop + k];
     fa5:	vcvtusi2ss xmm5,xmm4,edi
                float BL = p.SUB[ind_lbot + k];
     fab:	vcvtusi2ss xmm6,xmm4,edx
                float BR = p.SUB[ind_rbot + k];
     fb1:	movzx  edx,BYTE PTR [rsi+r8*1]
     fb6:	vmovaps xmm7,xmm5
                float TR = p.SUB[ind_rtop + k];
     fba:	vcvtusi2ss xmm5,xmm4,ecx
                vp[k] += p.A*TL + p.B*TR + p.C*BL + p.D*BR;
     fc0:	vmulss xmm6,xmm6,xmm14
     fc5:	vfmadd213ss xmm7,xmm16,DWORD PTR [rax]
     fcb:	vfmadd231ss xmm6,xmm15,xmm5
                float BR = p.SUB[ind_rbot + k];
     fd0:	vcvtusi2ss xmm5,xmm4,edx
                vp[k] += p.A*TL + p.B*TR + p.C*BL + p.D*BR;
     fd6:	vfmadd132ss xmm5,xmm7,xmm13
     fdb:	vaddss xmm5,xmm5,xmm6
     fdf:	vmovss DWORD PTR [rax],xmm5
        for (int y = p.y_begin; y < p.y_end; ++y) {
     fe3:	inc    DWORD PTR [rsp+0xf0]
     fea:	mov    rbx,QWORD PTR [rsp+0xb0]
     ff2:	mov    rdx,QWORD PTR [rsp+0xa8]
     ffa:	add    QWORD PTR [rsp+0xe0],rbx
    1002:	add    r15,rbx
    1005:	add    QWORD PTR [rsp+0xd8],rdx
    100d:	mov    eax,DWORD PTR [rsp+0xf0]
    1014:	cmp    eax,DWORD PTR [rsp+0xb8]
    101b:	jne    5e0 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x5e0>
    for (const SubParams& p : params) {
    1021:	add    QWORD PTR [rsp+0xc8],0x30
    102a:	mov    rax,QWORD PTR [rsp+0xc8]
    1032:	cmp    QWORD PTR [rsp+0x80],rax
    103a:	jne    4b8 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x4b8>
            }
        }
    }

    // Write to output
    for (int y = 0; y < h; ++y) {
    1040:	mov    r13d,DWORD PTR [rsp+0x28]
    1045:	mov    r15d,DWORD PTR [rsp+0x2c]
    104a:	mov    rbx,QWORD PTR [rsp+0x20]
    104f:	mov    rdi,QWORD PTR [rsp+0x68]
    1054:	mov    rax,QWORD PTR [rsp+0x18]
    1059:	test   r13d,r13d
    105c:	jle    1564 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x1564>
    1062:	test   r15d,r15d
    1065:	jle    1564 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x1564>
    106b:	vzeroupper
    106e:	mov    rcx,QWORD PTR [rsp+0x78]
            int c = counts[y * w + x];
            if (c == 0) {
                outp[x*3] = outp[x*3+1] = outp[x*3+2] = 0;
                continue;
            }
            float inv_c = 1.0f / static_cast<float>(c);
    1073:	mov    DWORD PTR [rsp+0xe0],r13d
    107b:	mov    r11,rdi
	this->_M_impl._M_end_of_storage = this->_M_impl._M_start + __n;
    107e:	xor    r10d,r10d
    1081:	mov    r12,QWORD PTR [rsp+0x58]
    1086:	vmovss xmm2,DWORD PTR [rip+0x0]        # 108e <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x108e>
    108e:	mov    QWORD PTR [rsp+0xd8],rbx
    for (int y = 0; y < h; ++y) {
    1096:	xor    r14d,r14d
    1099:	add    rax,rcx
            float inv_c = 1.0f / static_cast<float>(c);
    109c:	mov    rbx,QWORD PTR [rsp+0x48]
    10a1:	mov    QWORD PTR [rsp+0xf8],rax
    10a9:	shl    rax,0x2
    10ad:	mov    QWORD PTR [rsp+0xf0],rax
    10b5:	mov    eax,r15d
    10b8:	lea    r15,[rax*4+0x0]
    10c0:	lea    eax,[rcx-0x1]
    10c3:	lea    r8,[rax+rax*2+0x3]
    10c8:	nop    DWORD PTR [rax+rax*1+0x0]
        unsigned char* outp = output.data.data() + (size_t)y * width * 3;
    10d0:	mov    rcx,QWORD PTR [rbx+0x10]
    10d4:	lea    r9,[r10*4+0x0]
    10dc:	mov    rdx,r12
    10df:	xor    eax,eax
    10e1:	add    rcx,r10
    10e4:	jmp    1118 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x1118>
    10e6:	data16 cs nop WORD PTR [rax+rax*1+0x0]
    10f1:	data16 cs nop WORD PTR [rax+rax*1+0x0]
    10fc:	nop    DWORD PTR [rax+0x0]
                outp[x*3] = outp[x*3+1] = outp[x*3+2] = 0;
    1100:	xor    esi,esi
    1102:	mov    BYTE PTR [rcx+rax*1+0x2],0x0
        for (int x = 0; x < w; ++x) {
    1107:	add    rdx,0x4
                outp[x*3] = outp[x*3+1] = outp[x*3+2] = 0;
    110b:	mov    WORD PTR [rcx+rax*1],si
        for (int x = 0; x < w; ++x) {
    110f:	add    rax,0x3
    1113:	cmp    rax,r8
    1116:	je     116d <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x116d>
            int c = counts[y * w + x];
    1118:	mov    esi,DWORD PTR [rdx]
            if (c == 0) {
    111a:	test   esi,esi
    111c:	je     1100 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x1100>
            float inv_c = 1.0f / static_cast<float>(c);
    111e:	vcvtsi2ss xmm0,xmm4,esi
        for (int x = 0; x < w; ++x) {
    1122:	add    rdx,0x4
            float inv_c = 1.0f / static_cast<float>(c);
    1126:	vdivss xmm0,xmm2,xmm0
            for (int ch = 0; ch < 3; ++ch) {
                float v = vp[x*3 + ch] * inv_c;
    112a:	vmulss xmm1,xmm0,DWORD PTR [r11+rax*4]
                outp[x*3 + ch] = static_cast<unsigned char>(v);
    1130:	vcvttss2si esi,xmm1
    1134:	mov    BYTE PTR [rcx+rax*1],sil
                float v = vp[x*3 + ch] * inv_c;
    1138:	lea    esi,[rax+0x1]
    113b:	lea    r13,[rdi+rsi*4]
    113f:	vmulss xmm1,xmm0,DWORD PTR [r13+r9*1+0x0]
                outp[x*3 + ch] = static_cast<unsigned char>(v);
    1146:	vcvttss2si r13d,xmm1
    114a:	mov    BYTE PTR [rcx+rsi*1],r13b
                float v = vp[x*3 + ch] * inv_c;
    114e:	lea    esi,[rax+0x2]
        for (int x = 0; x < w; ++x) {
    1151:	add    rax,0x3
                float v = vp[x*3 + ch] * inv_c;
    1155:	lea    r13,[rdi+rsi*4]
    1159:	vmulss xmm0,xmm0,DWORD PTR [r13+r9*1+0x0]
                outp[x*3 + ch] = static_cast<unsigned char>(v);
    1160:	vcvttss2si r13d,xmm0
    1164:	mov    BYTE PTR [rcx+rsi*1],r13b
        for (int x = 0; x < w; ++x) {
    1168:	cmp    rax,r8
    116b:	jne    1118 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x1118>
    for (int y = 0; y < h; ++y) {
    116d:	inc    r14d
    1170:	add    r10,QWORD PTR [rsp+0xf8]
    1178:	add    r11,QWORD PTR [rsp+0xf0]
    1180:	add    r12,r15
    1183:	cmp    r14d,DWORD PTR [rsp+0xe0]
    118b:	jne    10d0 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x10d0>
    1191:	mov    rbx,QWORD PTR [rsp+0xd8]
	if (__p)
    1199:	test   rdi,rdi
    119c:	je     11a8 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x11a8>
	_GLIBCXX_OPERATOR_DELETE(_GLIBCXX_SIZED_DEALLOC(__p, __n));
    119e:	mov    rsi,QWORD PTR [rsp+0x50]
    11a3:	call   11a8 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x11a8>
    11a8:	test   rbx,rbx
    11ab:	je     11ba <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x11ba>
    11ad:	mov    rsi,QWORD PTR [rsp+0x40]
    11b2:	mov    rdi,rbx
    11b5:	call   11ba <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x11ba>
    11ba:	mov    rax,QWORD PTR [rsp+0x58]
    11bf:	test   rax,rax
    11c2:	je     11d1 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x11d1>
    11c4:	mov    rsi,QWORD PTR [rsp+0x30]
    11c9:	mov    rdi,rax
    11cc:	call   11d1 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x11d1>
    11d1:	mov    rax,QWORD PTR [rsp+0x70]
    11d6:	test   rax,rax
    11d9:	je     11e8 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x11e8>
    11db:	mov    rsi,QWORD PTR [rsp+0x38]
    11e0:	mov    rdi,rax
    11e3:	call   11e8 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x11e8>
            }
        }
    }

    return output;
}
    11e8:	mov    rax,QWORD PTR [rsp+0x48]
    11ed:	lea    rsp,[rbp-0x28]
    11f1:	pop    rbx
    11f2:	pop    r12
    11f4:	pop    r13
    11f6:	pop    r14
    11f8:	pop    r15
    11fa:	pop    rbp
    11fb:	ret
	: _M_start(), _M_finish(), _M_end_of_storage()
    11fc:	mov    QWORD PTR [rsp+0x80],0x0
    const int w = static_cast<int>(width);
    1208:	mov    r15d,eax
    const int h = static_cast<int>(height);
    120b:	mov    r13d,edi
    120e:	mov    QWORD PTR [rsp+0xf0],0x0
    for (auto& sub : subapertures) {
    121a:	cmp    rcx,rsi
    121d:	jne    102 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x102>
    1223:	mov    QWORD PTR [rsp+0x70],0x0
	this->_M_impl._M_end_of_storage = this->_M_impl._M_start + __n;
    122c:	mov    QWORD PTR [rsp+0x30],0x0
	return __n != 0 ? _Tr::allocate(_M_impl, __n) : pointer();
    1235:	mov    QWORD PTR [rsp+0x58],0x0
    123e:	jmp    271 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x271>
    1243:	nop    DWORD PTR [rax+rax*1+0x0]
            for (int k = 0; k < remaining; ++k) {
    1248:	mov    r9d,DWORD PTR [rsp+0xc0]
    1250:	test   r9d,r9d
    1253:	jle    fe3 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0xfe3>
                float TL = p.SUB[ind_ltop + k];
    1259:	mov    rsi,QWORD PTR [rsp+0xc8]
            size_t ind_rbot = ind_lbot + 3;
    1261:	mov    r14,QWORD PTR [rsp+0xe0]
            size_t ind_ltop = ((y + p.sy) * width + (p.x_begin + p.sx)) * 3;
    1269:	mov    r11,r15
            for (int k = 0; k < remaining; ++k) {
    126c:	xor    r8d,r8d
                float TL = p.SUB[ind_ltop + k];
    126f:	mov    rsi,QWORD PTR [rsi+0x28]
    1273:	add    rcx,rsi
    1276:	jmp    d2a <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0xd2a>
            for (int k = 0; k < remaining; ++k) {
    127b:	xor    r9d,r9d
    127e:	sub    r10d,r9d
    1281:	lea    r12d,[r10-0x1]
    1285:	cmp    r12d,0x6
    1289:	ja     ad2 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0xad2>
                vp[k] += p.A*TL + p.B*TR + p.C*BL + p.D*BR;
    128f:	mov    r9d,DWORD PTR [rsp+0xf8]
    1297:	jmp    d2a <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0xd2a>
            for (int k = 0; k < remaining; ++k) {
    129c:	xor    ebx,ebx
    129e:	xor    r8d,r8d
    12a1:	add    rcx,rsi
    12a4:	jmp    8c1 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x8c1>
	if (__n > _S_max_size(_Tp_alloc_type(__a)))
    12a9:	cmp    QWORD PTR [rsp+0xe0],0x0
    12b2:	js     12b8 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x12b8>
	  return static_cast<_Tp*>(_GLIBCXX_OPERATOR_NEW(__n * sizeof(_Tp)));
    12b8:	mov    rdi,rdx
    12bb:	mov    QWORD PTR [rsp+0xf0],rcx
      allocate(size_type __n, const void* = static_cast<const void*>(0))
    12c3:	mov    r14,rdx
    12c6:	vmovss DWORD PTR [rsp+0xd8],xmm4
	  return static_cast<_Tp*>(_GLIBCXX_OPERATOR_NEW(__n * sizeof(_Tp)));
    12cf:	call   12d4 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x12d4>
    12d4:	mov    rdi,rax
	      if constexpr (is_pointer<_BasePtr>::value)
		{
		  void* __dest = std::__niter_base(__first);
		  if (__n > 0) [[__likely__]]
		    {
		      __builtin_memset(__dest, (unsigned char)__x, __n);
    12d7:	xor    esi,esi
	this->_M_impl._M_end_of_storage = this->_M_impl._M_start + __n;
    12d9:	lea    r12,[rax+r14*1]
    12dd:	mov    rdx,r14
    12e0:	call   12e5 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x12e5>
      if (this->capacity() < __n)
    12e5:	mov    rcx,QWORD PTR [rsp+0xf0]
    12ed:	vmovss xmm4,DWORD PTR [rsp+0xd8]
    12f6:	mov    rdi,rax
	  _M_start = __x._M_start;
    12f9:	mov    rax,QWORD PTR [rsp+0x48]
    12fe:	mov    QWORD PTR [rax+0x10],rdi
	  _M_finish = __x._M_finish;
    1302:	mov    QWORD PTR [rax+0x18],r12
	  _M_end_of_storage = __x._M_end_of_storage;
    1306:	mov    QWORD PTR [rax+0x20],r12
	ptrdiff_t __dif = this->_M_impl._M_finish - this->_M_impl._M_start;
    130a:	mov    rax,QWORD PTR [rbx+0x8]
    130e:	mov    QWORD PTR [rsp+0xf8],rax
    1316:	sub    rax,rcx
    1319:	mov    QWORD PTR [rsp+0x38],rax
    131e:	jne    a5 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0xa5>
	: _M_start(), _M_finish(), _M_end_of_storage()
    1324:	mov    QWORD PTR [rsp+0xf0],0x0
    1330:	mov    QWORD PTR [rsp+0x80],0x0
    133c:	jmp    e7 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0xe7>
	ptrdiff_t __dif = this->_M_impl._M_finish - this->_M_impl._M_start;
    1341:	mov    r12,QWORD PTR [rsp+0xf0]
    1349:	movabs rax,0xaaaaaaaaaaaaaaab
    1353:	sub    r12,QWORD PTR [rsp+0x70]
    1358:	mov    rdx,r12
    135b:	sar    rdx,0x4
    135f:	imul   rdx,rax
	if (max_size() - size() < __n)
    1363:	movabs rax,0x2aaaaaaaaaaaaaa
    136d:	cmp    rdx,rax
    1370:	je     1376 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x1376>
    max(const _Tp& __a, const _Tp& __b)
    {
      // concept requirements
      __glibcxx_function_requires(_LessThanComparableConcept<_Tp>)
      //return  __a < __b ? __b : __a;
      if (__a < __b)
    1376:	test   rdx,rdx
    1379:	mov    eax,0x1
    137e:	mov    QWORD PTR [rsp+0x68],rcx
    1383:	cmovne rax,rdx
    1387:	mov    DWORD PTR [rsp+0x80],r11d
    138f:	mov    DWORD PTR [rsp+0x98],esi
	const size_type __len = size() + (std::max)(size(), __n);
    1396:	add    rax,rdx
	return (__len < size() || __len > max_size()) ? max_size() : __len;
    1399:	movabs rdx,0x2aaaaaaaaaaaaaa
    13a3:	mov    DWORD PTR [rsp+0xa8],r8d
    13ab:	cmp    rax,rdx
    13ae:	mov    DWORD PTR [rsp+0xb0],r9d
    13b6:	cmova  rax,rdx
    13ba:	vmovss DWORD PTR [rsp+0x60],xmm4
    13c0:	vmovss DWORD PTR [rsp+0x88],xmm5
    13c9:	lea    rax,[rax+rax*2]
    13cd:	vmovss DWORD PTR [rsp+0x90],xmm0
    13d6:	shl    rax,0x4
    13da:	vmovss DWORD PTR [rsp+0x9c],xmm1
    13e3:	mov    rdi,rax
    13e6:	mov    QWORD PTR [rsp+0xc0],rax
    13ee:	vmovss DWORD PTR [rsp+0xa0],xmm2
    13f7:	call   13fc <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x13fc>
	{ ::new((void *)__p) _Up(std::forward<_Args>(__args)...); }
    13fc:	vmovss xmm0,DWORD PTR [rsp+0x90]
    1405:	vmovss xmm2,DWORD PTR [rsp+0xa0]
    __relocate_a_1(_Tp* __first, _Tp* __last,
		   _Tp* __result,
		   [[__maybe_unused__]] allocator<_Up>& __alloc) noexcept
    {
      ptrdiff_t __count = __last - __first;
      if (__count > 0)
    140e:	test   r12,r12
	  return static_cast<_Tp*>(_GLIBCXX_OPERATOR_NEW(__n * sizeof(_Tp)));
    1411:	mov    QWORD PTR [rsp+0xc8],rax
	{ ::new((void *)__p) _Up(std::forward<_Args>(__args)...); }
    1419:	mov    rcx,QWORD PTR [rsp+0xd8]
    1421:	mov    r9d,DWORD PTR [rsp+0xb0]
    1429:	mov    DWORD PTR [rax+r12*1+0x1c],ebx
	  return static_cast<_Tp*>(_GLIBCXX_OPERATOR_NEW(__n * sizeof(_Tp)));
    142e:	mov    rdi,rax
	{ ::new((void *)__p) _Up(std::forward<_Args>(__args)...); }
    1431:	mov    r8d,DWORD PTR [rsp+0xa8]
    1439:	vinsertps xmm0,xmm0,DWORD PTR [rsp+0x88],0x10
    1444:	mov    DWORD PTR [rax+r12*1+0x24],r14d
    1449:	mov    r10d,0x0
    144f:	vinsertps xmm2,xmm2,DWORD PTR [rsp+0x9c],0x10
    145a:	mov    esi,DWORD PTR [rsp+0x98]
    1461:	mov    QWORD PTR [rax+r12*1+0x28],rcx
    1466:	mov    r11d,DWORD PTR [rsp+0x80]
    146e:	mov    rcx,QWORD PTR [rsp+0x68]
    1473:	mov    DWORD PTR [rax+r12*1],r9d
    1477:	vmovlhps xmm2,xmm2,xmm0
    147b:	mov    DWORD PTR [rax+r12*1+0x4],r8d
    1480:	vmovss xmm4,DWORD PTR [rsp+0x60]
    1486:	mov    DWORD PTR [rax+r12*1+0x18],esi
    148b:	mov    DWORD PTR [rax+r12*1+0x20],r11d
    1490:	vmovups XMMWORD PTR [rax+r12*1+0x8],xmm2
    1497:	je     14cb <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x14cb>
	      __gnu_cxx::__normal_iterator<_Tp*, void> __out(__result);
	      __out = std::__relocate_a_1(__first, __last, __out, __alloc);
	      return __out.base();
	    }
#endif
	  __builtin_memcpy(__result, __first, __count * sizeof(_Tp));
    1499:	mov    rsi,QWORD PTR [rsp+0x70]
    149e:	mov    rdx,r12
    14a1:	mov    QWORD PTR [rsp+0xd8],rcx
    14a9:	vmovss DWORD PTR [rsp+0xb0],xmm4
    14b2:	call   14b7 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x14b7>
    14b7:	vmovss xmm4,DWORD PTR [rsp+0xb0]
    14c0:	mov    rcx,QWORD PTR [rsp+0xd8]
    14c8:	xor    r10d,r10d
	  {
	    // Relocation cannot throw.
	    __new_finish = std::__relocate_a(__old_start, __old_finish,
					     __new_start,
					     _M_get_Tp_allocator());
	    ++__new_finish;
    14cb:	mov    rax,QWORD PTR [rsp+0xc8]
    14d3:	lea    rax,[rax+r12*1+0x30]
    14d8:	mov    QWORD PTR [rsp+0x80],rax
	  if (_M_storage)
    14e0:	mov    rax,QWORD PTR [rsp+0x70]
    14e5:	test   rax,rax
    14e8:	je     1522 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x1522>
	    // New storage has been fully initialized, destroy the old elements.
	    __guard_elts._M_first = __old_start;
	    __guard_elts._M_last = __old_finish;
	  }
	__guard._M_storage = __old_start;
	__guard._M_len = this->_M_impl._M_end_of_storage - __old_start;
    14ea:	mov    rsi,QWORD PTR [rsp+0xf0]
	_GLIBCXX_OPERATOR_DELETE(_GLIBCXX_SIZED_DEALLOC(__p, __n));
    14f2:	mov    rdi,rax
    14f5:	mov    QWORD PTR [rsp+0xd8],rcx
      deallocate(_Tp* __p, size_type __n __attribute__ ((__unused__)))
    14fd:	vmovss DWORD PTR [rsp+0xb0],xmm4
    1506:	sub    rsi,rax
	_GLIBCXX_OPERATOR_DELETE(_GLIBCXX_SIZED_DEALLOC(__p, __n));
    1509:	call   150e <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x150e>
    150e:	vmovss xmm4,DWORD PTR [rsp+0xb0]
    1517:	mov    rcx,QWORD PTR [rsp+0xd8]
    151f:	xor    r10d,r10d
      // deallocate should be called before assignments to _M_impl,
      // to avoid call-clobbering

      this->_M_impl._M_start = __new_start;
      this->_M_impl._M_finish = __new_finish;
      this->_M_impl._M_end_of_storage = __new_start + __len;
    1522:	mov    rsi,QWORD PTR [rsp+0xc8]
    152a:	mov    rax,QWORD PTR [rsp+0xc0]
    1532:	add    rax,rsi
      this->_M_impl._M_start = __new_start;
    1535:	mov    QWORD PTR [rsp+0x70],rsi
      this->_M_impl._M_end_of_storage = __new_start + __len;
    153a:	mov    QWORD PTR [rsp+0xf0],rax
    1542:	jmp    209 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x209>
	return __n != 0 ? _Tr::allocate(_M_impl, __n) : pointer();
    1547:	xor    ebx,ebx
    1549:	jmp    2c7 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x2c7>
    for (const SubParams& p : params) {
    154e:	mov    rcx,QWORD PTR [rsp+0x80]
    1556:	cmp    QWORD PTR [rsp+0x70],rcx
    155b:	je     15da <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x15da>
    155d:	xor    edi,edi
    155f:	jmp    467 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x467>
    1564:	vzeroupper
    1567:	jmp    1199 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x1199>
    for (int y = 0; y < h; ++y) {
    156c:	test   r13d,r13d
    156f:	jle    119e <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x119e>
    1575:	mov    rax,QWORD PTR [rsp+0x78]
    157a:	add    rax,rax
    157d:	test   r15d,r15d
    1580:	jg     106e <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x106e>
    1586:	jmp    119e <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x119e>
    158b:	nop    DWORD PTR [rax+rax*1+0x0]
	if (__n > _S_max_size(_Tp_alloc_type(__a)))
    1590:	mov    rax,QWORD PTR [rsp+0xe0]
    1598:	shr    rax,0x3d
    159c:	jne    15a2 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x15a2>
	return __n != 0 ? _Tr::allocate(_M_impl, __n) : pointer();
    15a2:	cmp    QWORD PTR [rsp+0x50],0x0
    15a8:	jne    407 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x407>
    for (const SubParams& p : params) {
    15ae:	mov    rcx,QWORD PTR [rsp+0x80]
    15b6:	cmp    QWORD PTR [rsp+0x70],rcx
    15bb:	je     11a8 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x11a8>
    15c1:	xor    edi,edi
    15c3:	jmp    467 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x467>
    for (auto& sub : subapertures) {
    15c8:	mov    rax,QWORD PTR [rsp+0x80]
    15d0:	mov    QWORD PTR [rsp+0x70],rax
    15d5:	jmp    22d <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x22d>
    15da:	mov    rax,QWORD PTR [rsp+0x78]
	this->_M_impl._M_end_of_storage = this->_M_impl._M_start + __n;
    15df:	mov    QWORD PTR [rsp+0x50],0x0
	return __n != 0 ? _Tr::allocate(_M_impl, __n) : pointer();
    15e8:	xor    edi,edi
    15ea:	add    rax,rax
    15ed:	test   r15d,r15d
    15f0:	jg     106e <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x106e>
    15f6:	jmp    11a8 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x11a8>
    15fb:	jmp    1600 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x1600>
    1600:	mov    rbx,rax
    1603:	vzeroupper
    1606:	jmp    160b <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x160b>
    160b:	jmp    1610 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x1610>
    1610:	jmp    1615 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x1615>
    1615:	jmp    161a <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x161a>

Disassembly of section .text.unlikely:

0000000000000000 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float) [clone .cold]>:
	  __throw_length_error(
   0:	lea    rdi,[rip+0x0]        # 7 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float) [clone .cold]+0x7>
   7:	call   c <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float) [clone .cold]+0xc>
	if (__p)
   c:	mov    rbx,rax
   f:	vzeroupper
  12:	cmp    QWORD PTR [rsp+0x58],0x0
  18:	je     29 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float) [clone .cold]+0x29>
  1a:	mov    rsi,QWORD PTR [rsp+0x30]
  1f:	mov    rdi,QWORD PTR [rsp+0x58]
  24:	call   29 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float) [clone .cold]+0x29>
  29:	cmp    QWORD PTR [rsp+0x70],0x0
  2f:	je     46 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float) [clone .cold]+0x46>
	ptrdiff_t __n = _M_impl._M_end_of_storage - _M_impl._M_start;
  31:	mov    rsi,QWORD PTR [rsp+0xf0]
  39:	mov    rdi,QWORD PTR [rsp+0x70]
  3e:	sub    rsi,rdi
  41:	call   46 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float) [clone .cold]+0x46>
  46:	mov    rax,QWORD PTR [rsp+0x48]
  4b:	mov    rdi,QWORD PTR [rax+0x10]
	if (__p)
  4f:	test   rdi,rdi
  52:	je     60 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float) [clone .cold]+0x60>
	ptrdiff_t __n = _M_impl._M_end_of_storage - _M_impl._M_start;
  54:	mov    rsi,QWORD PTR [rax+0x20]
  58:	sub    rsi,rdi
  5b:	call   60 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float) [clone .cold]+0x60>
      ~__new_allocator() _GLIBCXX_USE_NOEXCEPT { }
  60:	mov    rdi,rbx
  63:	call   68 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float) [clone .cold]+0x68>
	if (__p)
  68:	mov    r12,rax
  6b:	test   rbx,rbx
  6e:	jne    78 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float) [clone .cold]+0x78>
  70:	vzeroupper
  73:	mov    rbx,r12
  76:	jmp    12 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float) [clone .cold]+0x12>
	_GLIBCXX_OPERATOR_DELETE(_GLIBCXX_SIZED_DEALLOC(__p, __n));
  78:	mov    rsi,QWORD PTR [rsp+0x40]
  7d:	mov    rdi,rbx
  80:	vzeroupper
  83:	call   88 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float) [clone .cold]+0x88>
  88:	jmp    73 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float) [clone .cold]+0x73>
	  __throw_length_error(
  8a:	lea    rdi,[rip+0x0]        # 91 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float) [clone .cold]+0x91>
  91:	call   96 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float) [clone .cold]+0x96>
  96:	lea    rdi,[rip+0x0]        # 9d <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float) [clone .cold]+0x9d>
  9d:	call   a2 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float) [clone .cold]+0xa2>
	ptrdiff_t __n = _M_impl._M_end_of_storage - _M_impl._M_start;
  a2:	mov    rbx,rax
  a5:	vzeroupper
  a8:	jmp    46 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float) [clone .cold]+0x46>
	if (__p)
  aa:	mov    rbx,rax
  ad:	vzeroupper
  b0:	jmp    29 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float) [clone .cold]+0x29>
	  __throw_length_error(
  b5:	lea    rdi,[rip+0x0]        # bc <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float) [clone .cold]+0xbc>
  bc:	call   c1 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float) [clone .cold]+0xc1>
	  __throw_length_error(__N(__s));
  c1:	lea    rdi,[rip+0x0]        # c8 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float) [clone .cold]+0xc8>
  c8:	call   cd <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float) [clone .cold]+0xcd>
  cd:	mov    rbx,rax
  d0:	vzeroupper
  d3:	jmp    29 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float) [clone .cold]+0x29>
