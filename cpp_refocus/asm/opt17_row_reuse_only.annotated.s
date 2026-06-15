
asm/opt17_row_reuse_only.o:     file format elf64-x86-64


Disassembly of section .text:

0000000000000000 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)>:
static inline __m256 load_cvt8(const unsigned char* ptr) {
    return _mm256_cvtepi32_ps(_mm256_cvtepu8_epi32(
        _mm_loadl_epi64(reinterpret_cast<const __m128i*>(ptr))));
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
       a:	mov    r15,rdi
       d:	push   r14
       f:	push   r13
      11:	push   r12
      13:	mov    r12,rsi
      16:	push   rbx
      17:	and    rsp,0xffffffffffffffe0
      1b:	sub    rsp,0x1e0
      : _M_current() { }

      __attribute__((__always_inline__))
      explicit _GLIBCXX_CONSTEXPR
      __normal_iterator(const _Iterator& __i) _GLIBCXX_NOEXCEPT
      : _M_current(__i) { }
      22:	mov    rbx,QWORD PTR [rsi]
      25:	vmovss DWORD PTR [rsp+0x1a4],xmm0
    const size_t width  = subapertures.front().data.width;
      2e:	vmovdqu xmm0,XMMWORD PTR [rbx]
      32:	mov    QWORD PTR [rdi+0x20],0x0
      3a:	vmovdqu XMMWORD PTR [rdi+0x10],xmm1
      3f:	vpextrq rax,xmm0,0x1
      45:	vmovq  r13,xmm0
      4a:	vmovq  QWORD PTR [rsp+0xc8],xmm0
    const int h = static_cast<int>(height);

    ImageData output;
    output.width = width;
    output.height = height;
    output.data.assign(width * height * 3, 0);
      53:	imul   r13,rax
      57:	mov    QWORD PTR [rsp+0x1c8],rax
    output.width = width;
      5f:	vmovdqu XMMWORD PTR [rdi],xmm0
    void
    vector<_Tp, _Alloc>::
    _M_fill_assign(size_t __n, const value_type& __val)
    {
      const size_type __sz = size();
      if (__n > capacity())
      63:	test   r13,r13
      66:	jne    3574 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x3574>
      /**  Returns the number of elements in the %vector.  */
      _GLIBCXX_NODISCARD _GLIBCXX20_CONSTEXPR
      size_type
      size() const _GLIBCXX_NOEXCEPT
      {
	ptrdiff_t __dif = this->_M_impl._M_finish - this->_M_impl._M_start;
      6c:	mov    rax,QWORD PTR [rsi+0x8]
      70:	mov    QWORD PTR [rsp+0x1d0],rax
      if (this->capacity() < __n)
      78:	sub    rax,rbx
      7b:	mov    r12,rax
      7e:	je     3360 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x3360>
	    return static_cast<_Tp*>(_GLIBCXX_OPERATOR_NEW(__n * sizeof(_Tp),
							   __al));
	  }
#endif
	else
	  return static_cast<_Tp*>(_GLIBCXX_OPERATOR_NEW(__n * sizeof(_Tp)));
      84:	mov    rdi,r12
      87:	call   8c <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x8c>
      8c:	mov    QWORD PTR [rsp+0x80],rax
	  this->_M_impl._M_end_of_storage = this->_M_impl._M_start + __n;
      94:	lea    r14,[rax+r12*1]
    const int w = static_cast<int>(width);
      98:	mov    eax,DWORD PTR [rsp+0xc8]
    const int h = static_cast<int>(height);
      9f:	mov    r12d,DWORD PTR [rsp+0x1c8]
    const int w = static_cast<int>(width);
      a7:	mov    DWORD PTR [rsp+0x98],eax

    std::vector<SubParams> params;
    params.reserve(subapertures.size());
    for (auto& sub : subapertures) {
      ae:	cmp    rbx,QWORD PTR [rsp+0x1d0]
      b6:	je     3601 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x3601>
	: _M_start(), _M_finish(), _M_end_of_storage()
      bc:	mov    rax,QWORD PTR [rsp+0x80]
      c4:	mov    QWORD PTR [rsp+0xd8],rax
        SubParams p;
        float shift_x = focus * sub.u;
      cc:	vmovss xmm7,DWORD PTR [rsp+0x1a4]
        p.A = (1.0f - dx) * (1.0f - dy);
        p.B = dx           * (1.0f - dy);
        p.C = (1.0f - dx) * dy;
        p.D = dx           * dy;
        p.x_begin = std::max(0, -p.sx);
        p.x_end   = std::min(w, w - p.sx - 1);
      d5:	mov    edi,DWORD PTR [rsp+0x98]
        p.x_begin = std::max(0, -p.sx);
      dc:	xor    ecx,ecx
        float shift_x = focus * sub.u;
      de:	vmulss xmm4,xmm7,DWORD PTR [rbx+0x28]
        float shift_y = focus * sub.v;
      e3:	vmulss xmm2,xmm7,DWORD PTR [rbx+0x2c]
  using ::floor;

#ifndef __CORRECT_ISO_CPP_MATH_H_PROTO
  inline _GLIBCXX_CONSTEXPR float
  floor(float __x)
  { return __builtin_floorf(__x); }
      e8:	vrndscaless xmm0,xmm4,xmm4,0x9
        p.sx = static_cast<int>(std::floor(shift_x));
      ef:	vcvttss2si r9d,xmm0
      f3:	vrndscaless xmm1,xmm2,xmm2,0x9
        p.sy = static_cast<int>(std::floor(shift_y));
      fa:	vcvttss2si esi,xmm1
        p.x_begin = std::max(0, -p.sx);
      fe:	mov    eax,r9d
     101:	neg    eax
     103:	test   r9d,r9d
     106:	cmovs  ecx,eax
        p.x_end   = std::min(w, w - p.sx - 1);
     109:	mov    eax,edi
     10b:	sub    eax,r9d
     10e:	dec    eax
    min(const _Tp& __a, const _Tp& __b)
    {
      // concept requirements
      __glibcxx_function_requires(_LessThanComparableConcept<_Tp>)
      //return __b < __a ? __b : __a;
      if (__b < __a)
     110:	cmp    eax,edi
     112:	cmovg  eax,edi
        p.y_begin = std::max(0, -p.sy);
     115:	xor    r8d,r8d
     118:	mov    r10d,eax
     11b:	mov    eax,esi
     11d:	neg    eax
     11f:	test   esi,esi
     121:	cmovs  r8d,eax
        p.y_end   = std::min(h, h - p.sy - 1);
     125:	mov    eax,r12d
     128:	sub    eax,esi
     12a:	dec    eax
     12c:	cmp    eax,r12d
     12f:	cmovg  eax,r12d
     133:	mov    r11d,eax
        p.SUB = sub.data.data.data();
        if (p.x_begin >= p.x_end || p.y_begin >= p.y_end) continue;
     136:	cmp    ecx,r10d
     139:	jge    1cb <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x1cb>
     13f:	cmp    r8d,eax
     142:	jge    1cb <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x1cb>
        float dy = shift_y - p.sy;
     148:	vsubss xmm5,xmm2,xmm1
        float dx = shift_x - p.sx;
     14c:	vsubss xmm3,xmm4,xmm0
       *   range.  For a non-empty %vector, data() == &front().
       */
      _GLIBCXX_NODISCARD _GLIBCXX20_CONSTEXPR
      _Tp*
      data() _GLIBCXX_NOEXCEPT
      { return _M_data_ptr(this->_M_impl._M_start); }
     150:	mov    rdi,QWORD PTR [rbx+0x10]
       */
      _GLIBCXX20_CONSTEXPR
      void
      push_back(const value_type& __x)
      {
	if (this->_M_impl._M_finish != this->_M_impl._M_end_of_storage)
     154:	mov    rax,QWORD PTR [rsp+0xd8]
        p.A = (1.0f - dx) * (1.0f - dy);
     15c:	vaddss xmm0,xmm0,DWORD PTR [rip+0x0]        # 164 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x164>
     164:	vaddss xmm1,xmm1,DWORD PTR [rip+0x0]        # 16c <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x16c>
      { return _M_data_ptr(this->_M_impl._M_start); }
     16c:	mov    QWORD PTR [rsp+0x1b0],rdi
     174:	vsubss xmm0,xmm0,xmm4
     178:	vsubss xmm1,xmm1,xmm2
     17c:	vmulss xmm2,xmm0,xmm1
        p.B = dx           * (1.0f - dy);
     180:	vmulss xmm1,xmm1,xmm3
        p.C = (1.0f - dx) * dy;
     184:	vmulss xmm0,xmm0,xmm5
        p.D = dx           * dy;
     188:	vmulss xmm3,xmm3,xmm5
	if (this->_M_impl._M_finish != this->_M_impl._M_end_of_storage)
     18c:	cmp    r14,rax
     18f:	je     33ad <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x33ad>
      template<typename _Up, typename... _Args>
	__attribute__((__always_inline__))
	void
	construct(_Up* __p, _Args&&... __args)
	noexcept(__is_nothrow_new_constructible<_Up, _Args...>)
	{ ::new((void *)__p) _Up(std::forward<_Args>(__args)...); }
     195:	vunpcklps xmm0,xmm0,xmm3
     199:	vunpcklps xmm2,xmm2,xmm1
     19d:	mov    DWORD PTR [rax],r9d
	  {
	    _GLIBCXX_ASAN_ANNOTATE_GROW(1);
	    _Alloc_traits::construct(this->_M_impl, this->_M_impl._M_finish,
				     __x);
	    ++this->_M_impl._M_finish;
     1a0:	add    rax,0x30
     1a4:	vmovlhps xmm2,xmm2,xmm0
     1a8:	mov    DWORD PTR [rax-0x2c],esi
     1ab:	vmovups XMMWORD PTR [rax-0x28],xmm2
     1b0:	mov    DWORD PTR [rax-0x18],ecx
     1b3:	mov    DWORD PTR [rax-0x14],r10d
     1b7:	mov    DWORD PTR [rax-0x10],r8d
     1bb:	mov    DWORD PTR [rax-0xc],r11d
     1bf:	mov    QWORD PTR [rax-0x8],rdi
     1c3:	mov    QWORD PTR [rsp+0xd8],rax
      __attribute__((__always_inline__))
      _GLIBCXX14_CONSTEXPR
      __normal_iterator&
      operator++() _GLIBCXX_NOEXCEPT
      {
	++_M_current;
     1cb:	add    rbx,0x30
    for (auto& sub : subapertures) {
     1cf:	cmp    rbx,QWORD PTR [rsp+0x1d0]
     1d7:	jne    cc <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0xcc>

      // Called by constructors to check initial size.
      static _GLIBCXX20_CONSTEXPR size_type
      _S_check_init_len(size_type __n, const allocator_type& __a)
      {
	if (__n > _S_max_size(_Tp_alloc_type(__a)))
     1dd:	mov    rax,r13
     1e0:	shr    rax,0x3d
     1e4:	jne    1ea <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x1ea>
	return __n != 0 ? _Tr::allocate(_M_impl, __n) : pointer();
     1ea:	test   r13,r13
     1ed:	je     339f <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x339f>
	  return static_cast<_Tp*>(_GLIBCXX_OPERATOR_NEW(__n * sizeof(_Tp)));
     1f3:	shl    r13,0x2
     1f7:	mov    rdi,r13
     1fa:	call   1ff <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x1ff>
	  // Allow std::_Construct to be used in constant expressions.
	  std::construct_at(__p, std::forward<_Args>(__args)...);
	  return;
	}
#endif
      ::new(static_cast<void*>(__p)) _Tp(std::forward<_Args>(__args)...);
     1ff:	mov    rdx,r13
     202:	xor    esi,esi
     204:	mov    rdi,rax
     207:	mov    QWORD PTR [rsp+0x58],rax
     20c:	call   211 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x211>
        params.push_back(p);
    }

    std::vector<int> counts(width * height, 0);
    {
        std::vector<int> diff((width + 1) * (height + 1), 0);
     211:	mov    rax,QWORD PTR [rsp+0xc8]
     219:	mov    rbx,QWORD PTR [rsp+0x1c8]
     221:	inc    rax
     224:	inc    rbx
     227:	imul   rbx,rax
     22b:	mov    QWORD PTR [rsp+0x1d0],rax
	if (__n > _S_max_size(_Tp_alloc_type(__a)))
     233:	mov    rax,rbx
     236:	shr    rax,0x3d
     23a:	jne    240 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x240>
	return __n != 0 ? _Tr::allocate(_M_impl, __n) : pointer();
     240:	test   rbx,rbx
     243:	je     3322 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x3322>
     249:	shl    rbx,0x2
     24d:	mov    rdi,rbx
     250:	call   255 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x255>
     255:	mov    rdi,rax
     258:	mov    rdx,rbx
     25b:	xor    esi,esi
     25d:	call   262 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x262>
        for (const auto& p : params) {
     262:	mov    rcx,QWORD PTR [rsp+0xd8]
     26a:	mov    rdi,rax
     26d:	cmp    QWORD PTR [rsp+0x80],rcx
     275:	je     35e4 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x35e4>
     27b:	mov    rax,QWORD PTR [rsp+0x80]
            diff[p.y_begin * (width + 1) + p.x_begin] += 1;
     283:	movsxd rdx,DWORD PTR [rax+0x20]
     287:	mov    r9,QWORD PTR [rsp+0x1d0]
     28f:	add    rax,0x30
     293:	movsxd rsi,DWORD PTR [rax-0x18]
            diff[p.y_begin * (width + 1) + p.x_end  ] -= 1;
            diff[p.y_end   * (width + 1) + p.x_begin] -= 1;
     297:	movsxd r8,DWORD PTR [rax-0xc]
            diff[p.y_begin * (width + 1) + p.x_begin] += 1;
     29b:	imul   rdx,r9
            diff[p.y_end   * (width + 1) + p.x_begin] -= 1;
     29f:	imul   r8,r9
            diff[p.y_begin * (width + 1) + p.x_begin] += 1;
     2a3:	lea    rcx,[rdx+rsi*1]
     2a7:	inc    DWORD PTR [rdi+rcx*4]
            diff[p.y_begin * (width + 1) + p.x_end  ] -= 1;
     2aa:	movsxd rcx,DWORD PTR [rax-0x14]
     2ae:	add    rdx,rcx
     2b1:	dec    DWORD PTR [rdi+rdx*4]
            diff[p.y_end   * (width + 1) + p.x_begin] -= 1;
     2b4:	lea    rdx,[rsi+r8*1]
     2b8:	dec    DWORD PTR [rdi+rdx*4]
            diff[p.y_end   * (width + 1) + p.x_end  ] += 1;
     2bb:	lea    rdx,[rcx+r8*1]
     2bf:	inc    DWORD PTR [rdi+rdx*4]
        for (const auto& p : params) {
     2c2:	cmp    rax,QWORD PTR [rsp+0xd8]
     2ca:	jne    283 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x283>
        }
        for (int y = 0; y < h; ++y) {
     2cc:	test   r12d,r12d
     2cf:	jle    3ac <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x3ac>
     2d5:	mov    ecx,DWORD PTR [rsp+0x98]
     2dc:	test   ecx,ecx
     2de:	jle    3ac <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x3ac>
            int row = 0;
            for (int x = 0; x < w; ++x) {
     2e4:	mov    rax,QWORD PTR [rsp+0xc8]
            int row = 0;
     2ec:	xor    ecx,ecx
     2ee:	lea    edx,[rax-0x1]
        for (const auto& p : params) {
     2f1:	xor    eax,eax
     2f3:	lea    r9,[rdx+0x1]
                row += diff[y * (width + 1) + x];
                counts[y * w + x] = row + (y > 0 ? counts[(y - 1) * w + x] : 0);
     2f7:	mov    rsi,QWORD PTR [rsp+0x58]
                row += diff[y * (width + 1) + x];
     2fc:	add    ecx,DWORD PTR [rdi+rax*4]
                counts[y * w + x] = row + (y > 0 ? counts[(y - 1) * w + x] : 0);
     2ff:	mov    DWORD PTR [rsi+rax*4],ecx
            for (int x = 0; x < w; ++x) {
     302:	inc    rax
     305:	cmp    rax,r9
     308:	jne    2f7 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x2f7>
        for (int y = 0; y < h; ++y) {
     30a:	cmp    r12d,0x1
     30e:	jle    3b1 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x3b1>
     314:	mov    eax,DWORD PTR [rsp+0x98]
            for (int x = 0; x < w; ++x) {
     31b:	mov    r11,QWORD PTR [rsp+0x1d0]
     323:	xor    ecx,ecx
        for (int y = 0; y < h; ++y) {
     325:	mov    r8d,0x1
     32b:	lea    rsi,[rax*4+0x0]
     333:	mov    rax,QWORD PTR [rsp+0x58]
     338:	lea    r10,[rax+rsi*1]
            for (int x = 0; x < w; ++x) {
     33c:	lea    rdx,[rdi+r11*4]
     340:	movsxd rax,ecx
     343:	add    ecx,DWORD PTR [rsp+0xc8]
     34a:	mov    QWORD PTR [rsp+0x1c8],rdx
     352:	mov    rdx,QWORD PTR [rsp+0x58]
            int row = 0;
     357:	mov    DWORD PTR [rsp+0x1b8],ecx
     35e:	lea    rax,[rdx+rax*4]
     362:	xor    edx,edx
     364:	mov    QWORD PTR [rsp+0x1c0],rax
        for (int y = 0; y < h; ++y) {
     36c:	xor    eax,eax
                row += diff[y * (width + 1) + x];
     36e:	mov    rcx,QWORD PTR [rsp+0x1c8]
     376:	add    edx,DWORD PTR [rcx+rax*4]
                counts[y * w + x] = row + (y > 0 ? counts[(y - 1) * w + x] : 0);
     379:	mov    rcx,QWORD PTR [rsp+0x1c0]
     381:	mov    ecx,DWORD PTR [rcx+rax*4]
     384:	add    ecx,edx
     386:	mov    DWORD PTR [r10+rax*4],ecx
            for (int x = 0; x < w; ++x) {
     38a:	inc    rax
     38d:	cmp    rax,r9
     390:	jne    36e <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x36e>
        for (int y = 0; y < h; ++y) {
     392:	inc    r8d
     395:	mov    ecx,DWORD PTR [rsp+0x1b8]
     39c:	add    r11,QWORD PTR [rsp+0x1d0]
     3a4:	add    r10,rsi
     3a7:	cmp    r12d,r8d
     3aa:	jne    33c <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x33c>
	if (__p)
     3ac:	test   rdi,rdi
     3af:	je     3b9 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x3b9>
	_GLIBCXX_OPERATOR_DELETE(_GLIBCXX_SIZED_DEALLOC(__p, __n));
     3b1:	mov    rsi,rbx
     3b4:	call   3b9 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x3b9>
	  return static_cast<_Tp*>(_GLIBCXX_OPERATOR_NEW(__n * sizeof(_Tp)));
     3b9:	mov    edi,0x2fa00
     3be:	call   3c3 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x3c3>
     3c3:	mov    DWORD PTR [rax],0x0
      typedef typename __gnu_cxx::__conditional_type<__load_outside_loop,
						     const _Tp,
						     const _Tp&>::__type _Up;
      _Up __val(__value);
      for (; __first != __last; ++__first)
	*__first = __val;
     3c9:	xor    esi,esi
	  if (__n > 0)
	    {
	      typename iterator_traits<_ForwardIterator>::value_type* __val
		= std::addressof(*__first);
	      std::_Construct(__val);
	      ++__first;
     3cb:	lea    rdi,[rax+0x4]
     3cf:	mov    edx,0x2f9fc
     3d4:	mov    QWORD PTR [rsp+0xe8],rax
     3dc:	call   3e1 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x3e1>
    const int TILE_H = 8;
    const int TILE_W = 2032;

    std::vector<float> tile_vals(TILE_H * TILE_W * 3);

    for (int ty = 0; ty < h; ty += TILE_H) {
     3e1:	test   r12d,r12d
     3e4:	jle    32d1 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x32d1>
        const int tile_y_end    = std::min(ty + TILE_H, h);
        const int tile_h_actual = tile_y_end - ty;

        for (int tx = 0; tx < w; tx += TILE_W) {
     3ea:	mov    edx,DWORD PTR [rsp+0x98]
     3f1:	test   edx,edx
     3f3:	jle    3616 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x3616>
                int y = y_begin;

                for (; y + 3 < y_end; y += 4) {
                    size_t rb[5];
                    rb[0] = ((size_t)(y + p.sy) * width + (size_t)(x_begin + p.sx)) * 3;
                    rb[1] = rb[0] + width * 3;
     3f9:	mov    rbx,QWORD PTR [rsp+0xc8]
     401:	mov    QWORD PTR [rsp+0x78],0x0
     40a:	mov    edx,0x8
      if (__a < __b)
     40f:	vxorps xmm10,xmm10,xmm10
                unsigned char* outp = output.data.data() + (size_t)(y * width + tx) * 3;

                for (int x = 0; x < tile_w_actual; ++x) {
                    int c = counts[y * width + (tx + x)];
                    if (c == 0) continue;
                    float inv_c = 1.0f / (float)c;
     414:	vmovss xmm30,DWORD PTR [rip+0x0]        # 41e <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x41e>
     41e:	vmovss xmm29,DWORD PTR [rip+0x0]        # 428 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x428>
                    rb[1] = rb[0] + width * 3;
     428:	mov    DWORD PTR [rsp+0xe4],0x0
     433:	lea    rcx,[rbx+rbx*2]
     437:	lea    rax,[rbx*8+0x0]
     43f:	mov    QWORD PTR [rsp+0x18],r14
     444:	lea    rsi,[rcx*4+0x0]
     44c:	mov    QWORD PTR [rsp+0x88],rcx
     454:	add    rcx,rcx
     457:	add    rbx,rax
     45a:	mov    QWORD PTR [rsp+0xb0],rcx
     462:	neg    rcx
     465:	mov    QWORD PTR [rsp+0x168],rsi
     46d:	mov    QWORD PTR [rsp+0x60],rbx
     472:	mov    QWORD PTR [rsp+0x68],rcx
     477:	mov    QWORD PTR [rsp+0x20],r13
     47c:	xor    r13d,r13d
      if (__b < __a)
     47f:	cmp    edx,r12d
     482:	mov    ebx,DWORD PTR [rsp+0x78]
        const int tile_h_actual = tile_y_end - ty;
     486:	mov    QWORD PTR [rsp+0xb8],0x0
     492:	cmovg  edx,r12d
     496:	mov    DWORD PTR [rsp+0x28],r12d
     49b:	mov    DWORD PTR [rsp+0x40],ebx
     49f:	mov    DWORD PTR [rsp+0xd0],edx
     4a6:	sub    edx,DWORD PTR [rsp+0xe4]
     4ad:	mov    DWORD PTR [rsp+0x2c],edx
     4b1:	mov    QWORD PTR [rsp+0x30],r13
     4b6:	mov    QWORD PTR [rsp+0x10],rax
     4bb:	mov    rbx,QWORD PTR [rsp+0xb8]
     4c3:	mov    ecx,DWORD PTR [rsp+0x98]
            const int tile_x_end    = std::min(tx + TILE_W, w);
     4ca:	lea    eax,[rbx+0x7f0]
     4d0:	mov    DWORD PTR [rsp+0xe0],ebx
     4d7:	cmp    eax,ecx
     4d9:	cmovg  eax,ecx
            const int tile_w_actual = tile_x_end - tx;
     4dc:	mov    r12d,eax
     4df:	mov    DWORD PTR [rsp+0xd4],eax
                      tile_vals.begin() + tile_h_actual * tile_w_actual * 3,
     4e6:	mov    eax,DWORD PTR [rsp+0x2c]
            const int tile_w_actual = tile_x_end - tx;
     4ea:	sub    r12d,ebx
                      tile_vals.begin() + tile_h_actual * tile_w_actual * 3,
     4ed:	imul   eax,r12d
            const size_t tile_row_stride = (size_t)tile_w_actual * 3;
     4f1:	movsxd rbx,r12d
                      tile_vals.begin() + tile_h_actual * tile_w_actual * 3,
     4f4:	lea    edx,[rax+rax*2]

      _GLIBCXX_NODISCARD __attribute__((__always_inline__))
      _GLIBCXX_CONSTEXPR
      __normal_iterator
      operator+(difference_type __n) const _GLIBCXX_NOEXCEPT
      { return __normal_iterator(_M_current + __n); }
     4f7:	movsxd rdx,edx
      for (; __first != __last; ++__first)
     4fa:	shl    rdx,0x2
     4fe:	je     538 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x538>
	*__first = __val;
     500:	mov    rdi,QWORD PTR [rsp+0xe8]
     508:	vmovaps XMMWORD PTR [rsp+0x1d0],xmm10
     511:	xor    esi,esi
     513:	vzeroupper
     516:	call   51b <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x51b>
     51b:	vmovaps xmm10,XMMWORD PTR [rsp+0x1d0]
     524:	vmovss xmm29,DWORD PTR [rip+0x0]        # 52e <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x52e>
     52e:	vmovss xmm30,DWORD PTR [rip+0x0]        # 538 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x538>
            for (const SubParams& p : params) {
     538:	mov    rcx,QWORD PTR [rsp+0x80]
     540:	cmp    rcx,QWORD PTR [rsp+0xd8]
     548:	je     2b01 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x2b01>
            const size_t tile_row_stride = (size_t)tile_w_actual * 3;
     54e:	lea    rax,[rbx+rbx*2]
     552:	mov    QWORD PTR [rsp+0x48],rbx
                    float* vp1 = vp0 + tile_row_stride;
     557:	lea    rsi,[rax*4+0x0]
            const size_t tile_row_stride = (size_t)tile_w_actual * 3;
     55f:	mov    QWORD PTR [rsp+0xa8],rax
                    float* vp1 = vp0 + tile_row_stride;
     567:	mov    QWORD PTR [rsp+0x128],rsi
     56f:	mov    rsi,rax
     572:	add    rax,rax
     575:	mov    QWORD PTR [rsp+0x70],rax
     57a:	mov    eax,DWORD PTR [rsp+0xd4]
     581:	shl    rsi,0x4
     585:	mov    QWORD PTR [rsp+0x120],rsi
     58d:	sub    rax,QWORD PTR [rsp+0xb8]
     595:	mov    DWORD PTR [rsp+0x44],r12d
     59a:	mov    QWORD PTR [rsp+0x50],rax
     59f:	mov    QWORD PTR [rsp+0x38],r15
     5a4:	nop    DWORD PTR [rax+0x0]
      if (__a < __b)
     5a8:	mov    ebx,DWORD PTR [rsp+0xe4]
     5af:	mov    eax,DWORD PTR [rcx+0x20]
     5b2:	mov    edi,DWORD PTR [rsp+0xe0]
      if (__b < __a)
     5b9:	mov    edx,DWORD PTR [rsp+0xd4]
      if (__a < __b)
     5c0:	cmp    ebx,eax
     5c2:	cmovge eax,ebx
      if (__b < __a)
     5c5:	mov    ebx,DWORD PTR [rsp+0xd0]
      if (__a < __b)
     5cc:	mov    r9d,eax
      if (__b < __a)
     5cf:	mov    eax,DWORD PTR [rcx+0x24]
     5d2:	cmp    ebx,eax
     5d4:	mov    r8d,eax
      if (__a < __b)
     5d7:	mov    eax,DWORD PTR [rcx+0x18]
      if (__b < __a)
     5da:	cmovle r8d,ebx
      if (__a < __b)
     5de:	cmp    edi,eax
     5e0:	cmovge eax,edi
      if (__b < __a)
     5e3:	mov    DWORD PTR [rsp+0xf8],r8d
      if (__a < __b)
     5eb:	mov    ebx,eax
      if (__b < __a)
     5ed:	mov    eax,DWORD PTR [rcx+0x1c]
     5f0:	cmp    edx,eax
     5f2:	cmovle eax,edx
                if (x_begin >= x_end || y_begin >= y_end) continue;
     5f5:	cmp    eax,ebx
     5f7:	jle    2ae0 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x2ae0>
     5fd:	cmp    r8d,r9d
     600:	jle    2ae0 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x2ae0>
                const __m256 Avx = _mm256_set1_ps(p.A);
     606:	vmovss xmm4,DWORD PTR [rcx+0x8]
                const __m256 Bvx = _mm256_set1_ps(p.B);
     60b:	vmovss xmm5,DWORD PTR [rcx+0xc]
                const int x_floats = (x_end - x_begin) * 3;
     610:	sub    eax,ebx
                const __m256 Cvx = _mm256_set1_ps(p.C);
     612:	vmovss xmm6,DWORD PTR [rcx+0x10]
                const __m256 Dvx = _mm256_set1_ps(p.D);
     617:	vmovss xmm7,DWORD PTR [rcx+0x14]
                const int x_floats = (x_end - x_begin) * 3;
     61c:	lea    eax,[rax+rax*2]
     61f:	mov    DWORD PTR [rsp+0x1a0],eax
                const __m256 Avx = _mm256_set1_ps(p.A);
     626:	vbroadcastss ymm9,xmm4
                const __m256 Bvx = _mm256_set1_ps(p.B);
     62b:	vbroadcastss ymm17,xmm5
                const int x_floats = (x_end - x_begin) * 3;
     631:	mov    DWORD PTR [rsp+0xc4],eax
                const __m256 Cvx = _mm256_set1_ps(p.C);
     638:	vbroadcastss ymm25,xmm6
                const __m256 Dvx = _mm256_set1_ps(p.D);
     63e:	vbroadcastss ymm11,xmm7
                for (; y + 3 < y_end; y += 4) {
     643:	lea    eax,[r9+0x3]
/* Create a vector with all elements equal to A.  */
extern __inline __m256 __attribute__((__gnu_inline__, __always_inline__, __artificial__))
_mm256_set1_ps (float __A)
{
  return __extension__ (__m256){ __A, __A, __A, __A,
				 __A, __A, __A, __A };
     647:	vmovaps ymm0,ymm9
     64b:	vmovaps ymm1,ymm17
     651:	vmovaps ymm2,ymm25
     657:	vmovaps ymm3,ymm11
     65b:	cmp    r8d,eax
     65e:	jle    bc8 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0xbc8>
                    float* vp0 = tile_vals.data() + (size_t)(y     - ty) * tile_row_stride + (size_t)(x_begin - tx) * 3;
     664:	mov    esi,ebx
     666:	mov    eax,r9d
                    rb[0] = ((size_t)(y + p.sy) * width + (size_t)(x_begin + p.sx)) * 3;
     669:	mov    edx,DWORD PTR [rcx]
     66b:	lea    r10d,[r8-0x4]
                    float* vp0 = tile_vals.data() + (size_t)(y     - ty) * tile_row_stride + (size_t)(x_begin - tx) * 3;
     66f:	sub    esi,edi
     671:	sub    r10d,r9d
                        __m256 rl0 = load_cvt8(p.SUB + rb[0] + xf);
     674:	mov    r11,QWORD PTR [rcx+0x28]
                    for (int k = 0; k < x_floats - xf; ++k) {
     678:	mov    DWORD PTR [rsp+0x1d0],0x0
                    float* vp0 = tile_vals.data() + (size_t)(y     - ty) * tile_row_stride + (size_t)(x_begin - tx) * 3;
     683:	movsxd rsi,esi
                    rb[0] = ((size_t)(y + p.sy) * width + (size_t)(x_begin + p.sx)) * 3;
     686:	add    edx,ebx
     688:	mov    r8d,r10d
     68b:	mov    DWORD PTR [rsp+0xc0],ebx
                    float* vp0 = tile_vals.data() + (size_t)(y     - ty) * tile_row_stride + (size_t)(x_begin - tx) * 3;
     692:	lea    rdi,[rsi+rsi*2]
     696:	mov    rsi,rax
                    rb[0] = ((size_t)(y + p.sy) * width + (size_t)(x_begin + p.sx)) * 3;
     699:	movsxd rdx,edx
     69c:	shr    r8d,0x2
     6a0:	sub    rsi,QWORD PTR [rsp+0x78]
     6a5:	mov    DWORD PTR [rsp+0x150],r8d
     6ad:	imul   rsi,QWORD PTR [rsp+0xa8]
     6b6:	mov    r8,QWORD PTR [rsp+0x68]
     6bb:	mov    DWORD PTR [rsp+0xa0],r9d
     6c3:	mov    QWORD PTR [rsp+0x90],rcx
     6cb:	sub    r8,r11
     6ce:	mov    DWORD PTR [rsp+0x9c],r10d
     6d6:	add    rsi,rdi
     6d9:	mov    rdi,QWORD PTR [rsp+0xe8]
     6e1:	mov    QWORD PTR [rsp+0x140],r8
     6e9:	mov    r8,QWORD PTR [rsp+0x88]
                        __m256 rl0 = load_cvt8(p.SUB + rb[0] + xf);
     6f1:	mov    QWORD PTR [rsp+0x1b0],r11
     6f9:	lea    r15,[rdi+rsi*4]
     6fd:	add    rsi,QWORD PTR [rsp+0x70]
     702:	lea    r14,[rdi+rsi*4]
     706:	movsxd rsi,DWORD PTR [rcx+0x4]
     70a:	mov    rdi,QWORD PTR [rsp+0xc8]
     712:	sub    r8,r11
     715:	mov    QWORD PTR [rsp+0x130],r8
     71d:	mov    r8d,DWORD PTR [rsp+0x1a0]
     725:	add    rsi,rax
     728:	imul   rsi,rdi
     72c:	lea    rax,[rdx+rsi*1]
     730:	add    rdx,rdi
     733:	mov    rdi,QWORD PTR [rsp+0x60]
     738:	add    rdx,rsi
     73b:	lea    rax,[rax+rax*2]
     73f:	lea    rdx,[rdx+rdx*2]
     743:	lea    r13,[r11+rax*1]
     747:	lea    r12,[r11+rdx*1]
     74b:	mov    rdx,QWORD PTR [rsp+0xb0]
     753:	mov    QWORD PTR [rsp+0x1c8],r13
     75b:	lea    rsi,[r11+rdx*1]
     75f:	lea    rdx,[r11+rdi*1]
     763:	lea    rdi,[rdx+rax*1]
     767:	mov    rdx,QWORD PTR [rsp+0xb0]
     76f:	add    rsi,rax
     772:	mov    QWORD PTR [rsp+0x1c0],rdi
     77a:	mov    rdi,QWORD PTR [rsp+0x168]
     782:	sub    rdx,r11
     785:	add    rdi,r11
     788:	mov    QWORD PTR [rsp+0x160],rdx
     790:	mov    r11,r12
     793:	add    rdi,rax
     796:	lea    eax,[r8-0x8]
     79a:	mov    r10,QWORD PTR [rsp+0x1c0]
     7a2:	mov    edx,eax
     7a4:	shr    eax,0x3
     7a7:	mov    r13,rdi
     7aa:	and    edx,0xfffffff8
     7ad:	inc    eax
     7af:	add    edx,0x8
     7b2:	shl    rax,0x3
     7b6:	mov    QWORD PTR [rsp+0x100],rax
                    for (int k = 0; k < x_floats - xf; ++k) {
     7be:	sub    r8d,edx
                        float s0l = p.SUB[rb[0]+xf+k], s0r = p.SUB[rb[0]+xf+k+3];
     7c1:	mov    eax,edx
     7c3:	mov    DWORD PTR [rsp+0xfc],edx
                    for (int k = 0; k < x_floats - xf; ++k) {
     7ca:	mov    DWORD PTR [rsp+0x110],r8d
                        float s0l = p.SUB[rb[0]+xf+k], s0r = p.SUB[rb[0]+xf+k+3];
     7d2:	mov    QWORD PTR [rsp+0xf0],rax
     7da:	nop    WORD PTR [rax+rax*1+0x0]
                    rb[0] = ((size_t)(y + p.sy) * width + (size_t)(x_begin + p.sx)) * 3;
     7e0:	mov    rax,QWORD PTR [rsp+0x140]
                    rb[1] = rb[0] + width * 3;
     7e8:	mov    r9,r11
     7eb:	sub    r9,QWORD PTR [rsp+0x1b0]
                    rb[0] = ((size_t)(y + p.sy) * width + (size_t)(x_begin + p.sx)) * 3;
     7f3:	lea    rdi,[rsi+rax*1]
                    rb[2] = rb[1] + width * 3;
     7f7:	lea    r8,[r13+rax*1+0x0]
                    rb[3] = rb[2] + width * 3;
     7fc:	mov    rax,QWORD PTR [rsp+0x130]
     804:	add    rax,rsi
     807:	mov    QWORD PTR [rsp+0x1c0],rax
                    rb[4] = rb[3] + width * 3;
     80f:	mov    rax,QWORD PTR [rsp+0x160]
     817:	add    rax,rsi
                    for (; xf + 8 <= x_floats; xf += 8) {
     81a:	cmp    DWORD PTR [rsp+0x1a0],0x7
                    rb[4] = rb[3] + width * 3;
     822:	mov    QWORD PTR [rsp+0x1b8],rax
                    float* vp1 = vp0 + tile_row_stride;
     82a:	mov    rax,QWORD PTR [rsp+0x128]
     832:	lea    rcx,[rax+r15*1]
                    float* vp3 = vp2 + tile_row_stride;
     836:	lea    rdx,[rax+r14*1]
                    for (; xf + 8 <= x_floats; xf += 8) {
     83a:	jle    2ca0 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x2ca0>
     840:	mov    rbx,QWORD PTR [rsp+0x1c8]
     848:	mov    r12,QWORD PTR [rsp+0x100]
     850:	xor    eax,eax
     852:	nop    WORD PTR [rax+rax*1+0x0]

extern __inline __m256i
__attribute__ ((__gnu_inline__, __always_inline__, __artificial__))
_mm256_cvtepu8_epi32 (__m128i __X)
{
  return (__m256i) __builtin_ia32_pmovzxbd256 ((__v16qi)__X);
     858:	vpmovzxbd ymm14,QWORD PTR [rbx+rax*1]
     85e:	vpmovzxbd ymm8,QWORD PTR [rax+rbx*1+0x3]
     865:	vpmovzxbd ymm13,QWORD PTR [r11+rax*1]
     86b:	vpmovzxbd ymm12,QWORD PTR [rax+r11*1+0x3]
  return (__m256)__builtin_ia32_cvtdq2ps256 ((__v8si) __A);
     872:	vcvtdq2ps ymm14,ymm14

extern __inline __m256
__attribute__((__gnu_inline__, __always_inline__, __artificial__))
_mm256_fmadd_ps (__m256 __A, __m256 __B, __m256 __C)
{
  return (__m256)__builtin_ia32_vfmaddps256 ((__v8sf)__A, (__v8sf)__B,
     877:	vfmadd213ps ymm14,ymm0,YMMWORD PTR [r15+rax*4]
     87d:	vcvtdq2ps ymm8,ymm8
     882:	vcvtdq2ps ymm13,ymm13
     887:	vcvtdq2ps ymm12,ymm12
     88c:	vfmadd132ps ymm8,ymm14,ymm1
     891:	vpmovzxbd ymm14,QWORD PTR [rsi+rax*1]
     897:	vcvtdq2ps ymm14,ymm14
     89c:	vfmadd231ps ymm8,ymm2,ymm13
     8a1:	vfmadd231ps ymm8,ymm3,ymm12
  *(__m256_u *)__P = __A;
     8a6:	vmovups YMMWORD PTR [r15+rax*4],ymm8
     8ac:	vpmovzxbd ymm8,QWORD PTR [rax+rsi*1+0x3]
     8b3:	vfmadd213ps ymm13,ymm0,YMMWORD PTR [rcx+rax*4]
  return (__m256)__builtin_ia32_cvtdq2ps256 ((__v8si) __A);
     8b9:	vcvtdq2ps ymm8,ymm8
     8be:	vfmadd132ps ymm12,ymm13,ymm1
     8c3:	vpmovzxbd ymm13,QWORD PTR [r10+rax*1]
     8c9:	vcvtdq2ps ymm13,ymm13
     8ce:	vfmadd231ps ymm12,ymm2,ymm14
     8d3:	vfmadd231ps ymm12,ymm3,ymm8
  *(__m256_u *)__P = __A;
     8d8:	vmovups YMMWORD PTR [rcx+rax*4],ymm12
     8dd:	vpmovzxbd ymm12,QWORD PTR [rax+r10*1+0x3]
     8e4:	vfmadd213ps ymm14,ymm0,YMMWORD PTR [r14+rax*4]
  return (__m256)__builtin_ia32_cvtdq2ps256 ((__v8si) __A);
     8ea:	vcvtdq2ps ymm12,ymm12
     8ef:	vfmadd132ps ymm8,ymm14,ymm1
     8f4:	vpmovzxbd ymm14,QWORD PTR [r13+rax*1+0x0]
     8fb:	vcvtdq2ps ymm14,ymm14
     900:	vfmadd231ps ymm8,ymm2,ymm13
     905:	vfmadd231ps ymm8,ymm3,ymm12
  *(__m256_u *)__P = __A;
     90a:	vmovups YMMWORD PTR [r14+rax*4],ymm8
     910:	vpmovzxbd ymm8,QWORD PTR [rax+r13*1+0x3]
     917:	vfmadd213ps ymm13,ymm0,YMMWORD PTR [rdx+rax*4]
  return (__m256)__builtin_ia32_cvtdq2ps256 ((__v8si) __A);
     91d:	vcvtdq2ps ymm8,ymm8
     922:	vfmadd132ps ymm12,ymm13,ymm1
     927:	vfmadd231ps ymm12,ymm2,ymm14
     92c:	vfmadd132ps ymm8,ymm12,ymm3
  *(__m256_u *)__P = __A;
     931:	vmovups YMMWORD PTR [rdx+rax*4],ymm8
     936:	add    rax,0x8
     93a:	cmp    rax,r12
     93d:	jne    858 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x858>
                    for (int k = 0; k < x_floats - xf; ++k) {
     943:	mov    r12d,DWORD PTR [rsp+0x110]
     94b:	mov    QWORD PTR [rsp+0x1c8],rbx
     953:	test   r12d,r12d
     956:	jle    b4b <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0xb4b>
                        float s0l = p.SUB[rb[0]+xf+k], s0r = p.SUB[rb[0]+xf+k+3];
     95c:	mov    rax,QWORD PTR [rsp+0xf0]
                        float s4l = p.SUB[rb[4]+xf+k], s4r = p.SUB[rb[4]+xf+k+3];
     964:	mov    DWORD PTR [rsp+0x1a4],r12d
     96c:	mov    ebx,r12d
                        float s3l = p.SUB[rb[3]+xf+k], s3r = p.SUB[rb[3]+xf+k+3];
     96f:	add    QWORD PTR [rsp+0x1c0],rax
                        float s0l = p.SUB[rb[0]+xf+k], s0r = p.SUB[rb[0]+xf+k+3];
     977:	add    rdi,rax
                        float s1l = p.SUB[rb[1]+xf+k], s1r = p.SUB[rb[1]+xf+k+3];
     97a:	add    r9,rax
                        float s2l = p.SUB[rb[2]+xf+k], s2r = p.SUB[rb[2]+xf+k+3];
     97d:	add    r8,rax
                        float s4l = p.SUB[rb[4]+xf+k], s4r = p.SUB[rb[4]+xf+k+3];
     980:	add    QWORD PTR [rsp+0x1b8],rax
     988:	mov    eax,DWORD PTR [rsp+0xfc]
     98f:	shl    rax,0x2
     993:	mov    QWORD PTR [rsp+0x170],rsi
     99b:	add    rcx,rax
     99e:	lea    r12,[r15+rax*1]
     9a2:	mov    QWORD PTR [rsp+0x1a8],rcx
     9aa:	lea    rcx,[r14+rax*1]
     9ae:	add    rax,rdx
     9b1:	mov    rdx,QWORD PTR [rsp+0x1b0]
     9b9:	mov    QWORD PTR [rsp+0x190],rcx
     9c1:	mov    QWORD PTR [rsp+0x180],rax
     9c9:	lea    rcx,[rdx+rdi*1]
     9cd:	mov    rdi,rdx
     9d0:	lea    rdx,[rdx+r9*1]
     9d4:	lea    r9,[rdi+r8*1]
     9d8:	mov    r8,QWORD PTR [rsp+0x1c0]
     9e0:	mov    QWORD PTR [rsp+0x1c0],r13
                    int xf = 0;
     9e8:	xor    eax,eax
     9ea:	mov    rsi,QWORD PTR [rsp+0x1a8]
     9f2:	mov    QWORD PTR [rsp+0x1a8],r11
     9fa:	add    r8,rdi
     9fd:	mov    r11,QWORD PTR [rsp+0x180]
     a05:	add    rdi,QWORD PTR [rsp+0x1b8]
     a0d:	mov    QWORD PTR [rsp+0x1b8],r10
     a15:	mov    r10,QWORD PTR [rsp+0x190]
     a1d:	nop    DWORD PTR [rax]
                        float s1l = p.SUB[rb[1]+xf+k], s1r = p.SUB[rb[1]+xf+k+3];
     a20:	movzx  r13d,BYTE PTR [rdx+rax*1]
     a25:	vcvtusi2ss xmm12,xmm10,r13d
     a2b:	movzx  r13d,BYTE PTR [rdx+rax*1+0x3]
     a31:	vcvtusi2ss xmm20,xmm10,r13d
                        float s2l = p.SUB[rb[2]+xf+k], s2r = p.SUB[rb[2]+xf+k+3];
     a37:	movzx  r13d,BYTE PTR [r9+rax*1]
     a3c:	vcvtusi2ss xmm8,xmm10,r13d
     a42:	movzx  r13d,BYTE PTR [r9+rax*1+0x3]
                        vp0[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
     a48:	vmulss xmm22,xmm6,xmm12
                        float s2l = p.SUB[rb[2]+xf+k], s2r = p.SUB[rb[2]+xf+k+3];
     a4e:	vcvtusi2ss xmm19,xmm10,r13d
                        float s3l = p.SUB[rb[3]+xf+k], s3r = p.SUB[rb[3]+xf+k+3];
     a54:	movzx  r13d,BYTE PTR [r8+rax*1]
     a59:	vcvtusi2ss xmm16,xmm10,r13d
     a5f:	movzx  r13d,BYTE PTR [r8+rax*1+0x3]
     a65:	vcvtusi2ss xmm15,xmm10,r13d
                        float s4l = p.SUB[rb[4]+xf+k], s4r = p.SUB[rb[4]+xf+k+3];
     a6b:	movzx  r13d,BYTE PTR [rdi+rax*1]
     a70:	vcvtusi2ss xmm18,xmm10,r13d
     a76:	movzx  r13d,BYTE PTR [rdi+rax*1+0x3]
     a7c:	vcvtusi2ss xmm14,xmm10,r13d
                        float s0l = p.SUB[rb[0]+xf+k], s0r = p.SUB[rb[0]+xf+k+3];
     a82:	movzx  r13d,BYTE PTR [rcx+rax*1]
     a87:	vcvtusi2ss xmm13,xmm10,r13d
     a8d:	movzx  r13d,BYTE PTR [rcx+rax*1+0x3]
                        vp3[xf+k] += p.A*s3l + p.B*s3r + p.C*s4l + p.D*s4r;
     a93:	vmulss xmm18,xmm6,xmm18
                        float s0l = p.SUB[rb[0]+xf+k], s0r = p.SUB[rb[0]+xf+k+3];
     a99:	vcvtusi2ss xmm21,xmm10,r13d
     a9f:	vfmadd213ss xmm13,xmm4,DWORD PTR [r12+rax*4]
     aa5:	vfmadd132ss xmm21,xmm22,xmm5
                        vp0[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
     aab:	vfmadd231ss xmm13,xmm7,xmm20
     ab1:	vaddss xmm13,xmm13,xmm21
     ab7:	vmovss DWORD PTR [r12+rax*4],xmm13
                        vp1[xf+k] += p.A*s1l + p.B*s1r + p.C*s2l + p.D*s2r;
     abd:	vmulss xmm13,xmm6,xmm8
     ac2:	vfmadd213ss xmm12,xmm4,DWORD PTR [rsi+rax*4]
     ac8:	vfmadd132ss xmm20,xmm13,xmm5
     ace:	vfmadd231ss xmm12,xmm7,xmm19
     ad4:	vaddss xmm12,xmm12,xmm20
     ada:	vmovss DWORD PTR [rsi+rax*4],xmm12
                        vp2[xf+k] += p.A*s2l + p.B*s2r + p.C*s3l + p.D*s3r;
     adf:	vmulss xmm12,xmm6,xmm16
     ae5:	vfmadd213ss xmm8,xmm4,DWORD PTR [r10+rax*4]
     aeb:	vfmadd132ss xmm19,xmm12,xmm5
     af1:	vfmadd231ss xmm8,xmm7,xmm15
     af6:	vfmadd132ss xmm15,xmm18,xmm5
     afc:	vaddss xmm8,xmm8,xmm19
     b02:	vmovss DWORD PTR [r10+rax*4],xmm8
                        vp3[xf+k] += p.A*s3l + p.B*s3r + p.C*s4l + p.D*s4r;
     b08:	vfmadd213ss xmm16,xmm4,DWORD PTR [r11+rax*4]
     b0f:	vfmadd132ss xmm14,xmm16,xmm7
     b15:	vaddss xmm14,xmm14,xmm15
     b1a:	vmovss DWORD PTR [r11+rax*4],xmm14
                    for (int k = 0; k < x_floats - xf; ++k) {
     b20:	inc    rax
     b23:	cmp    ebx,eax
     b25:	jg     a20 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0xa20>
     b2b:	mov    r13,QWORD PTR [rsp+0x1c0]
     b33:	mov    r10,QWORD PTR [rsp+0x1b8]
     b3b:	mov    rsi,QWORD PTR [rsp+0x170]
     b43:	mov    r11,QWORD PTR [rsp+0x1a8]
                for (; y + 3 < y_end; y += 4) {
     b4b:	mov    rax,QWORD PTR [rsp+0x120]
     b53:	mov    ecx,DWORD PTR [rsp+0x150]
     b5a:	add    r15,rax
     b5d:	add    r14,rax
     b60:	mov    rax,QWORD PTR [rsp+0x168]
     b68:	add    QWORD PTR [rsp+0x1c8],rax
     b70:	add    r11,rax
     b73:	add    rsi,rax
     b76:	add    r10,rax
     b79:	add    r13,rax
     b7c:	cmp    DWORD PTR [rsp+0x1d0],ecx
     b83:	je     ba0 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0xba0>
     b85:	mov    eax,DWORD PTR [rsp+0x1d0]
     b8c:	inc    eax
     b8e:	mov    DWORD PTR [rsp+0x1d0],eax
     b95:	jmp    7e0 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x7e0>
     b9a:	nop    WORD PTR [rax+rax*1+0x0]
     ba0:	mov    r10d,DWORD PTR [rsp+0x9c]
     ba8:	mov    r9d,DWORD PTR [rsp+0xa0]
     bb0:	mov    ebx,DWORD PTR [rsp+0xc0]
     bb7:	mov    rcx,QWORD PTR [rsp+0x90]
     bbf:	and    r10d,0xfffffffc
     bc3:	lea    r9d,[r9+r10*1+0x4]
                for (; y + 1 < y_end; y += 2) {
     bc8:	lea    eax,[r9+0x1]
     bcc:	cmp    eax,DWORD PTR [rsp+0xf8]
     bd3:	jge    1ffc <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x1ffc>
                    rb[0] = ((size_t)(y + p.sy) * width + (size_t)(x_begin + p.sx)) * 3;
     bd9:	mov    eax,DWORD PTR [rcx+0x4]
     bdc:	mov    edx,DWORD PTR [rcx]
                    float* vp0 = tile_vals.data() + (size_t)(y - ty)     * tile_row_stride + (size_t)(x_begin - tx) * 3;
     bde:	mov    r13,QWORD PTR [rsp+0xa8]
     be6:	mov    rsi,QWORD PTR [rsp+0xe8]
                    rb[0] = ((size_t)(y + p.sy) * width + (size_t)(x_begin + p.sx)) * 3;
     bee:	add    eax,r9d
     bf1:	add    edx,ebx
                    float* vp1 = vp0 + tile_row_stride;
     bf3:	mov    rdi,QWORD PTR [rsp+0x128]
                    rb[0] = ((size_t)(y + p.sy) * width + (size_t)(x_begin + p.sx)) * 3;
     bfb:	cdqe
     bfd:	movsxd rdx,edx
     c00:	imul   rax,QWORD PTR [rsp+0xc8]
     c09:	add    rax,rdx
     c0c:	lea    r11,[rax+rax*2]
                    rb[1] = rb[0] + width * 3;
     c10:	mov    rax,QWORD PTR [rsp+0x88]
                    rb[0] = ((size_t)(y + p.sy) * width + (size_t)(x_begin + p.sx)) * 3;
     c18:	mov    QWORD PTR [rsp+0x1b8],r11
                    rb[1] = rb[0] + width * 3;
     c20:	lea    r15,[rax+r11*1]
                    rb[2] = rb[1] + width * 3;
     c24:	lea    r12,[rax+r15*1]
                    float* vp0 = tile_vals.data() + (size_t)(y - ty)     * tile_row_stride + (size_t)(x_begin - tx) * 3;
     c28:	mov    eax,r9d
                    rb[1] = rb[0] + width * 3;
     c2b:	mov    QWORD PTR [rsp+0x1c8],r15
                    float* vp0 = tile_vals.data() + (size_t)(y - ty)     * tile_row_stride + (size_t)(x_begin - tx) * 3;
     c33:	sub    eax,DWORD PTR [rsp+0xe4]
                    rb[2] = rb[1] + width * 3;
     c3a:	mov    QWORD PTR [rsp+0x1c0],r12
                    float* vp0 = tile_vals.data() + (size_t)(y - ty)     * tile_row_stride + (size_t)(x_begin - tx) * 3;
     c42:	cdqe
     c44:	imul   r13,rax
     c48:	mov    eax,ebx
     c4a:	sub    eax,DWORD PTR [rsp+0xe0]
     c51:	cdqe
     c53:	lea    rax,[rax+rax*2]
     c57:	add    rax,r13
     c5a:	lea    rdx,[rsi+rax*4]
                    float* vp1 = vp0 + tile_row_stride;
     c5e:	lea    rax,[rdx+rdi*1]
     c62:	mov    QWORD PTR [rsp+0x1d0],rax
                    for (; xf + 8 <= x_floats; xf += 8) {
     c6a:	mov    eax,DWORD PTR [rsp+0x1a0]
     c71:	cmp    eax,0x7
     c74:	jle    31ec <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x31ec>
                        __m256 rl0 = load_cvt8(p.SUB + rb[0] + xf);
     c7a:	mov    rdi,QWORD PTR [rcx+0x28]
     c7e:	lea    r14d,[rax-0x8]
     c82:	shr    eax,0x3
     c85:	lea    r10d,[rax*8+0x0]
     c8d:	xor    eax,eax
     c8f:	mov    rsi,rdi
     c92:	mov    QWORD PTR [rsp+0x1b0],rdi
     c9a:	lea    r8,[rdi+r11*1]
     c9e:	lea    rdi,[rdi+r15*1]
     ca2:	add    rsi,r12
     ca5:	mov    r12,QWORD PTR [rsp+0x1d0]
     cad:	nop    DWORD PTR [rax]
     cb0:	vpmovzxbd ymm14,QWORD PTR [r8+rax*1]
     cb6:	vpmovzxbd ymm8,QWORD PTR [r8+rax*1+0x3]
     cbd:	vpmovzxbd ymm13,QWORD PTR [rdi+rax*1]
     cc3:	vpmovzxbd ymm12,QWORD PTR [rdi+rax*1+0x3]
  return (__m256)__builtin_ia32_cvtdq2ps256 ((__v8si) __A);
     cca:	vcvtdq2ps ymm14,ymm14
     ccf:	vfmadd213ps ymm14,ymm0,YMMWORD PTR [rdx+rax*4]
     cd5:	vcvtdq2ps ymm8,ymm8
     cda:	vcvtdq2ps ymm13,ymm13
     cdf:	vcvtdq2ps ymm12,ymm12
     ce4:	vfmadd132ps ymm8,ymm14,ymm1
     ce9:	vpmovzxbd ymm14,QWORD PTR [rsi+rax*1]
     cef:	vcvtdq2ps ymm14,ymm14
     cf4:	vfmadd231ps ymm8,ymm2,ymm13
     cf9:	vfmadd231ps ymm8,ymm3,ymm12
  *(__m256_u *)__P = __A;
     cfe:	vmovups YMMWORD PTR [rdx+rax*4],ymm8
     d03:	vpmovzxbd ymm8,QWORD PTR [rsi+rax*1+0x3]
     d0a:	vfmadd213ps ymm13,ymm0,YMMWORD PTR [r12+rax*4]
  return (__m256)__builtin_ia32_cvtdq2ps256 ((__v8si) __A);
     d10:	vcvtdq2ps ymm8,ymm8
     d15:	vfmadd132ps ymm12,ymm13,ymm1
     d1a:	vfmadd231ps ymm12,ymm2,ymm14
     d1f:	vfmadd132ps ymm8,ymm12,ymm3
  *(__m256_u *)__P = __A;
     d24:	vmovups YMMWORD PTR [r12+rax*4],ymm8
                    for (; xf + 8 <= x_floats; xf += 8) {
     d2a:	add    rax,0x8
     d2e:	cmp    rax,r10
     d31:	jne    cb0 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0xcb0>
     d37:	mov    eax,r14d
     d3a:	mov    QWORD PTR [rsp+0x1d0],r12
     d42:	and    eax,0xfffffff8
     d45:	lea    esi,[rax+0x8]
                    for (int k = 0; k < x_floats - xf; ++k) {
     d48:	mov    eax,DWORD PTR [rsp+0x1a0]
     d4f:	mov    DWORD PTR [rsp+0x1a4],esi
     d56:	sub    eax,esi
     d58:	mov    DWORD PTR [rsp+0x1a8],eax
     d5f:	test   eax,eax
     d61:	jle    1ff8 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x1ff8>
                        float s0l = p.SUB[rb[0]+xf+k], s0r = p.SUB[rb[0]+xf+k+3];
     d67:	mov    eax,esi
     d69:	lea    rsi,[r11+rax*1]
                        float s1l = p.SUB[rb[1]+xf+k], s1r = p.SUB[rb[1]+xf+k+3];
     d6d:	add    QWORD PTR [rsp+0x1c8],rax
                        float s2l = p.SUB[rb[2]+xf+k], s2r = p.SUB[rb[2]+xf+k+3];
     d75:	add    QWORD PTR [rsp+0x1c0],rax
                        float s0l = p.SUB[rb[0]+xf+k], s0r = p.SUB[rb[0]+xf+k+3];
     d7d:	mov    QWORD PTR [rsp+0x1b8],rsi
     d85:	mov    eax,ebx
     d87:	mov    edi,DWORD PTR [rsp+0x1a4]
     d8e:	sub    rax,QWORD PTR [rsp+0xb8]
     d96:	lea    rsi,[rax+rax*2]
     d9a:	add    rax,QWORD PTR [rsp+0x50]
     d9f:	mov    QWORD PTR [rsp+0x160],rdi
     da7:	add    rsi,r13
     daa:	lea    rax,[rax+rax*2]
     dae:	add    rsi,rdi
     db1:	add    rax,r13
     db4:	add    rax,rdi
     db7:	mov    rdi,rsi
     dba:	mov    QWORD PTR [rsp+0x180],rsi
     dc2:	lea    rsi,[rsi*4+0x0]
     dca:	mov    QWORD PTR [rsp+0x190],rax
     dd2:	lea    rdi,[rdi*4+0x80]
     dda:	shl    rax,0x2
     dde:	cmp    rax,rdi
     de1:	jge    df3 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0xdf3>
     de3:	lea    rdi,[rax+0x80]
     dea:	cmp    rsi,rdi
     ded:	jl     2cbc <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x2cbc>
     df3:	mov    r15d,DWORD PTR [rsp+0x1a8]
     dfb:	lea    edi,[r15-0x1]
     dff:	cmp    edi,0x1e
     e02:	jbe    3298 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x3298>
     e08:	mov    rdi,QWORD PTR [rsp+0x1b0]
     e10:	mov    r14,QWORD PTR [rsp+0x1c8]
     e18:	shr    r15d,0x5
     e1c:	mov    DWORD PTR [rsp+0xf0],ebx
     e23:	mov    r11,QWORD PTR [rsp+0x1b8]
     e2b:	mov    r13,QWORD PTR [rsp+0x1c0]
     e33:	mov    DWORD PTR [rsp+0x170],r15d
     e3b:	lea    r8,[rdi+r14*1+0x3]
     e40:	add    r14,rdi
     e43:	mov    r12,QWORD PTR [rsp+0x1d0]
     e4b:	vmovss DWORD PTR [rsp+0x130],xmm4
     e54:	mov    QWORD PTR [rsp+0x150],r14
     e5c:	lea    r10,[rdi+r11*1+0x3]
     e61:	lea    r14,[rdi+r11*1]
     e65:	lea    r11,[rdi+r13*1+0x3]
     e6a:	add    rdi,r13
     e6d:	vmovss DWORD PTR [rsp+0x110],xmm5
     e76:	mov    QWORD PTR [rsp+0x140],rdi
     e7e:	mov    rdi,QWORD PTR [rsp+0xe8]
     e86:	mov    r13,QWORD PTR [rsp+0x150]
     e8e:	vmovss DWORD PTR [rsp+0x100],xmm6
     e97:	add    rax,rdi
     e9a:	add    rsi,rdi
     e9d:	mov    edi,r15d
     ea0:	vmovss DWORD PTR [rsp+0xfc],xmm7
     ea9:	shl    rdi,0x5
     ead:	mov    r15,rdi
     eb0:	xor    edi,edi
     eb2:	mov    rbx,r15
     eb5:	mov    r15,QWORD PTR [rsp+0x140]
     ebd:	nop    DWORD PTR [rax]
                        float s1l = p.SUB[rb[1]+xf+k], s1r = p.SUB[rb[1]+xf+k+3];
     ec0:	vmovdqu ymm5,YMMWORD PTR [r13+rdi*1+0x0]
                        float s0l = p.SUB[rb[0]+xf+k], s0r = p.SUB[rb[0]+xf+k+3];
     ec7:	vmovdqu ymm4,YMMWORD PTR [r10+rdi*1]
     ecd:	sub    rax,0xffffffffffffff80
     ed1:	sub    rsi,0xffffffffffffff80
     ed5:	vmovdqu ymm13,YMMWORD PTR [r14+rdi*1]
                        float s1l = p.SUB[rb[1]+xf+k], s1r = p.SUB[rb[1]+xf+k+3];
     edb:	vpmovzxbw ymm7,xmm5
     ee0:	vextracti32x4 xmm5,ymm5,0x1
                        float s0l = p.SUB[rb[0]+xf+k], s0r = p.SUB[rb[0]+xf+k+3];
     ee7:	vpmovzxbw ymm6,xmm4
                        float s1l = p.SUB[rb[1]+xf+k], s1r = p.SUB[rb[1]+xf+k+3];
     eec:	vpmovzxbw ymm5,xmm5
     ef1:	vpmovsxwd ymm27,xmm7
     ef7:	vextracti32x4 xmm16,ymm7,0x1
     efe:	vpmovsxwd ymm26,xmm5
     f04:	vextracti32x4 xmm8,ymm5,0x1
     f0b:	vcvtdq2ps ymm27,ymm27
                        float s0l = p.SUB[rb[0]+xf+k], s0r = p.SUB[rb[0]+xf+k+3];
     f11:	vpmovsxwd ymm23,xmm6
                        vp0[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
     f17:	vmulps ymm5,ymm2,ymm27
                        float s1l = p.SUB[rb[1]+xf+k], s1r = p.SUB[rb[1]+xf+k+3];
     f1d:	vpmovsxwd ymm16,xmm16
                        float s0l = p.SUB[rb[0]+xf+k], s0r = p.SUB[rb[0]+xf+k+3];
     f23:	vcvtdq2ps ymm23,ymm23
     f29:	vextracti32x4 xmm4,ymm4,0x1
                        float s1l = p.SUB[rb[1]+xf+k], s1r = p.SUB[rb[1]+xf+k+3];
     f30:	vcvtdq2ps ymm26,ymm26
     f36:	vcvtdq2ps ymm16,ymm16
                        float s0l = p.SUB[rb[0]+xf+k], s0r = p.SUB[rb[0]+xf+k+3];
     f3c:	vpmovzxbw ymm4,xmm4
                        float s1l = p.SUB[rb[1]+xf+k], s1r = p.SUB[rb[1]+xf+k+3];
     f41:	vpmovsxwd ymm8,xmm8
                        float s0l = p.SUB[rb[0]+xf+k], s0r = p.SUB[rb[0]+xf+k+3];
     f46:	vextracti32x4 xmm14,ymm6,0x1
     f4d:	vpmovsxwd ymm22,xmm4
     f53:	vextracti32x4 xmm12,ymm4,0x1
                        float s1l = p.SUB[rb[1]+xf+k], s1r = p.SUB[rb[1]+xf+k+3];
     f5a:	vcvtdq2ps ymm8,ymm8
                        float s0l = p.SUB[rb[0]+xf+k], s0r = p.SUB[rb[0]+xf+k+3];
     f5f:	vpmovsxwd ymm14,xmm14
                        vp0[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
     f64:	vmulps ymm4,ymm2,ymm8
                        float s0l = p.SUB[rb[0]+xf+k], s0r = p.SUB[rb[0]+xf+k+3];
     f69:	vcvtdq2ps ymm14,ymm14
     f6e:	vpmovsxwd ymm12,xmm12
     f73:	vcvtdq2ps ymm22,ymm22
     f79:	vpmovzxbw ymm15,xmm13
     f7e:	vcvtdq2ps ymm12,ymm12
     f83:	vpmovsxwd ymm24,xmm15
     f89:	vextracti32x4 xmm15,ymm15,0x1
     f90:	vextracti32x4 xmm13,ymm13,0x1
     f97:	vfmadd132ps ymm23,ymm5,ymm1
     f9d:	vpmovsxwd ymm15,xmm15
     fa2:	vpmovzxbw ymm13,xmm13
     fa7:	vcvtdq2ps ymm24,ymm24
                        vp0[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
     fad:	vmulps ymm5,ymm2,ymm16
                        float s0l = p.SUB[rb[0]+xf+k], s0r = p.SUB[rb[0]+xf+k+3];
     fb3:	vcvtdq2ps ymm15,ymm15
     fb8:	vfmadd213ps ymm15,ymm0,YMMWORD PTR [rsi-0x60]
     fbe:	vfmadd213ps ymm24,ymm0,YMMWORD PTR [rsi-0x80]
     fc5:	vfmadd132ps ymm12,ymm4,ymm1
                        float s1l = p.SUB[rb[1]+xf+k], s1r = p.SUB[rb[1]+xf+k+3];
     fca:	vmovdqu ymm4,YMMWORD PTR [r8+rdi*1]
     fd0:	vfmadd132ps ymm14,ymm5,ymm1
                        vp0[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
     fd5:	vmulps ymm5,ymm2,ymm26
     fdb:	vfmadd132ps ymm22,ymm5,ymm1
                        float s1l = p.SUB[rb[1]+xf+k], s1r = p.SUB[rb[1]+xf+k+3];
     fe1:	vpmovzxbw ymm5,xmm4
     fe6:	vextracti32x4 xmm4,ymm4,0x1
     fed:	vpmovsxwd ymm31,xmm5
     ff3:	vextracti32x4 xmm21,ymm5,0x1
                        float s2l = p.SUB[rb[2]+xf+k], s2r = p.SUB[rb[2]+xf+k+3];
     ffa:	vmovdqu ymm5,YMMWORD PTR [r15+rdi*1]
                        float s1l = p.SUB[rb[1]+xf+k], s1r = p.SUB[rb[1]+xf+k+3];
    1000:	vpmovzxbw ymm4,xmm4
    1005:	vpmovsxwd ymm21,xmm21
    100b:	vpmovsxwd ymm28,xmm4
    1011:	vextracti32x4 xmm4,ymm4,0x1
    1018:	vcvtdq2ps ymm31,ymm31
                        float s2l = p.SUB[rb[2]+xf+k], s2r = p.SUB[rb[2]+xf+k+3];
    101e:	vpmovzxbw ymm6,xmm5
    1023:	vextracti32x4 xmm5,ymm5,0x1
                        float s1l = p.SUB[rb[1]+xf+k], s1r = p.SUB[rb[1]+xf+k+3];
    102a:	vcvtdq2ps ymm21,ymm21
    1030:	vpmovsxwd ymm4,xmm4
    1035:	vcvtdq2ps ymm28,ymm28
                        float s2l = p.SUB[rb[2]+xf+k], s2r = p.SUB[rb[2]+xf+k+3];
    103b:	vextracti32x4 xmm7,ymm6,0x1
    1042:	vpmovzxbw ymm5,xmm5
    1047:	vpmovsxwd ymm20,xmm6
                        float s1l = p.SUB[rb[1]+xf+k], s1r = p.SUB[rb[1]+xf+k+3];
    104d:	vcvtdq2ps ymm4,ymm4
                        float s2l = p.SUB[rb[2]+xf+k], s2r = p.SUB[rb[2]+xf+k+3];
    1051:	vpmovsxwd ymm7,xmm7
    1056:	vfmadd231ps ymm15,ymm3,ymm21
    105c:	vextracti32x4 xmm6,ymm5,0x1
    1063:	vcvtdq2ps ymm20,ymm20
    1069:	vcvtdq2ps ymm7,ymm7
                        vp1[xf+k] += p.A*s1l + p.B*s1r + p.C*s2l + p.D*s2r;
    106d:	vmulps ymm7,ymm7,ymm2
                        float s2l = p.SUB[rb[2]+xf+k], s2r = p.SUB[rb[2]+xf+k+3];
    1071:	vpmovsxwd ymm6,xmm6
    1076:	vpmovsxwd ymm19,xmm5
    107c:	vmovdqu ymm5,YMMWORD PTR [r11+rdi*1]
    1082:	vcvtdq2ps ymm6,ymm6
                        vp1[xf+k] += p.A*s1l + p.B*s1r + p.C*s2l + p.D*s2r;
    1086:	vmulps ymm6,ymm6,ymm2
    108a:	vfmadd231ps ymm24,ymm3,ymm31
                        float s2l = p.SUB[rb[2]+xf+k], s2r = p.SUB[rb[2]+xf+k+3];
    1090:	vcvtdq2ps ymm19,ymm19
    1096:	add    rdi,0x20
                        vp1[xf+k] += p.A*s1l + p.B*s1r + p.C*s2l + p.D*s2r;
    109a:	vmulps ymm20,ymm20,ymm2
                        float s2l = p.SUB[rb[2]+xf+k], s2r = p.SUB[rb[2]+xf+k+3];
    10a0:	vpmovzxbw ymm18,xmm5
    10a6:	vextracti32x4 xmm5,ymm5,0x1
                        vp1[xf+k] += p.A*s1l + p.B*s1r + p.C*s2l + p.D*s2r;
    10ad:	vmulps ymm19,ymm19,ymm2
                        float s2l = p.SUB[rb[2]+xf+k], s2r = p.SUB[rb[2]+xf+k+3];
    10b3:	vpmovzxbw ymm5,xmm5
                        vp0[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    10b8:	vaddps ymm14,ymm14,ymm15
    10bd:	vfmadd231ps ymm7,ymm1,ymm21
                        float s0l = p.SUB[rb[0]+xf+k], s0r = p.SUB[rb[0]+xf+k+3];
    10c3:	vpmovsxwd ymm21,xmm13
    10c9:	vextracti32x4 xmm13,ymm13,0x1
    10d0:	vpmovsxwd ymm13,xmm13
    10d5:	vcvtdq2ps ymm21,ymm21
    10db:	vfmadd213ps ymm21,ymm0,YMMWORD PTR [rsi-0x40]
                        vp0[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    10e2:	vaddps ymm23,ymm23,ymm24
                        float s0l = p.SUB[rb[0]+xf+k], s0r = p.SUB[rb[0]+xf+k+3];
    10e8:	vcvtdq2ps ymm13,ymm13
                        vp0[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    10ed:	vfmadd213ps ymm13,ymm0,YMMWORD PTR [rsi-0x20]
    10f3:	vfmadd231ps ymm6,ymm1,ymm4
    10f8:	vmovups YMMWORD PTR [rsi-0x60],ymm14
    10fd:	vfmadd231ps ymm20,ymm1,ymm31
    1103:	vfmadd231ps ymm19,ymm1,ymm28
    1109:	vmovups YMMWORD PTR [rsi-0x80],ymm23
    1110:	vfmadd231ps ymm21,ymm3,ymm28
    1116:	vfmadd132ps ymm4,ymm13,ymm3
    111b:	vaddps ymm22,ymm22,ymm21
    1121:	vaddps ymm4,ymm4,ymm12
    1126:	vmovups YMMWORD PTR [rsi-0x40],ymm22
    112d:	vmovups YMMWORD PTR [rsi-0x20],ymm4
                        float s2l = p.SUB[rb[2]+xf+k], s2r = p.SUB[rb[2]+xf+k+3];
    1132:	vpmovsxwd ymm4,xmm18
    1138:	vfmadd213ps ymm27,ymm0,YMMWORD PTR [rax-0x80]
    113f:	vfmadd213ps ymm16,ymm0,YMMWORD PTR [rax-0x60]
    1146:	vcvtdq2ps ymm4,ymm4
    114a:	vfmadd213ps ymm26,ymm0,YMMWORD PTR [rax-0x40]
                        vp1[xf+k] += p.A*s1l + p.B*s1r + p.C*s2l + p.D*s2r;
    1151:	vfmadd213ps ymm8,ymm0,YMMWORD PTR [rax-0x20]
    1157:	vfmadd231ps ymm27,ymm3,ymm4
                        float s2l = p.SUB[rb[2]+xf+k], s2r = p.SUB[rb[2]+xf+k+3];
    115d:	vextracti32x4 xmm4,ymm18,0x1
    1164:	vpmovsxwd ymm4,xmm4
    1169:	vcvtdq2ps ymm4,ymm4
    116d:	vfmadd231ps ymm16,ymm3,ymm4
    1173:	vpmovsxwd ymm4,xmm5
    1178:	vcvtdq2ps ymm4,ymm4
    117c:	vfmadd231ps ymm26,ymm3,ymm4
    1182:	vextracti32x4 xmm4,ymm5,0x1
    1189:	vpmovsxwd ymm4,xmm4
    118e:	vcvtdq2ps ymm4,ymm4
                        vp1[xf+k] += p.A*s1l + p.B*s1r + p.C*s2l + p.D*s2r;
    1192:	vfmadd132ps ymm4,ymm8,ymm3
    1197:	vaddps ymm20,ymm20,ymm27
    119d:	vaddps ymm7,ymm7,ymm16
    11a3:	vaddps ymm19,ymm19,ymm26
    11a9:	vmovups YMMWORD PTR [rax-0x80],ymm20
    11b0:	vaddps ymm4,ymm4,ymm6
    11b4:	vmovups YMMWORD PTR [rax-0x60],ymm7
    11b9:	vmovups YMMWORD PTR [rax-0x40],ymm19
    11c0:	vmovups YMMWORD PTR [rax-0x20],ymm4
                    for (int k = 0; k < x_floats - xf; ++k) {
    11c5:	cmp    rdi,rbx
    11c8:	jne    ec0 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0xec0>
    11ce:	mov    r10d,DWORD PTR [rsp+0x170]
    11d6:	vmovss xmm4,DWORD PTR [rsp+0x130]
    11df:	mov    QWORD PTR [rsp+0x1d0],r12
    11e7:	vmovss xmm5,DWORD PTR [rsp+0x110]
    11f0:	vmovss xmm6,DWORD PTR [rsp+0x100]
    11f9:	shl    r10d,0x5
    11fd:	vmovss xmm7,DWORD PTR [rsp+0xfc]
    1206:	mov    ebx,DWORD PTR [rsp+0xf0]
    120d:	cmp    r10d,DWORD PTR [rsp+0x1a8]
    1215:	je     1ff8 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x1ff8>
    121b:	mov    r8d,r10d
    121e:	mov    r14d,DWORD PTR [rsp+0x1a8]
    1226:	sub    r14d,r10d
    1229:	lea    eax,[r14-0x1]
    122d:	cmp    eax,0xe
    1230:	jbe    3291 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x3291>
    1236:	mov    rdi,QWORD PTR [rsp+0x1c8]
    123e:	mov    eax,r10d
    1241:	mov    rsi,QWORD PTR [rsp+0x1b8]
    1249:	vmovaps xmm16,xmm17
    124f:	mov    r13,QWORD PTR [rsp+0x1c0]
    1257:	mov    r15,QWORD PTR [rsp+0xe8]
    125f:	lea    r11,[rax+rdi*1]
    1263:	mov    rdi,QWORD PTR [rsp+0x180]
    126b:	add    rsi,rax
    126e:	add    r13,rax
    1271:	add    rdi,rax
    1274:	add    rax,QWORD PTR [rsp+0x190]
    127c:	lea    rax,[r15+rax*4]
                        float s0l = p.SUB[rb[0]+xf+k], s0r = p.SUB[rb[0]+xf+k+3];
    1280:	lea    rdi,[r15+rdi*4]
    1284:	mov    r15,QWORD PTR [rsp+0x1b0]
                        float s1l = p.SUB[rb[1]+xf+k], s1r = p.SUB[rb[1]+xf+k+3];
    128c:	vmovdqu xmm12,XMMWORD PTR [r15+r11*1]
                        float s0l = p.SUB[rb[0]+xf+k], s0r = p.SUB[rb[0]+xf+k+3];
    1292:	vmovdqu xmm8,XMMWORD PTR [r15+rsi*1]
                        float s1l = p.SUB[rb[1]+xf+k], s1r = p.SUB[rb[1]+xf+k+3];
    1298:	vpmovzxbw xmm15,xmm12
    129d:	vpsrldq xmm12,xmm12,0x8
                        float s0l = p.SUB[rb[0]+xf+k], s0r = p.SUB[rb[0]+xf+k+3];
    12a3:	vpmovzxbw xmm18,xmm8
                        float s1l = p.SUB[rb[1]+xf+k], s1r = p.SUB[rb[1]+xf+k+3];
    12a9:	vpmovsxwd xmm26,xmm15
                        float s0l = p.SUB[rb[0]+xf+k], s0r = p.SUB[rb[0]+xf+k+3];
    12af:	vpsrldq xmm8,xmm8,0x8
                        float s1l = p.SUB[rb[1]+xf+k], s1r = p.SUB[rb[1]+xf+k+3];
    12b5:	vpmovzxbw xmm12,xmm12
    12ba:	vpsrldq xmm19,xmm15,0x8
    12c1:	vcvtdq2ps xmm26,xmm26
                        float s0l = p.SUB[rb[0]+xf+k], s0r = p.SUB[rb[0]+xf+k+3];
    12c7:	vpmovzxbw xmm14,xmm8
    12cc:	vmovdqu xmm8,XMMWORD PTR [r15+rsi*1+0x3]
                        float s1l = p.SUB[rb[1]+xf+k], s1r = p.SUB[rb[1]+xf+k+3];
    12d3:	vpmovsxwd xmm24,xmm12
                        vp0[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    12d9:	vmulps xmm15,xmm26,xmm25
                        float s1l = p.SUB[rb[1]+xf+k], s1r = p.SUB[rb[1]+xf+k+3];
    12df:	vcvtdq2ps xmm24,xmm24
    12e5:	vpsrldq xmm12,xmm12,0x8
    12eb:	vpmovsxwd xmm19,xmm19
                        float s0l = p.SUB[rb[0]+xf+k], s0r = p.SUB[rb[0]+xf+k+3];
    12f1:	vpmovzxbw xmm13,xmm8
                        float s1l = p.SUB[rb[1]+xf+k], s1r = p.SUB[rb[1]+xf+k+3];
    12f6:	vcvtdq2ps xmm19,xmm19
                        float s0l = p.SUB[rb[0]+xf+k], s0r = p.SUB[rb[0]+xf+k+3];
    12fc:	vpsrldq xmm8,xmm8,0x8
                        float s1l = p.SUB[rb[1]+xf+k], s1r = p.SUB[rb[1]+xf+k+3];
    1302:	vpmovsxwd xmm12,xmm12
                        float s0l = p.SUB[rb[0]+xf+k], s0r = p.SUB[rb[0]+xf+k+3];
    1307:	vpmovsxwd xmm23,xmm13
    130d:	vpsrldq xmm13,xmm13,0x8
    1313:	vpmovzxbw xmm8,xmm8
                        float s1l = p.SUB[rb[1]+xf+k], s1r = p.SUB[rb[1]+xf+k+3];
    1318:	vcvtdq2ps xmm12,xmm12
                        float s0l = p.SUB[rb[0]+xf+k], s0r = p.SUB[rb[0]+xf+k+3];
    131d:	vcvtdq2ps xmm23,xmm23
    1323:	vpmovsxwd xmm13,xmm13
    1328:	vcvtdq2ps xmm13,xmm13
    132d:	vfmadd132ps xmm23,xmm15,xmm17
                        vp0[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    1333:	vmulps xmm15,xmm19,xmm25
    1339:	vfmadd132ps xmm13,xmm15,xmm17
    133f:	vmulps xmm15,xmm24,xmm25
    1345:	vmovaps XMMWORD PTR [rsp+0x110],xmm13
                        float s0l = p.SUB[rb[0]+xf+k], s0r = p.SUB[rb[0]+xf+k+3];
    134e:	vpmovsxwd xmm13,xmm8
    1353:	vcvtdq2ps xmm28,xmm13
    1359:	vpsrldq xmm13,xmm8,0x8
    135f:	vfmadd132ps xmm28,xmm15,xmm17
                        float s2l = p.SUB[rb[2]+xf+k], s2r = p.SUB[rb[2]+xf+k+3];
    1365:	vmovdqu xmm15,XMMWORD PTR [r15+r13*1]
                        vp0[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    136b:	vmulps xmm8,xmm12,xmm25
                        float s0l = p.SUB[rb[0]+xf+k], s0r = p.SUB[rb[0]+xf+k+3];
    1371:	vpmovsxwd xmm13,xmm13
                        float s2l = p.SUB[rb[2]+xf+k], s2r = p.SUB[rb[2]+xf+k+3];
    1376:	vpmovzxbw xmm21,xmm15
                        float s0l = p.SUB[rb[0]+xf+k], s0r = p.SUB[rb[0]+xf+k+3];
    137c:	vcvtdq2ps xmm13,xmm13
                        float s2l = p.SUB[rb[2]+xf+k], s2r = p.SUB[rb[2]+xf+k+3];
    1381:	vpsrldq xmm15,xmm15,0x8
    1387:	vpmovsxwd xmm31,xmm21
    138d:	vpsrldq xmm21,xmm21,0x8
    1394:	vpmovzxbw xmm15,xmm15
    1399:	vcvtdq2ps xmm31,xmm31
                        vp1[xf+k] += p.A*s1l + p.B*s1r + p.C*s2l + p.D*s2r;
    139f:	vmulps xmm31,xmm31,xmm25
                        float s2l = p.SUB[rb[2]+xf+k], s2r = p.SUB[rb[2]+xf+k+3];
    13a5:	vpmovsxwd xmm21,xmm21
    13ab:	vmovaps XMMWORD PTR [rsp+0x130],xmm28
    13b3:	vcvtdq2ps xmm21,xmm21
                        vp1[xf+k] += p.A*s1l + p.B*s1r + p.C*s2l + p.D*s2r;
    13b9:	vmulps xmm21,xmm21,xmm25
    13bf:	vfmadd132ps xmm13,xmm8,xmm17
                        float s1l = p.SUB[rb[1]+xf+k], s1r = p.SUB[rb[1]+xf+k+3];
    13c5:	vmovdqu xmm8,XMMWORD PTR [r15+r11*1+0x3]
    13cc:	vpmovzxbw xmm22,xmm8
    13d2:	vpsrldq xmm8,xmm8,0x8
    13d8:	vpmovsxwd xmm28,xmm22
    13de:	vpsrldq xmm22,xmm22,0x8
    13e5:	vpmovzxbw xmm8,xmm8
    13ea:	vcvtdq2ps xmm28,xmm28
    13f0:	vfmadd231ps xmm31,xmm17,xmm28
    13f6:	vpmovsxwd xmm22,xmm22
    13fc:	vpmovsxwd xmm27,xmm8
    1402:	vcvtdq2ps xmm22,xmm22
    1408:	vfmadd231ps xmm21,xmm17,xmm22
    140e:	vpsrldq xmm8,xmm8,0x8
    1414:	vcvtdq2ps xmm27,xmm27
    141a:	vpmovsxwd xmm8,xmm8
    141f:	vcvtdq2ps xmm8,xmm8
                        float s2l = p.SUB[rb[2]+xf+k], s2r = p.SUB[rb[2]+xf+k+3];
    1424:	vmovaps XMMWORD PTR [rsp+0x140],xmm31
                        float s0l = p.SUB[rb[0]+xf+k], s0r = p.SUB[rb[0]+xf+k+3];
    142c:	vpmovsxwd xmm31,xmm18
    1432:	vpsrldq xmm18,xmm18,0x8
    1439:	vpmovsxwd xmm18,xmm18
    143f:	vmovaps XMMWORD PTR [rsp+0x150],xmm21
                        float s2l = p.SUB[rb[2]+xf+k], s2r = p.SUB[rb[2]+xf+k+3];
    1447:	vpmovsxwd xmm21,xmm15
                        float s0l = p.SUB[rb[0]+xf+k], s0r = p.SUB[rb[0]+xf+k+3];
    144d:	vcvtdq2ps xmm31,xmm31
    1453:	vcvtdq2ps xmm18,xmm18
    1459:	vfmadd213ps xmm18,xmm9,XMMWORD PTR [rdi+0x10]
                        float s2l = p.SUB[rb[2]+xf+k], s2r = p.SUB[rb[2]+xf+k+3];
    1460:	vpsrldq xmm15,xmm15,0x8
    1466:	vcvtdq2ps xmm21,xmm21
                        vp1[xf+k] += p.A*s1l + p.B*s1r + p.C*s2l + p.D*s2r;
    146c:	vmulps xmm21,xmm21,xmm25
    1472:	vfmadd213ps xmm31,xmm9,XMMWORD PTR [rdi]
                        float s2l = p.SUB[rb[2]+xf+k], s2r = p.SUB[rb[2]+xf+k+3];
    1478:	vpmovsxwd xmm15,xmm15
    147d:	vcvtdq2ps xmm15,xmm15
                        vp1[xf+k] += p.A*s1l + p.B*s1r + p.C*s2l + p.D*s2r;
    1482:	vmulps xmm15,xmm15,xmm25
    1488:	vfmadd231ps xmm18,xmm22,xmm11
                        float s0l = p.SUB[rb[0]+xf+k], s0r = p.SUB[rb[0]+xf+k+3];
    148e:	vpmovsxwd xmm22,xmm14
    1494:	vpsrldq xmm14,xmm14,0x8
    149a:	vcvtdq2ps xmm22,xmm22
    14a0:	vfmadd213ps xmm22,xmm9,XMMWORD PTR [rdi+0x20]
    14a7:	vfmadd132ps xmm16,xmm15,xmm8
    14ad:	vfmadd231ps xmm31,xmm28,xmm11
    14b3:	vpmovsxwd xmm14,xmm14
                        float s2l = p.SUB[rb[2]+xf+k], s2r = p.SUB[rb[2]+xf+k+3];
    14b8:	vmovdqu xmm15,XMMWORD PTR [r15+r13*1+0x3]
                        float s0l = p.SUB[rb[0]+xf+k], s0r = p.SUB[rb[0]+xf+k+3];
    14bf:	vcvtdq2ps xmm14,xmm14
                        vp0[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    14c4:	vfmadd213ps xmm14,xmm9,XMMWORD PTR [rdi+0x30]
    14ca:	vfmadd231ps xmm21,xmm17,xmm27
                        float s2l = p.SUB[rb[2]+xf+k], s2r = p.SUB[rb[2]+xf+k+3];
    14d0:	vpmovzxbw xmm20,xmm15
    14d6:	vpsrldq xmm15,xmm15,0x8
    14dc:	vfmadd231ps xmm22,xmm27,xmm11
                        vp0[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    14e2:	vaddps xmm23,xmm23,xmm31
    14e8:	vmovaps XMMWORD PTR [rsp+0x100],xmm16
                        float s2l = p.SUB[rb[2]+xf+k], s2r = p.SUB[rb[2]+xf+k+3];
    14f0:	vpmovzxbw xmm16,xmm15
                        vp0[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    14f6:	vfmadd132ps xmm8,xmm14,xmm11
                        float s2l = p.SUB[rb[2]+xf+k], s2r = p.SUB[rb[2]+xf+k+3];
    14fb:	vpmovsxwd xmm14,xmm20
    1501:	vmovaps XMMWORD PTR [rsp+0x170],xmm21
    1509:	vcvtdq2ps xmm14,xmm14
                        vp0[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    150e:	vmovups XMMWORD PTR [rdi],xmm23
    1514:	vaddps xmm8,xmm8,xmm13
    1519:	vaddps xmm13,xmm18,XMMWORD PTR [rsp+0x110]
                        float s2l = p.SUB[rb[2]+xf+k], s2r = p.SUB[rb[2]+xf+k+3];
    1521:	vpmovsxwd xmm18,xmm16
    1527:	vcvtdq2ps xmm18,xmm18
                        vp0[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    152d:	vmovups XMMWORD PTR [rdi+0x10],xmm13
    1532:	vaddps xmm13,xmm22,XMMWORD PTR [rsp+0x130]
    153a:	vmovups XMMWORD PTR [rdi+0x30],xmm8
                        float s2l = p.SUB[rb[2]+xf+k], s2r = p.SUB[rb[2]+xf+k+3];
    153f:	vpsrldq xmm8,xmm16,0x8
    1546:	vpmovsxwd xmm8,xmm8
                        vp0[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    154b:	vmovups XMMWORD PTR [rdi+0x20],xmm13
                        float s2l = p.SUB[rb[2]+xf+k], s2r = p.SUB[rb[2]+xf+k+3];
    1550:	vpsrldq xmm13,xmm20,0x8
    1557:	vcvtdq2ps xmm8,xmm8
    155c:	vfmadd213ps xmm26,xmm9,XMMWORD PTR [rax]
    1562:	vfmadd213ps xmm19,xmm9,XMMWORD PTR [rax+0x10]
    1569:	vpmovsxwd xmm13,xmm13
    156e:	vfmadd213ps xmm24,xmm9,XMMWORD PTR [rax+0x20]
                        vp1[xf+k] += p.A*s1l + p.B*s1r + p.C*s2l + p.D*s2r;
    1575:	vfmadd213ps xmm12,xmm9,XMMWORD PTR [rax+0x30]
                        float s2l = p.SUB[rb[2]+xf+k], s2r = p.SUB[rb[2]+xf+k+3];
    157b:	vcvtdq2ps xmm13,xmm13
    1580:	vfmadd132ps xmm14,xmm26,xmm11
    1586:	vfmadd132ps xmm13,xmm19,xmm11
                        vp1[xf+k] += p.A*s1l + p.B*s1r + p.C*s2l + p.D*s2r;
    158c:	vfmadd132ps xmm8,xmm12,xmm11
    1591:	vfmadd132ps xmm18,xmm24,xmm11
    1597:	vaddps xmm12,xmm14,XMMWORD PTR [rsp+0x140]
    15a0:	vaddps xmm8,xmm8,XMMWORD PTR [rsp+0x100]
    15a9:	vmovups XMMWORD PTR [rax],xmm12
    15ad:	vaddps xmm12,xmm13,XMMWORD PTR [rsp+0x150]
    15b6:	vmovups XMMWORD PTR [rax+0x30],xmm8
    15bb:	vmovups XMMWORD PTR [rax+0x10],xmm12
    15c0:	vaddps xmm12,xmm18,XMMWORD PTR [rsp+0x170]
    15c8:	vmovups XMMWORD PTR [rax+0x20],xmm12
    15cd:	mov    eax,r14d
    15d0:	and    eax,0xfffffff0
    15d3:	test   r14b,0xf
    15d7:	je     1ff8 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x1ff8>
    15dd:	add    r8d,eax
    15e0:	mov    r15d,r14d
    15e3:	sub    r15d,eax
    15e6:	lea    esi,[r15-0x1]
    15ea:	cmp    esi,0x6
    15ed:	jbe    1a63 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x1a63>
    15f3:	mov    rsi,QWORD PTR [rsp+0x1c8]
    15fb:	mov    rdi,QWORD PTR [rsp+0x1b8]
    1603:	add    eax,r10d
    1606:	vmovaps xmm16,xmm17
    160c:	mov    eax,eax
    160e:	mov    r11,QWORD PTR [rsp+0x190]
    1616:	mov    r14,QWORD PTR [rsp+0x1c0]
    161e:	lea    r13,[rsi+rax*1]
    1622:	lea    rsi,[rdi+rax*1]
    1626:	mov    rdi,QWORD PTR [rsp+0x180]
    162e:	mov    r10,QWORD PTR [rsp+0xe8]
    1636:	add    r14,rax
    1639:	add    rdi,rax
    163c:	add    rax,r11
    163f:	lea    rax,[r10+rax*4]
                        float s0l = p.SUB[rb[0]+xf+k], s0r = p.SUB[rb[0]+xf+k+3];
    1643:	lea    rdi,[r10+rdi*4]
    1647:	mov    r10,QWORD PTR [rsp+0x1b0]
    164f:	vmovq  xmm8,QWORD PTR [r10+rsi*1]
                        float s1l = p.SUB[rb[1]+xf+k], s1r = p.SUB[rb[1]+xf+k+3];
    1655:	vmovq  xmm12,QWORD PTR [r10+r13*1]
                        float s0l = p.SUB[rb[0]+xf+k], s0r = p.SUB[rb[0]+xf+k+3];
    165b:	vpmovzxbw xmm15,xmm8
    1660:	vpsrlq xmm8,xmm8,0x20
                        float s1l = p.SUB[rb[1]+xf+k], s1r = p.SUB[rb[1]+xf+k+3];
    1666:	vpmovzxbw xmm14,xmm12
                        float s0l = p.SUB[rb[0]+xf+k], s0r = p.SUB[rb[0]+xf+k+3];
    166b:	vmovq  r12,xmm15
                        float s1l = p.SUB[rb[1]+xf+k], s1r = p.SUB[rb[1]+xf+k+3];
    1670:	vpsrlq xmm12,xmm12,0x20
                        float s0l = p.SUB[rb[0]+xf+k], s0r = p.SUB[rb[0]+xf+k+3];
    1676:	vpmovzxbw xmm15,xmm8
    167b:	vmovq  xmm8,QWORD PTR [r10+rsi*1+0x3]
    1682:	vmovq  r11,xmm15
                        float s1l = p.SUB[rb[1]+xf+k], s1r = p.SUB[rb[1]+xf+k+3];
    1687:	vpmovzxwd xmm15,xmm14
    168c:	vpmovzxbw xmm12,xmm12
    1691:	vpsrlq xmm14,xmm14,0x20
    1697:	vmovq  xmm15,xmm15
                        float s0l = p.SUB[rb[0]+xf+k], s0r = p.SUB[rb[0]+xf+k+3];
    169c:	vpmovzxbw xmm13,xmm8
                        float s1l = p.SUB[rb[1]+xf+k], s1r = p.SUB[rb[1]+xf+k+3];
    16a1:	vpmovzxwd xmm14,xmm14
    16a6:	vcvtdq2ps xmm21,xmm15
                        float s0l = p.SUB[rb[0]+xf+k], s0r = p.SUB[rb[0]+xf+k+3];
    16ac:	vpsrlq xmm8,xmm8,0x20
                        vp0[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    16b2:	vmulps xmm20,xmm25,xmm21
                        float s1l = p.SUB[rb[1]+xf+k], s1r = p.SUB[rb[1]+xf+k+3];
    16b8:	vmovq  xmm14,xmm14
                        float s0l = p.SUB[rb[0]+xf+k], s0r = p.SUB[rb[0]+xf+k+3];
    16bd:	vpmovzxbw xmm8,xmm8
                        float s1l = p.SUB[rb[1]+xf+k], s1r = p.SUB[rb[1]+xf+k+3];
    16c2:	vcvtdq2ps xmm15,xmm14
    16c7:	vpmovzxwd xmm14,xmm12
    16cc:	vpsrlq xmm12,xmm12,0x20
    16d2:	vmovq  xmm14,xmm14
    16d7:	vpmovzxwd xmm12,xmm12
    16dc:	vcvtdq2ps xmm19,xmm14
                        float s0l = p.SUB[rb[0]+xf+k], s0r = p.SUB[rb[0]+xf+k+3];
    16e2:	vpmovzxwd xmm14,xmm13
    16e7:	vpsrlq xmm13,xmm13,0x20
                        float s1l = p.SUB[rb[1]+xf+k], s1r = p.SUB[rb[1]+xf+k+3];
    16ed:	vmovq  xmm12,xmm12
                        float s0l = p.SUB[rb[0]+xf+k], s0r = p.SUB[rb[0]+xf+k+3];
    16f2:	vmovq  xmm14,xmm14
    16f7:	vpmovzxwd xmm13,xmm13
                        float s1l = p.SUB[rb[1]+xf+k], s1r = p.SUB[rb[1]+xf+k+3];
    16fc:	vcvtdq2ps xmm12,xmm12
                        float s0l = p.SUB[rb[0]+xf+k], s0r = p.SUB[rb[0]+xf+k+3];
    1701:	vcvtdq2ps xmm14,xmm14
    1706:	vfmadd132ps xmm14,xmm20,xmm17
    170c:	vmovq  xmm13,xmm13
    1711:	vcvtdq2ps xmm13,xmm13
    1716:	vmovaps xmm27,xmm14
                        vp0[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    171c:	vmulps xmm14,xmm25,xmm15
    1722:	vfmadd132ps xmm13,xmm14,xmm17
    1728:	vmulps xmm14,xmm25,xmm19
    172e:	vmovaps xmm28,xmm13
                        float s0l = p.SUB[rb[0]+xf+k], s0r = p.SUB[rb[0]+xf+k+3];
    1734:	vpmovzxwd xmm13,xmm8
    1739:	vmovq  xmm13,xmm13
    173e:	vpsrlq xmm8,xmm8,0x20
    1744:	vcvtdq2ps xmm13,xmm13
    1749:	vfmadd132ps xmm13,xmm14,xmm17
    174f:	vpmovzxwd xmm8,xmm8
    1754:	vmovq  xmm8,xmm8
    1759:	vcvtdq2ps xmm8,xmm8
    175e:	vmovaps xmm31,xmm13
                        vp0[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    1764:	vmulps xmm13,xmm25,xmm12
    176a:	vfmadd132ps xmm8,xmm13,xmm17
    1770:	vmovaps xmm26,xmm8
                        float s1l = p.SUB[rb[1]+xf+k], s1r = p.SUB[rb[1]+xf+k+3];
    1776:	vmovq  xmm8,QWORD PTR [r10+r13*1+0x3]
                        float s2l = p.SUB[rb[2]+xf+k], s2r = p.SUB[rb[2]+xf+k+3];
    177d:	mov    r13,r10
                        float s1l = p.SUB[rb[1]+xf+k], s1r = p.SUB[rb[1]+xf+k+3];
    1780:	vpmovzxbw xmm13,xmm8
    1785:	vpsrlq xmm8,xmm8,0x20
    178b:	vpmovzxwd xmm14,xmm13
    1790:	vpsrlq xmm13,xmm13,0x20
    1796:	vpmovzxbw xmm8,xmm8
    179b:	vpmovzxwd xmm13,xmm13
    17a0:	vmovq  xmm14,xmm14
    17a5:	vmovq  xmm13,xmm13
    17aa:	vcvtdq2ps xmm14,xmm14
    17af:	vcvtdq2ps xmm23,xmm13
    17b5:	vpmovzxwd xmm13,xmm8
    17ba:	vpsrlq xmm8,xmm8,0x20
    17c0:	vpmovzxwd xmm8,xmm8
    17c5:	vmovq  xmm13,xmm13
    17ca:	vmovq  xmm8,xmm8
    17cf:	vcvtdq2ps xmm24,xmm13
    17d5:	vcvtdq2ps xmm22,xmm8
                        float s2l = p.SUB[rb[2]+xf+k], s2r = p.SUB[rb[2]+xf+k+3];
    17db:	vmovq  xmm8,QWORD PTR [r10+r14*1]
    17e1:	vpmovzxbw xmm13,xmm8
    17e6:	vpsrlq xmm8,xmm8,0x20
    17ec:	vpmovzxbw xmm8,xmm8
    17f1:	vmovq  r10,xmm8
    17f6:	vpmovzxwd xmm8,xmm13
    17fb:	vpsrlq xmm13,xmm13,0x20
    1801:	vmovq  xmm20,xmm8
    1807:	vmovq  xmm8,r10
    180c:	vpmovzxwd xmm13,xmm13
    1811:	vcvtdq2ps xmm20,xmm20
                        vp1[xf+k] += p.A*s1l + p.B*s1r + p.C*s2l + p.D*s2r;
    1817:	vmulps xmm20,xmm20,xmm25
                        float s2l = p.SUB[rb[2]+xf+k], s2r = p.SUB[rb[2]+xf+k+3];
    181d:	vmovq  xmm13,xmm13
    1822:	vcvtdq2ps xmm13,xmm13
                        vp1[xf+k] += p.A*s1l + p.B*s1r + p.C*s2l + p.D*s2r;
    1827:	vmulps xmm13,xmm13,xmm25
    182d:	vfmadd231ps xmm20,xmm14,xmm17
    1833:	vfmadd231ps xmm13,xmm23,xmm17
    1839:	vmovaps XMMWORD PTR [rsp+0x190],xmm20
    1841:	vmovaps XMMWORD PTR [rsp+0x180],xmm13
                        float s2l = p.SUB[rb[2]+xf+k], s2r = p.SUB[rb[2]+xf+k+3];
    184a:	vpmovzxwd xmm13,xmm8
    184f:	vpsrlq xmm8,xmm8,0x20
    1855:	vmovq  xmm13,xmm13
    185a:	vpmovzxwd xmm8,xmm8
    185f:	vcvtdq2ps xmm13,xmm13
                        vp1[xf+k] += p.A*s1l + p.B*s1r + p.C*s2l + p.D*s2r;
    1864:	vmulps xmm13,xmm13,xmm25
                        float s2l = p.SUB[rb[2]+xf+k], s2r = p.SUB[rb[2]+xf+k+3];
    186a:	vmovq  xmm8,xmm8
    186f:	vcvtdq2ps xmm8,xmm8
                        vp1[xf+k] += p.A*s1l + p.B*s1r + p.C*s2l + p.D*s2r;
    1874:	vmulps xmm8,xmm8,xmm25
    187a:	vfmadd231ps xmm13,xmm24,xmm17
    1880:	vfmadd132ps xmm16,xmm8,xmm22
                        float s2l = p.SUB[rb[2]+xf+k], s2r = p.SUB[rb[2]+xf+k+3];
    1886:	vmovq  xmm8,QWORD PTR [r13+r14*1+0x3]
    188d:	vmovaps XMMWORD PTR [rsp+0x170],xmm13
    1896:	vpmovzxbw xmm13,xmm8
    189b:	vpsrlq xmm8,xmm8,0x20
    18a1:	vpmovzxbw xmm8,xmm8
    18a6:	vmovq  rsi,xmm13
    18ab:	vmovq  r13,xmm8
                        float s0l = p.SUB[rb[0]+xf+k], s0r = p.SUB[rb[0]+xf+k+3];
    18b0:	vmovq  xmm8,r12
    18b5:	vpmovzxwd xmm8,xmm8
    18ba:	vmovq  xmm8,xmm8
    18bf:	vcvtdq2ps xmm13,xmm8
                        vp0[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    18c4:	vmovq  xmm8,QWORD PTR [rdi]
    18c8:	vfmadd231ps xmm8,xmm9,xmm13
    18cd:	vfmadd132ps xmm14,xmm8,xmm11
                        float s0l = p.SUB[rb[0]+xf+k], s0r = p.SUB[rb[0]+xf+k+3];
    18d2:	vmovq  xmm8,r12
    18d7:	vpsrlq xmm8,xmm8,0x20
    18dd:	vpmovzxwd xmm8,xmm8
    18e2:	vmovq  xmm8,xmm8
    18e7:	vcvtdq2ps xmm13,xmm8
                        vp0[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    18ec:	vmovq  xmm8,QWORD PTR [rdi+0x8]
    18f1:	vaddps xmm14,xmm27,xmm14
    18f7:	vfmadd132ps xmm13,xmm8,xmm9
                        float s0l = p.SUB[rb[0]+xf+k], s0r = p.SUB[rb[0]+xf+k+3];
    18fc:	vmovq  xmm8,r11
    1901:	vpmovzxwd xmm8,xmm8
    1906:	vmovq  xmm8,xmm8
                        vp0[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    190b:	vmovlps QWORD PTR [rdi],xmm14
                        float s2l = p.SUB[rb[2]+xf+k], s2r = p.SUB[rb[2]+xf+k+3];
    190f:	vmovq  xmm14,rsi
    1914:	vfmadd231ps xmm13,xmm11,xmm23
                        float s0l = p.SUB[rb[0]+xf+k], s0r = p.SUB[rb[0]+xf+k+3];
    191a:	vcvtdq2ps xmm23,xmm8
                        vp0[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    1920:	vmovq  xmm8,QWORD PTR [rdi+0x10]
    1925:	vfmadd132ps xmm23,xmm8,xmm9
                        float s0l = p.SUB[rb[0]+xf+k], s0r = p.SUB[rb[0]+xf+k+3];
    192b:	vmovq  xmm8,r11
    1930:	vpsrlq xmm8,xmm8,0x20
    1936:	vpmovzxwd xmm8,xmm8
    193b:	vmovq  xmm8,xmm8
                        vp0[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    1940:	vaddps xmm13,xmm28,xmm13
    1946:	vfmadd231ps xmm23,xmm11,xmm24
                        float s0l = p.SUB[rb[0]+xf+k], s0r = p.SUB[rb[0]+xf+k+3];
    194c:	vcvtdq2ps xmm24,xmm8
                        vp0[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    1952:	vmovq  xmm8,QWORD PTR [rdi+0x18]
    1957:	vmovlps QWORD PTR [rdi+0x8],xmm13
    195c:	vfmadd132ps xmm24,xmm8,xmm9
    1962:	vmovaps xmm8,xmm22
    1968:	vaddps xmm13,xmm31,xmm23
    196e:	vfmadd132ps xmm8,xmm24,xmm11
    1974:	vmovlps QWORD PTR [rdi+0x10],xmm13
                        float s2l = p.SUB[rb[2]+xf+k], s2r = p.SUB[rb[2]+xf+k+3];
    1979:	vpmovzxwd xmm13,xmm14
    197e:	vmovq  xmm13,xmm13
    1983:	vcvtdq2ps xmm13,xmm13
                        vp0[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    1988:	vaddps xmm8,xmm8,xmm26
    198e:	vmovlps QWORD PTR [rdi+0x18],xmm8
                        vp1[xf+k] += p.A*s1l + p.B*s1r + p.C*s2l + p.D*s2r;
    1993:	vmovq  xmm8,QWORD PTR [rax]
    1997:	vfmadd132ps xmm21,xmm8,xmm9
                        float s2l = p.SUB[rb[2]+xf+k], s2r = p.SUB[rb[2]+xf+k+3];
    199d:	vpsrlq xmm8,xmm14,0x20
    19a3:	vpmovzxwd xmm8,xmm8
    19a8:	vmovq  xmm14,xmm8
                        vp1[xf+k] += p.A*s1l + p.B*s1r + p.C*s2l + p.D*s2r;
    19ad:	vmovq  xmm8,QWORD PTR [rax+0x8]
                        float s2l = p.SUB[rb[2]+xf+k], s2r = p.SUB[rb[2]+xf+k+3];
    19b2:	vcvtdq2ps xmm14,xmm14
    19b7:	vfmadd132ps xmm15,xmm8,xmm9
                        vp1[xf+k] += p.A*s1l + p.B*s1r + p.C*s2l + p.D*s2r;
    19bc:	vmovq  xmm8,QWORD PTR [rax+0x10]
    19c1:	vfmadd132ps xmm13,xmm21,xmm11
    19c7:	vfmadd132ps xmm19,xmm8,xmm9
                        float s2l = p.SUB[rb[2]+xf+k], s2r = p.SUB[rb[2]+xf+k+3];
    19cd:	vmovq  xmm8,r13
    19d2:	vpsrlq xmm8,xmm8,0x20
    19d8:	vpmovzxwd xmm8,xmm8
    19dd:	vfmadd132ps xmm14,xmm15,xmm11
    19e2:	vmovq  xmm15,r13
    19e7:	vmovq  xmm8,xmm8
    19ec:	vpmovzxwd xmm15,xmm15
                        vp1[xf+k] += p.A*s1l + p.B*s1r + p.C*s2l + p.D*s2r;
    19f1:	vaddps xmm13,xmm13,XMMWORD PTR [rsp+0x190]
                        float s2l = p.SUB[rb[2]+xf+k], s2r = p.SUB[rb[2]+xf+k+3];
    19fa:	vmovq  xmm15,xmm15
    19ff:	vcvtdq2ps xmm15,xmm15
    1a04:	vfmadd132ps xmm15,xmm19,xmm11
    1a0a:	vcvtdq2ps xmm19,xmm8
                        vp1[xf+k] += p.A*s1l + p.B*s1r + p.C*s2l + p.D*s2r;
    1a10:	vmovq  xmm8,QWORD PTR [rax+0x18]
    1a15:	vmovlps QWORD PTR [rax],xmm13
    1a19:	vfmadd132ps xmm12,xmm8,xmm9
    1a1e:	vmovaps xmm8,xmm11
    1a23:	vaddps xmm14,xmm14,XMMWORD PTR [rsp+0x180]
    1a2c:	vmovlps QWORD PTR [rax+0x8],xmm14
    1a31:	vfmadd132ps xmm8,xmm12,xmm19
    1a37:	vaddps xmm12,xmm15,XMMWORD PTR [rsp+0x170]
    1a40:	vmovlps QWORD PTR [rax+0x10],xmm12
    1a45:	vaddps xmm8,xmm8,xmm16
    1a4b:	vmovlps QWORD PTR [rax+0x18],xmm8
                    for (int k = 0; k < x_floats - xf; ++k) {
    1a50:	mov    eax,r15d
    1a53:	and    eax,0xfffffff8
    1a56:	and    r15d,0x7
    1a5a:	je     1ff8 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x1ff8>
    1a60:	add    r8d,eax
    1a63:	mov    esi,DWORD PTR [rsp+0x1a8]
    1a6a:	lea    r10d,[r8+0x1]
    1a6e:	lea    eax,[rsi-0x2]
    1a71:	mov    DWORD PTR [rsp+0x130],eax
    1a78:	cmp    eax,r10d
    1a7b:	jle    1d9b <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x1d9b>
    1a81:	cmp    esi,r8d
    1a84:	jle    1d9b <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x1d9b>
    1a8a:	mov    r15,QWORD PTR [rsp+0x1b0]
    1a92:	mov    r14,QWORD PTR [rsp+0x1c8]
    1a9a:	movsxd rax,r8d
    1a9d:	mov    QWORD PTR [rsp+0xf0],rdx
    1aa5:	mov    r13,QWORD PTR [rsp+0x1c0]
    1aad:	mov    r12,QWORD PTR [rsp+0x1b8]
    1ab5:	mov    QWORD PTR [rsp+0xa0],rcx
    1abd:	lea    r10,[rax+r14*1]
    1ac1:	add    r14,r15
    1ac4:	mov    rsi,QWORD PTR [rsp+0x160]
    1acc:	mov    DWORD PTR [rsp+0xfc],ebx
    1ad3:	lea    r11,[rax+r12*1]
    1ad7:	mov    QWORD PTR [rsp+0x150],r14
    1adf:	lea    r14,[r15+r12*1]
    1ae3:	lea    r12,[r15+r13*1]
    1ae7:	lea    r8,[rax+r13*1]
    1aeb:	movzx  r13d,BYTE PTR [r15+r10*1]
    1af0:	shl    rsi,0x2
    1af4:	mov    QWORD PTR [rsp+0x140],r12
    1afc:	movzx  r12d,BYTE PTR [r15+r11*1]
    1b01:	lea    rdi,[rdx+rsi*1]
    1b05:	mov    DWORD PTR [rsp+0xc0],r9d
    1b0d:	add    rsi,QWORD PTR [rsp+0x1d0]
    1b15:	mov    DWORD PTR [rsp+0x180],r12d
    1b1d:	movzx  r12d,BYTE PTR [r15+r8*1]
    1b22:	mov    DWORD PTR [rsp+0x170],r13d
    1b2a:	mov    r13,QWORD PTR [rsp+0x150]
    1b32:	mov    DWORD PTR [rsp+0x190],r12d
    1b3a:	movzx  r12d,BYTE PTR [r15+r11*1+0x1]
    1b40:	movzx  r11d,BYTE PTR [r15+r11*1+0x2]
    1b46:	mov    DWORD PTR [rsp+0x160],r12d
    1b4e:	movzx  r12d,BYTE PTR [r15+r10*1+0x1]
    1b54:	movzx  r10d,BYTE PTR [r15+r10*1+0x2]
    1b5a:	mov    DWORD PTR [rsp+0x110],r12d
    1b62:	movzx  r12d,BYTE PTR [r15+r8*1+0x1]
    1b68:	mov    DWORD PTR [rsp+0x100],r12d
    1b70:	mov    r12d,r10d
    1b73:	movzx  r10d,BYTE PTR [r15+r8*1+0x2]
    1b79:	mov    r9d,DWORD PTR [rsp+0x110]
    1b81:	mov    r15,QWORD PTR [rsp+0x140]
    1b89:	mov    r8d,DWORD PTR [rsp+0x160]
    1b91:	mov    ebx,DWORD PTR [rsp+0x100]
                        float s0l = p.SUB[rb[0]+xf+k], s0r = p.SUB[rb[0]+xf+k+3];
    1b98:	vcvtusi2ss xmm8,xmm10,DWORD PTR [rsp+0x180]
                        float s1l = p.SUB[rb[1]+xf+k], s1r = p.SUB[rb[1]+xf+k+3];
    1ba0:	movzx  ecx,BYTE PTR [r13+rax*1+0x3]
    1ba6:	vmovaps xmm16,xmm6
                        float s2l = p.SUB[rb[2]+xf+k], s2r = p.SUB[rb[2]+xf+k+3];
    1bac:	movzx  edx,BYTE PTR [r15+rax*1+0x3]
    1bb2:	vcvtusi2ss xmm12,xmm10,DWORD PTR [rsp+0x190]
    1bba:	mov    QWORD PTR [rsp+0x150],rax
                        float s1l = p.SUB[rb[1]+xf+k], s1r = p.SUB[rb[1]+xf+k+3];
    1bc2:	vcvtusi2ss xmm13,xmm10,DWORD PTR [rsp+0x170]
    1bca:	mov    DWORD PTR [rsp+0x170],ecx
                        float s2l = p.SUB[rb[2]+xf+k], s2r = p.SUB[rb[2]+xf+k+3];
    1bd1:	mov    DWORD PTR [rsp+0x190],edx
                        float s0l = p.SUB[rb[0]+xf+k], s0r = p.SUB[rb[0]+xf+k+3];
    1bd8:	vmovaps xmm15,xmm8
                        float s1l = p.SUB[rb[1]+xf+k], s1r = p.SUB[rb[1]+xf+k+3];
    1bdd:	vcvtusi2ss xmm8,xmm10,ecx
                        float s0l = p.SUB[rb[0]+xf+k], s0r = p.SUB[rb[0]+xf+k+3];
    1be3:	movzx  ecx,BYTE PTR [r14+rax*1+0x3]
                        float s2l = p.SUB[rb[2]+xf+k], s2r = p.SUB[rb[2]+xf+k+3];
    1be9:	vmovaps xmm14,xmm12
                        float s0l = p.SUB[rb[0]+xf+k], s0r = p.SUB[rb[0]+xf+k+3];
    1bee:	vcvtusi2ss xmm12,xmm10,ecx
    1bf4:	vfmadd213ss xmm16,xmm13,DWORD PTR [rdi+rax*4]
    1bfb:	mov    DWORD PTR [rsp+0x180],ecx
                        vp0[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    1c02:	vmulss xmm18,xmm7,xmm8
    1c08:	vfmadd132ss xmm12,xmm18,xmm5
    1c0e:	vaddss xmm12,xmm12,xmm16
    1c14:	vmovaps xmm16,xmm6
    1c1a:	vfmadd231ss xmm12,xmm4,xmm15
    1c1f:	vmovss DWORD PTR [rdi+rax*4],xmm12
                        float s2l = p.SUB[rb[2]+xf+k], s2r = p.SUB[rb[2]+xf+k+3];
    1c24:	vcvtusi2ss xmm12,xmm10,edx
    1c2a:	vfmadd213ss xmm13,xmm4,DWORD PTR [rsi+rax*4]
                        vp1[xf+k] += p.A*s1l + p.B*s1r + p.C*s2l + p.D*s2r;
    1c30:	vmulss xmm12,xmm12,xmm7
    1c34:	vfmadd132ss xmm8,xmm12,xmm5
                        float s2l = p.SUB[rb[2]+xf+k], s2r = p.SUB[rb[2]+xf+k+3];
    1c39:	vcvtusi2ss xmm12,xmm10,ebx
    1c3f:	movzx  ebx,BYTE PTR [r15+rax*1+0x4]
                        vp1[xf+k] += p.A*s1l + p.B*s1r + p.C*s2l + p.D*s2r;
    1c45:	vaddss xmm8,xmm8,xmm13
                        float s1l = p.SUB[rb[1]+xf+k], s1r = p.SUB[rb[1]+xf+k+3];
    1c4a:	vcvtusi2ss xmm13,xmm10,r9d
    1c50:	movzx  r9d,BYTE PTR [r13+rax*1+0x4]
                        vp1[xf+k] += p.A*s1l + p.B*s1r + p.C*s2l + p.D*s2r;
    1c56:	vfmadd231ss xmm8,xmm6,xmm14
                        float s2l = p.SUB[rb[2]+xf+k], s2r = p.SUB[rb[2]+xf+k+3];
    1c5b:	vmovaps xmm14,xmm12
                        vp1[xf+k] += p.A*s1l + p.B*s1r + p.C*s2l + p.D*s2r;
    1c60:	vmovss DWORD PTR [rsi+rax*4],xmm8
                        float s0l = p.SUB[rb[0]+xf+k], s0r = p.SUB[rb[0]+xf+k+3];
    1c65:	vcvtusi2ss xmm8,xmm10,r8d
    1c6b:	movzx  r8d,BYTE PTR [r14+rax*1+0x4]
    1c71:	vfmadd213ss xmm16,xmm13,DWORD PTR [rdi+rax*4+0x4]
    1c79:	vcvtusi2ss xmm12,xmm10,r8d
    1c7f:	vmovaps xmm15,xmm8
                        float s1l = p.SUB[rb[1]+xf+k], s1r = p.SUB[rb[1]+xf+k+3];
    1c84:	vcvtusi2ss xmm8,xmm10,r9d
                        vp0[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    1c8a:	vmulss xmm18,xmm7,xmm8
    1c90:	vfmadd132ss xmm12,xmm18,xmm5
    1c96:	vaddss xmm12,xmm12,xmm16
    1c9c:	vmovaps xmm16,xmm6
    1ca2:	vfmadd231ss xmm12,xmm4,xmm15
    1ca7:	vmovss DWORD PTR [rdi+rax*4+0x4],xmm12
                        float s2l = p.SUB[rb[2]+xf+k], s2r = p.SUB[rb[2]+xf+k+3];
    1cad:	vcvtusi2ss xmm12,xmm10,ebx
    1cb3:	vfmadd213ss xmm13,xmm4,DWORD PTR [rsi+rax*4+0x4]
                        vp1[xf+k] += p.A*s1l + p.B*s1r + p.C*s2l + p.D*s2r;
    1cba:	vmulss xmm12,xmm12,xmm7
    1cbe:	vfmadd132ss xmm8,xmm12,xmm5
                        float s2l = p.SUB[rb[2]+xf+k], s2r = p.SUB[rb[2]+xf+k+3];
    1cc3:	vcvtusi2ss xmm12,xmm10,r10d
    1cc9:	movzx  r10d,BYTE PTR [r15+rax*1+0x5]
                        vp1[xf+k] += p.A*s1l + p.B*s1r + p.C*s2l + p.D*s2r;
    1ccf:	vaddss xmm8,xmm8,xmm13
                        float s1l = p.SUB[rb[1]+xf+k], s1r = p.SUB[rb[1]+xf+k+3];
    1cd4:	vcvtusi2ss xmm13,xmm10,r12d
    1cda:	movzx  r12d,BYTE PTR [r13+rax*1+0x5]
                        vp1[xf+k] += p.A*s1l + p.B*s1r + p.C*s2l + p.D*s2r;
    1ce0:	vfmadd231ss xmm8,xmm6,xmm14
                        float s2l = p.SUB[rb[2]+xf+k], s2r = p.SUB[rb[2]+xf+k+3];
    1ce5:	vmovaps xmm14,xmm12
                        vp1[xf+k] += p.A*s1l + p.B*s1r + p.C*s2l + p.D*s2r;
    1cea:	vmovss DWORD PTR [rsi+rax*4+0x4],xmm8
                        float s0l = p.SUB[rb[0]+xf+k], s0r = p.SUB[rb[0]+xf+k+3];
    1cf0:	vcvtusi2ss xmm8,xmm10,r11d
    1cf6:	movzx  r11d,BYTE PTR [r14+rax*1+0x5]
    1cfc:	vfmadd213ss xmm16,xmm13,DWORD PTR [rdi+rax*4+0x8]
    1d04:	vcvtusi2ss xmm12,xmm10,r11d
    1d0a:	vmovaps xmm15,xmm8
                        float s1l = p.SUB[rb[1]+xf+k], s1r = p.SUB[rb[1]+xf+k+3];
    1d0f:	vcvtusi2ss xmm8,xmm10,r12d
                        vp0[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    1d15:	vmulss xmm18,xmm7,xmm8
    1d1b:	vfmadd132ss xmm12,xmm18,xmm5
    1d21:	vaddss xmm12,xmm12,xmm16
    1d27:	vfmadd231ss xmm12,xmm4,xmm15
    1d2c:	vmovss DWORD PTR [rdi+rax*4+0x8],xmm12
                        float s2l = p.SUB[rb[2]+xf+k], s2r = p.SUB[rb[2]+xf+k+3];
    1d32:	vcvtusi2ss xmm12,xmm10,r10d
    1d38:	vfmadd213ss xmm13,xmm4,DWORD PTR [rsi+rax*4+0x8]
                        vp1[xf+k] += p.A*s1l + p.B*s1r + p.C*s2l + p.D*s2r;
    1d3f:	vmulss xmm12,xmm12,xmm7
    1d43:	vfmadd132ss xmm8,xmm12,xmm5
    1d48:	vaddss xmm8,xmm8,xmm13
    1d4d:	vfmadd231ss xmm8,xmm6,xmm14
    1d52:	vmovss DWORD PTR [rsi+rax*4+0x8],xmm8
                    for (int k = 0; k < x_floats - xf; ++k) {
    1d58:	add    rax,0x3
    1d5c:	lea    edx,[rax+0x1]
    1d5f:	cmp    edx,DWORD PTR [rsp+0x130]
    1d66:	jl     1b98 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x1b98>
    1d6c:	mov    rax,QWORD PTR [rsp+0x150]
    1d74:	mov    ebx,DWORD PTR [rsp+0xfc]
    1d7b:	mov    rdx,QWORD PTR [rsp+0xf0]
    1d83:	mov    r9d,DWORD PTR [rsp+0xc0]
    1d8b:	mov    rcx,QWORD PTR [rsp+0xa0]
    1d93:	lea    r8d,[rax+0x3]
    1d97:	lea    r10d,[rax+0x4]
                        float s1l = p.SUB[rb[1]+xf+k], s1r = p.SUB[rb[1]+xf+k+3];
    1d9b:	mov    r13,QWORD PTR [rsp+0x1c8]
    1da3:	mov    r14,QWORD PTR [rsp+0x1b0]
                        float s0l = p.SUB[rb[0]+xf+k], s0r = p.SUB[rb[0]+xf+k+3];
    1dab:	mov    eax,r8d
    1dae:	mov    r15,QWORD PTR [rsp+0x1b8]
                    for (int k = 0; k < x_floats - xf; ++k) {
    1db6:	mov    r12d,DWORD PTR [rsp+0x1a8]
                        float s1l = p.SUB[rb[1]+xf+k], s1r = p.SUB[rb[1]+xf+k+3];
    1dbe:	lea    rsi,[rax+r13*1]
    1dc2:	movzx  edi,BYTE PTR [r14+rsi*1]
    1dc7:	movzx  esi,BYTE PTR [r14+rsi*1+0x3]
                        float s0l = p.SUB[rb[0]+xf+k], s0r = p.SUB[rb[0]+xf+k+3];
    1dcd:	lea    r11,[rax+r15*1]
                        float s2l = p.SUB[rb[2]+xf+k], s2r = p.SUB[rb[2]+xf+k+3];
    1dd1:	add    rax,QWORD PTR [rsp+0x1c0]
                        float s1l = p.SUB[rb[1]+xf+k], s1r = p.SUB[rb[1]+xf+k+3];
    1dd9:	vcvtusi2ss xmm13,xmm10,esi
                        float s2l = p.SUB[rb[2]+xf+k], s2r = p.SUB[rb[2]+xf+k+3];
    1ddf:	movzx  esi,BYTE PTR [r14+rax*1]
    1de4:	movzx  eax,BYTE PTR [r14+rax*1+0x3]
                        float s1l = p.SUB[rb[1]+xf+k], s1r = p.SUB[rb[1]+xf+k+3];
    1dea:	vcvtusi2ss xmm14,xmm10,edi
                        float s0l = p.SUB[rb[0]+xf+k], s0r = p.SUB[rb[0]+xf+k+3];
    1df0:	movzx  edi,BYTE PTR [r14+r11*1]
                        float s2l = p.SUB[rb[2]+xf+k], s2r = p.SUB[rb[2]+xf+k+3];
    1df5:	vcvtusi2ss xmm8,xmm10,esi
                        vp0[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    1dfb:	vmulss xmm18,xmm6,xmm14
                        vp1[xf+k] += p.A*s1l + p.B*s1r + p.C*s2l + p.D*s2r;
    1e01:	vmulss xmm15,xmm6,xmm8
                        float s2l = p.SUB[rb[2]+xf+k], s2r = p.SUB[rb[2]+xf+k+3];
    1e06:	vcvtusi2ss xmm8,xmm10,eax
                        vp0[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    1e0c:	mov    eax,DWORD PTR [rsp+0x1a4]
    1e13:	add    eax,r8d
    1e16:	mov    eax,eax
                        float s2l = p.SUB[rb[2]+xf+k], s2r = p.SUB[rb[2]+xf+k+3];
    1e18:	vmovaps xmm12,xmm8
                        float s0l = p.SUB[rb[0]+xf+k], s0r = p.SUB[rb[0]+xf+k+3];
    1e1d:	vcvtusi2ss xmm8,xmm10,edi
                        vp0[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    1e23:	shl    rax,0x2
                        float s0l = p.SUB[rb[0]+xf+k], s0r = p.SUB[rb[0]+xf+k+3];
    1e27:	movzx  edi,BYTE PTR [r14+r11*1+0x3]
    1e2d:	vcvtusi2ss xmm16,xmm10,edi
    1e33:	vfmadd213ss xmm8,xmm4,DWORD PTR [rdx+rax*1]
    1e39:	vfmadd132ss xmm16,xmm18,xmm5
                        vp0[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    1e3f:	vfmadd231ss xmm8,xmm7,xmm13
    1e44:	vfmadd132ss xmm13,xmm15,xmm5
    1e49:	vaddss xmm8,xmm8,xmm16
    1e4f:	vmovss DWORD PTR [rdx+rax*1],xmm8
                        vp1[xf+k] += p.A*s1l + p.B*s1r + p.C*s2l + p.D*s2r;
    1e54:	add    rax,QWORD PTR [rsp+0x1d0]
    1e5c:	vfmadd213ss xmm14,xmm4,DWORD PTR [rax]
    1e61:	vfmadd132ss xmm12,xmm14,xmm7
    1e66:	vaddss xmm8,xmm12,xmm13
    1e6b:	vmovss DWORD PTR [rax],xmm8
                    for (int k = 0; k < x_floats - xf; ++k) {
    1e6f:	cmp    r12d,r10d
    1e72:	jle    1ff8 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x1ff8>
                        float s0l = p.SUB[rb[0]+xf+k], s0r = p.SUB[rb[0]+xf+k+3];
    1e78:	mov    eax,r10d
                        float s1l = p.SUB[rb[1]+xf+k], s1r = p.SUB[rb[1]+xf+k+3];
    1e7b:	lea    rsi,[r13+rax*1+0x0]
                        float s0l = p.SUB[rb[0]+xf+k], s0r = p.SUB[rb[0]+xf+k+3];
    1e80:	lea    r11,[r15+rax*1]
                        float s2l = p.SUB[rb[2]+xf+k], s2r = p.SUB[rb[2]+xf+k+3];
    1e84:	add    rax,QWORD PTR [rsp+0x1c0]
                        float s1l = p.SUB[rb[1]+xf+k], s1r = p.SUB[rb[1]+xf+k+3];
    1e8c:	movzx  edi,BYTE PTR [r14+rsi*1]
    1e91:	movzx  esi,BYTE PTR [r14+rsi*1+0x3]
    1e97:	vcvtusi2ss xmm13,xmm10,esi
                        float s2l = p.SUB[rb[2]+xf+k], s2r = p.SUB[rb[2]+xf+k+3];
    1e9d:	movzx  esi,BYTE PTR [r14+rax*1]
    1ea2:	movzx  eax,BYTE PTR [r14+rax*1+0x3]
                        float s1l = p.SUB[rb[1]+xf+k], s1r = p.SUB[rb[1]+xf+k+3];
    1ea8:	vcvtusi2ss xmm14,xmm10,edi
                        float s2l = p.SUB[rb[2]+xf+k], s2r = p.SUB[rb[2]+xf+k+3];
    1eae:	vcvtusi2ss xmm8,xmm10,esi
                        float s0l = p.SUB[rb[0]+xf+k], s0r = p.SUB[rb[0]+xf+k+3];
    1eb4:	movzx  esi,BYTE PTR [r14+r11*1]
                        vp0[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    1eb9:	vmulss xmm18,xmm6,xmm14
                        vp1[xf+k] += p.A*s1l + p.B*s1r + p.C*s2l + p.D*s2r;
    1ebf:	vmulss xmm15,xmm6,xmm8
                        float s2l = p.SUB[rb[2]+xf+k], s2r = p.SUB[rb[2]+xf+k+3];
    1ec4:	vcvtusi2ss xmm8,xmm10,eax
                        vp0[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    1eca:	mov    eax,DWORD PTR [rsp+0x1a4]
    1ed1:	add    eax,r10d
    1ed4:	mov    eax,eax
                        float s2l = p.SUB[rb[2]+xf+k], s2r = p.SUB[rb[2]+xf+k+3];
    1ed6:	vmovaps xmm12,xmm8
                        float s0l = p.SUB[rb[0]+xf+k], s0r = p.SUB[rb[0]+xf+k+3];
    1edb:	vcvtusi2ss xmm8,xmm10,esi
                        vp0[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    1ee1:	lea    rdi,[rax*4+0x0]
                        float s0l = p.SUB[rb[0]+xf+k], s0r = p.SUB[rb[0]+xf+k+3];
    1ee9:	movzx  esi,BYTE PTR [r14+r11*1+0x3]
                        vp1[xf+k] += p.A*s1l + p.B*s1r + p.C*s2l + p.D*s2r;
    1eef:	mov    r11,QWORD PTR [rsp+0x1d0]
                        float s0l = p.SUB[rb[0]+xf+k], s0r = p.SUB[rb[0]+xf+k+3];
    1ef7:	vcvtusi2ss xmm16,xmm10,esi
    1efd:	vfmadd213ss xmm8,xmm4,DWORD PTR [rdx+rdi*1]
    1f03:	vfmadd132ss xmm16,xmm18,xmm5
                        vp0[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    1f09:	vfmadd231ss xmm8,xmm7,xmm13
    1f0e:	vfmadd132ss xmm13,xmm15,xmm5
    1f13:	vaddss xmm8,xmm8,xmm16
    1f19:	vmovss DWORD PTR [rdx+rdi*1],xmm8
                        vp1[xf+k] += p.A*s1l + p.B*s1r + p.C*s2l + p.D*s2r;
    1f1e:	vfmadd213ss xmm14,xmm4,DWORD PTR [r11+rdi*1]
    1f24:	vfmadd132ss xmm12,xmm14,xmm7
    1f29:	vaddss xmm8,xmm12,xmm13
    1f2e:	vmovss DWORD PTR [r11+rdi*1],xmm8
                    for (int k = 0; k < x_floats - xf; ++k) {
    1f34:	lea    edi,[r8+0x2]
    1f38:	cmp    r12d,edi
    1f3b:	jle    1ff8 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x1ff8>
                        float s0l = p.SUB[rb[0]+xf+k], s0r = p.SUB[rb[0]+xf+k+3];
    1f41:	mov    r8d,edi
                        float s1l = p.SUB[rb[1]+xf+k], s1r = p.SUB[rb[1]+xf+k+3];
    1f44:	lea    rax,[r13+r8*1+0x0]
                        float s0l = p.SUB[rb[0]+xf+k], s0r = p.SUB[rb[0]+xf+k+3];
    1f49:	lea    r10,[r15+r8*1]
                        float s1l = p.SUB[rb[1]+xf+k], s1r = p.SUB[rb[1]+xf+k+3];
    1f4d:	movzx  esi,BYTE PTR [r14+rax*1]
    1f52:	movzx  eax,BYTE PTR [r14+rax*1+0x3]
    1f58:	vcvtusi2ss xmm14,xmm10,esi
                        float s2l = p.SUB[rb[2]+xf+k], s2r = p.SUB[rb[2]+xf+k+3];
    1f5e:	mov    rsi,QWORD PTR [rsp+0x1c0]
                        float s1l = p.SUB[rb[1]+xf+k], s1r = p.SUB[rb[1]+xf+k+3];
    1f66:	vcvtusi2ss xmm13,xmm10,eax
                        float s2l = p.SUB[rb[2]+xf+k], s2r = p.SUB[rb[2]+xf+k+3];
    1f6c:	lea    rax,[rsi+r8*1]
    1f70:	movzx  esi,BYTE PTR [r14+rax*1]
    1f75:	movzx  eax,BYTE PTR [r14+rax*1+0x3]
    1f7b:	vcvtusi2ss xmm8,xmm10,esi
                        vp1[xf+k] += p.A*s1l + p.B*s1r + p.C*s2l + p.D*s2r;
    1f81:	vmulss xmm15,xmm6,xmm8
                        float s2l = p.SUB[rb[2]+xf+k], s2r = p.SUB[rb[2]+xf+k+3];
    1f86:	vcvtusi2ss xmm8,xmm10,eax
                        vp0[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    1f8c:	mov    eax,DWORD PTR [rsp+0x1a4]
    1f93:	add    eax,edi
    1f95:	mov    eax,eax
                        float s2l = p.SUB[rb[2]+xf+k], s2r = p.SUB[rb[2]+xf+k+3];
    1f97:	vmovaps xmm12,xmm8
                        vp0[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    1f9c:	lea    rsi,[rax*4+0x0]
                        float s0l = p.SUB[rb[0]+xf+k], s0r = p.SUB[rb[0]+xf+k+3];
    1fa4:	movzx  eax,BYTE PTR [r14+r10*1]
                        vp0[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    1fa9:	vmulss xmm18,xmm6,xmm14
                        float s0l = p.SUB[rb[0]+xf+k], s0r = p.SUB[rb[0]+xf+k+3];
    1faf:	vcvtusi2ss xmm8,xmm10,eax
    1fb5:	movzx  eax,BYTE PTR [r14+r10*1+0x3]
    1fbb:	vcvtusi2ss xmm16,xmm10,eax
    1fc1:	vfmadd213ss xmm8,xmm4,DWORD PTR [rdx+rsi*1]
    1fc7:	vfmadd132ss xmm16,xmm18,xmm5
                        vp0[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    1fcd:	vfmadd231ss xmm8,xmm7,xmm13
    1fd2:	vfmadd132ss xmm13,xmm15,xmm5
    1fd7:	vaddss xmm8,xmm8,xmm16
    1fdd:	vmovss DWORD PTR [rdx+rsi*1],xmm8
                        vp1[xf+k] += p.A*s1l + p.B*s1r + p.C*s2l + p.D*s2r;
    1fe2:	vfmadd213ss xmm14,xmm4,DWORD PTR [r11+rsi*1]
    1fe8:	vfmadd132ss xmm12,xmm14,xmm7
    1fed:	vaddss xmm8,xmm12,xmm13
    1ff2:	vmovss DWORD PTR [r11+rsi*1],xmm8
                for (; y + 1 < y_end; y += 2) {
    1ff8:	add    r9d,0x2
                if (y < y_end) {
    1ffc:	cmp    DWORD PTR [rsp+0xf8],r9d
    2004:	jle    2ae0 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x2ae0>
                    const size_t rb0 = ((size_t)(y + p.sy) * width + (size_t)(x_begin + p.sx)) * 3;
    200a:	mov    eax,DWORD PTR [rcx+0x4]
    200d:	mov    edx,DWORD PTR [rcx]
                    float* vp = tile_vals.data() + (size_t)(y - ty) * tile_row_stride + (size_t)(x_begin - tx) * 3;
    200f:	mov    r11,QWORD PTR [rsp+0xa8]
    2017:	mov    rdi,QWORD PTR [rsp+0xe8]
                    const size_t rb0 = ((size_t)(y + p.sy) * width + (size_t)(x_begin + p.sx)) * 3;
    201f:	add    eax,r9d
    2022:	add    edx,ebx
                    float* vp = tile_vals.data() + (size_t)(y - ty) * tile_row_stride + (size_t)(x_begin - tx) * 3;
    2024:	sub    r9d,DWORD PTR [rsp+0xe4]
                        __m256 rl0 = load_cvt8(p.SUB + rb[0] + xf);
    202c:	mov    rsi,QWORD PTR [rcx+0x28]
                    const size_t rb0 = ((size_t)(y + p.sy) * width + (size_t)(x_begin + p.sx)) * 3;
    2030:	cdqe
    2032:	movsxd rdx,edx
    2035:	imul   rax,QWORD PTR [rsp+0xc8]
    203e:	add    rax,rdx
    2041:	lea    r10,[rax+rax*2]
                    const size_t rb1 = rb0 + width * 3;
    2045:	mov    rax,QWORD PTR [rsp+0x88]
                    const size_t rb0 = ((size_t)(y + p.sy) * width + (size_t)(x_begin + p.sx)) * 3;
    204d:	mov    r13,r10
                    const size_t rb1 = rb0 + width * 3;
    2050:	lea    r12,[rax+r10*1]
                    float* vp = tile_vals.data() + (size_t)(y - ty) * tile_row_stride + (size_t)(x_begin - tx) * 3;
    2054:	movsxd rax,r9d
    2057:	imul   r11,rax
    205b:	mov    eax,ebx
    205d:	sub    eax,DWORD PTR [rsp+0xe0]
    2064:	cdqe
    2066:	lea    rax,[rax+rax*2]
    206a:	add    rax,r11
    206d:	lea    rdi,[rdi+rax*4]
                    for (; xf + 8 <= x_floats; xf += 8) {
    2071:	mov    eax,DWORD PTR [rsp+0x1a0]
    2078:	cmp    eax,0x7
    207b:	jle    32a3 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x32a3>
    2081:	lea    r13d,[rax-0x8]
    2085:	shr    eax,0x3
    2088:	lea    r8,[rsi+r10*1]
    208c:	lea    r9d,[rax*8+0x0]
    2094:	lea    rdx,[rsi+r12*1]
    2098:	xor    eax,eax
    209a:	nop    WORD PTR [rax+rax*1+0x0]
    20a0:	vpmovzxbd ymm14,QWORD PTR [r8+rax*1]
    20a6:	vpmovzxbd ymm13,QWORD PTR [r8+rax*1+0x3]
    20ad:	vpmovzxbd ymm12,QWORD PTR [rdx+rax*1]
    20b3:	vpmovzxbd ymm8,QWORD PTR [rdx+rax*1+0x3]
  return (__m256)__builtin_ia32_cvtdq2ps256 ((__v8si) __A);
    20ba:	vcvtdq2ps ymm14,ymm14
    20bf:	vfmadd213ps ymm14,ymm0,YMMWORD PTR [rdi+rax*4]
    20c5:	vcvtdq2ps ymm13,ymm13
    20ca:	vcvtdq2ps ymm12,ymm12
    20cf:	vcvtdq2ps ymm8,ymm8
    20d4:	vfmadd132ps ymm13,ymm14,ymm1
    20d9:	vfmadd132ps ymm12,ymm13,ymm2
    20de:	vfmadd132ps ymm8,ymm12,ymm3
  *(__m256_u *)__P = __A;
    20e3:	vmovups YMMWORD PTR [rdi+rax*4],ymm8
    20e8:	add    rax,0x8
    20ec:	cmp    rax,r9
    20ef:	jne    20a0 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x20a0>
    20f1:	mov    eax,r13d
    20f4:	and    eax,0xfffffff8
    20f7:	lea    r14d,[rax+0x8]
                    for (int k = 0; k < x_floats - xf; ++k) {
    20fb:	mov    eax,DWORD PTR [rsp+0x1a0]
    2102:	sub    eax,r14d
    2105:	mov    DWORD PTR [rsp+0xc4],eax
    210c:	test   eax,eax
    210e:	jle    2ae0 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x2ae0>
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
    2114:	mov    eax,r14d
    2117:	lea    r13,[r10+rax*1]
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
    211b:	add    r12,rax
    211e:	sub    rbx,QWORD PTR [rsp+0xb8]
    2126:	mov    eax,DWORD PTR [rsp+0xc4]
    212d:	mov    r15d,r14d
    2130:	lea    r9,[rsi+r13*1]
    2134:	lea    rdx,[rbx+rbx*2]
    2138:	mov    r8,QWORD PTR [rsp+0xe8]
    2140:	mov    QWORD PTR [rsp+0x1d0],r15
    2148:	add    rdx,r11
    214b:	lea    r10,[rax+r12*1+0x3]
    2150:	add    r15,rdx
    2153:	add    r10,rsi
    2156:	lea    rbx,[r8+r15*4]
    215a:	lea    rdx,[r15+rax*1]
    215e:	cmp    rbx,r10
    2161:	lea    rdx,[r8+rdx*4]
    2165:	lea    r8,[rsi+r12*1]
    2169:	setae  r11b
    216d:	cmp    r8,rdx
    2170:	setae  r10b
    2174:	or     r11b,r10b
    2177:	je     320f <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x320f>
    217d:	lea    rax,[rax+r13*1+0x3]
    2182:	add    rax,rsi
    2185:	cmp    rbx,rax
    2188:	setae  al
    218b:	cmp    r9,rdx
    218e:	setae  dl
    2191:	or     al,dl
    2193:	je     320f <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x320f>
    2199:	mov    edx,DWORD PTR [rsp+0xc4]
    21a0:	lea    eax,[rdx-0x1]
    21a3:	cmp    eax,0x1e
    21a6:	jbe    32b2 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x32b2>
    21ac:	shr    edx,0x5
    21af:	lea    r11,[rsi+r12*1+0x3]
    21b4:	lea    r10,[rsi+r13*1+0x3]
    21b9:	mov    rax,rbx
    21bc:	mov    ebx,edx
    21be:	mov    DWORD PTR [rsp+0x1d0],edx
                    int xf = 0;
    21c5:	xor    edx,edx
    21c7:	shl    rbx,0x5
    21cb:	nop    DWORD PTR [rax+rax*1+0x0]
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
    21d0:	vmovdqu ymm8,YMMWORD PTR [r8+rdx*1]
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
    21d6:	vmovdqu ymm12,YMMWORD PTR [r10+rdx*1]
    21dc:	sub    rax,0xffffffffffffff80
    21e0:	vmovdqu ymm13,YMMWORD PTR [r9+rdx*1]
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
    21e6:	vpmovzxbw ymm14,xmm8
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
    21eb:	vpmovzxbw ymm15,xmm12
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
    21f0:	vextracti32x4 xmm8,ymm8,0x1
    21f7:	vpmovsxwd ymm18,xmm14
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
    21fd:	vpmovsxwd ymm16,xmm15
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
    2203:	vpmovzxbw ymm8,xmm8
    2208:	vcvtdq2ps ymm18,ymm18
                        vp[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    220e:	vmulps ymm18,ymm18,ymm2
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
    2214:	vcvtdq2ps ymm16,ymm16
    221a:	vextracti32x4 xmm12,ymm12,0x1
    2221:	vpmovzxbw ymm19,xmm13
    2227:	vpmovzxbw ymm12,xmm12
    222c:	vpmovsxwd ymm21,xmm19
    2232:	vextracti32x4 xmm13,ymm13,0x1
    2239:	vcvtdq2ps ymm21,ymm21
    223f:	vfmadd213ps ymm21,ymm0,YMMWORD PTR [rax-0x80]
    2246:	vextracti32x4 xmm19,ymm19,0x1
    224d:	vpmovzxbw ymm13,xmm13
    2252:	vpmovsxwd ymm19,xmm19
    2258:	vcvtdq2ps ymm19,ymm19
    225e:	vfmadd213ps ymm19,ymm0,YMMWORD PTR [rax-0x60]
    2265:	vfmadd132ps ymm16,ymm18,ymm1
    226b:	vextracti32x4 xmm18,ymm15,0x1
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
    2272:	vextracti32x4 xmm15,ymm14,0x1
    2279:	vpmovsxwd ymm15,xmm15
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
    227e:	vpmovsxwd ymm18,xmm18
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
    2284:	vcvtdq2ps ymm15,ymm15
                        vp[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    2289:	vmulps ymm15,ymm15,ymm2
    228d:	vcvtdq2ps ymm14,ymm18
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
    2293:	vpmovsxwd ymm18,xmm12
    2299:	vextracti32x4 xmm12,ymm12,0x1
    22a0:	vpmovsxwd ymm12,xmm12
    22a5:	vcvtdq2ps ymm18,ymm18
    22ab:	vcvtdq2ps ymm12,ymm12
    22b0:	vfmadd132ps ymm14,ymm15,ymm1
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
    22b5:	vpmovsxwd ymm15,xmm8
    22ba:	vextracti32x4 xmm8,ymm8,0x1
    22c1:	vpmovsxwd ymm8,xmm8
    22c6:	vcvtdq2ps ymm15,ymm15
    22cb:	vcvtdq2ps ymm8,ymm8
                        vp[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    22d0:	vmulps ymm8,ymm8,ymm2
    22d4:	vmulps ymm15,ymm15,ymm2
    22d8:	vfmadd132ps ymm12,ymm8,ymm1
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
    22dd:	vmovdqu ymm8,YMMWORD PTR [r11+rdx*1]
    22e3:	add    rdx,0x20
    22e7:	vfmadd132ps ymm18,ymm15,ymm1
    22ed:	vpmovzxbw ymm15,xmm8
    22f2:	vextracti32x4 xmm8,ymm8,0x1
    22f9:	vpmovsxwd ymm20,xmm15
    22ff:	vextracti32x4 xmm15,ymm15,0x1
    2306:	vpmovzxbw ymm8,xmm8
    230b:	vcvtdq2ps ymm20,ymm20
    2311:	vfmadd132ps ymm20,ymm21,ymm3
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
    2317:	vpmovsxwd ymm21,xmm13
    231d:	vextracti32x4 xmm13,ymm13,0x1
    2324:	vpmovsxwd ymm13,xmm13
    2329:	vcvtdq2ps ymm21,ymm21
    232f:	vfmadd213ps ymm21,ymm0,YMMWORD PTR [rax-0x40]
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
    2336:	vpmovsxwd ymm15,xmm15
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
    233b:	vcvtdq2ps ymm13,ymm13
                        vp[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    2340:	vfmadd213ps ymm13,ymm0,YMMWORD PTR [rax-0x20]
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
    2346:	vcvtdq2ps ymm15,ymm15
    234b:	vfmadd132ps ymm15,ymm19,ymm3
    2351:	vpmovsxwd ymm19,xmm8
    2357:	vextracti32x4 xmm8,ymm8,0x1
    235e:	vcvtdq2ps ymm19,ymm19
    2364:	vpmovsxwd ymm8,xmm8
    2369:	vcvtdq2ps ymm8,ymm8
                        vp[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    236e:	vaddps ymm16,ymm16,ymm20
    2374:	vfmadd132ps ymm19,ymm21,ymm3
    237a:	vfmadd132ps ymm8,ymm13,ymm3
    237f:	vaddps ymm14,ymm14,ymm15
    2384:	vmovups YMMWORD PTR [rax-0x80],ymm16
    238b:	vmovups YMMWORD PTR [rax-0x60],ymm14
    2390:	vaddps ymm18,ymm18,ymm19
    2396:	vaddps ymm8,ymm8,ymm12
    239b:	vmovups YMMWORD PTR [rax-0x40],ymm18
    23a2:	vmovups YMMWORD PTR [rax-0x20],ymm8
                    for (int k = 0; k < x_floats - xf; ++k) {
    23a7:	cmp    rdx,rbx
    23aa:	jne    21d0 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x21d0>
    23b0:	mov    r9d,DWORD PTR [rsp+0x1d0]
    23b8:	shl    r9d,0x5
    23bc:	cmp    r9d,DWORD PTR [rsp+0xc4]
    23c4:	je     2ae0 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x2ae0>
    23ca:	mov    r8d,r9d
    23cd:	mov    r11d,DWORD PTR [rsp+0xc4]
    23d5:	sub    r11d,r9d
    23d8:	lea    eax,[r11-0x1]
    23dc:	cmp    eax,0xe
    23df:	jbe    32ab <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x32ab>
    23e5:	mov    eax,r9d
    23e8:	mov    rbx,QWORD PTR [rsp+0xe8]
    23f0:	lea    r10,[rax+r12*1]
    23f4:	lea    rdx,[rax+r13*1]
    23f8:	add    rax,r15
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
    23fb:	vmovdqu xmm3,XMMWORD PTR [rsi+r10*1]
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
    2401:	vmovdqu xmm0,XMMWORD PTR [rsi+rdx*1]
    2406:	lea    rax,[rbx+rax*4]
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
    240a:	vpmovzxbw xmm1,xmm3
    240f:	vpsrldq xmm3,xmm3,0x8
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
    2414:	vpmovzxbw xmm16,xmm0
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
    241a:	vpmovsxwd xmm12,xmm1
    241f:	vpsrldq xmm1,xmm1,0x8
    2424:	vpmovzxbw xmm3,xmm3
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
    2429:	vpsrldq xmm0,xmm0,0x8
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
    242e:	vpmovsxwd xmm1,xmm1
    2433:	vcvtdq2ps xmm12,xmm12
    2438:	vcvtdq2ps xmm1,xmm1
                        vp[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    243c:	vmulps xmm1,xmm1,xmm25
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
    2442:	vpmovzxbw xmm2,xmm0
    2447:	vmovdqu xmm0,XMMWORD PTR [rsi+rdx*1+0x3]
                        vp[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    244d:	vmulps xmm12,xmm12,xmm25
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
    2453:	vpmovzxbw xmm8,xmm0
    2458:	vpsrldq xmm0,xmm0,0x8
    245d:	vpmovsxwd xmm13,xmm8
    2462:	vpsrldq xmm8,xmm8,0x8
    2468:	vpmovzxbw xmm0,xmm0
    246d:	vpmovsxwd xmm8,xmm8
    2472:	vcvtdq2ps xmm13,xmm13
    2477:	vcvtdq2ps xmm8,xmm8
    247c:	vfmadd132ps xmm8,xmm1,xmm17
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
    2482:	vpmovsxwd xmm1,xmm3
    2487:	vcvtdq2ps xmm1,xmm1
                        vp[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    248b:	vmulps xmm1,xmm1,xmm25
    2491:	vfmadd132ps xmm13,xmm12,xmm17
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
    2497:	vpmovsxwd xmm12,xmm0
    249c:	vcvtdq2ps xmm12,xmm12
    24a1:	vfmadd132ps xmm12,xmm1,xmm17
    24a7:	vpsrldq xmm1,xmm0,0x8
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
    24ac:	vpsrldq xmm0,xmm3,0x8
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
    24b1:	vpmovsxwd xmm3,xmm16
    24b7:	vpmovsxwd xmm1,xmm1
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
    24bc:	vpmovsxwd xmm0,xmm0
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
    24c1:	vcvtdq2ps xmm3,xmm3
    24c5:	vfmadd213ps xmm3,xmm9,XMMWORD PTR [rax]
    24ca:	vcvtdq2ps xmm1,xmm1
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
    24ce:	vcvtdq2ps xmm0,xmm0
                        vp[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    24d2:	vmulps xmm0,xmm0,xmm25
    24d8:	vfmadd132ps xmm1,xmm0,xmm17
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
    24de:	vmovdqu xmm0,XMMWORD PTR [rsi+r10*1+0x3]
    24e5:	vpmovzxbw xmm14,xmm0
    24ea:	vpsrldq xmm0,xmm0,0x8
    24ef:	vpmovsxwd xmm15,xmm14
    24f4:	vpsrldq xmm14,xmm14,0x8
    24fa:	vpmovzxbw xmm0,xmm0
    24ff:	vcvtdq2ps xmm15,xmm15
    2504:	vfmadd132ps xmm15,xmm3,xmm11
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
    2509:	vpsrldq xmm3,xmm16,0x8
    2510:	vpmovsxwd xmm16,xmm2
    2516:	vpmovsxwd xmm3,xmm3
    251b:	vpsrldq xmm2,xmm2,0x8
    2520:	vcvtdq2ps xmm16,xmm16
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
    2526:	vpmovsxwd xmm14,xmm14
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
    252b:	vcvtdq2ps xmm3,xmm3
    252f:	vfmadd213ps xmm3,xmm9,XMMWORD PTR [rax+0x10]
    2535:	vfmadd213ps xmm16,xmm9,XMMWORD PTR [rax+0x20]
    253c:	vpmovsxwd xmm2,xmm2
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
    2541:	vcvtdq2ps xmm14,xmm14
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
    2546:	vcvtdq2ps xmm2,xmm2
                        vp[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    254a:	vfmadd213ps xmm2,xmm9,XMMWORD PTR [rax+0x30]
    2550:	vaddps xmm13,xmm13,xmm15
    2555:	vfmadd132ps xmm14,xmm3,xmm11
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
    255a:	vpmovsxwd xmm3,xmm0
    255f:	vpsrldq xmm0,xmm0,0x8
    2564:	vcvtdq2ps xmm3,xmm3
    2568:	vfmadd132ps xmm3,xmm16,xmm11
                        vp[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    256e:	vmovups XMMWORD PTR [rax],xmm13
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
    2572:	vpmovsxwd xmm0,xmm0
    2577:	vcvtdq2ps xmm0,xmm0
                        vp[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    257b:	vfmadd132ps xmm0,xmm2,xmm11
    2580:	vaddps xmm8,xmm8,xmm14
    2585:	vaddps xmm12,xmm12,xmm3
    2589:	vaddps xmm0,xmm0,xmm1
    258d:	vmovups XMMWORD PTR [rax+0x10],xmm8
    2592:	vmovups XMMWORD PTR [rax+0x20],xmm12
    2597:	vmovups XMMWORD PTR [rax+0x30],xmm0
                    for (int k = 0; k < x_floats - xf; ++k) {
    259c:	mov    eax,r11d
    259f:	and    eax,0xfffffff0
    25a2:	test   r11b,0xf
    25a6:	je     2ae0 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x2ae0>
    25ac:	add    r8d,eax
    25af:	mov    r10d,r11d
    25b2:	sub    r10d,eax
    25b5:	lea    edx,[r10-0x1]
    25b9:	cmp    edx,0x6
    25bc:	jbe    27f4 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x27f4>
    25c2:	add    eax,r9d
    25c5:	mov    rbx,QWORD PTR [rsp+0xe8]
    25cd:	vmovaps xmm16,xmm9
    25d3:	mov    eax,eax
    25d5:	lea    r9,[rax+r12*1]
    25d9:	lea    rdx,[rax+r13*1]
    25dd:	add    rax,r15
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
    25e0:	vmovq  xmm1,QWORD PTR [rsi+r9*1]
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
    25e6:	vmovq  xmm0,QWORD PTR [rsi+rdx*1]
    25eb:	lea    rax,[rbx+rax*4]
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
    25ef:	vpmovzxbw xmm12,xmm1
    25f4:	vpsrlq xmm1,xmm1,0x20
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
    25f9:	vpmovzxbw xmm8,xmm0
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
    25fe:	vpmovzxwd xmm14,xmm12
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
    2603:	vpsrlq xmm0,xmm0,0x20
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
    2608:	vpmovzxbw xmm1,xmm1
    260d:	vmovq  xmm14,xmm14
    2612:	vpsrlq xmm12,xmm12,0x20
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
    2618:	vpmovzxbw xmm2,xmm0
    261d:	vmovq  xmm0,QWORD PTR [rsi+rdx*1+0x3]
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
    2623:	vcvtdq2ps xmm14,xmm14
                        vp[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    2628:	vmulps xmm14,xmm14,xmm25
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
    262e:	vpmovzxwd xmm12,xmm12
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
    2633:	vpmovzxbw xmm3,xmm0
    2638:	vpsrlq xmm0,xmm0,0x20
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
    263d:	vmovq  xmm12,xmm12
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
    2642:	vpmovzxwd xmm13,xmm3
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
    2647:	vcvtdq2ps xmm12,xmm12
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
    264c:	vpsrlq xmm3,xmm3,0x20
    2651:	vpmovzxbw xmm0,xmm0
                        vp[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    2656:	vmulps xmm12,xmm12,xmm25
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
    265c:	vmovq  xmm13,xmm13
    2661:	vpmovzxwd xmm3,xmm3
    2666:	vcvtdq2ps xmm13,xmm13
    266b:	vmovq  xmm3,xmm3
    266f:	vfmadd132ps xmm13,xmm14,xmm17
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
    2675:	vpmovzxwd xmm14,xmm1
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
    267a:	vcvtdq2ps xmm3,xmm3
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
    267e:	vmovq  xmm14,xmm14
    2683:	vcvtdq2ps xmm14,xmm14
                        vp[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    2688:	vmulps xmm14,xmm14,xmm25
    268e:	vfmadd132ps xmm3,xmm12,xmm17
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
    2694:	vpmovzxwd xmm12,xmm0
    2699:	vmovq  xmm12,xmm12
    269e:	vcvtdq2ps xmm12,xmm12
    26a3:	vfmadd132ps xmm12,xmm14,xmm17
    26a9:	vpsrlq xmm14,xmm0,0x20
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
    26ae:	vpsrlq xmm0,xmm1,0x20
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
    26b3:	vpmovzxwd xmm14,xmm14
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
    26b8:	vpmovzxwd xmm0,xmm0
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
    26bd:	vmovq  xmm14,xmm14
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
    26c2:	vmovq  xmm0,xmm0
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
    26c6:	vcvtdq2ps xmm14,xmm14
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
    26cb:	vcvtdq2ps xmm0,xmm0
                        vp[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    26cf:	vmulps xmm0,xmm0,xmm25
    26d5:	vfmadd132ps xmm14,xmm0,xmm17
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
    26db:	vmovq  xmm0,QWORD PTR [rsi+r9*1+0x3]
    26e2:	vpmovzxbw xmm1,xmm0
    26e7:	vpsrlq xmm0,xmm0,0x20
    26ec:	vpmovzxwd xmm15,xmm1
    26f1:	vpmovzxbw xmm0,xmm0
    26f6:	vmovq  xmm18,xmm15
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
    26fc:	vpmovzxwd xmm15,xmm8
    2701:	vmovq  xmm15,xmm15
    2706:	vcvtdq2ps xmm17,xmm15
                        vp[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    270c:	vmovq  xmm15,QWORD PTR [rax]
    2710:	vfmadd231ps xmm15,xmm17,xmm9
    2716:	vcvtdq2ps xmm9,xmm18
    271c:	vfmadd132ps xmm9,xmm15,xmm11
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
    2721:	vpsrlq xmm15,xmm1,0x20
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
    2726:	vpsrlq xmm1,xmm8,0x20
                        vp[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    272c:	vmovq  xmm8,QWORD PTR [rax+0x8]
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
    2731:	vpmovzxwd xmm15,xmm15
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
    2736:	vpmovzxwd xmm1,xmm1
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
    273b:	vmovq  xmm15,xmm15
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
    2740:	vmovq  xmm1,xmm1
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
    2744:	vcvtdq2ps xmm15,xmm15
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
    2749:	vcvtdq2ps xmm1,xmm1
    274d:	vfmadd132ps xmm1,xmm8,xmm16
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
    2753:	vpmovzxwd xmm8,xmm0
    2758:	vmovq  xmm8,xmm8
    275d:	vpsrlq xmm0,xmm0,0x20
                        vp[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    2762:	vaddps xmm13,xmm13,xmm9
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
    2767:	vcvtdq2ps xmm8,xmm8
    276c:	vpmovzxwd xmm0,xmm0
    2771:	vmovq  xmm0,xmm0
    2775:	vcvtdq2ps xmm0,xmm0
                        vp[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    2779:	vmovlps QWORD PTR [rax],xmm13
    277d:	vfmadd132ps xmm15,xmm1,xmm11
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
    2782:	vpmovzxwd xmm1,xmm2
    2787:	vmovq  xmm1,xmm1
    278b:	vcvtdq2ps xmm17,xmm1
                        vp[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    2791:	vmovq  xmm1,QWORD PTR [rax+0x10]
    2796:	vfmadd231ps xmm1,xmm17,xmm16
    279c:	vaddps xmm3,xmm3,xmm15
    27a1:	vmovlps QWORD PTR [rax+0x8],xmm3
    27a6:	vfmadd132ps xmm8,xmm1,xmm11
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
    27ab:	vpsrlq xmm1,xmm2,0x20
                        vp[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    27b0:	vmovq  xmm2,QWORD PTR [rax+0x18]
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
    27b5:	vpmovzxwd xmm1,xmm1
    27ba:	vmovq  xmm1,xmm1
    27be:	vcvtdq2ps xmm1,xmm1
                        vp[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    27c2:	vfmadd132ps xmm1,xmm2,xmm16
    27c8:	vaddps xmm12,xmm12,xmm8
    27cd:	vfmadd132ps xmm0,xmm1,xmm11
    27d2:	vmovlps QWORD PTR [rax+0x10],xmm12
    27d7:	vaddps xmm0,xmm0,xmm14
    27dc:	vmovlps QWORD PTR [rax+0x18],xmm0
                    for (int k = 0; k < x_floats - xf; ++k) {
    27e1:	mov    eax,r10d
    27e4:	and    eax,0xfffffff8
    27e7:	and    r10d,0x7
    27eb:	je     2ae0 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x2ae0>
    27f1:	add    r8d,eax
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
    27f4:	movsxd rdx,r8d
                    for (int k = 0; k < x_floats - xf; ++k) {
    27f7:	mov    ebx,DWORD PTR [rsp+0xc4]
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
    27fe:	lea    rax,[r13+rdx*1+0x0]
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
    2803:	lea    r10,[r12+rdx*1]
                        vp[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    2807:	lea    edx,[r14+r8*1]
    280b:	lea    r9,[rdi+rdx*4]
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
    280f:	movzx  edx,BYTE PTR [rsi+rax*1]
    2813:	movzx  eax,BYTE PTR [rsi+rax*1+0x3]
    2818:	vcvtusi2ss xmm0,xmm10,edx
    281e:	vmovaps xmm2,xmm0
    2822:	vcvtusi2ss xmm0,xmm10,eax
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
    2828:	movzx  eax,BYTE PTR [rsi+r10*1]
    282d:	vfmadd213ss xmm2,xmm4,DWORD PTR [r9]
    2832:	vcvtusi2ss xmm1,xmm10,eax
    2838:	movzx  eax,BYTE PTR [rsi+r10*1+0x3]
                        vp[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    283e:	vmulss xmm1,xmm1,xmm6
    2842:	vfmadd231ss xmm1,xmm5,xmm0
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
    2847:	vcvtusi2ss xmm0,xmm10,eax
                    for (int k = 0; k < x_floats - xf; ++k) {
    284d:	lea    eax,[r8+0x1]
                        vp[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    2851:	vfmadd132ss xmm0,xmm2,xmm7
    2856:	vaddss xmm0,xmm0,xmm1
    285a:	vmovss DWORD PTR [r9],xmm0
                    for (int k = 0; k < x_floats - xf; ++k) {
    285f:	cmp    eax,ebx
    2861:	jge    2ae0 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x2ae0>
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
    2867:	mov    edx,eax
                        vp[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    2869:	add    eax,r14d
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
    286c:	lea    r9,[rdx+r13*1]
                        vp[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    2870:	mov    eax,eax
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
    2872:	lea    r10,[rdx+r12*1]
                        vp[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    2876:	lea    rdx,[rdi+rax*4]
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
    287a:	movzx  eax,BYTE PTR [rsi+r9*1]
    287f:	vcvtusi2ss xmm0,xmm10,eax
    2885:	movzx  eax,BYTE PTR [rsi+r9*1+0x3]
    288b:	vmovaps xmm2,xmm0
    288f:	vcvtusi2ss xmm0,xmm10,eax
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
    2895:	movzx  eax,BYTE PTR [rsi+r10*1]
    289a:	vfmadd213ss xmm2,xmm4,DWORD PTR [rdx]
    289f:	vcvtusi2ss xmm1,xmm10,eax
    28a5:	movzx  eax,BYTE PTR [rsi+r10*1+0x3]
                        vp[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    28ab:	vmulss xmm1,xmm1,xmm6
    28af:	vfmadd231ss xmm1,xmm5,xmm0
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
    28b4:	vcvtusi2ss xmm0,xmm10,eax
                    for (int k = 0; k < x_floats - xf; ++k) {
    28ba:	lea    eax,[r8+0x2]
                        vp[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    28be:	vfmadd132ss xmm0,xmm2,xmm7
    28c3:	vaddss xmm0,xmm0,xmm1
    28c7:	vmovss DWORD PTR [rdx],xmm0
                    for (int k = 0; k < x_floats - xf; ++k) {
    28cb:	cmp    eax,ebx
    28cd:	jge    2ae0 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x2ae0>
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
    28d3:	mov    edx,eax
                        vp[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    28d5:	add    eax,r14d
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
    28d8:	lea    r9,[rdx+r13*1]
                        vp[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    28dc:	mov    eax,eax
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
    28de:	lea    r10,[rdx+r12*1]
                        vp[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    28e2:	lea    rdx,[rdi+rax*4]
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
    28e6:	movzx  eax,BYTE PTR [rsi+r9*1]
    28eb:	vcvtusi2ss xmm0,xmm10,eax
    28f1:	movzx  eax,BYTE PTR [rsi+r9*1+0x3]
    28f7:	vmovaps xmm2,xmm0
    28fb:	vcvtusi2ss xmm0,xmm10,eax
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
    2901:	movzx  eax,BYTE PTR [rsi+r10*1]
    2906:	vfmadd213ss xmm2,xmm4,DWORD PTR [rdx]
    290b:	vcvtusi2ss xmm1,xmm10,eax
    2911:	movzx  eax,BYTE PTR [rsi+r10*1+0x3]
                        vp[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    2917:	vmulss xmm1,xmm1,xmm6
    291b:	vfmadd231ss xmm1,xmm5,xmm0
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
    2920:	vcvtusi2ss xmm0,xmm10,eax
                    for (int k = 0; k < x_floats - xf; ++k) {
    2926:	lea    eax,[r8+0x3]
                        vp[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    292a:	vfmadd132ss xmm0,xmm2,xmm7
    292f:	vaddss xmm0,xmm0,xmm1
    2933:	vmovss DWORD PTR [rdx],xmm0
                    for (int k = 0; k < x_floats - xf; ++k) {
    2937:	cmp    ebx,eax
    2939:	jle    2ae0 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x2ae0>
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
    293f:	mov    edx,eax
                        vp[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    2941:	add    eax,r14d
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
    2944:	lea    r9,[r13+rdx*1+0x0]
                        vp[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    2949:	mov    eax,eax
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
    294b:	lea    r10,[r12+rdx*1]
                        vp[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    294f:	lea    rdx,[rdi+rax*4]
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
    2953:	movzx  eax,BYTE PTR [rsi+r9*1]
    2958:	vcvtusi2ss xmm0,xmm10,eax
    295e:	movzx  eax,BYTE PTR [rsi+r9*1+0x3]
    2964:	vmovaps xmm2,xmm0
    2968:	vcvtusi2ss xmm0,xmm10,eax
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
    296e:	movzx  eax,BYTE PTR [rsi+r10*1]
    2973:	vfmadd213ss xmm2,xmm4,DWORD PTR [rdx]
    2978:	vcvtusi2ss xmm1,xmm10,eax
    297e:	movzx  eax,BYTE PTR [rsi+r10*1+0x3]
                        vp[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    2984:	vmulss xmm1,xmm1,xmm6
    2988:	vfmadd231ss xmm1,xmm5,xmm0
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
    298d:	vcvtusi2ss xmm0,xmm10,eax
                    for (int k = 0; k < x_floats - xf; ++k) {
    2993:	lea    eax,[r8+0x4]
                        vp[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    2997:	vfmadd132ss xmm0,xmm2,xmm7
    299c:	vaddss xmm0,xmm0,xmm1
    29a0:	vmovss DWORD PTR [rdx],xmm0
                    for (int k = 0; k < x_floats - xf; ++k) {
    29a4:	cmp    eax,ebx
    29a6:	jge    2ae0 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x2ae0>
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
    29ac:	mov    edx,eax
                        vp[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    29ae:	add    eax,r14d
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
    29b1:	lea    r9,[rdx+r13*1]
                        vp[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    29b5:	mov    eax,eax
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
    29b7:	lea    r10,[rdx+r12*1]
                        vp[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    29bb:	lea    rdx,[rdi+rax*4]
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
    29bf:	movzx  eax,BYTE PTR [rsi+r9*1]
    29c4:	vcvtusi2ss xmm0,xmm10,eax
    29ca:	movzx  eax,BYTE PTR [rsi+r9*1+0x3]
    29d0:	vmovaps xmm2,xmm0
    29d4:	vcvtusi2ss xmm0,xmm10,eax
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
    29da:	movzx  eax,BYTE PTR [rsi+r10*1]
    29df:	vfmadd213ss xmm2,xmm4,DWORD PTR [rdx]
    29e4:	vcvtusi2ss xmm1,xmm10,eax
    29ea:	movzx  eax,BYTE PTR [rsi+r10*1+0x3]
                        vp[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    29f0:	vmulss xmm1,xmm1,xmm6
    29f4:	vfmadd231ss xmm1,xmm5,xmm0
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
    29f9:	vcvtusi2ss xmm0,xmm10,eax
                    for (int k = 0; k < x_floats - xf; ++k) {
    29ff:	lea    eax,[r8+0x5]
                        vp[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    2a03:	vfmadd132ss xmm0,xmm2,xmm7
    2a08:	vaddss xmm0,xmm0,xmm1
    2a0c:	vmovss DWORD PTR [rdx],xmm0
                    for (int k = 0; k < x_floats - xf; ++k) {
    2a10:	cmp    eax,ebx
    2a12:	jge    2ae0 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x2ae0>
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
    2a18:	mov    edx,eax
                        vp[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    2a1a:	add    eax,r14d
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
    2a1d:	lea    r9,[rdx+r13*1]
                        vp[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    2a21:	mov    eax,eax
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
    2a23:	lea    r10,[rdx+r12*1]
                        vp[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    2a27:	lea    rdx,[rdi+rax*4]
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
    2a2b:	movzx  eax,BYTE PTR [rsi+r9*1]
    2a30:	vcvtusi2ss xmm0,xmm10,eax
    2a36:	movzx  eax,BYTE PTR [rsi+r9*1+0x3]
    2a3c:	vmovaps xmm2,xmm0
    2a40:	vcvtusi2ss xmm0,xmm10,eax
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
    2a46:	movzx  eax,BYTE PTR [rsi+r10*1]
    2a4b:	vfmadd213ss xmm2,xmm4,DWORD PTR [rdx]
    2a50:	vcvtusi2ss xmm1,xmm10,eax
    2a56:	movzx  eax,BYTE PTR [rsi+r10*1+0x3]
                        vp[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    2a5c:	vmulss xmm1,xmm1,xmm6
    2a60:	vfmadd231ss xmm1,xmm5,xmm0
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
    2a65:	vcvtusi2ss xmm0,xmm10,eax
                    for (int k = 0; k < x_floats - xf; ++k) {
    2a6b:	lea    eax,[r8+0x6]
                        vp[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    2a6f:	vfmadd132ss xmm0,xmm2,xmm7
    2a74:	vaddss xmm0,xmm0,xmm1
    2a78:	vmovss DWORD PTR [rdx],xmm0
                    for (int k = 0; k < x_floats - xf; ++k) {
    2a7c:	cmp    eax,ebx
    2a7e:	jge    2ae0 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x2ae0>
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
    2a80:	mov    edx,eax
                        vp[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    2a82:	add    eax,r14d
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
    2a85:	lea    r8,[rdx+r13*1]
                        vp[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    2a89:	mov    eax,eax
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
    2a8b:	lea    r9,[rdx+r12*1]
                        vp[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    2a8f:	lea    rdx,[rdi+rax*4]
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
    2a93:	movzx  eax,BYTE PTR [rsi+r8*1]
    2a98:	vcvtusi2ss xmm0,xmm10,eax
    2a9e:	movzx  eax,BYTE PTR [rsi+r8*1+0x3]
    2aa4:	vfmadd213ss xmm4,xmm0,DWORD PTR [rdx]
    2aa9:	vcvtusi2ss xmm0,xmm10,eax
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
    2aaf:	movzx  eax,BYTE PTR [rsi+r9*1]
    2ab4:	vcvtusi2ss xmm1,xmm10,eax
    2aba:	movzx  eax,BYTE PTR [rsi+r9*1+0x3]
                        vp[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    2ac0:	vmulss xmm1,xmm1,xmm6
    2ac4:	vfmadd231ss xmm1,xmm5,xmm0
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
    2ac9:	vcvtusi2ss xmm0,xmm10,eax
                        vp[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    2acf:	vfmadd132ss xmm0,xmm4,xmm7
    2ad4:	vaddss xmm0,xmm0,xmm1
    2ad8:	vmovss DWORD PTR [rdx],xmm0
                    for (int k = 0; k < x_floats - xf; ++k) {
    2adc:	nop    DWORD PTR [rax+0x0]
            for (const SubParams& p : params) {
    2ae0:	add    rcx,0x30
    2ae4:	cmp    QWORD PTR [rsp+0xd8],rcx
    2aec:	jne    5a8 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x5a8>
    2af2:	mov    rbx,QWORD PTR [rsp+0x48]
    2af7:	mov    r12d,DWORD PTR [rsp+0x44]
    2afc:	mov    r15,QWORD PTR [rsp+0x38]
            for (int y = ty; y < tile_y_end; ++y) {
    2b01:	mov    r13d,DWORD PTR [rsp+0xd0]
    2b09:	cmp    r13d,DWORD PTR [rsp+0x40]
    2b0e:	jle    2c40 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x2c40>
    2b14:	test   r12d,r12d
    2b17:	jle    2c40 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x2c40>
    2b1d:	lea    rax,[rbx+rbx*2]
    2b21:	mov    rcx,QWORD PTR [rsp+0x58]
    2b26:	mov    rdi,QWORD PTR [rsp+0xe8]
    2b2e:	lea    r8d,[r12+r12*2]
    2b32:	lea    rbx,[rax*4+0x0]
    2b3a:	mov    rax,QWORD PTR [rsp+0xb8]
    2b42:	mov    r9,QWORD PTR [rsp+0x30]
    2b47:	mov    r10d,DWORD PTR [rsp+0xe4]
                    outp[x*3    ] = (unsigned char)std::clamp(vp[x*3    ] * inv_c + 0.5f, 0.0f, 255.0f);
    2b4f:	vmovss xmm3,DWORD PTR [rip+0x0]        # 2b57 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x2b57>
    2b57:	vmovss xmm5,DWORD PTR [rip+0x0]        # 2b5f <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x2b5f>
    2b5f:	mov    r14,QWORD PTR [rsp+0xc8]
    2b67:	lea    r11,[rcx+rax*4]
    2b6b:	mov    r12,rax
    2b6e:	xchg   ax,ax
                unsigned char* outp = output.data.data() + (size_t)(y * width + tx) * 3;
    2b70:	lea    rax,[r9+r12*1]
                    outp[x*3 + 1] = (unsigned char)std::clamp(vp[x*3 + 1] * inv_c + 0.5f, 0.0f, 255.0f);
                    outp[x*3 + 2] = (unsigned char)std::clamp(vp[x*3 + 2] * inv_c + 0.5f, 0.0f, 255.0f);
    2b74:	mov    QWORD PTR [rsp+0x1d0],r9
    2b7c:	vmovss xmm2,DWORD PTR [rip+0x0]        # 2b84 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x2b84>
    2b84:	lea    rcx,[r11+r9*4]
                unsigned char* outp = output.data.data() + (size_t)(y * width + tx) * 3;
    2b88:	lea    rsi,[rax+rax*2]
                    outp[x*3 + 2] = (unsigned char)std::clamp(vp[x*3 + 2] * inv_c + 0.5f, 0.0f, 255.0f);
    2b8c:	vmovss xmm4,DWORD PTR [rip+0x0]        # 2b94 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x2b94>
                unsigned char* outp = output.data.data() + (size_t)(y * width + tx) * 3;
    2b94:	xor    edx,edx
    2b96:	add    rsi,QWORD PTR [r15+0x10]
    2b9a:	nop    WORD PTR [rax+rax*1+0x0]
                    int c = counts[y * width + (tx + x)];
    2ba0:	mov    eax,DWORD PTR [rcx]
                    if (c == 0) continue;
    2ba2:	test   eax,eax
    2ba4:	je     2c16 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x2c16>
                    float inv_c = 1.0f / (float)c;
    2ba6:	vcvtsi2ss xmm0,xmm10,eax
                    outp[x*3    ] = (unsigned char)std::clamp(vp[x*3    ] * inv_c + 0.5f, 0.0f, 255.0f);
    2baa:	mov    eax,edx
      if (__a < __b)
    2bac:	xor    r9d,r9d
                    float inv_c = 1.0f / (float)c;
    2baf:	vdivss xmm0,xmm30,xmm0
                    outp[x*3    ] = (unsigned char)std::clamp(vp[x*3    ] * inv_c + 0.5f, 0.0f, 255.0f);
    2bb5:	vmulss xmm1,xmm0,DWORD PTR [rdi+rax*4]
    2bba:	vcomiss xmm29,xmm1
    2bc0:	ja     2bce <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x2bce>
    2bc2:	vaddss xmm1,xmm1,xmm3
      if (__b < __a)
    2bc6:	vminss xmm1,xmm1,xmm5
    2bca:	vcvttss2si r9d,xmm1
                    outp[x*3 + 1] = (unsigned char)std::clamp(vp[x*3 + 1] * inv_c + 0.5f, 0.0f, 255.0f);
    2bce:	vmulss xmm1,xmm0,DWORD PTR [rdi+rax*4+0x4]
                    outp[x*3    ] = (unsigned char)std::clamp(vp[x*3    ] * inv_c + 0.5f, 0.0f, 255.0f);
    2bd4:	mov    BYTE PTR [rsi+rax*1],r9b
      if (__a < __b)
    2bd8:	xor    r9d,r9d
    2bdb:	vcomiss xmm29,xmm1
    2be1:	ja     2bef <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x2bef>
                    outp[x*3 + 1] = (unsigned char)std::clamp(vp[x*3 + 1] * inv_c + 0.5f, 0.0f, 255.0f);
    2be3:	vaddss xmm1,xmm1,xmm3
      if (__b < __a)
    2be7:	vminss xmm1,xmm1,xmm2
    2beb:	vcvttss2si r9d,xmm1
                    outp[x*3 + 2] = (unsigned char)std::clamp(vp[x*3 + 2] * inv_c + 0.5f, 0.0f, 255.0f);
    2bef:	vmulss xmm0,xmm0,DWORD PTR [rdi+rax*4+0x8]
                    outp[x*3 + 1] = (unsigned char)std::clamp(vp[x*3 + 1] * inv_c + 0.5f, 0.0f, 255.0f);
    2bf5:	mov    BYTE PTR [rsi+rax*1+0x1],r9b
      if (__a < __b)
    2bfa:	xor    r9d,r9d
    2bfd:	vcomiss xmm29,xmm0
    2c03:	ja     2c11 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x2c11>
                    outp[x*3 + 2] = (unsigned char)std::clamp(vp[x*3 + 2] * inv_c + 0.5f, 0.0f, 255.0f);
    2c05:	vaddss xmm0,xmm0,xmm4
      if (__b < __a)
    2c09:	vminss xmm0,xmm0,xmm2
    2c0d:	vcvttss2si r9d,xmm0
    2c11:	mov    BYTE PTR [rsi+rax*1+0x2],r9b
                for (int x = 0; x < tile_w_actual; ++x) {
    2c16:	add    edx,0x3
    2c19:	add    rcx,0x4
    2c1d:	cmp    edx,r8d
    2c20:	jne    2ba0 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x2ba0>
            for (int y = ty; y < tile_y_end; ++y) {
    2c26:	mov    r9,QWORD PTR [rsp+0x1d0]
    2c2e:	inc    r10d
    2c31:	add    rdi,rbx
    2c34:	add    r9,r14
    2c37:	cmp    r13d,r10d
    2c3a:	jne    2b70 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x2b70>
        for (int tx = 0; tx < w; tx += TILE_W) {
    2c40:	add    QWORD PTR [rsp+0xb8],0x7f0
    2c4c:	mov    rax,QWORD PTR [rsp+0xb8]
    2c54:	cmp    DWORD PTR [rsp+0x98],eax
    2c5b:	jg     4bb <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x4bb>
    for (int ty = 0; ty < h; ty += TILE_H) {
    2c61:	add    QWORD PTR [rsp+0x78],0x8
    2c67:	mov    r12d,DWORD PTR [rsp+0x28]
    2c6c:	mov    r13,QWORD PTR [rsp+0x30]
    2c71:	mov    rax,QWORD PTR [rsp+0x10]
    2c76:	mov    rbx,QWORD PTR [rsp+0x78]
    2c7b:	cmp    r12d,ebx
    2c7e:	jle    32c4 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x32c4>
    2c84:	mov    DWORD PTR [rsp+0xe4],ebx
    2c8b:	add    r13,rax
        const int tile_y_end    = std::min(ty + TILE_H, h);
    2c8e:	lea    edx,[rbx+0x8]
        for (int tx = 0; tx < w; tx += TILE_W) {
    2c91:	jmp    47f <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x47f>
    2c96:	cs nop WORD PTR [rax+rax*1+0x0]
                    for (; xf + 8 <= x_floats; xf += 8) {
    2ca0:	mov    eax,DWORD PTR [rsp+0x1a0]
    2ca7:	mov    DWORD PTR [rsp+0x1a4],eax
                    int xf = 0;
    2cae:	xor    eax,eax
    2cb0:	mov    ebx,DWORD PTR [rsp+0x1a4]
    2cb7:	jmp    98f <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x98f>
    2cbc:	mov    eax,DWORD PTR [rsp+0x1a8]
    2cc3:	cmp    eax,0x3
    2cc6:	jle    32bd <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x32bd>
    2ccc:	sub    eax,0x2
    2ccf:	mov    r8,QWORD PTR [rsp+0x1b0]
    2cd7:	mov    r12,QWORD PTR [rsp+0x1c8]
    2cdf:	mov    DWORD PTR [rsp+0xc0],r9d
    2ce7:	mov    r10,QWORD PTR [rsp+0x1c0]
    2cef:	mov    rdi,QWORD PTR [rsp+0x1b8]
    2cf7:	mov    DWORD PTR [rsp+0x170],eax
    2cfe:	mov    rax,QWORD PTR [rsp+0x160]
    2d06:	lea    r13,[r8+r12*1]
    2d0a:	mov    DWORD PTR [rsp+0xfc],ebx
    2d11:	lea    r14,[r8+r10*1]
    2d15:	lea    r11,[r8+rdi*1]
    2d19:	mov    QWORD PTR [rsp+0xf0],rdx
    2d21:	lea    rsi,[rax*4+0x0]
    2d29:	movzx  r15d,BYTE PTR [r11]
    2d2d:	lea    rax,[rdx+rsi*1]
    2d31:	mov    QWORD PTR [rsp+0x150],rax
    2d39:	mov    rax,QWORD PTR [rsp+0x1d0]
    2d41:	add    rax,rsi
    2d44:	movzx  esi,BYTE PTR [r13+0x0]
    2d49:	mov    QWORD PTR [rsp+0x140],rax
                        float s0l = p.SUB[rb[0]+xf+k], s0r = p.SUB[rb[0]+xf+k+3];
    2d51:	mov    eax,0x3
    2d56:	mov    DWORD PTR [rsp+0x180],esi
    2d5d:	movzx  esi,BYTE PTR [r14]
    2d61:	mov    DWORD PTR [rsp+0x160],esi
    2d68:	mov    rsi,rdi
    2d6b:	movzx  edi,BYTE PTR [r8+rdi*1+0x1]
    2d71:	mov    DWORD PTR [rsp+0x130],edi
    2d78:	movzx  edi,BYTE PTR [r8+r12*1+0x1]
    2d7e:	mov    r12,r10
    2d81:	movzx  r10d,BYTE PTR [r8+r10*1+0x1]
    2d87:	mov    DWORD PTR [rsp+0x110],edi
    2d8e:	mov    rdi,QWORD PTR [rsp+0x150]
    2d96:	mov    DWORD PTR [rsp+0x190],r10d
    2d9e:	movzx  r10d,BYTE PTR [r8+rsi*1+0x2]
    2da4:	mov    rsi,QWORD PTR [rsp+0x1c8]
    2dac:	mov    DWORD PTR [rsp+0x100],r10d
    2db4:	mov    r10,r8
    2db7:	movzx  r10d,BYTE PTR [r10+r12*1+0x2]
    2dbd:	movzx  r8d,BYTE PTR [r8+rsi*1+0x2]
    2dc3:	mov    r12d,DWORD PTR [rsp+0x130]
    2dcb:	mov    rsi,QWORD PTR [rsp+0x140]
    2dd3:	mov    QWORD PTR [rsp+0x140],rcx
    2ddb:	mov    ebx,DWORD PTR [rsp+0x160]
    2de2:	mov    ecx,DWORD PTR [rsp+0x110]
    2de9:	mov    r9d,DWORD PTR [rsp+0x100]
    2df1:	vcvtusi2ss xmm8,xmm10,r15d
                        float s1l = p.SUB[rb[1]+xf+k], s1r = p.SUB[rb[1]+xf+k+3];
    2df7:	movzx  edx,BYTE PTR [r13+rax*1+0x0]
                        float s0l = p.SUB[rb[0]+xf+k], s0r = p.SUB[rb[0]+xf+k+3];
    2dfd:	movzx  r15d,BYTE PTR [r11+rax*1]
    2e02:	vmovaps xmm16,xmm6
                        float s2l = p.SUB[rb[2]+xf+k], s2r = p.SUB[rb[2]+xf+k+3];
    2e08:	vcvtusi2ss xmm12,xmm10,ebx
    2e0e:	movzx  ebx,BYTE PTR [r14+rax*1]
    2e13:	mov    QWORD PTR [rsp+0x150],rax
    2e1b:	add    rdi,0xc
                        float s1l = p.SUB[rb[1]+xf+k], s1r = p.SUB[rb[1]+xf+k+3];
    2e1f:	vcvtusi2ss xmm13,xmm10,DWORD PTR [rsp+0x180]
    2e27:	mov    DWORD PTR [rsp+0x180],edx
    2e2e:	add    rsi,0xc
                        float s0l = p.SUB[rb[0]+xf+k], s0r = p.SUB[rb[0]+xf+k+3];
    2e32:	vmovaps xmm15,xmm8
                        float s1l = p.SUB[rb[1]+xf+k], s1r = p.SUB[rb[1]+xf+k+3];
    2e37:	vcvtusi2ss xmm8,xmm10,edx
                        float s2l = p.SUB[rb[2]+xf+k], s2r = p.SUB[rb[2]+xf+k+3];
    2e3d:	movzx  edx,BYTE PTR [r14+rax*1+0x1]
    2e43:	vmovaps xmm14,xmm12
                        float s0l = p.SUB[rb[0]+xf+k], s0r = p.SUB[rb[0]+xf+k+3];
    2e48:	vcvtusi2ss xmm12,xmm10,r15d
    2e4e:	vfmadd213ss xmm16,xmm13,DWORD PTR [rdi-0xc]
                        vp0[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    2e55:	vmulss xmm18,xmm7,xmm8
    2e5b:	vfmadd132ss xmm12,xmm18,xmm5
    2e61:	vaddss xmm12,xmm12,xmm16
    2e67:	vmovaps xmm16,xmm6
    2e6d:	vfmadd231ss xmm12,xmm4,xmm15
    2e72:	vmovss DWORD PTR [rdi-0xc],xmm12
                        float s2l = p.SUB[rb[2]+xf+k], s2r = p.SUB[rb[2]+xf+k+3];
    2e77:	vcvtusi2ss xmm12,xmm10,ebx
    2e7d:	vfmadd213ss xmm13,xmm4,DWORD PTR [rsi-0xc]
                        vp1[xf+k] += p.A*s1l + p.B*s1r + p.C*s2l + p.D*s2r;
    2e83:	vmulss xmm12,xmm12,xmm7
    2e87:	vfmadd132ss xmm8,xmm12,xmm5
                        float s2l = p.SUB[rb[2]+xf+k], s2r = p.SUB[rb[2]+xf+k+3];
    2e8c:	vcvtusi2ss xmm12,xmm10,DWORD PTR [rsp+0x190]
    2e94:	mov    DWORD PTR [rsp+0x190],edx
                        vp1[xf+k] += p.A*s1l + p.B*s1r + p.C*s2l + p.D*s2r;
    2e9b:	vaddss xmm8,xmm8,xmm13
                        float s1l = p.SUB[rb[1]+xf+k], s1r = p.SUB[rb[1]+xf+k+3];
    2ea0:	vcvtusi2ss xmm13,xmm10,ecx
    2ea6:	movzx  ecx,BYTE PTR [r13+rax*1+0x1]
                        vp1[xf+k] += p.A*s1l + p.B*s1r + p.C*s2l + p.D*s2r;
    2eac:	vfmadd231ss xmm8,xmm6,xmm14
                        float s2l = p.SUB[rb[2]+xf+k], s2r = p.SUB[rb[2]+xf+k+3];
    2eb1:	vmovaps xmm14,xmm12
                        vp1[xf+k] += p.A*s1l + p.B*s1r + p.C*s2l + p.D*s2r;
    2eb6:	vmovss DWORD PTR [rsi-0xc],xmm8
                        float s0l = p.SUB[rb[0]+xf+k], s0r = p.SUB[rb[0]+xf+k+3];
    2ebb:	vcvtusi2ss xmm8,xmm10,r12d
    2ec1:	movzx  r12d,BYTE PTR [r11+rax*1+0x1]
    2ec7:	vfmadd213ss xmm16,xmm13,DWORD PTR [rdi-0x8]
    2ece:	vcvtusi2ss xmm12,xmm10,r12d
    2ed4:	vmovaps xmm15,xmm8
                        float s1l = p.SUB[rb[1]+xf+k], s1r = p.SUB[rb[1]+xf+k+3];
    2ed9:	vcvtusi2ss xmm8,xmm10,ecx
                        vp0[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    2edf:	vmulss xmm18,xmm7,xmm8
    2ee5:	vfmadd132ss xmm12,xmm18,xmm5
    2eeb:	vaddss xmm12,xmm12,xmm16
    2ef1:	vmovaps xmm16,xmm6
    2ef7:	vfmadd231ss xmm12,xmm4,xmm15
    2efc:	vmovss DWORD PTR [rdi-0x8],xmm12
                        float s2l = p.SUB[rb[2]+xf+k], s2r = p.SUB[rb[2]+xf+k+3];
    2f01:	vcvtusi2ss xmm12,xmm10,edx
    2f07:	vfmadd213ss xmm13,xmm4,DWORD PTR [rsi-0x8]
                        vp1[xf+k] += p.A*s1l + p.B*s1r + p.C*s2l + p.D*s2r;
    2f0d:	vmulss xmm12,xmm12,xmm7
    2f11:	vfmadd132ss xmm8,xmm12,xmm5
                        float s2l = p.SUB[rb[2]+xf+k], s2r = p.SUB[rb[2]+xf+k+3];
    2f16:	vcvtusi2ss xmm12,xmm10,r10d
    2f1c:	movzx  r10d,BYTE PTR [r14+rax*1+0x2]
                        vp1[xf+k] += p.A*s1l + p.B*s1r + p.C*s2l + p.D*s2r;
    2f22:	vaddss xmm8,xmm8,xmm13
                        float s1l = p.SUB[rb[1]+xf+k], s1r = p.SUB[rb[1]+xf+k+3];
    2f27:	vcvtusi2ss xmm13,xmm10,r8d
    2f2d:	movzx  r8d,BYTE PTR [r13+rax*1+0x2]
                        vp1[xf+k] += p.A*s1l + p.B*s1r + p.C*s2l + p.D*s2r;
    2f33:	vfmadd231ss xmm8,xmm6,xmm14
                        float s2l = p.SUB[rb[2]+xf+k], s2r = p.SUB[rb[2]+xf+k+3];
    2f38:	vmovaps xmm14,xmm12
                        vp1[xf+k] += p.A*s1l + p.B*s1r + p.C*s2l + p.D*s2r;
    2f3d:	vmovss DWORD PTR [rsi-0x8],xmm8
                        float s0l = p.SUB[rb[0]+xf+k], s0r = p.SUB[rb[0]+xf+k+3];
    2f42:	vcvtusi2ss xmm8,xmm10,r9d
    2f48:	movzx  r9d,BYTE PTR [r11+rax*1+0x2]
    2f4e:	add    rax,0x3
    2f52:	vfmadd213ss xmm16,xmm13,DWORD PTR [rdi-0x4]
    2f59:	lea    edx,[rax-0x2]
    2f5c:	vcvtusi2ss xmm12,xmm10,r9d
    2f62:	vmovaps xmm15,xmm8
                        float s1l = p.SUB[rb[1]+xf+k], s1r = p.SUB[rb[1]+xf+k+3];
    2f67:	vcvtusi2ss xmm8,xmm10,r8d
                        vp0[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    2f6d:	vmulss xmm18,xmm7,xmm8
    2f73:	vfmadd132ss xmm12,xmm18,xmm5
    2f79:	vaddss xmm12,xmm12,xmm16
    2f7f:	vfmadd231ss xmm12,xmm4,xmm15
    2f84:	vmovss DWORD PTR [rdi-0x4],xmm12
                        float s2l = p.SUB[rb[2]+xf+k], s2r = p.SUB[rb[2]+xf+k+3];
    2f89:	vcvtusi2ss xmm12,xmm10,r10d
    2f8f:	vfmadd213ss xmm13,xmm4,DWORD PTR [rsi-0x4]
                        vp1[xf+k] += p.A*s1l + p.B*s1r + p.C*s2l + p.D*s2r;
    2f95:	vmulss xmm12,xmm12,xmm7
    2f99:	vfmadd132ss xmm8,xmm12,xmm5
    2f9e:	vaddss xmm8,xmm8,xmm13
    2fa3:	vfmadd231ss xmm8,xmm6,xmm14
    2fa8:	vmovss DWORD PTR [rsi-0x4],xmm8
                    for (int k = 0; k < x_floats - xf; ++k) {
    2fad:	cmp    DWORD PTR [rsp+0x170],edx
    2fb4:	jg     2df1 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x2df1>
    2fba:	mov    ebx,DWORD PTR [rsp+0xfc]
    2fc1:	mov    rdx,QWORD PTR [rsp+0xf0]
    2fc9:	mov    r9d,DWORD PTR [rsp+0xc0]
    2fd1:	mov    rcx,QWORD PTR [rsp+0x140]
    2fd9:	mov    edi,DWORD PTR [rsp+0x150]
                        float s1l = p.SUB[rb[1]+xf+k], s1r = p.SUB[rb[1]+xf+k+3];
    2fe0:	mov    r12,QWORD PTR [rsp+0x1c8]
    2fe8:	mov    r14,QWORD PTR [rsp+0x1b0]
                        float s0l = p.SUB[rb[0]+xf+k], s0r = p.SUB[rb[0]+xf+k+3];
    2ff0:	mov    r8d,edi
                        float s2l = p.SUB[rb[2]+xf+k], s2r = p.SUB[rb[2]+xf+k+3];
    2ff3:	mov    r13,QWORD PTR [rsp+0x1c0]
                        float s0l = p.SUB[rb[0]+xf+k], s0r = p.SUB[rb[0]+xf+k+3];
    2ffb:	mov    r15,QWORD PTR [rsp+0x1b8]
                        float s1l = p.SUB[rb[1]+xf+k], s1r = p.SUB[rb[1]+xf+k+3];
    3003:	lea    rax,[r8+r12*1]
                        vp1[xf+k] += p.A*s1l + p.B*s1r + p.C*s2l + p.D*s2r;
    3007:	mov    r11,QWORD PTR [rsp+0x1d0]
                        float s1l = p.SUB[rb[1]+xf+k], s1r = p.SUB[rb[1]+xf+k+3];
    300f:	movzx  esi,BYTE PTR [r14+rax*1]
    3014:	movzx  eax,BYTE PTR [r14+rax*1+0x3]
                        float s0l = p.SUB[rb[0]+xf+k], s0r = p.SUB[rb[0]+xf+k+3];
    301a:	lea    r10,[r8+r15*1]
                        float s1l = p.SUB[rb[1]+xf+k], s1r = p.SUB[rb[1]+xf+k+3];
    301e:	vcvtusi2ss xmm13,xmm10,eax
                        float s2l = p.SUB[rb[2]+xf+k], s2r = p.SUB[rb[2]+xf+k+3];
    3024:	lea    rax,[r8+r13*1]
                        float s1l = p.SUB[rb[1]+xf+k], s1r = p.SUB[rb[1]+xf+k+3];
    3028:	vcvtusi2ss xmm14,xmm10,esi
                        float s2l = p.SUB[rb[2]+xf+k], s2r = p.SUB[rb[2]+xf+k+3];
    302e:	movzx  esi,BYTE PTR [r14+rax*1]
    3033:	movzx  eax,BYTE PTR [r14+rax*1+0x3]
    3039:	vcvtusi2ss xmm8,xmm10,esi
                        vp0[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    303f:	vmulss xmm18,xmm6,xmm14
                        vp1[xf+k] += p.A*s1l + p.B*s1r + p.C*s2l + p.D*s2r;
    3045:	vmulss xmm15,xmm6,xmm8
                        float s2l = p.SUB[rb[2]+xf+k], s2r = p.SUB[rb[2]+xf+k+3];
    304a:	vcvtusi2ss xmm8,xmm10,eax
                        vp0[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    3050:	mov    eax,DWORD PTR [rsp+0x1a4]
    3057:	add    eax,edi
    3059:	mov    eax,eax
    305b:	lea    r8,[rax*4+0x0]
                        float s0l = p.SUB[rb[0]+xf+k], s0r = p.SUB[rb[0]+xf+k+3];
    3063:	movzx  eax,BYTE PTR [r14+r10*1]
                        float s2l = p.SUB[rb[2]+xf+k], s2r = p.SUB[rb[2]+xf+k+3];
    3068:	vmovaps xmm12,xmm8
                        float s0l = p.SUB[rb[0]+xf+k], s0r = p.SUB[rb[0]+xf+k+3];
    306d:	vcvtusi2ss xmm8,xmm10,eax
    3073:	movzx  eax,BYTE PTR [r14+r10*1+0x3]
                    for (int k = 0; k < x_floats - xf; ++k) {
    3079:	lea    r10d,[rdi+0x1]
                        float s0l = p.SUB[rb[0]+xf+k], s0r = p.SUB[rb[0]+xf+k+3];
    307d:	vcvtusi2ss xmm16,xmm10,eax
    3083:	vfmadd213ss xmm8,xmm4,DWORD PTR [rdx+r8*1]
    3089:	vfmadd132ss xmm16,xmm18,xmm5
                        vp0[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    308f:	vfmadd231ss xmm8,xmm7,xmm13
    3094:	vfmadd132ss xmm13,xmm15,xmm5
    3099:	vaddss xmm8,xmm8,xmm16
    309f:	vmovss DWORD PTR [rdx+r8*1],xmm8
                        vp1[xf+k] += p.A*s1l + p.B*s1r + p.C*s2l + p.D*s2r;
    30a5:	vfmadd213ss xmm14,xmm4,DWORD PTR [r11+r8*1]
    30ab:	vfmadd132ss xmm12,xmm14,xmm7
    30b0:	vaddss xmm8,xmm12,xmm13
    30b5:	vmovss DWORD PTR [r11+r8*1],xmm8
                    for (int k = 0; k < x_floats - xf; ++k) {
    30bb:	cmp    r10d,DWORD PTR [rsp+0x1a8]
    30c3:	jge    1ff8 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x1ff8>
                        float s0l = p.SUB[rb[0]+xf+k], s0r = p.SUB[rb[0]+xf+k+3];
    30c9:	mov    r8d,r10d
                        float s1l = p.SUB[rb[1]+xf+k], s1r = p.SUB[rb[1]+xf+k+3];
    30cc:	lea    rax,[r8+r12*1]
                        float s0l = p.SUB[rb[0]+xf+k], s0r = p.SUB[rb[0]+xf+k+3];
    30d0:	lea    r11,[r8+r15*1]
                        float s1l = p.SUB[rb[1]+xf+k], s1r = p.SUB[rb[1]+xf+k+3];
    30d4:	movzx  esi,BYTE PTR [r14+rax*1]
    30d9:	movzx  eax,BYTE PTR [r14+rax*1+0x3]
    30df:	vcvtusi2ss xmm13,xmm10,eax
                        float s2l = p.SUB[rb[2]+xf+k], s2r = p.SUB[rb[2]+xf+k+3];
    30e5:	lea    rax,[r8+r13*1]
                        float s1l = p.SUB[rb[1]+xf+k], s1r = p.SUB[rb[1]+xf+k+3];
    30e9:	vcvtusi2ss xmm14,xmm10,esi
                        float s2l = p.SUB[rb[2]+xf+k], s2r = p.SUB[rb[2]+xf+k+3];
    30ef:	movzx  esi,BYTE PTR [r14+rax*1]
    30f4:	movzx  eax,BYTE PTR [r14+rax*1+0x3]
    30fa:	vcvtusi2ss xmm8,xmm10,esi
                        vp0[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    3100:	vmulss xmm18,xmm6,xmm14
                        vp1[xf+k] += p.A*s1l + p.B*s1r + p.C*s2l + p.D*s2r;
    3106:	vmulss xmm15,xmm6,xmm8
                        float s2l = p.SUB[rb[2]+xf+k], s2r = p.SUB[rb[2]+xf+k+3];
    310b:	vcvtusi2ss xmm8,xmm10,eax
                        vp0[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    3111:	mov    eax,DWORD PTR [rsp+0x1a4]
    3118:	add    eax,r10d
    311b:	mov    eax,eax
    311d:	lea    r8,[rax*4+0x0]
                        float s0l = p.SUB[rb[0]+xf+k], s0r = p.SUB[rb[0]+xf+k+3];
    3125:	movzx  eax,BYTE PTR [r14+r11*1]
                        float s2l = p.SUB[rb[2]+xf+k], s2r = p.SUB[rb[2]+xf+k+3];
    312a:	vmovaps xmm12,xmm8
                        float s0l = p.SUB[rb[0]+xf+k], s0r = p.SUB[rb[0]+xf+k+3];
    312f:	vcvtusi2ss xmm8,xmm10,eax
    3135:	movzx  eax,BYTE PTR [r14+r11*1+0x3]
                        vp1[xf+k] += p.A*s1l + p.B*s1r + p.C*s2l + p.D*s2r;
    313b:	mov    r11,QWORD PTR [rsp+0x1d0]
                        float s0l = p.SUB[rb[0]+xf+k], s0r = p.SUB[rb[0]+xf+k+3];
    3143:	vcvtusi2ss xmm16,xmm10,eax
    3149:	vfmadd213ss xmm8,xmm4,DWORD PTR [rdx+r8*1]
    314f:	vfmadd132ss xmm16,xmm18,xmm5
                        vp0[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    3155:	vfmadd231ss xmm8,xmm7,xmm13
    315a:	vfmadd132ss xmm13,xmm15,xmm5
    315f:	vaddss xmm8,xmm8,xmm16
    3165:	vmovss DWORD PTR [rdx+r8*1],xmm8
                        vp1[xf+k] += p.A*s1l + p.B*s1r + p.C*s2l + p.D*s2r;
    316b:	vfmadd213ss xmm14,xmm4,DWORD PTR [r11+r8*1]
    3171:	vfmadd132ss xmm12,xmm14,xmm7
    3176:	vaddss xmm8,xmm12,xmm13
    317b:	vmovss DWORD PTR [r11+r8*1],xmm8
                    for (int k = 0; k < x_floats - xf; ++k) {
    3181:	lea    r8d,[rdi+0x2]
    3185:	cmp    r8d,DWORD PTR [rsp+0x1a8]
    318d:	jge    1ff8 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x1ff8>
                        float s0l = p.SUB[rb[0]+xf+k], s0r = p.SUB[rb[0]+xf+k+3];
    3193:	mov    edi,r8d
                        float s1l = p.SUB[rb[1]+xf+k], s1r = p.SUB[rb[1]+xf+k+3];
    3196:	lea    rax,[r12+rdi*1]
                        float s0l = p.SUB[rb[0]+xf+k], s0r = p.SUB[rb[0]+xf+k+3];
    319a:	lea    r10,[r15+rdi*1]
                        float s1l = p.SUB[rb[1]+xf+k], s1r = p.SUB[rb[1]+xf+k+3];
    319e:	movzx  esi,BYTE PTR [r14+rax*1]
    31a3:	movzx  eax,BYTE PTR [r14+rax*1+0x3]
    31a9:	vcvtusi2ss xmm13,xmm10,eax
                        float s2l = p.SUB[rb[2]+xf+k], s2r = p.SUB[rb[2]+xf+k+3];
    31af:	lea    rax,[r13+rdi*1+0x0]
                        float s1l = p.SUB[rb[1]+xf+k], s1r = p.SUB[rb[1]+xf+k+3];
    31b4:	vcvtusi2ss xmm14,xmm10,esi
                        float s2l = p.SUB[rb[2]+xf+k], s2r = p.SUB[rb[2]+xf+k+3];
    31ba:	movzx  esi,BYTE PTR [r14+rax*1]
    31bf:	movzx  eax,BYTE PTR [r14+rax*1+0x3]
    31c5:	vcvtusi2ss xmm8,xmm10,esi
                        vp1[xf+k] += p.A*s1l + p.B*s1r + p.C*s2l + p.D*s2r;
    31cb:	vmulss xmm15,xmm6,xmm8
                        float s2l = p.SUB[rb[2]+xf+k], s2r = p.SUB[rb[2]+xf+k+3];
    31d0:	vcvtusi2ss xmm8,xmm10,eax
                        vp0[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    31d6:	mov    eax,DWORD PTR [rsp+0x1a4]
    31dd:	add    eax,r8d
    31e0:	mov    eax,eax
                        float s2l = p.SUB[rb[2]+xf+k], s2r = p.SUB[rb[2]+xf+k+3];
    31e2:	vmovaps xmm12,xmm8
                        vp0[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    31e7:	jmp    1f9c <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x1f9c>
                    for (; xf + 8 <= x_floats; xf += 8) {
    31ec:	mov    DWORD PTR [rsp+0x1a8],eax
    31f3:	mov    rax,QWORD PTR [rcx+0x28]
                    int xf = 0;
    31f7:	mov    DWORD PTR [rsp+0x1a4],0x0
    3202:	mov    QWORD PTR [rsp+0x1b0],rax
    320a:	jmp    d85 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0xd85>
    320f:	mov    rax,QWORD PTR [rsp+0x1d0]
                    for (int k = 0; k < x_floats - xf; ++k) {
    3217:	mov    edx,DWORD PTR [rsp+0xc4]
    321e:	lea    rsi,[rdi+rax*4]
    3222:	xor    eax,eax
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
    3224:	movzx  edi,BYTE PTR [r9+rax*1]
    3229:	vcvtusi2ss xmm0,xmm10,edi
    322f:	movzx  edi,BYTE PTR [r9+rax*1+0x3]
    3235:	vmovaps xmm2,xmm0
    3239:	vcvtusi2ss xmm0,xmm10,edi
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
    323f:	movzx  edi,BYTE PTR [r8+rax*1]
    3244:	vfmadd213ss xmm2,xmm4,DWORD PTR [rsi+rax*4]
    324a:	vcvtusi2ss xmm1,xmm10,edi
    3250:	movzx  edi,BYTE PTR [r8+rax*1+0x3]
                        vp[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    3256:	vmulss xmm1,xmm1,xmm6
    325a:	vfmadd231ss xmm1,xmm5,xmm0
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
    325f:	vcvtusi2ss xmm0,xmm10,edi
                        vp[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    3265:	vfmadd132ss xmm0,xmm2,xmm7
    326a:	vaddss xmm0,xmm0,xmm1
    326e:	vmovss DWORD PTR [rsi+rax*4],xmm0
                    for (int k = 0; k < x_floats - xf; ++k) {
    3273:	inc    rax
    3276:	cmp    edx,eax
    3278:	jg     3224 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x3224>
            for (const SubParams& p : params) {
    327a:	add    rcx,0x30
    327e:	cmp    QWORD PTR [rsp+0xd8],rcx
    3286:	jne    5a8 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x5a8>
    328c:	jmp    2af2 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x2af2>
                    for (int k = 0; k < x_floats - xf; ++k) {
    3291:	xor    eax,eax
    3293:	jmp    15e0 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x15e0>
                        float s0l = p.SUB[rb[0]+xf+k], s0r = p.SUB[rb[0]+xf+k+3];
    3298:	xor    r10d,r10d
                    for (int k = 0; k < x_floats - xf; ++k) {
    329b:	xor    r8d,r8d
    329e:	jmp    121e <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x121e>
                    int xf = 0;
    32a3:	xor    r14d,r14d
    32a6:	jmp    211e <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x211e>
                    for (int k = 0; k < x_floats - xf; ++k) {
    32ab:	xor    eax,eax
    32ad:	jmp    25af <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x25af>
                    int xf = 0;
    32b2:	xor    r9d,r9d
                    for (int k = 0; k < x_floats - xf; ++k) {
    32b5:	xor    r8d,r8d
    32b8:	jmp    23cd <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x23cd>
                        float s0l = p.SUB[rb[0]+xf+k], s0r = p.SUB[rb[0]+xf+k+3];
    32bd:	xor    edi,edi
    32bf:	jmp    2fe0 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x2fe0>
    32c4:	mov    r13,QWORD PTR [rsp+0x20]
    32c9:	mov    r14,QWORD PTR [rsp+0x18]
    32ce:	vzeroupper
	_GLIBCXX_OPERATOR_DELETE(_GLIBCXX_SIZED_DEALLOC(__p, __n));
    32d1:	mov    rdi,QWORD PTR [rsp+0xe8]
    32d9:	mov    esi,0x2fa00
    32de:	call   32e3 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x32e3>
    32e3:	mov    rax,QWORD PTR [rsp+0x58]
    32e8:	test   rax,rax
    32eb:	je     32f8 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x32f8>
    32ed:	mov    rsi,r13
    32f0:	mov    rdi,rax
    32f3:	call   32f8 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x32f8>
    32f8:	mov    rdi,QWORD PTR [rsp+0x80]
    3300:	test   rdi,rdi
    3303:	je     3310 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x3310>
	ptrdiff_t __n = _M_impl._M_end_of_storage - _M_impl._M_start;
    3305:	mov    rsi,r14
    3308:	sub    rsi,rdi
    330b:	call   3310 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x3310>
            }
        }
    }

    return output;
}
    3310:	lea    rsp,[rbp-0x28]
    3314:	mov    rax,r15
    3317:	pop    rbx
    3318:	pop    r12
    331a:	pop    r13
    331c:	pop    r14
    331e:	pop    r15
    3320:	pop    rbp
    3321:	ret
        for (const auto& p : params) {
    3322:	mov    rcx,QWORD PTR [rsp+0xd8]
	return __n != 0 ? _Tr::allocate(_M_impl, __n) : pointer();
    332a:	xor    edi,edi
    332c:	cmp    QWORD PTR [rsp+0x80],rcx
    3334:	jne    27b <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x27b>
        for (int y = 0; y < h; ++y) {
    333a:	test   r12d,r12d
    333d:	jle    3b9 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x3b9>
    3343:	mov    esi,DWORD PTR [rsp+0x98]
    334a:	test   esi,esi
    334c:	jg     2e4 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x2e4>
    3352:	jmp    3b9 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x3b9>
    3357:	nop    WORD PTR [rax+rax*1+0x0]
    const int w = static_cast<int>(width);
    3360:	mov    eax,DWORD PTR [rsp+0xc8]
    const int h = static_cast<int>(height);
    3367:	mov    r12d,DWORD PTR [rsp+0x1c8]
	: _M_start(), _M_finish(), _M_end_of_storage()
    336f:	mov    QWORD PTR [rsp+0x80],0x0
    337b:	xor    r14d,r14d
    const int w = static_cast<int>(width);
    337e:	mov    DWORD PTR [rsp+0x98],eax
    for (auto& sub : subapertures) {
    3385:	cmp    rbx,QWORD PTR [rsp+0x1d0]
    338d:	jne    bc <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0xbc>
    3393:	mov    QWORD PTR [rsp+0xd8],0x0
	return __n != 0 ? _Tr::allocate(_M_impl, __n) : pointer();
    339f:	mov    QWORD PTR [rsp+0x58],0x0
    33a8:	jmp    211 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x211>
	ptrdiff_t __dif = this->_M_impl._M_finish - this->_M_impl._M_start;
    33ad:	mov    rax,r14
    33b0:	sub    rax,QWORD PTR [rsp+0x80]
    33b8:	mov    QWORD PTR [rsp+0x1c0],rax
    33c0:	sar    rax,0x4
    33c4:	mov    rdx,rax
    33c7:	movabs rax,0xaaaaaaaaaaaaaaab
    33d1:	imul   rdx,rax
	if (max_size() - size() < __n)
    33d5:	movabs rax,0x2aaaaaaaaaaaaaa
    33df:	cmp    rdx,rax
    33e2:	je     33e8 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x33e8>
      if (__a < __b)
    33e8:	test   rdx,rdx
    33eb:	mov    eax,0x1
    33f0:	mov    DWORD PTR [rsp+0x128],r11d
    33f8:	cmovne rax,rdx
    33fc:	mov    DWORD PTR [rsp+0x160],r10d
    3404:	mov    DWORD PTR [rsp+0x130],r8d
	const size_type __len = size() + (std::max)(size(), __n);
    340c:	add    rax,rdx
	return (__len < size() || __len > max_size()) ? max_size() : __len;
    340f:	movabs rdx,0x2aaaaaaaaaaaaaa
    3419:	mov    DWORD PTR [rsp+0x140],ecx
    3420:	cmp    rax,rdx
    3423:	mov    DWORD PTR [rsp+0x180],esi
    342a:	cmova  rax,rdx
    342e:	mov    DWORD PTR [rsp+0x190],r9d
      allocate(size_type __n, const void* = static_cast<const void*>(0))
    3436:	vmovss DWORD PTR [rsp+0x150],xmm3
	  return static_cast<_Tp*>(_GLIBCXX_OPERATOR_NEW(__n * sizeof(_Tp)));
    343f:	lea    rax,[rax+rax*2]
    3443:	vmovss DWORD PTR [rsp+0x168],xmm0
    344c:	shl    rax,0x4
    3450:	vmovss DWORD PTR [rsp+0x1a0],xmm1
    3459:	mov    rdi,rax
    345c:	mov    QWORD PTR [rsp+0x1a8],rax
    3464:	vmovss DWORD PTR [rsp+0x170],xmm2
    346d:	call   3472 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x3472>
	// taking the element by lvalue ref (see last bullet of C++11
	// [res.on.arguments]).

	// If this throws, the existing elements are unchanged.
#if __cplusplus >= 201103L
	_Alloc_traits::construct(this->_M_impl,
    3472:	mov    rdx,QWORD PTR [rsp+0x1c0]
	{ ::new((void *)__p) _Up(std::forward<_Args>(__args)...); }
    347a:	mov    ecx,DWORD PTR [rsp+0x140]
	  return static_cast<_Tp*>(_GLIBCXX_OPERATOR_NEW(__n * sizeof(_Tp)));
    3481:	mov    QWORD PTR [rsp+0x1b8],rax
    3489:	mov    rdi,rax
	{ ::new((void *)__p) _Up(std::forward<_Args>(__args)...); }
    348c:	vmovss xmm0,DWORD PTR [rsp+0x168]
    3495:	vmovss xmm2,DWORD PTR [rsp+0x170]
    349e:	mov    r9d,DWORD PTR [rsp+0x190]
    34a6:	mov    esi,DWORD PTR [rsp+0x180]
    34ad:	mov    DWORD PTR [rax+rdx*1+0x18],ecx
    34b1:	vinsertps xmm0,xmm0,DWORD PTR [rsp+0x150],0x10
    34bc:	vinsertps xmm2,xmm2,DWORD PTR [rsp+0x1a0],0x10
    34c7:	mov    r10d,DWORD PTR [rsp+0x160]
    34cf:	mov    r8d,DWORD PTR [rsp+0x130]
    34d7:	mov    DWORD PTR [rax+rdx*1],r9d
    34db:	mov    r11d,DWORD PTR [rsp+0x128]
    34e3:	mov    rcx,QWORD PTR [rsp+0x1b0]
    34eb:	vmovlhps xmm2,xmm2,xmm0
    34ef:	mov    DWORD PTR [rax+rdx*1+0x4],esi
    34f3:	mov    DWORD PTR [rax+rdx*1+0x1c],r10d
    34f8:	mov    DWORD PTR [rax+rdx*1+0x20],r8d
    34fd:	mov    DWORD PTR [rax+rdx*1+0x24],r11d
    3502:	mov    QWORD PTR [rax+rdx*1+0x28],rcx
    3507:	vmovups XMMWORD PTR [rax+rdx*1+0x8],xmm2
    __relocate_a_1(_Tp* __first, _Tp* __last,
		   _Tp* __result,
		   [[__maybe_unused__]] allocator<_Up>& __alloc) noexcept
    {
      ptrdiff_t __count = __last - __first;
      if (__count > 0)
    350d:	test   rdx,rdx
    3510:	je     351f <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x351f>
	      __gnu_cxx::__normal_iterator<_Tp*, void> __out(__result);
	      __out = std::__relocate_a_1(__first, __last, __out, __alloc);
	      return __out.base();
	    }
#endif
	  __builtin_memcpy(__result, __first, __count * sizeof(_Tp));
    3512:	mov    rsi,QWORD PTR [rsp+0x80]
    351a:	call   351f <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x351f>
	  {
	    // Relocation cannot throw.
	    __new_finish = std::__relocate_a(__old_start, __old_finish,
					     __new_start,
					     _M_get_Tp_allocator());
	    ++__new_finish;
    351f:	mov    rax,QWORD PTR [rsp+0x1b8]
    3527:	mov    rcx,QWORD PTR [rsp+0x1c0]
	  if (_M_storage)
    352f:	mov    rdi,QWORD PTR [rsp+0x80]
    3537:	lea    rax,[rax+rcx*1+0x30]
    353c:	mov    QWORD PTR [rsp+0xd8],rax
    3544:	test   rdi,rdi
    3547:	je     3554 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x3554>
	    // New storage has been fully initialized, destroy the old elements.
	    __guard_elts._M_first = __old_start;
	    __guard_elts._M_last = __old_finish;
	  }
	__guard._M_storage = __old_start;
	__guard._M_len = this->_M_impl._M_end_of_storage - __old_start;
    3549:	mov    rsi,r14
    354c:	sub    rsi,rdi
	_GLIBCXX_OPERATOR_DELETE(_GLIBCXX_SIZED_DEALLOC(__p, __n));
    354f:	call   3554 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x3554>
      // deallocate should be called before assignments to _M_impl,
      // to avoid call-clobbering

      this->_M_impl._M_start = __new_start;
      this->_M_impl._M_finish = __new_finish;
      this->_M_impl._M_end_of_storage = __new_start + __len;
    3554:	mov    rax,QWORD PTR [rsp+0x1b8]
    355c:	mov    r14,QWORD PTR [rsp+0x1a8]
      this->_M_impl._M_start = __new_start;
    3564:	mov    QWORD PTR [rsp+0x80],rax
      this->_M_impl._M_end_of_storage = __new_start + __len;
    356c:	add    r14,rax
    356f:	jmp    1cb <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x1cb>
    output.data.assign(width * height * 3, 0);
    3574:	lea    r14,[r13+r13*2+0x0]
	if (__n > _S_max_size(_Tp_alloc_type(__a)))
    3579:	test   r14,r14
    357c:	js     3582 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x3582>
	  return static_cast<_Tp*>(_GLIBCXX_OPERATOR_NEW(__n * sizeof(_Tp)));
    3582:	mov    rdi,r14
    3585:	call   358a <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x358a>
	this->_M_impl._M_end_of_storage = this->_M_impl._M_start + __n;
    358a:	lea    r8,[rax+r14*1]
		      __builtin_memset(__dest, (unsigned char)__x, __n);
    358e:	xor    esi,esi
    3590:	mov    rdx,r14
    3593:	mov    rdi,rax
    3596:	mov    QWORD PTR [rsp+0x1d0],r8
    359e:	call   35a3 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x35a3>
	  _M_finish = __x._M_finish;
    35a3:	mov    r8,QWORD PTR [rsp+0x1d0]
	  _M_start = __x._M_start;
    35ab:	mov    QWORD PTR [r15+0x10],rax
	ptrdiff_t __dif = this->_M_impl._M_finish - this->_M_impl._M_start;
    35af:	mov    rax,QWORD PTR [r12+0x8]
	  _M_finish = __x._M_finish;
    35b4:	mov    QWORD PTR [r15+0x18],r8
	ptrdiff_t __dif = this->_M_impl._M_finish - this->_M_impl._M_start;
    35b8:	mov    QWORD PTR [rsp+0x1d0],rax
      if (this->capacity() < __n)
    35c0:	sub    rax,rbx
	  _M_end_of_storage = __x._M_end_of_storage;
    35c3:	mov    QWORD PTR [r15+0x20],r8
    35c7:	mov    r12,rax
    35ca:	jne    84 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x84>
	: _M_start(), _M_finish(), _M_end_of_storage()
    35d0:	mov    QWORD PTR [rsp+0x80],0x0
    35dc:	xor    r14d,r14d
    35df:	jmp    98 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x98>
        for (int y = 0; y < h; ++y) {
    35e4:	test   r12d,r12d
    35e7:	jle    3b1 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x3b1>
    35ed:	mov    eax,DWORD PTR [rsp+0x98]
    35f4:	test   eax,eax
    35f6:	jg     2e4 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x2e4>
    35fc:	jmp    3b1 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x3b1>
    for (auto& sub : subapertures) {
    3601:	mov    rax,QWORD PTR [rsp+0x80]
    3609:	mov    QWORD PTR [rsp+0xd8],rax
    3611:	jmp    1dd <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x1dd>
        for (int tx = 0; tx < w; tx += TILE_W) {
    3616:	xor    eax,eax
    for (int ty = 0; ty < h; ty += TILE_H) {
    3618:	lea    rdx,[rax+0x8]
    361c:	cmp    r12d,edx
    361f:	jle    32d1 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x32d1>
    3625:	add    rax,0x10
    3629:	cmp    r12d,eax
    362c:	jg     3618 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x3618>
    362e:	jmp    32d1 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x32d1>
    3633:	jmp    3638 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x3638>
    3638:	jmp    363d <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x363d>
    363d:	jmp    3642 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x3642>
    3642:	mov    rbx,rax
    3645:	vzeroupper
    3648:	jmp    364d <.LC6+0x3641>

Disassembly of section .text.unlikely:

0000000000000000 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float) [clone .cold]>:
	  __throw_length_error(
   0:	lea    rdi,[rip+0x0]        # 7 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float) [clone .cold]+0x7>
   7:	call   c <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float) [clone .cold]+0xc>
	if (__p)
   c:	cmp    QWORD PTR [rsp+0x58],0x0
  12:	mov    rbx,rax
  15:	jne    69 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float) [clone .cold]+0x69>
  17:	vzeroupper
  1a:	cmp    QWORD PTR [rsp+0x80],0x0
  23:	je     4c <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float) [clone .cold]+0x4c>
	ptrdiff_t __n = _M_impl._M_end_of_storage - _M_impl._M_start;
  25:	mov    rdi,QWORD PTR [rsp+0x80]
  2d:	mov    rsi,r14
  30:	sub    rsi,rdi
	_GLIBCXX_OPERATOR_DELETE(_GLIBCXX_SIZED_DEALLOC(__p, __n));
  33:	call   38 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float) [clone .cold]+0x38>
      ~__new_allocator() _GLIBCXX_USE_NOEXCEPT { }
  38:	jmp    4c <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float) [clone .cold]+0x4c>
	  __throw_length_error(
  3a:	lea    rdi,[rip+0x0]        # 41 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float) [clone .cold]+0x41>
  41:	call   46 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float) [clone .cold]+0x46>
	ptrdiff_t __n = _M_impl._M_end_of_storage - _M_impl._M_start;
  46:	mov    rbx,rax
  49:	vzeroupper
  4c:	mov    rdi,QWORD PTR [r15+0x10]
	if (__p)
  50:	test   rdi,rdi
  53:	je     61 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float) [clone .cold]+0x61>
	ptrdiff_t __n = _M_impl._M_end_of_storage - _M_impl._M_start;
  55:	mov    rsi,QWORD PTR [r15+0x20]
  59:	sub    rsi,rdi
	_GLIBCXX_OPERATOR_DELETE(_GLIBCXX_SIZED_DEALLOC(__p, __n));
  5c:	call   61 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float) [clone .cold]+0x61>
      ~__new_allocator() _GLIBCXX_USE_NOEXCEPT { }
  61:	mov    rdi,rbx
  64:	call   69 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float) [clone .cold]+0x69>
	_GLIBCXX_OPERATOR_DELETE(_GLIBCXX_SIZED_DEALLOC(__p, __n));
  69:	mov    rdi,QWORD PTR [rsp+0x58]
  6e:	mov    rsi,r13
  71:	vzeroupper
  74:	call   79 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float) [clone .cold]+0x79>
      ~__new_allocator() _GLIBCXX_USE_NOEXCEPT { }
  79:	jmp    1a <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float) [clone .cold]+0x1a>
	  __throw_length_error(__N(__s));
  7b:	lea    rdi,[rip+0x0]        # 82 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float) [clone .cold]+0x82>
  82:	call   87 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float) [clone .cold]+0x87>
  87:	mov    rbx,rax
  8a:	vzeroupper
  8d:	jmp    1a <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float) [clone .cold]+0x1a>
	  __throw_length_error(
  8f:	lea    rdi,[rip+0x0]        # 96 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float) [clone .cold]+0x96>
  96:	call   9b <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float) [clone .cold]+0x9b>
	if (__p)
  9b:	mov    rbx,rax
  9e:	vzeroupper
  a1:	jmp    1a <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float) [clone .cold]+0x1a>
