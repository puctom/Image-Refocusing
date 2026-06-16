
asm/opt11_abl_tile_8x2032.o:     file format elf64-x86-64


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
       e:	mov    r13,rsi
      11:	push   r12
      13:	push   rbx
      14:	and    rsp,0xffffffffffffffe0
      18:	sub    rsp,0x120
      : _M_current() { }

      __attribute__((__always_inline__))
      explicit _GLIBCXX_CONSTEXPR
      __normal_iterator(const _Iterator& __i) _GLIBCXX_NOEXCEPT
      : _M_current(__i) { }
      1f:	mov    rbx,QWORD PTR [rsi]
      22:	vmovss DWORD PTR [rsp+0xe8],xmm0
      2b:	mov    QWORD PTR [rsp+0x80],rdi
    const size_t width  = subapertures.front().data.width;
      33:	vmovdqu xmm0,XMMWORD PTR [rbx]
      37:	mov    QWORD PTR [rdi+0x20],0x0
      3f:	vmovdqu XMMWORD PTR [rdi+0x10],xmm1
      44:	vmovq  rax,xmm0
      49:	vpextrq rcx,xmm0,0x1
      4f:	vmovq  QWORD PTR [rsp+0xa0],xmm0
    const int h = static_cast<int>(height);

    ImageData output;
    output.width = width;
    output.height = height;
    output.data.assign(width * height * 3, 0);
      58:	mov    rdx,rax
      5b:	mov    QWORD PTR [rsp+0x100],rcx
      63:	imul   rdx,rcx
    output.width = width;
      67:	vmovdqu XMMWORD PTR [rdi],xmm0
    output.data.assign(width * height * 3, 0);
      6b:	mov    QWORD PTR [rsp+0x48],rdx
    void
    vector<_Tp, _Alloc>::
    _M_fill_assign(size_t __n, const value_type& __val)
    {
      const size_type __sz = size();
      if (__n > capacity())
      70:	test   rdx,rdx
      73:	jne    131d <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x131d>
      /**  Returns the number of elements in the %vector.  */
      _GLIBCXX_NODISCARD _GLIBCXX20_CONSTEXPR
      size_type
      size() const _GLIBCXX_NOEXCEPT
      {
	ptrdiff_t __dif = this->_M_impl._M_finish - this->_M_impl._M_start;
      79:	mov    rdx,QWORD PTR [rsi+0x8]
      if (this->capacity() < __n)
      7d:	mov    rdi,rdx
      80:	mov    QWORD PTR [rsp+0x110],rdx
      88:	sub    rdi,rbx
      8b:	mov    QWORD PTR [rsp+0x40],rdi
      90:	je     13bf <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x13bf>
	    return static_cast<_Tp*>(_GLIBCXX_OPERATOR_NEW(__n * sizeof(_Tp),
							   __al));
	  }
#endif
	else
	  return static_cast<_Tp*>(_GLIBCXX_OPERATOR_NEW(__n * sizeof(_Tp)));
      96:	mov    r15,QWORD PTR [rsp+0x40]
      9b:	mov    rdi,r15
      9e:	call   a3 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0xa3>
      a3:	mov    QWORD PTR [rsp+0x58],rax
	  this->_M_impl._M_end_of_storage = this->_M_impl._M_start + __n;
      a8:	lea    r13,[rax+r15*1]
    const int w = static_cast<int>(width);
      ac:	mov    eax,DWORD PTR [rsp+0xa0]
    const int h = static_cast<int>(height);
      b3:	mov    r14d,DWORD PTR [rsp+0x100]
    const int w = static_cast<int>(width);
      bb:	mov    DWORD PTR [rsp+0x68],eax

    // Precalculate subaperture parameters
    std::vector<SubParams> params;
    params.reserve(subapertures.size());
    for (auto& sub : subapertures) {
      bf:	cmp    rbx,QWORD PTR [rsp+0x110]
      c7:	je     15a3 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x15a3>
	: _M_start(), _M_finish(), _M_end_of_storage()
      cd:	mov    r15,QWORD PTR [rsp+0x58]
        SubParams p;
        float shift_x = focus * sub.u;
      d2:	vmovss xmm5,DWORD PTR [rsp+0xe8]
        float dy = shift_y - p.sy;
        p.A = (1 - dx) * (1 - dy);
        p.B = dx       * (1 - dy);
        p.C = (1 - dx) * dy;
        p.D = dx       * dy;
        p.x_begin = std::max(0, -p.sx);
      db:	xor    r8d,r8d
        float shift_x = focus * sub.u;
      de:	vmulss xmm4,xmm5,DWORD PTR [rbx+0x28]
        float shift_y = focus * sub.v;
      e3:	vmulss xmm2,xmm5,DWORD PTR [rbx+0x2c]
  using ::floor;

#ifndef __CORRECT_ISO_CPP_MATH_H_PROTO
  inline _GLIBCXX_CONSTEXPR float
  floor(float __x)
  { return __builtin_floorf(__x); }
      e8:	vrndscaless xmm0,xmm4,xmm4,0x9
        p.sx = static_cast<int>(std::floor(shift_x));
      ef:	vcvttss2si r10d,xmm0
      f3:	vrndscaless xmm1,xmm2,xmm2,0x9
        p.sy = static_cast<int>(std::floor(shift_y));
      fa:	vcvttss2si esi,xmm1
        p.x_begin = std::max(0, -p.sx);
      fe:	mov    eax,r10d
     101:	neg    eax
     103:	test   r10d,r10d
     106:	cmovs  r8d,eax
        p.x_end   = std::min(w, w - p.sx - 1);
     10a:	mov    eax,DWORD PTR [rsp+0x68]
     10e:	mov    ecx,eax
     110:	sub    ecx,r10d
     113:	dec    ecx
    min(const _Tp& __a, const _Tp& __b)
    {
      // concept requirements
      __glibcxx_function_requires(_LessThanComparableConcept<_Tp>)
      //return __b < __a ? __b : __a;
      if (__b < __a)
     115:	cmp    ecx,eax
     117:	cmovg  ecx,eax
        p.y_begin = std::max(0, -p.sy);
     11a:	mov    eax,esi
     11c:	xor    r9d,r9d
     11f:	neg    eax
     121:	test   esi,esi
     123:	cmovs  r9d,eax
        p.y_end   = std::min(h, h - p.sy - 1);
     127:	mov    eax,r14d
     12a:	sub    eax,esi
     12c:	dec    eax
     12e:	cmp    eax,r14d
     131:	cmovg  eax,r14d
     135:	mov    r11d,eax
        p.SUB = sub.data.data.data();
        if (p.x_begin >= p.x_end || p.y_begin >= p.y_end) continue;  // skip degenerate
     138:	cmp    r8d,ecx
     13b:	jge    1b7 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x1b7>
     13d:	cmp    r9d,eax
     140:	jge    1b7 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x1b7>
        float dy = shift_y - p.sy;
     142:	vsubss xmm5,xmm2,xmm1
        float dx = shift_x - p.sx;
     146:	vsubss xmm3,xmm4,xmm0
       */
      _GLIBCXX20_CONSTEXPR
      void
      push_back(const value_type& __x)
      {
	if (this->_M_impl._M_finish != this->_M_impl._M_end_of_storage)
     14a:	mov    rax,QWORD PTR [rsp+0x58]
      { return _M_data_ptr(this->_M_impl._M_start); }
     14f:	mov    r12,QWORD PTR [rbx+0x10]
        p.A = (1 - dx) * (1 - dy);
     153:	vaddss xmm0,xmm0,DWORD PTR [rip+0x0]        # 15b <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x15b>
     15b:	vaddss xmm1,xmm1,DWORD PTR [rip+0x0]        # 163 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x163>
     163:	vsubss xmm0,xmm0,xmm4
     167:	vsubss xmm1,xmm1,xmm2
     16b:	vmulss xmm2,xmm0,xmm1
        p.B = dx       * (1 - dy);
     16f:	vmulss xmm1,xmm1,xmm3
        p.C = (1 - dx) * dy;
     173:	vmulss xmm0,xmm0,xmm5
        p.D = dx       * dy;
     177:	vmulss xmm3,xmm3,xmm5
	if (this->_M_impl._M_finish != this->_M_impl._M_end_of_storage)
     17b:	cmp    rax,r13
     17e:	je     13fe <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x13fe>
      template<typename _Up, typename... _Args>
	__attribute__((__always_inline__))
	void
	construct(_Up* __p, _Args&&... __args)
	noexcept(__is_nothrow_new_constructible<_Up, _Args...>)
	{ ::new((void *)__p) _Up(std::forward<_Args>(__args)...); }
     184:	vunpcklps xmm0,xmm0,xmm3
     188:	vunpcklps xmm2,xmm2,xmm1
     18c:	mov    DWORD PTR [rax],r10d
	  {
	    _GLIBCXX_ASAN_ANNOTATE_GROW(1);
	    _Alloc_traits::construct(this->_M_impl, this->_M_impl._M_finish,
				     __x);
	    ++this->_M_impl._M_finish;
     18f:	add    rax,0x30
     193:	vmovlhps xmm2,xmm2,xmm0
     197:	mov    DWORD PTR [rax-0x2c],esi
     19a:	vmovups XMMWORD PTR [rax-0x28],xmm2
     19f:	mov    DWORD PTR [rax-0x18],r8d
     1a3:	mov    DWORD PTR [rax-0x14],ecx
     1a6:	mov    DWORD PTR [rax-0x10],r9d
     1aa:	mov    DWORD PTR [rax-0xc],r11d
     1ae:	mov    QWORD PTR [rax-0x8],r12
     1b2:	mov    QWORD PTR [rsp+0x58],rax
      __attribute__((__always_inline__))
      _GLIBCXX14_CONSTEXPR
      __normal_iterator&
      operator++() _GLIBCXX_NOEXCEPT
      {
	++_M_current;
     1b7:	add    rbx,0x30
    for (auto& sub : subapertures) {
     1bb:	cmp    QWORD PTR [rsp+0x110],rbx
     1c3:	jne    d2 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0xd2>
	ptrdiff_t __n = _M_impl._M_end_of_storage - _M_impl._M_start;
     1c9:	mov    rax,r13
     1cc:	sub    rax,r15
     1cf:	mov    QWORD PTR [rsp+0x40],rax
     1d4:	mov    rax,QWORD PTR [rsp+0x58]
     1d9:	mov    QWORD PTR [rsp+0x58],r15
     1de:	mov    QWORD PTR [rsp+0x90],rax

      // Called by constructors to check initial size.
      static _GLIBCXX20_CONSTEXPR size_type
      _S_check_init_len(size_type __n, const allocator_type& __a)
      {
	if (__n > _S_max_size(_Tp_alloc_type(__a)))
     1e6:	mov    rax,QWORD PTR [rsp+0x48]
     1eb:	shr    rax,0x3d
     1ef:	jne    1f5 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x1f5>
	return __n != 0 ? _Tr::allocate(_M_impl, __n) : pointer();
     1f5:	mov    rbx,QWORD PTR [rsp+0x48]
     1fa:	test   rbx,rbx
     1fd:	je     13e9 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x13e9>
	  return static_cast<_Tp*>(_GLIBCXX_OPERATOR_NEW(__n * sizeof(_Tp)));
     203:	shl    rbx,0x2
     207:	mov    rdi,rbx
     20a:	mov    QWORD PTR [rsp+0x48],rbx
     20f:	call   214 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x214>
	  // Allow std::_Construct to be used in constant expressions.
	  std::construct_at(__p, std::forward<_Args>(__args)...);
	  return;
	}
#endif
      ::new(static_cast<void*>(__p)) _Tp(std::forward<_Args>(__args)...);
     214:	mov    rdx,rbx
     217:	xor    esi,esi
     219:	mov    rdi,rax
     21c:	mov    QWORD PTR [rsp+0x50],rax
     221:	call   226 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x226>
        params.push_back(p);
    }

    // Precalculate counts
    std::vector<int> counts(width * height, 0);
    std::vector<int> diff((width + 1) * (height + 1), 0);
     226:	mov    rax,QWORD PTR [rsp+0xa0]
     22e:	lea    r11,[rax+0x1]
     232:	mov    rax,QWORD PTR [rsp+0x100]
     23a:	inc    rax
     23d:	imul   rax,r11
     241:	mov    r15,rax
	if (__n > _S_max_size(_Tp_alloc_type(__a)))
     244:	shr    rax,0x3d
     248:	jne    24e <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x24e>
	return __n != 0 ? _Tr::allocate(_M_impl, __n) : pointer();
     24e:	test   r15,r15
     251:	je     13f7 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x13f7>
     257:	shl    r15,0x2
     25b:	mov    QWORD PTR [rsp+0x110],r11
     263:	mov    rdi,r15
     266:	call   26b <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x26b>
     26b:	mov    rdx,r15
     26e:	xor    esi,esi
     270:	mov    rdi,rax
     273:	mov    rbx,rax
     276:	call   27b <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x27b>
     27b:	mov    r11,QWORD PTR [rsp+0x110]

    for (const auto& p : params) {
     283:	mov    rax,QWORD PTR [rsp+0x58]
     288:	cmp    QWORD PTR [rsp+0x90],rax
     290:	je     2d3 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x2d3>
        diff[p.y_begin * (width + 1) + p.x_begin] += 1;
     292:	movsxd rdx,DWORD PTR [rax+0x20]
     296:	movsxd rsi,DWORD PTR [rax+0x18]
     29a:	add    rax,0x30
        diff[p.y_begin * (width + 1) + p.x_end  ] -= 1;
        diff[p.y_end   * (width + 1) + p.x_begin] -= 1;
     29e:	movsxd rdi,DWORD PTR [rax-0xc]
        diff[p.y_begin * (width + 1) + p.x_begin] += 1;
     2a2:	imul   rdx,r11
        diff[p.y_end   * (width + 1) + p.x_begin] -= 1;
     2a6:	imul   rdi,r11
        diff[p.y_begin * (width + 1) + p.x_begin] += 1;
     2aa:	lea    rcx,[rdx+rsi*1]
     2ae:	inc    DWORD PTR [rbx+rcx*4]
        diff[p.y_begin * (width + 1) + p.x_end  ] -= 1;
     2b1:	movsxd rcx,DWORD PTR [rax-0x14]
     2b5:	add    rdx,rcx
     2b8:	dec    DWORD PTR [rbx+rdx*4]
        diff[p.y_end   * (width + 1) + p.x_begin] -= 1;
     2bb:	lea    rdx,[rsi+rdi*1]
     2bf:	dec    DWORD PTR [rbx+rdx*4]
        diff[p.y_end   * (width + 1) + p.x_end  ] += 1;
     2c2:	lea    rdx,[rcx+rdi*1]
     2c6:	inc    DWORD PTR [rbx+rdx*4]
    for (const auto& p : params) {
     2c9:	cmp    rax,QWORD PTR [rsp+0x90]
     2d1:	jne    292 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x292>
    }

    for (int y = 0; y < h; ++y) {
     2d3:	test   r14d,r14d
     2d6:	jle    38f <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x38f>
     2dc:	mov    r8d,DWORD PTR [rsp+0x68]
     2e1:	test   r8d,r8d
     2e4:	jle    38f <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x38f>
        int row = 0;
        for (int x = 0; x < w; ++x) {
     2ea:	mov    rax,QWORD PTR [rsp+0xa0]
        int row = 0;
     2f2:	xor    esi,esi
     2f4:	lea    edx,[rax-0x1]
    for (int y = 0; y < h; ++y) {
     2f7:	xor    eax,eax
     2f9:	lea    r8,[rdx+0x1]
            row += diff[y * (width + 1) + x];
            counts[y * w + x] = row + (y > 0 ? counts[(y - 1) * w + x] : 0);
     2fd:	mov    rdx,QWORD PTR [rsp+0x50]
            row += diff[y * (width + 1) + x];
     302:	add    esi,DWORD PTR [rbx+rax*4]
            counts[y * w + x] = row + (y > 0 ? counts[(y - 1) * w + x] : 0);
     305:	mov    DWORD PTR [rdx+rax*4],esi
        for (int x = 0; x < w; ++x) {
     308:	inc    rax
     30b:	cmp    rax,r8
     30e:	jne    2fd <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x2fd>
    for (int y = 0; y < h; ++y) {
     310:	cmp    r14d,0x1
     314:	je     38f <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x38f>
     316:	mov    eax,DWORD PTR [rsp+0x68]
     31a:	shl    r11,0x2
        for (int x = 0; x < w; ++x) {
     31e:	xor    r10d,r10d
     321:	lea    rsi,[rbx+r11*1]
     325:	lea    r9,[rax*4+0x0]
     32d:	lea    rcx,[rdx+r9*1]
    for (int y = 0; y < h; ++y) {
     331:	mov    edx,0x1
        for (int x = 0; x < w; ++x) {
     336:	mov    rdi,QWORD PTR [rsp+0x50]
     33b:	movsxd rax,r10d
     33e:	add    r10d,DWORD PTR [rsp+0xa0]
        int row = 0;
     346:	mov    DWORD PTR [rsp+0x108],edx
     34d:	lea    rax,[rdi+rax*4]
     351:	xor    edi,edi
     353:	mov    QWORD PTR [rsp+0x110],rax
    for (int y = 0; y < h; ++y) {
     35b:	xor    eax,eax
            counts[y * w + x] = row + (y > 0 ? counts[(y - 1) * w + x] : 0);
     35d:	mov    rdx,QWORD PTR [rsp+0x110]
            row += diff[y * (width + 1) + x];
     365:	add    edi,DWORD PTR [rsi+rax*4]
            counts[y * w + x] = row + (y > 0 ? counts[(y - 1) * w + x] : 0);
     368:	mov    r12d,DWORD PTR [rdx+rax*4]
     36c:	add    r12d,edi
     36f:	mov    DWORD PTR [rcx+rax*4],r12d
        for (int x = 0; x < w; ++x) {
     373:	inc    rax
     376:	cmp    r8,rax
     379:	jne    35d <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x35d>
    for (int y = 0; y < h; ++y) {
     37b:	mov    edx,DWORD PTR [rsp+0x108]
     382:	add    rsi,r11
     385:	add    rcx,r9
     388:	inc    edx
     38a:	cmp    r14d,edx
     38d:	jg     336 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x336>
     38f:	mov    edi,0x2fa00
     394:	call   399 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x399>
     399:	mov    DWORD PTR [rax],0x0
      typedef typename __gnu_cxx::__conditional_type<__load_outside_loop,
						     const _Tp,
						     const _Tp&>::__type _Up;
      _Up __val(__value);
      for (; __first != __last; ++__first)
	*__first = __val;
     39f:	xor    esi,esi
	  if (__n > 0)
	    {
	      typename iterator_traits<_ForwardIterator>::value_type* __val
		= std::addressof(*__first);
	      std::_Construct(__val);
	      ++__first;
     3a1:	lea    rdi,[rax+0x4]
     3a5:	mov    edx,0x2f9fc
     3aa:	mov    QWORD PTR [rsp+0x28],rax
     3af:	mov    r13,rax
     3b2:	call   3b7 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x3b7>
    const int TILE_W = 2032;

    // Per-tile vals accumulator
    std::vector<float> tile_vals(TILE_H * TILE_W * 3);

    for (int ty = 0; ty < h; ty += TILE_H) {
     3b7:	test   r14d,r14d
     3ba:	jle    12b9 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x12b9>
     3c0:	mov    edi,DWORD PTR [rsp+0x68]
     3c4:	test   edi,edi
     3c6:	jle    12b9 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x12b9>
                const __m256 Cvx = _mm256_set1_ps(p.C);
                const __m256 Dvx = _mm256_set1_ps(p.D);

                for (int y = y_begin; y < y_end; ++y) {
                    size_t ind_ltop = ((y + p.sy) * width + (x_begin + p.sx)) * 3;
                    size_t ind_lbot = ind_ltop + width * 3;
     3cc:	mov    rax,QWORD PTR [rsp+0xa0]
                    int c = counts[y * width + (tx + x)];
                    if (c == 0) {
                        outp[x*3] = outp[x*3+1] = outp[x*3+2] = 0;
                        continue;
                    }
                    float inv_c = 1.0f / static_cast<float>(c);
     3d4:	mov    QWORD PTR [rsp+0x20],r15
     3d9:	vxorps xmm5,xmm5,xmm5
                    size_t ind_lbot = ind_ltop + width * 3;
     3dd:	xor    edx,edx
                    float inv_c = 1.0f / static_cast<float>(c);
     3df:	vmovss xmm23,DWORD PTR [rip+0x0]        # 3e9 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x3e9>
     3e9:	mov    QWORD PTR [rsp+0x18],rbx
     3ee:	mov    r8,r13
     3f1:	xor    ebx,ebx
                    size_t ind_lbot = ind_ltop + width * 3;
     3f3:	lea    rdi,[rax+rax*2]
                    float inv_c = 1.0f / static_cast<float>(c);
     3f7:	lea    r12,[rax*8+0x0]
                    size_t ind_lbot = ind_ltop + width * 3;
     3ff:	mov    QWORD PTR [rsp+0xc0],rdi
     407:	add    rdi,0x3
     40b:	mov    QWORD PTR [rsp+0xb8],rdi
        const int tile_y_end = std::min(ty + TILE_H, h);
     413:	mov    r15d,ebx
     416:	add    ebx,0x8
      if (__b < __a)
     419:	mov    eax,r14d
        const int tile_h_actual = tile_y_end - ty;
     41c:	mov    QWORD PTR [rsp+0x98],0x0
     428:	cmp    ebx,r14d
     42b:	mov    DWORD PTR [rsp+0x30],r14d
     430:	cmovle eax,ebx
     433:	mov    DWORD PTR [rsp+0x14],ebx
     437:	mov    QWORD PTR [rsp+0x8],r12
     43c:	mov    DWORD PTR [rsp+0x8c],eax
     443:	sub    eax,r15d
     446:	mov    DWORD PTR [rsp+0x34],eax
     44a:	mov    QWORD PTR [rsp+0x38],rdx
            const int tile_x_end = std::min(tx + TILE_W, w);
     44f:	mov    eax,DWORD PTR [rsp+0x98]
     456:	mov    edi,DWORD PTR [rsp+0x68]
     45a:	mov    ebx,DWORD PTR [rsp+0x98]
     461:	add    eax,0x7f0
     466:	cmp    eax,edi
     468:	cmovg  eax,edi
            const int tile_w_actual = tile_x_end - tx;
     46b:	mov    r13d,eax
     46e:	mov    r12d,eax
                      tile_vals.begin() + tile_h_actual * tile_w_actual * 3,
     471:	mov    eax,DWORD PTR [rsp+0x34]
            const int tile_w_actual = tile_x_end - tx;
     475:	sub    r13d,DWORD PTR [rsp+0x98]
                      tile_vals.begin() + tile_h_actual * tile_w_actual * 3,
     47d:	imul   eax,r13d
     481:	lea    edx,[rax+rax*2]

      _GLIBCXX_NODISCARD __attribute__((__always_inline__))
      _GLIBCXX_CONSTEXPR
      __normal_iterator
      operator+(difference_type __n) const _GLIBCXX_NOEXCEPT
      { return __normal_iterator(_M_current + __n); }
     484:	movsxd rdx,edx
      for (; __first != __last; ++__first)
     487:	shl    rdx,0x2
     48b:	je     4b9 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x4b9>
     48d:	vmovaps XMMWORD PTR [rsp+0x110],xmm5
	*__first = __val;
     496:	xor    esi,esi
     498:	mov    rdi,r8
     49b:	vzeroupper
     49e:	call   4a3 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x4a3>
     4a3:	vmovaps xmm5,XMMWORD PTR [rsp+0x110]
     4ac:	vmovss xmm23,DWORD PTR [rip+0x0]        # 4b6 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x4b6>
     4b6:	mov    r8,rax
            for (const SubParams& p : params) {
     4b9:	mov    rax,QWORD PTR [rsp+0x58]
     4be:	cmp    QWORD PTR [rsp+0x90],rax
     4c6:	je     114f <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x114f>
     4cc:	mov    QWORD PTR [rsp+0xf0],rax
     4d4:	lea    eax,[r13+r13*2+0x0]
     4d9:	cdqe
     4db:	mov    DWORD PTR [rsp+0x6c],r13d
     4e0:	shl    rax,0x2
     4e4:	mov    QWORD PTR [rsp+0x60],r8
     4e9:	mov    r8d,DWORD PTR [rsp+0x8c]
     4f1:	mov    QWORD PTR [rsp+0xc8],rax
     4f9:	nop    DWORD PTR [rax+0x0]
      if (__a < __b)
     500:	mov    rdi,QWORD PTR [rsp+0xf0]
     508:	mov    eax,DWORD PTR [rdi+0x20]
      if (__b < __a)
     50b:	mov    edx,DWORD PTR [rdi+0x1c]
      if (__a < __b)
     50e:	cmp    r15d,eax
     511:	mov    esi,eax
      if (__b < __a)
     513:	mov    eax,DWORD PTR [rdi+0x24]
      if (__a < __b)
     516:	cmovge esi,r15d
      if (__b < __a)
     51a:	cmp    r8d,eax
     51d:	cmovle eax,r8d
      if (__a < __b)
     521:	mov    DWORD PTR [rsp+0xf8],esi
      if (__b < __a)
     528:	mov    DWORD PTR [rsp+0xd8],eax
     52f:	mov    ecx,eax
      if (__a < __b)
     531:	mov    eax,DWORD PTR [rdi+0x18]
     534:	cmp    ebx,eax
     536:	cmovge eax,ebx
      if (__b < __a)
     539:	cmp    r12d,edx
     53c:	cmovle edx,r12d
                if (x_begin >= x_end || y_begin >= y_end) continue;
     540:	cmp    edx,eax
     542:	jle    1126 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x1126>
     548:	mov    r14d,esi
     54b:	cmp    esi,ecx
     54d:	jge    1126 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x1126>
                                + (x_begin - tx) * 3;
     553:	mov    ecx,eax
                    const int x_stop = (x_end - tx) * 3;
     555:	sub    edx,ebx
     557:	mov    esi,esi
                    size_t ind_ltop = ((y + p.sy) * width + (x_begin + p.sx)) * 3;
     559:	add    eax,DWORD PTR [rdi]
                                + (x_begin - tx) * 3;
     55b:	sub    ecx,ebx
                    const int x_stop = (x_end - tx) * 3;
     55d:	lea    r9d,[rdx+rdx*2]
                    size_t ind_ltop = ((y + p.sy) * width + (x_begin + p.sx)) * 3;
     561:	cdqe
                const __m256 Avx = _mm256_set1_ps(p.A);
     563:	vmovss xmm18,DWORD PTR [rdi+0x8]
                                + (x_begin - tx) * 3;
     56a:	lea    r10d,[rcx+rcx*2]
     56e:	movsxd rcx,ecx
                const __m256 Bvx = _mm256_set1_ps(p.B);
     571:	vmovss xmm17,DWORD PTR [rdi+0xc]
                const __m256 Cvx = _mm256_set1_ps(p.C);
     578:	vmovss xmm16,DWORD PTR [rdi+0x10]
                    for (; x + 8 <= x_stop; x += 8) {
     57f:	lea    edx,[r10+0x7]
                const __m256 Dvx = _mm256_set1_ps(p.D);
     583:	vmovss xmm15,DWORD PTR [rdi+0x14]
                                + (x_begin - tx) * 3;
     588:	mov    DWORD PTR [rsp+0x88],r10d
                const __m256 Avx = _mm256_set1_ps(p.A);
     590:	vbroadcastss ymm11,xmm18
                    for (; x + 8 <= x_stop; x += 8) {
     596:	mov    DWORD PTR [rsp+0xd4],edx
     59d:	movsxd rdx,DWORD PTR [rdi+0x4]
                const __m256 Bvx = _mm256_set1_ps(p.B);
     5a1:	vbroadcastss ymm12,xmm17
                const __m256 Cvx = _mm256_set1_ps(p.C);
     5a7:	vbroadcastss ymm13,xmm16
                    const int x_stop = (x_end - tx) * 3;
     5ad:	mov    DWORD PTR [rsp+0xdc],r9d
                const __m256 Dvx = _mm256_set1_ps(p.D);
     5b5:	vbroadcastss ymm10,xmm15
/* Create a vector with all elements equal to A.  */
extern __inline __m256 __attribute__((__gnu_inline__, __always_inline__, __artificial__))
_mm256_set1_ps (float __A)
{
  return __extension__ (__m256){ __A, __A, __A, __A,
				 __A, __A, __A, __A };
     5ba:	vmovaps ymm3,ymm11
     5be:	vmovaps ymm2,ymm12
  return __extension__ (__m256){ __A, __A, __A, __A,
     5c2:	add    rdx,rsi
     5c5:	mov    DWORD PTR [rsp+0x7c],r12d
				 __A, __A, __A, __A };
     5ca:	vmovaps ymm1,ymm13
     5ce:	vmovaps ymm0,ymm10
                for (int y = y_begin; y < y_end; ++y) {
     5d2:	imul   rdx,QWORD PTR [rsp+0xa0]
     5db:	mov    DWORD PTR [rsp+0x78],r8d
     5e0:	mov    DWORD PTR [rsp+0x74],ebx
     5e4:	mov    DWORD PTR [rsp+0x70],r15d
     5e9:	add    rdx,rax
     5ec:	mov    eax,r14d
     5ef:	sub    eax,r15d
     5f2:	lea    r11,[rdx+rdx*2]
     5f6:	mov    rdx,QWORD PTR [rsp+0x60]
     5fb:	imul   eax,DWORD PTR [rsp+0x6c]
     600:	cdqe
     602:	add    rax,rcx
     605:	lea    rax,[rax+rax*2]
     609:	lea    rax,[rdx+rax*4]
     60d:	mov    QWORD PTR [rsp+0xe0],rax
     615:	lea    eax,[r9-0x8]
     619:	sub    eax,r10d
     61c:	mov    edx,eax
     61e:	shr    eax,0x3
     621:	and    edx,0xfffffff8
     624:	inc    rax
     627:	lea    edx,[r10+rdx*1+0x8]
     62c:	mov    DWORD PTR [rsp+0xd0],edx
     633:	mov    rdx,rax
     636:	shl    rax,0x3
     63a:	shl    rdx,0x5
     63e:	mov    QWORD PTR [rsp+0xa8],rax
     646:	mov    QWORD PTR [rsp+0xb0],rdx
     64e:	xchg   ax,ax
                    size_t ind_lbot = ind_ltop + width * 3;
     650:	mov    rdx,r11
                                + (x_begin - tx) * 3;
     653:	mov    rdi,QWORD PTR [rsp+0xe0]
                    for (; x + 8 <= x_stop; x += 8) {
     65b:	mov    ecx,DWORD PTR [rsp+0xdc]
                    size_t ind_rtop = ind_ltop + 3;
     662:	lea    rax,[rdx+0x3]
                    size_t ind_lbot = ind_ltop + width * 3;
     666:	add    r11,QWORD PTR [rsp+0xc0]
                    size_t ind_rtop = ind_ltop + 3;
     66e:	mov    QWORD PTR [rsp+0x110],rax
                    size_t ind_rbot = ind_lbot + 3;
     676:	mov    rax,QWORD PTR [rsp+0xb8]
     67e:	lea    r15,[rax+rdx*1]
                                + (x_begin - tx) * 3;
     682:	mov    rax,rdi
                    for (; x + 8 <= x_stop; x += 8) {
     685:	cmp    DWORD PTR [rsp+0xd4],ecx
     68c:	jge    1388 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x1388>
     692:	mov    rbx,QWORD PTR [rsp+0xf0]
     69a:	add    rdi,QWORD PTR [rsp+0xb0]
     6a2:	mov    rcx,QWORD PTR [rbx+0x28]
     6a6:	add    rcx,r11
     6a9:	nop    DWORD PTR [rax+0x0]
}

extern __inline __m128i __attribute__((__gnu_inline__, __always_inline__, __artificial__))
_mm_loadl_epi64 (__m128i_u const *__P)
{
  return _mm_set_epi64 ((__m64)0LL, *(__m64_u *)__P);
     6b0:	mov    rsi,rcx

extern __inline __m256i
__attribute__ ((__gnu_inline__, __always_inline__, __artificial__))
_mm256_cvtepu8_epi32 (__m128i __X)
{
  return (__m256i) __builtin_ia32_pmovzxbd256 ((__v16qi)__X);
     6b3:	vpmovzxbd ymm6,QWORD PTR [rcx]
     6b8:	vpmovzxbd ymm4,QWORD PTR [rcx+0x3]
                        vp += 8;
     6be:	add    rax,0x20
     6c2:	sub    rsi,r11
                    for (; x + 8 <= x_stop; x += 8) {
     6c5:	add    rcx,0x8
     6c9:	vpmovzxbd ymm8,QWORD PTR [rsi+rdx*1]
     6cf:	vpmovzxbd ymm7,QWORD PTR [rsi+rdx*1+0x3]
  return (__m256)__builtin_ia32_cvtdq2ps256 ((__v8si) __A);
     6d6:	vcvtdq2ps ymm6,ymm6
     6da:	vcvtdq2ps ymm4,ymm4
     6de:	vcvtdq2ps ymm8,ymm8

extern __inline __m256
__attribute__((__gnu_inline__, __always_inline__, __artificial__))
_mm256_fmadd_ps (__m256 __A, __m256 __B, __m256 __C)
{
  return (__m256)__builtin_ia32_vfmaddps256 ((__v8sf)__A, (__v8sf)__B,
     6e3:	vfmadd213ps ymm8,ymm3,YMMWORD PTR [rax-0x20]
     6e9:	vcvtdq2ps ymm7,ymm7
     6ed:	vfmadd132ps ymm7,ymm8,ymm2
     6f2:	vfmadd132ps ymm6,ymm7,ymm1
     6f7:	vfmadd132ps ymm4,ymm6,ymm0
  *(__m256_u *)__P = __A;
     6fc:	vmovups YMMWORD PTR [rax-0x20],ymm4
     701:	cmp    rax,rdi
     704:	jne    6b0 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x6b0>
     706:	mov    rdi,QWORD PTR [rsp+0xa8]
     70e:	mov    ecx,DWORD PTR [rsp+0xd0]
     715:	lea    rbx,[r11+rdi*1]
     719:	add    QWORD PTR [rsp+0x110],rdi
     721:	add    r15,rdi
     724:	add    rdx,rdi
     727:	mov    QWORD PTR [rsp+0xe8],rbx
                    int remaining = x_stop - x;
     72f:	mov    ebx,DWORD PTR [rsp+0xdc]
     736:	sub    ebx,ecx
     738:	mov    DWORD PTR [rsp+0x108],ebx
                    for (int k = 0; k < remaining; ++k) {
     73f:	test   ebx,ebx
     741:	jle    10e8 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x10e8>
                        float TL = p.SUB[ind_ltop + k];
     747:	mov    rdi,QWORD PTR [rsp+0xf0]
     74f:	lea    ecx,[rbx-0x1]
     752:	mov    rdi,QWORD PTR [rdi+0x28]
     756:	cmp    ecx,0x1e
     759:	jbe    139c <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x139c>
     75f:	shr    ebx,0x5
     762:	lea    r13,[rdi+r15*1]
     766:	lea    rsi,[rdi+rdx*1]
     76a:	mov    r8,rax
     76d:	mov    r10d,ebx
     770:	mov    rbx,QWORD PTR [rsp+0xe8]
     778:	xor    r9d,r9d
     77b:	lea    rcx,[rdi+rbx*1]
     77f:	mov    rbx,QWORD PTR [rsp+0x110]
     787:	lea    r12,[rdi+rbx*1]
     78b:	mov    ebx,r10d
     78e:	shl    rbx,0x5
     792:	nop    WORD PTR [rax+rax*1+0x0]
                        float BL = p.SUB[ind_lbot + k];
     798:	vmovdqu ymm8,YMMWORD PTR [rcx+r9*1]
                        float TR = p.SUB[ind_rtop + k];
     79e:	vmovdqu ymm4,YMMWORD PTR [r12+r9*1]
     7a4:	sub    r8,0xffffffffffffff80
                        float TL = p.SUB[ind_ltop + k];
     7a8:	vmovdqu ymm7,YMMWORD PTR [rsi+r9*1]
                        float BL = p.SUB[ind_lbot + k];
     7ae:	vpmovzxbw ymm6,xmm8
                        float TR = p.SUB[ind_rtop + k];
     7b3:	vpmovzxbw ymm9,xmm4
                        float BL = p.SUB[ind_lbot + k];
     7b8:	vextracti32x4 xmm8,ymm8,0x1
     7bf:	vpmovsxwd ymm19,xmm6
     7c5:	vextracti32x4 xmm6,ymm6,0x1
                        float TR = p.SUB[ind_rtop + k];
     7cc:	vpmovsxwd ymm14,xmm9
                        float BL = p.SUB[ind_lbot + k];
     7d1:	vpmovsxwd ymm6,xmm6
                        float TR = p.SUB[ind_rtop + k];
     7d6:	vextracti32x4 xmm9,ymm9,0x1
                        float BL = p.SUB[ind_lbot + k];
     7dd:	vpmovzxbw ymm8,xmm8
     7e2:	vcvtdq2ps ymm19,ymm19
                        float TR = p.SUB[ind_rtop + k];
     7e8:	vcvtdq2ps ymm14,ymm14
                        float BL = p.SUB[ind_lbot + k];
     7ed:	vcvtdq2ps ymm6,ymm6
                        vp[k] += p.A*TL + p.B*TR + p.C*BL + p.D*BR;
     7f1:	vmulps ymm6,ymm6,ymm1
                        float TR = p.SUB[ind_rtop + k];
     7f5:	vpmovsxwd ymm9,xmm9
                        float BL = p.SUB[ind_lbot + k];
     7fa:	vextracti32x4 xmm20,ymm8,0x1
                        vp[k] += p.A*TL + p.B*TR + p.C*BL + p.D*BR;
     801:	vmulps ymm19,ymm19,ymm1
                        float TR = p.SUB[ind_rtop + k];
     807:	vcvtdq2ps ymm9,ymm9
                        float TL = p.SUB[ind_ltop + k];
     80c:	vpmovzxbw ymm22,xmm7
                        float TR = p.SUB[ind_rtop + k];
     812:	vextracti32x4 xmm4,ymm4,0x1
                        float BL = p.SUB[ind_lbot + k];
     819:	vpmovsxwd ymm20,xmm20
                        float TR = p.SUB[ind_rtop + k];
     81f:	vpmovzxbw ymm4,xmm4
                        float TL = p.SUB[ind_ltop + k];
     824:	vextracti32x4 xmm7,ymm7,0x1
                        float BL = p.SUB[ind_lbot + k];
     82b:	vcvtdq2ps ymm20,ymm20
                        vp[k] += p.A*TL + p.B*TR + p.C*BL + p.D*BR;
     831:	vmulps ymm20,ymm20,ymm1
                        float TL = p.SUB[ind_ltop + k];
     837:	vpmovzxbw ymm7,xmm7
                        float BL = p.SUB[ind_lbot + k];
     83c:	vfmadd132ps ymm9,ymm6,ymm2
     841:	vpmovsxwd ymm6,xmm8
                        float TL = p.SUB[ind_ltop + k];
     846:	vpmovsxwd ymm8,xmm22
                        float BL = p.SUB[ind_lbot + k];
     84c:	vcvtdq2ps ymm6,ymm6
                        vp[k] += p.A*TL + p.B*TR + p.C*BL + p.D*BR;
     850:	vmulps ymm6,ymm6,ymm1
     854:	vfmadd132ps ymm14,ymm19,ymm2
                        float TL = p.SUB[ind_ltop + k];
     85a:	vcvtdq2ps ymm8,ymm8
                        float TR = p.SUB[ind_rtop + k];
     85f:	vpmovsxwd ymm19,xmm4
     865:	vfmadd213ps ymm8,ymm3,YMMWORD PTR [r8-0x80]
     86b:	vcvtdq2ps ymm19,ymm19
     871:	vfmadd132ps ymm19,ymm6,ymm2
     877:	vextracti32x4 xmm6,ymm4,0x1
                        float BR = p.SUB[ind_rbot + k];
     87e:	vmovdqu ymm4,YMMWORD PTR [r13+r9*1+0x0]
     885:	add    r9,0x20
                        float TR = p.SUB[ind_rtop + k];
     889:	vpmovsxwd ymm6,xmm6
                        float BR = p.SUB[ind_rbot + k];
     88e:	vpmovzxbw ymm21,xmm4
                        float TR = p.SUB[ind_rtop + k];
     894:	vcvtdq2ps ymm6,ymm6
     898:	vfmadd132ps ymm6,ymm20,ymm2
                        float BR = p.SUB[ind_rbot + k];
     89e:	vextracti32x4 xmm4,ymm4,0x1
     8a5:	vpmovsxwd ymm20,xmm21
     8ab:	vextracti32x4 xmm21,ymm21,0x1
     8b2:	vpmovzxbw ymm4,xmm4
     8b7:	vcvtdq2ps ymm20,ymm20
     8bd:	vfmadd132ps ymm20,ymm8,ymm0
                        float TL = p.SUB[ind_ltop + k];
     8c3:	vextracti32x4 xmm8,ymm22,0x1
                        float BR = p.SUB[ind_rbot + k];
     8ca:	vpmovsxwd ymm21,xmm21
                        float TL = p.SUB[ind_ltop + k];
     8d0:	vpmovsxwd ymm8,xmm8
                        float BR = p.SUB[ind_rbot + k];
     8d5:	vcvtdq2ps ymm21,ymm21
     8db:	vpmovsxwd ymm22,xmm4
     8e1:	vextracti32x4 xmm4,ymm4,0x1
                        float TL = p.SUB[ind_ltop + k];
     8e8:	vcvtdq2ps ymm8,ymm8
     8ed:	vfmadd213ps ymm8,ymm3,YMMWORD PTR [r8-0x60]
                        float BR = p.SUB[ind_rbot + k];
     8f3:	vpmovsxwd ymm4,xmm4
     8f8:	vcvtdq2ps ymm22,ymm22
     8fe:	vcvtdq2ps ymm4,ymm4
                        vp[k] += p.A*TL + p.B*TR + p.C*BL + p.D*BR;
     902:	vaddps ymm14,ymm14,ymm20
     908:	vfmadd132ps ymm21,ymm8,ymm0
                        float TL = p.SUB[ind_ltop + k];
     90e:	vpmovsxwd ymm8,xmm7
     913:	vextracti32x4 xmm7,ymm7,0x1
     91a:	vpmovsxwd ymm7,xmm7
     91f:	vcvtdq2ps ymm8,ymm8
     924:	vfmadd213ps ymm8,ymm3,YMMWORD PTR [r8-0x40]
                        vp[k] += p.A*TL + p.B*TR + p.C*BL + p.D*BR;
     92a:	vmovups YMMWORD PTR [r8-0x80],ymm14
                        float TL = p.SUB[ind_ltop + k];
     930:	vcvtdq2ps ymm7,ymm7
                        vp[k] += p.A*TL + p.B*TR + p.C*BL + p.D*BR;
     934:	vfmadd213ps ymm7,ymm3,YMMWORD PTR [r8-0x20]
     93a:	vaddps ymm9,ymm9,ymm21
     940:	vfmadd132ps ymm22,ymm8,ymm0
     946:	vfmadd132ps ymm4,ymm7,ymm0
     94b:	vmovups YMMWORD PTR [r8-0x60],ymm9
     951:	vaddps ymm22,ymm22,ymm19
     957:	vaddps ymm4,ymm4,ymm6
     95b:	vmovups YMMWORD PTR [r8-0x40],ymm22
     962:	vmovups YMMWORD PTR [r8-0x20],ymm4
                    for (int k = 0; k < remaining; ++k) {
     968:	cmp    rbx,r9
     96b:	jne    798 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x798>
     971:	shl    r10d,0x5
     975:	cmp    r10d,DWORD PTR [rsp+0x108]
     97d:	je     10e8 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x10e8>
     983:	mov    r8d,r10d
     986:	mov    r12d,DWORD PTR [rsp+0x108]
     98e:	sub    r12d,r10d
     991:	lea    r9d,[r12-0x1]
     996:	cmp    r9d,0xe
     99a:	jbe    13b7 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x13b7>
     9a0:	mov    ebx,r10d
                        float TR = p.SUB[ind_rtop + k];
     9a3:	mov    r13,QWORD PTR [rsp+0x110]
                        float BL = p.SUB[ind_lbot + k];
     9ab:	vmovdqu xmm8,XMMWORD PTR [rcx+rbx*1]
     9b0:	lea    r14,[rbx+r15*1]
                        float TL = p.SUB[ind_ltop + k];
     9b4:	vmovdqu xmm7,XMMWORD PTR [rsi+rbx*1]
     9b9:	lea    r9,[rax+rbx*4]
     9bd:	mov    QWORD PTR [rsp+0x100],r14
                        float TR = p.SUB[ind_rtop + k];
     9c5:	lea    r14,[rdi+rbx*1]
                        float BL = p.SUB[ind_lbot + k];
     9c9:	vpmovzxbw xmm6,xmm8
                        float TR = p.SUB[ind_rtop + k];
     9ce:	vmovdqu xmm4,XMMWORD PTR [r14+r13*1]
                        float BL = p.SUB[ind_lbot + k];
     9d4:	vpsrldq xmm8,xmm8,0x8
                        float TL = p.SUB[ind_ltop + k];
     9da:	vpmovzxbw xmm21,xmm7
                        float BL = p.SUB[ind_lbot + k];
     9e0:	vpmovsxwd xmm14,xmm6
     9e5:	vpsrldq xmm6,xmm6,0x8
     9ea:	vpmovzxbw xmm8,xmm8
     9ef:	vpmovsxwd xmm6,xmm6
                        float TR = p.SUB[ind_rtop + k];
     9f4:	vpmovzxbw xmm9,xmm4
                        float BL = p.SUB[ind_lbot + k];
     9f9:	vcvtdq2ps xmm14,xmm14
                        float TL = p.SUB[ind_ltop + k];
     9fe:	vpmovsxwd xmm22,xmm21
                        float BR = p.SUB[ind_rbot + k];
     a04:	mov    rbx,QWORD PTR [rsp+0x100]
                        float BL = p.SUB[ind_lbot + k];
     a0c:	vcvtdq2ps xmm6,xmm6
                        vp[k] += p.A*TL + p.B*TR + p.C*BL + p.D*BR;
     a10:	vmulps xmm6,xmm6,xmm13
                        float BL = p.SUB[ind_lbot + k];
     a15:	vpsrldq xmm20,xmm8,0x8
                        float TR = p.SUB[ind_rtop + k];
     a1c:	vpmovsxwd xmm19,xmm9
                        float TL = p.SUB[ind_ltop + k];
     a22:	vcvtdq2ps xmm22,xmm22
                        float TR = p.SUB[ind_rtop + k];
     a28:	vpsrldq xmm9,xmm9,0x8
     a2e:	vpsrldq xmm4,xmm4,0x8
                        float BL = p.SUB[ind_lbot + k];
     a33:	vpmovsxwd xmm20,xmm20
                        float TR = p.SUB[ind_rtop + k];
     a39:	vcvtdq2ps xmm19,xmm19
     a3f:	vpmovsxwd xmm9,xmm9
                        float BL = p.SUB[ind_lbot + k];
     a44:	vcvtdq2ps xmm20,xmm20
     a4a:	vfmadd213ps xmm22,xmm11,XMMWORD PTR [r9]
                        float TR = p.SUB[ind_rtop + k];
     a50:	vpmovzxbw xmm4,xmm4
                        vp[k] += p.A*TL + p.B*TR + p.C*BL + p.D*BR;
     a55:	vmulps xmm14,xmm14,xmm13
                        float TR = p.SUB[ind_rtop + k];
     a5a:	vcvtdq2ps xmm9,xmm9
                        float TL = p.SUB[ind_ltop + k];
     a5f:	vpsrldq xmm7,xmm7,0x8
                        vp[k] += p.A*TL + p.B*TR + p.C*BL + p.D*BR;
     a64:	vmulps xmm20,xmm20,xmm13
                        float TL = p.SUB[ind_ltop + k];
     a6a:	vpmovzxbw xmm7,xmm7
                        float BL = p.SUB[ind_lbot + k];
     a6f:	vfmadd132ps xmm9,xmm6,xmm12
     a74:	vpmovsxwd xmm6,xmm8
     a79:	vcvtdq2ps xmm6,xmm6
                        vp[k] += p.A*TL + p.B*TR + p.C*BL + p.D*BR;
     a7d:	vmulps xmm6,xmm6,xmm13
     a82:	vfmadd132ps xmm19,xmm14,xmm12
                        float TR = p.SUB[ind_rtop + k];
     a88:	vpmovsxwd xmm14,xmm4
     a8d:	vcvtdq2ps xmm14,xmm14
     a92:	vfmadd132ps xmm14,xmm6,xmm12
     a97:	vpsrldq xmm6,xmm4,0x8
                        float BR = p.SUB[ind_rbot + k];
     a9c:	vmovdqu xmm4,XMMWORD PTR [rdi+rbx*1]
                        float TR = p.SUB[ind_rtop + k];
     aa1:	vpmovsxwd xmm6,xmm6
                        float BR = p.SUB[ind_rbot + k];
     aa6:	vpmovzxbw xmm8,xmm4
                        float TR = p.SUB[ind_rtop + k];
     aab:	vcvtdq2ps xmm6,xmm6
     aaf:	vfmadd132ps xmm6,xmm20,xmm12
                        float BR = p.SUB[ind_rbot + k];
     ab5:	vpmovsxwd xmm20,xmm8
     abb:	vpsrldq xmm4,xmm4,0x8
     ac0:	vcvtdq2ps xmm20,xmm20
     ac6:	vfmadd132ps xmm20,xmm22,xmm10
     acc:	vpsrldq xmm22,xmm8,0x8
     ad3:	vpmovzxbw xmm4,xmm4
                        float TL = p.SUB[ind_ltop + k];
     ad8:	vpsrldq xmm8,xmm21,0x8
     adf:	vpmovsxwd xmm21,xmm7
                        float BR = p.SUB[ind_rbot + k];
     ae5:	vpmovsxwd xmm22,xmm22
                        float TL = p.SUB[ind_ltop + k];
     aeb:	vpmovsxwd xmm8,xmm8
     af0:	vpsrldq xmm7,xmm7,0x8
     af5:	vcvtdq2ps xmm21,xmm21
                        float BR = p.SUB[ind_rbot + k];
     afb:	vcvtdq2ps xmm22,xmm22
                        float TL = p.SUB[ind_ltop + k];
     b01:	vcvtdq2ps xmm8,xmm8
     b06:	vfmadd213ps xmm8,xmm11,XMMWORD PTR [r9+0x10]
     b0c:	vfmadd213ps xmm21,xmm11,XMMWORD PTR [r9+0x20]
     b13:	vpmovsxwd xmm7,xmm7
     b18:	vcvtdq2ps xmm7,xmm7
                        vp[k] += p.A*TL + p.B*TR + p.C*BL + p.D*BR;
     b1c:	vfmadd213ps xmm7,xmm11,XMMWORD PTR [r9+0x30]
     b22:	vaddps xmm19,xmm19,xmm20
     b28:	vfmadd132ps xmm22,xmm8,xmm10
                        float BR = p.SUB[ind_rbot + k];
     b2e:	vpmovsxwd xmm8,xmm4
                        vp[k] += p.A*TL + p.B*TR + p.C*BL + p.D*BR;
     b33:	vmovups XMMWORD PTR [r9],xmm19
                        float BR = p.SUB[ind_rbot + k];
     b39:	vpsrldq xmm4,xmm4,0x8
     b3e:	vcvtdq2ps xmm8,xmm8
     b43:	vfmadd132ps xmm8,xmm21,xmm10
     b49:	vpmovsxwd xmm4,xmm4
     b4e:	vcvtdq2ps xmm4,xmm4
                        vp[k] += p.A*TL + p.B*TR + p.C*BL + p.D*BR;
     b52:	vfmadd132ps xmm4,xmm7,xmm10
     b57:	vaddps xmm9,xmm9,xmm22
     b5d:	vaddps xmm14,xmm14,xmm8
     b62:	vaddps xmm4,xmm4,xmm6
     b66:	vmovups XMMWORD PTR [r9+0x10],xmm9
     b6c:	vmovups XMMWORD PTR [r9+0x20],xmm14
     b72:	vmovups XMMWORD PTR [r9+0x30],xmm4
                    for (int k = 0; k < remaining; ++k) {
     b78:	mov    r9d,r12d
     b7b:	and    r9d,0xfffffff0
     b7f:	test   r12b,0xf
     b83:	je     10e8 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x10e8>
     b89:	add    r8d,r9d
     b8c:	sub    r12d,r9d
     b8f:	lea    ebx,[r12-0x1]
     b94:	cmp    ebx,0x6
     b97:	jbe    dde <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0xdde>
     b9d:	add    r9d,r10d
                        float TR = p.SUB[ind_rtop + k];
     ba0:	mov    r14,QWORD PTR [rsp+0x110]
     ba8:	mov    r9d,r9d
                        float TL = p.SUB[ind_ltop + k];
     bab:	vmovq  xmm4,QWORD PTR [rsi+r9*1]
                        float TR = p.SUB[ind_rtop + k];
     bb1:	add    r14,rdi
     bb4:	lea    r13,[r15+r9*1]
     bb8:	lea    rbx,[rax+r9*4]
                        float TL = p.SUB[ind_ltop + k];
     bbc:	vpmovzxbw xmm7,xmm4
     bc1:	vpsrlq xmm4,xmm4,0x20
     bc6:	vpmovzxbw xmm6,xmm4
                        float TR = p.SUB[ind_rtop + k];
     bcb:	vmovq  xmm4,QWORD PTR [r14+r9*1]
                        float TL = p.SUB[ind_ltop + k];
     bd1:	vmovq  r10,xmm6
                        float BL = p.SUB[ind_lbot + k];
     bd6:	vmovq  xmm6,QWORD PTR [rcx+r9*1]
     bdc:	mov    r9d,r12d
                        float TR = p.SUB[ind_rtop + k];
     bdf:	vpmovzxbw xmm9,xmm4
     be4:	vpsrlq xmm4,xmm4,0x20
     be9:	and    r9d,0xfffffff8
     bed:	and    r12d,0x7
     bf1:	vpmovzxwd xmm14,xmm9
                        float BL = p.SUB[ind_lbot + k];
     bf6:	vpmovzxbw xmm8,xmm6
                        float TR = p.SUB[ind_rtop + k];
     bfb:	vpmovzxbw xmm4,xmm4
     c00:	vpsrlq xmm9,xmm9,0x20
                        float BL = p.SUB[ind_lbot + k];
     c06:	vpsrlq xmm6,xmm6,0x20
                        float TR = p.SUB[ind_rtop + k];
     c0b:	vmovq  xmm14,xmm14
     c10:	vcvtdq2ps xmm20,xmm14
                        float BL = p.SUB[ind_lbot + k];
     c16:	vpmovzxwd xmm14,xmm8
     c1b:	vpsrlq xmm8,xmm8,0x20
                        float TR = p.SUB[ind_rtop + k];
     c21:	vpmovzxwd xmm9,xmm9
                        float BL = p.SUB[ind_lbot + k];
     c26:	vpmovzxwd xmm8,xmm8
                        float TR = p.SUB[ind_rtop + k];
     c2b:	vmovq  xmm9,xmm9
                        float BL = p.SUB[ind_lbot + k];
     c30:	vpmovzxbw xmm6,xmm6
     c35:	vmovq  xmm8,xmm8
                        float TR = p.SUB[ind_rtop + k];
     c3a:	vcvtdq2ps xmm9,xmm9
                        float BL = p.SUB[ind_lbot + k];
     c3f:	vmovq  xmm19,xmm14
     c45:	vcvtdq2ps xmm8,xmm8
                        vp[k] += p.A*TL + p.B*TR + p.C*BL + p.D*BR;
     c4a:	vmulps xmm8,xmm8,xmm13
                        float BL = p.SUB[ind_lbot + k];
     c4f:	vcvtdq2ps xmm19,xmm19
                        vp[k] += p.A*TL + p.B*TR + p.C*BL + p.D*BR;
     c55:	vmulps xmm19,xmm19,xmm13
     c5b:	vfmadd132ps xmm9,xmm8,xmm12
                        float TR = p.SUB[ind_rtop + k];
     c60:	vpmovzxwd xmm8,xmm4
     c65:	vmovq  xmm8,xmm8
     c6a:	vfmadd231ps xmm19,xmm12,xmm20
     c70:	vcvtdq2ps xmm14,xmm8
     c75:	vmovaps xmm21,xmm9
                        float BL = p.SUB[ind_lbot + k];
     c7b:	vpmovzxwd xmm9,xmm6
     c80:	vmovq  xmm9,xmm9
     c85:	vpsrlq xmm6,xmm6,0x20
     c8a:	vcvtdq2ps xmm9,xmm9
                        vp[k] += p.A*TL + p.B*TR + p.C*BL + p.D*BR;
     c8f:	vmulps xmm9,xmm9,xmm13
                        float BL = p.SUB[ind_lbot + k];
     c94:	vpmovzxwd xmm6,xmm6
     c99:	vmovq  xmm6,xmm6
     c9d:	vcvtdq2ps xmm6,xmm6
                        vp[k] += p.A*TL + p.B*TR + p.C*BL + p.D*BR;
     ca1:	vmulps xmm6,xmm6,xmm13
     ca6:	vfmadd132ps xmm14,xmm9,xmm12
     cab:	vmovq  xmm9,QWORD PTR [rbx]
     caf:	vmovaps xmm22,xmm14
                        float TR = p.SUB[ind_rtop + k];
     cb5:	vpsrlq xmm14,xmm4,0x20
                        float BR = p.SUB[ind_rbot + k];
     cba:	vmovq  xmm4,QWORD PTR [rdi+r13*1]
                        float TR = p.SUB[ind_rtop + k];
     cc0:	vpmovzxwd xmm14,xmm14
     cc5:	vmovq  xmm14,xmm14
     cca:	vcvtdq2ps xmm14,xmm14
     ccf:	vfmadd132ps xmm14,xmm6,xmm12
                        float BR = p.SUB[ind_rbot + k];
     cd4:	vpmovzxbw xmm6,xmm4
     cd9:	vpmovzxwd xmm8,xmm6
     cde:	vpsrlq xmm6,xmm6,0x20
     ce3:	vmovq  xmm8,xmm8
     ce8:	vpsrlq xmm4,xmm4,0x20
     ced:	vpmovzxwd xmm6,xmm6
     cf2:	vcvtdq2ps xmm20,xmm8
                        float TL = p.SUB[ind_ltop + k];
     cf8:	vpmovzxwd xmm8,xmm7
     cfd:	vpsrlq xmm7,xmm7,0x20
                        float BR = p.SUB[ind_rbot + k];
     d02:	vpmovzxbw xmm4,xmm4
                        float TL = p.SUB[ind_ltop + k];
     d07:	vmovq  xmm8,xmm8
     d0c:	vpmovzxwd xmm7,xmm7
                        float BR = p.SUB[ind_rbot + k];
     d11:	vmovq  xmm6,xmm6
                        float TL = p.SUB[ind_ltop + k];
     d15:	vcvtdq2ps xmm8,xmm8
     d1a:	vfmadd231ps xmm9,xmm11,xmm8
                        vp[k] += p.A*TL + p.B*TR + p.C*BL + p.D*BR;
     d1f:	vmovq  xmm8,QWORD PTR [rbx+0x8]
                        float TL = p.SUB[ind_ltop + k];
     d24:	vmovq  xmm7,xmm7
                        float BR = p.SUB[ind_rbot + k];
     d28:	vcvtdq2ps xmm6,xmm6
                        float TL = p.SUB[ind_ltop + k];
     d2c:	vcvtdq2ps xmm7,xmm7
     d30:	vfmadd132ps xmm7,xmm8,xmm11
     d35:	vfmadd132ps xmm20,xmm9,xmm10
     d3b:	vmovq  xmm9,r10
     d40:	vpmovzxwd xmm8,xmm9
                        vp[k] += p.A*TL + p.B*TR + p.C*BL + p.D*BR;
     d45:	vmovq  xmm9,QWORD PTR [rbx+0x10]
                        float TL = p.SUB[ind_ltop + k];
     d4a:	vmovq  xmm8,xmm8
     d4f:	vfmadd132ps xmm6,xmm7,xmm10
                        float BR = p.SUB[ind_rbot + k];
     d54:	vpmovzxwd xmm7,xmm4
                        float TL = p.SUB[ind_ltop + k];
     d59:	vcvtdq2ps xmm8,xmm8
     d5e:	vfmadd132ps xmm8,xmm9,xmm11
                        float BR = p.SUB[ind_rbot + k];
     d63:	vmovq  xmm7,xmm7
                        float TL = p.SUB[ind_ltop + k];
     d67:	vmovq  xmm9,r10
                        float BR = p.SUB[ind_rbot + k];
     d6c:	vcvtdq2ps xmm7,xmm7
     d70:	vpsrlq xmm4,xmm4,0x20
     d75:	vpmovzxwd xmm4,xmm4
     d7a:	vmovq  xmm4,xmm4
     d7e:	vcvtdq2ps xmm4,xmm4
                        vp[k] += p.A*TL + p.B*TR + p.C*BL + p.D*BR;
     d82:	vaddps xmm6,xmm21,xmm6
     d88:	vfmadd132ps xmm7,xmm8,xmm10
                        float TL = p.SUB[ind_ltop + k];
     d8d:	vpsrlq xmm8,xmm9,0x20
                        vp[k] += p.A*TL + p.B*TR + p.C*BL + p.D*BR;
     d93:	vmovq  xmm9,QWORD PTR [rbx+0x18]
                        float TL = p.SUB[ind_ltop + k];
     d98:	vpmovzxwd xmm8,xmm8
     d9d:	vmovq  xmm8,xmm8
                        vp[k] += p.A*TL + p.B*TR + p.C*BL + p.D*BR;
     da2:	vmovlps QWORD PTR [rbx+0x8],xmm6
                        float TL = p.SUB[ind_ltop + k];
     da7:	vcvtdq2ps xmm8,xmm8
                        vp[k] += p.A*TL + p.B*TR + p.C*BL + p.D*BR;
     dac:	vfmadd132ps xmm8,xmm9,xmm11
     db1:	vaddps xmm6,xmm22,xmm7
     db7:	vfmadd132ps xmm4,xmm8,xmm10
     dbc:	vaddps xmm8,xmm19,xmm20
     dc2:	vmovlps QWORD PTR [rbx+0x10],xmm6
     dc7:	vmovlps QWORD PTR [rbx],xmm8
     dcb:	vaddps xmm4,xmm4,xmm14
     dd0:	vmovlps QWORD PTR [rbx+0x18],xmm4
                    for (int k = 0; k < remaining; ++k) {
     dd5:	je     10e8 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x10e8>
     ddb:	add    r8d,r9d
                        float TL = p.SUB[ind_ltop + k];
     dde:	movsxd r10,r8d
                        float TR = p.SUB[ind_rtop + k];
     de1:	mov    r9,QWORD PTR [rsp+0x110]
                    for (int k = 0; k < remaining; ++k) {
     de9:	mov    r14d,DWORD PTR [rsp+0x108]
                        float TL = p.SUB[ind_ltop + k];
     df1:	movzx  r12d,BYTE PTR [rsi+r10*1]
                        vp[k] += p.A*TL + p.B*TR + p.C*BL + p.D*BR;
     df6:	lea    rbx,[r10*4+0x0]
     dfe:	mov    QWORD PTR [rsp+0x100],rbx
                        float TL = p.SUB[ind_ltop + k];
     e06:	vcvtusi2ss xmm4,xmm5,r12d
                        float TR = p.SUB[ind_rtop + k];
     e0c:	lea    r12,[rdi+r10*1]
                        float BL = p.SUB[ind_lbot + k];
     e10:	movzx  r10d,BYTE PTR [rcx+r10*1]
                        float TR = p.SUB[ind_rtop + k];
     e15:	movzx  r13d,BYTE PTR [r12+r9*1]
                        float BL = p.SUB[ind_lbot + k];
     e1a:	vcvtusi2ss xmm6,xmm5,r10d
                        float BR = p.SUB[ind_rbot + k];
     e20:	movzx  r10d,BYTE PTR [r12+r15*1]
     e25:	vmovaps xmm7,xmm4
                        float TR = p.SUB[ind_rtop + k];
     e29:	vcvtusi2ss xmm4,xmm5,r13d
     e2f:	vfmadd213ss xmm7,xmm18,DWORD PTR [rax+rbx*1]
                        vp[k] += p.A*TL + p.B*TR + p.C*BL + p.D*BR;
     e36:	vmulss xmm6,xmm6,xmm16
     e3c:	vfmadd231ss xmm6,xmm17,xmm4
                        float BR = p.SUB[ind_rbot + k];
     e42:	vcvtusi2ss xmm4,xmm5,r10d
                    for (int k = 0; k < remaining; ++k) {
     e48:	lea    r10d,[r8+0x1]
                        vp[k] += p.A*TL + p.B*TR + p.C*BL + p.D*BR;
     e4c:	vfmadd132ss xmm4,xmm7,xmm15
     e51:	vaddss xmm4,xmm4,xmm6
     e55:	vmovss DWORD PTR [rax+rbx*1],xmm4
                    for (int k = 0; k < remaining; ++k) {
     e5a:	cmp    r10d,r14d
     e5d:	jge    10e8 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x10e8>
                        float TL = p.SUB[ind_ltop + k];
     e63:	movzx  r12d,BYTE PTR [rsi+r10*1]
     e68:	vcvtusi2ss xmm4,xmm5,r12d
                        float TR = p.SUB[ind_rtop + k];
     e6e:	lea    r12,[rdi+r10*1]
                        float BL = p.SUB[ind_lbot + k];
     e72:	movzx  r10d,BYTE PTR [rcx+r10*1]
                        float TR = p.SUB[ind_rtop + k];
     e77:	movzx  r13d,BYTE PTR [r12+r9*1]
                        float BL = p.SUB[ind_lbot + k];
     e7c:	vcvtusi2ss xmm6,xmm5,r10d
                        float BR = p.SUB[ind_rbot + k];
     e82:	movzx  r10d,BYTE PTR [r12+r15*1]
     e87:	vmovaps xmm7,xmm4
                        float TR = p.SUB[ind_rtop + k];
     e8b:	vcvtusi2ss xmm4,xmm5,r13d
     e91:	vfmadd213ss xmm7,xmm18,DWORD PTR [rax+rbx*1+0x4]
                        vp[k] += p.A*TL + p.B*TR + p.C*BL + p.D*BR;
     e99:	vmulss xmm6,xmm6,xmm16
     e9f:	vfmadd231ss xmm6,xmm17,xmm4
                        float BR = p.SUB[ind_rbot + k];
     ea5:	vcvtusi2ss xmm4,xmm5,r10d
                    for (int k = 0; k < remaining; ++k) {
     eab:	lea    r10d,[r8+0x2]
                        vp[k] += p.A*TL + p.B*TR + p.C*BL + p.D*BR;
     eaf:	vfmadd132ss xmm4,xmm7,xmm15
     eb4:	vaddss xmm4,xmm4,xmm6
     eb8:	vmovss DWORD PTR [rax+rbx*1+0x4],xmm4
                    for (int k = 0; k < remaining; ++k) {
     ebe:	cmp    r14d,r10d
     ec1:	jle    10e8 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x10e8>
                        vp[k] += p.A*TL + p.B*TR + p.C*BL + p.D*BR;
     ec7:	lea    r13,[rax+rbx*1+0x8]
                        float TL = p.SUB[ind_ltop + k];
     ecc:	movzx  ebx,BYTE PTR [rsi+r10*1]
                        float TR = p.SUB[ind_rtop + k];
     ed1:	lea    r12,[rdi+r9*1]
                        float TL = p.SUB[ind_ltop + k];
     ed5:	vcvtusi2ss xmm4,xmm5,ebx
                        float TR = p.SUB[ind_rtop + k];
     edb:	movzx  ebx,BYTE PTR [r12+r10*1]
     ee0:	vmovaps xmm7,xmm4
     ee4:	vcvtusi2ss xmm4,xmm5,ebx
                        float BL = p.SUB[ind_lbot + k];
     eea:	movzx  ebx,BYTE PTR [rcx+r10*1]
     eef:	vfmadd213ss xmm7,xmm18,DWORD PTR [r13+0x0]
     ef6:	vcvtusi2ss xmm6,xmm5,ebx
                        float BR = p.SUB[ind_rbot + k];
     efc:	lea    rbx,[rdi+r15*1]
     f00:	movzx  r10d,BYTE PTR [rbx+r10*1]
                        vp[k] += p.A*TL + p.B*TR + p.C*BL + p.D*BR;
     f05:	vmulss xmm6,xmm6,xmm16
     f0b:	vfmadd231ss xmm6,xmm17,xmm4
                        float BR = p.SUB[ind_rbot + k];
     f11:	vcvtusi2ss xmm4,xmm5,r10d
                    for (int k = 0; k < remaining; ++k) {
     f17:	lea    r10d,[r8+0x3]
                        vp[k] += p.A*TL + p.B*TR + p.C*BL + p.D*BR;
     f1b:	vfmadd132ss xmm4,xmm7,xmm15
     f20:	vaddss xmm4,xmm4,xmm6
     f24:	vmovss DWORD PTR [r13+0x0],xmm4
                    for (int k = 0; k < remaining; ++k) {
     f2a:	cmp    r14d,r10d
     f2d:	jle    10e8 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x10e8>
                        vp[k] += p.A*TL + p.B*TR + p.C*BL + p.D*BR;
     f33:	mov    r14,QWORD PTR [rsp+0x100]
     f3b:	lea    r13,[rax+r14*1+0xc]
                        float TL = p.SUB[ind_ltop + k];
     f40:	movzx  r14d,BYTE PTR [rsi+r10*1]
     f45:	vcvtusi2ss xmm4,xmm5,r14d
                        float TR = p.SUB[ind_rtop + k];
     f4b:	lea    r14,[rdi+r10*1]
                        float BL = p.SUB[ind_lbot + k];
     f4f:	movzx  r10d,BYTE PTR [rcx+r10*1]
                        float TR = p.SUB[ind_rtop + k];
     f54:	movzx  r9d,BYTE PTR [r14+r9*1]
                        float BL = p.SUB[ind_lbot + k];
     f59:	vcvtusi2ss xmm6,xmm5,r10d
                        float BR = p.SUB[ind_rbot + k];
     f5f:	movzx  r10d,BYTE PTR [r14+r15*1]
     f64:	vmovaps xmm7,xmm4
                        float TR = p.SUB[ind_rtop + k];
     f68:	vcvtusi2ss xmm4,xmm5,r9d
     f6e:	vfmadd213ss xmm7,xmm18,DWORD PTR [r13+0x0]
                        vp[k] += p.A*TL + p.B*TR + p.C*BL + p.D*BR;
     f75:	vmulss xmm6,xmm6,xmm16
     f7b:	vfmadd231ss xmm6,xmm17,xmm4
                        float BR = p.SUB[ind_rbot + k];
     f81:	vcvtusi2ss xmm4,xmm5,r10d
                    for (int k = 0; k < remaining; ++k) {
     f87:	lea    r10d,[r8+0x4]
                        vp[k] += p.A*TL + p.B*TR + p.C*BL + p.D*BR;
     f8b:	vfmadd132ss xmm4,xmm7,xmm15
     f90:	vaddss xmm4,xmm4,xmm6
     f94:	vmovss DWORD PTR [r13+0x0],xmm4
                    for (int k = 0; k < remaining; ++k) {
     f9a:	cmp    DWORD PTR [rsp+0x108],r10d
     fa2:	jle    10e8 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x10e8>
                        vp[k] += p.A*TL + p.B*TR + p.C*BL + p.D*BR;
     fa8:	mov    r14,QWORD PTR [rsp+0x100]
     fb0:	lea    r13,[rax+r14*1+0x10]
                        float TL = p.SUB[ind_ltop + k];
     fb5:	movzx  r14d,BYTE PTR [rsi+r10*1]
     fba:	vcvtusi2ss xmm4,xmm5,r14d
                        float TR = p.SUB[ind_rtop + k];
     fc0:	movzx  r14d,BYTE PTR [r12+r10*1]
     fc5:	vmovaps xmm7,xmm4
     fc9:	vcvtusi2ss xmm4,xmm5,r14d
                        float BL = p.SUB[ind_lbot + k];
     fcf:	movzx  r14d,BYTE PTR [rcx+r10*1]
                        float BR = p.SUB[ind_rbot + k];
     fd4:	movzx  r10d,BYTE PTR [rbx+r10*1]
     fd9:	vfmadd213ss xmm7,xmm18,DWORD PTR [r13+0x0]
                        float BL = p.SUB[ind_lbot + k];
     fe0:	vcvtusi2ss xmm6,xmm5,r14d
                    for (int k = 0; k < remaining; ++k) {
     fe6:	mov    r14d,DWORD PTR [rsp+0x108]
                        vp[k] += p.A*TL + p.B*TR + p.C*BL + p.D*BR;
     fee:	vmulss xmm6,xmm6,xmm16
     ff4:	vfmadd231ss xmm6,xmm17,xmm4
                        float BR = p.SUB[ind_rbot + k];
     ffa:	vcvtusi2ss xmm4,xmm5,r10d
                    for (int k = 0; k < remaining; ++k) {
    1000:	lea    r10d,[r8+0x5]
                        vp[k] += p.A*TL + p.B*TR + p.C*BL + p.D*BR;
    1004:	vfmadd132ss xmm4,xmm7,xmm15
    1009:	vaddss xmm4,xmm4,xmm6
    100d:	vmovss DWORD PTR [r13+0x0],xmm4
                    for (int k = 0; k < remaining; ++k) {
    1013:	cmp    r14d,r10d
    1016:	jle    10e8 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x10e8>
                        float BL = p.SUB[ind_lbot + k];
    101c:	movzx  ecx,BYTE PTR [rcx+r10*1]
                        float TL = p.SUB[ind_ltop + k];
    1021:	movzx  esi,BYTE PTR [rsi+r10*1]
                    for (int k = 0; k < remaining; ++k) {
    1026:	add    r8d,0x6
                        vp[k] += p.A*TL + p.B*TR + p.C*BL + p.D*BR;
    102a:	mov    r9,QWORD PTR [rsp+0x100]
                        float BL = p.SUB[ind_lbot + k];
    1032:	vcvtusi2ss xmm6,xmm5,ecx
                        float BR = p.SUB[ind_rbot + k];
    1038:	movzx  ecx,BYTE PTR [rbx+r10*1]
                        float TL = p.SUB[ind_ltop + k];
    103d:	vcvtusi2ss xmm4,xmm5,esi
                        float TR = p.SUB[ind_rtop + k];
    1043:	movzx  esi,BYTE PTR [r12+r10*1]
                        vp[k] += p.A*TL + p.B*TR + p.C*BL + p.D*BR;
    1048:	vmulss xmm6,xmm6,xmm16
    104e:	vmovaps xmm7,xmm4
                        float TR = p.SUB[ind_rtop + k];
    1052:	vcvtusi2ss xmm4,xmm5,esi
    1058:	vfmadd213ss xmm7,xmm18,DWORD PTR [rax+r9*1+0x14]
    1060:	vfmadd231ss xmm6,xmm17,xmm4
                        float BR = p.SUB[ind_rbot + k];
    1066:	vcvtusi2ss xmm4,xmm5,ecx
                        vp[k] += p.A*TL + p.B*TR + p.C*BL + p.D*BR;
    106c:	vfmadd132ss xmm4,xmm7,xmm15
    1071:	vaddss xmm4,xmm4,xmm6
    1075:	vmovss DWORD PTR [rax+r9*1+0x14],xmm4
                    for (int k = 0; k < remaining; ++k) {
    107c:	cmp    r14d,r8d
    107f:	jle    10e8 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x10e8>
                        float TL = p.SUB[ind_ltop + k];
    1081:	add    r8,rdi
                        vp[k] += p.A*TL + p.B*TR + p.C*BL + p.D*BR;
    1084:	lea    rax,[rax+r9*1+0x18]
                        float TR = p.SUB[ind_rtop + k];
    1089:	mov    r9,QWORD PTR [rsp+0x110]
                        float TL = p.SUB[ind_ltop + k];
    1091:	movzx  edx,BYTE PTR [r8+rdx*1]
    1096:	vcvtusi2ss xmm4,xmm5,edx
                        float TR = p.SUB[ind_rtop + k];
    109c:	movzx  edx,BYTE PTR [r8+r9*1]
    10a1:	vmovaps xmm7,xmm4
    10a5:	vcvtusi2ss xmm4,xmm5,edx
                        float BL = p.SUB[ind_lbot + k];
    10ab:	mov    rdx,QWORD PTR [rsp+0xe8]
    10b3:	vfmadd213ss xmm7,xmm18,DWORD PTR [rax]
    10b9:	movzx  edx,BYTE PTR [r8+rdx*1]
    10be:	vcvtusi2ss xmm6,xmm5,edx
                        float BR = p.SUB[ind_rbot + k];
    10c4:	movzx  edx,BYTE PTR [r8+r15*1]
                        vp[k] += p.A*TL + p.B*TR + p.C*BL + p.D*BR;
    10c9:	vmulss xmm6,xmm6,xmm16
    10cf:	vfmadd231ss xmm6,xmm17,xmm4
                        float BR = p.SUB[ind_rbot + k];
    10d5:	vcvtusi2ss xmm4,xmm5,edx
                        vp[k] += p.A*TL + p.B*TR + p.C*BL + p.D*BR;
    10db:	vfmadd132ss xmm4,xmm7,xmm15
    10e0:	vaddss xmm4,xmm4,xmm6
    10e4:	vmovss DWORD PTR [rax],xmm4
                for (int y = y_begin; y < y_end; ++y) {
    10e8:	inc    DWORD PTR [rsp+0xf8]
    10ef:	mov    rdi,QWORD PTR [rsp+0xc8]
    10f7:	add    QWORD PTR [rsp+0xe0],rdi
    10ff:	mov    eax,DWORD PTR [rsp+0xf8]
    1106:	cmp    eax,DWORD PTR [rsp+0xd8]
    110d:	jl     650 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x650>
    1113:	mov    r12d,DWORD PTR [rsp+0x7c]
    1118:	mov    r8d,DWORD PTR [rsp+0x78]
    111d:	mov    ebx,DWORD PTR [rsp+0x74]
    1121:	mov    r15d,DWORD PTR [rsp+0x70]
            for (const SubParams& p : params) {
    1126:	add    QWORD PTR [rsp+0xf0],0x30
    112f:	mov    rax,QWORD PTR [rsp+0xf0]
    1137:	cmp    QWORD PTR [rsp+0x90],rax
    113f:	jne    500 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x500>
    1145:	mov    r13d,DWORD PTR [rsp+0x6c]
    114a:	mov    r8,QWORD PTR [rsp+0x60]
            for (int y = ty; y < tile_y_end; ++y) {
    114f:	cmp    DWORD PTR [rsp+0x8c],r15d
    1157:	jle    126f <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x126f>
    115d:	test   r13d,r13d
    1160:	jle    126f <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x126f>
    1166:	lea    r12d,[r13+r13*2+0x0]
    116b:	mov    rax,QWORD PTR [rsp+0x50]
    1170:	mov    rdx,QWORD PTR [rsp+0x98]
    1178:	lea    r9,[r13+r13*2+0x0]
    117d:	movsxd r12,r12d
    1180:	mov    r11,QWORD PTR [rsp+0x38]
    1185:	lea    r14,[r9*4+0x0]
    118d:	mov    r10,r8
    1190:	mov    QWORD PTR [rsp+0x110],r12
    1198:	lea    r13,[rax+rdx*4]
    119c:	mov    ebx,r15d
    119f:	xor    edi,edi
    11a1:	nop    DWORD PTR [rax+0x0]
                unsigned char* outp = output.data.data() + (y * width + tx) * 3;
    11a8:	mov    rax,QWORD PTR [rsp+0x98]
    11b0:	lea    rdx,[r13+r11*4+0x0]
    11b5:	add    rax,r11
    11b8:	lea    rcx,[rax+rax*2]
    11bc:	mov    rax,QWORD PTR [rsp+0x80]
    11c4:	add    rcx,QWORD PTR [rax+0x10]
    11c8:	xor    eax,eax
    11ca:	jmp    11f8 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x11f8>
    11cc:	data16 cs nop WORD PTR [rax+rax*1+0x0]
    11d7:	nop    WORD PTR [rax+rax*1+0x0]
                        outp[x*3] = outp[x*3+1] = outp[x*3+2] = 0;
    11e0:	xor    esi,esi
    11e2:	mov    BYTE PTR [rcx+rax*1+0x2],0x0
                for (int x = 0; x < tile_w_actual; ++x) {
    11e7:	add    rdx,0x4
                        outp[x*3] = outp[x*3+1] = outp[x*3+2] = 0;
    11eb:	mov    WORD PTR [rcx+rax*1],si
                for (int x = 0; x < tile_w_actual; ++x) {
    11ef:	add    rax,0x3
    11f3:	cmp    r9,rax
    11f6:	je     124d <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x124d>
                    int c = counts[y * width + (tx + x)];
    11f8:	mov    esi,DWORD PTR [rdx]
                    if (c == 0) {
    11fa:	test   esi,esi
    11fc:	je     11e0 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x11e0>
                    float inv_c = 1.0f / static_cast<float>(c);
    11fe:	vcvtsi2ss xmm0,xmm5,esi
                for (int x = 0; x < tile_w_actual; ++x) {
    1202:	add    rdx,0x4
                    float inv_c = 1.0f / static_cast<float>(c);
    1206:	vdivss xmm0,xmm23,xmm0
                    for (int ch = 0; ch < 3; ++ch) {
                        float v = vp[x*3 + ch] * inv_c;
    120c:	vmulss xmm1,xmm0,DWORD PTR [r10+rax*4]
                        outp[x*3 + ch] = static_cast<unsigned char>(v);
    1212:	vcvttss2si esi,xmm1
    1216:	mov    BYTE PTR [rcx+rax*1],sil
                        float v = vp[x*3 + ch] * inv_c;
    121a:	lea    esi,[rax+0x1]
    121d:	lea    r12,[rdi+rsi*1]
    1221:	vmulss xmm1,xmm0,DWORD PTR [r8+r12*4]
                        outp[x*3 + ch] = static_cast<unsigned char>(v);
    1227:	vcvttss2si r12d,xmm1
    122b:	mov    BYTE PTR [rcx+rsi*1],r12b
                        float v = vp[x*3 + ch] * inv_c;
    122f:	lea    esi,[rax+0x2]
                for (int x = 0; x < tile_w_actual; ++x) {
    1232:	add    rax,0x3
                        float v = vp[x*3 + ch] * inv_c;
    1236:	lea    r12,[rdi+rsi*1]
    123a:	vmulss xmm0,xmm0,DWORD PTR [r8+r12*4]
                        outp[x*3 + ch] = static_cast<unsigned char>(v);
    1240:	vcvttss2si r12d,xmm0
    1244:	mov    BYTE PTR [rcx+rsi*1],r12b
                for (int x = 0; x < tile_w_actual; ++x) {
    1248:	cmp    r9,rax
    124b:	jne    11f8 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x11f8>
            for (int y = ty; y < tile_y_end; ++y) {
    124d:	inc    ebx
    124f:	add    rdi,QWORD PTR [rsp+0x110]
    1257:	add    r10,r14
    125a:	add    r11,QWORD PTR [rsp+0xa0]
    1262:	cmp    DWORD PTR [rsp+0x8c],ebx
    1269:	jne    11a8 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x11a8>
        for (int tx = 0; tx < w; tx += TILE_W) {
    126f:	add    QWORD PTR [rsp+0x98],0x7f0
    127b:	mov    rax,QWORD PTR [rsp+0x98]
    1283:	cmp    DWORD PTR [rsp+0x68],eax
    1287:	jg     44f <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x44f>
    for (int ty = 0; ty < h; ty += TILE_H) {
    128d:	mov    r12,QWORD PTR [rsp+0x8]
    1292:	mov    rdx,QWORD PTR [rsp+0x38]
    1297:	mov    r14d,DWORD PTR [rsp+0x30]
    129c:	mov    ebx,DWORD PTR [rsp+0x14]
    12a0:	add    rdx,r12
    12a3:	cmp    ebx,r14d
    12a6:	jl     413 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x413>
    12ac:	mov    r15,QWORD PTR [rsp+0x20]
    12b1:	mov    rbx,QWORD PTR [rsp+0x18]
    12b6:	vzeroupper
	_GLIBCXX_OPERATOR_DELETE(_GLIBCXX_SIZED_DEALLOC(__p, __n));
    12b9:	mov    rdi,QWORD PTR [rsp+0x28]
    12be:	mov    esi,0x2fa00
    12c3:	call   12c8 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x12c8>
	if (__p)
    12c8:	test   rbx,rbx
    12cb:	je     12d8 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x12d8>
    12cd:	mov    rsi,r15
    12d0:	mov    rdi,rbx
    12d3:	call   12d8 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x12d8>
    12d8:	mov    rax,QWORD PTR [rsp+0x50]
    12dd:	test   rax,rax
    12e0:	je     12ef <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x12ef>
    12e2:	mov    rsi,QWORD PTR [rsp+0x48]
    12e7:	mov    rdi,rax
    12ea:	call   12ef <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x12ef>
    12ef:	mov    rax,QWORD PTR [rsp+0x58]
    12f4:	test   rax,rax
    12f7:	je     1306 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x1306>
    12f9:	mov    rsi,QWORD PTR [rsp+0x40]
    12fe:	mov    rdi,rax
    1301:	call   1306 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x1306>
            }
        }
    }

    return output;
}
    1306:	mov    rax,QWORD PTR [rsp+0x80]
    130e:	lea    rsp,[rbp-0x28]
    1312:	pop    rbx
    1313:	pop    r12
    1315:	pop    r13
    1317:	pop    r14
    1319:	pop    r15
    131b:	pop    rbp
    131c:	ret
    output.data.assign(width * height * 3, 0);
    131d:	lea    r14,[rdx+rdx*2]
	if (__n > _S_max_size(_Tp_alloc_type(__a)))
    1321:	test   r14,r14
    1324:	js     132a <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x132a>
	  return static_cast<_Tp*>(_GLIBCXX_OPERATOR_NEW(__n * sizeof(_Tp)));
    132a:	mov    rdi,r14
    132d:	call   1332 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x1332>
		      __builtin_memset(__dest, (unsigned char)__x, __n);
    1332:	xor    esi,esi
    1334:	mov    rdx,r14
	this->_M_impl._M_end_of_storage = this->_M_impl._M_start + __n;
    1337:	lea    r15,[rax+r14*1]
    133b:	mov    rdi,rax
    133e:	call   1343 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x1343>
    1343:	mov    rcx,rax
	  _M_start = __x._M_start;
    1346:	mov    rax,QWORD PTR [rsp+0x80]
    134e:	mov    QWORD PTR [rax+0x10],rcx
	  _M_finish = __x._M_finish;
    1352:	mov    QWORD PTR [rax+0x18],r15
	  _M_end_of_storage = __x._M_end_of_storage;
    1356:	mov    QWORD PTR [rax+0x20],r15
	ptrdiff_t __dif = this->_M_impl._M_finish - this->_M_impl._M_start;
    135a:	mov    rax,QWORD PTR [r13+0x8]
    135e:	mov    QWORD PTR [rsp+0x110],rax
      if (this->capacity() < __n)
    1366:	sub    rax,rbx
    1369:	mov    QWORD PTR [rsp+0x40],rax
    136e:	jne    96 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x96>
	: _M_start(), _M_finish(), _M_end_of_storage()
    1374:	mov    QWORD PTR [rsp+0x58],0x0
    137d:	xor    r13d,r13d
    1380:	jmp    ac <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0xac>
    1385:	nop    DWORD PTR [rax]
                    size_t ind_lbot = ind_ltop + width * 3;
    1388:	mov    QWORD PTR [rsp+0xe8],r11
                    int x = (x_begin - tx) * 3;
    1390:	mov    ecx,DWORD PTR [rsp+0x88]
    1397:	jmp    72f <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x72f>
    139c:	mov    rbx,QWORD PTR [rsp+0xe8]
                        float TL = p.SUB[ind_ltop + k];
    13a4:	xor    r10d,r10d
                    for (int k = 0; k < remaining; ++k) {
    13a7:	xor    r8d,r8d
    13aa:	lea    rsi,[rdi+rdx*1]
    13ae:	lea    rcx,[rdi+rbx*1]
    13b2:	jmp    986 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x986>
    13b7:	xor    r9d,r9d
    13ba:	jmp    b8c <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0xb8c>
    13bf:	mov    QWORD PTR [rsp+0x58],0x0
    const int h = static_cast<int>(height);
    13c8:	mov    r14d,ecx
    13cb:	xor    r13d,r13d
    const int w = static_cast<int>(width);
    13ce:	vmovd  DWORD PTR [rsp+0x68],xmm0
    for (auto& sub : subapertures) {
    13d4:	cmp    rdx,rbx
    13d7:	jne    cd <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0xcd>
    13dd:	mov    QWORD PTR [rsp+0x90],0x0
	return __n != 0 ? _Tr::allocate(_M_impl, __n) : pointer();
    13e9:	mov    QWORD PTR [rsp+0x50],0x0
    13f2:	jmp    226 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x226>
    13f7:	xor    ebx,ebx
    13f9:	jmp    283 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x283>
	ptrdiff_t __dif = this->_M_impl._M_finish - this->_M_impl._M_start;
    13fe:	mov    rax,r13
    1401:	sub    rax,r15
    1404:	mov    QWORD PTR [rsp+0x108],rax
    140c:	sar    rax,0x4
    1410:	mov    rdx,rax
    1413:	movabs rax,0xaaaaaaaaaaaaaaab
    141d:	imul   rdx,rax
	if (max_size() - size() < __n)
    1421:	movabs rax,0x2aaaaaaaaaaaaaa
    142b:	cmp    rdx,rax
    142e:	je     1434 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x1434>
      if (__a < __b)
    1434:	test   rdx,rdx
    1437:	mov    eax,0x1
    143c:	mov    DWORD PTR [rsp+0xa8],r11d
    1444:	cmovne rax,rdx
    1448:	mov    DWORD PTR [rsp+0xb0],ecx
    144f:	mov    DWORD PTR [rsp+0xd0],r9d
	const size_type __len = size() + (std::max)(size(), __n);
    1457:	add    rax,rdx
	return (__len < size() || __len > max_size()) ? max_size() : __len;
    145a:	movabs rdx,0x2aaaaaaaaaaaaaa
    1464:	mov    DWORD PTR [rsp+0xb8],r8d
    146c:	cmp    rax,rdx
    146f:	mov    DWORD PTR [rsp+0xdc],esi
    1476:	cmova  rax,rdx
    147a:	mov    DWORD PTR [rsp+0xe0],r10d
      allocate(size_type __n, const void* = static_cast<const void*>(0))
    1482:	vmovss DWORD PTR [rsp+0xc0],xmm3
	  return static_cast<_Tp*>(_GLIBCXX_OPERATOR_NEW(__n * sizeof(_Tp)));
    148b:	lea    rax,[rax+rax*2]
    148f:	vmovss DWORD PTR [rsp+0xc8],xmm0
    1498:	shl    rax,0x4
    149c:	vmovss DWORD PTR [rsp+0xd4],xmm1
    14a5:	mov    rdi,rax
    14a8:	mov    QWORD PTR [rsp+0xf0],rax
    14b0:	vmovss DWORD PTR [rsp+0xd8],xmm2
    14b9:	call   14be <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x14be>
	{ ::new((void *)__p) _Up(std::forward<_Args>(__args)...); }
    14be:	vmovss xmm0,DWORD PTR [rsp+0xc8]
    14c7:	vmovss xmm2,DWORD PTR [rsp+0xd8]
	  return static_cast<_Tp*>(_GLIBCXX_OPERATOR_NEW(__n * sizeof(_Tp)));
    14d0:	mov    QWORD PTR [rsp+0xf8],rax
    14d8:	mov    rdi,rax
	// taking the element by lvalue ref (see last bullet of C++11
	// [res.on.arguments]).

	// If this throws, the existing elements are unchanged.
#if __cplusplus >= 201103L
	_Alloc_traits::construct(this->_M_impl,
    14db:	mov    rdx,QWORD PTR [rsp+0x108]
	{ ::new((void *)__p) _Up(std::forward<_Args>(__args)...); }
    14e3:	mov    r10d,DWORD PTR [rsp+0xe0]
    14eb:	mov    esi,DWORD PTR [rsp+0xdc]
    14f2:	vinsertps xmm0,xmm0,DWORD PTR [rsp+0xc0],0x10
    14fd:	vinsertps xmm2,xmm2,DWORD PTR [rsp+0xd4],0x10
    1508:	mov    r8d,DWORD PTR [rsp+0xb8]
    1510:	mov    DWORD PTR [rax+rdx*1],r10d
    1514:	mov    ecx,DWORD PTR [rsp+0xb0]
    151b:	mov    r9d,DWORD PTR [rsp+0xd0]
    1523:	mov    DWORD PTR [rax+rdx*1+0x4],esi
    1527:	mov    r11d,DWORD PTR [rsp+0xa8]
    152f:	vmovlhps xmm2,xmm2,xmm0
    1533:	mov    DWORD PTR [rax+rdx*1+0x18],r8d
    1538:	mov    DWORD PTR [rax+rdx*1+0x1c],ecx
    153c:	mov    DWORD PTR [rax+rdx*1+0x20],r9d
    1541:	mov    DWORD PTR [rax+rdx*1+0x24],r11d
    1546:	mov    QWORD PTR [rax+rdx*1+0x28],r12
    154b:	vmovups XMMWORD PTR [rax+rdx*1+0x8],xmm2
    __relocate_a_1(_Tp* __first, _Tp* __last,
		   _Tp* __result,
		   [[__maybe_unused__]] allocator<_Up>& __alloc) noexcept
    {
      ptrdiff_t __count = __last - __first;
      if (__count > 0)
    1551:	test   rdx,rdx
    1554:	je     155e <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x155e>
	      __gnu_cxx::__normal_iterator<_Tp*, void> __out(__result);
	      __out = std::__relocate_a_1(__first, __last, __out, __alloc);
	      return __out.base();
	    }
#endif
	  __builtin_memcpy(__result, __first, __count * sizeof(_Tp));
    1556:	mov    rsi,r15
    1559:	call   155e <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x155e>
	  {
	    // Relocation cannot throw.
	    __new_finish = std::__relocate_a(__old_start, __old_finish,
					     __new_start,
					     _M_get_Tp_allocator());
	    ++__new_finish;
    155e:	mov    rax,QWORD PTR [rsp+0xf8]
    1566:	mov    rdx,QWORD PTR [rsp+0x108]
    156e:	lea    rax,[rax+rdx*1+0x30]
    1573:	mov    QWORD PTR [rsp+0x58],rax
	  if (_M_storage)
    1578:	test   r15,r15
    157b:	je     158b <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x158b>
	    // New storage has been fully initialized, destroy the old elements.
	    __guard_elts._M_first = __old_start;
	    __guard_elts._M_last = __old_finish;
	  }
	__guard._M_storage = __old_start;
	__guard._M_len = this->_M_impl._M_end_of_storage - __old_start;
    157d:	mov    rsi,r13
	_GLIBCXX_OPERATOR_DELETE(_GLIBCXX_SIZED_DEALLOC(__p, __n));
    1580:	mov    rdi,r15
    1583:	sub    rsi,r15
    1586:	call   158b <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x158b>
      // deallocate should be called before assignments to _M_impl,
      // to avoid call-clobbering

      this->_M_impl._M_start = __new_start;
      this->_M_impl._M_finish = __new_finish;
      this->_M_impl._M_end_of_storage = __new_start + __len;
    158b:	mov    r13,QWORD PTR [rsp+0xf0]
    1593:	mov    r15,QWORD PTR [rsp+0xf8]
    159b:	add    r13,r15
    159e:	jmp    1b7 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x1b7>
    15a3:	mov    rax,QWORD PTR [rsp+0x58]
    15a8:	mov    QWORD PTR [rsp+0x90],rax
    15b0:	jmp    1e6 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x1e6>
	if (__p)
    15b5:	mov    r14,rax
    15b8:	jmp    15bd <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x15bd>
    15bd:	jmp    15c2 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x15c2>
    15c2:	mov    rbx,rax
    15c5:	vzeroupper
    15c8:	jmp    15cd <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x15cd>
    15cd:	jmp    15d2 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x15d2>
    15d2:	jmp    15d7 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x15d7>

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
  30:	test   rbx,rbx
  33:	jne    9f <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float) [clone .cold]+0x9f>
  35:	vzeroupper
      ~__new_allocator() _GLIBCXX_USE_NOEXCEPT { }
  38:	mov    rbx,r14
  3b:	jmp    43 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float) [clone .cold]+0x43>
  3d:	mov    rbx,rax
  40:	vzeroupper
  43:	cmp    QWORD PTR [rsp+0x50],0x0
  49:	je     5a <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float) [clone .cold]+0x5a>
	_GLIBCXX_OPERATOR_DELETE(_GLIBCXX_SIZED_DEALLOC(__p, __n));
  4b:	mov    rsi,QWORD PTR [rsp+0x48]
  50:	mov    rdi,QWORD PTR [rsp+0x50]
  55:	call   5a <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float) [clone .cold]+0x5a>
  5a:	cmp    QWORD PTR [rsp+0x58],0x0
  60:	je     7a <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float) [clone .cold]+0x7a>
	ptrdiff_t __n = _M_impl._M_end_of_storage - _M_impl._M_start;
  62:	mov    rdi,QWORD PTR [rsp+0x58]
  67:	mov    rsi,r13
  6a:	sub    rsi,rdi
  6d:	call   72 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float) [clone .cold]+0x72>
      ~__new_allocator() _GLIBCXX_USE_NOEXCEPT { }
  72:	jmp    7a <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float) [clone .cold]+0x7a>
  74:	mov    rbx,rax
  77:	vzeroupper
  7a:	mov    rax,QWORD PTR [rsp+0x80]
  82:	mov    rdi,QWORD PTR [rax+0x10]
	if (__p)
  86:	test   rdi,rdi
  89:	je     97 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float) [clone .cold]+0x97>
	ptrdiff_t __n = _M_impl._M_end_of_storage - _M_impl._M_start;
  8b:	mov    rsi,QWORD PTR [rax+0x20]
  8f:	sub    rsi,rdi
	_GLIBCXX_OPERATOR_DELETE(_GLIBCXX_SIZED_DEALLOC(__p, __n));
  92:	call   97 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float) [clone .cold]+0x97>
      ~__new_allocator() _GLIBCXX_USE_NOEXCEPT { }
  97:	mov    rdi,rbx
  9a:	call   9f <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float) [clone .cold]+0x9f>
	_GLIBCXX_OPERATOR_DELETE(_GLIBCXX_SIZED_DEALLOC(__p, __n));
  9f:	mov    rsi,r15
  a2:	mov    rdi,rbx
  a5:	vzeroupper
  a8:	call   ad <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float) [clone .cold]+0xad>
  ad:	jmp    38 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float) [clone .cold]+0x38>
                unsigned char* outp = output.data.data() + (y * width + tx) * 3;
  af:	mov    QWORD PTR [rsp+0x58],r15
  b4:	mov    rbx,rax
  b7:	vzeroupper
  ba:	jmp    5a <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float) [clone .cold]+0x5a>
	if (__p)
  bc:	mov    rbx,rax
  bf:	vzeroupper
  c2:	jmp    5a <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float) [clone .cold]+0x5a>
