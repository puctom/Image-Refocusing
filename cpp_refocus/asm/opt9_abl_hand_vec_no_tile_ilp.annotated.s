
asm/opt9_abl_hand_vec_no_tile_ilp.o:     file format elf64-x86-64


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
      1c:	sub    rsp,0xe0
      : _M_current() { }

      __attribute__((__always_inline__))
      explicit _GLIBCXX_CONSTEXPR
      __normal_iterator(const _Iterator& __i) _GLIBCXX_NOEXCEPT
      : _M_current(__i) { }
      23:	mov    rcx,QWORD PTR [rsi]
      26:	mov    QWORD PTR [rsp+0x28],rdi
    const size_t width  = subapertures.front().data.width;
      2b:	vmovdqu xmm0,XMMWORD PTR [rcx]
      2f:	mov    QWORD PTR [rdi+0x20],0x0
      37:	vmovdqu XMMWORD PTR [rdi+0x10],xmm1
      3c:	vmovq  rax,xmm0
      41:	vpextrq rdx,xmm0,0x1
    const size_t height = subapertures.front().data.height;
    const int w = static_cast<int>(width);
    const int h = static_cast<int>(height);

    ImageData output;
    output.width = width;
      47:	vmovdqu XMMWORD PTR [rdi],xmm0
    output.height = height;
    output.data.assign(width * height * 3, 0);
      4b:	mov    rdi,rax
      4e:	mov    QWORD PTR [rsp+0xb0],rdx
      56:	imul   rdi,rdx
      5a:	vmovq  QWORD PTR [rsp+0x68],xmm0
      60:	lea    rsi,[rdi+rdi*1]
      64:	mov    QWORD PTR [rsp+0x38],rdi
      69:	mov    QWORD PTR [rsp+0x98],rsi
      71:	add    rsi,rdi
      74:	mov    QWORD PTR [rsp+0xc0],rsi
    void
    vector<_Tp, _Alloc>::
    _M_fill_assign(size_t __n, const value_type& __val)
    {
      const size_type __sz = size();
      if (__n > capacity())
      7c:	test   rdi,rdi
      7f:	jne    1384 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x1384>
      /**  Returns the number of elements in the %vector.  */
      _GLIBCXX_NODISCARD _GLIBCXX20_CONSTEXPR
      size_type
      size() const _GLIBCXX_NOEXCEPT
      {
	ptrdiff_t __dif = this->_M_impl._M_finish - this->_M_impl._M_start;
      85:	mov    rsi,QWORD PTR [rbx+0x8]
      if (this->capacity() < __n)
      89:	mov    rdi,rsi
      8c:	mov    QWORD PTR [rsp+0xd8],rsi
      94:	sub    rdi,rcx
      97:	mov    QWORD PTR [rsp+0x20],rdi
      9c:	je     12bc <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x12bc>
	    return static_cast<_Tp*>(_GLIBCXX_OPERATOR_NEW(__n * sizeof(_Tp),
							   __al));
	  }
#endif
	else
	  return static_cast<_Tp*>(_GLIBCXX_OPERATOR_NEW(__n * sizeof(_Tp)));
      a2:	mov    rbx,QWORD PTR [rsp+0x20]
      a7:	mov    QWORD PTR [rsp+0xb8],rcx
      allocate(size_type __n, const void* = static_cast<const void*>(0))
      af:	vmovss DWORD PTR [rsp+0xa8],xmm4
	  return static_cast<_Tp*>(_GLIBCXX_OPERATOR_NEW(__n * sizeof(_Tp)));
      b8:	mov    rdi,rbx
      bb:	call   c0 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0xc0>
      c0:	mov    r12,rax
	  this->_M_impl._M_end_of_storage = this->_M_impl._M_start + __n;
      c3:	lea    rax,[rax+rbx*1]
      c7:	mov    rcx,QWORD PTR [rsp+0xb8]
      cf:	vmovss xmm4,DWORD PTR [rsp+0xa8]
      d8:	mov    QWORD PTR [rsp+0xd0],rax
    const int w = static_cast<int>(width);
      e0:	mov    r15d,DWORD PTR [rsp+0x68]
    const int h = static_cast<int>(height);
      e5:	mov    r13d,DWORD PTR [rsp+0xb0]

    // Precalculate subaperture parameters
    std::vector<SubParams> params;
    params.reserve(subapertures.size());
    for (auto& sub : subapertures) {
      ed:	cmp    rcx,QWORD PTR [rsp+0xd8]
      f5:	je     1668 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x1668>
	: _M_start(), _M_finish(), _M_end_of_storage()
      fb:	mov    QWORD PTR [rsp+0x60],r12
        float dy = shift_y - p.sy;
        p.A = (1 - dx) * (1 - dy);
        p.B = dx       * (1 - dy);
        p.C = (1 - dx) * dy;
        p.D = dx       * dy;
        p.x_begin = std::max(0, -p.sx);
     100:	xor    r9d,r9d
     103:	nop    DWORD PTR [rax+rax*1+0x0]
        float shift_x = focus * sub.u;
     108:	vmulss xmm3,xmm4,DWORD PTR [rcx+0x28]
        p.x_end   = std::min(w, w - p.sx - 1);
     10d:	mov    ebx,r15d
        p.y_begin = std::max(0, -p.sy);
        p.y_end   = std::min(h, h - p.sy - 1);
     110:	mov    r14d,r13d
        float shift_y = focus * sub.v;
     113:	vmulss xmm2,xmm4,DWORD PTR [rcx+0x2c]
  using ::floor;

#ifndef __CORRECT_ISO_CPP_MATH_H_PROTO
  inline _GLIBCXX_CONSTEXPR float
  floor(float __x)
  { return __builtin_floorf(__x); }
     118:	vrndscaless xmm0,xmm3,xmm3,0x9
        p.sx = static_cast<int>(std::floor(shift_x));
     11f:	vcvttss2si r10d,xmm0
     123:	vrndscaless xmm1,xmm2,xmm2,0x9
        p.sy = static_cast<int>(std::floor(shift_y));
     12a:	vcvttss2si r8d,xmm1
        p.x_begin = std::max(0, -p.sx);
     12e:	mov    esi,r10d
     131:	neg    esi
     133:	test   r10d,r10d
        p.y_begin = std::max(0, -p.sy);
     136:	mov    r11d,r8d
        p.x_begin = std::max(0, -p.sx);
     139:	cmovns esi,r9d
        p.x_end   = std::min(w, w - p.sx - 1);
     13d:	sub    ebx,r10d
     140:	dec    ebx
    min(const _Tp& __a, const _Tp& __b)
    {
      // concept requirements
      __glibcxx_function_requires(_LessThanComparableConcept<_Tp>)
      //return __b < __a ? __b : __a;
      if (__b < __a)
     142:	cmp    ebx,r15d
     145:	cmovg  ebx,r15d
        p.y_begin = std::max(0, -p.sy);
     149:	neg    r11d
     14c:	test   r8d,r8d
     14f:	cmovns r11d,r9d
        p.y_end   = std::min(h, h - p.sy - 1);
     153:	sub    r14d,r8d
     156:	dec    r14d
     159:	cmp    r14d,r13d
     15c:	cmovg  r14d,r13d
        p.SUB = sub.data.data.data();
        if (p.x_begin >= p.x_end || p.y_begin >= p.y_end) continue;  // skip degenerate
     160:	cmp    ebx,esi
     162:	jle    1f4 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x1f4>
     168:	cmp    r11d,r14d
     16b:	jge    1f4 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x1f4>
        float dy = shift_y - p.sy;
     171:	vsubss xmm6,xmm2,xmm1
        float dx = shift_x - p.sx;
     175:	vsubss xmm5,xmm3,xmm0
       *   range.  For a non-empty %vector, data() == &front().
       */
      _GLIBCXX_NODISCARD _GLIBCXX20_CONSTEXPR
      _Tp*
      data() _GLIBCXX_NOEXCEPT
      { return _M_data_ptr(this->_M_impl._M_start); }
     179:	mov    rax,QWORD PTR [rcx+0x10]
        p.A = (1 - dx) * (1 - dy);
     17d:	vaddss xmm0,xmm0,DWORD PTR [rip+0x0]        # 185 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x185>
     185:	vaddss xmm1,xmm1,DWORD PTR [rip+0x0]        # 18d <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x18d>
     18d:	mov    QWORD PTR [rsp+0xb8],rax
     195:	vsubss xmm0,xmm0,xmm3
     199:	vsubss xmm1,xmm1,xmm2
     19d:	vmulss xmm2,xmm0,xmm1
        p.B = dx       * (1 - dy);
     1a1:	vmulss xmm1,xmm1,xmm5
        p.C = (1 - dx) * dy;
     1a5:	vmulss xmm0,xmm0,xmm6
        p.D = dx       * dy;
     1a9:	vmulss xmm5,xmm5,xmm6
       */
      _GLIBCXX20_CONSTEXPR
      void
      push_back(const value_type& __x)
      {
	if (this->_M_impl._M_finish != this->_M_impl._M_end_of_storage)
     1ad:	cmp    QWORD PTR [rsp+0xd0],r12
     1b5:	je     1413 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x1413>
      template<typename _Up, typename... _Args>
	__attribute__((__always_inline__))
	void
	construct(_Up* __p, _Args&&... __args)
	noexcept(__is_nothrow_new_constructible<_Up, _Args...>)
	{ ::new((void *)__p) _Up(std::forward<_Args>(__args)...); }
     1bb:	vunpcklps xmm0,xmm0,xmm5
     1bf:	vunpcklps xmm2,xmm2,xmm1
     1c3:	mov    DWORD PTR [r12],r10d
	  {
	    _GLIBCXX_ASAN_ANNOTATE_GROW(1);
	    _Alloc_traits::construct(this->_M_impl, this->_M_impl._M_finish,
				     __x);
	    ++this->_M_impl._M_finish;
     1c7:	add    r12,0x30
     1cb:	mov    DWORD PTR [r12-0x2c],r8d
     1d0:	vmovlhps xmm2,xmm2,xmm0
     1d4:	mov    DWORD PTR [r12-0x18],esi
     1d9:	mov    DWORD PTR [r12-0x14],ebx
     1de:	mov    DWORD PTR [r12-0x10],r11d
     1e3:	mov    DWORD PTR [r12-0xc],r14d
     1e8:	mov    QWORD PTR [r12-0x8],rax
     1ed:	vmovups XMMWORD PTR [r12-0x28],xmm2
      __attribute__((__always_inline__))
      _GLIBCXX14_CONSTEXPR
      __normal_iterator&
      operator++() _GLIBCXX_NOEXCEPT
      {
	++_M_current;
     1f4:	add    rcx,0x30
    for (auto& sub : subapertures) {
     1f8:	cmp    rcx,QWORD PTR [rsp+0xd8]
     200:	jne    108 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x108>
	ptrdiff_t __n = _M_impl._M_end_of_storage - _M_impl._M_start;
     206:	mov    rax,QWORD PTR [rsp+0xd0]
     20e:	sub    rax,QWORD PTR [rsp+0x60]
     213:	mov    QWORD PTR [rsp+0x20],rax

      // Called by constructors to check initial size.
      static _GLIBCXX20_CONSTEXPR size_type
      _S_check_init_len(size_type __n, const allocator_type& __a)
      {
	if (__n > _S_max_size(_Tp_alloc_type(__a)))
     218:	mov    rax,QWORD PTR [rsp+0x38]
     21d:	shr    rax,0x3d
     221:	jne    227 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x227>
	return __n != 0 ? _Tr::allocate(_M_impl, __n) : pointer();
     227:	mov    rax,QWORD PTR [rsp+0x38]
     22c:	test   rax,rax
     22f:	je     12e3 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x12e3>
	  return static_cast<_Tp*>(_GLIBCXX_OPERATOR_NEW(__n * sizeof(_Tp)));
     235:	lea    rbx,[rax*4+0x0]
     23d:	mov    rdi,rbx
     240:	mov    QWORD PTR [rsp+0x18],rbx
     245:	call   24a <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x24a>
	  // Allow std::_Construct to be used in constant expressions.
	  std::construct_at(__p, std::forward<_Args>(__args)...);
	  return;
	}
#endif
      ::new(static_cast<void*>(__p)) _Tp(std::forward<_Args>(__args)...);
     24a:	mov    rdx,rbx
     24d:	xor    esi,esi
     24f:	mov    rdi,rax
     252:	mov    QWORD PTR [rsp+0x40],rax
     257:	call   25c <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x25c>
        params.push_back(p);
    }

    // Precalculate counts
    std::vector<int> counts(width * height, 0);
    std::vector<int> diff((width + 1) * (height + 1), 0);
     25c:	mov    rax,QWORD PTR [rsp+0x68]
     261:	lea    r14,[rax+0x1]
     265:	mov    rax,QWORD PTR [rsp+0xb0]
     26d:	inc    rax
     270:	imul   rax,r14
     274:	mov    QWORD PTR [rsp+0x30],rax
	if (__n > _S_max_size(_Tp_alloc_type(__a)))
     279:	shr    rax,0x3d
     27d:	jne    283 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x283>
	return __n != 0 ? _Tr::allocate(_M_impl, __n) : pointer();
     283:	mov    rax,QWORD PTR [rsp+0x30]
     288:	test   rax,rax
     28b:	je     15f9 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x15f9>
     291:	shl    rax,0x2
     295:	mov    rdi,rax
     298:	mov    QWORD PTR [rsp+0x30],rax
     29d:	call   2a2 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x2a2>
     2a2:	mov    rdx,QWORD PTR [rsp+0x30]
     2a7:	xor    esi,esi
     2a9:	mov    rdi,rax
     2ac:	mov    rbx,rax
     2af:	call   2b4 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x2b4>

    for (const auto& p : params) {
     2b4:	mov    rax,QWORD PTR [rsp+0x60]
     2b9:	cmp    rax,r12
     2bc:	je     2fc <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x2fc>
     2be:	xchg   ax,ax
        diff[p.y_begin * (width + 1) + p.x_begin] += 1;
     2c0:	movsxd rdx,DWORD PTR [rax+0x20]
     2c4:	movsxd rsi,DWORD PTR [rax+0x18]
     2c8:	add    rax,0x30
        diff[p.y_begin * (width + 1) + p.x_end  ] -= 1;
        diff[p.y_end   * (width + 1) + p.x_begin] -= 1;
     2cc:	movsxd rdi,DWORD PTR [rax-0xc]
        diff[p.y_begin * (width + 1) + p.x_begin] += 1;
     2d0:	imul   rdx,r14
        diff[p.y_end   * (width + 1) + p.x_begin] -= 1;
     2d4:	imul   rdi,r14
        diff[p.y_begin * (width + 1) + p.x_begin] += 1;
     2d8:	lea    rcx,[rdx+rsi*1]
     2dc:	inc    DWORD PTR [rbx+rcx*4]
        diff[p.y_begin * (width + 1) + p.x_end  ] -= 1;
     2df:	movsxd rcx,DWORD PTR [rax-0x14]
     2e3:	add    rdx,rcx
     2e6:	dec    DWORD PTR [rbx+rdx*4]
        diff[p.y_end   * (width + 1) + p.x_begin] -= 1;
     2e9:	lea    rdx,[rsi+rdi*1]
     2ed:	dec    DWORD PTR [rbx+rdx*4]
        diff[p.y_end   * (width + 1) + p.x_end  ] += 1;
     2f0:	lea    rdx,[rcx+rdi*1]
     2f4:	inc    DWORD PTR [rbx+rdx*4]
    for (const auto& p : params) {
     2f7:	cmp    rax,r12
     2fa:	jne    2c0 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x2c0>
    }

    for (int y = 0; y < h; ++y) {
     2fc:	vxorps xmm5,xmm5,xmm5
     300:	test   r13d,r13d
     303:	jle    1638 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x1638>
     309:	test   r15d,r15d
     30c:	jle    3ce <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x3ce>
        int row = 0;
        for (int x = 0; x < w; ++x) {
     312:	mov    rax,QWORD PTR [rsp+0x68]
        int row = 0;
     317:	xor    edx,edx
     319:	lea    ecx,[rax-0x1]
    for (int y = 0; y < h; ++y) {
     31c:	xor    eax,eax
     31e:	lea    r8,[rcx+0x1]
     322:	mov    rcx,QWORD PTR [rsp+0x40]
            row += diff[y * (width + 1) + x];
     327:	add    edx,DWORD PTR [rbx+rax*4]
            counts[y * w + x] = row + (y > 0 ? counts[(y - 1) * w + x] : 0);
     32a:	mov    DWORD PTR [rcx+rax*4],edx
        for (int x = 0; x < w; ++x) {
     32d:	inc    rax
     330:	cmp    rax,r8
     333:	jne    327 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x327>
    for (int y = 0; y < h; ++y) {
     335:	cmp    r13d,0x1
     339:	je     3ce <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x3ce>
     33f:	lea    rax,[r14*4+0x0]
     347:	mov    rsi,QWORD PTR [rsp+0x40]
        for (int x = 0; x < w; ++x) {
     34c:	xor    ecx,ecx
    for (int y = 0; y < h; ++y) {
     34e:	mov    r11d,0x1
     354:	mov    QWORD PTR [rsp+0xd8],rax
     35c:	lea    rdi,[rbx+rax*1]
     360:	mov    eax,r15d
     363:	shl    rax,0x2
     367:	mov    QWORD PTR [rsp+0xb8],rax
     36f:	add    rsi,rax
        for (int x = 0; x < w; ++x) {
     372:	mov    rdx,QWORD PTR [rsp+0x40]
     377:	movsxd rax,ecx
     37a:	add    ecx,DWORD PTR [rsp+0x68]
     37e:	lea    r10,[rdx+rax*4]
    for (int y = 0; y < h; ++y) {
     382:	xor    eax,eax
        int row = 0;
     384:	xor    edx,edx
     386:	data16 cs nop WORD PTR [rax+rax*1+0x0]
     391:	data16 cs nop WORD PTR [rax+rax*1+0x0]
     39c:	nop    DWORD PTR [rax+0x0]
            counts[y * w + x] = row + (y > 0 ? counts[(y - 1) * w + x] : 0);
     3a0:	mov    r9d,DWORD PTR [r10+rax*4]
            row += diff[y * (width + 1) + x];
     3a4:	add    edx,DWORD PTR [rdi+rax*4]
            counts[y * w + x] = row + (y > 0 ? counts[(y - 1) * w + x] : 0);
     3a7:	add    r9d,edx
     3aa:	mov    DWORD PTR [rsi+rax*4],r9d
        for (int x = 0; x < w; ++x) {
     3ae:	inc    rax
     3b1:	cmp    r8,rax
     3b4:	jne    3a0 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x3a0>
    for (int y = 0; y < h; ++y) {
     3b6:	inc    r11d
     3b9:	add    rdi,QWORD PTR [rsp+0xd8]
     3c1:	add    rsi,QWORD PTR [rsp+0xb8]
     3c9:	cmp    r13d,r11d
     3cc:	jg     372 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x372>
	if (__n > _S_max_size(_Tp_alloc_type(__a)))
     3ce:	mov    rax,QWORD PTR [rsp+0xc0]
     3d6:	shr    rax,0x3d
     3da:	jne    3e0 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x3e0>
	return __n != 0 ? _Tr::allocate(_M_impl, __n) : pointer();
     3e0:	cmp    QWORD PTR [rsp+0x38],0x0
     3e6:	je     1600 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x1600>
     3ec:	mov    rdx,QWORD PTR [rsp+0x98]
     3f4:	vmovaps XMMWORD PTR [rsp+0xc0],xmm5
     3fd:	add    rdx,QWORD PTR [rsp+0x38]
     402:	shl    rdx,0x2
     406:	mov    rdi,rdx
     409:	mov    QWORD PTR [rsp+0xd8],rdx
     411:	mov    QWORD PTR [rsp+0x38],rdx
     416:	call   41b <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x41b>
     41b:	mov    rdx,QWORD PTR [rsp+0xd8]
     423:	mov    rdi,rax
     426:	xor    esi,esi
     428:	call   42d <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x42d>
    }

    // Full-image float accumulator (no tiling)
    std::vector<float> vals(width * height * 3, 0.0f);

    for (const SubParams& p : params) {
     42d:	cmp    QWORD PTR [rsp+0x60],r12
     432:	vmovaps xmm5,XMMWORD PTR [rsp+0xc0]
     43b:	mov    rdi,rax
     43e:	je     1616 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x1616>
        const __m256 Cvx = _mm256_set1_ps(p.C);
        const __m256 Dvx = _mm256_set1_ps(p.D);

        for (int y = p.y_begin; y < p.y_end; ++y) {
            size_t ind_ltop = ((y + p.sy) * width + (p.x_begin + p.sx)) * 3;
            size_t ind_lbot = ind_ltop + width * 3;
     444:	mov    rsi,QWORD PTR [rsp+0x68]
     449:	mov    rdx,QWORD PTR [rsp+0x60]
     44e:	mov    DWORD PTR [rsp+0x14],r13d
     453:	mov    QWORD PTR [rsp+0x48],r14
     458:	lea    rax,[rsi+rsi*1]
     45c:	mov    QWORD PTR [rsp+0xa0],rdx
     464:	add    rsi,rax
     467:	mov    QWORD PTR [rsp+0x58],r12
     46c:	mov    QWORD PTR [rsp+0x90],rsi
     474:	shl    rsi,0x2
     478:	mov    QWORD PTR [rsp+0x88],rsi
     480:	mov    QWORD PTR [rsp+0x50],rdi
     485:	mov    QWORD PTR [rsp+0x8],rbx
     48a:	mov    DWORD PTR [rsp+0x10],r15d
     48f:	mov    QWORD PTR [rsp],rax
     493:	nop    DWORD PTR [rax+rax*1+0x0]
        for (int y = p.y_begin; y < p.y_end; ++y) {
     498:	mov    rax,QWORD PTR [rsp+0xa0]
     4a0:	mov    edi,DWORD PTR [rax+0x20]
     4a3:	mov    esi,DWORD PTR [rax+0x24]
     4a6:	mov    DWORD PTR [rsp+0xc0],edi
     4ad:	mov    DWORD PTR [rsp+0x98],esi
     4b4:	cmp    edi,esi
     4b6:	jge    1100 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x1100>
            float* vp = vals.data()
                        + (size_t)y * width * 3
                        + (size_t)p.x_begin * 3;

            int x = 0;
            const int x_stop = (p.x_end - p.x_begin) * 3;
     4bc:	mov    ebx,DWORD PTR [rax+0x1c]
            size_t ind_ltop = ((y + p.sy) * width + (p.x_begin + p.sx)) * 3;
     4bf:	movsxd r8,DWORD PTR [rax+0x18]
        const __m256 Avx = _mm256_set1_ps(p.A);
     4c3:	vmovss xmm18,DWORD PTR [rax+0x8]
        const __m256 Bvx = _mm256_set1_ps(p.B);
     4ca:	vmovss xmm17,DWORD PTR [rax+0xc]
            const int x_stop = (p.x_end - p.x_begin) * 3;
     4d1:	mov    edx,ebx
        const __m256 Cvx = _mm256_set1_ps(p.C);
     4d3:	vmovss xmm16,DWORD PTR [rax+0x10]
        const __m256 Dvx = _mm256_set1_ps(p.D);
     4da:	vmovss xmm15,DWORD PTR [rax+0x14]
            const int x_stop = (p.x_end - p.x_begin) * 3;
     4df:	mov    DWORD PTR [rsp+0xd8],ebx
            size_t ind_ltop = ((y + p.sy) * width + (p.x_begin + p.sx)) * 3;
     4e6:	mov    esi,DWORD PTR [rax]
     4e8:	movsxd r9,DWORD PTR [rax+0x4]
            const int x_stop = (p.x_end - p.x_begin) * 3;
     4ec:	sub    edx,r8d
        const __m256 Avx = _mm256_set1_ps(p.A);
     4ef:	vbroadcastss ymm11,xmm18
     4f5:	mov    rax,QWORD PTR [rsp+0x68]
            const int x_stop = (p.x_end - p.x_begin) * 3;
     4fa:	lea    ebx,[rdx+rdx*2]
     4fd:	movsxd rdx,edi
        const __m256 Bvx = _mm256_set1_ps(p.B);
     500:	vbroadcastss ymm12,xmm17
     506:	add    r9,rdx
            size_t ind_ltop = ((y + p.sy) * width + (p.x_begin + p.sx)) * 3;
     509:	add    esi,r8d
            const int x_stop = (p.x_end - p.x_begin) * 3;
     50c:	mov    DWORD PTR [rsp+0xb0],ebx
        const __m256 Cvx = _mm256_set1_ps(p.C);
     513:	vbroadcastss ymm13,xmm16
     519:	imul   rdx,rax
        const __m256 Dvx = _mm256_set1_ps(p.D);
     51d:	vbroadcastss ymm10,xmm15
/* Create a vector with all elements equal to A.  */
extern __inline __m256 __attribute__((__gnu_inline__, __always_inline__, __artificial__))
_mm256_set1_ps (float __A)
{
  return __extension__ (__m256){ __A, __A, __A, __A,
				 __A, __A, __A, __A };
     522:	vmovaps ymm3,ymm11
            size_t ind_ltop = ((y + p.sy) * width + (p.x_begin + p.sx)) * 3;
     526:	movsxd rsi,esi
     529:	imul   r9,rax
     52d:	mov    rax,QWORD PTR [rsp+0x50]
     532:	vmovaps ymm2,ymm12
     536:	vmovaps ymm1,ymm13
     53a:	vmovaps ymm0,ymm10
     53e:	add    rdx,r8
     541:	lea    rdx,[rdx+rdx*2]
     545:	lea    r10,[rsi+r9*1]
     549:	add    rsi,QWORD PTR [rsp+0x48]
     54e:	lea    rax,[rax+rdx*4]
     552:	lea    edx,[rbx-0x10]
     555:	add    rsi,r9
     558:	mov    QWORD PTR [rsp+0xa8],rax
     560:	mov    eax,edx
     562:	shr    edx,0x4
     565:	lea    rdi,[rsi+rsi*2]
     569:	and    eax,0xfffffff0
     56c:	inc    rdx
     56f:	mov    QWORD PTR [rsp+0xb8],rdi
     577:	lea    r14,[r10+r10*2]
     57b:	mov    DWORD PTR [rsp+0x80],eax

                vp += 16;
                ind_ltop += 16; ind_lbot += 16;
                ind_rtop += 16; ind_rbot += 16;
            }
            if(x + 8 <= x_stop) {
     582:	add    eax,0x17
     585:	mov    DWORD PTR [rsp+0x84],eax
     58c:	mov    rax,rdx
     58f:	shl    rdx,0x4
     593:	shl    rax,0x6
     597:	mov    QWORD PTR [rsp+0x70],rdx
     59c:	mov    QWORD PTR [rsp+0x78],rax
     5a1:	nop    DWORD PTR [rax+0x0]
            size_t ind_lbot = ind_ltop + width * 3;
     5a8:	mov    rax,QWORD PTR [rsp+0xb8]
            for (; x + 16 <= x_stop; x += 16) {
     5b0:	cmp    DWORD PTR [rsp+0xb0],0xf
            size_t ind_rtop = ind_ltop + 3;
     5b8:	lea    r8,[r14+0x3]
                        + (size_t)p.x_begin * 3;
     5bc:	mov    rdx,QWORD PTR [rsp+0xa8]
            size_t ind_lbot = ind_ltop + width * 3;
     5c4:	lea    rsi,[rax-0x3]
            for (; x + 16 <= x_stop; x += 16) {
     5c8:	jle    1300 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x1300>
     5ce:	mov    rax,QWORD PTR [rsp+0xa0]
     5d6:	mov    rcx,QWORD PTR [rsp+0x78]
     5db:	mov    rdi,QWORD PTR [rax+0x28]
     5df:	lea    r9,[rdx+rcx*1]
     5e3:	lea    rax,[rdi+rsi*1]
     5e7:	nop    WORD PTR [rax+rax*1+0x0]
}

extern __inline __m128i __attribute__((__gnu_inline__, __always_inline__, __artificial__))
_mm_loadl_epi64 (__m128i_u const *__P)
{
  return _mm_set_epi64 ((__m64)0LL, *(__m64_u *)__P);
     5f0:	mov    rcx,rax

extern __inline __m256i
__attribute__ ((__gnu_inline__, __always_inline__, __artificial__))
_mm256_cvtepu8_epi32 (__m128i __X)
{
  return (__m256i) __builtin_ia32_pmovzxbd256 ((__v16qi)__X);
     5f3:	vpmovzxbd ymm8,QWORD PTR [rax]
     5f8:	vpmovzxbd ymm7,QWORD PTR [rax+0x8]
                vp += 16;
     5fe:	add    rdx,0x40
     602:	sub    rcx,rsi
     605:	vpmovzxbd ymm6,QWORD PTR [rax+0x3]
     60b:	vpmovzxbd ymm4,QWORD PTR [rax+0xb]
            for (; x + 16 <= x_stop; x += 16) {
     611:	add    rax,0x10
     615:	vpmovzxbd ymm20,QWORD PTR [rcx+r14*1]
     61c:	vpmovzxbd ymm19,QWORD PTR [rcx+r14*1+0x8]
  return (__m256)__builtin_ia32_cvtdq2ps256 ((__v8si) __A);
     624:	vcvtdq2ps ymm8,ymm8
     629:	vcvtdq2ps ymm7,ymm7
     62d:	vpmovzxbd ymm14,QWORD PTR [rcx+r14*1+0x3]
     634:	vpmovzxbd ymm9,QWORD PTR [rcx+r14*1+0xb]
     63b:	vcvtdq2ps ymm6,ymm6
     63f:	vcvtdq2ps ymm4,ymm4
     643:	vcvtdq2ps ymm20,ymm20
     649:	vcvtdq2ps ymm19,ymm19

extern __inline __m256
__attribute__((__gnu_inline__, __always_inline__, __artificial__))
_mm256_fmadd_ps (__m256 __A, __m256 __B, __m256 __C)
{
  return (__m256)__builtin_ia32_vfmaddps256 ((__v8sf)__A, (__v8sf)__B,
     64f:	vfmadd213ps ymm20,ymm3,YMMWORD PTR [rdx-0x40]
     656:	vfmadd213ps ymm19,ymm3,YMMWORD PTR [rdx-0x20]
     65d:	vcvtdq2ps ymm14,ymm14
     662:	vcvtdq2ps ymm9,ymm9
     667:	vfmadd132ps ymm14,ymm20,ymm2
     66d:	vfmadd132ps ymm9,ymm19,ymm2
     673:	vfmadd132ps ymm8,ymm14,ymm1
     678:	vfmadd132ps ymm7,ymm9,ymm1
     67d:	vfmadd132ps ymm6,ymm8,ymm0
     682:	vfmadd132ps ymm4,ymm7,ymm0
  *(__m256_u *)__P = __A;
     687:	vmovups YMMWORD PTR [rdx-0x40],ymm6
     68c:	vmovups YMMWORD PTR [rdx-0x20],ymm4
     691:	cmp    rdx,r9
     694:	jne    5f0 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x5f0>
     69a:	mov    rax,QWORD PTR [rsp+0x70]
     69f:	mov    rbx,QWORD PTR [rsp+0xb8]
            if(x + 8 <= x_stop) {
     6a7:	mov    r10d,DWORD PTR [rsp+0x84]
     6af:	add    rbx,rax
     6b2:	add    r8,rax
     6b5:	add    rsi,rax
     6b8:	add    rax,r14
     6bb:	mov    QWORD PTR [rsp+0xd0],rbx
     6c3:	mov    ebx,DWORD PTR [rsp+0x80]
     6ca:	mov    QWORD PTR [rsp+0xd8],rax
     6d2:	lea    eax,[rbx+0x10]
     6d5:	cmp    DWORD PTR [rsp+0xb0],r10d
     6dd:	jle    759 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x759>
     6df:	mov    rbx,QWORD PTR [rsp+0xd8]
     6e7:	vpmovzxbd ymm7,QWORD PTR [rdi+r8*1]
                val = _mm256_fmadd_ps(Bvx, rtop_f, val);
                val = _mm256_fmadd_ps(Cvx, lbot_f, val);
                val = _mm256_fmadd_ps(Dvx, rbot_f, val);
                _mm256_storeu_ps(vp, val);

                vp += 8;
     6ed:	add    rdx,0x20
                ind_ltop += 8; ind_lbot += 8;
                ind_rtop += 8; ind_rbot += 8;
     6f1:	add    r8,0x8
     6f5:	vpmovzxbd ymm6,QWORD PTR [rdi+rsi*1]
     6fb:	mov    rcx,QWORD PTR [rsp+0xd0]
                ind_ltop += 8; ind_lbot += 8;
     703:	add    rsi,0x8
                x += 8;
     707:	add    eax,0x8
     70a:	vpmovzxbd ymm8,QWORD PTR [rdi+rbx*1]
  return (__m256)__builtin_ia32_cvtdq2ps256 ((__v8si) __A);
     710:	vcvtdq2ps ymm7,ymm7
                ind_ltop += 8; ind_lbot += 8;
     714:	add    rbx,0x8
     718:	vcvtdq2ps ymm6,ymm6
     71c:	vpmovzxbd ymm4,QWORD PTR [rdi+rcx*1]
                ind_rtop += 8; ind_rbot += 8;
     722:	add    rcx,0x8
                ind_ltop += 8; ind_lbot += 8;
     726:	mov    QWORD PTR [rsp+0xd8],rbx
     72e:	vcvtdq2ps ymm8,ymm8
     733:	vfmadd213ps ymm8,ymm3,YMMWORD PTR [rdx-0x20]
                ind_rtop += 8; ind_rbot += 8;
     739:	mov    QWORD PTR [rsp+0xd0],rcx
     741:	vcvtdq2ps ymm4,ymm4
     745:	vfmadd132ps ymm7,ymm8,ymm2
     74a:	vfmadd132ps ymm6,ymm7,ymm1
     74f:	vfmadd132ps ymm4,ymm6,ymm0
  *(__m256_u *)__P = __A;
     754:	vmovups YMMWORD PTR [rdx-0x20],ymm4
            }
            // Handle tail
            int remaining = x_stop - x;
     759:	mov    r10d,DWORD PTR [rsp+0xb0]
     761:	sub    r10d,eax
            for (int k = 0; k < remaining; ++k) {
     764:	test   r10d,r10d
     767:	jle    10c2 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x10c2>
     76d:	lea    eax,[r10-0x1]
     771:	cmp    eax,0x1e
     774:	jbe    1365 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x1365>
     77a:	mov    rax,QWORD PTR [rsp+0xd0]
     782:	mov    r15d,r10d
     785:	lea    r12,[rdi+rsi*1]
     789:	lea    rbx,[rdi+r8*1]
     78d:	shr    r15d,0x5
                float TL = p.SUB[ind_ltop + k];
     791:	xor    ecx,ecx
     793:	lea    r13,[rdi+rax*1]
     797:	mov    rax,QWORD PTR [rsp+0xd8]
     79f:	mov    r9d,r15d
     7a2:	shl    r9,0x5
     7a6:	lea    r11,[rdi+rax*1]
     7aa:	mov    rax,rdx
     7ad:	nop    DWORD PTR [rax]
                float TR = p.SUB[ind_rtop + k];
                float BL = p.SUB[ind_lbot + k];
     7b0:	vmovdqu ymm4,YMMWORD PTR [r12+rcx*1]
                float TR = p.SUB[ind_rtop + k];
     7b6:	vmovdqu ymm6,YMMWORD PTR [rbx+rcx*1]
     7bb:	sub    rax,0xffffffffffffff80
                float TL = p.SUB[ind_ltop + k];
     7bf:	vmovdqu ymm7,YMMWORD PTR [r11+rcx*1]
                float BL = p.SUB[ind_lbot + k];
     7c5:	vpmovzxbw ymm9,xmm4
                float TR = p.SUB[ind_rtop + k];
     7ca:	vpmovzxbw ymm8,xmm6
                float BL = p.SUB[ind_lbot + k];
     7cf:	vextracti32x4 xmm4,ymm4,0x1
     7d6:	vpmovsxwd ymm19,xmm9
     7dc:	vextracti32x4 xmm9,ymm9,0x1
                float TR = p.SUB[ind_rtop + k];
     7e3:	vpmovsxwd ymm14,xmm8
                float BL = p.SUB[ind_lbot + k];
     7e8:	vpmovsxwd ymm9,xmm9
                float TR = p.SUB[ind_rtop + k];
     7ed:	vextracti32x4 xmm8,ymm8,0x1
                float BL = p.SUB[ind_lbot + k];
     7f4:	vpmovzxbw ymm4,xmm4
     7f9:	vcvtdq2ps ymm19,ymm19
                float TR = p.SUB[ind_rtop + k];
     7ff:	vcvtdq2ps ymm14,ymm14
                float BL = p.SUB[ind_lbot + k];
     804:	vcvtdq2ps ymm9,ymm9
                float BR = p.SUB[ind_rbot + k];
                vp[k] += p.A*TL + p.B*TR + p.C*BL + p.D*BR;
     809:	vmulps ymm9,ymm9,ymm1
                float TR = p.SUB[ind_rtop + k];
     80d:	vpmovsxwd ymm8,xmm8
     812:	vextracti32x4 xmm6,ymm6,0x1
                vp[k] += p.A*TL + p.B*TR + p.C*BL + p.D*BR;
     819:	vmulps ymm19,ymm19,ymm1
                float TR = p.SUB[ind_rtop + k];
     81f:	vcvtdq2ps ymm8,ymm8
     824:	vpmovzxbw ymm6,xmm6
                float TL = p.SUB[ind_ltop + k];
     829:	vpmovzxbw ymm22,xmm7
     82f:	vextracti32x4 xmm7,ymm7,0x1
     836:	vpmovzxbw ymm7,xmm7
                float BL = p.SUB[ind_lbot + k];
     83b:	vfmadd132ps ymm8,ymm9,ymm2
     840:	vpmovsxwd ymm9,xmm4
     845:	vextracti32x4 xmm4,ymm4,0x1
     84c:	vcvtdq2ps ymm9,ymm9
                vp[k] += p.A*TL + p.B*TR + p.C*BL + p.D*BR;
     851:	vmulps ymm9,ymm9,ymm1
     855:	vfmadd132ps ymm14,ymm19,ymm2
                float BL = p.SUB[ind_lbot + k];
     85b:	vpmovsxwd ymm4,xmm4
     860:	vcvtdq2ps ymm4,ymm4
                vp[k] += p.A*TL + p.B*TR + p.C*BL + p.D*BR;
     864:	vmulps ymm4,ymm4,ymm1
                float TR = p.SUB[ind_rtop + k];
     868:	vpmovsxwd ymm19,xmm6
     86e:	vextracti32x4 xmm6,ymm6,0x1
     875:	vcvtdq2ps ymm19,ymm19
     87b:	vpmovsxwd ymm6,xmm6
     880:	vcvtdq2ps ymm6,ymm6
     884:	vfmadd132ps ymm19,ymm9,ymm2
                float TL = p.SUB[ind_ltop + k];
     88a:	vpmovsxwd ymm9,xmm22
     890:	vcvtdq2ps ymm9,ymm9
     895:	vfmadd213ps ymm9,ymm3,YMMWORD PTR [rax-0x80]
     89b:	vfmadd132ps ymm6,ymm4,ymm2
                float BR = p.SUB[ind_rbot + k];
     8a0:	vmovdqu ymm4,YMMWORD PTR [r13+rcx*1+0x0]
     8a7:	add    rcx,0x20
     8ab:	vpmovzxbw ymm21,xmm4
     8b1:	vextracti32x4 xmm4,ymm4,0x1
     8b8:	vpmovsxwd ymm20,xmm21
     8be:	vextracti32x4 xmm21,ymm21,0x1
     8c5:	vpmovzxbw ymm4,xmm4
     8ca:	vcvtdq2ps ymm20,ymm20
     8d0:	vpmovsxwd ymm21,xmm21
     8d6:	vfmadd132ps ymm20,ymm9,ymm0
                float TL = p.SUB[ind_ltop + k];
     8dc:	vextracti32x4 xmm9,ymm22,0x1
     8e3:	vpmovsxwd ymm22,xmm7
                float BR = p.SUB[ind_rbot + k];
     8e9:	vcvtdq2ps ymm21,ymm21
                float TL = p.SUB[ind_ltop + k];
     8ef:	vpmovsxwd ymm9,xmm9
     8f4:	vextracti32x4 xmm7,ymm7,0x1
     8fb:	vcvtdq2ps ymm22,ymm22
     901:	vcvtdq2ps ymm9,ymm9
     906:	vfmadd213ps ymm9,ymm3,YMMWORD PTR [rax-0x60]
     90c:	vfmadd213ps ymm22,ymm3,YMMWORD PTR [rax-0x40]
     913:	vpmovsxwd ymm7,xmm7
     918:	vcvtdq2ps ymm7,ymm7
                vp[k] += p.A*TL + p.B*TR + p.C*BL + p.D*BR;
     91c:	vfmadd213ps ymm7,ymm3,YMMWORD PTR [rax-0x20]
     922:	vaddps ymm14,ymm14,ymm20
     928:	vfmadd132ps ymm21,ymm9,ymm0
                float BR = p.SUB[ind_rbot + k];
     92e:	vpmovsxwd ymm9,xmm4
     933:	vextracti32x4 xmm4,ymm4,0x1
     93a:	vpmovsxwd ymm4,xmm4
     93f:	vcvtdq2ps ymm9,ymm9
     944:	vfmadd132ps ymm9,ymm22,ymm0
                vp[k] += p.A*TL + p.B*TR + p.C*BL + p.D*BR;
     94a:	vmovups YMMWORD PTR [rax-0x80],ymm14
                float BR = p.SUB[ind_rbot + k];
     94f:	vcvtdq2ps ymm4,ymm4
                vp[k] += p.A*TL + p.B*TR + p.C*BL + p.D*BR;
     953:	vfmadd132ps ymm4,ymm7,ymm0
     958:	vaddps ymm8,ymm8,ymm21
     95e:	vaddps ymm19,ymm19,ymm9
     964:	vaddps ymm4,ymm4,ymm6
     968:	vmovups YMMWORD PTR [rax-0x60],ymm8
     96d:	vmovups YMMWORD PTR [rax-0x40],ymm19
     974:	vmovups YMMWORD PTR [rax-0x20],ymm4
            for (int k = 0; k < remaining; ++k) {
     979:	cmp    rcx,r9
     97c:	jne    7b0 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x7b0>
     982:	shl    r15d,0x5
     986:	cmp    r15d,r10d
     989:	je     10c2 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x10c2>
     98f:	mov    r9d,r10d
     992:	mov    eax,r15d
     995:	sub    r9d,r15d
     998:	lea    ecx,[r9-0x1]
     99c:	cmp    ecx,0xe
     99f:	jbe    137d <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x137d>
                float TL = p.SUB[ind_ltop + k];
     9a5:	mov    r13,QWORD PTR [rsp+0xd8]
     9ad:	mov    r11d,r15d
     9b0:	mov    rbx,QWORD PTR [rsp+0xd0]
     9b8:	lea    rcx,[rdx+r11*4]
     9bc:	lea    r12,[rdi+r13*1]
     9c0:	add    rbx,r11
     9c3:	vmovdqu xmm7,XMMWORD PTR [r12+r11*1]
                float TR = p.SUB[ind_rtop + k];
     9c9:	lea    r12,[rdi+r11*1]
     9cd:	vmovdqu xmm6,XMMWORD PTR [r12+r8*1]
                float BL = p.SUB[ind_lbot + k];
     9d3:	lea    r12,[rdi+rsi*1]
     9d7:	vmovdqu xmm4,XMMWORD PTR [r12+r11*1]
                float TL = p.SUB[ind_ltop + k];
     9dd:	vpmovzxbw xmm9,xmm7
     9e2:	vpsrldq xmm7,xmm7,0x8
                float TR = p.SUB[ind_rtop + k];
     9e7:	vpmovzxbw xmm8,xmm6
     9ec:	vpsrldq xmm6,xmm6,0x8
                float TL = p.SUB[ind_ltop + k];
     9f1:	vpmovsxwd xmm22,xmm9
                float BL = p.SUB[ind_lbot + k];
     9f7:	vpmovzxbw xmm14,xmm4
     9fc:	vpsrldq xmm4,xmm4,0x8
                float TR = p.SUB[ind_rtop + k];
     a01:	vpmovsxwd xmm19,xmm8
                float TL = p.SUB[ind_ltop + k];
     a07:	vcvtdq2ps xmm22,xmm22
                float BL = p.SUB[ind_lbot + k];
     a0d:	vpmovsxwd xmm20,xmm14
     a13:	vpsrldq xmm14,xmm14,0x8
     a19:	vpmovzxbw xmm4,xmm4
                float TR = p.SUB[ind_rtop + k];
     a1e:	vcvtdq2ps xmm19,xmm19
                float BL = p.SUB[ind_lbot + k];
     a24:	vcvtdq2ps xmm20,xmm20
                vp[k] += p.A*TL + p.B*TR + p.C*BL + p.D*BR;
     a2a:	vmulps xmm20,xmm20,xmm13
                float BL = p.SUB[ind_lbot + k];
     a30:	vpmovsxwd xmm14,xmm14
                float TR = p.SUB[ind_rtop + k];
     a35:	vpmovzxbw xmm6,xmm6
                float BL = p.SUB[ind_lbot + k];
     a3a:	vcvtdq2ps xmm14,xmm14
                vp[k] += p.A*TL + p.B*TR + p.C*BL + p.D*BR;
     a3f:	vmulps xmm14,xmm14,xmm13
                float TR = p.SUB[ind_rtop + k];
     a44:	vpsrldq xmm8,xmm8,0x8
                float TL = p.SUB[ind_ltop + k];
     a4a:	vpmovzxbw xmm7,xmm7
                float BL = p.SUB[ind_lbot + k];
     a4f:	vfmadd213ps xmm22,xmm11,XMMWORD PTR [rcx]
                float TL = p.SUB[ind_ltop + k];
     a55:	vpsrldq xmm9,xmm9,0x8
                float TR = p.SUB[ind_rtop + k];
     a5b:	vpmovsxwd xmm8,xmm8
     a60:	vcvtdq2ps xmm8,xmm8
                float TL = p.SUB[ind_ltop + k];
     a65:	vpmovsxwd xmm9,xmm9
     a6a:	vcvtdq2ps xmm9,xmm9
     a6f:	vfmadd213ps xmm9,xmm11,XMMWORD PTR [rcx+0x10]
     a75:	vfmadd132ps xmm19,xmm20,xmm12
                float BL = p.SUB[ind_lbot + k];
     a7b:	vpmovsxwd xmm20,xmm4
     a81:	vpsrldq xmm4,xmm4,0x8
     a86:	vfmadd132ps xmm8,xmm14,xmm12
     a8b:	vcvtdq2ps xmm20,xmm20
                float TR = p.SUB[ind_rtop + k];
     a91:	vpmovsxwd xmm14,xmm6
                vp[k] += p.A*TL + p.B*TR + p.C*BL + p.D*BR;
     a96:	vmulps xmm20,xmm20,xmm13
                float TR = p.SUB[ind_rtop + k];
     a9c:	vpsrldq xmm6,xmm6,0x8
                float BL = p.SUB[ind_lbot + k];
     aa1:	vpmovsxwd xmm4,xmm4
                float TR = p.SUB[ind_rtop + k];
     aa6:	vcvtdq2ps xmm14,xmm14
                float BL = p.SUB[ind_lbot + k];
     aab:	vcvtdq2ps xmm4,xmm4
                vp[k] += p.A*TL + p.B*TR + p.C*BL + p.D*BR;
     aaf:	vmulps xmm4,xmm4,xmm13
                float TR = p.SUB[ind_rtop + k];
     ab4:	vpmovsxwd xmm6,xmm6
     ab9:	vcvtdq2ps xmm6,xmm6
     abd:	vfmadd132ps xmm14,xmm20,xmm12
     ac3:	vfmadd132ps xmm6,xmm4,xmm12
                float BR = p.SUB[ind_rbot + k];
     ac8:	vmovdqu xmm4,XMMWORD PTR [rdi+rbx*1]
     acd:	vpmovzxbw xmm21,xmm4
     ad3:	vpsrldq xmm4,xmm4,0x8
     ad8:	vpmovsxwd xmm20,xmm21
     ade:	vpsrldq xmm21,xmm21,0x8
     ae5:	vpmovzxbw xmm4,xmm4
     aea:	vcvtdq2ps xmm20,xmm20
     af0:	vfmadd132ps xmm20,xmm22,xmm10
                float TL = p.SUB[ind_ltop + k];
     af6:	vpmovsxwd xmm22,xmm7
                float BR = p.SUB[ind_rbot + k];
     afc:	vpmovsxwd xmm21,xmm21
                float TL = p.SUB[ind_ltop + k];
     b02:	vpsrldq xmm7,xmm7,0x8
     b07:	vcvtdq2ps xmm22,xmm22
     b0d:	vfmadd213ps xmm22,xmm11,XMMWORD PTR [rcx+0x20]
                float BR = p.SUB[ind_rbot + k];
     b14:	vcvtdq2ps xmm21,xmm21
                float TL = p.SUB[ind_ltop + k];
     b1a:	vpmovsxwd xmm7,xmm7
     b1f:	vfmadd132ps xmm21,xmm9,xmm10
                float BR = p.SUB[ind_rbot + k];
     b25:	vpmovsxwd xmm9,xmm4
                float TL = p.SUB[ind_ltop + k];
     b2a:	vcvtdq2ps xmm7,xmm7
                vp[k] += p.A*TL + p.B*TR + p.C*BL + p.D*BR;
     b2e:	vfmadd213ps xmm7,xmm11,XMMWORD PTR [rcx+0x30]
                float BR = p.SUB[ind_rbot + k];
     b34:	vpsrldq xmm4,xmm4,0x8
     b39:	vcvtdq2ps xmm9,xmm9
     b3e:	vpmovsxwd xmm4,xmm4
     b43:	vcvtdq2ps xmm4,xmm4
                vp[k] += p.A*TL + p.B*TR + p.C*BL + p.D*BR;
     b47:	vaddps xmm19,xmm19,xmm20
     b4d:	vfmadd132ps xmm9,xmm22,xmm10
     b53:	vaddps xmm8,xmm8,xmm21
     b59:	vfmadd132ps xmm4,xmm7,xmm10
     b5e:	vmovups XMMWORD PTR [rcx],xmm19
     b64:	vmovups XMMWORD PTR [rcx+0x10],xmm8
     b69:	vaddps xmm14,xmm14,xmm9
     b6e:	vaddps xmm4,xmm4,xmm6
     b72:	vmovups XMMWORD PTR [rcx+0x20],xmm14
     b77:	vmovups XMMWORD PTR [rcx+0x30],xmm4
            for (int k = 0; k < remaining; ++k) {
     b7c:	mov    ecx,r9d
     b7f:	and    ecx,0xfffffff0
     b82:	test   r9b,0xf
     b86:	je     10c2 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x10c2>
     b8c:	add    eax,ecx
     b8e:	sub    r9d,ecx
     b91:	lea    r11d,[r9-0x1]
     b95:	cmp    r11d,0x6
     b99:	jbe    de4 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0xde4>
     b9f:	add    ecx,r15d
     ba2:	mov    rbx,QWORD PTR [rsp+0xd0]
                float TL = p.SUB[ind_ltop + k];
     baa:	mov    r15,QWORD PTR [rsp+0xd8]
     bb2:	mov    ecx,ecx
     bb4:	lea    r12,[rcx+rbx*1]
     bb8:	lea    rbx,[rdx+rcx*4]
     bbc:	add    rcx,rdi
     bbf:	vmovq  xmm4,QWORD PTR [rcx+r15*1]
     bc5:	vpmovzxbw xmm7,xmm4
     bca:	vpsrlq xmm4,xmm4,0x20
     bcf:	vpmovzxbw xmm6,xmm4
                float TR = p.SUB[ind_rtop + k];
     bd4:	vmovq  xmm4,QWORD PTR [rcx+r8*1]
                float TL = p.SUB[ind_ltop + k];
     bda:	vmovq  r11,xmm6
                float BL = p.SUB[ind_lbot + k];
     bdf:	vmovq  xmm6,QWORD PTR [rcx+rsi*1]
     be4:	mov    ecx,r9d
                float TR = p.SUB[ind_rtop + k];
     be7:	vpmovzxbw xmm9,xmm4
     bec:	vpsrlq xmm4,xmm4,0x20
     bf1:	and    ecx,0xfffffff8
     bf4:	and    r9d,0x7
     bf8:	vpmovzxwd xmm14,xmm9
                float BL = p.SUB[ind_lbot + k];
     bfd:	vpmovzxbw xmm8,xmm6
                float TR = p.SUB[ind_rtop + k];
     c02:	vpmovzxbw xmm4,xmm4
     c07:	vpsrlq xmm9,xmm9,0x20
                float BL = p.SUB[ind_lbot + k];
     c0d:	vpsrlq xmm6,xmm6,0x20
                float TR = p.SUB[ind_rtop + k];
     c12:	vmovq  xmm14,xmm14
     c17:	vcvtdq2ps xmm20,xmm14
                float BL = p.SUB[ind_lbot + k];
     c1d:	vpmovzxwd xmm14,xmm8
     c22:	vpsrlq xmm8,xmm8,0x20
                float TR = p.SUB[ind_rtop + k];
     c28:	vpmovzxwd xmm9,xmm9
                float BL = p.SUB[ind_lbot + k];
     c2d:	vpmovzxwd xmm8,xmm8
                float TR = p.SUB[ind_rtop + k];
     c32:	vmovq  xmm9,xmm9
                float BL = p.SUB[ind_lbot + k];
     c37:	vpmovzxbw xmm6,xmm6
     c3c:	vmovq  xmm8,xmm8
                float TR = p.SUB[ind_rtop + k];
     c41:	vcvtdq2ps xmm9,xmm9
                float BL = p.SUB[ind_lbot + k];
     c46:	vmovq  xmm19,xmm14
     c4c:	vcvtdq2ps xmm8,xmm8
                vp[k] += p.A*TL + p.B*TR + p.C*BL + p.D*BR;
     c51:	vmulps xmm8,xmm8,xmm13
                float BL = p.SUB[ind_lbot + k];
     c56:	vcvtdq2ps xmm19,xmm19
                vp[k] += p.A*TL + p.B*TR + p.C*BL + p.D*BR;
     c5c:	vmulps xmm19,xmm19,xmm13
     c62:	vfmadd132ps xmm9,xmm8,xmm12
                float TR = p.SUB[ind_rtop + k];
     c67:	vpmovzxwd xmm8,xmm4
     c6c:	vmovq  xmm8,xmm8
     c71:	vfmadd231ps xmm19,xmm12,xmm20
     c77:	vcvtdq2ps xmm14,xmm8
     c7c:	vmovaps xmm21,xmm9
                float BL = p.SUB[ind_lbot + k];
     c82:	vpmovzxwd xmm9,xmm6
     c87:	vmovq  xmm9,xmm9
     c8c:	vpsrlq xmm6,xmm6,0x20
     c91:	vcvtdq2ps xmm9,xmm9
                vp[k] += p.A*TL + p.B*TR + p.C*BL + p.D*BR;
     c96:	vmulps xmm9,xmm9,xmm13
                float BL = p.SUB[ind_lbot + k];
     c9b:	vpmovzxwd xmm6,xmm6
     ca0:	vmovq  xmm6,xmm6
     ca4:	vcvtdq2ps xmm6,xmm6
                vp[k] += p.A*TL + p.B*TR + p.C*BL + p.D*BR;
     ca8:	vmulps xmm6,xmm6,xmm13
     cad:	vfmadd132ps xmm14,xmm9,xmm12
     cb2:	vmovq  xmm9,QWORD PTR [rbx]
     cb6:	vmovaps xmm22,xmm14
                float TR = p.SUB[ind_rtop + k];
     cbc:	vpsrlq xmm14,xmm4,0x20
                float BR = p.SUB[ind_rbot + k];
     cc1:	vmovq  xmm4,QWORD PTR [rdi+r12*1]
                float TR = p.SUB[ind_rtop + k];
     cc7:	vpmovzxwd xmm14,xmm14
     ccc:	vmovq  xmm14,xmm14
     cd1:	vcvtdq2ps xmm14,xmm14
     cd6:	vfmadd132ps xmm14,xmm6,xmm12
                float BR = p.SUB[ind_rbot + k];
     cdb:	vpmovzxbw xmm6,xmm4
     ce0:	vpmovzxwd xmm8,xmm6
     ce5:	vpsrlq xmm6,xmm6,0x20
     cea:	vmovq  xmm8,xmm8
     cef:	vpsrlq xmm4,xmm4,0x20
     cf4:	vpmovzxwd xmm6,xmm6
     cf9:	vcvtdq2ps xmm20,xmm8
                float TL = p.SUB[ind_ltop + k];
     cff:	vpmovzxwd xmm8,xmm7
     d04:	vpsrlq xmm7,xmm7,0x20
                float BR = p.SUB[ind_rbot + k];
     d09:	vpmovzxbw xmm4,xmm4
                float TL = p.SUB[ind_ltop + k];
     d0e:	vmovq  xmm8,xmm8
     d13:	vpmovzxwd xmm7,xmm7
                float BR = p.SUB[ind_rbot + k];
     d18:	vmovq  xmm6,xmm6
                float TL = p.SUB[ind_ltop + k];
     d1c:	vcvtdq2ps xmm8,xmm8
     d21:	vfmadd231ps xmm9,xmm11,xmm8
                vp[k] += p.A*TL + p.B*TR + p.C*BL + p.D*BR;
     d26:	vmovq  xmm8,QWORD PTR [rbx+0x8]
                float TL = p.SUB[ind_ltop + k];
     d2b:	vmovq  xmm7,xmm7
                float BR = p.SUB[ind_rbot + k];
     d2f:	vcvtdq2ps xmm6,xmm6
                float TL = p.SUB[ind_ltop + k];
     d33:	vcvtdq2ps xmm7,xmm7
     d37:	vfmadd132ps xmm7,xmm8,xmm11
     d3c:	vmovq  xmm8,r11
     d41:	vpmovzxwd xmm8,xmm8
     d46:	vmovq  xmm8,xmm8
     d4b:	vfmadd132ps xmm20,xmm9,xmm10
                vp[k] += p.A*TL + p.B*TR + p.C*BL + p.D*BR;
     d51:	vmovq  xmm9,QWORD PTR [rbx+0x10]
                float TL = p.SUB[ind_ltop + k];
     d56:	vcvtdq2ps xmm8,xmm8
     d5b:	vfmadd132ps xmm8,xmm9,xmm11
     d60:	vfmadd132ps xmm6,xmm7,xmm10
                float BR = p.SUB[ind_rbot + k];
     d65:	vpmovzxwd xmm7,xmm4
                vp[k] += p.A*TL + p.B*TR + p.C*BL + p.D*BR;
     d6a:	vmovq  xmm9,QWORD PTR [rbx+0x18]
                float BR = p.SUB[ind_rbot + k];
     d6f:	vmovq  xmm7,xmm7
     d73:	vpsrlq xmm4,xmm4,0x20
     d78:	vcvtdq2ps xmm7,xmm7
     d7c:	vpmovzxwd xmm4,xmm4
     d81:	vmovq  xmm4,xmm4
     d85:	vcvtdq2ps xmm4,xmm4
     d89:	vfmadd132ps xmm7,xmm8,xmm10
                float TL = p.SUB[ind_ltop + k];
     d8e:	vmovq  xmm8,r11
                vp[k] += p.A*TL + p.B*TR + p.C*BL + p.D*BR;
     d93:	vaddps xmm6,xmm21,xmm6
                float TL = p.SUB[ind_ltop + k];
     d99:	vpsrlq xmm8,xmm8,0x20
     d9f:	vpmovzxwd xmm8,xmm8
     da4:	vmovq  xmm8,xmm8
                vp[k] += p.A*TL + p.B*TR + p.C*BL + p.D*BR;
     da9:	vmovlps QWORD PTR [rbx+0x8],xmm6
                float TL = p.SUB[ind_ltop + k];
     dae:	vcvtdq2ps xmm8,xmm8
                vp[k] += p.A*TL + p.B*TR + p.C*BL + p.D*BR;
     db3:	vfmadd132ps xmm8,xmm9,xmm11
     db8:	vaddps xmm6,xmm22,xmm7
     dbe:	vmovlps QWORD PTR [rbx+0x10],xmm6
     dc3:	vfmadd132ps xmm4,xmm8,xmm10
     dc8:	vaddps xmm8,xmm19,xmm20
     dce:	vmovlps QWORD PTR [rbx],xmm8
     dd2:	vaddps xmm4,xmm4,xmm14
     dd7:	vmovlps QWORD PTR [rbx+0x18],xmm4
            for (int k = 0; k < remaining; ++k) {
     ddc:	je     10c2 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x10c2>
     de2:	add    eax,ecx
                float TL = p.SUB[ind_ltop + k];
     de4:	movsxd rcx,eax
     de7:	mov    r15,QWORD PTR [rsp+0xd8]
                vp[k] += p.A*TL + p.B*TR + p.C*BL + p.D*BR;
     def:	lea    r9,[rcx*4+0x0]
                float TL = p.SUB[ind_ltop + k];
     df7:	add    rcx,rdi
     dfa:	movzx  ebx,BYTE PTR [rcx+r15*1]
     dff:	vcvtusi2ss xmm4,xmm5,ebx
                float TR = p.SUB[ind_rtop + k];
     e05:	movzx  ebx,BYTE PTR [rcx+r8*1]
     e0a:	vmovaps xmm7,xmm4
     e0e:	vcvtusi2ss xmm4,xmm5,ebx
                float BL = p.SUB[ind_lbot + k];
     e14:	movzx  ebx,BYTE PTR [rcx+rsi*1]
     e18:	vfmadd213ss xmm7,xmm18,DWORD PTR [rdx+r9*1]
     e1f:	vcvtusi2ss xmm6,xmm5,ebx
                float BR = p.SUB[ind_rbot + k];
     e25:	mov    rbx,QWORD PTR [rsp+0xd0]
     e2d:	movzx  ecx,BYTE PTR [rcx+rbx*1]
                vp[k] += p.A*TL + p.B*TR + p.C*BL + p.D*BR;
     e31:	vmulss xmm6,xmm6,xmm16
     e37:	vfmadd231ss xmm6,xmm17,xmm4
                float BR = p.SUB[ind_rbot + k];
     e3d:	vcvtusi2ss xmm4,xmm5,ecx
            for (int k = 0; k < remaining; ++k) {
     e43:	lea    ecx,[rax+0x1]
                vp[k] += p.A*TL + p.B*TR + p.C*BL + p.D*BR;
     e46:	vfmadd132ss xmm4,xmm7,xmm15
     e4b:	vaddss xmm4,xmm4,xmm6
     e4f:	vmovss DWORD PTR [rdx+r9*1],xmm4
            for (int k = 0; k < remaining; ++k) {
     e55:	cmp    ecx,r10d
     e58:	jge    10c2 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x10c2>
                float TL = p.SUB[ind_ltop + k];
     e5e:	lea    r12,[rdi+r15*1]
                float BL = p.SUB[ind_lbot + k];
     e62:	lea    rbx,[rdi+rsi*1]
                float TL = p.SUB[ind_ltop + k];
     e66:	movzx  r11d,BYTE PTR [r12+rcx*1]
     e6b:	vcvtusi2ss xmm4,xmm5,r11d
                float TR = p.SUB[ind_rtop + k];
     e71:	lea    r11,[rdi+rcx*1]
     e75:	movzx  r11d,BYTE PTR [r11+r8*1]
     e7a:	vmovaps xmm7,xmm4
     e7e:	vcvtusi2ss xmm4,xmm5,r11d
                float BL = p.SUB[ind_lbot + k];
     e84:	movzx  r11d,BYTE PTR [rbx+rcx*1]
     e89:	vfmadd213ss xmm7,xmm18,DWORD PTR [rdx+r9*1+0x4]
     e91:	vcvtusi2ss xmm6,xmm5,r11d
                float BR = p.SUB[ind_rbot + k];
     e97:	mov    r11,QWORD PTR [rsp+0xd0]
     e9f:	add    r11,rdi
     ea2:	movzx  ecx,BYTE PTR [r11+rcx*1]
                vp[k] += p.A*TL + p.B*TR + p.C*BL + p.D*BR;
     ea7:	vmulss xmm6,xmm6,xmm16
     ead:	vfmadd231ss xmm6,xmm17,xmm4
                float BR = p.SUB[ind_rbot + k];
     eb3:	vcvtusi2ss xmm4,xmm5,ecx
            for (int k = 0; k < remaining; ++k) {
     eb9:	lea    ecx,[rax+0x2]
                vp[k] += p.A*TL + p.B*TR + p.C*BL + p.D*BR;
     ebc:	vfmadd132ss xmm4,xmm7,xmm15
     ec1:	vaddss xmm4,xmm4,xmm6
     ec5:	vmovss DWORD PTR [rdx+r9*1+0x4],xmm4
            for (int k = 0; k < remaining; ++k) {
     ecc:	cmp    ecx,r10d
     ecf:	jge    10c2 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x10c2>
                float TL = p.SUB[ind_ltop + k];
     ed5:	movzx  r15d,BYTE PTR [r12+rcx*1]
     eda:	vcvtusi2ss xmm4,xmm5,r15d
                float TR = p.SUB[ind_rtop + k];
     ee0:	lea    r15,[rdi+rcx*1]
     ee4:	movzx  r15d,BYTE PTR [r15+r8*1]
     ee9:	vmovaps xmm7,xmm4
     eed:	vcvtusi2ss xmm4,xmm5,r15d
                float BL = p.SUB[ind_lbot + k];
     ef3:	movzx  r15d,BYTE PTR [rbx+rcx*1]
                float BR = p.SUB[ind_rbot + k];
     ef8:	movzx  ecx,BYTE PTR [r11+rcx*1]
     efd:	vfmadd213ss xmm7,xmm18,DWORD PTR [rdx+r9*1+0x8]
                float BL = p.SUB[ind_lbot + k];
     f05:	vcvtusi2ss xmm6,xmm5,r15d
                vp[k] += p.A*TL + p.B*TR + p.C*BL + p.D*BR;
     f0b:	vmulss xmm6,xmm6,xmm16
     f11:	vfmadd231ss xmm6,xmm17,xmm4
                float BR = p.SUB[ind_rbot + k];
     f17:	vcvtusi2ss xmm4,xmm5,ecx
            for (int k = 0; k < remaining; ++k) {
     f1d:	lea    ecx,[rax+0x3]
                vp[k] += p.A*TL + p.B*TR + p.C*BL + p.D*BR;
     f20:	vfmadd132ss xmm4,xmm7,xmm15
     f25:	vaddss xmm4,xmm4,xmm6
     f29:	vmovss DWORD PTR [rdx+r9*1+0x8],xmm4
            for (int k = 0; k < remaining; ++k) {
     f30:	cmp    ecx,r10d
     f33:	jge    10c2 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x10c2>
                float TL = p.SUB[ind_ltop + k];
     f39:	movzx  r15d,BYTE PTR [r12+rcx*1]
     f3e:	vcvtusi2ss xmm4,xmm5,r15d
                float TR = p.SUB[ind_rtop + k];
     f44:	lea    r15,[rdi+rcx*1]
     f48:	movzx  r15d,BYTE PTR [r15+r8*1]
     f4d:	vmovaps xmm7,xmm4
     f51:	vcvtusi2ss xmm4,xmm5,r15d
                float BL = p.SUB[ind_lbot + k];
     f57:	movzx  r15d,BYTE PTR [rbx+rcx*1]
                float BR = p.SUB[ind_rbot + k];
     f5c:	movzx  ecx,BYTE PTR [r11+rcx*1]
     f61:	vfmadd213ss xmm7,xmm18,DWORD PTR [rdx+r9*1+0xc]
                float BL = p.SUB[ind_lbot + k];
     f69:	vcvtusi2ss xmm6,xmm5,r15d
                vp[k] += p.A*TL + p.B*TR + p.C*BL + p.D*BR;
     f6f:	vmulss xmm6,xmm6,xmm16
     f75:	vfmadd231ss xmm6,xmm17,xmm4
                float BR = p.SUB[ind_rbot + k];
     f7b:	vcvtusi2ss xmm4,xmm5,ecx
            for (int k = 0; k < remaining; ++k) {
     f81:	lea    ecx,[rax+0x4]
                vp[k] += p.A*TL + p.B*TR + p.C*BL + p.D*BR;
     f84:	vfmadd132ss xmm4,xmm7,xmm15
     f89:	vaddss xmm4,xmm4,xmm6
     f8d:	vmovss DWORD PTR [rdx+r9*1+0xc],xmm4
            for (int k = 0; k < remaining; ++k) {
     f94:	cmp    ecx,r10d
     f97:	jge    10c2 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x10c2>
                float BL = p.SUB[ind_lbot + k];
     f9d:	movzx  ebx,BYTE PTR [rbx+rcx*1]
                float TL = p.SUB[ind_ltop + k];
     fa1:	movzx  r12d,BYTE PTR [r12+rcx*1]
                float BL = p.SUB[ind_lbot + k];
     fa6:	vcvtusi2ss xmm6,xmm5,ebx
                float TL = p.SUB[ind_ltop + k];
     fac:	vcvtusi2ss xmm4,xmm5,r12d
                float TR = p.SUB[ind_rtop + k];
     fb2:	lea    r12,[rdi+rcx*1]
                float BR = p.SUB[ind_rbot + k];
     fb6:	movzx  ecx,BYTE PTR [r11+rcx*1]
                float TR = p.SUB[ind_rtop + k];
     fbb:	movzx  r12d,BYTE PTR [r12+r8*1]
                vp[k] += p.A*TL + p.B*TR + p.C*BL + p.D*BR;
     fc0:	vmulss xmm6,xmm6,xmm16
     fc6:	vmovaps xmm7,xmm4
                float TR = p.SUB[ind_rtop + k];
     fca:	vcvtusi2ss xmm4,xmm5,r12d
     fd0:	vfmadd213ss xmm7,xmm18,DWORD PTR [rdx+r9*1+0x10]
     fd8:	vfmadd231ss xmm6,xmm4,xmm17
                float BR = p.SUB[ind_rbot + k];
     fde:	vcvtusi2ss xmm4,xmm5,ecx
            for (int k = 0; k < remaining; ++k) {
     fe4:	lea    ecx,[rax+0x5]
                vp[k] += p.A*TL + p.B*TR + p.C*BL + p.D*BR;
     fe7:	vfmadd132ss xmm4,xmm7,xmm15
     fec:	vaddss xmm4,xmm4,xmm6
     ff0:	vmovss DWORD PTR [rdx+r9*1+0x10],xmm4
            for (int k = 0; k < remaining; ++k) {
     ff7:	cmp    ecx,r10d
     ffa:	jge    10c2 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x10c2>
                float TL = p.SUB[ind_ltop + k];
    1000:	mov    r15,QWORD PTR [rsp+0xd8]
    1008:	add    rcx,rdi
            for (int k = 0; k < remaining; ++k) {
    100b:	add    eax,0x6
                float TL = p.SUB[ind_ltop + k];
    100e:	movzx  ebx,BYTE PTR [rcx+r15*1]
    1013:	vcvtusi2ss xmm4,xmm5,ebx
                float TR = p.SUB[ind_rtop + k];
    1019:	movzx  ebx,BYTE PTR [rcx+r8*1]
    101e:	vmovaps xmm7,xmm4
    1022:	vcvtusi2ss xmm4,xmm5,ebx
                float BL = p.SUB[ind_lbot + k];
    1028:	movzx  ebx,BYTE PTR [rcx+rsi*1]
    102c:	vfmadd213ss xmm7,xmm18,DWORD PTR [rdx+r9*1+0x14]
    1034:	vcvtusi2ss xmm6,xmm5,ebx
                float BR = p.SUB[ind_rbot + k];
    103a:	mov    rbx,QWORD PTR [rsp+0xd0]
    1042:	movzx  ecx,BYTE PTR [rcx+rbx*1]
                vp[k] += p.A*TL + p.B*TR + p.C*BL + p.D*BR;
    1046:	vmulss xmm6,xmm6,xmm16
    104c:	vfmadd231ss xmm6,xmm17,xmm4
                float BR = p.SUB[ind_rbot + k];
    1052:	vcvtusi2ss xmm4,xmm5,ecx
                vp[k] += p.A*TL + p.B*TR + p.C*BL + p.D*BR;
    1058:	vfmadd132ss xmm4,xmm7,xmm15
    105d:	vaddss xmm4,xmm4,xmm6
    1061:	vmovss DWORD PTR [rdx+r9*1+0x14],xmm4
            for (int k = 0; k < remaining; ++k) {
    1068:	cmp    eax,r10d
    106b:	jge    10c2 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x10c2>
                float TL = p.SUB[ind_ltop + k];
    106d:	add    rax,rdi
    1070:	movzx  ecx,BYTE PTR [rax+r15*1]
    1075:	vcvtusi2ss xmm4,xmm5,ecx
                float TR = p.SUB[ind_rtop + k];
    107b:	movzx  ecx,BYTE PTR [rax+r8*1]
    1080:	vmovaps xmm7,xmm4
    1084:	vcvtusi2ss xmm4,xmm5,ecx
                float BL = p.SUB[ind_lbot + k];
    108a:	movzx  ecx,BYTE PTR [rax+rsi*1]
                float BR = p.SUB[ind_rbot + k];
    108e:	movzx  eax,BYTE PTR [rax+rbx*1]
    1092:	vfmadd213ss xmm7,xmm18,DWORD PTR [rdx+r9*1+0x18]
                float BL = p.SUB[ind_lbot + k];
    109a:	vcvtusi2ss xmm6,xmm5,ecx
                vp[k] += p.A*TL + p.B*TR + p.C*BL + p.D*BR;
    10a0:	vmulss xmm6,xmm6,xmm16
    10a6:	vfmadd231ss xmm6,xmm17,xmm4
                float BR = p.SUB[ind_rbot + k];
    10ac:	vcvtusi2ss xmm4,xmm5,eax
                vp[k] += p.A*TL + p.B*TR + p.C*BL + p.D*BR;
    10b2:	vfmadd132ss xmm4,xmm7,xmm15
    10b7:	vaddss xmm4,xmm4,xmm6
    10bb:	vmovss DWORD PTR [rdx+r9*1+0x18],xmm4
        for (int y = p.y_begin; y < p.y_end; ++y) {
    10c2:	inc    DWORD PTR [rsp+0xc0]
    10c9:	mov    rdi,QWORD PTR [rsp+0x90]
    10d1:	add    QWORD PTR [rsp+0xb8],rdi
    10d9:	add    r14,rdi
    10dc:	mov    rdi,QWORD PTR [rsp+0x88]
    10e4:	mov    eax,DWORD PTR [rsp+0xc0]
    10eb:	add    QWORD PTR [rsp+0xa8],rdi
    10f3:	cmp    eax,DWORD PTR [rsp+0x98]
    10fa:	jne    5a8 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x5a8>
    for (const SubParams& p : params) {
    1100:	add    QWORD PTR [rsp+0xa0],0x30
    1109:	mov    rax,QWORD PTR [rsp+0xa0]
    1111:	cmp    QWORD PTR [rsp+0x58],rax
    1116:	jne    498 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x498>
            }
        }
    }

    // Write to output
    for (int y = 0; y < h; ++y) {
    111c:	mov    r13d,DWORD PTR [rsp+0x14]
    1121:	mov    rdi,QWORD PTR [rsp+0x50]
    1126:	mov    rbx,QWORD PTR [rsp+0x8]
    112b:	mov    r15d,DWORD PTR [rsp+0x10]
    1130:	mov    rax,QWORD PTR [rsp]
    1134:	test   r13d,r13d
    1137:	jle    160e <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x160e>
    113d:	test   r15d,r15d
    1140:	jle    160e <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x160e>
    1146:	vzeroupper
    1149:	mov    rsi,QWORD PTR [rsp+0x68]
            int c = counts[y * w + x];
            if (c == 0) {
                outp[x*3] = outp[x*3+1] = outp[x*3+2] = 0;
                continue;
            }
            float inv_c = 1.0f / static_cast<float>(c);
    114e:	mov    DWORD PTR [rsp+0xc0],r13d
    1156:	mov    r10,rdi
	this->_M_impl._M_end_of_storage = this->_M_impl._M_start + __n;
    1159:	xor    r11d,r11d
    115c:	mov    r12,QWORD PTR [rsp+0x40]
    1161:	vmovss xmm2,DWORD PTR [rip+0x0]        # 1169 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x1169>
    1169:	mov    QWORD PTR [rsp+0xb8],rbx
    for (int y = 0; y < h; ++y) {
    1171:	xor    r14d,r14d
    1174:	add    rax,rsi
            float inv_c = 1.0f / static_cast<float>(c);
    1177:	mov    rbx,QWORD PTR [rsp+0x28]
    117c:	mov    QWORD PTR [rsp+0xd8],rax
    1184:	shl    rax,0x2
    1188:	mov    QWORD PTR [rsp+0xd0],rax
    1190:	mov    eax,r15d
    1193:	lea    r15,[rax*4+0x0]
    119b:	lea    eax,[rsi-0x1]
    119e:	lea    r8,[rax+rax*2+0x3]
    11a3:	nop    DWORD PTR [rax+rax*1+0x0]
        unsigned char* outp = output.data.data() + (size_t)y * width * 3;
    11a8:	mov    rcx,QWORD PTR [rbx+0x10]
    11ac:	lea    r9,[r11*4+0x0]
    11b4:	mov    rdx,r12
    11b7:	xor    eax,eax
    11b9:	add    rcx,r11
    11bc:	jmp    11d8 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x11d8>
    11be:	xchg   ax,ax
                outp[x*3] = outp[x*3+1] = outp[x*3+2] = 0;
    11c0:	xor    esi,esi
    11c2:	mov    BYTE PTR [rcx+rax*1+0x2],0x0
        for (int x = 0; x < w; ++x) {
    11c7:	add    rdx,0x4
                outp[x*3] = outp[x*3+1] = outp[x*3+2] = 0;
    11cb:	mov    WORD PTR [rcx+rax*1],si
        for (int x = 0; x < w; ++x) {
    11cf:	add    rax,0x3
    11d3:	cmp    r8,rax
    11d6:	je     122d <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x122d>
            int c = counts[y * w + x];
    11d8:	mov    esi,DWORD PTR [rdx]
            if (c == 0) {
    11da:	test   esi,esi
    11dc:	je     11c0 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x11c0>
            float inv_c = 1.0f / static_cast<float>(c);
    11de:	vcvtsi2ss xmm0,xmm5,esi
        for (int x = 0; x < w; ++x) {
    11e2:	add    rdx,0x4
            float inv_c = 1.0f / static_cast<float>(c);
    11e6:	vdivss xmm0,xmm2,xmm0
            for (int ch = 0; ch < 3; ++ch) {
                float v = vp[x*3 + ch] * inv_c;
    11ea:	vmulss xmm1,xmm0,DWORD PTR [r10+rax*4]
                outp[x*3 + ch] = static_cast<unsigned char>(v);
    11f0:	vcvttss2si esi,xmm1
    11f4:	mov    BYTE PTR [rcx+rax*1],sil
                float v = vp[x*3 + ch] * inv_c;
    11f8:	lea    esi,[rax+0x1]
    11fb:	lea    r13,[rdi+rsi*4]
    11ff:	vmulss xmm1,xmm0,DWORD PTR [r13+r9*1+0x0]
                outp[x*3 + ch] = static_cast<unsigned char>(v);
    1206:	vcvttss2si r13d,xmm1
    120a:	mov    BYTE PTR [rcx+rsi*1],r13b
                float v = vp[x*3 + ch] * inv_c;
    120e:	lea    esi,[rax+0x2]
        for (int x = 0; x < w; ++x) {
    1211:	add    rax,0x3
                float v = vp[x*3 + ch] * inv_c;
    1215:	lea    r13,[rdi+rsi*4]
    1219:	vmulss xmm0,xmm0,DWORD PTR [r13+r9*1+0x0]
                outp[x*3 + ch] = static_cast<unsigned char>(v);
    1220:	vcvttss2si r13d,xmm0
    1224:	mov    BYTE PTR [rcx+rsi*1],r13b
        for (int x = 0; x < w; ++x) {
    1228:	cmp    r8,rax
    122b:	jne    11d8 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x11d8>
    for (int y = 0; y < h; ++y) {
    122d:	inc    r14d
    1230:	add    r11,QWORD PTR [rsp+0xd8]
    1238:	add    r10,QWORD PTR [rsp+0xd0]
    1240:	add    r12,r15
    1243:	cmp    DWORD PTR [rsp+0xc0],r14d
    124b:	jne    11a8 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x11a8>
    1251:	mov    rbx,QWORD PTR [rsp+0xb8]
	if (__p)
    1259:	test   rdi,rdi
    125c:	je     1268 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x1268>
	_GLIBCXX_OPERATOR_DELETE(_GLIBCXX_SIZED_DEALLOC(__p, __n));
    125e:	mov    rsi,QWORD PTR [rsp+0x38]
    1263:	call   1268 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x1268>
    1268:	test   rbx,rbx
    126b:	je     127a <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x127a>
    126d:	mov    rsi,QWORD PTR [rsp+0x30]
    1272:	mov    rdi,rbx
    1275:	call   127a <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x127a>
    127a:	mov    rax,QWORD PTR [rsp+0x40]
    127f:	test   rax,rax
    1282:	je     1291 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x1291>
    1284:	mov    rsi,QWORD PTR [rsp+0x18]
    1289:	mov    rdi,rax
    128c:	call   1291 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x1291>
    1291:	mov    rax,QWORD PTR [rsp+0x60]
    1296:	test   rax,rax
    1299:	je     12a8 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x12a8>
    129b:	mov    rsi,QWORD PTR [rsp+0x20]
    12a0:	mov    rdi,rax
    12a3:	call   12a8 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x12a8>
            }
        }
    }

    return output;
}
    12a8:	mov    rax,QWORD PTR [rsp+0x28]
    12ad:	lea    rsp,[rbp-0x28]
    12b1:	pop    rbx
    12b2:	pop    r12
    12b4:	pop    r13
    12b6:	pop    r14
    12b8:	pop    r15
    12ba:	pop    rbp
    12bb:	ret
	: _M_start(), _M_finish(), _M_end_of_storage()
    12bc:	mov    QWORD PTR [rsp+0xd0],0x0
    const int w = static_cast<int>(width);
    12c8:	mov    r15d,eax
    const int h = static_cast<int>(height);
    12cb:	mov    r13d,edx
    12ce:	xor    r12d,r12d
    for (auto& sub : subapertures) {
    12d1:	cmp    rcx,rsi
    12d4:	jne    fb <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0xfb>
    12da:	mov    QWORD PTR [rsp+0x60],0x0
	this->_M_impl._M_end_of_storage = this->_M_impl._M_start + __n;
    12e3:	mov    QWORD PTR [rsp+0x18],0x0
	return __n != 0 ? _Tr::allocate(_M_impl, __n) : pointer();
    12ec:	mov    QWORD PTR [rsp+0x40],0x0
    12f5:	jmp    25c <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x25c>
    12fa:	nop    WORD PTR [rax+rax*1+0x0]
            if(x + 8 <= x_stop) {
    1300:	mov    r10d,DWORD PTR [rsp+0xb0]
    1308:	cmp    r10d,0x7
    130c:	jg     1342 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x1342>
            for (int k = 0; k < remaining; ++k) {
    130e:	test   r10d,r10d
    1311:	jle    10c2 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x10c2>
                float TL = p.SUB[ind_ltop + k];
    1317:	mov    rax,QWORD PTR [rsp+0xa0]
            size_t ind_ltop = ((y + p.sy) * width + (p.x_begin + p.sx)) * 3;
    131f:	mov    QWORD PTR [rsp+0xd8],r14
                float TL = p.SUB[ind_ltop + k];
    1327:	mov    rdi,QWORD PTR [rax+0x28]
            size_t ind_rbot = ind_lbot + 3;
    132b:	mov    rax,QWORD PTR [rsp+0xb8]
    1333:	mov    QWORD PTR [rsp+0xd0],rax
            for (int k = 0; k < remaining; ++k) {
    133b:	xor    eax,eax
    133d:	jmp    de4 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0xde4>
    1342:	mov    rdi,QWORD PTR [rsp+0xa0]
            size_t ind_rbot = ind_lbot + 3;
    134a:	mov    QWORD PTR [rsp+0xd0],rax
            int x = 0;
    1352:	xor    eax,eax
            size_t ind_ltop = ((y + p.sy) * width + (p.x_begin + p.sx)) * 3;
    1354:	mov    QWORD PTR [rsp+0xd8],r14
    135c:	mov    rdi,QWORD PTR [rdi+0x28]
    1360:	jmp    6df <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x6df>
                float TL = p.SUB[ind_ltop + k];
    1365:	xor    r15d,r15d
    1368:	mov    r9d,r10d
            for (int k = 0; k < remaining; ++k) {
    136b:	xor    eax,eax
    136d:	sub    r9d,r15d
    1370:	lea    ecx,[r9-0x1]
    1374:	cmp    ecx,0xe
    1377:	ja     9a5 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x9a5>
    137d:	xor    ecx,ecx
    137f:	jmp    b8e <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0xb8e>
	if (__n > _S_max_size(_Tp_alloc_type(__a)))
    1384:	cmp    QWORD PTR [rsp+0xc0],0x0
    138d:	js     1393 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x1393>
	  return static_cast<_Tp*>(_GLIBCXX_OPERATOR_NEW(__n * sizeof(_Tp)));
    1393:	mov    rdi,rsi
    1396:	mov    QWORD PTR [rsp+0xd0],rcx
      allocate(size_type __n, const void* = static_cast<const void*>(0))
    139e:	mov    r15,rsi
    13a1:	vmovss DWORD PTR [rsp+0xb8],xmm4
	  return static_cast<_Tp*>(_GLIBCXX_OPERATOR_NEW(__n * sizeof(_Tp)));
    13aa:	call   13af <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x13af>
    13af:	mov    rdi,rax
	      if constexpr (is_pointer<_BasePtr>::value)
		{
		  void* __dest = std::__niter_base(__first);
		  if (__n > 0) [[__likely__]]
		    {
		      __builtin_memset(__dest, (unsigned char)__x, __n);
    13b2:	xor    esi,esi
	this->_M_impl._M_end_of_storage = this->_M_impl._M_start + __n;
    13b4:	lea    r12,[rax+r15*1]
    13b8:	mov    rdx,r15
    13bb:	call   13c0 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x13c0>
      if (this->capacity() < __n)
    13c0:	mov    rcx,QWORD PTR [rsp+0xd0]
    13c8:	vmovss xmm4,DWORD PTR [rsp+0xb8]
    13d1:	mov    rdi,rax
	  _M_start = __x._M_start;
    13d4:	mov    rax,QWORD PTR [rsp+0x28]
    13d9:	mov    QWORD PTR [rax+0x10],rdi
	  _M_finish = __x._M_finish;
    13dd:	mov    QWORD PTR [rax+0x18],r12
	  _M_end_of_storage = __x._M_end_of_storage;
    13e1:	mov    QWORD PTR [rax+0x20],r12
	ptrdiff_t __dif = this->_M_impl._M_finish - this->_M_impl._M_start;
    13e5:	mov    rax,QWORD PTR [rbx+0x8]
    13e9:	mov    QWORD PTR [rsp+0xd8],rax
    13f1:	sub    rax,rcx
    13f4:	mov    QWORD PTR [rsp+0x20],rax
    13f9:	jne    a2 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0xa2>
	: _M_start(), _M_finish(), _M_end_of_storage()
    13ff:	mov    QWORD PTR [rsp+0xd0],0x0
    140b:	xor    r12d,r12d
    140e:	jmp    e0 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0xe0>
	ptrdiff_t __dif = this->_M_impl._M_finish - this->_M_impl._M_start;
    1413:	mov    r12,QWORD PTR [rsp+0xd0]
    141b:	movabs rax,0xaaaaaaaaaaaaaaab
    1425:	sub    r12,QWORD PTR [rsp+0x60]
    142a:	mov    rdx,r12
    142d:	sar    rdx,0x4
    1431:	imul   rdx,rax
	if (max_size() - size() < __n)
    1435:	movabs rax,0x2aaaaaaaaaaaaaa
    143f:	cmp    rdx,rax
    1442:	je     1448 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x1448>
    max(const _Tp& __a, const _Tp& __b)
    {
      // concept requirements
      __glibcxx_function_requires(_LessThanComparableConcept<_Tp>)
      //return  __a < __b ? __b : __a;
      if (__a < __b)
    1448:	test   rdx,rdx
    144b:	mov    eax,0x1
    1450:	mov    QWORD PTR [rsp+0x48],rcx
    1455:	cmovne rax,rdx
    1459:	mov    DWORD PTR [rsp+0x50],r11d
    145e:	mov    DWORD PTR [rsp+0x58],esi
	const size_type __len = size() + (std::max)(size(), __n);
    1462:	add    rax,rdx
	return (__len < size() || __len > max_size()) ? max_size() : __len;
    1465:	movabs rdx,0x2aaaaaaaaaaaaaa
    146f:	mov    DWORD PTR [rsp+0x88],r8d
    1477:	cmp    rax,rdx
    147a:	mov    DWORD PTR [rsp+0x90],r10d
    1482:	cmova  rax,rdx
    1486:	vmovss DWORD PTR [rsp+0x40],xmm4
    148c:	vmovss DWORD PTR [rsp+0x70],xmm5
    1492:	lea    rax,[rax+rax*2]
    1496:	vmovss DWORD PTR [rsp+0x78],xmm0
    149c:	shl    rax,0x4
    14a0:	vmovss DWORD PTR [rsp+0x80],xmm1
    14a9:	mov    rdi,rax
    14ac:	mov    QWORD PTR [rsp+0xa0],rax
    14b4:	vmovss DWORD PTR [rsp+0x84],xmm2
    14bd:	call   14c2 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x14c2>
	{ ::new((void *)__p) _Up(std::forward<_Args>(__args)...); }
    14c2:	mov    esi,DWORD PTR [rsp+0x58]
    14c6:	vmovss xmm0,DWORD PTR [rsp+0x78]
    __relocate_a_1(_Tp* __first, _Tp* __last,
		   _Tp* __result,
		   [[__maybe_unused__]] allocator<_Up>& __alloc) noexcept
    {
      ptrdiff_t __count = __last - __first;
      if (__count > 0)
    14cc:	test   r12,r12
	  return static_cast<_Tp*>(_GLIBCXX_OPERATOR_NEW(__n * sizeof(_Tp)));
    14cf:	mov    QWORD PTR [rsp+0xa8],rax
	{ ::new((void *)__p) _Up(std::forward<_Args>(__args)...); }
    14d7:	vmovss xmm2,DWORD PTR [rsp+0x84]
    14e0:	mov    r10d,DWORD PTR [rsp+0x90]
    14e8:	mov    DWORD PTR [rax+r12*1+0x1c],ebx
	  return static_cast<_Tp*>(_GLIBCXX_OPERATOR_NEW(__n * sizeof(_Tp)));
    14ed:	mov    rdi,rax
	{ ::new((void *)__p) _Up(std::forward<_Args>(__args)...); }
    14f0:	mov    r8d,DWORD PTR [rsp+0x88]
    14f8:	vinsertps xmm0,xmm0,DWORD PTR [rsp+0x70],0x10
    1500:	mov    DWORD PTR [rax+r12*1+0x18],esi
    1505:	mov    r9d,0x0
    150b:	vinsertps xmm2,xmm2,DWORD PTR [rsp+0x80],0x10
    1516:	mov    r11d,DWORD PTR [rsp+0x50]
    151b:	mov    DWORD PTR [rax+r12*1],r10d
    151f:	mov    rsi,QWORD PTR [rsp+0xb8]
    1527:	mov    rcx,QWORD PTR [rsp+0x48]
    152c:	mov    DWORD PTR [rax+r12*1+0x4],r8d
    1531:	vmovlhps xmm2,xmm2,xmm0
    1535:	mov    DWORD PTR [rax+r12*1+0x20],r11d
    153a:	vmovss xmm4,DWORD PTR [rsp+0x40]
    1540:	mov    DWORD PTR [rax+r12*1+0x24],r14d
    1545:	mov    QWORD PTR [rax+r12*1+0x28],rsi
    154a:	vmovups XMMWORD PTR [rax+r12*1+0x8],xmm2
    1551:	je     1585 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x1585>
	      __gnu_cxx::__normal_iterator<_Tp*, void> __out(__result);
	      __out = std::__relocate_a_1(__first, __last, __out, __alloc);
	      return __out.base();
	    }
#endif
	  __builtin_memcpy(__result, __first, __count * sizeof(_Tp));
    1553:	mov    rsi,QWORD PTR [rsp+0x60]
    1558:	mov    rdx,r12
    155b:	mov    QWORD PTR [rsp+0xb8],rcx
    1563:	vmovss DWORD PTR [rsp+0x90],xmm4
    156c:	call   1571 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x1571>
    1571:	vmovss xmm4,DWORD PTR [rsp+0x90]
    157a:	mov    rcx,QWORD PTR [rsp+0xb8]
    1582:	xor    r9d,r9d
	  {
	    // Relocation cannot throw.
	    __new_finish = std::__relocate_a(__old_start, __old_finish,
					     __new_start,
					     _M_get_Tp_allocator());
	    ++__new_finish;
    1585:	mov    rax,QWORD PTR [rsp+0xa8]
    158d:	lea    r12,[rax+r12*1+0x30]
	  if (_M_storage)
    1592:	mov    rax,QWORD PTR [rsp+0x60]
    1597:	test   rax,rax
    159a:	je     15d4 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x15d4>
	    // New storage has been fully initialized, destroy the old elements.
	    __guard_elts._M_first = __old_start;
	    __guard_elts._M_last = __old_finish;
	  }
	__guard._M_storage = __old_start;
	__guard._M_len = this->_M_impl._M_end_of_storage - __old_start;
    159c:	mov    rsi,QWORD PTR [rsp+0xd0]
	_GLIBCXX_OPERATOR_DELETE(_GLIBCXX_SIZED_DEALLOC(__p, __n));
    15a4:	mov    rdi,rax
    15a7:	mov    QWORD PTR [rsp+0xb8],rcx
      deallocate(_Tp* __p, size_type __n __attribute__ ((__unused__)))
    15af:	vmovss DWORD PTR [rsp+0x90],xmm4
    15b8:	sub    rsi,rax
	_GLIBCXX_OPERATOR_DELETE(_GLIBCXX_SIZED_DEALLOC(__p, __n));
    15bb:	call   15c0 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x15c0>
    15c0:	vmovss xmm4,DWORD PTR [rsp+0x90]
    15c9:	mov    rcx,QWORD PTR [rsp+0xb8]
    15d1:	xor    r9d,r9d
      // deallocate should be called before assignments to _M_impl,
      // to avoid call-clobbering

      this->_M_impl._M_start = __new_start;
      this->_M_impl._M_finish = __new_finish;
      this->_M_impl._M_end_of_storage = __new_start + __len;
    15d4:	mov    rsi,QWORD PTR [rsp+0xa8]
    15dc:	mov    rax,QWORD PTR [rsp+0xa0]
    15e4:	add    rax,rsi
      this->_M_impl._M_start = __new_start;
    15e7:	mov    QWORD PTR [rsp+0x60],rsi
      this->_M_impl._M_end_of_storage = __new_start + __len;
    15ec:	mov    QWORD PTR [rsp+0xd0],rax
    15f4:	jmp    1f4 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x1f4>
	return __n != 0 ? _Tr::allocate(_M_impl, __n) : pointer();
    15f9:	xor    ebx,ebx
    15fb:	jmp    2b4 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x2b4>
    for (const SubParams& p : params) {
    1600:	cmp    QWORD PTR [rsp+0x60],r12
    1605:	je     1672 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x1672>
    1607:	xor    edi,edi
    1609:	jmp    444 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x444>
    160e:	vzeroupper
    1611:	jmp    1259 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x1259>
    for (int y = 0; y < h; ++y) {
    1616:	test   r13d,r13d
    1619:	jle    125e <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x125e>
    161f:	mov    rax,QWORD PTR [rsp+0x68]
    1624:	add    rax,rax
    1627:	test   r15d,r15d
    162a:	jg     1149 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x1149>
    1630:	jmp    125e <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x125e>
    1635:	nop    DWORD PTR [rax]
	if (__n > _S_max_size(_Tp_alloc_type(__a)))
    1638:	mov    rax,QWORD PTR [rsp+0xc0]
    1640:	shr    rax,0x3d
    1644:	jne    164a <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x164a>
	return __n != 0 ? _Tr::allocate(_M_impl, __n) : pointer();
    164a:	cmp    QWORD PTR [rsp+0x38],0x0
    1650:	jne    3ec <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x3ec>
    for (const SubParams& p : params) {
    1656:	cmp    QWORD PTR [rsp+0x60],r12
    165b:	je     1268 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x1268>
    1661:	xor    edi,edi
    1663:	jmp    444 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x444>
    for (auto& sub : subapertures) {
    1668:	mov    QWORD PTR [rsp+0x60],r12
    166d:	jmp    218 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x218>
    1672:	mov    rax,QWORD PTR [rsp+0x68]
	this->_M_impl._M_end_of_storage = this->_M_impl._M_start + __n;
    1677:	mov    QWORD PTR [rsp+0x38],0x0
	return __n != 0 ? _Tr::allocate(_M_impl, __n) : pointer();
    1680:	xor    edi,edi
    1682:	add    rax,rax
    1685:	test   r15d,r15d
    1688:	jg     1149 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x1149>
    168e:	jmp    1268 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x1268>
    1693:	jmp    1698 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x1698>
    1698:	mov    rbx,rax
    169b:	vzeroupper
    169e:	jmp    16a3 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x16a3>
    16a3:	jmp    16a8 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x16a8>
    16a8:	jmp    16ad <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x16ad>
    16ad:	jmp    16b2 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x16b2>

Disassembly of section .text.unlikely:

0000000000000000 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float) [clone .cold]>:
	  __throw_length_error(
   0:	lea    rdi,[rip+0x0]        # 7 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float) [clone .cold]+0x7>
   7:	call   c <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float) [clone .cold]+0xc>
	if (__p)
   c:	mov    rbx,rax
   f:	vzeroupper
  12:	cmp    QWORD PTR [rsp+0x40],0x0
  18:	je     29 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float) [clone .cold]+0x29>
  1a:	mov    rsi,QWORD PTR [rsp+0x18]
  1f:	mov    rdi,QWORD PTR [rsp+0x40]
  24:	call   29 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float) [clone .cold]+0x29>
  29:	cmp    QWORD PTR [rsp+0x60],0x0
  2f:	je     46 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float) [clone .cold]+0x46>
	ptrdiff_t __n = _M_impl._M_end_of_storage - _M_impl._M_start;
  31:	mov    rsi,QWORD PTR [rsp+0xd0]
  39:	mov    rdi,QWORD PTR [rsp+0x60]
  3e:	sub    rsi,rdi
  41:	call   46 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float) [clone .cold]+0x46>
  46:	mov    rax,QWORD PTR [rsp+0x28]
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
  78:	mov    rsi,QWORD PTR [rsp+0x30]
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
