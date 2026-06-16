
asm/opt17_no_ilp_no_reuse.o:     file format elf64-x86-64


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
      22:	vmovss DWORD PTR [rsp+0xe0],xmm0
      2b:	mov    QWORD PTR [rsp+0x48],rdi
    const size_t width  = subapertures.front().data.width;
      30:	vmovdqu xmm0,XMMWORD PTR [rbx]
      34:	mov    QWORD PTR [rdi+0x20],0x0
      3c:	vmovdqu XMMWORD PTR [rdi+0x10],xmm1
      41:	vmovq  rax,xmm0
      46:	vpextrq rsi,xmm0,0x1
      4c:	vmovq  QWORD PTR [rsp+0x40],xmm0
    const int h = static_cast<int>(height);

    ImageData output;
    output.width = width;
    output.height = height;
    output.data.assign(width * height * 3, 0);
      52:	mov    r12,rax
      55:	mov    QWORD PTR [rsp+0x110],rsi
      5d:	imul   r12,rsi
    output.width = width;
      61:	vmovdqu XMMWORD PTR [rdi],xmm0
    void
    vector<_Tp, _Alloc>::
    _M_fill_assign(size_t __n, const value_type& __val)
    {
      const size_type __sz = size();
      if (__n > capacity())
      65:	test   r12,r12
      68:	jne    1685 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x1685>
      /**  Returns the number of elements in the %vector.  */
      _GLIBCXX_NODISCARD _GLIBCXX20_CONSTEXPR
      size_type
      size() const _GLIBCXX_NOEXCEPT
      {
	ptrdiff_t __dif = this->_M_impl._M_finish - this->_M_impl._M_start;
      6e:	mov    rdi,QWORD PTR [r13+0x8]
      if (this->capacity() < __n)
      72:	mov    rdx,rdi
      75:	mov    QWORD PTR [rsp+0x118],rdi
      7d:	sub    rdx,rbx
      80:	mov    QWORD PTR [rsp+0x30],rdx
      85:	je     14a0 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x14a0>
	    return static_cast<_Tp*>(_GLIBCXX_OPERATOR_NEW(__n * sizeof(_Tp),
							   __al));
	  }
#endif
	else
	  return static_cast<_Tp*>(_GLIBCXX_OPERATOR_NEW(__n * sizeof(_Tp)));
      8b:	mov    r15,QWORD PTR [rsp+0x30]
      90:	mov    rdi,r15
      93:	call   98 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x98>
      98:	mov    QWORD PTR [rsp+0x60],rax
	  this->_M_impl._M_end_of_storage = this->_M_impl._M_start + __n;
      9d:	add    r15,rax
    const int w = static_cast<int>(width);
      a0:	mov    eax,DWORD PTR [rsp+0x40]
    const int h = static_cast<int>(height);
      a4:	mov    r13d,DWORD PTR [rsp+0x110]
    const int w = static_cast<int>(width);
      ac:	mov    DWORD PTR [rsp+0x70],eax

    std::vector<SubParams> params;
    params.reserve(subapertures.size());
    for (auto& sub : subapertures) {
      b0:	cmp    rbx,QWORD PTR [rsp+0x118]
      b8:	je     1704 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x1704>
	: _M_start(), _M_finish(), _M_end_of_storage()
      be:	mov    r14,QWORD PTR [rsp+0x60]
        SubParams p;
        float shift_x = focus * sub.u;
      c3:	vmovss xmm3,DWORD PTR [rsp+0xe0]
        float dy = shift_y - p.sy;
        p.A = (1.0f - dx) * (1.0f - dy);
        p.B = dx           * (1.0f - dy);
        p.C = (1.0f - dx) * dy;
        p.D = dx           * dy;
        p.x_begin = std::max(0, -p.sx);
      cc:	xor    r8d,r8d
        float shift_x = focus * sub.u;
      cf:	vmulss xmm4,xmm3,DWORD PTR [rbx+0x28]
        float shift_y = focus * sub.v;
      d4:	vmulss xmm2,xmm3,DWORD PTR [rbx+0x2c]
  using ::floor;

#ifndef __CORRECT_ISO_CPP_MATH_H_PROTO
  inline _GLIBCXX_CONSTEXPR float
  floor(float __x)
  { return __builtin_floorf(__x); }
      d9:	vrndscaless xmm0,xmm4,xmm4,0x9
        p.sx = static_cast<int>(std::floor(shift_x));
      e0:	vcvttss2si r10d,xmm0
      e4:	vrndscaless xmm1,xmm2,xmm2,0x9
        p.sy = static_cast<int>(std::floor(shift_y));
      eb:	vcvttss2si esi,xmm1
        p.x_begin = std::max(0, -p.sx);
      ef:	mov    eax,r10d
      f2:	neg    eax
      f4:	test   r10d,r10d
      f7:	cmovs  r8d,eax
        p.x_end   = std::min(w, w - p.sx - 1);
      fb:	mov    eax,DWORD PTR [rsp+0x70]
      ff:	mov    ecx,eax
     101:	sub    ecx,r10d
     104:	dec    ecx
    min(const _Tp& __a, const _Tp& __b)
    {
      // concept requirements
      __glibcxx_function_requires(_LessThanComparableConcept<_Tp>)
      //return __b < __a ? __b : __a;
      if (__b < __a)
     106:	cmp    ecx,eax
     108:	cmovg  ecx,eax
        p.y_begin = std::max(0, -p.sy);
     10b:	mov    eax,esi
     10d:	xor    r9d,r9d
     110:	neg    eax
     112:	test   esi,esi
     114:	cmovs  r9d,eax
        p.y_end   = std::min(h, h - p.sy - 1);
     118:	mov    eax,r13d
     11b:	sub    eax,esi
     11d:	dec    eax
     11f:	cmp    eax,r13d
     122:	cmovg  eax,r13d
     126:	mov    r11d,eax
        p.SUB = sub.data.data.data();
        if (p.x_begin >= p.x_end || p.y_begin >= p.y_end) continue;
     129:	cmp    r8d,ecx
     12c:	jge    1b4 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x1b4>
     132:	cmp    r9d,eax
     135:	jge    1b4 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x1b4>
        float dy = shift_y - p.sy;
     137:	vsubss xmm5,xmm2,xmm1
        float dx = shift_x - p.sx;
     13b:	vsubss xmm3,xmm4,xmm0
       *   range.  For a non-empty %vector, data() == &front().
       */
      _GLIBCXX_NODISCARD _GLIBCXX20_CONSTEXPR
      _Tp*
      data() _GLIBCXX_NOEXCEPT
      { return _M_data_ptr(this->_M_impl._M_start); }
     13f:	mov    rdi,QWORD PTR [rbx+0x10]
       */
      _GLIBCXX20_CONSTEXPR
      void
      push_back(const value_type& __x)
      {
	if (this->_M_impl._M_finish != this->_M_impl._M_end_of_storage)
     143:	mov    rax,QWORD PTR [rsp+0x60]
        p.A = (1.0f - dx) * (1.0f - dy);
     148:	vaddss xmm0,xmm0,DWORD PTR [rip+0x0]        # 150 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x150>
     150:	vaddss xmm1,xmm1,DWORD PTR [rip+0x0]        # 158 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x158>
      { return _M_data_ptr(this->_M_impl._M_start); }
     158:	mov    QWORD PTR [rsp+0xf0],rdi
     160:	vsubss xmm0,xmm0,xmm4
     164:	vsubss xmm1,xmm1,xmm2
     168:	vmulss xmm2,xmm0,xmm1
        p.B = dx           * (1.0f - dy);
     16c:	vmulss xmm1,xmm1,xmm3
        p.C = (1.0f - dx) * dy;
     170:	vmulss xmm0,xmm0,xmm5
        p.D = dx           * dy;
     174:	vmulss xmm3,xmm3,xmm5
	if (this->_M_impl._M_finish != this->_M_impl._M_end_of_storage)
     178:	cmp    r15,rax
     17b:	je     14d8 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x14d8>
      template<typename _Up, typename... _Args>
	__attribute__((__always_inline__))
	void
	construct(_Up* __p, _Args&&... __args)
	noexcept(__is_nothrow_new_constructible<_Up, _Args...>)
	{ ::new((void *)__p) _Up(std::forward<_Args>(__args)...); }
     181:	vunpcklps xmm0,xmm0,xmm3
     185:	vunpcklps xmm2,xmm2,xmm1
     189:	mov    DWORD PTR [rax],r10d
	  {
	    _GLIBCXX_ASAN_ANNOTATE_GROW(1);
	    _Alloc_traits::construct(this->_M_impl, this->_M_impl._M_finish,
				     __x);
	    ++this->_M_impl._M_finish;
     18c:	add    rax,0x30
     190:	vmovlhps xmm2,xmm2,xmm0
     194:	mov    DWORD PTR [rax-0x2c],esi
     197:	vmovups XMMWORD PTR [rax-0x28],xmm2
     19c:	mov    DWORD PTR [rax-0x18],r8d
     1a0:	mov    DWORD PTR [rax-0x14],ecx
     1a3:	mov    DWORD PTR [rax-0x10],r9d
     1a7:	mov    DWORD PTR [rax-0xc],r11d
     1ab:	mov    QWORD PTR [rax-0x8],rdi
     1af:	mov    QWORD PTR [rsp+0x60],rax
      __attribute__((__always_inline__))
      _GLIBCXX14_CONSTEXPR
      __normal_iterator&
      operator++() _GLIBCXX_NOEXCEPT
      {
	++_M_current;
     1b4:	add    rbx,0x30
    for (auto& sub : subapertures) {
     1b8:	cmp    rbx,QWORD PTR [rsp+0x118]
     1c0:	jne    c3 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0xc3>
	ptrdiff_t __n = _M_impl._M_end_of_storage - _M_impl._M_start;
     1c6:	mov    rax,r15
     1c9:	sub    rax,r14
     1cc:	mov    QWORD PTR [rsp+0x30],rax
     1d1:	mov    rax,QWORD PTR [rsp+0x60]
     1d6:	mov    QWORD PTR [rsp+0x60],r14
     1db:	mov    QWORD PTR [rsp+0x98],rax

      // Called by constructors to check initial size.
      static _GLIBCXX20_CONSTEXPR size_type
      _S_check_init_len(size_type __n, const allocator_type& __a)
      {
	if (__n > _S_max_size(_Tp_alloc_type(__a)))
     1e3:	mov    rax,r12
     1e6:	shr    rax,0x3d
     1ea:	jne    1f0 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x1f0>
	return __n != 0 ? _Tr::allocate(_M_impl, __n) : pointer();
     1f0:	test   r12,r12
     1f3:	je     14ca <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x14ca>
	  return static_cast<_Tp*>(_GLIBCXX_OPERATOR_NEW(__n * sizeof(_Tp)));
     1f9:	shl    r12,0x2
     1fd:	mov    rdi,r12
     200:	call   205 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x205>
	  // Allow std::_Construct to be used in constant expressions.
	  std::construct_at(__p, std::forward<_Args>(__args)...);
	  return;
	}
#endif
      ::new(static_cast<void*>(__p)) _Tp(std::forward<_Args>(__args)...);
     205:	mov    rdx,r12
     208:	xor    esi,esi
     20a:	mov    rdi,rax
     20d:	mov    QWORD PTR [rsp+0x50],rax
     212:	call   217 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x217>
        params.push_back(p);
    }

    std::vector<int> counts(width * height, 0);
    {
        std::vector<int> diff((width + 1) * (height + 1), 0);
     217:	mov    rax,QWORD PTR [rsp+0x40]
     21c:	mov    rbx,QWORD PTR [rsp+0x110]
     224:	lea    r14,[rax+0x1]
     228:	inc    rbx
     22b:	imul   rbx,r14
	if (__n > _S_max_size(_Tp_alloc_type(__a)))
     22f:	mov    rax,rbx
     232:	shr    rax,0x3d
     236:	jne    23c <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x23c>
	return __n != 0 ? _Tr::allocate(_M_impl, __n) : pointer();
     23c:	test   rbx,rbx
     23f:	je     146f <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x146f>
     245:	shl    rbx,0x2
     249:	mov    rdi,rbx
     24c:	call   251 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x251>
     251:	mov    rdi,rax
     254:	mov    rdx,rbx
     257:	xor    esi,esi
     259:	call   25e <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x25e>
        for (const auto& p : params) {
     25e:	mov    rdx,QWORD PTR [rsp+0x98]
     266:	mov    rdi,rax
     269:	cmp    QWORD PTR [rsp+0x60],rdx
     26e:	je     16ea <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x16ea>
     274:	mov    rax,QWORD PTR [rsp+0x60]
            diff[p.y_begin * (width + 1) + p.x_begin] += 1;
     279:	movsxd rdx,DWORD PTR [rax+0x20]
     27d:	movsxd rsi,DWORD PTR [rax+0x18]
     281:	add    rax,0x30
            diff[p.y_begin * (width + 1) + p.x_end  ] -= 1;
            diff[p.y_end   * (width + 1) + p.x_begin] -= 1;
     285:	movsxd r8,DWORD PTR [rax-0xc]
            diff[p.y_begin * (width + 1) + p.x_begin] += 1;
     289:	imul   rdx,r14
            diff[p.y_end   * (width + 1) + p.x_begin] -= 1;
     28d:	imul   r8,r14
            diff[p.y_begin * (width + 1) + p.x_begin] += 1;
     291:	lea    rcx,[rdx+rsi*1]
     295:	inc    DWORD PTR [rdi+rcx*4]
            diff[p.y_begin * (width + 1) + p.x_end  ] -= 1;
     298:	movsxd rcx,DWORD PTR [rax-0x14]
     29c:	add    rdx,rcx
     29f:	dec    DWORD PTR [rdi+rdx*4]
            diff[p.y_end   * (width + 1) + p.x_begin] -= 1;
     2a2:	lea    rdx,[rsi+r8*1]
     2a6:	dec    DWORD PTR [rdi+rdx*4]
            diff[p.y_end   * (width + 1) + p.x_end  ] += 1;
     2a9:	lea    rdx,[rcx+r8*1]
     2ad:	inc    DWORD PTR [rdi+rdx*4]
        for (const auto& p : params) {
     2b0:	cmp    rax,QWORD PTR [rsp+0x98]
     2b8:	jne    279 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x279>
        }
        for (int y = 0; y < h; ++y) {
     2ba:	test   r13d,r13d
     2bd:	jle    379 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x379>
     2c3:	mov    ecx,DWORD PTR [rsp+0x70]
     2c7:	test   ecx,ecx
     2c9:	jle    379 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x379>
            int row = 0;
            for (int x = 0; x < w; ++x) {
     2cf:	mov    rax,QWORD PTR [rsp+0x40]
            int row = 0;
     2d4:	xor    ecx,ecx
     2d6:	lea    edx,[rax-0x1]
        for (const auto& p : params) {
     2d9:	xor    eax,eax
     2db:	lea    rsi,[rdx+0x1]
                row += diff[y * (width + 1) + x];
                counts[y * w + x] = row + (y > 0 ? counts[(y - 1) * w + x] : 0);
     2df:	mov    rdx,QWORD PTR [rsp+0x50]
                row += diff[y * (width + 1) + x];
     2e4:	add    ecx,DWORD PTR [rdi+rax*4]
                counts[y * w + x] = row + (y > 0 ? counts[(y - 1) * w + x] : 0);
     2e7:	mov    DWORD PTR [rdx+rax*4],ecx
            for (int x = 0; x < w; ++x) {
     2ea:	inc    rax
     2ed:	cmp    rsi,rax
     2f0:	jne    2df <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x2df>
        for (int y = 0; y < h; ++y) {
     2f2:	cmp    r13d,0x1
     2f6:	jle    37e <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x37e>
     2fc:	mov    eax,DWORD PTR [rsp+0x70]
     300:	shl    r14,0x2
            for (int x = 0; x < w; ++x) {
     304:	xor    r11d,r11d
        for (int y = 0; y < h; ++y) {
     307:	mov    r10d,0x1
     30d:	lea    rdx,[rdi+r14*1]
     311:	lea    r8,[rax*4+0x0]
     319:	mov    rax,QWORD PTR [rsp+0x50]
     31e:	lea    r9,[rax+r8*1]
            for (int x = 0; x < w; ++x) {
     322:	mov    rcx,QWORD PTR [rsp+0x50]
     327:	movsxd rax,r11d
     32a:	add    r11d,DWORD PTR [rsp+0x40]
            int row = 0;
     32f:	mov    QWORD PTR [rsp+0x100],rdi
     337:	lea    rax,[rcx+rax*4]
     33b:	xor    ecx,ecx
     33d:	mov    QWORD PTR [rsp+0x118],rax
        for (int y = 0; y < h; ++y) {
     345:	xor    eax,eax
                counts[y * w + x] = row + (y > 0 ? counts[(y - 1) * w + x] : 0);
     347:	mov    rdi,QWORD PTR [rsp+0x118]
                row += diff[y * (width + 1) + x];
     34f:	add    ecx,DWORD PTR [rdx+rax*4]
                counts[y * w + x] = row + (y > 0 ? counts[(y - 1) * w + x] : 0);
     352:	mov    edi,DWORD PTR [rdi+rax*4]
     355:	add    edi,ecx
     357:	mov    DWORD PTR [r9+rax*4],edi
            for (int x = 0; x < w; ++x) {
     35b:	inc    rax
     35e:	cmp    rsi,rax
     361:	jne    347 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x347>
        for (int y = 0; y < h; ++y) {
     363:	inc    r10d
     366:	mov    rdi,QWORD PTR [rsp+0x100]
     36e:	add    rdx,r14
     371:	add    r9,r8
     374:	cmp    r13d,r10d
     377:	jg     322 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x322>
	if (__p)
     379:	test   rdi,rdi
     37c:	je     386 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x386>
	_GLIBCXX_OPERATOR_DELETE(_GLIBCXX_SIZED_DEALLOC(__p, __n));
     37e:	mov    rsi,rbx
     381:	call   386 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x386>
	  return static_cast<_Tp*>(_GLIBCXX_OPERATOR_NEW(__n * sizeof(_Tp)));
     386:	mov    edi,0x2fa00
     38b:	call   390 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x390>
     390:	mov    DWORD PTR [rax],0x0
      typedef typename __gnu_cxx::__conditional_type<__load_outside_loop,
						     const _Tp,
						     const _Tp&>::__type _Up;
      _Up __val(__value);
      for (; __first != __last; ++__first)
	*__first = __val;
     396:	xor    esi,esi
	  if (__n > 0)
	    {
	      typename iterator_traits<_ForwardIterator>::value_type* __val
		= std::addressof(*__first);
	      std::_Construct(__val);
	      ++__first;
     398:	lea    rdi,[rax+0x4]
     39c:	mov    edx,0x2f9fc
     3a1:	mov    QWORD PTR [rsp+0xf0],rax
     3a9:	call   3ae <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x3ae>
    const int TILE_H = 8;
    const int TILE_W = 2032;

    std::vector<float> tile_vals(TILE_H * TILE_W * 3);

    for (int ty = 0; ty < h; ty += TILE_H) {
     3ae:	test   r13d,r13d
     3b1:	jle    1370 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x1370>
     3b7:	mov    edx,DWORD PTR [rsp+0x70]
     3bb:	test   edx,edx
     3bd:	jle    1370 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x1370>

                const int x_floats = (x_end - x_begin) * 3;

                for (int y = y_begin; y < y_end; ++y) {
                    const size_t rb0 = ((size_t)(y + p.sy) * width + (size_t)(x_begin + p.sx)) * 3;
                    const size_t rb1 = rb0 + width * 3;
     3c3:	mov    rax,QWORD PTR [rsp+0x40]
     3c8:	mov    QWORD PTR [rsp+0x58],0x0
     3d1:	vxorps xmm4,xmm4,xmm4
     3d5:	xor    esi,esi
                unsigned char* outp = output.data.data() + (size_t)(y * width + tx) * 3;

                for (int x = 0; x < tile_w_actual; ++x) {
                    int c = counts[y * width + (tx + x)];
                    if (c == 0) continue;
                    float inv_c = 1.0f / (float)c;
     3d7:	vmovss xmm19,DWORD PTR [rip+0x0]        # 3e1 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x3e1>
      if (__a < __b)
     3e1:	vmovss xmm12,DWORD PTR [rip+0x0]        # 3e9 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x3e9>
     3e9:	mov    ebx,r13d
                    const size_t rb1 = rb0 + width * 3;
     3ec:	lea    rdi,[rax+rax*2]
     3f0:	lea    r14,[rax*8+0x0]
     3f8:	mov    QWORD PTR [rsp+0xc8],rdi
     400:	mov    rdi,QWORD PTR [rsp+0x58]
        const int tile_h_actual = tile_y_end - ty;
     405:	mov    r11,QWORD PTR [rsp+0x40]
     40a:	mov    QWORD PTR [rsp+0x10],r12
     40f:	mov    QWORD PTR [rsp+0x8],r14
        const int tile_y_end    = std::min(ty + TILE_H, h);
     414:	lea    eax,[rdi+0x8]
     417:	mov    DWORD PTR [rsp+0x3c],edi
      if (__b < __a)
     41b:	cmp    eax,ebx
     41d:	mov    DWORD PTR [rsp+0x20],edi
     421:	cmovg  eax,ebx
        const int tile_h_actual = tile_y_end - ty;
     424:	mov    QWORD PTR [rsp+0x28],rsi
     429:	mov    DWORD PTR [rsp+0x1c],ebx
     42d:	xor    ebx,ebx
     42f:	mov    DWORD PTR [rsp+0x94],eax
     436:	sub    eax,edi
     438:	mov    DWORD PTR [rsp+0x24],eax
     43c:	mov    edi,DWORD PTR [rsp+0x70]
            const int tile_x_end    = std::min(tx + TILE_W, w);
     440:	lea    eax,[rbx+0x7f0]
     446:	mov    r14d,ebx
     449:	cmp    eax,edi
     44b:	cmovg  eax,edi
            const int tile_w_actual = tile_x_end - tx;
     44e:	mov    ecx,eax
     450:	mov    r15d,eax
     453:	sub    ecx,ebx
            const size_t tile_row_stride = (size_t)tile_w_actual * 3;
     455:	movsxd rax,ecx
     458:	mov    QWORD PTR [rsp+0x68],rax
                      tile_vals.begin() + tile_h_actual * tile_w_actual * 3,
     45d:	mov    eax,DWORD PTR [rsp+0x24]
     461:	imul   eax,ecx
     464:	lea    edx,[rax+rax*2]

      _GLIBCXX_NODISCARD __attribute__((__always_inline__))
      _GLIBCXX_CONSTEXPR
      __normal_iterator
      operator+(difference_type __n) const _GLIBCXX_NOEXCEPT
      { return __normal_iterator(_M_current + __n); }
     467:	movsxd rdx,edx
      for (; __first != __last; ++__first)
     46a:	shl    rdx,0x2
     46e:	je     4c4 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x4c4>
     470:	mov    QWORD PTR [rsp+0x110],r11
	*__first = __val;
     478:	mov    rdi,QWORD PTR [rsp+0xf0]
     480:	xor    esi,esi
     482:	mov    DWORD PTR [rsp+0x118],ecx
     489:	vmovaps XMMWORD PTR [rsp+0x100],xmm4
     492:	vzeroupper
     495:	call   49a <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x49a>
     49a:	mov    r11,QWORD PTR [rsp+0x110]
     4a2:	vmovaps xmm4,XMMWORD PTR [rsp+0x100]
     4ab:	vmovss xmm12,DWORD PTR [rip+0x0]        # 4b3 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x4b3>
     4b3:	vmovss xmm19,DWORD PTR [rip+0x0]        # 4bd <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x4bd>
     4bd:	mov    ecx,DWORD PTR [rsp+0x118]
            for (const SubParams& p : params) {
     4c4:	mov    rax,QWORD PTR [rsp+0x60]
     4c9:	cmp    rax,QWORD PTR [rsp+0x98]
     4d1:	je     120d <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x120d>
     4d7:	mov    rdx,rax
     4da:	mov    rax,QWORD PTR [rsp+0x68]
     4df:	mov    r12d,DWORD PTR [rsp+0x3c]
     4e4:	mov    DWORD PTR [rsp+0xac],r14d
     4ec:	mov    DWORD PTR [rsp+0x38],ecx
     4f0:	mov    rcx,rdx
     4f3:	lea    rax,[rax+rax*2]
     4f7:	mov    QWORD PTR [rsp+0xb0],rax
     4ff:	nop
      if (__a < __b)
     500:	mov    eax,DWORD PTR [rcx+0x20]
      if (__b < __a)
     503:	mov    edx,DWORD PTR [rsp+0x94]
      if (__a < __b)
     50a:	cmp    r12d,eax
     50d:	cmovge eax,r12d
     511:	mov    DWORD PTR [rsp+0x100],eax
     518:	mov    edi,eax
      if (__b < __a)
     51a:	mov    eax,DWORD PTR [rcx+0x24]
     51d:	cmp    edx,eax
     51f:	cmovle eax,edx
      if (__a < __b)
     522:	mov    edx,DWORD PTR [rcx+0x18]
      if (__b < __a)
     525:	mov    DWORD PTR [rsp+0xd4],eax
     52c:	mov    esi,eax
      if (__a < __b)
     52e:	mov    eax,DWORD PTR [rsp+0xac]
     535:	cmp    eax,edx
     537:	cmovge edx,eax
      if (__b < __a)
     53a:	mov    eax,DWORD PTR [rcx+0x1c]
     53d:	cmp    r15d,eax
     540:	cmovle eax,r15d
                if (x_begin >= x_end || y_begin >= y_end) continue;
     544:	cmp    eax,edx
     546:	jle    11f7 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x11f7>
     54c:	cmp    esi,edi
     54e:	jle    11f7 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x11f7>
                const __m256 Avx = _mm256_set1_ps(p.A);
     554:	mov    r8d,edi
     557:	mov    rdi,QWORD PTR [rsp+0x68]
                const int x_floats = (x_end - x_begin) * 3;
     55c:	sub    eax,edx
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
     55e:	mov    r13,QWORD PTR [rcx+0x28]
     562:	mov    r10,r8
                const int x_floats = (x_end - x_begin) * 3;
     565:	lea    esi,[rax+rax*2]
     568:	mov    eax,edx
                const __m256 Avx = _mm256_set1_ps(p.A);
     56a:	vmovss xmm18,DWORD PTR [rcx+0x8]
     571:	sub    r10,QWORD PTR [rsp+0x58]
     576:	mov    r9,rax
                const int x_floats = (x_end - x_begin) * 3;
     579:	mov    DWORD PTR [rsp+0xd8],esi
     580:	lea    rax,[rax+rax*2]
     584:	imul   rdi,r10
     588:	sub    r9,rbx
                    const size_t rb0 = ((size_t)(y + p.sy) * width + (size_t)(x_begin + p.sx)) * 3;
     58b:	mov    esi,DWORD PTR [rcx]
     58d:	shl    rax,0x2
                const __m256 Bvx = _mm256_set1_ps(p.B);
     591:	vmovss xmm17,DWORD PTR [rcx+0xc]
                const __m256 Cvx = _mm256_set1_ps(p.C);
     598:	vmovss xmm16,DWORD PTR [rcx+0x10]
     59f:	mov    QWORD PTR [rsp+0x88],rbx
                const __m256 Avx = _mm256_set1_ps(p.A);
     5a7:	vbroadcastss ymm9,xmm18
                    const size_t rb0 = ((size_t)(y + p.sy) * width + (size_t)(x_begin + p.sx)) * 3;
     5ad:	add    esi,edx
                    float* vp = tile_vals.data() + (size_t)(y - ty) * tile_row_stride + (size_t)(x_begin - tx) * 3;
     5af:	sub    edx,DWORD PTR [rsp+0xac]
                const __m256 Dvx = _mm256_set1_ps(p.D);
     5b6:	vmovss xmm15,DWORD PTR [rcx+0x14]
     5bb:	mov    QWORD PTR [rsp+0x80],rcx
     5c3:	add    rdi,r9
                    const size_t rb0 = ((size_t)(y + p.sy) * width + (size_t)(x_begin + p.sx)) * 3;
     5c6:	movsxd rsi,esi
                    float* vp = tile_vals.data() + (size_t)(y - ty) * tile_row_stride + (size_t)(x_begin - tx) * 3;
     5c9:	movsxd rdx,edx
     5cc:	mov    QWORD PTR [rsp+0x78],r11
     5d1:	lea    r10,[rdi+rdi*2]
     5d5:	movsxd rdi,DWORD PTR [rcx+0x4]
     5d9:	add    rdx,rbx
     5dc:	mov    DWORD PTR [rsp+0x74],r12d
     5e1:	mov    QWORD PTR [rsp+0x110],r10
                const __m256 Bvx = _mm256_set1_ps(p.B);
     5e9:	vbroadcastss ymm10,xmm17
                const __m256 Cvx = _mm256_set1_ps(p.C);
     5ef:	vbroadcastss ymm11,xmm16
                const __m256 Dvx = _mm256_set1_ps(p.D);
     5f5:	vbroadcastss ymm8,xmm15
     5fa:	add    rdi,r8
     5fd:	mov    DWORD PTR [rsp+0x90],r15d
/* Create a vector with all elements equal to A.  */
extern __inline __m256 __attribute__((__gnu_inline__, __always_inline__, __artificial__))
_mm256_set1_ps (float __A)
{
  return __extension__ (__m256){ __A, __A, __A, __A,
				 __A, __A, __A, __A };
     605:	vmovaps ymm3,ymm9
     609:	vmovaps ymm2,ymm10
  return __extension__ (__m256){ __A, __A, __A, __A,
     60d:	imul   rdi,r11
				 __A, __A, __A, __A };
     611:	vmovaps ymm1,ymm11
     615:	vmovaps ymm0,ymm8
                for (int y = y_begin; y < y_end; ++y) {
     619:	lea    r8,[rsi+rdi*1]
     61d:	add    rsi,r11
     620:	add    rsi,rdi
     623:	mov    edi,DWORD PTR [rsp+0xd8]
     62a:	lea    r8,[r8+r8*2]
     62e:	lea    rsi,[rsi+rsi*2]
     632:	lea    r14,[r8+r13*1]
     636:	mov    r8,QWORD PTR [rsp+0xc8]
     63e:	lea    r10,[rsi+r13*1]
     642:	lea    rsi,[rdx+rdx*2]
     646:	mov    rdx,QWORD PTR [rsp+0xf0]
     64e:	sub    r8,r13
     651:	sub    rdx,rax
     654:	mov    QWORD PTR [rsp+0xc0],r8
     65c:	lea    rax,[rdx+rsi*4]
     660:	mov    QWORD PTR [rsp+0xb8],rax
     668:	lea    eax,[rdi-0x8]
     66b:	mov    edx,eax
     66d:	shr    eax,0x3
     670:	and    edx,0xfffffff8
     673:	inc    eax
     675:	add    edx,0x8
     678:	lea    r15,[rax*8+0x0]
                    for (int k = 0; k < x_floats - xf; ++k) {
     680:	sub    edi,edx
     682:	mov    DWORD PTR [rsp+0xa8],edx
     689:	mov    DWORD PTR [rsp+0xd0],edi
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
     690:	mov    edi,edx
     692:	mov    QWORD PTR [rsp+0xa0],rdi
     69a:	nop    WORD PTR [rax+rax*1+0x0]
                    const size_t rb1 = rb0 + width * 3;
     6a0:	mov    rax,QWORD PTR [rsp+0xc0]
                    float* vp = tile_vals.data() + (size_t)(y - ty) * tile_row_stride + (size_t)(x_begin - tx) * 3;
     6a8:	mov    rbx,QWORD PTR [rsp+0x110]
                    const size_t rb0 = ((size_t)(y + p.sy) * width + (size_t)(x_begin + p.sx)) * 3;
     6b0:	mov    r8,r14
     6b3:	sub    r8,r13
                    for (; xf + 8 <= x_floats; xf += 8) {
     6b6:	cmp    DWORD PTR [rsp+0xd8],0x7
                    const size_t rb1 = rb0 + width * 3;
     6be:	lea    rdi,[rax+r14*1]
                    float* vp = tile_vals.data() + (size_t)(y - ty) * tile_row_stride + (size_t)(x_begin - tx) * 3;
     6c2:	mov    rax,QWORD PTR [rsp+0xb8]
     6ca:	lea    rdx,[rax+rbx*4]
                    for (; xf + 8 <= x_floats; xf += 8) {
     6ce:	jle    1440 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x1440>
     6d4:	xor    eax,eax
     6d6:	cs nop WORD PTR [rax+rax*1+0x0]

extern __inline __m256i
__attribute__ ((__gnu_inline__, __always_inline__, __artificial__))
_mm256_cvtepu8_epi32 (__m128i __X)
{
  return (__m256i) __builtin_ia32_pmovzxbd256 ((__v16qi)__X);
     6e0:	vpmovzxbd ymm13,QWORD PTR [r14+rax*1]
     6e6:	vpmovzxbd ymm7,QWORD PTR [rax+r14*1+0x3]
     6ed:	vpmovzxbd ymm6,QWORD PTR [r10+rax*1]
     6f3:	vpmovzxbd ymm5,QWORD PTR [r10+rax*1+0x3]
  return (__m256)__builtin_ia32_cvtdq2ps256 ((__v8si) __A);
     6fa:	vcvtdq2ps ymm13,ymm13

extern __inline __m256
__attribute__((__gnu_inline__, __always_inline__, __artificial__))
_mm256_fmadd_ps (__m256 __A, __m256 __B, __m256 __C)
{
  return (__m256)__builtin_ia32_vfmaddps256 ((__v8sf)__A, (__v8sf)__B,
     6ff:	vfmadd213ps ymm13,ymm3,YMMWORD PTR [rdx+rax*4]
     705:	vcvtdq2ps ymm7,ymm7
     709:	vcvtdq2ps ymm6,ymm6
     70d:	vcvtdq2ps ymm5,ymm5
     711:	vfmadd132ps ymm7,ymm13,ymm2
     716:	vfmadd132ps ymm6,ymm7,ymm1
     71b:	vfmadd132ps ymm5,ymm6,ymm0
  *(__m256_u *)__P = __A;
     720:	vmovups YMMWORD PTR [rdx+rax*4],ymm5
     725:	add    rax,0x8
     729:	cmp    rax,r15
     72c:	jne    6e0 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x6e0>
                    for (int k = 0; k < x_floats - xf; ++k) {
     72e:	mov    eax,DWORD PTR [rsp+0xd0]
     735:	test   eax,eax
     737:	jle    119c <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x119c>
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
     73d:	mov    DWORD PTR [rsp+0x118],eax
     744:	mov    eax,DWORD PTR [rsp+0xa8]
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
     74b:	mov    rbx,QWORD PTR [rsp+0xa0]
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
     753:	mov    DWORD PTR [rsp+0xf8],eax
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
     75a:	add    r8,rbx
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
     75d:	add    rdi,rbx
     760:	mov    r9d,DWORD PTR [rsp+0x118]
     768:	mov    rax,QWORD PTR [rsp+0x110]
     770:	mov    ebx,DWORD PTR [rsp+0xf8]
     777:	mov    r11,QWORD PTR [rsp+0xf0]
     77f:	lea    r12,[r9+rdi*1+0x3]
     784:	lea    rsi,[rax+rbx*1]
     788:	add    r12,r13
     78b:	lea    rax,[r11+rsi*4]
     78f:	lea    rcx,[rsi+r9*1]
     793:	mov    QWORD PTR [rsp+0xe8],rsi
     79b:	cmp    rax,r12
     79e:	lea    r11,[r11+rcx*4]
     7a2:	lea    rsi,[r13+r8*1+0x0]
     7a7:	setae  BYTE PTR [rsp+0xdc]
     7af:	lea    rcx,[r13+rdi*1+0x0]
     7b4:	cmp    rcx,r11
     7b7:	mov    QWORD PTR [rsp+0xe0],rsi
     7bf:	movzx  esi,BYTE PTR [rsp+0xdc]
     7c7:	setae  r12b
     7cb:	or     sil,r12b
     7ce:	je     13c8 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x13c8>
     7d4:	lea    r9,[r9+r8*1+0x3]
     7d9:	mov    rsi,QWORD PTR [rsp+0xe0]
     7e1:	add    r9,r13
     7e4:	cmp    rax,r9
     7e7:	setae  r9b
     7eb:	cmp    rsi,r11
     7ee:	setae  r11b
     7f2:	or     r9b,r11b
     7f5:	je     13c8 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x13c8>
     7fb:	mov    ebx,DWORD PTR [rsp+0x118]
     802:	lea    r9d,[rbx-0x1]
     806:	cmp    r9d,0x1e
     80a:	jbe    145e <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x145e>
     810:	shr    ebx,0x5
     813:	lea    r11,[r13+r8*1+0x3]
                    int xf = 0;
     818:	xor    r9d,r9d
     81b:	mov    r12d,ebx
     81e:	mov    DWORD PTR [rsp+0xe0],ebx
     825:	lea    rbx,[r13+rdi*1+0x3]
     82a:	shl    r12,0x5
     82e:	xchg   ax,ax
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
     830:	vmovdqu ymm5,YMMWORD PTR [rcx+r9*1]
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
     836:	vmovdqu ymm6,YMMWORD PTR [r11+r9*1]
     83c:	sub    rax,0xffffffffffffff80
     840:	vmovdqu ymm7,YMMWORD PTR [rsi+r9*1]
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
     846:	vpmovzxbw ymm13,xmm5
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
     84b:	vpmovzxbw ymm14,xmm6
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
     850:	vextracti32x4 xmm5,ymm5,0x1
     857:	vpmovsxwd ymm21,xmm13
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
     85d:	vpmovsxwd ymm20,xmm14
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
     863:	vpmovzxbw ymm5,xmm5
     868:	vcvtdq2ps ymm21,ymm21
                        vp[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
     86e:	vmulps ymm21,ymm21,ymm1
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
     874:	vcvtdq2ps ymm20,ymm20
     87a:	vextracti32x4 xmm6,ymm6,0x1
     881:	vpmovzxbw ymm23,xmm7
     887:	vpmovzxbw ymm6,xmm6
     88c:	vpmovsxwd ymm24,xmm23
     892:	vextracti32x4 xmm7,ymm7,0x1
     899:	vcvtdq2ps ymm24,ymm24
     89f:	vfmadd213ps ymm24,ymm3,YMMWORD PTR [rax-0x80]
     8a6:	vextracti32x4 xmm23,ymm23,0x1
     8ad:	vpmovzxbw ymm7,xmm7
     8b2:	vpmovsxwd ymm23,xmm23
     8b8:	vcvtdq2ps ymm23,ymm23
     8be:	vfmadd213ps ymm23,ymm3,YMMWORD PTR [rax-0x60]
     8c5:	vfmadd132ps ymm20,ymm21,ymm2
     8cb:	vextracti32x4 xmm21,ymm14,0x1
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
     8d2:	vextracti32x4 xmm14,ymm13,0x1
     8d9:	vpmovsxwd ymm14,xmm14
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
     8de:	vpmovsxwd ymm21,xmm21
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
     8e4:	vcvtdq2ps ymm14,ymm14
                        vp[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
     8e9:	vmulps ymm14,ymm14,ymm1
     8ed:	vcvtdq2ps ymm13,ymm21
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
     8f3:	vpmovsxwd ymm21,xmm6
     8f9:	vextracti32x4 xmm6,ymm6,0x1
     900:	vpmovsxwd ymm6,xmm6
     905:	vcvtdq2ps ymm21,ymm21
     90b:	vcvtdq2ps ymm6,ymm6
     90f:	vfmadd132ps ymm13,ymm14,ymm2
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
     914:	vpmovsxwd ymm14,xmm5
     919:	vextracti32x4 xmm5,ymm5,0x1
     920:	vpmovsxwd ymm5,xmm5
     925:	vcvtdq2ps ymm14,ymm14
     92a:	vcvtdq2ps ymm5,ymm5
                        vp[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
     92e:	vmulps ymm5,ymm5,ymm1
     932:	vmulps ymm14,ymm14,ymm1
     936:	vfmadd132ps ymm6,ymm5,ymm2
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
     93b:	vmovdqu ymm5,YMMWORD PTR [rbx+r9*1]
     941:	add    r9,0x20
     945:	vfmadd132ps ymm21,ymm14,ymm2
     94b:	vpmovzxbw ymm14,xmm5
     950:	vextracti32x4 xmm5,ymm5,0x1
     957:	vpmovsxwd ymm22,xmm14
     95d:	vextracti32x4 xmm14,ymm14,0x1
     964:	vpmovzxbw ymm5,xmm5
     969:	vcvtdq2ps ymm22,ymm22
     96f:	vfmadd132ps ymm22,ymm24,ymm0
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
     975:	vpmovsxwd ymm24,xmm7
     97b:	vextracti32x4 xmm7,ymm7,0x1
     982:	vpmovsxwd ymm7,xmm7
     987:	vcvtdq2ps ymm24,ymm24
     98d:	vfmadd213ps ymm24,ymm3,YMMWORD PTR [rax-0x40]
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
     994:	vpmovsxwd ymm14,xmm14
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
     999:	vcvtdq2ps ymm7,ymm7
                        vp[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
     99d:	vfmadd213ps ymm7,ymm3,YMMWORD PTR [rax-0x20]
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
     9a3:	vcvtdq2ps ymm14,ymm14
     9a8:	vfmadd132ps ymm14,ymm23,ymm0
     9ae:	vpmovsxwd ymm23,xmm5
     9b4:	vextracti32x4 xmm5,ymm5,0x1
     9bb:	vcvtdq2ps ymm23,ymm23
     9c1:	vpmovsxwd ymm5,xmm5
     9c6:	vcvtdq2ps ymm5,ymm5
                        vp[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
     9ca:	vaddps ymm22,ymm22,ymm20
     9d0:	vfmadd132ps ymm23,ymm24,ymm0
     9d6:	vfmadd132ps ymm5,ymm7,ymm0
     9db:	vaddps ymm13,ymm13,ymm14
     9e0:	vmovups YMMWORD PTR [rax-0x80],ymm22
     9e7:	vmovups YMMWORD PTR [rax-0x60],ymm13
     9ec:	vaddps ymm21,ymm21,ymm23
     9f2:	vaddps ymm5,ymm5,ymm6
     9f6:	vmovups YMMWORD PTR [rax-0x40],ymm21
     9fd:	vmovups YMMWORD PTR [rax-0x20],ymm5
                    for (int k = 0; k < x_floats - xf; ++k) {
     a02:	cmp    r9,r12
     a05:	jne    830 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x830>
     a0b:	mov    r9d,DWORD PTR [rsp+0xe0]
     a13:	shl    r9d,0x5
     a17:	cmp    r9d,DWORD PTR [rsp+0x118]
     a1f:	je     119c <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x119c>
     a25:	mov    eax,r9d
     a28:	mov    esi,DWORD PTR [rsp+0x118]
     a2f:	sub    esi,r9d
     a32:	lea    ecx,[rsi-0x1]
     a35:	cmp    ecx,0xe
     a38:	jbe    1468 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x1468>
     a3e:	mov    ecx,r9d
     a41:	mov    r12,QWORD PTR [rsp+0xf0]
     a49:	lea    r11,[rcx+rdi*1]
     a4d:	lea    rbx,[rcx+r8*1]
     a51:	add    rcx,QWORD PTR [rsp+0xe8]
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
     a59:	vmovdqu xmm5,XMMWORD PTR [r13+r11*1+0x0]
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
     a60:	vmovdqu xmm6,XMMWORD PTR [r13+rbx*1+0x3]
     a67:	lea    rcx,[r12+rcx*4]
     a6b:	vmovdqu xmm7,XMMWORD PTR [r13+rbx*1+0x0]
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
     a72:	vpmovzxbw xmm14,xmm5
     a77:	vpsrldq xmm5,xmm5,0x8
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
     a7c:	vpmovzxbw xmm13,xmm6
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
     a81:	vpmovsxwd xmm20,xmm14
     a87:	vpsrldq xmm14,xmm14,0x8
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
     a8d:	vpmovsxwd xmm21,xmm13
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
     a93:	vpmovsxwd xmm14,xmm14
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
     a98:	vpsrldq xmm13,xmm13,0x8
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
     a9e:	vpmovzxbw xmm5,xmm5
     aa3:	vcvtdq2ps xmm20,xmm20
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
     aa9:	vcvtdq2ps xmm21,xmm21
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
     aaf:	vcvtdq2ps xmm14,xmm14
                        vp[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
     ab4:	vmulps xmm14,xmm14,xmm11
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
     ab9:	vpmovsxwd xmm13,xmm13
     abe:	vpmovzxbw xmm22,xmm7
                        vp[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
     ac4:	vmulps xmm20,xmm20,xmm11
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
     aca:	vcvtdq2ps xmm13,xmm13
     acf:	vpsrldq xmm6,xmm6,0x8
     ad4:	vpmovsxwd xmm24,xmm22
     ada:	vcvtdq2ps xmm24,xmm24
     ae0:	vfmadd213ps xmm24,xmm9,XMMWORD PTR [rcx]
     ae6:	vpsrldq xmm7,xmm7,0x8
     aeb:	vpmovzxbw xmm6,xmm6
     af0:	vpsrldq xmm22,xmm22,0x8
     af7:	vpmovzxbw xmm7,xmm7
     afc:	vpmovsxwd xmm22,xmm22
     b02:	vfmadd132ps xmm13,xmm14,xmm10
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
     b07:	vpmovsxwd xmm14,xmm5
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
     b0c:	vcvtdq2ps xmm22,xmm22
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
     b12:	vpsrldq xmm5,xmm5,0x8
     b17:	vcvtdq2ps xmm14,xmm14
     b1c:	vfmadd132ps xmm21,xmm20,xmm10
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
     b22:	vpmovsxwd xmm20,xmm6
                        vp[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
     b28:	vmulps xmm14,xmm14,xmm11
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
     b2d:	vpsrldq xmm6,xmm6,0x8
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
     b32:	vpmovsxwd xmm5,xmm5
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
     b37:	vcvtdq2ps xmm20,xmm20
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
     b3d:	vcvtdq2ps xmm5,xmm5
                        vp[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
     b41:	vmulps xmm5,xmm5,xmm11
     b46:	vfmadd213ps xmm22,xmm9,XMMWORD PTR [rcx+0x10]
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
     b4d:	vpmovsxwd xmm6,xmm6
     b52:	vcvtdq2ps xmm6,xmm6
     b56:	vfmadd132ps xmm20,xmm14,xmm10
     b5c:	vfmadd132ps xmm6,xmm5,xmm10
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
     b61:	vmovdqu xmm5,XMMWORD PTR [r13+r11*1+0x3]
     b68:	vpmovzxbw xmm14,xmm5
     b6d:	vpsrldq xmm5,xmm5,0x8
     b72:	vpmovsxwd xmm23,xmm14
     b78:	vpsrldq xmm14,xmm14,0x8
     b7e:	vpmovzxbw xmm5,xmm5
     b83:	vcvtdq2ps xmm23,xmm23
     b89:	vfmadd132ps xmm23,xmm24,xmm8
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
     b8f:	vpmovsxwd xmm24,xmm7
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
     b95:	vpmovsxwd xmm14,xmm14
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
     b9a:	vpsrldq xmm7,xmm7,0x8
     b9f:	vcvtdq2ps xmm24,xmm24
     ba5:	vfmadd213ps xmm24,xmm9,XMMWORD PTR [rcx+0x20]
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
     bac:	vcvtdq2ps xmm14,xmm14
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
     bb1:	vpmovsxwd xmm7,xmm7
     bb6:	vfmadd132ps xmm14,xmm22,xmm8
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
     bbc:	vpmovsxwd xmm22,xmm5
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
     bc2:	vcvtdq2ps xmm7,xmm7
                        vp[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
     bc6:	vfmadd213ps xmm7,xmm9,XMMWORD PTR [rcx+0x30]
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
     bcc:	vpsrldq xmm5,xmm5,0x8
     bd1:	vcvtdq2ps xmm22,xmm22
     bd7:	vpmovsxwd xmm5,xmm5
     bdc:	vcvtdq2ps xmm5,xmm5
                        vp[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
     be0:	vaddps xmm21,xmm21,xmm23
     be6:	vfmadd132ps xmm22,xmm24,xmm8
     bec:	vaddps xmm13,xmm13,xmm14
     bf1:	vfmadd132ps xmm5,xmm7,xmm8
     bf6:	vmovups XMMWORD PTR [rcx],xmm21
     bfc:	vmovups XMMWORD PTR [rcx+0x10],xmm13
     c01:	vaddps xmm20,xmm20,xmm22
     c07:	vaddps xmm5,xmm5,xmm6
     c0b:	vmovups XMMWORD PTR [rcx+0x20],xmm20
     c12:	vmovups XMMWORD PTR [rcx+0x30],xmm5
                    for (int k = 0; k < x_floats - xf; ++k) {
     c17:	mov    ecx,esi
     c19:	and    ecx,0xfffffff0
     c1c:	test   sil,0xf
     c20:	je     119c <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x119c>
     c26:	add    eax,ecx
     c28:	sub    esi,ecx
     c2a:	lea    r11d,[rsi-0x1]
     c2e:	cmp    r11d,0x6
     c32:	jbe    e9a <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0xe9a>
     c38:	add    ecx,r9d
     c3b:	mov    r9,QWORD PTR [rsp+0xe8]
     c43:	mov    ecx,ecx
     c45:	lea    rbx,[r8+rcx*1]
     c49:	lea    r11,[rdi+rcx*1]
     c4d:	add    rcx,r9
     c50:	mov    r9,QWORD PTR [rsp+0xf0]
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
     c58:	vmovq  xmm5,QWORD PTR [r13+rbx*1+0x0]
     c5f:	vmovq  xmm6,QWORD PTR [r13+rbx*1+0x3]
     c66:	lea    r9,[r9+rcx*4]
     c6a:	vpmovzxbw xmm7,xmm5
     c6f:	vpsrlq xmm5,xmm5,0x20
     c74:	vpmovzxbw xmm13,xmm6
     c79:	vmovq  r12,xmm7
     c7e:	vpmovzxbw xmm7,xmm5
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
     c83:	vmovq  xmm5,QWORD PTR [r13+r11*1+0x0]
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
     c8a:	vpmovzxwd xmm14,xmm13
     c8f:	vmovq  rcx,xmm7
     c94:	vpsrlq xmm13,xmm13,0x20
     c9a:	vmovq  xmm14,xmm14
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
     c9f:	vpmovzxbw xmm7,xmm5
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
     ca4:	vcvtdq2ps xmm21,xmm14
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
     caa:	vpsrlq xmm5,xmm5,0x20
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
     caf:	vpmovzxwd xmm13,xmm13
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
     cb4:	vpmovzxwd xmm14,xmm7
     cb9:	vpsrlq xmm7,xmm7,0x20
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
     cbe:	vmovq  xmm13,xmm13
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
     cc3:	vpmovzxwd xmm7,xmm7
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
     cc8:	vcvtdq2ps xmm13,xmm13
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
     ccd:	vpmovzxbw xmm5,xmm5
     cd2:	vmovq  xmm20,xmm14
     cd8:	vmovq  xmm7,xmm7
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
     cdc:	vpsrlq xmm6,xmm6,0x20
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
     ce1:	vcvtdq2ps xmm20,xmm20
     ce7:	vcvtdq2ps xmm7,xmm7
                        vp[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
     ceb:	vmulps xmm7,xmm7,xmm11
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
     cf0:	vpmovzxbw xmm6,xmm6
                        vp[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
     cf5:	vmulps xmm20,xmm20,xmm11
     cfb:	vfmadd132ps xmm13,xmm7,xmm10
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
     d00:	vpmovzxwd xmm7,xmm6
     d05:	vpsrlq xmm6,xmm6,0x20
     d0a:	vfmadd132ps xmm21,xmm20,xmm10
     d10:	vmovq  xmm7,xmm7
     d14:	vpmovzxwd xmm6,xmm6
     d19:	vcvtdq2ps xmm14,xmm7
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
     d1d:	vmovq  xmm7,QWORD PTR [r13+r11*1+0x3]
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
     d24:	vmovq  xmm6,xmm6
     d28:	vcvtdq2ps xmm6,xmm6
     d2c:	vmovaps xmm23,xmm13
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
     d32:	vpmovzxwd xmm13,xmm5
     d37:	vpsrlq xmm5,xmm5,0x20
     d3c:	vmovq  xmm13,xmm13
     d41:	vpmovzxwd xmm5,xmm5
     d46:	vcvtdq2ps xmm13,xmm13
                        vp[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
     d4b:	vmulps xmm13,xmm13,xmm11
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
     d50:	vmovq  xmm5,xmm5
     d54:	vcvtdq2ps xmm5,xmm5
                        vp[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
     d58:	vmulps xmm5,xmm5,xmm11
     d5d:	vfmadd132ps xmm14,xmm13,xmm10
     d62:	vmovq  xmm13,QWORD PTR [r9]
     d67:	vfmadd132ps xmm6,xmm5,xmm10
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
     d6c:	vpmovzxbw xmm5,xmm7
     d71:	vpsrlq xmm7,xmm7,0x20
     d76:	vpmovzxbw xmm7,xmm7
     d7b:	vmovaps xmm25,xmm14
     d81:	vmovaps xmm20,xmm6
     d87:	vpmovzxwd xmm6,xmm5
     d8c:	vmovq  xmm6,xmm6
     d90:	vpsrlq xmm5,xmm5,0x20
     d95:	vcvtdq2ps xmm14,xmm6
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
     d99:	vmovq  xmm6,r12
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
     d9e:	vpmovzxwd xmm5,xmm5
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
     da3:	vpmovzxwd xmm6,xmm6
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
     da8:	vmovq  xmm24,xmm5
     dae:	vpmovzxwd xmm5,xmm7
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
     db3:	vmovq  xmm6,xmm6
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
     db7:	vcvtdq2ps xmm24,xmm24
     dbd:	vpsrlq xmm7,xmm7,0x20
     dc2:	vmovq  xmm5,xmm5
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
     dc6:	vcvtdq2ps xmm6,xmm6
     dca:	vfmadd231ps xmm13,xmm9,xmm6
     dcf:	vmovq  xmm6,r12
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
     dd4:	vcvtdq2ps xmm5,xmm5
     dd8:	vpmovzxwd xmm7,xmm7
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
     ddd:	vpsrlq xmm6,xmm6,0x20
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
     de2:	vmovq  xmm7,xmm7
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
     de6:	vpmovzxwd xmm6,xmm6
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
     deb:	vcvtdq2ps xmm7,xmm7
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
     def:	vmovq  xmm6,xmm6
     df3:	vcvtdq2ps xmm6,xmm6
     df7:	vfmadd132ps xmm14,xmm13,xmm8
                        vp[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
     dfc:	vmovq  xmm13,QWORD PTR [r9+0x8]
     e02:	vfmadd132ps xmm6,xmm13,xmm9
     e07:	vmovaps xmm22,xmm14
     e0d:	vmovq  xmm14,QWORD PTR [r9+0x10]
     e13:	vfmadd132ps xmm24,xmm6,xmm8
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
     e19:	vmovq  xmm6,rcx
     e1e:	mov    ecx,esi
     e20:	vpmovzxwd xmm13,xmm6
     e25:	and    ecx,0xfffffff8
     e28:	and    esi,0x7
     e2b:	vmovq  xmm13,xmm13
     e30:	vcvtdq2ps xmm13,xmm13
     e35:	vfmadd132ps xmm13,xmm14,xmm9
                        vp[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
     e3a:	vmovq  xmm14,QWORD PTR [r9+0x18]
     e40:	vfmadd132ps xmm5,xmm13,xmm8
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
     e45:	vpsrlq xmm13,xmm6,0x20
     e4a:	vpmovzxwd xmm13,xmm13
     e4f:	vmovq  xmm13,xmm13
     e54:	vcvtdq2ps xmm13,xmm13
                        vp[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
     e59:	vfmadd132ps xmm13,xmm14,xmm9
     e5e:	vaddps xmm5,xmm25,xmm5
     e64:	vfmadd132ps xmm7,xmm13,xmm8
     e69:	vaddps xmm13,xmm21,xmm22
     e6f:	vmovlps QWORD PTR [r9+0x10],xmm5
     e75:	vmovlps QWORD PTR [r9],xmm13
     e7a:	vaddps xmm14,xmm7,xmm20
     e80:	vaddps xmm7,xmm23,xmm24
     e86:	vmovlps QWORD PTR [r9+0x18],xmm14
     e8c:	vmovlps QWORD PTR [r9+0x8],xmm7
     e92:	je     119c <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x119c>
     e98:	add    eax,ecx
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
     e9a:	movsxd rcx,eax
                        vp[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
     e9d:	mov    ebx,DWORD PTR [rsp+0xf8]
                    for (int k = 0; k < x_floats - xf; ++k) {
     ea4:	mov    r12d,DWORD PTR [rsp+0x118]
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
     eac:	lea    r9,[rcx+r8*1]
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
     eb0:	add    rcx,rdi
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
     eb3:	movzx  r11d,BYTE PTR [r13+r9*1+0x0]
     eb9:	movzx  r9d,BYTE PTR [r13+r9*1+0x3]
                        vp[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
     ebf:	lea    esi,[rbx+rax*1]
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
     ec2:	vcvtusi2ss xmm5,xmm4,r11d
     ec8:	vmovaps xmm7,xmm5
     ecc:	vcvtusi2ss xmm5,xmm4,r9d
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
     ed2:	movzx  r9d,BYTE PTR [r13+rcx*1+0x0]
     ed8:	movzx  ecx,BYTE PTR [r13+rcx*1+0x3]
     ede:	vfmadd213ss xmm7,xmm18,DWORD PTR [rdx+rsi*4]
     ee5:	vcvtusi2ss xmm6,xmm4,r9d
                        vp[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
     eeb:	vmulss xmm6,xmm6,xmm16
     ef1:	vfmadd231ss xmm6,xmm17,xmm5
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
     ef7:	vcvtusi2ss xmm5,xmm4,ecx
                        vp[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
     efd:	vfmadd132ss xmm5,xmm7,xmm15
     f02:	vaddss xmm5,xmm5,xmm6
     f06:	vmovss DWORD PTR [rdx+rsi*4],xmm5
                    for (int k = 0; k < x_floats - xf; ++k) {
     f0b:	lea    esi,[rax+0x1]
     f0e:	cmp    esi,r12d
     f11:	jge    119c <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x119c>
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
     f17:	mov    ecx,esi
                        vp[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
     f19:	add    esi,ebx
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
     f1b:	lea    r9,[rcx+r8*1]
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
     f1f:	add    rcx,rdi
                        vp[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
     f22:	mov    esi,esi
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
     f24:	movzx  r11d,BYTE PTR [r13+r9*1+0x0]
     f2a:	movzx  r9d,BYTE PTR [r13+r9*1+0x3]
     f30:	vcvtusi2ss xmm5,xmm4,r11d
     f36:	vmovaps xmm7,xmm5
     f3a:	vcvtusi2ss xmm5,xmm4,r9d
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
     f40:	movzx  r9d,BYTE PTR [r13+rcx*1+0x0]
     f46:	movzx  ecx,BYTE PTR [r13+rcx*1+0x3]
     f4c:	vfmadd213ss xmm7,xmm18,DWORD PTR [rdx+rsi*4]
     f53:	vcvtusi2ss xmm6,xmm4,r9d
                        vp[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
     f59:	vmulss xmm6,xmm6,xmm16
     f5f:	vfmadd231ss xmm6,xmm17,xmm5
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
     f65:	vcvtusi2ss xmm5,xmm4,ecx
                        vp[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
     f6b:	vfmadd132ss xmm5,xmm7,xmm15
     f70:	vaddss xmm5,xmm5,xmm6
     f74:	vmovss DWORD PTR [rdx+rsi*4],xmm5
                    for (int k = 0; k < x_floats - xf; ++k) {
     f79:	lea    esi,[rax+0x2]
     f7c:	cmp    esi,r12d
     f7f:	jge    119c <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x119c>
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
     f85:	mov    ecx,esi
                        vp[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
     f87:	add    esi,ebx
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
     f89:	lea    r9,[rcx+r8*1]
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
     f8d:	add    rcx,rdi
                        vp[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
     f90:	mov    esi,esi
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
     f92:	movzx  r11d,BYTE PTR [r13+r9*1+0x0]
     f98:	movzx  r9d,BYTE PTR [r13+r9*1+0x3]
     f9e:	vcvtusi2ss xmm5,xmm4,r11d
     fa4:	vmovaps xmm7,xmm5
     fa8:	vcvtusi2ss xmm5,xmm4,r9d
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
     fae:	movzx  r9d,BYTE PTR [r13+rcx*1+0x0]
     fb4:	movzx  ecx,BYTE PTR [r13+rcx*1+0x3]
     fba:	vfmadd213ss xmm7,xmm18,DWORD PTR [rdx+rsi*4]
     fc1:	vcvtusi2ss xmm6,xmm4,r9d
                        vp[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
     fc7:	vmulss xmm6,xmm6,xmm16
     fcd:	vfmadd231ss xmm6,xmm17,xmm5
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
     fd3:	vcvtusi2ss xmm5,xmm4,ecx
                        vp[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
     fd9:	vfmadd132ss xmm5,xmm7,xmm15
     fde:	vaddss xmm5,xmm5,xmm6
     fe2:	vmovss DWORD PTR [rdx+rsi*4],xmm5
                    for (int k = 0; k < x_floats - xf; ++k) {
     fe7:	lea    esi,[rax+0x3]
     fea:	cmp    esi,r12d
     fed:	jge    119c <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x119c>
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
     ff3:	mov    ecx,esi
                        vp[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
     ff5:	add    esi,ebx
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
     ff7:	lea    r9,[rcx+r8*1]
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
     ffb:	add    rcx,rdi
                        vp[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
     ffe:	mov    esi,esi
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
    1000:	movzx  r11d,BYTE PTR [r13+r9*1+0x0]
    1006:	movzx  r9d,BYTE PTR [r13+r9*1+0x3]
    100c:	vcvtusi2ss xmm5,xmm4,r11d
    1012:	vmovaps xmm7,xmm5
    1016:	vcvtusi2ss xmm5,xmm4,r9d
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
    101c:	movzx  r9d,BYTE PTR [r13+rcx*1+0x0]
    1022:	movzx  ecx,BYTE PTR [r13+rcx*1+0x3]
    1028:	vfmadd213ss xmm7,xmm18,DWORD PTR [rdx+rsi*4]
    102f:	vcvtusi2ss xmm6,xmm4,r9d
                        vp[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    1035:	vmulss xmm6,xmm6,xmm16
    103b:	vfmadd231ss xmm6,xmm17,xmm5
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
    1041:	vcvtusi2ss xmm5,xmm4,ecx
                        vp[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    1047:	vfmadd132ss xmm5,xmm7,xmm15
    104c:	vaddss xmm5,xmm5,xmm6
    1050:	vmovss DWORD PTR [rdx+rsi*4],xmm5
                    for (int k = 0; k < x_floats - xf; ++k) {
    1055:	lea    esi,[rax+0x4]
    1058:	cmp    esi,r12d
    105b:	jge    119c <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x119c>
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
    1061:	mov    ecx,esi
                        vp[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    1063:	add    esi,ebx
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
    1065:	lea    r9,[rcx+r8*1]
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
    1069:	add    rcx,rdi
                        vp[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    106c:	mov    esi,esi
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
    106e:	movzx  r11d,BYTE PTR [r13+r9*1+0x0]
    1074:	movzx  r9d,BYTE PTR [r13+r9*1+0x3]
    107a:	vcvtusi2ss xmm5,xmm4,r11d
    1080:	vmovaps xmm7,xmm5
    1084:	vcvtusi2ss xmm5,xmm4,r9d
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
    108a:	movzx  r9d,BYTE PTR [r13+rcx*1+0x0]
    1090:	movzx  ecx,BYTE PTR [r13+rcx*1+0x3]
    1096:	vfmadd213ss xmm7,xmm18,DWORD PTR [rdx+rsi*4]
    109d:	vcvtusi2ss xmm6,xmm4,r9d
                        vp[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    10a3:	vmulss xmm6,xmm6,xmm16
    10a9:	vfmadd231ss xmm6,xmm17,xmm5
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
    10af:	vcvtusi2ss xmm5,xmm4,ecx
                        vp[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    10b5:	vfmadd132ss xmm5,xmm7,xmm15
    10ba:	vaddss xmm5,xmm5,xmm6
    10be:	vmovss DWORD PTR [rdx+rsi*4],xmm5
                    for (int k = 0; k < x_floats - xf; ++k) {
    10c3:	lea    esi,[rax+0x5]
    10c6:	cmp    r12d,esi
    10c9:	jle    119c <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x119c>
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
    10cf:	mov    ecx,esi
                        vp[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    10d1:	add    esi,ebx
                    for (int k = 0; k < x_floats - xf; ++k) {
    10d3:	add    eax,0x6
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
    10d6:	lea    r9,[r8+rcx*1]
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
    10da:	add    rcx,rdi
                        vp[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    10dd:	mov    esi,esi
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
    10df:	movzx  r11d,BYTE PTR [r13+r9*1+0x0]
    10e5:	movzx  r9d,BYTE PTR [r13+r9*1+0x3]
    10eb:	vcvtusi2ss xmm5,xmm4,r11d
    10f1:	vmovaps xmm7,xmm5
    10f5:	vcvtusi2ss xmm5,xmm4,r9d
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
    10fb:	movzx  r9d,BYTE PTR [r13+rcx*1+0x0]
    1101:	movzx  ecx,BYTE PTR [r13+rcx*1+0x3]
    1107:	vfmadd213ss xmm7,xmm18,DWORD PTR [rdx+rsi*4]
    110e:	vcvtusi2ss xmm6,xmm4,r9d
                        vp[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    1114:	vmulss xmm6,xmm6,xmm16
    111a:	vfmadd231ss xmm6,xmm17,xmm5
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
    1120:	vcvtusi2ss xmm5,xmm4,ecx
                        vp[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    1126:	vfmadd132ss xmm5,xmm7,xmm15
    112b:	vaddss xmm5,xmm5,xmm6
    112f:	vmovss DWORD PTR [rdx+rsi*4],xmm5
                    for (int k = 0; k < x_floats - xf; ++k) {
    1134:	cmp    r12d,eax
    1137:	jle    119c <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x119c>
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
    1139:	mov    ecx,eax
                        vp[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    113b:	add    eax,ebx
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
    113d:	add    r8,rcx
                        vp[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    1140:	mov    eax,eax
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
    1142:	add    rdi,rcx
                        vp[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    1145:	lea    rax,[rdx+rax*4]
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
    1149:	movzx  edx,BYTE PTR [r13+r8*1+0x0]
    114f:	vcvtusi2ss xmm5,xmm4,edx
    1155:	movzx  edx,BYTE PTR [r13+r8*1+0x3]
    115b:	vmovaps xmm7,xmm5
    115f:	vcvtusi2ss xmm5,xmm4,edx
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
    1165:	movzx  edx,BYTE PTR [r13+rdi*1+0x0]
    116b:	vfmadd213ss xmm7,xmm18,DWORD PTR [rax]
    1171:	vcvtusi2ss xmm6,xmm4,edx
    1177:	movzx  edx,BYTE PTR [r13+rdi*1+0x3]
                        vp[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    117d:	vmulss xmm6,xmm6,xmm16
    1183:	vfmadd231ss xmm6,xmm17,xmm5
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
    1189:	vcvtusi2ss xmm5,xmm4,edx
                        vp[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    118f:	vfmadd132ss xmm5,xmm7,xmm15
    1194:	vaddss xmm5,xmm5,xmm6
    1198:	vmovss DWORD PTR [rax],xmm5
                for (int y = y_begin; y < y_end; ++y) {
    119c:	inc    DWORD PTR [rsp+0x100]
    11a3:	mov    rdi,QWORD PTR [rsp+0xc8]
    11ab:	mov    rdx,QWORD PTR [rsp+0xb0]
    11b3:	add    r14,rdi
    11b6:	add    r10,rdi
    11b9:	add    QWORD PTR [rsp+0x110],rdx
    11c1:	mov    eax,DWORD PTR [rsp+0x100]
    11c8:	cmp    eax,DWORD PTR [rsp+0xd4]
    11cf:	jl     6a0 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x6a0>
    11d5:	mov    rbx,QWORD PTR [rsp+0x88]
    11dd:	mov    rcx,QWORD PTR [rsp+0x80]
    11e5:	mov    r11,QWORD PTR [rsp+0x78]
    11ea:	mov    r15d,DWORD PTR [rsp+0x90]
    11f2:	mov    r12d,DWORD PTR [rsp+0x74]
            for (const SubParams& p : params) {
    11f7:	add    rcx,0x30
    11fb:	cmp    QWORD PTR [rsp+0x98],rcx
    1203:	jne    500 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x500>
    1209:	mov    ecx,DWORD PTR [rsp+0x38]
            for (int y = ty; y < tile_y_end; ++y) {
    120d:	mov    r12d,DWORD PTR [rsp+0x94]
    1215:	cmp    r12d,DWORD PTR [rsp+0x20]
    121a:	jle    1336 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x1336>
    1220:	test   ecx,ecx
    1222:	jle    1336 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x1336>
    1228:	mov    rax,QWORD PTR [rsp+0x68]
    122d:	mov    rdi,QWORD PTR [rsp+0xf0]
    1235:	lea    r8d,[rcx+rcx*2]
    1239:	mov    r9,QWORD PTR [rsp+0x28]
    123e:	mov    r10d,DWORD PTR [rsp+0x3c]
    1243:	lea    rax,[rax+rax*2]
                    outp[x*3    ] = (unsigned char)std::clamp(vp[x*3    ] * inv_c + 0.5f, 0.0f, 255.0f);
    1247:	vmovss xmm3,DWORD PTR [rip+0x0]        # 124f <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x124f>
    124f:	vmovss xmm6,DWORD PTR [rip+0x0]        # 1257 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x1257>
    1257:	lea    r14,[rax*4+0x0]
    125f:	mov    rax,QWORD PTR [rsp+0x50]
    1264:	mov    r15,QWORD PTR [rsp+0x48]
    1269:	lea    r13,[rax+rbx*4]
    126d:	nop    DWORD PTR [rax]
                unsigned char* outp = output.data.data() + (size_t)(y * width + tx) * 3;
    1270:	lea    rax,[rbx+r9*1]
                    outp[x*3 + 1] = (unsigned char)std::clamp(vp[x*3 + 1] * inv_c + 0.5f, 0.0f, 255.0f);
                    outp[x*3 + 2] = (unsigned char)std::clamp(vp[x*3 + 2] * inv_c + 0.5f, 0.0f, 255.0f);
    1274:	mov    QWORD PTR [rsp+0x118],r9
    127c:	vmovss xmm2,DWORD PTR [rip+0x0]        # 1284 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x1284>
    1284:	lea    rcx,[r13+r9*4+0x0]
                unsigned char* outp = output.data.data() + (size_t)(y * width + tx) * 3;
    1289:	lea    rsi,[rax+rax*2]
                    outp[x*3 + 2] = (unsigned char)std::clamp(vp[x*3 + 2] * inv_c + 0.5f, 0.0f, 255.0f);
    128d:	vmovss xmm5,DWORD PTR [rip+0x0]        # 1295 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x1295>
                unsigned char* outp = output.data.data() + (size_t)(y * width + tx) * 3;
    1295:	xor    edx,edx
    1297:	add    rsi,QWORD PTR [r15+0x10]
    129b:	nop    DWORD PTR [rax+rax*1+0x0]
                    int c = counts[y * width + (tx + x)];
    12a0:	mov    eax,DWORD PTR [rcx]
                    if (c == 0) continue;
    12a2:	test   eax,eax
    12a4:	je     1310 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x1310>
                    float inv_c = 1.0f / (float)c;
    12a6:	vcvtsi2ss xmm0,xmm4,eax
                    outp[x*3    ] = (unsigned char)std::clamp(vp[x*3    ] * inv_c + 0.5f, 0.0f, 255.0f);
    12aa:	mov    eax,edx
      if (__a < __b)
    12ac:	xor    r9d,r9d
                    float inv_c = 1.0f / (float)c;
    12af:	vdivss xmm0,xmm19,xmm0
                    outp[x*3    ] = (unsigned char)std::clamp(vp[x*3    ] * inv_c + 0.5f, 0.0f, 255.0f);
    12b5:	vmulss xmm1,xmm0,DWORD PTR [rdi+rax*4]
    12ba:	vcomiss xmm12,xmm1
    12be:	ja     12cc <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x12cc>
    12c0:	vaddss xmm1,xmm1,xmm3
      if (__b < __a)
    12c4:	vminss xmm1,xmm1,xmm6
    12c8:	vcvttss2si r9d,xmm1
                    outp[x*3 + 1] = (unsigned char)std::clamp(vp[x*3 + 1] * inv_c + 0.5f, 0.0f, 255.0f);
    12cc:	vmulss xmm1,xmm0,DWORD PTR [rdi+rax*4+0x4]
                    outp[x*3    ] = (unsigned char)std::clamp(vp[x*3    ] * inv_c + 0.5f, 0.0f, 255.0f);
    12d2:	mov    BYTE PTR [rsi+rax*1],r9b
      if (__a < __b)
    12d6:	xor    r9d,r9d
    12d9:	vcomiss xmm12,xmm1
    12dd:	ja     12eb <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x12eb>
                    outp[x*3 + 1] = (unsigned char)std::clamp(vp[x*3 + 1] * inv_c + 0.5f, 0.0f, 255.0f);
    12df:	vaddss xmm1,xmm1,xmm3
      if (__b < __a)
    12e3:	vminss xmm1,xmm1,xmm2
    12e7:	vcvttss2si r9d,xmm1
                    outp[x*3 + 2] = (unsigned char)std::clamp(vp[x*3 + 2] * inv_c + 0.5f, 0.0f, 255.0f);
    12eb:	vmulss xmm0,xmm0,DWORD PTR [rdi+rax*4+0x8]
                    outp[x*3 + 1] = (unsigned char)std::clamp(vp[x*3 + 1] * inv_c + 0.5f, 0.0f, 255.0f);
    12f1:	mov    BYTE PTR [rsi+rax*1+0x1],r9b
      if (__a < __b)
    12f6:	xor    r9d,r9d
    12f9:	vcomiss xmm12,xmm0
    12fd:	ja     130b <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x130b>
                    outp[x*3 + 2] = (unsigned char)std::clamp(vp[x*3 + 2] * inv_c + 0.5f, 0.0f, 255.0f);
    12ff:	vaddss xmm0,xmm0,xmm5
      if (__b < __a)
    1303:	vminss xmm0,xmm0,xmm2
    1307:	vcvttss2si r9d,xmm0
    130b:	mov    BYTE PTR [rsi+rax*1+0x2],r9b
                for (int x = 0; x < tile_w_actual; ++x) {
    1310:	add    edx,0x3
    1313:	add    rcx,0x4
    1317:	cmp    r8d,edx
    131a:	jne    12a0 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x12a0>
            for (int y = ty; y < tile_y_end; ++y) {
    131c:	mov    r9,QWORD PTR [rsp+0x118]
    1324:	inc    r10d
    1327:	add    rdi,r14
    132a:	add    r9,r11
    132d:	cmp    r12d,r10d
    1330:	jne    1270 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x1270>
        for (int tx = 0; tx < w; tx += TILE_W) {
    1336:	add    rbx,0x7f0
    133d:	cmp    DWORD PTR [rsp+0x70],ebx
    1341:	jg     43c <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x43c>
    for (int ty = 0; ty < h; ty += TILE_H) {
    1347:	add    QWORD PTR [rsp+0x58],0x8
    134d:	mov    r14,QWORD PTR [rsp+0x8]
    1352:	mov    rsi,QWORD PTR [rsp+0x28]
    1357:	mov    ebx,DWORD PTR [rsp+0x1c]
    135b:	mov    r12,QWORD PTR [rsp+0x10]
    1360:	add    rsi,r14
    1363:	cmp    ebx,DWORD PTR [rsp+0x58]
    1367:	jg     400 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x400>
    136d:	vzeroupper
	_GLIBCXX_OPERATOR_DELETE(_GLIBCXX_SIZED_DEALLOC(__p, __n));
    1370:	mov    rdi,QWORD PTR [rsp+0xf0]
    1378:	mov    esi,0x2fa00
    137d:	call   1382 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x1382>
    1382:	mov    rax,QWORD PTR [rsp+0x50]
    1387:	test   rax,rax
    138a:	je     1397 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x1397>
    138c:	mov    rsi,r12
    138f:	mov    rdi,rax
    1392:	call   1397 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x1397>
    1397:	mov    rax,QWORD PTR [rsp+0x60]
    139c:	test   rax,rax
    139f:	je     13ae <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x13ae>
    13a1:	mov    rsi,QWORD PTR [rsp+0x30]
    13a6:	mov    rdi,rax
    13a9:	call   13ae <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x13ae>
            }
        }
    }

    return output;
}
    13ae:	mov    rax,QWORD PTR [rsp+0x48]
    13b3:	lea    rsp,[rbp-0x28]
    13b7:	pop    rbx
    13b8:	pop    r12
    13ba:	pop    r13
    13bc:	pop    r14
    13be:	pop    r15
    13c0:	pop    rbp
    13c1:	ret
    13c2:	nop    WORD PTR [rax+rax*1+0x0]
                    for (int k = 0; k < x_floats - xf; ++k) {
    13c8:	mov    rsi,QWORD PTR [rsp+0xe0]
    13d0:	mov    edi,DWORD PTR [rsp+0x118]
    13d7:	lea    rdx,[rdx+rbx*4]
    13db:	xor    eax,eax
    13dd:	nop    DWORD PTR [rax]
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
    13e0:	movzx  r8d,BYTE PTR [rsi+rax*1]
    13e5:	vcvtusi2ss xmm5,xmm4,r8d
    13eb:	movzx  r8d,BYTE PTR [rsi+rax*1+0x3]
    13f1:	vmovaps xmm7,xmm5
    13f5:	vcvtusi2ss xmm5,xmm4,r8d
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
    13fb:	movzx  r8d,BYTE PTR [rcx+rax*1]
    1400:	vfmadd213ss xmm7,xmm18,DWORD PTR [rdx+rax*4]
    1407:	vcvtusi2ss xmm6,xmm4,r8d
    140d:	movzx  r8d,BYTE PTR [rcx+rax*1+0x3]
                        vp[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    1413:	vmulss xmm6,xmm6,xmm16
    1419:	vfmadd231ss xmm6,xmm17,xmm5
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
    141f:	vcvtusi2ss xmm5,xmm4,r8d
                        vp[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    1425:	vfmadd132ss xmm5,xmm7,xmm15
    142a:	vaddss xmm5,xmm5,xmm6
    142e:	vmovss DWORD PTR [rdx+rax*4],xmm5
                    for (int k = 0; k < x_floats - xf; ++k) {
    1433:	inc    rax
    1436:	cmp    edi,eax
    1438:	jg     13e0 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x13e0>
    143a:	jmp    119c <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x119c>
    143f:	nop
                    for (; xf + 8 <= x_floats; xf += 8) {
    1440:	mov    eax,DWORD PTR [rsp+0xd8]
                    int xf = 0;
    1447:	mov    DWORD PTR [rsp+0xf8],0x0
                    for (; xf + 8 <= x_floats; xf += 8) {
    1452:	mov    DWORD PTR [rsp+0x118],eax
    1459:	jmp    760 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x760>
                    int xf = 0;
    145e:	xor    r9d,r9d
                    for (int k = 0; k < x_floats - xf; ++k) {
    1461:	xor    eax,eax
    1463:	jmp    a28 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0xa28>
    1468:	xor    ecx,ecx
    146a:	jmp    c28 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0xc28>
        for (const auto& p : params) {
    146f:	mov    rdx,QWORD PTR [rsp+0x98]
	return __n != 0 ? _Tr::allocate(_M_impl, __n) : pointer();
    1477:	xor    edi,edi
    1479:	cmp    QWORD PTR [rsp+0x60],rdx
    147e:	jne    274 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x274>
        for (int y = 0; y < h; ++y) {
    1484:	test   r13d,r13d
    1487:	jle    386 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x386>
    148d:	mov    esi,DWORD PTR [rsp+0x70]
    1491:	test   esi,esi
    1493:	jg     2cf <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x2cf>
    1499:	jmp    386 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x386>
    149e:	xchg   ax,ax
	: _M_start(), _M_finish(), _M_end_of_storage()
    14a0:	mov    QWORD PTR [rsp+0x60],0x0
    const int h = static_cast<int>(height);
    14a9:	mov    r13d,esi
    14ac:	xor    r15d,r15d
    const int w = static_cast<int>(width);
    14af:	vmovd  DWORD PTR [rsp+0x70],xmm0
    for (auto& sub : subapertures) {
    14b5:	cmp    rbx,rdi
    14b8:	jne    be <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0xbe>
    14be:	mov    QWORD PTR [rsp+0x98],0x0
	return __n != 0 ? _Tr::allocate(_M_impl, __n) : pointer();
    14ca:	mov    QWORD PTR [rsp+0x50],0x0
    14d3:	jmp    217 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x217>
	ptrdiff_t __dif = this->_M_impl._M_finish - this->_M_impl._M_start;
    14d8:	mov    rax,r15
    14db:	sub    rax,r14
    14de:	mov    QWORD PTR [rsp+0x100],rax
    14e6:	sar    rax,0x4
    14ea:	mov    rdx,rax
    14ed:	movabs rax,0xaaaaaaaaaaaaaaab
    14f7:	imul   rdx,rax
	if (max_size() - size() < __n)
    14fb:	movabs rax,0x2aaaaaaaaaaaaaa
    1505:	cmp    rdx,rax
    1508:	je     150e <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x150e>
      if (__a < __b)
    150e:	test   rdx,rdx
    1511:	mov    eax,0x1
    1516:	mov    DWORD PTR [rsp+0xa0],r11d
    151e:	cmovne rax,rdx
    1522:	mov    DWORD PTR [rsp+0xac],ecx
    1529:	mov    DWORD PTR [rsp+0xd0],r9d
	const size_type __len = size() + (std::max)(size(), __n);
    1531:	add    rax,rdx
	return (__len < size() || __len > max_size()) ? max_size() : __len;
    1534:	movabs rdx,0x2aaaaaaaaaaaaaa
    153e:	mov    DWORD PTR [rsp+0xb0],r8d
    1546:	cmp    rax,rdx
    1549:	mov    DWORD PTR [rsp+0xd8],esi
    1550:	cmova  rax,rdx
    1554:	mov    DWORD PTR [rsp+0xdc],r10d
      allocate(size_type __n, const void* = static_cast<const void*>(0))
    155c:	vmovss DWORD PTR [rsp+0xb8],xmm3
	  return static_cast<_Tp*>(_GLIBCXX_OPERATOR_NEW(__n * sizeof(_Tp)));
    1565:	lea    rax,[rax+rax*2]
    1569:	vmovss DWORD PTR [rsp+0xc0],xmm0
    1572:	shl    rax,0x4
    1576:	vmovss DWORD PTR [rsp+0xc8],xmm1
    157f:	mov    rdi,rax
    1582:	mov    QWORD PTR [rsp+0xe8],rax
    158a:	vmovss DWORD PTR [rsp+0xd4],xmm2
    1593:	call   1598 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x1598>
	// taking the element by lvalue ref (see last bullet of C++11
	// [res.on.arguments]).

	// If this throws, the existing elements are unchanged.
#if __cplusplus >= 201103L
	_Alloc_traits::construct(this->_M_impl,
    1598:	mov    rdx,QWORD PTR [rsp+0x100]
	{ ::new((void *)__p) _Up(std::forward<_Args>(__args)...); }
    15a0:	mov    esi,DWORD PTR [rsp+0xd8]
	  return static_cast<_Tp*>(_GLIBCXX_OPERATOR_NEW(__n * sizeof(_Tp)));
    15a7:	mov    QWORD PTR [rsp+0xf8],rax
    15af:	mov    rdi,rax
	{ ::new((void *)__p) _Up(std::forward<_Args>(__args)...); }
    15b2:	vmovss xmm0,DWORD PTR [rsp+0xc0]
    15bb:	vmovss xmm2,DWORD PTR [rsp+0xd4]
    15c4:	mov    r10d,DWORD PTR [rsp+0xdc]
    15cc:	mov    r8d,DWORD PTR [rsp+0xb0]
    15d4:	mov    DWORD PTR [rax+rdx*1+0x4],esi
    15d8:	vinsertps xmm0,xmm0,DWORD PTR [rsp+0xb8],0x10
    15e3:	vinsertps xmm2,xmm2,DWORD PTR [rsp+0xc8],0x10
    15ee:	mov    ecx,DWORD PTR [rsp+0xac]
    15f5:	mov    r9d,DWORD PTR [rsp+0xd0]
    15fd:	mov    DWORD PTR [rax+rdx*1],r10d
    1601:	mov    r11d,DWORD PTR [rsp+0xa0]
    1609:	mov    rsi,QWORD PTR [rsp+0xf0]
    1611:	vmovlhps xmm2,xmm2,xmm0
    1615:	mov    DWORD PTR [rax+rdx*1+0x18],r8d
    161a:	mov    DWORD PTR [rax+rdx*1+0x1c],ecx
    161e:	mov    DWORD PTR [rax+rdx*1+0x20],r9d
    1623:	mov    DWORD PTR [rax+rdx*1+0x24],r11d
    1628:	mov    QWORD PTR [rax+rdx*1+0x28],rsi
    162d:	vmovups XMMWORD PTR [rax+rdx*1+0x8],xmm2
    __relocate_a_1(_Tp* __first, _Tp* __last,
		   _Tp* __result,
		   [[__maybe_unused__]] allocator<_Up>& __alloc) noexcept
    {
      ptrdiff_t __count = __last - __first;
      if (__count > 0)
    1633:	test   rdx,rdx
    1636:	je     1640 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x1640>
	      __gnu_cxx::__normal_iterator<_Tp*, void> __out(__result);
	      __out = std::__relocate_a_1(__first, __last, __out, __alloc);
	      return __out.base();
	    }
#endif
	  __builtin_memcpy(__result, __first, __count * sizeof(_Tp));
    1638:	mov    rsi,r14
    163b:	call   1640 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x1640>
	  {
	    // Relocation cannot throw.
	    __new_finish = std::__relocate_a(__old_start, __old_finish,
					     __new_start,
					     _M_get_Tp_allocator());
	    ++__new_finish;
    1640:	mov    rax,QWORD PTR [rsp+0xf8]
    1648:	mov    rdi,QWORD PTR [rsp+0x100]
    1650:	lea    rax,[rax+rdi*1+0x30]
    1655:	mov    QWORD PTR [rsp+0x60],rax
	  if (_M_storage)
    165a:	test   r14,r14
    165d:	je     166d <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x166d>
	    // New storage has been fully initialized, destroy the old elements.
	    __guard_elts._M_first = __old_start;
	    __guard_elts._M_last = __old_finish;
	  }
	__guard._M_storage = __old_start;
	__guard._M_len = this->_M_impl._M_end_of_storage - __old_start;
    165f:	mov    rsi,r15
	_GLIBCXX_OPERATOR_DELETE(_GLIBCXX_SIZED_DEALLOC(__p, __n));
    1662:	mov    rdi,r14
    1665:	sub    rsi,r14
    1668:	call   166d <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x166d>
      // deallocate should be called before assignments to _M_impl,
      // to avoid call-clobbering

      this->_M_impl._M_start = __new_start;
      this->_M_impl._M_finish = __new_finish;
      this->_M_impl._M_end_of_storage = __new_start + __len;
    166d:	mov    r15,QWORD PTR [rsp+0xe8]
    1675:	mov    r14,QWORD PTR [rsp+0xf8]
    167d:	add    r15,r14
    1680:	jmp    1b4 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x1b4>
    output.data.assign(width * height * 3, 0);
    1685:	lea    r14,[r12+r12*2]
	if (__n > _S_max_size(_Tp_alloc_type(__a)))
    1689:	test   r14,r14
    168c:	js     1692 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x1692>
	  return static_cast<_Tp*>(_GLIBCXX_OPERATOR_NEW(__n * sizeof(_Tp)));
    1692:	mov    rdi,r14
    1695:	call   169a <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x169a>
		      __builtin_memset(__dest, (unsigned char)__x, __n);
    169a:	xor    esi,esi
    169c:	mov    rdx,r14
	this->_M_impl._M_end_of_storage = this->_M_impl._M_start + __n;
    169f:	lea    r15,[rax+r14*1]
    16a3:	mov    rdi,rax
    16a6:	call   16ab <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x16ab>
    16ab:	mov    rcx,rax
	  _M_start = __x._M_start;
    16ae:	mov    rax,QWORD PTR [rsp+0x48]
    16b3:	mov    QWORD PTR [rax+0x10],rcx
	  _M_finish = __x._M_finish;
    16b7:	mov    QWORD PTR [rax+0x18],r15
	  _M_end_of_storage = __x._M_end_of_storage;
    16bb:	mov    QWORD PTR [rax+0x20],r15
	ptrdiff_t __dif = this->_M_impl._M_finish - this->_M_impl._M_start;
    16bf:	mov    rax,QWORD PTR [r13+0x8]
    16c3:	mov    QWORD PTR [rsp+0x118],rax
      if (this->capacity() < __n)
    16cb:	sub    rax,rbx
    16ce:	mov    QWORD PTR [rsp+0x30],rax
    16d3:	jne    8b <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x8b>
	: _M_start(), _M_finish(), _M_end_of_storage()
    16d9:	mov    QWORD PTR [rsp+0x60],0x0
    16e2:	xor    r15d,r15d
    16e5:	jmp    a0 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0xa0>
        for (int y = 0; y < h; ++y) {
    16ea:	test   r13d,r13d
    16ed:	jle    37e <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x37e>
    16f3:	mov    eax,DWORD PTR [rsp+0x70]
    16f7:	test   eax,eax
    16f9:	jg     2cf <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x2cf>
    16ff:	jmp    37e <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x37e>
    for (auto& sub : subapertures) {
    1704:	mov    rax,QWORD PTR [rsp+0x60]
    1709:	mov    QWORD PTR [rsp+0x98],rax
    1711:	jmp    1e3 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x1e3>
    1716:	jmp    171b <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x171b>
    171b:	jmp    1720 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x1720>
    1720:	mov    rbx,rax
    1723:	vzeroupper
    1726:	jmp    172b <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x172b>
    172b:	jmp    1730 <.LC6+0x1724>

Disassembly of section .text.unlikely:

0000000000000000 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float) [clone .cold]>:
	  __throw_length_error(
   0:	lea    rdi,[rip+0x0]        # 7 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float) [clone .cold]+0x7>
   7:	call   c <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float) [clone .cold]+0xc>
	if (__p)
   c:	mov    rbx,rax
   f:	vzeroupper
  12:	cmp    QWORD PTR [rsp+0x60],0x0
  18:	je     32 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float) [clone .cold]+0x32>
	ptrdiff_t __n = _M_impl._M_end_of_storage - _M_impl._M_start;
  1a:	mov    rdi,QWORD PTR [rsp+0x60]
  1f:	mov    rsi,r15
  22:	sub    rsi,rdi
	_GLIBCXX_OPERATOR_DELETE(_GLIBCXX_SIZED_DEALLOC(__p, __n));
  25:	call   2a <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float) [clone .cold]+0x2a>
      ~__new_allocator() _GLIBCXX_USE_NOEXCEPT { }
  2a:	jmp    32 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float) [clone .cold]+0x32>
  2c:	mov    rbx,rax
  2f:	vzeroupper
  32:	mov    rax,QWORD PTR [rsp+0x48]
  37:	mov    rdi,QWORD PTR [rax+0x10]
	if (__p)
  3b:	test   rdi,rdi
  3e:	je     4c <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float) [clone .cold]+0x4c>
	ptrdiff_t __n = _M_impl._M_end_of_storage - _M_impl._M_start;
  40:	mov    rsi,QWORD PTR [rax+0x20]
  44:	sub    rsi,rdi
	_GLIBCXX_OPERATOR_DELETE(_GLIBCXX_SIZED_DEALLOC(__p, __n));
  47:	call   4c <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float) [clone .cold]+0x4c>
      ~__new_allocator() _GLIBCXX_USE_NOEXCEPT { }
  4c:	mov    rdi,rbx
  4f:	call   54 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float) [clone .cold]+0x54>
	  __throw_length_error(
  54:	lea    rdi,[rip+0x0]        # 5b <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float) [clone .cold]+0x5b>
  5b:	call   60 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float) [clone .cold]+0x60>
	if (__p)
  60:	cmp    QWORD PTR [rsp+0x50],0x0
  66:	mov    rbx,rax
  69:	je     7d <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float) [clone .cold]+0x7d>
	_GLIBCXX_OPERATOR_DELETE(_GLIBCXX_SIZED_DEALLOC(__p, __n));
  6b:	mov    rdi,QWORD PTR [rsp+0x50]
  70:	mov    rsi,r12
  73:	vzeroupper
  76:	call   7b <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float) [clone .cold]+0x7b>
      ~__new_allocator() _GLIBCXX_USE_NOEXCEPT { }
  7b:	jmp    12 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float) [clone .cold]+0x12>
  7d:	vzeroupper
  80:	jmp    12 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float) [clone .cold]+0x12>
	  __throw_length_error(__N(__s));
  82:	lea    rdi,[rip+0x0]        # 89 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float) [clone .cold]+0x89>
  89:	call   8e <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float) [clone .cold]+0x8e>
	  __throw_length_error(
  8e:	lea    rdi,[rip+0x0]        # 95 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float) [clone .cold]+0x95>
  95:	call   9a <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float) [clone .cold]+0x9a>
  9a:	mov    QWORD PTR [rsp+0x60],r14
  9f:	mov    rbx,rax
  a2:	vzeroupper
  a5:	jmp    12 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float) [clone .cold]+0x12>
