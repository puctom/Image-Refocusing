
asm/opt17_abl_tile_8x2032_ilp_reuse.o:     file format elf64-x86-64


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
       e:	push   r12
      10:	mov    r12,rsi
      13:	push   rbx
      14:	and    rsp,0xffffffffffffffe0
      18:	sub    rsp,0x200
      : _M_current() { }

      __attribute__((__always_inline__))
      explicit _GLIBCXX_CONSTEXPR
      __normal_iterator(const _Iterator& __i) _GLIBCXX_NOEXCEPT
      : _M_current(__i) { }
      1f:	mov    r14,QWORD PTR [rsi]
      22:	vmovss DWORD PTR [rsp+0x1d8],xmm0
      2b:	mov    QWORD PTR [rsp+0x40],rdi
    const size_t width  = subapertures.front().data.width;
      30:	vmovdqu xmm0,XMMWORD PTR [r14]
      35:	mov    QWORD PTR [rdi+0x20],0x0
      3d:	vmovdqu XMMWORD PTR [rdi+0x10],xmm1
      42:	vpextrq rbx,xmm0,0x1
      48:	vmovq  rax,xmm0
      4d:	vmovq  QWORD PTR [rsp+0xb8],xmm0
    const int h = static_cast<int>(height);

    ImageData output;
    output.width = width;
    output.height = height;
    output.data.assign(width * height * 3, 0);
      56:	imul   rax,rbx
      5a:	mov    QWORD PTR [rsp+0x1e8],rbx
    output.width = width;
      62:	vmovdqu XMMWORD PTR [rdi],xmm0
    output.data.assign(width * height * 3, 0);
      66:	mov    QWORD PTR [rsp+0x38],rax
    void
    vector<_Tp, _Alloc>::
    _M_fill_assign(size_t __n, const value_type& __val)
    {
      const size_type __sz = size();
      if (__n > capacity())
      6b:	test   rax,rax
      6e:	jne    39e0 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x39e0>
      /**  Returns the number of elements in the %vector.  */
      _GLIBCXX_NODISCARD _GLIBCXX20_CONSTEXPR
      size_type
      size() const _GLIBCXX_NOEXCEPT
      {
	ptrdiff_t __dif = this->_M_impl._M_finish - this->_M_impl._M_start;
      74:	mov    rax,QWORD PTR [rsi+0x8]
      78:	mov    QWORD PTR [rsp+0x1f0],rax
      if (this->capacity() < __n)
      80:	sub    rax,r14
      83:	mov    r12,rax
      86:	je     37f8 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x37f8>
	    return static_cast<_Tp*>(_GLIBCXX_OPERATOR_NEW(__n * sizeof(_Tp),
							   __al));
	  }
#endif
	else
	  return static_cast<_Tp*>(_GLIBCXX_OPERATOR_NEW(__n * sizeof(_Tp)));
      8c:	mov    rdi,r12
      8f:	call   94 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x94>
      94:	mov    QWORD PTR [rsp+0x80],rax
	  this->_M_impl._M_end_of_storage = this->_M_impl._M_start + __n;
      9c:	lea    r15,[rax+r12*1]
    const int w = static_cast<int>(width);
      a0:	mov    eax,DWORD PTR [rsp+0xb8]
      a7:	mov    DWORD PTR [rsp+0x90],eax
    const int h = static_cast<int>(height);
      ae:	mov    eax,DWORD PTR [rsp+0x1e8]
      b5:	mov    DWORD PTR [rsp+0x5c],eax

    std::vector<SubParams> params;
    params.reserve(subapertures.size());
    for (auto& sub : subapertures) {
      b9:	cmp    QWORD PTR [rsp+0x1f0],r14
      c1:	je     3a77 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x3a77>
	: _M_start(), _M_finish(), _M_end_of_storage()
      c7:	mov    rax,QWORD PTR [rsp+0x80]
      cf:	mov    QWORD PTR [rsp+0xd0],rax
        SubParams p;
        float shift_x = focus * sub.u;
      d7:	vmovss xmm7,DWORD PTR [rsp+0x1d8]
        p.A = (1.0f - dx) * (1.0f - dy);
        p.B = dx           * (1.0f - dy);
        p.C = (1.0f - dx) * dy;
        p.D = dx           * dy;
        p.x_begin = std::max(0, -p.sx);
        p.x_end   = std::min(w, w - p.sx - 1);
      e0:	mov    ebx,DWORD PTR [rsp+0x90]
        p.x_begin = std::max(0, -p.sx);
      e7:	xor    ecx,ecx
        float shift_x = focus * sub.u;
      e9:	vmulss xmm4,xmm7,DWORD PTR [r14+0x28]
        float shift_y = focus * sub.v;
      ef:	vmulss xmm2,xmm7,DWORD PTR [r14+0x2c]
  using ::floor;

#ifndef __CORRECT_ISO_CPP_MATH_H_PROTO
  inline _GLIBCXX_CONSTEXPR float
  floor(float __x)
  { return __builtin_floorf(__x); }
      f5:	vrndscaless xmm0,xmm4,xmm4,0x9
        p.sx = static_cast<int>(std::floor(shift_x));
      fc:	vcvttss2si r9d,xmm0
     100:	vrndscaless xmm1,xmm2,xmm2,0x9
        p.sy = static_cast<int>(std::floor(shift_y));
     107:	vcvttss2si esi,xmm1
        p.x_begin = std::max(0, -p.sx);
     10b:	mov    eax,r9d
     10e:	neg    eax
     110:	test   r9d,r9d
     113:	cmovs  ecx,eax
        p.x_end   = std::min(w, w - p.sx - 1);
     116:	mov    eax,ebx
     118:	sub    eax,r9d
     11b:	dec    eax
    min(const _Tp& __a, const _Tp& __b)
    {
      // concept requirements
      __glibcxx_function_requires(_LessThanComparableConcept<_Tp>)
      //return __b < __a ? __b : __a;
      if (__b < __a)
     11d:	cmp    eax,ebx
     11f:	cmovg  eax,ebx
        p.y_begin = std::max(0, -p.sy);
        p.y_end   = std::min(h, h - p.sy - 1);
     122:	mov    ebx,DWORD PTR [rsp+0x5c]
        p.y_begin = std::max(0, -p.sy);
     126:	xor    r8d,r8d
     129:	mov    r10d,eax
     12c:	mov    eax,esi
     12e:	neg    eax
     130:	test   esi,esi
     132:	cmovs  r8d,eax
        p.y_end   = std::min(h, h - p.sy - 1);
     136:	mov    eax,ebx
     138:	sub    eax,esi
     13a:	dec    eax
     13c:	cmp    eax,ebx
     13e:	cmovg  eax,ebx
     141:	mov    r11d,eax
        p.SUB = sub.data.data.data();
        if (p.x_begin >= p.x_end || p.y_begin >= p.y_end) continue;
     144:	cmp    ecx,r10d
     147:	jge    1cd <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x1cd>
     14d:	cmp    r8d,eax
     150:	jge    1cd <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x1cd>
        float dy = shift_y - p.sy;
     152:	vsubss xmm5,xmm2,xmm1
        float dx = shift_x - p.sx;
     156:	vsubss xmm3,xmm4,xmm0
       */
      _GLIBCXX20_CONSTEXPR
      void
      push_back(const value_type& __x)
      {
	if (this->_M_impl._M_finish != this->_M_impl._M_end_of_storage)
     15a:	mov    rax,QWORD PTR [rsp+0xd0]
      { return _M_data_ptr(this->_M_impl._M_start); }
     162:	mov    rbx,QWORD PTR [r14+0x10]
        p.A = (1.0f - dx) * (1.0f - dy);
     166:	vaddss xmm0,xmm0,DWORD PTR [rip+0x0]        # 16e <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x16e>
     16e:	vaddss xmm1,xmm1,DWORD PTR [rip+0x0]        # 176 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x176>
     176:	vsubss xmm0,xmm0,xmm4
     17a:	vsubss xmm1,xmm1,xmm2
     17e:	vmulss xmm2,xmm0,xmm1
        p.B = dx           * (1.0f - dy);
     182:	vmulss xmm1,xmm1,xmm3
        p.C = (1.0f - dx) * dy;
     186:	vmulss xmm0,xmm0,xmm5
        p.D = dx           * dy;
     18a:	vmulss xmm3,xmm3,xmm5
	if (this->_M_impl._M_finish != this->_M_impl._M_end_of_storage)
     18e:	cmp    rax,r15
     191:	je     3848 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x3848>
      template<typename _Up, typename... _Args>
	__attribute__((__always_inline__))
	void
	construct(_Up* __p, _Args&&... __args)
	noexcept(__is_nothrow_new_constructible<_Up, _Args...>)
	{ ::new((void *)__p) _Up(std::forward<_Args>(__args)...); }
     197:	vunpcklps xmm0,xmm0,xmm3
     19b:	vunpcklps xmm2,xmm2,xmm1
     19f:	mov    DWORD PTR [rax],r9d
	  {
	    _GLIBCXX_ASAN_ANNOTATE_GROW(1);
	    _Alloc_traits::construct(this->_M_impl, this->_M_impl._M_finish,
				     __x);
	    ++this->_M_impl._M_finish;
     1a2:	add    rax,0x30
     1a6:	vmovlhps xmm2,xmm2,xmm0
     1aa:	mov    DWORD PTR [rax-0x2c],esi
     1ad:	vmovups XMMWORD PTR [rax-0x28],xmm2
     1b2:	mov    DWORD PTR [rax-0x18],ecx
     1b5:	mov    DWORD PTR [rax-0x14],r10d
     1b9:	mov    DWORD PTR [rax-0x10],r8d
     1bd:	mov    DWORD PTR [rax-0xc],r11d
     1c1:	mov    QWORD PTR [rax-0x8],rbx
     1c5:	mov    QWORD PTR [rsp+0xd0],rax
    for (auto& sub : subapertures) {
     1cd:	add    r14,0x30
     1d1:	cmp    QWORD PTR [rsp+0x1f0],r14
     1d9:	jne    d7 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0xd7>

      // Called by constructors to check initial size.
      static _GLIBCXX20_CONSTEXPR size_type
      _S_check_init_len(size_type __n, const allocator_type& __a)
      {
	if (__n > _S_max_size(_Tp_alloc_type(__a)))
     1df:	mov    rax,QWORD PTR [rsp+0x38]
     1e4:	shr    rax,0x3d
     1e8:	jne    1ee <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x1ee>
	return __n != 0 ? _Tr::allocate(_M_impl, __n) : pointer();
     1ee:	mov    rbx,QWORD PTR [rsp+0x38]
     1f3:	test   rbx,rbx
     1f6:	je     383a <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x383a>
	  return static_cast<_Tp*>(_GLIBCXX_OPERATOR_NEW(__n * sizeof(_Tp)));
     1fc:	shl    rbx,0x2
     200:	mov    rdi,rbx
     203:	mov    QWORD PTR [rsp+0x38],rbx
     208:	call   20d <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x20d>
	  // Allow std::_Construct to be used in constant expressions.
	  std::construct_at(__p, std::forward<_Args>(__args)...);
	  return;
	}
#endif
      ::new(static_cast<void*>(__p)) _Tp(std::forward<_Args>(__args)...);
     20d:	mov    rdx,rbx
     210:	xor    esi,esi
     212:	mov    rdi,rax
     215:	mov    QWORD PTR [rsp+0x50],rax
     21a:	call   21f <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x21f>
        params.push_back(p);
    }

    std::vector<int> counts(width * height, 0);
    {
        std::vector<int> diff((width + 1) * (height + 1), 0);
     21f:	mov    rax,QWORD PTR [rsp+0xb8]
     227:	mov    r14,QWORD PTR [rsp+0x1e8]
     22f:	lea    r13,[rax+0x1]
     233:	inc    r14
     236:	imul   r14,r13
	if (__n > _S_max_size(_Tp_alloc_type(__a)))
     23a:	mov    rax,r14
     23d:	shr    rax,0x3d
     241:	jne    247 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x247>
	return __n != 0 ? _Tr::allocate(_M_impl, __n) : pointer();
     247:	test   r14,r14
     24a:	je     37b6 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x37b6>
     250:	shl    r14,0x2
     254:	mov    rdi,r14
     257:	call   25c <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x25c>
     25c:	mov    rdi,rax
     25f:	mov    rdx,r14
     262:	xor    esi,esi
     264:	call   269 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x269>
        for (const auto& p : params) {
     269:	mov    rbx,QWORD PTR [rsp+0xd0]
     271:	mov    rdi,rax
     274:	cmp    QWORD PTR [rsp+0x80],rbx
     27c:	je     3a57 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x3a57>
     282:	mov    rax,QWORD PTR [rsp+0x80]
            diff[p.y_begin * (width + 1) + p.x_begin] += 1;
     28a:	movsxd rdx,DWORD PTR [rax+0x20]
     28e:	movsxd rsi,DWORD PTR [rax+0x18]
      __attribute__((__always_inline__))
      _GLIBCXX14_CONSTEXPR
      __normal_iterator&
      operator++() _GLIBCXX_NOEXCEPT
      {
	++_M_current;
     292:	add    rax,0x30
            diff[p.y_begin * (width + 1) + p.x_end  ] -= 1;
            diff[p.y_end   * (width + 1) + p.x_begin] -= 1;
     296:	movsxd r8,DWORD PTR [rax-0xc]
            diff[p.y_begin * (width + 1) + p.x_begin] += 1;
     29a:	imul   rdx,r13
            diff[p.y_end   * (width + 1) + p.x_begin] -= 1;
     29e:	imul   r8,r13
            diff[p.y_begin * (width + 1) + p.x_begin] += 1;
     2a2:	lea    rcx,[rdx+rsi*1]
     2a6:	inc    DWORD PTR [rdi+rcx*4]
            diff[p.y_begin * (width + 1) + p.x_end  ] -= 1;
     2a9:	movsxd rcx,DWORD PTR [rax-0x14]
     2ad:	add    rdx,rcx
     2b0:	dec    DWORD PTR [rdi+rdx*4]
            diff[p.y_end   * (width + 1) + p.x_begin] -= 1;
     2b3:	lea    rdx,[rsi+r8*1]
     2b7:	dec    DWORD PTR [rdi+rdx*4]
            diff[p.y_end   * (width + 1) + p.x_end  ] += 1;
     2ba:	lea    rdx,[rcx+r8*1]
     2be:	inc    DWORD PTR [rdi+rdx*4]
        for (const auto& p : params) {
     2c1:	cmp    rax,QWORD PTR [rsp+0xd0]
     2c9:	jne    28a <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x28a>
        }
        for (int y = 0; y < h; ++y) {
     2cb:	mov    r9d,DWORD PTR [rsp+0x5c]
     2d0:	test   r9d,r9d
     2d3:	jle    387 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x387>
     2d9:	mov    r8d,DWORD PTR [rsp+0x90]
     2e1:	test   r8d,r8d
     2e4:	jle    387 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x387>
            int row = 0;
            for (int x = 0; x < w; ++x) {
     2ea:	mov    rax,QWORD PTR [rsp+0xb8]
            int row = 0;
     2f2:	xor    ecx,ecx
     2f4:	lea    edx,[rax-0x1]
        for (const auto& p : params) {
     2f7:	xor    eax,eax
     2f9:	lea    r9,[rdx+0x1]
                row += diff[y * (width + 1) + x];
                counts[y * w + x] = row + (y > 0 ? counts[(y - 1) * w + x] : 0);
     2fd:	mov    rbx,QWORD PTR [rsp+0x50]
                row += diff[y * (width + 1) + x];
     302:	add    ecx,DWORD PTR [rdi+rax*4]
                counts[y * w + x] = row + (y > 0 ? counts[(y - 1) * w + x] : 0);
     305:	mov    DWORD PTR [rbx+rax*4],ecx
            for (int x = 0; x < w; ++x) {
     308:	inc    rax
     30b:	cmp    r9,rax
     30e:	jne    2fd <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x2fd>
        for (int y = 0; y < h; ++y) {
     310:	cmp    DWORD PTR [rsp+0x5c],0x1
     315:	jle    38c <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x38c>
     317:	mov    eax,DWORD PTR [rsp+0x90]
            for (int x = 0; x < w; ++x) {
     31e:	mov    r11,r13
     321:	xor    ecx,ecx
        for (int y = 0; y < h; ++y) {
     323:	mov    r8d,0x1
     329:	lea    rsi,[rax*4+0x0]
     331:	lea    r10,[rbx+rsi*1]
            for (int x = 0; x < w; ++x) {
     335:	lea    rbx,[rdi+r11*4]
     339:	movsxd rax,ecx
            int row = 0;
     33c:	xor    edx,edx
     33e:	add    ecx,DWORD PTR [rsp+0xb8]
     345:	mov    QWORD PTR [rsp+0x1f0],rbx
     34d:	mov    rbx,QWORD PTR [rsp+0x50]
     352:	lea    rbx,[rbx+rax*4]
        for (int y = 0; y < h; ++y) {
     356:	xor    eax,eax
                row += diff[y * (width + 1) + x];
     358:	mov    r12,QWORD PTR [rsp+0x1f0]
     360:	add    edx,DWORD PTR [r12+rax*4]
                counts[y * w + x] = row + (y > 0 ? counts[(y - 1) * w + x] : 0);
     364:	mov    r12d,DWORD PTR [rbx+rax*4]
     368:	add    r12d,edx
     36b:	mov    DWORD PTR [r10+rax*4],r12d
            for (int x = 0; x < w; ++x) {
     36f:	inc    rax
     372:	cmp    rax,r9
     375:	jne    358 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x358>
        for (int y = 0; y < h; ++y) {
     377:	inc    r8d
     37a:	add    r11,r13
     37d:	add    r10,rsi
     380:	cmp    DWORD PTR [rsp+0x5c],r8d
     385:	jne    335 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x335>
	if (__p)
     387:	test   rdi,rdi
     38a:	je     394 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x394>
	_GLIBCXX_OPERATOR_DELETE(_GLIBCXX_SIZED_DEALLOC(__p, __n));
     38c:	mov    rsi,r14
     38f:	call   394 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x394>
	  return static_cast<_Tp*>(_GLIBCXX_OPERATOR_NEW(__n * sizeof(_Tp)));
     394:	mov    edi,0x2fa00
     399:	call   39e <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x39e>
     39e:	mov    DWORD PTR [rax],0x0
      typedef typename __gnu_cxx::__conditional_type<__load_outside_loop,
						     const _Tp,
						     const _Tp&>::__type _Up;
      _Up __val(__value);
      for (; __first != __last; ++__first)
	*__first = __val;
     3a4:	xor    esi,esi
	  if (__n > 0)
	    {
	      typename iterator_traits<_ForwardIterator>::value_type* __val
		= std::addressof(*__first);
	      std::_Construct(__val);
	      ++__first;
     3a6:	lea    rdi,[rax+0x4]
     3aa:	mov    edx,0x2f9fc
     3af:	mov    QWORD PTR [rsp+0xd8],rax
     3b7:	call   3bc <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x3bc>
    const int TILE_H = 8;
    const int TILE_W = 2032;

    std::vector<float> tile_vals(TILE_H * TILE_W * 3);

    for (int ty = 0; ty < h; ty += TILE_H) {
     3bc:	mov    esi,DWORD PTR [rsp+0x5c]
     3c0:	test   esi,esi
     3c2:	jle    3761 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x3761>
        const int tile_y_end    = std::min(ty + TILE_H, h);
        const int tile_h_actual = tile_y_end - ty;

        for (int tx = 0; tx < w; tx += TILE_W) {
     3c8:	mov    ecx,DWORD PTR [rsp+0x90]
     3cf:	test   ecx,ecx
     3d1:	jle    3a8c <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x3a8c>
                int y = y_begin;

                for (; y + 3 < y_end; y += 4) {
                    size_t rb[5];
                    rb[0] = ((size_t)(y + p.sy) * width + (size_t)(x_begin + p.sx)) * 3;
                    rb[1] = rb[0] + width * 3;
     3d7:	mov    rbx,QWORD PTR [rsp+0xb8]
     3df:	mov    DWORD PTR [rsp+0xe0],0x0
      if (__a < __b)
     3ea:	xor    r14d,r14d
     3ed:	vxorps xmm10,xmm10,xmm10
                unsigned char* outp = output.data.data() + (size_t)(y * width + tx) * 3;

                for (int x = 0; x < tile_w_actual; ++x) {
                    int c = counts[y * width + (tx + x)];
                    if (c == 0) continue;
                    float inv_c = 1.0f / (float)c;
     3f2:	vmovss xmm30,DWORD PTR [rip+0x0]        # 3fc <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x3fc>
     3fc:	vmovss xmm29,DWORD PTR [rip+0x0]        # 406 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x406>
                    rb[1] = rb[0] + width * 3;
     406:	mov    QWORD PTR [rsp+0x78],0x0
     40f:	lea    rdx,[rbx+rbx*2]
     413:	lea    rax,[rbx*8+0x0]
     41b:	mov    QWORD PTR [rsp+0x18],r15
     420:	lea    rdi,[rdx*4+0x0]
     428:	add    rbx,rax
     42b:	mov    QWORD PTR [rsp+0x88],rdx
     433:	add    rdx,rdx
     436:	mov    QWORD PTR [rsp+0x190],rdi
     43e:	mov    QWORD PTR [rsp+0x60],rbx
     443:	mov    QWORD PTR [rsp+0xa8],rdx
     44b:	neg    rdx
     44e:	mov    QWORD PTR [rsp+0x68],rdx
     453:	mov    edx,0x8
      if (__b < __a)
     458:	mov    ebx,DWORD PTR [rsp+0x5c]
        const int tile_h_actual = tile_y_end - ty;
     45c:	mov    QWORD PTR [rsp+0xb0],0x0
     468:	mov    QWORD PTR [rsp+0x10],rax
     46d:	cmp    edx,ebx
     46f:	mov    QWORD PTR [rsp+0x28],r14
     474:	cmovg  edx,ebx
     477:	mov    ebx,DWORD PTR [rsp+0x78]
     47b:	mov    DWORD PTR [rsp+0xc4],edx
     482:	sub    edx,DWORD PTR [rsp+0xe0]
     489:	mov    DWORD PTR [rsp+0x24],ebx
     48d:	mov    DWORD PTR [rsp+0x20],edx
     491:	mov    rbx,QWORD PTR [rsp+0xb0]
     499:	mov    edx,DWORD PTR [rsp+0x90]
            const int tile_x_end    = std::min(tx + TILE_W, w);
     4a0:	lea    eax,[rbx+0x7f0]
     4a6:	mov    DWORD PTR [rsp+0xcc],ebx
     4ad:	cmp    eax,edx
     4af:	cmovg  eax,edx
            const int tile_w_actual = tile_x_end - tx;
     4b2:	mov    r14d,eax
     4b5:	mov    DWORD PTR [rsp+0xc8],eax
                      tile_vals.begin() + tile_h_actual * tile_w_actual * 3,
     4bc:	mov    eax,DWORD PTR [rsp+0x20]
            const int tile_w_actual = tile_x_end - tx;
     4c0:	sub    r14d,ebx
                      tile_vals.begin() + tile_h_actual * tile_w_actual * 3,
     4c3:	imul   eax,r14d
            const size_t tile_row_stride = (size_t)tile_w_actual * 3;
     4c7:	movsxd rbx,r14d
                      tile_vals.begin() + tile_h_actual * tile_w_actual * 3,
     4ca:	lea    edx,[rax+rax*2]

      _GLIBCXX_NODISCARD __attribute__((__always_inline__))
      _GLIBCXX_CONSTEXPR
      __normal_iterator
      operator+(difference_type __n) const _GLIBCXX_NOEXCEPT
      { return __normal_iterator(_M_current + __n); }
     4cd:	movsxd rdx,edx
      for (; __first != __last; ++__first)
     4d0:	shl    rdx,0x2
     4d4:	je     50e <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x50e>
	*__first = __val;
     4d6:	mov    rdi,QWORD PTR [rsp+0xd8]
     4de:	vmovaps XMMWORD PTR [rsp+0x1f0],xmm10
     4e7:	xor    esi,esi
     4e9:	vzeroupper
     4ec:	call   4f1 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x4f1>
     4f1:	vmovaps xmm10,XMMWORD PTR [rsp+0x1f0]
     4fa:	vmovss xmm29,DWORD PTR [rip+0x0]        # 504 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x504>
     504:	vmovss xmm30,DWORD PTR [rip+0x0]        # 50e <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x50e>
            for (const SubParams& p : params) {
     50e:	mov    rdx,QWORD PTR [rsp+0x80]
     516:	cmp    rdx,QWORD PTR [rsp+0xd0]
     51e:	je     2e7c <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x2e7c>
            const size_t tile_row_stride = (size_t)tile_w_actual * 3;
     524:	lea    rax,[rbx+rbx*2]
     528:	mov    QWORD PTR [rsp+0x30],rbx
                    float* vp1 = vp0 + tile_row_stride;
     52d:	lea    rdi,[rax*4+0x0]
            const size_t tile_row_stride = (size_t)tile_w_actual * 3;
     535:	mov    QWORD PTR [rsp+0xa0],rax
                    float* vp1 = vp0 + tile_row_stride;
     53d:	mov    QWORD PTR [rsp+0x128],rdi
     545:	mov    rdi,rax
     548:	add    rax,rax
     54b:	mov    QWORD PTR [rsp+0x70],rax
     550:	mov    eax,DWORD PTR [rsp+0xc8]
     557:	shl    rdi,0x4
     55b:	mov    QWORD PTR [rsp+0x120],rdi
     563:	sub    rax,QWORD PTR [rsp+0xb0]
     56b:	mov    DWORD PTR [rsp+0x58],r14d
     570:	mov    QWORD PTR [rsp+0x48],rax
     575:	nop    DWORD PTR [rax]
      if (__a < __b)
     578:	mov    eax,DWORD PTR [rdx+0x20]
     57b:	mov    ebx,DWORD PTR [rsp+0xe0]
     582:	mov    edi,DWORD PTR [rsp+0xcc]
      if (__b < __a)
     589:	mov    esi,DWORD PTR [rsp+0xc8]
      if (__a < __b)
     590:	cmp    ebx,eax
     592:	mov    r8d,eax
      if (__b < __a)
     595:	mov    eax,DWORD PTR [rdx+0x24]
      if (__a < __b)
     598:	cmovge r8d,ebx
      if (__b < __a)
     59c:	mov    ebx,DWORD PTR [rsp+0xc4]
     5a3:	mov    r13d,eax
     5a6:	cmp    ebx,eax
      if (__a < __b)
     5a8:	mov    eax,DWORD PTR [rdx+0x18]
     5ab:	mov    DWORD PTR [rsp+0xfc],r8d
      if (__b < __a)
     5b3:	cmovle r13d,ebx
      if (__a < __b)
     5b7:	cmp    edi,eax
     5b9:	mov    ebx,eax
      if (__b < __a)
     5bb:	mov    eax,DWORD PTR [rdx+0x1c]
      if (__a < __b)
     5be:	cmovge ebx,edi
      if (__b < __a)
     5c1:	mov    DWORD PTR [rsp+0xf8],r13d
     5c9:	cmp    esi,eax
     5cb:	cmovle eax,esi
      if (__a < __b)
     5ce:	mov    DWORD PTR [rsp+0xe4],ebx
                if (x_begin >= x_end || y_begin >= y_end) continue;
     5d5:	cmp    eax,ebx
     5d7:	jle    2e60 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x2e60>
     5dd:	cmp    r13d,r8d
     5e0:	jle    2e60 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x2e60>
                const __m256 Avx = _mm256_set1_ps(p.A);
     5e6:	vmovss xmm4,DWORD PTR [rdx+0x8]
                const __m256 Bvx = _mm256_set1_ps(p.B);
     5eb:	vmovss xmm5,DWORD PTR [rdx+0xc]
                const int x_floats = (x_end - x_begin) * 3;
     5f0:	sub    eax,ebx
                const __m256 Cvx = _mm256_set1_ps(p.C);
     5f2:	vmovss xmm6,DWORD PTR [rdx+0x10]
                const __m256 Dvx = _mm256_set1_ps(p.D);
     5f7:	vmovss xmm7,DWORD PTR [rdx+0x14]
                const int x_floats = (x_end - x_begin) * 3;
     5fc:	lea    eax,[rax+rax*2]
     5ff:	mov    DWORD PTR [rsp+0x1f0],eax
                const __m256 Avx = _mm256_set1_ps(p.A);
     606:	vbroadcastss ymm9,xmm4
                const __m256 Bvx = _mm256_set1_ps(p.B);
     60b:	vbroadcastss ymm17,xmm5
                const int x_floats = (x_end - x_begin) * 3;
     611:	mov    DWORD PTR [rsp+0xc0],eax
                const __m256 Cvx = _mm256_set1_ps(p.C);
     618:	vbroadcastss ymm25,xmm6
                const __m256 Dvx = _mm256_set1_ps(p.D);
     61e:	vbroadcastss ymm11,xmm7
                for (; y + 3 < y_end; y += 4) {
     623:	lea    eax,[r8+0x3]
/* Create a vector with all elements equal to A.  */
extern __inline __m256 __attribute__((__gnu_inline__, __always_inline__, __artificial__))
_mm256_set1_ps (float __A)
{
  return __extension__ (__m256){ __A, __A, __A, __A,
				 __A, __A, __A, __A };
     627:	vmovaps ymm0,ymm9
     62b:	vmovaps ymm1,ymm17
     631:	vmovaps ymm2,ymm25
     637:	vmovaps ymm3,ymm11
     63b:	cmp    r13d,eax
     63e:	jle    e8c <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0xe8c>
                    rb[0] = ((size_t)(y + p.sy) * width + (size_t)(x_begin + p.sx)) * 3;
     644:	mov    ecx,DWORD PTR [rdx]
     646:	mov    eax,r8d
     649:	mov    r10,QWORD PTR [rsp+0xb8]
                            __m256 v = _mm256_loadu_ps(vp0 + xf);
     651:	mov    DWORD PTR [rsp+0x1b0],0x0
                        float s0l = p.SUB[rb[0]+xf+k], s0r = p.SUB[rb[0]+xf+k+3];
     65c:	mov    r11,QWORD PTR [rdx+0x28]
     660:	mov    QWORD PTR [rsp+0x98],rdx
                    rb[0] = ((size_t)(y + p.sy) * width + (size_t)(x_begin + p.sx)) * 3;
     668:	add    ecx,ebx
                    float* vp0 = tile_vals.data() + (size_t)(y     - ty) * tile_row_stride + (size_t)(x_begin - tx) * 3;
     66a:	sub    ebx,edi
     66c:	movsxd rsi,ebx
                    rb[0] = ((size_t)(y + p.sy) * width + (size_t)(x_begin + p.sx)) * 3;
     66f:	movsxd rcx,ecx
                        float s0l = p.SUB[rb[0]+xf+k], s0r = p.SUB[rb[0]+xf+k+3];
     672:	mov    QWORD PTR [rsp+0x1d0],r11
                    float* vp0 = tile_vals.data() + (size_t)(y     - ty) * tile_row_stride + (size_t)(x_begin - tx) * 3;
     67a:	lea    rdi,[rsi+rsi*2]
     67e:	mov    rsi,rax
     681:	sub    rsi,QWORD PTR [rsp+0x78]
     686:	imul   rsi,QWORD PTR [rsp+0xa0]
     68f:	add    rsi,rdi
     692:	mov    rdi,QWORD PTR [rsp+0xd8]
     69a:	lea    rbx,[rdi+rsi*4]
     69e:	add    rsi,QWORD PTR [rsp+0x70]
     6a3:	lea    r12,[rdi+rsi*4]
     6a7:	movsxd rsi,DWORD PTR [rdx+0x4]
     6ab:	mov    rdi,r11
     6ae:	add    rsi,rax
     6b1:	imul   rsi,r10
     6b5:	lea    rax,[rcx+rsi*1]
     6b9:	add    rcx,r10
     6bc:	add    rcx,rsi
     6bf:	mov    rsi,QWORD PTR [rsp+0x60]
     6c4:	lea    rax,[rax+rax*2]
     6c8:	lea    rcx,[rcx+rcx*2]
     6cc:	lea    r11,[r11+rax*1]
     6d0:	lea    r9,[rdi+rcx*1]
     6d4:	mov    rcx,QWORD PTR [rsp+0xa8]
     6dc:	add    rcx,rdi
     6df:	lea    r14,[rcx+rax*1]
     6e3:	lea    rcx,[rdi+rsi*1]
     6e7:	mov    rsi,QWORD PTR [rsp+0x190]
     6ef:	lea    r10,[rcx+rax*1]
     6f3:	lea    rcx,[rdi+rsi*1]
     6f7:	lea    esi,[r13-0x4]
     6fb:	sub    esi,r8d
     6fe:	lea    r15,[rcx+rax*1]
     702:	mov    eax,DWORD PTR [rsp+0x1f0]
     709:	mov    rcx,QWORD PTR [rsp+0xa8]
     711:	mov    r8d,esi
     714:	mov    DWORD PTR [rsp+0x94],esi
     71b:	shr    r8d,0x2
     71f:	sub    eax,0x10
     722:	sub    rcx,rdi
     725:	mov    DWORD PTR [rsp+0x130],r8d
     72d:	mov    r8,QWORD PTR [rsp+0x68]
     732:	mov    QWORD PTR [rsp+0x150],rcx
     73a:	sub    r8,rdi
     73d:	mov    QWORD PTR [rsp+0x138],r8
     745:	mov    r8,QWORD PTR [rsp+0x88]
     74d:	sub    r8,rdi
     750:	mov    edi,eax
     752:	shr    eax,0x4
     755:	and    edi,0xfffffff0
     758:	inc    eax
     75a:	mov    QWORD PTR [rsp+0x140],r8
     762:	mov    r8,r10
                    if (xf + 8 <= x_floats) {
     765:	lea    ecx,[rdi+0x17]
     768:	shl    rax,0x4
     76c:	mov    DWORD PTR [rsp+0x108],edi
                        __m256 rl0 = load_cvt8(p.SUB + rb[0] + xf);
     773:	add    edi,0x10
                    if (xf + 8 <= x_floats) {
     776:	mov    DWORD PTR [rsp+0x10c],ecx
     77d:	mov    r10,r11
     780:	mov    QWORD PTR [rsp+0x100],rax
                        __m256 rl0 = load_cvt8(p.SUB + rb[0] + xf);
     788:	mov    QWORD PTR [rsp+0xf0],rdi
                            __m256 v = _mm256_loadu_ps(vp0 + xf);
     790:	shl    rdi,0x2
     794:	mov    QWORD PTR [rsp+0xe8],rdi
     79c:	mov    rdi,r15
     79f:	nop
                    rb[0] = ((size_t)(y + p.sy) * width + (size_t)(x_begin + p.sx)) * 3;
     7a0:	mov    rax,QWORD PTR [rsp+0x138]
     7a8:	lea    rdx,[rax+r14*1]
                    rb[2] = rb[1] + width * 3;
     7ac:	add    rax,rdi
     7af:	mov    QWORD PTR [rsp+0x1d8],rax
                    rb[3] = rb[2] + width * 3;
     7b7:	mov    rax,QWORD PTR [rsp+0x140]
                    rb[0] = ((size_t)(y + p.sy) * width + (size_t)(x_begin + p.sx)) * 3;
     7bf:	mov    QWORD PTR [rsp+0x1e8],rdx
                    rb[1] = rb[0] + width * 3;
     7c7:	mov    rdx,r9
                    rb[3] = rb[2] + width * 3;
     7ca:	add    rax,r14
                    rb[1] = rb[0] + width * 3;
     7cd:	sub    rdx,QWORD PTR [rsp+0x1d0]
                    rb[3] = rb[2] + width * 3;
     7d5:	mov    QWORD PTR [rsp+0x1c0],rax
                    rb[4] = rb[3] + width * 3;
     7dd:	mov    rax,QWORD PTR [rsp+0x150]
                    rb[1] = rb[0] + width * 3;
     7e5:	mov    QWORD PTR [rsp+0x1e0],rdx
                    rb[4] = rb[3] + width * 3;
     7ed:	lea    r15,[rax+r14*1]
                    float* vp1 = vp0 + tile_row_stride;
     7f1:	mov    rax,QWORD PTR [rsp+0x128]
     7f9:	lea    rdx,[rax+rbx*1]
                    float* vp3 = vp2 + tile_row_stride;
     7fd:	add    rax,r12
                    for (; xf + 16 <= x_floats; xf += 16) {
     800:	cmp    DWORD PTR [rsp+0x1f0],0xf
     808:	jle    3018 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x3018>
     80e:	mov    rsi,QWORD PTR [rsp+0x100]
     816:	xor    ecx,ecx
     818:	nop    DWORD PTR [rax+rax*1+0x0]

extern __inline __m256i
__attribute__ ((__gnu_inline__, __always_inline__, __artificial__))
_mm256_cvtepu8_epi32 (__m128i __X)
{
  return (__m256i) __builtin_ia32_pmovzxbd256 ((__v16qi)__X);
     820:	vpmovzxbd ymm19,QWORD PTR [r10+rcx*1]
     827:	vpmovzxbd ymm18,QWORD PTR [r10+rcx*1+0x8]
     82f:	vpmovzxbd ymm12,QWORD PTR [r10+rcx*1+0x3]
     836:	vpmovzxbd ymm8,QWORD PTR [r10+rcx*1+0xb]
  return (__m256)__builtin_ia32_cvtdq2ps256 ((__v8si) __A);
     83d:	vcvtdq2ps ymm19,ymm19
     843:	vcvtdq2ps ymm18,ymm18

extern __inline __m256
__attribute__((__gnu_inline__, __always_inline__, __artificial__))
_mm256_fmadd_ps (__m256 __A, __m256 __B, __m256 __C)
{
  return (__m256)__builtin_ia32_vfmaddps256 ((__v8sf)__A, (__v8sf)__B,
     849:	vfmadd213ps ymm19,ymm0,YMMWORD PTR [rbx+rcx*4]
     850:	vfmadd213ps ymm18,ymm0,YMMWORD PTR [rbx+rcx*4+0x20]
     858:	vcvtdq2ps ymm12,ymm12
     85d:	vcvtdq2ps ymm8,ymm8
     862:	vpmovzxbd ymm16,QWORD PTR [r9+rcx*1]
     869:	vpmovzxbd ymm15,QWORD PTR [r9+rcx*1+0x8]
     870:	vpmovzxbd ymm14,QWORD PTR [r9+rcx*1+0x3]
     877:	vpmovzxbd ymm13,QWORD PTR [r9+rcx*1+0xb]
     87e:	vcvtdq2ps ymm16,ymm16
     884:	vcvtdq2ps ymm15,ymm15
     889:	vcvtdq2ps ymm14,ymm14
     88e:	vcvtdq2ps ymm13,ymm13
     893:	vfmadd132ps ymm12,ymm19,ymm1
     899:	vfmadd132ps ymm8,ymm18,ymm1
     89f:	vpmovzxbd ymm19,QWORD PTR [r14+rcx*1]
     8a6:	vpmovzxbd ymm18,QWORD PTR [r14+rcx*1+0x8]
     8ae:	vcvtdq2ps ymm19,ymm19
     8b4:	vcvtdq2ps ymm18,ymm18
     8ba:	vfmadd231ps ymm12,ymm2,ymm16
     8c0:	vfmadd231ps ymm8,ymm2,ymm15
     8c5:	vfmadd231ps ymm12,ymm3,ymm14
     8ca:	vfmadd231ps ymm8,ymm3,ymm13
  *(__m256_u *)__P = __A;
     8cf:	vmovups YMMWORD PTR [rbx+rcx*4],ymm12
     8d4:	vpmovzxbd ymm12,QWORD PTR [r14+rcx*1+0x3]
     8db:	vmovups YMMWORD PTR [rbx+rcx*4+0x20],ymm8
     8e1:	vpmovzxbd ymm8,QWORD PTR [r14+rcx*1+0xb]
     8e8:	vfmadd213ps ymm16,ymm0,YMMWORD PTR [rdx+rcx*4]
     8ef:	vfmadd213ps ymm15,ymm0,YMMWORD PTR [rdx+rcx*4+0x20]
  return (__m256)__builtin_ia32_cvtdq2ps256 ((__v8si) __A);
     8f6:	vcvtdq2ps ymm12,ymm12
     8fb:	vcvtdq2ps ymm8,ymm8
     900:	vfmadd132ps ymm14,ymm16,ymm1
     906:	vfmadd132ps ymm13,ymm15,ymm1
     90b:	vpmovzxbd ymm16,QWORD PTR [r8+rcx*1]
     912:	vpmovzxbd ymm15,QWORD PTR [r8+rcx*1+0x8]
     919:	vcvtdq2ps ymm16,ymm16
     91f:	vcvtdq2ps ymm15,ymm15
     924:	vfmadd231ps ymm14,ymm2,ymm19
     92a:	vfmadd231ps ymm13,ymm2,ymm18
     930:	vfmadd231ps ymm14,ymm3,ymm12
     935:	vfmadd231ps ymm13,ymm3,ymm8
  *(__m256_u *)__P = __A;
     93a:	vmovups YMMWORD PTR [rdx+rcx*4],ymm14
     93f:	vpmovzxbd ymm14,QWORD PTR [r8+rcx*1+0x3]
     946:	vmovups YMMWORD PTR [rdx+rcx*4+0x20],ymm13
     94c:	vpmovzxbd ymm13,QWORD PTR [r8+rcx*1+0xb]
     953:	vfmadd213ps ymm19,ymm0,YMMWORD PTR [r12+rcx*4]
     95a:	vfmadd213ps ymm18,ymm0,YMMWORD PTR [r12+rcx*4+0x20]
  return (__m256)__builtin_ia32_cvtdq2ps256 ((__v8si) __A);
     962:	vcvtdq2ps ymm14,ymm14
     967:	vcvtdq2ps ymm13,ymm13
     96c:	vfmadd132ps ymm12,ymm19,ymm1
     972:	vfmadd132ps ymm8,ymm18,ymm1
     978:	vpmovzxbd ymm19,QWORD PTR [rdi+rcx*1]
     97f:	vpmovzxbd ymm18,QWORD PTR [rdi+rcx*1+0x8]
     987:	vfmadd231ps ymm12,ymm2,ymm16
     98d:	vfmadd231ps ymm8,ymm2,ymm15
     992:	vfmadd231ps ymm12,ymm3,ymm14
     997:	vfmadd231ps ymm8,ymm3,ymm13
  *(__m256_u *)__P = __A;
     99c:	vmovups YMMWORD PTR [r12+rcx*4],ymm12
     9a2:	vpmovzxbd ymm12,QWORD PTR [rdi+rcx*1+0x3]
     9a9:	vmovups YMMWORD PTR [r12+rcx*4+0x20],ymm8
     9b0:	vpmovzxbd ymm8,QWORD PTR [rdi+rcx*1+0xb]
     9b7:	vfmadd213ps ymm16,ymm0,YMMWORD PTR [rax+rcx*4]
     9be:	vfmadd213ps ymm15,ymm0,YMMWORD PTR [rax+rcx*4+0x20]
  return (__m256)__builtin_ia32_cvtdq2ps256 ((__v8si) __A);
     9c5:	vcvtdq2ps ymm12,ymm12
     9ca:	vcvtdq2ps ymm8,ymm8
     9cf:	vfmadd132ps ymm14,ymm16,ymm1
     9d5:	vfmadd132ps ymm13,ymm15,ymm1
     9da:	vcvtdq2ps ymm16,ymm19
     9e0:	vcvtdq2ps ymm15,ymm18
     9e6:	vfmadd132ps ymm16,ymm14,ymm2
     9ec:	vfmadd132ps ymm15,ymm13,ymm2
     9f1:	vfmadd132ps ymm12,ymm16,ymm3
     9f7:	vfmadd132ps ymm8,ymm15,ymm3
  *(__m256_u *)__P = __A;
     9fc:	vmovups YMMWORD PTR [rax+rcx*4],ymm12
     a01:	vmovups YMMWORD PTR [rax+rcx*4+0x20],ymm8
     a07:	add    rcx,0x10
     a0b:	cmp    rsi,rcx
     a0e:	jne    820 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x820>
                    if (xf + 8 <= x_floats) {
     a14:	mov    r11d,DWORD PTR [rsp+0x108]
     a1c:	mov    r13d,DWORD PTR [rsp+0x1f0]
     a24:	lea    esi,[r11+0x10]
     a28:	cmp    DWORD PTR [rsp+0x10c],r13d
     a30:	jge    bec <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0xbec>
                        __m256 rl0 = load_cvt8(p.SUB + rb[0] + xf);
     a36:	mov    rsi,QWORD PTR [rsp+0xf0]
     a3e:	mov    rcx,QWORD PTR [rsp+0x1e8]
     a46:	add    rcx,rsi
     a49:	mov    QWORD PTR [rsp+0x1a8],rcx
                        __m256 rl1 = load_cvt8(p.SUB + rb[1] + xf);
     a51:	mov    rcx,QWORD PTR [rsp+0x1e0]
     a59:	add    rcx,rsi
     a5c:	mov    QWORD PTR [rsp+0x1a0],rcx
                            __m256 v = _mm256_loadu_ps(vp0 + xf);
     a64:	mov    rcx,QWORD PTR [rsp+0xe8]
     a6c:	lea    r13,[rbx+rcx*1]
     a70:	mov    QWORD PTR [rsp+0x198],r13
                        __m256 rl2 = load_cvt8(p.SUB + rb[2] + xf);
     a78:	mov    r13,QWORD PTR [rsp+0x1d8]
     a80:	add    r13,rsi
     a83:	mov    QWORD PTR [rsp+0x180],r13
                            __m256 v = _mm256_loadu_ps(vp1 + xf);
     a8b:	lea    r13,[rdx+rcx*1]
     a8f:	mov    QWORD PTR [rsp+0x170],r13
                        __m256 rl3 = load_cvt8(p.SUB + rb[3] + xf);
     a97:	mov    r13,QWORD PTR [rsp+0x1c0]
     a9f:	add    r13,rsi
                        __m256 rl4 = load_cvt8(p.SUB + rb[4] + xf);
     aa2:	add    rsi,r15
                        __m256 rl3 = load_cvt8(p.SUB + rb[3] + xf);
     aa5:	mov    QWORD PTR [rsp+0x160],r13
                            __m256 v = _mm256_loadu_ps(vp2 + xf);
     aad:	lea    r13,[r12+rcx*1]
                            __m256 v = _mm256_loadu_ps(vp3 + xf);
     ab1:	add    rcx,rax
                            __m256 v = _mm256_loadu_ps(vp2 + xf);
     ab4:	mov    QWORD PTR [rsp+0x118],r13
                        __m256 rl4 = load_cvt8(p.SUB + rb[4] + xf);
     abc:	mov    QWORD PTR [rsp+0x110],rsi
                        xf += 8;
     ac4:	lea    esi,[r11+0x18]
     ac8:	mov    r11,QWORD PTR [rsp+0x1d0]
     ad0:	mov    r13,QWORD PTR [rsp+0x1a8]
     ad8:	vpmovzxbd ymm14,QWORD PTR [r11+r13*1]
     ade:	vpmovzxbd ymm8,QWORD PTR [r11+r13*1+0x3]
     ae5:	mov    r13,QWORD PTR [rsp+0x1a0]
  return (__m256)__builtin_ia32_cvtdq2ps256 ((__v8si) __A);
     aed:	vcvtdq2ps ymm14,ymm14
     af2:	vcvtdq2ps ymm8,ymm8
     af7:	vpmovzxbd ymm13,QWORD PTR [r11+r13*1]
     afd:	vpmovzxbd ymm12,QWORD PTR [r11+r13*1+0x3]
     b04:	mov    r13,QWORD PTR [rsp+0x198]
     b0c:	vcvtdq2ps ymm13,ymm13
     b11:	vcvtdq2ps ymm12,ymm12
     b16:	vfmadd213ps ymm14,ymm0,YMMWORD PTR [r13+0x0]
     b1c:	vfmadd132ps ymm8,ymm14,ymm1
     b21:	vfmadd231ps ymm8,ymm2,ymm13
     b26:	vfmadd231ps ymm8,ymm3,ymm12
  *(__m256_u *)__P = __A;
     b2b:	vmovups YMMWORD PTR [r13+0x0],ymm8
     b31:	mov    r13,QWORD PTR [rsp+0x180]
     b39:	vpmovzxbd ymm14,QWORD PTR [r11+r13*1]
     b3f:	vpmovzxbd ymm8,QWORD PTR [r11+r13*1+0x3]
     b46:	mov    r13,QWORD PTR [rsp+0x170]
  return (__m256)__builtin_ia32_cvtdq2ps256 ((__v8si) __A);
     b4e:	vcvtdq2ps ymm14,ymm14
     b53:	vcvtdq2ps ymm8,ymm8
     b58:	vfmadd213ps ymm13,ymm0,YMMWORD PTR [r13+0x0]
     b5e:	vfmadd132ps ymm12,ymm13,ymm1
     b63:	vfmadd231ps ymm12,ymm2,ymm14
     b68:	vfmadd231ps ymm12,ymm3,ymm8
  *(__m256_u *)__P = __A;
     b6d:	vmovups YMMWORD PTR [r13+0x0],ymm12
     b73:	mov    r13,QWORD PTR [rsp+0x160]
     b7b:	vpmovzxbd ymm13,QWORD PTR [r11+r13*1]
     b81:	vpmovzxbd ymm12,QWORD PTR [r11+r13*1+0x3]
     b88:	mov    r13,QWORD PTR [rsp+0x118]
  return (__m256)__builtin_ia32_cvtdq2ps256 ((__v8si) __A);
     b90:	vcvtdq2ps ymm13,ymm13
     b95:	vcvtdq2ps ymm12,ymm12
     b9a:	vfmadd213ps ymm14,ymm0,YMMWORD PTR [r13+0x0]
     ba0:	vfmadd132ps ymm8,ymm14,ymm1
     ba5:	vfmadd231ps ymm8,ymm2,ymm13
     baa:	vfmadd231ps ymm8,ymm3,ymm12
  *(__m256_u *)__P = __A;
     baf:	vmovups YMMWORD PTR [r13+0x0],ymm8
     bb5:	mov    r13,QWORD PTR [rsp+0x110]
     bbd:	vfmadd213ps ymm13,ymm0,YMMWORD PTR [rcx]
     bc2:	vpmovzxbd ymm14,QWORD PTR [r11+r13*1]
     bc8:	vpmovzxbd ymm8,QWORD PTR [r11+r13*1+0x3]
  return (__m256)__builtin_ia32_cvtdq2ps256 ((__v8si) __A);
     bcf:	vcvtdq2ps ymm14,ymm14
     bd4:	vcvtdq2ps ymm8,ymm8
     bd9:	vfmadd132ps ymm12,ymm13,ymm1
     bde:	vfmadd231ps ymm12,ymm2,ymm14
     be3:	vfmadd132ps ymm8,ymm12,ymm3
  *(__m256_u *)__P = __A;
     be8:	vmovups YMMWORD PTR [rcx],ymm8
                    for (int k = 0; k < x_floats - xf; ++k) {
     bec:	mov    ecx,DWORD PTR [rsp+0x1f0]
     bf3:	sub    ecx,esi
     bf5:	mov    DWORD PTR [rsp+0x1a8],ecx
     bfc:	test   ecx,ecx
     bfe:	jle    e1e <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0xe1e>
                        float s0l = p.SUB[rb[0]+xf+k], s0r = p.SUB[rb[0]+xf+k+3];
     c04:	add    QWORD PTR [rsp+0x1e8],rsi
                        float s4l = p.SUB[rb[4]+xf+k], s4r = p.SUB[rb[4]+xf+k+3];
     c0c:	add    r15,rsi
                        float s1l = p.SUB[rb[1]+xf+k], s1r = p.SUB[rb[1]+xf+k+3];
     c0f:	add    QWORD PTR [rsp+0x1e0],rsi
                        float s2l = p.SUB[rb[2]+xf+k], s2r = p.SUB[rb[2]+xf+k+3];
     c17:	add    QWORD PTR [rsp+0x1d8],rsi
                        float s3l = p.SUB[rb[3]+xf+k], s3r = p.SUB[rb[3]+xf+k+3];
     c1f:	add    QWORD PTR [rsp+0x1c0],rsi
     c27:	shl    rsi,0x2
     c2b:	mov    rcx,QWORD PTR [rsp+0x1e8]
     c33:	mov    QWORD PTR [rsp+0x180],r14
     c3b:	add    rdx,rsi
     c3e:	add    rax,rsi
     c41:	lea    r11,[rbx+rsi*1]
     c45:	mov    QWORD PTR [rsp+0x170],r9
     c4d:	mov    QWORD PTR [rsp+0x198],rdx
     c55:	lea    r13,[r12+rsi*1]
     c59:	mov    rdx,QWORD PTR [rsp+0x1e0]
     c61:	mov    rsi,QWORD PTR [rsp+0x1d0]
     c69:	mov    QWORD PTR [rsp+0x1a0],rax
                    int xf = 0;
     c71:	xor    eax,eax
     c73:	mov    QWORD PTR [rsp+0x160],r10
     c7b:	mov    r10d,DWORD PTR [rsp+0x1a8]
     c83:	add    rcx,rsi
     c86:	add    rdx,rsi
     c89:	mov    QWORD PTR [rsp+0x1e8],rcx
     c91:	mov    rcx,QWORD PTR [rsp+0x1d8]
     c99:	mov    QWORD PTR [rsp+0x1e0],rdx
     ca1:	mov    rdx,QWORD PTR [rsp+0x1c0]
     ca9:	mov    QWORD PTR [rsp+0x1d8],rdi
     cb1:	mov    rdi,QWORD PTR [rsp+0x1a0]
     cb9:	add    rcx,rsi
     cbc:	mov    QWORD PTR [rsp+0x1c0],r8
     cc4:	mov    r9,QWORD PTR [rsp+0x1e8]
     ccc:	add    rdx,rsi
     ccf:	add    rsi,r15
     cd2:	mov    r8,QWORD PTR [rsp+0x198]
     cda:	mov    r14,QWORD PTR [rsp+0x1e0]
     ce2:	nop    WORD PTR [rax+rax*1+0x0]
                        float s1l = p.SUB[rb[1]+xf+k], s1r = p.SUB[rb[1]+xf+k+3];
     ce8:	movzx  r15d,BYTE PTR [r14+rax*1]
     ced:	vcvtusi2ss xmm12,xmm10,r15d
     cf3:	movzx  r15d,BYTE PTR [r14+rax*1+0x3]
     cf9:	vcvtusi2ss xmm20,xmm10,r15d
                        float s2l = p.SUB[rb[2]+xf+k], s2r = p.SUB[rb[2]+xf+k+3];
     cff:	movzx  r15d,BYTE PTR [rcx+rax*1]
     d04:	vcvtusi2ss xmm8,xmm10,r15d
     d0a:	movzx  r15d,BYTE PTR [rcx+rax*1+0x3]
                        vp0[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
     d10:	vmulss xmm22,xmm6,xmm12
                        float s2l = p.SUB[rb[2]+xf+k], s2r = p.SUB[rb[2]+xf+k+3];
     d16:	vcvtusi2ss xmm19,xmm10,r15d
                        float s3l = p.SUB[rb[3]+xf+k], s3r = p.SUB[rb[3]+xf+k+3];
     d1c:	movzx  r15d,BYTE PTR [rdx+rax*1]
     d21:	vcvtusi2ss xmm16,xmm10,r15d
     d27:	movzx  r15d,BYTE PTR [rdx+rax*1+0x3]
     d2d:	vcvtusi2ss xmm15,xmm10,r15d
                        float s4l = p.SUB[rb[4]+xf+k], s4r = p.SUB[rb[4]+xf+k+3];
     d33:	movzx  r15d,BYTE PTR [rsi+rax*1]
     d38:	vcvtusi2ss xmm18,xmm10,r15d
     d3e:	movzx  r15d,BYTE PTR [rsi+rax*1+0x3]
     d44:	vcvtusi2ss xmm14,xmm10,r15d
                        float s0l = p.SUB[rb[0]+xf+k], s0r = p.SUB[rb[0]+xf+k+3];
     d4a:	movzx  r15d,BYTE PTR [r9+rax*1]
     d4f:	vcvtusi2ss xmm13,xmm10,r15d
     d55:	movzx  r15d,BYTE PTR [r9+rax*1+0x3]
                        vp3[xf+k] += p.A*s3l + p.B*s3r + p.C*s4l + p.D*s4r;
     d5b:	vmulss xmm18,xmm6,xmm18
                        float s0l = p.SUB[rb[0]+xf+k], s0r = p.SUB[rb[0]+xf+k+3];
     d61:	vcvtusi2ss xmm21,xmm10,r15d
     d67:	vfmadd213ss xmm13,xmm4,DWORD PTR [r11+rax*4]
     d6d:	vfmadd132ss xmm21,xmm22,xmm5
                        vp0[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
     d73:	vfmadd231ss xmm13,xmm7,xmm20
     d79:	vaddss xmm13,xmm13,xmm21
     d7f:	vmovss DWORD PTR [r11+rax*4],xmm13
                        vp1[xf+k] += p.A*s1l + p.B*s1r + p.C*s2l + p.D*s2r;
     d85:	vmulss xmm13,xmm6,xmm8
     d8a:	vfmadd213ss xmm12,xmm4,DWORD PTR [r8+rax*4]
     d90:	vfmadd132ss xmm20,xmm13,xmm5
     d96:	vfmadd231ss xmm12,xmm7,xmm19
     d9c:	vaddss xmm12,xmm12,xmm20
     da2:	vmovss DWORD PTR [r8+rax*4],xmm12
                        vp2[xf+k] += p.A*s2l + p.B*s2r + p.C*s3l + p.D*s3r;
     da8:	vmulss xmm12,xmm6,xmm16
     dae:	vfmadd213ss xmm8,xmm4,DWORD PTR [r13+rax*4+0x0]
     db5:	vfmadd132ss xmm19,xmm12,xmm5
     dbb:	vfmadd231ss xmm8,xmm7,xmm15
     dc0:	vfmadd132ss xmm15,xmm18,xmm5
     dc6:	vaddss xmm8,xmm8,xmm19
     dcc:	vmovss DWORD PTR [r13+rax*4+0x0],xmm8
                        vp3[xf+k] += p.A*s3l + p.B*s3r + p.C*s4l + p.D*s4r;
     dd3:	vfmadd213ss xmm16,xmm4,DWORD PTR [rdi+rax*4]
     dda:	vfmadd132ss xmm14,xmm16,xmm7
     de0:	vaddss xmm14,xmm14,xmm15
     de5:	vmovss DWORD PTR [rdi+rax*4],xmm14
                    for (int k = 0; k < x_floats - xf; ++k) {
     dea:	inc    rax
     ded:	cmp    r10d,eax
     df0:	jg     ce8 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0xce8>
     df6:	mov    rdi,QWORD PTR [rsp+0x1d8]
     dfe:	mov    r8,QWORD PTR [rsp+0x1c0]
     e06:	mov    r14,QWORD PTR [rsp+0x180]
     e0e:	mov    r9,QWORD PTR [rsp+0x170]
     e16:	mov    r10,QWORD PTR [rsp+0x160]
                for (; y + 3 < y_end; y += 4) {
     e1e:	mov    rax,QWORD PTR [rsp+0x120]
     e26:	mov    edx,DWORD PTR [rsp+0x1b0]
     e2d:	add    rbx,rax
     e30:	add    r12,rax
     e33:	mov    rax,QWORD PTR [rsp+0x190]
     e3b:	add    r10,rax
     e3e:	add    r9,rax
     e41:	add    r14,rax
     e44:	add    r8,rax
     e47:	add    rdi,rax
     e4a:	cmp    DWORD PTR [rsp+0x130],edx
     e51:	je     e68 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0xe68>
     e53:	mov    eax,edx
     e55:	inc    eax
     e57:	mov    DWORD PTR [rsp+0x1b0],eax
     e5e:	jmp    7a0 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x7a0>
     e63:	nop    DWORD PTR [rax+rax*1+0x0]
     e68:	mov    esi,DWORD PTR [rsp+0x94]
     e6f:	mov    eax,DWORD PTR [rsp+0xfc]
     e76:	mov    rdx,QWORD PTR [rsp+0x98]
     e7e:	and    esi,0xfffffffc
     e81:	lea    eax,[rax+rsi*1+0x4]
     e85:	mov    DWORD PTR [rsp+0xfc],eax
                for (; y + 1 < y_end; y += 2) {
     e8c:	mov    ebx,DWORD PTR [rsp+0xfc]
     e93:	lea    eax,[rbx+0x1]
     e96:	cmp    DWORD PTR [rsp+0xf8],eax
     e9d:	jle    22a6 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x22a6>
                    rb[0] = ((size_t)(y + p.sy) * width + (size_t)(x_begin + p.sx)) * 3;
     ea3:	mov    eax,DWORD PTR [rdx+0x4]
     ea6:	mov    edi,DWORD PTR [rsp+0xe4]
     ead:	mov    ecx,DWORD PTR [rdx]
                    for (; xf + 16 <= x_floats; xf += 16) {
     eaf:	mov    r14d,DWORD PTR [rsp+0x1f0]
                    rb[0] = ((size_t)(y + p.sy) * width + (size_t)(x_begin + p.sx)) * 3;
     eb7:	add    eax,ebx
                    float* vp0 = tile_vals.data() + (size_t)(y - ty)     * tile_row_stride + (size_t)(x_begin - tx) * 3;
     eb9:	sub    ebx,DWORD PTR [rsp+0xe0]
     ec0:	movsxd rsi,ebx
     ec3:	mov    rbx,QWORD PTR [rsp+0xa0]
                    rb[0] = ((size_t)(y + p.sy) * width + (size_t)(x_begin + p.sx)) * 3;
     ecb:	cdqe
     ecd:	add    ecx,edi
     ecf:	imul   rax,QWORD PTR [rsp+0xb8]
                    float* vp0 = tile_vals.data() + (size_t)(y - ty)     * tile_row_stride + (size_t)(x_begin - tx) * 3;
     ed8:	sub    edi,DWORD PTR [rsp+0xcc]
                    rb[0] = ((size_t)(y + p.sy) * width + (size_t)(x_begin + p.sx)) * 3;
     edf:	movsxd rcx,ecx
                    float* vp0 = tile_vals.data() + (size_t)(y - ty)     * tile_row_stride + (size_t)(x_begin - tx) * 3;
     ee2:	imul   rbx,rsi
     ee6:	movsxd rsi,edi
     ee9:	mov    rdi,QWORD PTR [rsp+0xd8]
     ef1:	lea    rsi,[rsi+rsi*2]
                    rb[0] = ((size_t)(y + p.sy) * width + (size_t)(x_begin + p.sx)) * 3;
     ef5:	add    rax,rcx
                    float* vp0 = tile_vals.data() + (size_t)(y - ty)     * tile_row_stride + (size_t)(x_begin - tx) * 3;
     ef8:	add    rsi,rbx
                    rb[0] = ((size_t)(y + p.sy) * width + (size_t)(x_begin + p.sx)) * 3;
     efb:	lea    rcx,[rax+rax*2]
                    rb[1] = rb[0] + width * 3;
     eff:	mov    rax,QWORD PTR [rsp+0x88]
                    float* vp0 = tile_vals.data() + (size_t)(y - ty)     * tile_row_stride + (size_t)(x_begin - tx) * 3;
     f07:	lea    rsi,[rdi+rsi*4]
                    float* vp1 = vp0 + tile_row_stride;
     f0b:	mov    rdi,QWORD PTR [rsp+0x128]
                    rb[0] = ((size_t)(y + p.sy) * width + (size_t)(x_begin + p.sx)) * 3;
     f13:	mov    QWORD PTR [rsp+0x1e8],rcx
                    rb[1] = rb[0] + width * 3;
     f1b:	lea    r13,[rax+rcx*1]
                    float* vp0 = tile_vals.data() + (size_t)(y - ty)     * tile_row_stride + (size_t)(x_begin - tx) * 3;
     f1f:	mov    QWORD PTR [rsp+0x1a0],rsi
                    float* vp1 = vp0 + tile_row_stride;
     f27:	lea    r9,[rsi+rdi*1]
                    rb[2] = rb[1] + width * 3;
     f2b:	add    rax,r13
                    float* vp1 = vp0 + tile_row_stride;
     f2e:	mov    QWORD PTR [rsp+0x198],r9
                    for (; xf + 16 <= x_floats; xf += 16) {
     f36:	cmp    r14d,0xf
     f3a:	jle    3620 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x3620>
     f40:	mov    r10d,r14d
     f43:	mov    rdi,QWORD PTR [rdx+0x28]
     f47:	lea    r11d,[r14-0x10]
     f4b:	shr    r10d,0x4
     f4f:	shl    r10,0x6
     f53:	mov    QWORD PTR [rsp+0x1d0],rdi
     f5b:	lea    r8,[rdi+r13*1]
     f5f:	mov    rdi,rsi
     f62:	add    r10,rsi
     f65:	nop    DWORD PTR [rax]
}

extern __inline __m128i __attribute__((__gnu_inline__, __always_inline__, __artificial__))
_mm_loadl_epi64 (__m128i_u const *__P)
{
  return _mm_set_epi64 ((__m64)0LL, *(__m64_u *)__P);
     f68:	mov    rsi,r8
     f6b:	vpmovzxbd ymm16,QWORD PTR [r8]
     f71:	vpmovzxbd ymm15,QWORD PTR [r8+0x8]
     f77:	add    rdi,0x40
     f7b:	sub    rsi,r13
     f7e:	vpmovzxbd ymm14,QWORD PTR [r8+0x3]
     f84:	vpmovzxbd ymm13,QWORD PTR [r8+0xb]
     f8a:	add    r9,0x40
     f8e:	vpmovzxbd ymm19,QWORD PTR [rsi+rcx*1]
     f95:	vpmovzxbd ymm18,QWORD PTR [rsi+rcx*1+0x8]
  return (__m256)__builtin_ia32_cvtdq2ps256 ((__v8si) __A);
     f9d:	vcvtdq2ps ymm16,ymm16
     fa3:	vcvtdq2ps ymm15,ymm15
     fa8:	add    r8,0x10
     fac:	vpmovzxbd ymm12,QWORD PTR [rsi+rcx*1+0x3]
     fb3:	vpmovzxbd ymm8,QWORD PTR [rsi+rcx*1+0xb]
     fba:	vcvtdq2ps ymm14,ymm14
     fbf:	vcvtdq2ps ymm13,ymm13
     fc4:	vcvtdq2ps ymm19,ymm19
     fca:	vcvtdq2ps ymm18,ymm18
     fd0:	vfmadd213ps ymm19,ymm0,YMMWORD PTR [rdi-0x40]
     fd7:	vfmadd213ps ymm18,ymm0,YMMWORD PTR [rdi-0x20]
     fde:	vcvtdq2ps ymm12,ymm12
     fe3:	vcvtdq2ps ymm8,ymm8
     fe8:	vfmadd132ps ymm12,ymm19,ymm1
     fee:	vfmadd132ps ymm8,ymm18,ymm1
     ff4:	vpmovzxbd ymm19,QWORD PTR [rsi+rax*1]
     ffb:	vpmovzxbd ymm18,QWORD PTR [rsi+rax*1+0x8]
    1003:	vcvtdq2ps ymm19,ymm19
    1009:	vcvtdq2ps ymm18,ymm18
    100f:	vfmadd231ps ymm12,ymm2,ymm16
    1015:	vfmadd231ps ymm8,ymm2,ymm15
    101a:	vfmadd231ps ymm12,ymm3,ymm14
    101f:	vfmadd231ps ymm8,ymm3,ymm13
  *(__m256_u *)__P = __A;
    1024:	vmovups YMMWORD PTR [rdi-0x40],ymm12
    1029:	vpmovzxbd ymm12,QWORD PTR [rsi+rax*1+0x3]
    1030:	vmovups YMMWORD PTR [rdi-0x20],ymm8
    1035:	vpmovzxbd ymm8,QWORD PTR [rsi+rax*1+0xb]
    103c:	vfmadd213ps ymm16,ymm0,YMMWORD PTR [r9-0x40]
    1043:	vfmadd213ps ymm15,ymm0,YMMWORD PTR [r9-0x20]
  return (__m256)__builtin_ia32_cvtdq2ps256 ((__v8si) __A);
    1049:	vcvtdq2ps ymm12,ymm12
    104e:	vcvtdq2ps ymm8,ymm8
    1053:	vfmadd132ps ymm14,ymm16,ymm1
    1059:	vfmadd132ps ymm13,ymm15,ymm1
    105e:	vfmadd231ps ymm14,ymm2,ymm19
    1064:	vfmadd231ps ymm13,ymm2,ymm18
    106a:	vfmadd132ps ymm12,ymm14,ymm3
    106f:	vfmadd132ps ymm8,ymm13,ymm3
  *(__m256_u *)__P = __A;
    1074:	vmovups YMMWORD PTR [r9-0x40],ymm12
    107a:	vmovups YMMWORD PTR [r9-0x20],ymm8
    1080:	cmp    r10,rdi
    1083:	jne    f68 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0xf68>
    1089:	mov    esi,r11d
    108c:	and    esi,0xfffffff0
                    if (xf + 8 <= x_floats) {
    108f:	lea    edi,[rsi+0x17]
    1092:	cmp    edi,DWORD PTR [rsp+0x1f0]
    1099:	jl     309f <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x309f>
    109f:	lea    edi,[rsi+0x10]
    10a2:	mov    DWORD PTR [rsp+0x1a8],edi
                    for (int k = 0; k < x_floats - xf; ++k) {
    10a9:	mov    edi,DWORD PTR [rsp+0x1f0]
    10b0:	mov    esi,DWORD PTR [rsp+0x1a8]
    10b7:	sub    edi,esi
    10b9:	mov    DWORD PTR [rsp+0x1e0],edi
    10c0:	test   edi,edi
    10c2:	jle    229e <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x229e>
                        float s0l = p.SUB[rb[0]+xf+k], s0r = p.SUB[rb[0]+xf+k+3];
    10c8:	mov    edi,esi
    10ca:	lea    rsi,[rcx+rdi*1]
    10ce:	mov    QWORD PTR [rsp+0x1d8],rdi
                        float s1l = p.SUB[rb[1]+xf+k], s1r = p.SUB[rb[1]+xf+k+3];
    10d6:	add    r13,rdi
                        float s2l = p.SUB[rb[2]+xf+k], s2r = p.SUB[rb[2]+xf+k+3];
    10d9:	add    rax,rdi
                        float s0l = p.SUB[rb[0]+xf+k], s0r = p.SUB[rb[0]+xf+k+3];
    10dc:	mov    QWORD PTR [rsp+0x1e8],rsi
    10e4:	mov    r11,rdi
    10e7:	mov    ecx,DWORD PTR [rsp+0xe4]
    10ee:	sub    rcx,QWORD PTR [rsp+0xb0]
    10f6:	lea    rsi,[rcx+rcx*2]
    10fa:	add    rcx,QWORD PTR [rsp+0x48]
    10ff:	lea    rcx,[rcx+rcx*2]
    1103:	add    rsi,rbx
    1106:	add    rcx,rbx
    1109:	lea    rdi,[rsi+r11*1]
    110d:	lea    rbx,[rcx+r11*1]
    1111:	mov    QWORD PTR [rsp+0x1c0],rdi
    1119:	lea    rsi,[rdi*4+0x0]
    1121:	lea    rcx,[rbx*4+0x0]
    1129:	lea    rdi,[rdi*4+0x80]
    1131:	mov    r15,rbx
    1134:	cmp    rcx,rdi
    1137:	jge    1149 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x1149>
    1139:	lea    rdi,[rcx+0x80]
    1140:	cmp    rsi,rdi
    1143:	jl     3158 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x3158>
    1149:	mov    ebx,DWORD PTR [rsp+0x1e0]
    1150:	lea    edi,[rbx-0x1]
    1153:	cmp    edi,0x1e
    1156:	jbe    36e4 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x36e4>
    115c:	shr    ebx,0x5
    115f:	mov    r10,QWORD PTR [rsp+0x1e8]
    1167:	vmovss DWORD PTR [rsp+0x180],xmm4
    1170:	mov    edi,ebx
    1172:	mov    DWORD PTR [rsp+0x1b0],ebx
    1179:	mov    rbx,QWORD PTR [rsp+0x1d0]
    1181:	vmovss DWORD PTR [rsp+0x170],xmm5
    118a:	lea    r9,[rbx+r10*1+0x3]
    118f:	lea    r14,[rbx+r10*1]
    1193:	vmovss DWORD PTR [rsp+0x160],xmm6
    119c:	lea    r8,[rbx+r13*1+0x3]
    11a1:	lea    r11,[rbx+r13*1]
    11a5:	vmovss DWORD PTR [rsp+0x150],xmm7
    11ae:	lea    r10,[rbx+rax*1+0x3]
    11b3:	lea    r12,[rbx+rax*1]
    11b7:	mov    rbx,QWORD PTR [rsp+0xd8]
    11bf:	add    rcx,rbx
    11c2:	add    rsi,rbx
    11c5:	mov    rbx,rdi
    11c8:	xor    edi,edi
    11ca:	shl    rbx,0x5
    11ce:	xchg   ax,ax
                        float s1l = p.SUB[rb[1]+xf+k], s1r = p.SUB[rb[1]+xf+k+3];
    11d0:	vmovdqu ymm5,YMMWORD PTR [r11+rdi*1]
                        float s0l = p.SUB[rb[0]+xf+k], s0r = p.SUB[rb[0]+xf+k+3];
    11d6:	vmovdqu ymm4,YMMWORD PTR [r9+rdi*1]
    11dc:	sub    rcx,0xffffffffffffff80
    11e0:	sub    rsi,0xffffffffffffff80
    11e4:	vmovdqu ymm13,YMMWORD PTR [r14+rdi*1]
                        float s1l = p.SUB[rb[1]+xf+k], s1r = p.SUB[rb[1]+xf+k+3];
    11ea:	vpmovzxbw ymm7,xmm5
    11ef:	vextracti32x4 xmm5,ymm5,0x1
                        float s0l = p.SUB[rb[0]+xf+k], s0r = p.SUB[rb[0]+xf+k+3];
    11f6:	vpmovzxbw ymm6,xmm4
                        float s1l = p.SUB[rb[1]+xf+k], s1r = p.SUB[rb[1]+xf+k+3];
    11fb:	vpmovzxbw ymm5,xmm5
    1200:	vpmovsxwd ymm27,xmm7
    1206:	vextracti32x4 xmm16,ymm7,0x1
    120d:	vpmovsxwd ymm26,xmm5
    1213:	vextracti32x4 xmm8,ymm5,0x1
    121a:	vcvtdq2ps ymm27,ymm27
                        float s0l = p.SUB[rb[0]+xf+k], s0r = p.SUB[rb[0]+xf+k+3];
    1220:	vpmovsxwd ymm23,xmm6
                        vp0[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    1226:	vmulps ymm5,ymm2,ymm27
                        float s1l = p.SUB[rb[1]+xf+k], s1r = p.SUB[rb[1]+xf+k+3];
    122c:	vpmovsxwd ymm16,xmm16
                        float s0l = p.SUB[rb[0]+xf+k], s0r = p.SUB[rb[0]+xf+k+3];
    1232:	vcvtdq2ps ymm23,ymm23
    1238:	vextracti32x4 xmm4,ymm4,0x1
                        float s1l = p.SUB[rb[1]+xf+k], s1r = p.SUB[rb[1]+xf+k+3];
    123f:	vcvtdq2ps ymm26,ymm26
    1245:	vcvtdq2ps ymm16,ymm16
                        float s0l = p.SUB[rb[0]+xf+k], s0r = p.SUB[rb[0]+xf+k+3];
    124b:	vpmovzxbw ymm4,xmm4
                        float s1l = p.SUB[rb[1]+xf+k], s1r = p.SUB[rb[1]+xf+k+3];
    1250:	vpmovsxwd ymm8,xmm8
                        float s0l = p.SUB[rb[0]+xf+k], s0r = p.SUB[rb[0]+xf+k+3];
    1255:	vextracti32x4 xmm14,ymm6,0x1
    125c:	vpmovsxwd ymm22,xmm4
    1262:	vextracti32x4 xmm12,ymm4,0x1
                        float s1l = p.SUB[rb[1]+xf+k], s1r = p.SUB[rb[1]+xf+k+3];
    1269:	vcvtdq2ps ymm8,ymm8
                        float s0l = p.SUB[rb[0]+xf+k], s0r = p.SUB[rb[0]+xf+k+3];
    126e:	vpmovsxwd ymm14,xmm14
                        vp0[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    1273:	vmulps ymm4,ymm2,ymm8
                        float s0l = p.SUB[rb[0]+xf+k], s0r = p.SUB[rb[0]+xf+k+3];
    1278:	vcvtdq2ps ymm14,ymm14
    127d:	vpmovsxwd ymm12,xmm12
    1282:	vcvtdq2ps ymm22,ymm22
    1288:	vpmovzxbw ymm15,xmm13
    128d:	vcvtdq2ps ymm12,ymm12
    1292:	vpmovsxwd ymm24,xmm15
    1298:	vextracti32x4 xmm15,ymm15,0x1
    129f:	vextracti32x4 xmm13,ymm13,0x1
    12a6:	vfmadd132ps ymm23,ymm5,ymm1
    12ac:	vpmovsxwd ymm15,xmm15
    12b1:	vpmovzxbw ymm13,xmm13
    12b6:	vcvtdq2ps ymm24,ymm24
                        vp0[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    12bc:	vmulps ymm5,ymm2,ymm16
                        float s0l = p.SUB[rb[0]+xf+k], s0r = p.SUB[rb[0]+xf+k+3];
    12c2:	vcvtdq2ps ymm15,ymm15
    12c7:	vfmadd213ps ymm15,ymm0,YMMWORD PTR [rsi-0x60]
    12cd:	vfmadd213ps ymm24,ymm0,YMMWORD PTR [rsi-0x80]
    12d4:	vfmadd132ps ymm12,ymm4,ymm1
                        float s1l = p.SUB[rb[1]+xf+k], s1r = p.SUB[rb[1]+xf+k+3];
    12d9:	vmovdqu ymm4,YMMWORD PTR [r8+rdi*1]
    12df:	vfmadd132ps ymm14,ymm5,ymm1
                        vp0[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    12e4:	vmulps ymm5,ymm2,ymm26
    12ea:	vfmadd132ps ymm22,ymm5,ymm1
                        float s1l = p.SUB[rb[1]+xf+k], s1r = p.SUB[rb[1]+xf+k+3];
    12f0:	vpmovzxbw ymm5,xmm4
    12f5:	vextracti32x4 xmm4,ymm4,0x1
    12fc:	vpmovsxwd ymm31,xmm5
    1302:	vextracti32x4 xmm21,ymm5,0x1
                        float s2l = p.SUB[rb[2]+xf+k], s2r = p.SUB[rb[2]+xf+k+3];
    1309:	vmovdqu ymm5,YMMWORD PTR [r12+rdi*1]
                        float s1l = p.SUB[rb[1]+xf+k], s1r = p.SUB[rb[1]+xf+k+3];
    130f:	vpmovzxbw ymm4,xmm4
    1314:	vpmovsxwd ymm21,xmm21
    131a:	vpmovsxwd ymm28,xmm4
    1320:	vextracti32x4 xmm4,ymm4,0x1
    1327:	vcvtdq2ps ymm31,ymm31
                        float s2l = p.SUB[rb[2]+xf+k], s2r = p.SUB[rb[2]+xf+k+3];
    132d:	vpmovzxbw ymm6,xmm5
    1332:	vextracti32x4 xmm5,ymm5,0x1
                        float s1l = p.SUB[rb[1]+xf+k], s1r = p.SUB[rb[1]+xf+k+3];
    1339:	vcvtdq2ps ymm21,ymm21
    133f:	vpmovsxwd ymm4,xmm4
    1344:	vcvtdq2ps ymm28,ymm28
                        float s2l = p.SUB[rb[2]+xf+k], s2r = p.SUB[rb[2]+xf+k+3];
    134a:	vextracti32x4 xmm7,ymm6,0x1
    1351:	vpmovzxbw ymm5,xmm5
    1356:	vpmovsxwd ymm20,xmm6
                        float s1l = p.SUB[rb[1]+xf+k], s1r = p.SUB[rb[1]+xf+k+3];
    135c:	vcvtdq2ps ymm4,ymm4
                        float s2l = p.SUB[rb[2]+xf+k], s2r = p.SUB[rb[2]+xf+k+3];
    1360:	vpmovsxwd ymm7,xmm7
    1365:	vfmadd231ps ymm15,ymm3,ymm21
    136b:	vextracti32x4 xmm6,ymm5,0x1
    1372:	vcvtdq2ps ymm20,ymm20
    1378:	vcvtdq2ps ymm7,ymm7
                        vp1[xf+k] += p.A*s1l + p.B*s1r + p.C*s2l + p.D*s2r;
    137c:	vmulps ymm7,ymm7,ymm2
                        float s2l = p.SUB[rb[2]+xf+k], s2r = p.SUB[rb[2]+xf+k+3];
    1380:	vpmovsxwd ymm6,xmm6
    1385:	vpmovsxwd ymm19,xmm5
    138b:	vmovdqu ymm5,YMMWORD PTR [r10+rdi*1]
    1391:	vcvtdq2ps ymm6,ymm6
                        vp1[xf+k] += p.A*s1l + p.B*s1r + p.C*s2l + p.D*s2r;
    1395:	vmulps ymm6,ymm6,ymm2
    1399:	vfmadd231ps ymm24,ymm3,ymm31
                        float s2l = p.SUB[rb[2]+xf+k], s2r = p.SUB[rb[2]+xf+k+3];
    139f:	vcvtdq2ps ymm19,ymm19
    13a5:	add    rdi,0x20
                        vp1[xf+k] += p.A*s1l + p.B*s1r + p.C*s2l + p.D*s2r;
    13a9:	vmulps ymm20,ymm20,ymm2
                        float s2l = p.SUB[rb[2]+xf+k], s2r = p.SUB[rb[2]+xf+k+3];
    13af:	vpmovzxbw ymm18,xmm5
    13b5:	vextracti32x4 xmm5,ymm5,0x1
                        vp1[xf+k] += p.A*s1l + p.B*s1r + p.C*s2l + p.D*s2r;
    13bc:	vmulps ymm19,ymm19,ymm2
                        float s2l = p.SUB[rb[2]+xf+k], s2r = p.SUB[rb[2]+xf+k+3];
    13c2:	vpmovzxbw ymm5,xmm5
                        vp0[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    13c7:	vaddps ymm14,ymm14,ymm15
    13cc:	vfmadd231ps ymm7,ymm1,ymm21
                        float s0l = p.SUB[rb[0]+xf+k], s0r = p.SUB[rb[0]+xf+k+3];
    13d2:	vpmovsxwd ymm21,xmm13
    13d8:	vextracti32x4 xmm13,ymm13,0x1
    13df:	vpmovsxwd ymm13,xmm13
    13e4:	vcvtdq2ps ymm21,ymm21
    13ea:	vfmadd213ps ymm21,ymm0,YMMWORD PTR [rsi-0x40]
                        vp0[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    13f1:	vaddps ymm23,ymm23,ymm24
                        float s0l = p.SUB[rb[0]+xf+k], s0r = p.SUB[rb[0]+xf+k+3];
    13f7:	vcvtdq2ps ymm13,ymm13
                        vp0[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    13fc:	vfmadd213ps ymm13,ymm0,YMMWORD PTR [rsi-0x20]
    1402:	vfmadd231ps ymm6,ymm1,ymm4
    1407:	vmovups YMMWORD PTR [rsi-0x60],ymm14
    140c:	vfmadd231ps ymm20,ymm1,ymm31
    1412:	vfmadd231ps ymm19,ymm1,ymm28
    1418:	vmovups YMMWORD PTR [rsi-0x80],ymm23
    141f:	vfmadd231ps ymm21,ymm3,ymm28
    1425:	vfmadd132ps ymm4,ymm13,ymm3
    142a:	vaddps ymm22,ymm22,ymm21
    1430:	vaddps ymm4,ymm4,ymm12
    1435:	vmovups YMMWORD PTR [rsi-0x40],ymm22
    143c:	vmovups YMMWORD PTR [rsi-0x20],ymm4
                        float s2l = p.SUB[rb[2]+xf+k], s2r = p.SUB[rb[2]+xf+k+3];
    1441:	vpmovsxwd ymm4,xmm18
    1447:	vfmadd213ps ymm27,ymm0,YMMWORD PTR [rcx-0x80]
    144e:	vfmadd213ps ymm16,ymm0,YMMWORD PTR [rcx-0x60]
    1455:	vcvtdq2ps ymm4,ymm4
    1459:	vfmadd213ps ymm26,ymm0,YMMWORD PTR [rcx-0x40]
                        vp1[xf+k] += p.A*s1l + p.B*s1r + p.C*s2l + p.D*s2r;
    1460:	vfmadd213ps ymm8,ymm0,YMMWORD PTR [rcx-0x20]
    1466:	vfmadd231ps ymm27,ymm3,ymm4
                        float s2l = p.SUB[rb[2]+xf+k], s2r = p.SUB[rb[2]+xf+k+3];
    146c:	vextracti32x4 xmm4,ymm18,0x1
    1473:	vpmovsxwd ymm4,xmm4
    1478:	vcvtdq2ps ymm4,ymm4
    147c:	vfmadd231ps ymm16,ymm3,ymm4
    1482:	vpmovsxwd ymm4,xmm5
    1487:	vcvtdq2ps ymm4,ymm4
    148b:	vfmadd231ps ymm26,ymm3,ymm4
    1491:	vextracti32x4 xmm4,ymm5,0x1
    1498:	vpmovsxwd ymm4,xmm4
    149d:	vcvtdq2ps ymm4,ymm4
                        vp1[xf+k] += p.A*s1l + p.B*s1r + p.C*s2l + p.D*s2r;
    14a1:	vfmadd132ps ymm4,ymm8,ymm3
    14a6:	vaddps ymm20,ymm20,ymm27
    14ac:	vaddps ymm7,ymm7,ymm16
    14b2:	vaddps ymm19,ymm19,ymm26
    14b8:	vmovups YMMWORD PTR [rcx-0x80],ymm20
    14bf:	vaddps ymm4,ymm4,ymm6
    14c3:	vmovups YMMWORD PTR [rcx-0x60],ymm7
    14c8:	vmovups YMMWORD PTR [rcx-0x40],ymm19
    14cf:	vmovups YMMWORD PTR [rcx-0x20],ymm4
                    for (int k = 0; k < x_floats - xf; ++k) {
    14d4:	cmp    rbx,rdi
    14d7:	jne    11d0 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x11d0>
    14dd:	mov    r9d,DWORD PTR [rsp+0x1b0]
    14e5:	vmovss xmm4,DWORD PTR [rsp+0x180]
    14ee:	vmovss xmm5,DWORD PTR [rsp+0x170]
    14f7:	vmovss xmm6,DWORD PTR [rsp+0x160]
    1500:	shl    r9d,0x5
    1504:	vmovss xmm7,DWORD PTR [rsp+0x150]
    150d:	cmp    r9d,DWORD PTR [rsp+0x1e0]
    1515:	je     229e <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x229e>
    151b:	mov    r8d,r9d
    151e:	mov    r10d,DWORD PTR [rsp+0x1e0]
    1526:	sub    r10d,r9d
    1529:	lea    ecx,[r10-0x1]
    152d:	cmp    ecx,0xe
    1530:	jbe    36dd <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x36dd>
    1536:	mov    rdi,QWORD PTR [rsp+0x1e8]
    153e:	mov    ecx,r9d
    1541:	mov    r14,QWORD PTR [rsp+0xd8]
    1549:	vmovaps xmm16,xmm17
    154f:	lea    rbx,[rcx+r13*1]
    1553:	lea    r11,[rcx+rax*1]
    1557:	lea    rsi,[rcx+rdi*1]
    155b:	mov    rdi,QWORD PTR [rsp+0x1c0]
    1563:	add    rdi,rcx
    1566:	add    rcx,r15
    1569:	lea    rcx,[r14+rcx*4]
                        float s0l = p.SUB[rb[0]+xf+k], s0r = p.SUB[rb[0]+xf+k+3];
    156d:	lea    rdi,[r14+rdi*4]
    1571:	mov    r14,QWORD PTR [rsp+0x1d0]
                        float s1l = p.SUB[rb[1]+xf+k], s1r = p.SUB[rb[1]+xf+k+3];
    1579:	vmovdqu xmm12,XMMWORD PTR [r14+rbx*1]
                        float s0l = p.SUB[rb[0]+xf+k], s0r = p.SUB[rb[0]+xf+k+3];
    157f:	vmovdqu xmm8,XMMWORD PTR [r14+rsi*1]
                        float s1l = p.SUB[rb[1]+xf+k], s1r = p.SUB[rb[1]+xf+k+3];
    1585:	vpmovzxbw xmm15,xmm12
    158a:	vpsrldq xmm12,xmm12,0x8
                        float s0l = p.SUB[rb[0]+xf+k], s0r = p.SUB[rb[0]+xf+k+3];
    1590:	vpmovzxbw xmm18,xmm8
                        float s1l = p.SUB[rb[1]+xf+k], s1r = p.SUB[rb[1]+xf+k+3];
    1596:	vpmovzxbw xmm12,xmm12
                        float s0l = p.SUB[rb[0]+xf+k], s0r = p.SUB[rb[0]+xf+k+3];
    159b:	vpsrldq xmm8,xmm8,0x8
                        float s1l = p.SUB[rb[1]+xf+k], s1r = p.SUB[rb[1]+xf+k+3];
    15a1:	vpmovsxwd xmm26,xmm15
    15a7:	vpsrldq xmm19,xmm15,0x8
    15ae:	vpmovsxwd xmm24,xmm12
    15b4:	vcvtdq2ps xmm26,xmm26
                        float s0l = p.SUB[rb[0]+xf+k], s0r = p.SUB[rb[0]+xf+k+3];
    15ba:	vpmovzxbw xmm14,xmm8
    15bf:	vmovdqu xmm8,XMMWORD PTR [r14+rsi*1+0x3]
                        float s1l = p.SUB[rb[1]+xf+k], s1r = p.SUB[rb[1]+xf+k+3];
    15c6:	vpsrldq xmm15,xmm12,0x8
    15cc:	vpmovsxwd xmm19,xmm19
    15d2:	vcvtdq2ps xmm24,xmm24
                        vp0[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    15d8:	vmulps xmm12,xmm26,xmm25
                        float s0l = p.SUB[rb[0]+xf+k], s0r = p.SUB[rb[0]+xf+k+3];
    15de:	vpmovzxbw xmm13,xmm8
                        float s1l = p.SUB[rb[1]+xf+k], s1r = p.SUB[rb[1]+xf+k+3];
    15e3:	vcvtdq2ps xmm19,xmm19
    15e9:	vpmovsxwd xmm15,xmm15
                        float s0l = p.SUB[rb[0]+xf+k], s0r = p.SUB[rb[0]+xf+k+3];
    15ee:	vpmovsxwd xmm23,xmm13
    15f4:	vpsrldq xmm8,xmm8,0x8
                        float s1l = p.SUB[rb[1]+xf+k], s1r = p.SUB[rb[1]+xf+k+3];
    15fa:	vcvtdq2ps xmm15,xmm15
                        float s0l = p.SUB[rb[0]+xf+k], s0r = p.SUB[rb[0]+xf+k+3];
    15ff:	vcvtdq2ps xmm23,xmm23
    1605:	vpmovzxbw xmm8,xmm8
                        float s1l = p.SUB[rb[1]+xf+k], s1r = p.SUB[rb[1]+xf+k+3];
    160a:	vfmadd132ps xmm23,xmm12,xmm17
                        float s0l = p.SUB[rb[0]+xf+k], s0r = p.SUB[rb[0]+xf+k+3];
    1610:	vpsrldq xmm12,xmm13,0x8
                        vp0[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    1616:	vmulps xmm13,xmm19,xmm25
                        float s0l = p.SUB[rb[0]+xf+k], s0r = p.SUB[rb[0]+xf+k+3];
    161c:	vpmovsxwd xmm12,xmm12
    1621:	vcvtdq2ps xmm12,xmm12
    1626:	vfmadd132ps xmm12,xmm13,xmm17
                        vp0[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    162c:	vmulps xmm13,xmm24,xmm25
    1632:	vmovaps XMMWORD PTR [rsp+0x180],xmm12
                        float s0l = p.SUB[rb[0]+xf+k], s0r = p.SUB[rb[0]+xf+k+3];
    163b:	vpmovsxwd xmm12,xmm8
    1640:	vcvtdq2ps xmm12,xmm12
    1645:	vfmadd132ps xmm12,xmm13,xmm17
    164b:	vpsrldq xmm13,xmm8,0x8
                        vp0[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    1651:	vmulps xmm8,xmm15,xmm25
                        float s0l = p.SUB[rb[0]+xf+k], s0r = p.SUB[rb[0]+xf+k+3];
    1657:	vpmovsxwd xmm13,xmm13
    165c:	vcvtdq2ps xmm13,xmm13
    1661:	vmovaps XMMWORD PTR [rsp+0x1b0],xmm12
                        float s2l = p.SUB[rb[2]+xf+k], s2r = p.SUB[rb[2]+xf+k+3];
    166a:	vmovdqu xmm12,XMMWORD PTR [r14+r11*1]
    1670:	vfmadd132ps xmm13,xmm8,xmm17
                        float s1l = p.SUB[rb[1]+xf+k], s1r = p.SUB[rb[1]+xf+k+3];
    1676:	vmovdqu xmm8,XMMWORD PTR [r14+rbx*1+0x3]
                        float s2l = p.SUB[rb[2]+xf+k], s2r = p.SUB[rb[2]+xf+k+3];
    167d:	vpmovzxbw xmm21,xmm12
    1683:	vpsrldq xmm12,xmm12,0x8
    1689:	vpmovsxwd xmm31,xmm21
                        float s1l = p.SUB[rb[1]+xf+k], s1r = p.SUB[rb[1]+xf+k+3];
    168f:	vpmovzxbw xmm22,xmm8
                        float s2l = p.SUB[rb[2]+xf+k], s2r = p.SUB[rb[2]+xf+k+3];
    1695:	vpmovzxbw xmm12,xmm12
    169a:	vcvtdq2ps xmm31,xmm31
                        vp1[xf+k] += p.A*s1l + p.B*s1r + p.C*s2l + p.D*s2r;
    16a0:	vmulps xmm31,xmm31,xmm25
                        float s2l = p.SUB[rb[2]+xf+k], s2r = p.SUB[rb[2]+xf+k+3];
    16a6:	vpsrldq xmm21,xmm21,0x8
                        float s1l = p.SUB[rb[1]+xf+k], s1r = p.SUB[rb[1]+xf+k+3];
    16ad:	vpmovsxwd xmm28,xmm22
    16b3:	vcvtdq2ps xmm28,xmm28
    16b9:	vpsrldq xmm22,xmm22,0x8
    16c0:	vpsrldq xmm8,xmm8,0x8
                        float s2l = p.SUB[rb[2]+xf+k], s2r = p.SUB[rb[2]+xf+k+3];
    16c6:	vpmovsxwd xmm21,xmm21
    16cc:	vcvtdq2ps xmm21,xmm21
                        vp1[xf+k] += p.A*s1l + p.B*s1r + p.C*s2l + p.D*s2r;
    16d2:	vmulps xmm21,xmm21,xmm25
                        float s1l = p.SUB[rb[1]+xf+k], s1r = p.SUB[rb[1]+xf+k+3];
    16d8:	vpmovsxwd xmm22,xmm22
    16de:	vpmovzxbw xmm8,xmm8
    16e3:	vcvtdq2ps xmm22,xmm22
    16e9:	vpmovsxwd xmm27,xmm8
    16ef:	vpsrldq xmm8,xmm8,0x8
    16f5:	vpmovsxwd xmm8,xmm8
    16fa:	vcvtdq2ps xmm27,xmm27
    1700:	vfmadd231ps xmm31,xmm17,xmm28
    1706:	vcvtdq2ps xmm8,xmm8
                        float s2l = p.SUB[rb[2]+xf+k], s2r = p.SUB[rb[2]+xf+k+3];
    170b:	vfmadd231ps xmm21,xmm17,xmm22
    1711:	vmovaps XMMWORD PTR [rsp+0x140],xmm31
                        float s0l = p.SUB[rb[0]+xf+k], s0r = p.SUB[rb[0]+xf+k+3];
    1719:	vpmovsxwd xmm31,xmm18
    171f:	vpsrldq xmm18,xmm18,0x8
    1726:	vpmovsxwd xmm18,xmm18
    172c:	vcvtdq2ps xmm31,xmm31
    1732:	vfmadd213ps xmm31,xmm9,XMMWORD PTR [rdi]
    1738:	vcvtdq2ps xmm18,xmm18
    173e:	vfmadd213ps xmm18,xmm9,XMMWORD PTR [rdi+0x10]
    1745:	vmovaps XMMWORD PTR [rsp+0x150],xmm21
                        float s2l = p.SUB[rb[2]+xf+k], s2r = p.SUB[rb[2]+xf+k+3];
    174d:	vpmovsxwd xmm21,xmm12
    1753:	vpsrldq xmm12,xmm12,0x8
    1759:	vcvtdq2ps xmm21,xmm21
                        vp1[xf+k] += p.A*s1l + p.B*s1r + p.C*s2l + p.D*s2r;
    175f:	vmulps xmm21,xmm21,xmm25
                        float s2l = p.SUB[rb[2]+xf+k], s2r = p.SUB[rb[2]+xf+k+3];
    1765:	vpmovsxwd xmm12,xmm12
    176a:	vcvtdq2ps xmm12,xmm12
                        vp1[xf+k] += p.A*s1l + p.B*s1r + p.C*s2l + p.D*s2r;
    176f:	vmulps xmm12,xmm12,xmm25
    1775:	vfmadd231ps xmm31,xmm28,xmm11
    177b:	vfmadd231ps xmm18,xmm22,xmm11
                        float s0l = p.SUB[rb[0]+xf+k], s0r = p.SUB[rb[0]+xf+k+3];
    1781:	vpmovsxwd xmm22,xmm14
    1787:	vpsrldq xmm14,xmm14,0x8
    178d:	vcvtdq2ps xmm22,xmm22
    1793:	vfmadd213ps xmm22,xmm9,XMMWORD PTR [rdi+0x20]
    179a:	vpmovsxwd xmm14,xmm14
    179f:	vfmadd231ps xmm21,xmm17,xmm27
    17a5:	vcvtdq2ps xmm14,xmm14
                        vp0[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    17aa:	vfmadd213ps xmm14,xmm9,XMMWORD PTR [rdi+0x30]
    17b0:	vfmadd132ps xmm16,xmm12,xmm8
                        float s2l = p.SUB[rb[2]+xf+k], s2r = p.SUB[rb[2]+xf+k+3];
    17b6:	vmovdqu xmm12,XMMWORD PTR [r14+r11*1+0x3]
                        vp0[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    17bd:	vaddps xmm23,xmm23,xmm31
                        float s2l = p.SUB[rb[2]+xf+k], s2r = p.SUB[rb[2]+xf+k+3];
    17c3:	vpmovzxbw xmm20,xmm12
    17c9:	vpsrldq xmm12,xmm12,0x8
    17cf:	vfmadd231ps xmm22,xmm27,xmm11
    17d5:	vpmovzxbw xmm12,xmm12
                        vp0[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    17da:	vmovups XMMWORD PTR [rdi],xmm23
    17e0:	vfmadd132ps xmm8,xmm14,xmm11
    17e5:	vmovaps XMMWORD PTR [rsp+0x170],xmm16
                        float s2l = p.SUB[rb[2]+xf+k], s2r = p.SUB[rb[2]+xf+k+3];
    17ed:	vpsrldq xmm14,xmm20,0x8
    17f4:	vmovaps xmm16,xmm9
    17fa:	vpmovsxwd xmm14,xmm14
    17ff:	vmovaps XMMWORD PTR [rsp+0x160],xmm21
    1807:	vcvtdq2ps xmm14,xmm14
                        vp0[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    180c:	vaddps xmm8,xmm8,xmm13
    1811:	vaddps xmm13,xmm18,XMMWORD PTR [rsp+0x180]
                        float s2l = p.SUB[rb[2]+xf+k], s2r = p.SUB[rb[2]+xf+k+3];
    1819:	vpmovsxwd xmm18,xmm12
    181f:	vcvtdq2ps xmm18,xmm18
                        vp0[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    1825:	vmovups XMMWORD PTR [rdi+0x10],xmm13
    182a:	vaddps xmm13,xmm22,XMMWORD PTR [rsp+0x1b0]
    1832:	vmovups XMMWORD PTR [rdi+0x30],xmm8
                        float s2l = p.SUB[rb[2]+xf+k], s2r = p.SUB[rb[2]+xf+k+3];
    1837:	vpsrldq xmm8,xmm12,0x8
    183d:	vpmovsxwd xmm8,xmm8
                        vp0[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    1842:	vmovups XMMWORD PTR [rdi+0x20],xmm13
                        float s2l = p.SUB[rb[2]+xf+k], s2r = p.SUB[rb[2]+xf+k+3];
    1847:	vpmovsxwd xmm13,xmm20
    184d:	vcvtdq2ps xmm8,xmm8
    1852:	vfmadd213ps xmm26,xmm9,XMMWORD PTR [rcx]
    1858:	vfmadd213ps xmm19,xmm9,XMMWORD PTR [rcx+0x10]
    185f:	vcvtdq2ps xmm13,xmm13
                        vp1[xf+k] += p.A*s1l + p.B*s1r + p.C*s2l + p.D*s2r;
    1864:	vfmadd213ps xmm16,xmm15,XMMWORD PTR [rcx+0x30]
    186b:	vfmadd213ps xmm24,xmm9,XMMWORD PTR [rcx+0x20]
    1872:	vfmadd132ps xmm13,xmm26,xmm11
    1878:	vfmadd132ps xmm14,xmm19,xmm11
    187e:	vfmadd132ps xmm8,xmm16,xmm11
    1884:	vfmadd132ps xmm18,xmm24,xmm11
    188a:	vaddps xmm12,xmm13,XMMWORD PTR [rsp+0x140]
    1893:	vaddps xmm8,xmm8,XMMWORD PTR [rsp+0x170]
    189c:	vmovups XMMWORD PTR [rcx],xmm12
    18a0:	vaddps xmm12,xmm14,XMMWORD PTR [rsp+0x150]
    18a9:	vmovups XMMWORD PTR [rcx+0x30],xmm8
    18ae:	vmovups XMMWORD PTR [rcx+0x10],xmm12
    18b3:	vaddps xmm12,xmm18,XMMWORD PTR [rsp+0x160]
    18bb:	vmovups XMMWORD PTR [rcx+0x20],xmm12
    18c0:	mov    ecx,r10d
    18c3:	and    ecx,0xfffffff0
    18c6:	test   r10b,0xf
    18ca:	je     229e <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x229e>
    18d0:	add    r8d,ecx
    18d3:	sub    r10d,ecx
    18d6:	lea    esi,[r10-0x1]
    18da:	cmp    esi,0x6
    18dd:	jbe    1d44 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x1d44>
    18e3:	add    ecx,r9d
    18e6:	mov    rbx,QWORD PTR [rsp+0x1e8]
                        float s0l = p.SUB[rb[0]+xf+k], s0r = p.SUB[rb[0]+xf+k+3];
    18ee:	mov    r14,QWORD PTR [rsp+0x1d0]
    18f6:	vmovaps xmm16,xmm17
    18fc:	mov    ecx,ecx
    18fe:	mov    rdi,QWORD PTR [rsp+0x1c0]
    1906:	vmovaps xmm18,xmm9
    190c:	lea    rsi,[rcx+rbx*1]
    1910:	lea    r11,[rcx+r13*1]
    1914:	mov    rbx,QWORD PTR [rsp+0xd8]
    191c:	vmovq  xmm8,QWORD PTR [r14+rsi*1]
                        float s1l = p.SUB[rb[1]+xf+k], s1r = p.SUB[rb[1]+xf+k+3];
    1922:	vmovq  xmm12,QWORD PTR [r14+r11*1]
    1928:	add    rdi,rcx
    192b:	lea    r9,[rcx+rax*1]
    192f:	add    rcx,r15
    1932:	lea    rdi,[rbx+rdi*4]
                        float s0l = p.SUB[rb[0]+xf+k], s0r = p.SUB[rb[0]+xf+k+3];
    1936:	vpmovzxbw xmm15,xmm8
    193b:	vpsrlq xmm8,xmm8,0x20
                        float s1l = p.SUB[rb[1]+xf+k], s1r = p.SUB[rb[1]+xf+k+3];
    1941:	vpmovzxbw xmm14,xmm12
                        float s0l = p.SUB[rb[0]+xf+k], s0r = p.SUB[rb[0]+xf+k+3];
    1946:	vmovq  r12,xmm15
    194b:	vpmovzxbw xmm15,xmm8
    1950:	lea    rcx,[rbx+rcx*4]
    1954:	vmovq  xmm8,QWORD PTR [r14+rsi*1+0x3]
    195b:	vmovq  rbx,xmm15
                        float s1l = p.SUB[rb[1]+xf+k], s1r = p.SUB[rb[1]+xf+k+3];
    1960:	vpsrlq xmm12,xmm12,0x20
    1966:	vpmovzxwd xmm15,xmm14
    196b:	vpsrlq xmm14,xmm14,0x20
    1971:	vmovq  xmm15,xmm15
    1976:	vpmovzxbw xmm12,xmm12
    197b:	vpmovzxwd xmm14,xmm14
    1980:	vcvtdq2ps xmm21,xmm15
                        float s0l = p.SUB[rb[0]+xf+k], s0r = p.SUB[rb[0]+xf+k+3];
    1986:	vpmovzxbw xmm13,xmm8
                        vp0[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    198b:	vmulps xmm20,xmm21,xmm25
                        float s0l = p.SUB[rb[0]+xf+k], s0r = p.SUB[rb[0]+xf+k+3];
    1991:	vpsrlq xmm8,xmm8,0x20
                        float s1l = p.SUB[rb[1]+xf+k], s1r = p.SUB[rb[1]+xf+k+3];
    1997:	vmovq  xmm14,xmm14
    199c:	vcvtdq2ps xmm15,xmm14
    19a1:	vpmovzxwd xmm14,xmm12
    19a6:	vpsrlq xmm12,xmm12,0x20
                        float s0l = p.SUB[rb[0]+xf+k], s0r = p.SUB[rb[0]+xf+k+3];
    19ac:	vpmovzxbw xmm8,xmm8
                        float s1l = p.SUB[rb[1]+xf+k], s1r = p.SUB[rb[1]+xf+k+3];
    19b1:	vmovq  xmm14,xmm14
    19b6:	vpmovzxwd xmm12,xmm12
    19bb:	vcvtdq2ps xmm19,xmm14
                        float s0l = p.SUB[rb[0]+xf+k], s0r = p.SUB[rb[0]+xf+k+3];
    19c1:	vpmovzxwd xmm14,xmm13
    19c6:	vpsrlq xmm13,xmm13,0x20
                        float s1l = p.SUB[rb[1]+xf+k], s1r = p.SUB[rb[1]+xf+k+3];
    19cc:	vmovq  xmm12,xmm12
                        float s0l = p.SUB[rb[0]+xf+k], s0r = p.SUB[rb[0]+xf+k+3];
    19d1:	vmovq  xmm14,xmm14
    19d6:	vpmovzxwd xmm13,xmm13
                        float s1l = p.SUB[rb[1]+xf+k], s1r = p.SUB[rb[1]+xf+k+3];
    19db:	vcvtdq2ps xmm12,xmm12
                        float s0l = p.SUB[rb[0]+xf+k], s0r = p.SUB[rb[0]+xf+k+3];
    19e0:	vcvtdq2ps xmm14,xmm14
    19e5:	vfmadd132ps xmm14,xmm20,xmm17
    19eb:	vmovq  xmm13,xmm13
    19f0:	vcvtdq2ps xmm13,xmm13
    19f5:	vmovaps xmm27,xmm14
                        vp0[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    19fb:	vmulps xmm14,xmm15,xmm25
    1a01:	vfmadd132ps xmm13,xmm14,xmm17
    1a07:	vmulps xmm14,xmm19,xmm25
    1a0d:	vmovaps xmm28,xmm13
                        float s0l = p.SUB[rb[0]+xf+k], s0r = p.SUB[rb[0]+xf+k+3];
    1a13:	vpmovzxwd xmm13,xmm8
    1a18:	vmovq  xmm13,xmm13
    1a1d:	vpsrlq xmm8,xmm8,0x20
    1a23:	vcvtdq2ps xmm13,xmm13
    1a28:	vfmadd132ps xmm13,xmm14,xmm17
    1a2e:	vpmovzxwd xmm8,xmm8
    1a33:	vmovq  xmm8,xmm8
    1a38:	vcvtdq2ps xmm8,xmm8
    1a3d:	vmovaps xmm31,xmm13
                        vp0[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    1a43:	vmulps xmm13,xmm12,xmm25
    1a49:	vfmadd132ps xmm8,xmm13,xmm17
    1a4f:	vmovaps xmm26,xmm8
                        float s1l = p.SUB[rb[1]+xf+k], s1r = p.SUB[rb[1]+xf+k+3];
    1a55:	vmovq  xmm8,QWORD PTR [r14+r11*1+0x3]
                        float s2l = p.SUB[rb[2]+xf+k], s2r = p.SUB[rb[2]+xf+k+3];
    1a5c:	mov    r11,r14
                        float s1l = p.SUB[rb[1]+xf+k], s1r = p.SUB[rb[1]+xf+k+3];
    1a5f:	vpmovzxbw xmm13,xmm8
    1a64:	vpsrlq xmm8,xmm8,0x20
    1a6a:	vpmovzxwd xmm14,xmm13
    1a6f:	vpsrlq xmm13,xmm13,0x20
    1a75:	vpmovzxbw xmm8,xmm8
    1a7a:	vpmovzxwd xmm13,xmm13
    1a7f:	vmovq  xmm14,xmm14
    1a84:	vmovq  xmm13,xmm13
    1a89:	vcvtdq2ps xmm14,xmm14
    1a8e:	vcvtdq2ps xmm23,xmm13
    1a94:	vpmovzxwd xmm13,xmm8
    1a99:	vpsrlq xmm8,xmm8,0x20
    1a9f:	vpmovzxwd xmm8,xmm8
    1aa4:	vmovq  xmm13,xmm13
    1aa9:	vmovq  xmm8,xmm8
    1aae:	vcvtdq2ps xmm24,xmm13
    1ab4:	vcvtdq2ps xmm22,xmm8
                        float s2l = p.SUB[rb[2]+xf+k], s2r = p.SUB[rb[2]+xf+k+3];
    1aba:	vmovq  xmm8,QWORD PTR [r14+r9*1]
    1ac0:	vpmovzxbw xmm13,xmm8
    1ac5:	vpsrlq xmm8,xmm8,0x20
    1acb:	vpmovzxbw xmm8,xmm8
    1ad0:	vmovq  r14,xmm8
    1ad5:	vpmovzxwd xmm8,xmm13
    1ada:	vpsrlq xmm13,xmm13,0x20
    1ae0:	vmovq  xmm20,xmm8
    1ae6:	vmovq  xmm8,r14
    1aeb:	vpmovzxwd xmm13,xmm13
    1af0:	vcvtdq2ps xmm20,xmm20
                        vp1[xf+k] += p.A*s1l + p.B*s1r + p.C*s2l + p.D*s2r;
    1af6:	vmulps xmm20,xmm20,xmm25
                        float s2l = p.SUB[rb[2]+xf+k], s2r = p.SUB[rb[2]+xf+k+3];
    1afc:	vmovq  xmm13,xmm13
    1b01:	vcvtdq2ps xmm13,xmm13
                        vp1[xf+k] += p.A*s1l + p.B*s1r + p.C*s2l + p.D*s2r;
    1b06:	vmulps xmm13,xmm13,xmm25
    1b0c:	vfmadd231ps xmm20,xmm17,xmm14
    1b12:	vfmadd231ps xmm13,xmm17,xmm23
    1b18:	vmovaps XMMWORD PTR [rsp+0x1c0],xmm20
    1b20:	vmovaps XMMWORD PTR [rsp+0x1b0],xmm13
                        float s2l = p.SUB[rb[2]+xf+k], s2r = p.SUB[rb[2]+xf+k+3];
    1b29:	vpmovzxwd xmm13,xmm8
    1b2e:	vpsrlq xmm8,xmm8,0x20
    1b34:	vmovq  xmm13,xmm13
    1b39:	vpmovzxwd xmm8,xmm8
    1b3e:	vcvtdq2ps xmm13,xmm13
                        vp1[xf+k] += p.A*s1l + p.B*s1r + p.C*s2l + p.D*s2r;
    1b43:	vmulps xmm13,xmm13,xmm25
                        float s2l = p.SUB[rb[2]+xf+k], s2r = p.SUB[rb[2]+xf+k+3];
    1b49:	vmovq  xmm8,xmm8
    1b4e:	vcvtdq2ps xmm8,xmm8
                        vp1[xf+k] += p.A*s1l + p.B*s1r + p.C*s2l + p.D*s2r;
    1b53:	vmulps xmm8,xmm8,xmm25
    1b59:	vfmadd231ps xmm13,xmm17,xmm24
    1b5f:	vfmadd132ps xmm16,xmm8,xmm22
                        float s2l = p.SUB[rb[2]+xf+k], s2r = p.SUB[rb[2]+xf+k+3];
    1b65:	vmovq  xmm8,QWORD PTR [r11+r9*1+0x3]
    1b6c:	vmovaps XMMWORD PTR [rsp+0x180],xmm13
    1b75:	vpmovzxbw xmm13,xmm8
    1b7a:	vpsrlq xmm8,xmm8,0x20
    1b80:	vpmovzxbw xmm8,xmm8
    1b85:	vmovq  rsi,xmm13
    1b8a:	vmovq  r11,xmm8
                        float s0l = p.SUB[rb[0]+xf+k], s0r = p.SUB[rb[0]+xf+k+3];
    1b8f:	vmovq  xmm8,r12
    1b94:	vpmovzxwd xmm8,xmm8
    1b99:	vmovq  xmm8,xmm8
    1b9e:	vcvtdq2ps xmm13,xmm8
                        vp0[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    1ba3:	vmovq  xmm8,QWORD PTR [rdi]
    1ba7:	vfmadd231ps xmm8,xmm13,xmm9
    1bac:	vfmadd132ps xmm14,xmm8,xmm11
                        float s0l = p.SUB[rb[0]+xf+k], s0r = p.SUB[rb[0]+xf+k+3];
    1bb1:	vmovq  xmm8,r12
    1bb6:	vpsrlq xmm8,xmm8,0x20
    1bbc:	vpmovzxwd xmm8,xmm8
    1bc1:	vmovq  xmm8,xmm8
    1bc6:	vcvtdq2ps xmm13,xmm8
                        vp0[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    1bcb:	vmovq  xmm8,QWORD PTR [rdi+0x8]
    1bd0:	vaddps xmm14,xmm27,xmm14
    1bd6:	vfmadd132ps xmm13,xmm8,xmm9
                        float s0l = p.SUB[rb[0]+xf+k], s0r = p.SUB[rb[0]+xf+k+3];
    1bdb:	vmovq  xmm8,rbx
    1be0:	vpmovzxwd xmm8,xmm8
    1be5:	vmovq  xmm8,xmm8
                        vp0[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    1bea:	vmovlps QWORD PTR [rdi],xmm14
                        float s2l = p.SUB[rb[2]+xf+k], s2r = p.SUB[rb[2]+xf+k+3];
    1bee:	vmovq  xmm14,rsi
    1bf3:	vfmadd231ps xmm13,xmm23,xmm11
                        float s0l = p.SUB[rb[0]+xf+k], s0r = p.SUB[rb[0]+xf+k+3];
    1bf9:	vcvtdq2ps xmm23,xmm8
                        vp0[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    1bff:	vmovq  xmm8,QWORD PTR [rdi+0x10]
    1c04:	vfmadd132ps xmm23,xmm8,xmm9
                        float s0l = p.SUB[rb[0]+xf+k], s0r = p.SUB[rb[0]+xf+k+3];
    1c0a:	vmovq  xmm8,rbx
    1c0f:	vpsrlq xmm8,xmm8,0x20
    1c15:	vpmovzxwd xmm8,xmm8
    1c1a:	vmovq  xmm8,xmm8
                        vp0[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    1c1f:	vaddps xmm13,xmm28,xmm13
    1c25:	vfmadd231ps xmm23,xmm24,xmm11
                        float s0l = p.SUB[rb[0]+xf+k], s0r = p.SUB[rb[0]+xf+k+3];
    1c2b:	vcvtdq2ps xmm24,xmm8
                        vp0[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    1c31:	vmovq  xmm8,QWORD PTR [rdi+0x18]
    1c36:	vmovlps QWORD PTR [rdi+0x8],xmm13
    1c3b:	vfmadd132ps xmm24,xmm8,xmm9
    1c41:	vmovaps xmm8,xmm22
    1c47:	vaddps xmm13,xmm31,xmm23
    1c4d:	vfmadd132ps xmm8,xmm24,xmm11
    1c53:	vmovlps QWORD PTR [rdi+0x10],xmm13
                        float s2l = p.SUB[rb[2]+xf+k], s2r = p.SUB[rb[2]+xf+k+3];
    1c58:	vpmovzxwd xmm13,xmm14
    1c5d:	vmovq  xmm13,xmm13
    1c62:	vcvtdq2ps xmm13,xmm13
                        vp0[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    1c67:	vaddps xmm8,xmm8,xmm26
    1c6d:	vmovlps QWORD PTR [rdi+0x18],xmm8
                        vp1[xf+k] += p.A*s1l + p.B*s1r + p.C*s2l + p.D*s2r;
    1c72:	vmovq  xmm8,QWORD PTR [rcx]
    1c76:	vfmadd132ps xmm21,xmm8,xmm9
                        float s2l = p.SUB[rb[2]+xf+k], s2r = p.SUB[rb[2]+xf+k+3];
    1c7c:	vpsrlq xmm8,xmm14,0x20
    1c82:	vpmovzxwd xmm8,xmm8
    1c87:	vmovq  xmm14,xmm8
                        vp1[xf+k] += p.A*s1l + p.B*s1r + p.C*s2l + p.D*s2r;
    1c8c:	vmovq  xmm8,QWORD PTR [rcx+0x8]
                        float s2l = p.SUB[rb[2]+xf+k], s2r = p.SUB[rb[2]+xf+k+3];
    1c91:	vcvtdq2ps xmm14,xmm14
    1c96:	vfmadd132ps xmm15,xmm8,xmm9
                        vp1[xf+k] += p.A*s1l + p.B*s1r + p.C*s2l + p.D*s2r;
    1c9b:	vmovq  xmm8,QWORD PTR [rcx+0x10]
    1ca0:	vfmadd132ps xmm13,xmm21,xmm11
    1ca6:	vfmadd132ps xmm19,xmm8,xmm9
                        float s2l = p.SUB[rb[2]+xf+k], s2r = p.SUB[rb[2]+xf+k+3];
    1cac:	vmovq  xmm8,r11
    1cb1:	vpsrlq xmm8,xmm8,0x20
    1cb7:	vpmovzxwd xmm8,xmm8
    1cbc:	vfmadd132ps xmm14,xmm15,xmm11
    1cc1:	vmovq  xmm15,r11
    1cc6:	vmovq  xmm8,xmm8
    1ccb:	vpmovzxwd xmm15,xmm15
                        vp1[xf+k] += p.A*s1l + p.B*s1r + p.C*s2l + p.D*s2r;
    1cd0:	vaddps xmm13,xmm13,XMMWORD PTR [rsp+0x1c0]
                        float s2l = p.SUB[rb[2]+xf+k], s2r = p.SUB[rb[2]+xf+k+3];
    1cd9:	vmovq  xmm15,xmm15
    1cde:	vcvtdq2ps xmm15,xmm15
    1ce3:	vfmadd132ps xmm15,xmm19,xmm11
    1ce9:	vcvtdq2ps xmm19,xmm8
                        vp1[xf+k] += p.A*s1l + p.B*s1r + p.C*s2l + p.D*s2r;
    1cef:	vmovq  xmm8,QWORD PTR [rcx+0x18]
    1cf4:	vmovlps QWORD PTR [rcx],xmm13
    1cf8:	vfmadd132ps xmm18,xmm8,xmm12
    1cfe:	vmovaps xmm8,xmm19
    1d04:	vaddps xmm14,xmm14,XMMWORD PTR [rsp+0x1b0]
    1d0d:	vaddps xmm12,xmm15,XMMWORD PTR [rsp+0x180]
    1d16:	vmovlps QWORD PTR [rcx+0x8],xmm14
    1d1b:	vfmadd132ps xmm8,xmm18,xmm11
    1d21:	vmovlps QWORD PTR [rcx+0x10],xmm12
    1d26:	vaddps xmm8,xmm8,xmm16
    1d2c:	vmovlps QWORD PTR [rcx+0x18],xmm8
                    for (int k = 0; k < x_floats - xf; ++k) {
    1d31:	mov    ecx,r10d
    1d34:	and    ecx,0xfffffff8
    1d37:	and    r10d,0x7
    1d3b:	je     229e <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x229e>
    1d41:	add    r8d,ecx
    1d44:	mov    edi,DWORD PTR [rsp+0x1e0]
    1d4b:	lea    r9d,[r8+0x1]
    1d4f:	lea    ebx,[rdi-0x2]
    1d52:	mov    DWORD PTR [rsp+0x180],ebx
    1d59:	cmp    r9d,ebx
    1d5c:	jge    2062 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x2062>
    1d62:	cmp    r8d,edi
    1d65:	jge    2062 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x2062>
    1d6b:	mov    rsi,QWORD PTR [rsp+0x1d8]
    1d73:	mov    rbx,QWORD PTR [rsp+0x1a0]
    1d7b:	movsxd rcx,r8d
    1d7e:	mov    QWORD PTR [rsp+0x118],rax
    1d86:	lea    r9,[rcx+r13*1]
    1d8a:	lea    r8,[rcx+rax*1]
    1d8e:	mov    r14,QWORD PTR [rsp+0x1e8]
    1d96:	mov    QWORD PTR [rsp+0x138],rdx
    1d9e:	shl    rsi,0x2
    1da2:	mov    QWORD PTR [rsp+0x130],r13
    1daa:	lea    rdi,[rbx+rsi*1]
    1dae:	mov    rbx,QWORD PTR [rsp+0x198]
    1db6:	lea    r10,[rcx+r14*1]
    1dba:	add    rbx,rsi
    1dbd:	mov    QWORD PTR [rsp+0x1b0],rbx
    1dc5:	mov    rbx,QWORD PTR [rsp+0x1d0]
    1dcd:	movzx  esi,BYTE PTR [rbx+r9*1]
    1dd2:	movzx  r15d,BYTE PTR [rbx+r10*1]
    1dd7:	lea    r11,[rbx+r13*1]
    1ddb:	add    r14,rbx
    1dde:	lea    r12,[rbx+rax*1]
    1de2:	mov    DWORD PTR [rsp+0x1c0],esi
    1de9:	movzx  esi,BYTE PTR [rbx+r8*1]
    1dee:	mov    DWORD PTR [rsp+0x1d8],esi
    1df5:	movzx  esi,BYTE PTR [rbx+r10*1+0x1]
    1dfb:	movzx  r10d,BYTE PTR [rbx+r10*1+0x2]
    1e01:	mov    DWORD PTR [rsp+0x160],esi
    1e08:	movzx  esi,BYTE PTR [rbx+r9*1+0x1]
    1e0e:	movzx  r9d,BYTE PTR [rbx+r9*1+0x2]
    1e14:	mov    DWORD PTR [rsp+0x150],esi
    1e1b:	movzx  esi,BYTE PTR [rbx+r8*1+0x1]
    1e21:	mov    DWORD PTR [rsp+0x170],r9d
    1e29:	mov    edx,DWORD PTR [rsp+0x160]
    1e30:	mov    DWORD PTR [rsp+0x140],esi
    1e37:	mov    rsi,QWORD PTR [rsp+0x1b0]
    1e3f:	mov    DWORD PTR [rsp+0x1b0],r15d
    1e47:	movzx  r9d,BYTE PTR [rbx+r8*1+0x2]
    1e4d:	mov    ebx,DWORD PTR [rsp+0x170]
    1e54:	mov    r8d,DWORD PTR [rsp+0x150]
    1e5c:	mov    r13d,DWORD PTR [rsp+0x140]
                        float s0l = p.SUB[rb[0]+xf+k], s0r = p.SUB[rb[0]+xf+k+3];
    1e64:	vcvtusi2ss xmm8,xmm10,DWORD PTR [rsp+0x1b0]
                        float s1l = p.SUB[rb[1]+xf+k], s1r = p.SUB[rb[1]+xf+k+3];
    1e6c:	movzx  eax,BYTE PTR [r11+rcx*1+0x3]
    1e72:	vmovaps xmm16,xmm6
    1e78:	mov    QWORD PTR [rsp+0x170],rcx
                        float s2l = p.SUB[rb[2]+xf+k], s2r = p.SUB[rb[2]+xf+k+3];
    1e80:	vcvtusi2ss xmm12,xmm10,DWORD PTR [rsp+0x1d8]
                        float s1l = p.SUB[rb[1]+xf+k], s1r = p.SUB[rb[1]+xf+k+3];
    1e88:	vcvtusi2ss xmm13,xmm10,DWORD PTR [rsp+0x1c0]
    1e90:	mov    DWORD PTR [rsp+0x1c0],eax
                        float s0l = p.SUB[rb[0]+xf+k], s0r = p.SUB[rb[0]+xf+k+3];
    1e97:	vmovaps xmm15,xmm8
                        float s1l = p.SUB[rb[1]+xf+k], s1r = p.SUB[rb[1]+xf+k+3];
    1e9c:	vcvtusi2ss xmm8,xmm10,eax
                        float s0l = p.SUB[rb[0]+xf+k], s0r = p.SUB[rb[0]+xf+k+3];
    1ea2:	movzx  eax,BYTE PTR [r14+rcx*1+0x3]
                        float s2l = p.SUB[rb[2]+xf+k], s2r = p.SUB[rb[2]+xf+k+3];
    1ea8:	vmovaps xmm14,xmm12
                        float s0l = p.SUB[rb[0]+xf+k], s0r = p.SUB[rb[0]+xf+k+3];
    1ead:	vcvtusi2ss xmm12,xmm10,eax
    1eb3:	vfmadd213ss xmm16,xmm13,DWORD PTR [rdi+rcx*4]
    1eba:	mov    DWORD PTR [rsp+0x1b0],eax
                        float s2l = p.SUB[rb[2]+xf+k], s2r = p.SUB[rb[2]+xf+k+3];
    1ec1:	movzx  eax,BYTE PTR [r12+rcx*1+0x3]
                        vp0[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    1ec7:	vmulss xmm18,xmm7,xmm8
                        float s2l = p.SUB[rb[2]+xf+k], s2r = p.SUB[rb[2]+xf+k+3];
    1ecd:	mov    DWORD PTR [rsp+0x1d8],eax
                        vp0[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    1ed4:	vfmadd132ss xmm12,xmm18,xmm5
    1eda:	vaddss xmm12,xmm12,xmm16
    1ee0:	vmovaps xmm16,xmm6
    1ee6:	vfmadd231ss xmm12,xmm4,xmm15
    1eeb:	vmovss DWORD PTR [rdi+rcx*4],xmm12
                        float s2l = p.SUB[rb[2]+xf+k], s2r = p.SUB[rb[2]+xf+k+3];
    1ef0:	vcvtusi2ss xmm12,xmm10,eax
    1ef6:	vfmadd213ss xmm13,xmm4,DWORD PTR [rsi+rcx*4]
                        vp1[xf+k] += p.A*s1l + p.B*s1r + p.C*s2l + p.D*s2r;
    1efc:	vmulss xmm12,xmm12,xmm7
    1f00:	vfmadd132ss xmm8,xmm12,xmm5
                        float s2l = p.SUB[rb[2]+xf+k], s2r = p.SUB[rb[2]+xf+k+3];
    1f05:	vcvtusi2ss xmm12,xmm10,r13d
    1f0b:	movzx  r13d,BYTE PTR [r12+rcx*1+0x4]
                        vp1[xf+k] += p.A*s1l + p.B*s1r + p.C*s2l + p.D*s2r;
    1f11:	vaddss xmm8,xmm8,xmm13
                        float s1l = p.SUB[rb[1]+xf+k], s1r = p.SUB[rb[1]+xf+k+3];
    1f16:	vcvtusi2ss xmm13,xmm10,r8d
    1f1c:	movzx  r8d,BYTE PTR [r11+rcx*1+0x4]
                        vp1[xf+k] += p.A*s1l + p.B*s1r + p.C*s2l + p.D*s2r;
    1f22:	vfmadd231ss xmm8,xmm6,xmm14
                        float s2l = p.SUB[rb[2]+xf+k], s2r = p.SUB[rb[2]+xf+k+3];
    1f27:	vmovaps xmm14,xmm12
                        vp1[xf+k] += p.A*s1l + p.B*s1r + p.C*s2l + p.D*s2r;
    1f2c:	vmovss DWORD PTR [rsi+rcx*4],xmm8
                        float s0l = p.SUB[rb[0]+xf+k], s0r = p.SUB[rb[0]+xf+k+3];
    1f31:	vcvtusi2ss xmm8,xmm10,edx
    1f37:	movzx  edx,BYTE PTR [r14+rcx*1+0x4]
    1f3d:	vfmadd213ss xmm16,xmm13,DWORD PTR [rdi+rcx*4+0x4]
    1f45:	vcvtusi2ss xmm12,xmm10,edx
    1f4b:	vmovaps xmm15,xmm8
                        float s1l = p.SUB[rb[1]+xf+k], s1r = p.SUB[rb[1]+xf+k+3];
    1f50:	vcvtusi2ss xmm8,xmm10,r8d
                        vp0[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    1f56:	vmulss xmm18,xmm7,xmm8
    1f5c:	vfmadd132ss xmm12,xmm18,xmm5
    1f62:	vaddss xmm12,xmm12,xmm16
    1f68:	vmovaps xmm16,xmm6
    1f6e:	vfmadd231ss xmm12,xmm4,xmm15
    1f73:	vmovss DWORD PTR [rdi+rcx*4+0x4],xmm12
                        float s2l = p.SUB[rb[2]+xf+k], s2r = p.SUB[rb[2]+xf+k+3];
    1f79:	vcvtusi2ss xmm12,xmm10,r13d
    1f7f:	vfmadd213ss xmm13,xmm4,DWORD PTR [rsi+rcx*4+0x4]
                        vp1[xf+k] += p.A*s1l + p.B*s1r + p.C*s2l + p.D*s2r;
    1f86:	vmulss xmm12,xmm12,xmm7
    1f8a:	vfmadd132ss xmm8,xmm12,xmm5
                        float s2l = p.SUB[rb[2]+xf+k], s2r = p.SUB[rb[2]+xf+k+3];
    1f8f:	vcvtusi2ss xmm12,xmm10,r9d
    1f95:	movzx  r9d,BYTE PTR [r12+rcx*1+0x5]
                        vp1[xf+k] += p.A*s1l + p.B*s1r + p.C*s2l + p.D*s2r;
    1f9b:	vaddss xmm8,xmm8,xmm13
                        float s1l = p.SUB[rb[1]+xf+k], s1r = p.SUB[rb[1]+xf+k+3];
    1fa0:	vcvtusi2ss xmm13,xmm10,ebx
    1fa6:	movzx  ebx,BYTE PTR [r11+rcx*1+0x5]
                        vp1[xf+k] += p.A*s1l + p.B*s1r + p.C*s2l + p.D*s2r;
    1fac:	vfmadd231ss xmm8,xmm6,xmm14
                        float s2l = p.SUB[rb[2]+xf+k], s2r = p.SUB[rb[2]+xf+k+3];
    1fb1:	vmovaps xmm14,xmm12
                        vp1[xf+k] += p.A*s1l + p.B*s1r + p.C*s2l + p.D*s2r;
    1fb6:	vmovss DWORD PTR [rsi+rcx*4+0x4],xmm8
                        float s0l = p.SUB[rb[0]+xf+k], s0r = p.SUB[rb[0]+xf+k+3];
    1fbc:	vcvtusi2ss xmm8,xmm10,r10d
    1fc2:	movzx  r10d,BYTE PTR [r14+rcx*1+0x5]
    1fc8:	vfmadd213ss xmm16,xmm13,DWORD PTR [rdi+rcx*4+0x8]
    1fd0:	vcvtusi2ss xmm12,xmm10,r10d
    1fd6:	vmovaps xmm15,xmm8
                        float s1l = p.SUB[rb[1]+xf+k], s1r = p.SUB[rb[1]+xf+k+3];
    1fdb:	vcvtusi2ss xmm8,xmm10,ebx
                        vp0[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    1fe1:	vmulss xmm18,xmm7,xmm8
    1fe7:	vfmadd132ss xmm12,xmm18,xmm5
    1fed:	vaddss xmm12,xmm12,xmm16
    1ff3:	vfmadd231ss xmm12,xmm4,xmm15
    1ff8:	vmovss DWORD PTR [rdi+rcx*4+0x8],xmm12
                        float s2l = p.SUB[rb[2]+xf+k], s2r = p.SUB[rb[2]+xf+k+3];
    1ffe:	vcvtusi2ss xmm12,xmm10,r9d
    2004:	vfmadd213ss xmm13,xmm4,DWORD PTR [rsi+rcx*4+0x8]
                        vp1[xf+k] += p.A*s1l + p.B*s1r + p.C*s2l + p.D*s2r;
    200b:	vmulss xmm12,xmm12,xmm7
    200f:	vfmadd132ss xmm8,xmm12,xmm5
    2014:	vaddss xmm8,xmm8,xmm13
    2019:	vfmadd231ss xmm8,xmm6,xmm14
    201e:	vmovss DWORD PTR [rsi+rcx*4+0x8],xmm8
                    for (int k = 0; k < x_floats - xf; ++k) {
    2024:	add    rcx,0x3
    2028:	lea    r15d,[rcx+0x1]
    202c:	cmp    r15d,DWORD PTR [rsp+0x180]
    2034:	jl     1e64 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x1e64>
    203a:	mov    rbx,QWORD PTR [rsp+0x170]
    2042:	mov    rdx,QWORD PTR [rsp+0x138]
    204a:	mov    r13,QWORD PTR [rsp+0x130]
    2052:	mov    rax,QWORD PTR [rsp+0x118]
    205a:	lea    r8d,[rbx+0x3]
    205e:	lea    r9d,[rbx+0x4]
                        float s1l = p.SUB[rb[1]+xf+k], s1r = p.SUB[rb[1]+xf+k+3];
    2062:	mov    rbx,QWORD PTR [rsp+0x1d0]
                        float s0l = p.SUB[rb[0]+xf+k], s0r = p.SUB[rb[0]+xf+k+3];
    206a:	mov    ecx,r8d
    206d:	mov    r11,QWORD PTR [rsp+0x1e8]
                        float s1l = p.SUB[rb[1]+xf+k], s1r = p.SUB[rb[1]+xf+k+3];
    2075:	lea    rsi,[r13+rcx*1+0x0]
                        vp0[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    207a:	mov    r12d,DWORD PTR [rsp+0x1a8]
    2082:	mov    r14,QWORD PTR [rsp+0x1a0]
                        float s1l = p.SUB[rb[1]+xf+k], s1r = p.SUB[rb[1]+xf+k+3];
    208a:	movzx  edi,BYTE PTR [rbx+rsi*1]
    208e:	movzx  esi,BYTE PTR [rbx+rsi*1+0x3]
                        float s0l = p.SUB[rb[0]+xf+k], s0r = p.SUB[rb[0]+xf+k+3];
    2093:	lea    r10,[r11+rcx*1]
                        float s2l = p.SUB[rb[2]+xf+k], s2r = p.SUB[rb[2]+xf+k+3];
    2097:	add    rcx,rax
                        vp1[xf+k] += p.A*s1l + p.B*s1r + p.C*s2l + p.D*s2r;
    209a:	mov    r15,QWORD PTR [rsp+0x198]
                        float s1l = p.SUB[rb[1]+xf+k], s1r = p.SUB[rb[1]+xf+k+3];
    20a2:	vcvtusi2ss xmm13,xmm10,esi
                        float s2l = p.SUB[rb[2]+xf+k], s2r = p.SUB[rb[2]+xf+k+3];
    20a8:	movzx  esi,BYTE PTR [rbx+rcx*1]
    20ac:	movzx  ecx,BYTE PTR [rbx+rcx*1+0x3]
                        float s1l = p.SUB[rb[1]+xf+k], s1r = p.SUB[rb[1]+xf+k+3];
    20b1:	vcvtusi2ss xmm14,xmm10,edi
                        float s0l = p.SUB[rb[0]+xf+k], s0r = p.SUB[rb[0]+xf+k+3];
    20b7:	movzx  edi,BYTE PTR [rbx+r10*1]
                        float s2l = p.SUB[rb[2]+xf+k], s2r = p.SUB[rb[2]+xf+k+3];
    20bc:	vcvtusi2ss xmm8,xmm10,esi
                        vp0[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    20c2:	vmulss xmm18,xmm6,xmm14
                        vp1[xf+k] += p.A*s1l + p.B*s1r + p.C*s2l + p.D*s2r;
    20c8:	vmulss xmm15,xmm6,xmm8
                        float s2l = p.SUB[rb[2]+xf+k], s2r = p.SUB[rb[2]+xf+k+3];
    20cd:	vcvtusi2ss xmm8,xmm10,ecx
                        vp0[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    20d3:	lea    ecx,[r12+r8*1]
    20d7:	shl    rcx,0x2
                        float s2l = p.SUB[rb[2]+xf+k], s2r = p.SUB[rb[2]+xf+k+3];
    20db:	vmovaps xmm12,xmm8
                        float s0l = p.SUB[rb[0]+xf+k], s0r = p.SUB[rb[0]+xf+k+3];
    20e0:	vcvtusi2ss xmm8,xmm10,edi
    20e6:	movzx  edi,BYTE PTR [rbx+r10*1+0x3]
    20ec:	vcvtusi2ss xmm16,xmm10,edi
    20f2:	vfmadd213ss xmm8,xmm4,DWORD PTR [r14+rcx*1]
    20f8:	vfmadd132ss xmm16,xmm18,xmm5
                        vp0[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    20fe:	vfmadd231ss xmm8,xmm7,xmm13
    2103:	vfmadd132ss xmm13,xmm15,xmm5
    2108:	vaddss xmm8,xmm8,xmm16
    210e:	vmovss DWORD PTR [r14+rcx*1],xmm8
                        vp1[xf+k] += p.A*s1l + p.B*s1r + p.C*s2l + p.D*s2r;
    2114:	vmovaps xmm8,xmm12
    2119:	vfmadd213ss xmm14,xmm4,DWORD PTR [r15+rcx*1]
    211f:	vfmadd132ss xmm8,xmm14,xmm7
    2124:	vaddss xmm8,xmm8,xmm13
    2129:	vmovss DWORD PTR [r15+rcx*1],xmm8
                    for (int k = 0; k < x_floats - xf; ++k) {
    212f:	cmp    r9d,DWORD PTR [rsp+0x1e0]
    2137:	jge    229e <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x229e>
                        float s0l = p.SUB[rb[0]+xf+k], s0r = p.SUB[rb[0]+xf+k+3];
    213d:	mov    ecx,r9d
                        float s1l = p.SUB[rb[1]+xf+k], s1r = p.SUB[rb[1]+xf+k+3];
    2140:	lea    rsi,[rcx+r13*1]
                        float s0l = p.SUB[rb[0]+xf+k], s0r = p.SUB[rb[0]+xf+k+3];
    2144:	lea    r10,[rcx+r11*1]
                        float s2l = p.SUB[rb[2]+xf+k], s2r = p.SUB[rb[2]+xf+k+3];
    2148:	add    rcx,rax
                        float s1l = p.SUB[rb[1]+xf+k], s1r = p.SUB[rb[1]+xf+k+3];
    214b:	movzx  edi,BYTE PTR [rbx+rsi*1]
    214f:	movzx  esi,BYTE PTR [rbx+rsi*1+0x3]
    2154:	vcvtusi2ss xmm13,xmm10,esi
                        float s2l = p.SUB[rb[2]+xf+k], s2r = p.SUB[rb[2]+xf+k+3];
    215a:	movzx  esi,BYTE PTR [rbx+rcx*1]
    215e:	movzx  ecx,BYTE PTR [rbx+rcx*1+0x3]
                        float s1l = p.SUB[rb[1]+xf+k], s1r = p.SUB[rb[1]+xf+k+3];
    2163:	vcvtusi2ss xmm14,xmm10,edi
                        float s2l = p.SUB[rb[2]+xf+k], s2r = p.SUB[rb[2]+xf+k+3];
    2169:	vcvtusi2ss xmm8,xmm10,esi
                        float s0l = p.SUB[rb[0]+xf+k], s0r = p.SUB[rb[0]+xf+k+3];
    216f:	movzx  esi,BYTE PTR [rbx+r10*1]
                        vp0[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    2174:	vmulss xmm18,xmm6,xmm14
                        vp1[xf+k] += p.A*s1l + p.B*s1r + p.C*s2l + p.D*s2r;
    217a:	vmulss xmm15,xmm6,xmm8
                        float s2l = p.SUB[rb[2]+xf+k], s2r = p.SUB[rb[2]+xf+k+3];
    217f:	vcvtusi2ss xmm8,xmm10,ecx
                        vp0[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    2185:	lea    ecx,[r12+r9*1]
    2189:	lea    rdi,[rcx*4+0x0]
                        float s2l = p.SUB[rb[2]+xf+k], s2r = p.SUB[rb[2]+xf+k+3];
    2191:	vmovaps xmm12,xmm8
                        float s0l = p.SUB[rb[0]+xf+k], s0r = p.SUB[rb[0]+xf+k+3];
    2196:	vcvtusi2ss xmm8,xmm10,esi
    219c:	movzx  esi,BYTE PTR [rbx+r10*1+0x3]
    21a2:	vcvtusi2ss xmm16,xmm10,esi
    21a8:	vfmadd213ss xmm8,xmm4,DWORD PTR [r14+rdi*1]
    21ae:	vfmadd132ss xmm16,xmm18,xmm5
                        vp0[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    21b4:	vfmadd231ss xmm8,xmm7,xmm13
    21b9:	vfmadd132ss xmm13,xmm15,xmm5
    21be:	vaddss xmm8,xmm8,xmm16
    21c4:	vmovss DWORD PTR [r14+rdi*1],xmm8
                        vp1[xf+k] += p.A*s1l + p.B*s1r + p.C*s2l + p.D*s2r;
    21ca:	vmovaps xmm8,xmm12
    21cf:	vfmadd213ss xmm14,xmm4,DWORD PTR [r15+rdi*1]
    21d5:	vfmadd132ss xmm8,xmm14,xmm7
    21da:	vaddss xmm8,xmm8,xmm13
    21df:	vmovss DWORD PTR [r15+rdi*1],xmm8
                    for (int k = 0; k < x_floats - xf; ++k) {
    21e5:	lea    edi,[r8+0x2]
    21e9:	cmp    edi,DWORD PTR [rsp+0x1e0]
    21f0:	jge    229e <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x229e>
                        float s0l = p.SUB[rb[0]+xf+k], s0r = p.SUB[rb[0]+xf+k+3];
    21f6:	mov    r8d,edi
                        float s1l = p.SUB[rb[1]+xf+k], s1r = p.SUB[rb[1]+xf+k+3];
    21f9:	lea    rcx,[r8+r13*1]
                        float s2l = p.SUB[rb[2]+xf+k], s2r = p.SUB[rb[2]+xf+k+3];
    21fd:	add    rax,r8
                        float s0l = p.SUB[rb[0]+xf+k], s0r = p.SUB[rb[0]+xf+k+3];
    2200:	lea    r9,[r11+r8*1]
                        float s1l = p.SUB[rb[1]+xf+k], s1r = p.SUB[rb[1]+xf+k+3];
    2204:	movzx  esi,BYTE PTR [rbx+rcx*1]
    2208:	movzx  ecx,BYTE PTR [rbx+rcx*1+0x3]
    220d:	vcvtusi2ss xmm13,xmm10,ecx
                        float s2l = p.SUB[rb[2]+xf+k], s2r = p.SUB[rb[2]+xf+k+3];
    2213:	movzx  ecx,BYTE PTR [rbx+rax*1]
    2217:	movzx  eax,BYTE PTR [rbx+rax*1+0x3]
                        float s1l = p.SUB[rb[1]+xf+k], s1r = p.SUB[rb[1]+xf+k+3];
    221c:	vcvtusi2ss xmm14,xmm10,esi
                        float s2l = p.SUB[rb[2]+xf+k], s2r = p.SUB[rb[2]+xf+k+3];
    2222:	vcvtusi2ss xmm8,xmm10,ecx
                        vp1[xf+k] += p.A*s1l + p.B*s1r + p.C*s2l + p.D*s2r;
    2228:	vmulss xmm15,xmm6,xmm8
                        float s2l = p.SUB[rb[2]+xf+k], s2r = p.SUB[rb[2]+xf+k+3];
    222d:	vcvtusi2ss xmm8,xmm10,eax
                        vp0[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    2233:	lea    eax,[r12+rdi*1]
    2237:	lea    rsi,[rax*4+0x0]
                        float s0l = p.SUB[rb[0]+xf+k], s0r = p.SUB[rb[0]+xf+k+3];
    223f:	movzx  eax,BYTE PTR [rbx+r9*1]
                        float s2l = p.SUB[rb[2]+xf+k], s2r = p.SUB[rb[2]+xf+k+3];
    2244:	vmovaps xmm12,xmm8
                        float s0l = p.SUB[rb[0]+xf+k], s0r = p.SUB[rb[0]+xf+k+3];
    2249:	vcvtusi2ss xmm8,xmm10,eax
    224f:	movzx  eax,BYTE PTR [rbx+r9*1+0x3]
    2255:	vfmadd213ss xmm8,xmm4,DWORD PTR [r14+rsi*1]
                        vp0[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    225b:	vmulss xmm18,xmm6,xmm14
                        float s0l = p.SUB[rb[0]+xf+k], s0r = p.SUB[rb[0]+xf+k+3];
    2261:	vcvtusi2ss xmm16,xmm10,eax
                        vp0[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    2267:	vfmadd231ss xmm8,xmm7,xmm13
    226c:	vfmadd132ss xmm13,xmm15,xmm5
    2271:	vfmadd132ss xmm16,xmm18,xmm5
    2277:	vaddss xmm8,xmm8,xmm16
    227d:	vmovss DWORD PTR [r14+rsi*1],xmm8
                        vp1[xf+k] += p.A*s1l + p.B*s1r + p.C*s2l + p.D*s2r;
    2283:	vmovaps xmm8,xmm12
    2288:	vfmadd213ss xmm14,xmm4,DWORD PTR [r15+rsi*1]
    228e:	vfmadd132ss xmm8,xmm14,xmm7
    2293:	vaddss xmm8,xmm8,xmm13
    2298:	vmovss DWORD PTR [r15+rsi*1],xmm8
                for (; y + 1 < y_end; y += 2) {
    229e:	add    DWORD PTR [rsp+0xfc],0x2
                if (y < y_end) {
    22a6:	mov    ebx,DWORD PTR [rsp+0xfc]
    22ad:	cmp    DWORD PTR [rsp+0xf8],ebx
    22b4:	jle    2e60 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x2e60>
                    size_t rb0 = ((size_t)(y + p.sy) * width + (size_t)(x_begin + p.sx)) * 3;
    22ba:	mov    eax,DWORD PTR [rdx+0x4]
    22bd:	mov    ecx,DWORD PTR [rsp+0xe4]
                    float* vp = tile_vals.data() + (size_t)(y - ty) * tile_row_stride + (size_t)(x_begin - tx) * 3;
    22c4:	mov    r11,QWORD PTR [rsp+0xa0]
                    for (; xf + 16 <= x_floats; xf += 16) {
    22cc:	mov    esi,DWORD PTR [rsp+0x1f0]
                    size_t rb0 = ((size_t)(y + p.sy) * width + (size_t)(x_begin + p.sx)) * 3;
    22d3:	add    eax,ebx
    22d5:	add    ecx,DWORD PTR [rdx]
                    float* vp = tile_vals.data() + (size_t)(y - ty) * tile_row_stride + (size_t)(x_begin - tx) * 3;
    22d7:	sub    ebx,DWORD PTR [rsp+0xe0]
                    size_t rb0 = ((size_t)(y + p.sy) * width + (size_t)(x_begin + p.sx)) * 3;
    22de:	cdqe
    22e0:	movsxd rcx,ecx
                        float s0l = p.SUB[rb[0]+xf+k], s0r = p.SUB[rb[0]+xf+k+3];
    22e3:	mov    r8,QWORD PTR [rdx+0x28]
                    size_t rb0 = ((size_t)(y + p.sy) * width + (size_t)(x_begin + p.sx)) * 3;
    22e7:	imul   rax,QWORD PTR [rsp+0xb8]
    22f0:	add    rax,rcx
    22f3:	lea    rdi,[rax+rax*2]
                    size_t rb1 = rb0 + width * 3;
    22f7:	mov    rax,QWORD PTR [rsp+0x88]
                    size_t rb0 = ((size_t)(y + p.sy) * width + (size_t)(x_begin + p.sx)) * 3;
    22ff:	mov    r13,rdi
                    size_t rb1 = rb0 + width * 3;
    2302:	lea    r9,[rax+rdi*1]
                    float* vp = tile_vals.data() + (size_t)(y - ty) * tile_row_stride + (size_t)(x_begin - tx) * 3;
    2306:	movsxd rax,ebx
    2309:	mov    rbx,QWORD PTR [rsp+0xd8]
    2311:	imul   r11,rax
    2315:	mov    eax,DWORD PTR [rsp+0xe4]
    231c:	sub    eax,DWORD PTR [rsp+0xcc]
    2323:	cdqe
    2325:	lea    rax,[rax+rax*2]
    2329:	add    rax,r11
    232c:	lea    r14,[rbx+rax*4]
                    for (; xf + 16 <= x_floats; xf += 16) {
    2330:	cmp    esi,0xf
    2333:	jle    36ef <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x36ef>
    2339:	mov    r10d,esi
    233c:	lea    rcx,[r8+r9*1]
    2340:	lea    ebx,[rsi-0x10]
    2343:	mov    rax,r14
    2346:	shr    r10d,0x4
    234a:	shl    r10,0x6
    234e:	add    r10,r14
    2351:	nop    DWORD PTR [rax+0x0]
    2358:	mov    rsi,rcx
    235b:	vpmovzxbd ymm14,QWORD PTR [rcx]
    2360:	vpmovzxbd ymm13,QWORD PTR [rcx+0x8]
    2366:	add    rax,0x40
    236a:	sub    rsi,r9
    236d:	vpmovzxbd ymm12,QWORD PTR [rcx+0x3]
    2373:	vpmovzxbd ymm8,QWORD PTR [rcx+0xb]
    2379:	add    rcx,0x10
    237d:	vpmovzxbd ymm19,QWORD PTR [rsi+rdi*1]
    2384:	vpmovzxbd ymm18,QWORD PTR [rsi+rdi*1+0x8]
  return (__m256)__builtin_ia32_cvtdq2ps256 ((__v8si) __A);
    238c:	vcvtdq2ps ymm14,ymm14
    2391:	vcvtdq2ps ymm13,ymm13
    2396:	vpmovzxbd ymm16,QWORD PTR [rsi+rdi*1+0x3]
    23a1:	vpmovzxbd ymm15,QWORD PTR [rsi+rdi*1+0xb]
    23a8:	vcvtdq2ps ymm12,ymm12
    23ad:	vcvtdq2ps ymm8,ymm8
    23b2:	vcvtdq2ps ymm19,ymm19
    23b8:	vcvtdq2ps ymm18,ymm18
    23be:	vfmadd213ps ymm19,ymm0,YMMWORD PTR [rax-0x40]
    23c5:	vfmadd213ps ymm18,ymm0,YMMWORD PTR [rax-0x20]
    23cc:	vcvtdq2ps ymm16,ymm16
    23d2:	vcvtdq2ps ymm15,ymm15
    23d7:	vfmadd132ps ymm16,ymm19,ymm1
    23dd:	vfmadd132ps ymm15,ymm18,ymm1
    23e3:	vfmadd132ps ymm14,ymm16,ymm2
    23e9:	vfmadd132ps ymm13,ymm15,ymm2
    23ee:	vfmadd132ps ymm12,ymm14,ymm3
    23f3:	vfmadd132ps ymm8,ymm13,ymm3
  *(__m256_u *)__P = __A;
    23f8:	vmovups YMMWORD PTR [rax-0x40],ymm12
    23fd:	vmovups YMMWORD PTR [rax-0x20],ymm8
    2402:	cmp    r10,rax
    2405:	jne    2358 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x2358>
    240b:	mov    eax,ebx
    240d:	and    eax,0xfffffff0
                    if (xf + 8 <= x_floats) {
    2410:	lea    ecx,[rax+0x17]
    2413:	lea    r15d,[rax+0x10]
    2417:	cmp    ecx,DWORD PTR [rsp+0x1f0]
    241e:	jge    2479 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x2479>
                        __m256 rl0 = load_cvt8(p.SUB + rb0 + xf);
    2420:	lea    esi,[rax+0x10]
                        xf += 8;
    2423:	lea    r15d,[rax+0x18]
                        __m256 rl0 = load_cvt8(p.SUB + rb0 + xf);
    2427:	lea    rcx,[rdi+rsi*1]
                        __m256 rl1 = load_cvt8(p.SUB + rb1 + xf);
    242b:	lea    r10,[r9+rsi*1]
                        __m256 v = _mm256_loadu_ps(vp + xf);
    242f:	lea    rsi,[r14+rsi*4]
    2433:	vpmovzxbd ymm14,QWORD PTR [r8+rcx*1]
    2439:	vpmovzxbd ymm13,QWORD PTR [r8+rcx*1+0x3]
    2440:	vpmovzxbd ymm12,QWORD PTR [r8+r10*1]
    2446:	vpmovzxbd ymm8,QWORD PTR [r8+r10*1+0x3]
  return (__m256)__builtin_ia32_cvtdq2ps256 ((__v8si) __A);
    244d:	vcvtdq2ps ymm14,ymm14
    2452:	vfmadd213ps ymm14,ymm0,YMMWORD PTR [rsi]
    2457:	vcvtdq2ps ymm13,ymm13
    245c:	vcvtdq2ps ymm12,ymm12
    2461:	vcvtdq2ps ymm8,ymm8
    2466:	vfmadd132ps ymm13,ymm14,ymm1
    246b:	vfmadd132ps ymm12,ymm13,ymm2
    2470:	vfmadd132ps ymm8,ymm12,ymm3
  *(__m256_u *)__P = __A;
    2475:	vmovups YMMWORD PTR [rsi],ymm8
                    for (int k = 0; k < x_floats - xf; ++k) {
    2479:	mov    eax,DWORD PTR [rsp+0x1f0]
    2480:	sub    eax,r15d
    2483:	mov    DWORD PTR [rsp+0xc0],eax
    248a:	test   eax,eax
    248c:	jle    2e60 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x2e60>
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
    2492:	mov    ebx,r15d
    2495:	lea    r13,[rdi+rbx*1]
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
    2499:	add    r9,rbx
    249c:	mov    r12d,DWORD PTR [rsp+0xe4]
    24a4:	mov    eax,DWORD PTR [rsp+0xc0]
    24ab:	lea    rsi,[r8+r9*1]
    24af:	mov    rdi,QWORD PTR [rsp+0xd8]
    24b7:	sub    r12,QWORD PTR [rsp+0xb0]
    24bf:	lea    r10,[rax+r9*1+0x3]
    24c4:	lea    rcx,[r12+r12*2]
    24c8:	add    r10,r8
    24cb:	add    rcx,r11
    24ce:	lea    r12,[rcx+rbx*1]
    24d2:	lea    r11,[rdi+r12*4]
    24d6:	lea    rcx,[r12+rax*1]
    24da:	cmp    r11,r10
    24dd:	lea    rcx,[rdi+rcx*4]
    24e1:	mov    QWORD PTR [rsp+0x1f0],r11
    24e9:	lea    rdi,[r8+r13*1]
    24ed:	setae  r11b
    24f1:	cmp    rsi,rcx
    24f4:	setae  r10b
    24f8:	or     r11b,r10b
    24fb:	je     3662 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x3662>
    2501:	lea    rax,[rax+r13*1+0x3]
    2506:	add    rax,r8
    2509:	cmp    QWORD PTR [rsp+0x1f0],rax
    2511:	setae  r10b
    2515:	cmp    rdi,rcx
    2518:	setae  cl
    251b:	or     r10b,cl
    251e:	je     3662 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x3662>
    2524:	mov    ebx,DWORD PTR [rsp+0xc0]
    252b:	lea    eax,[rbx-0x1]
    252e:	cmp    eax,0x1e
    2531:	jbe    3735 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x3735>
    2537:	shr    ebx,0x5
    253a:	mov    rax,QWORD PTR [rsp+0x1f0]
    2542:	lea    r11,[r8+r9*1+0x3]
    2547:	lea    r10,[r8+r13*1+0x3]
    254c:	mov    DWORD PTR [rsp+0x1e8],ebx
                    int xf = 0;
    2553:	xor    ecx,ecx
    2555:	shl    rbx,0x5
    2559:	nop    DWORD PTR [rax+0x0]
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
    2560:	vmovdqu ymm8,YMMWORD PTR [rsi+rcx*1]
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
    2565:	vmovdqu ymm12,YMMWORD PTR [r10+rcx*1]
    256b:	sub    rax,0xffffffffffffff80
    256f:	vmovdqu ymm13,YMMWORD PTR [rdi+rcx*1]
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
    2574:	vpmovzxbw ymm14,xmm8
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
    2579:	vpmovzxbw ymm15,xmm12
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
    257e:	vextracti32x4 xmm8,ymm8,0x1
    2585:	vpmovsxwd ymm18,xmm14
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
    258b:	vpmovsxwd ymm16,xmm15
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
    2591:	vpmovzxbw ymm8,xmm8
    2596:	vcvtdq2ps ymm18,ymm18
                        vp[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    259c:	vmulps ymm18,ymm18,ymm2
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
    25a2:	vcvtdq2ps ymm16,ymm16
    25a8:	vextracti32x4 xmm12,ymm12,0x1
    25af:	vpmovzxbw ymm19,xmm13
    25b5:	vpmovzxbw ymm12,xmm12
    25ba:	vpmovsxwd ymm21,xmm19
    25c0:	vextracti32x4 xmm13,ymm13,0x1
    25c7:	vcvtdq2ps ymm21,ymm21
    25cd:	vfmadd213ps ymm21,ymm0,YMMWORD PTR [rax-0x80]
    25d4:	vextracti32x4 xmm19,ymm19,0x1
    25db:	vpmovzxbw ymm13,xmm13
    25e0:	vpmovsxwd ymm19,xmm19
    25e6:	vcvtdq2ps ymm19,ymm19
    25ec:	vfmadd213ps ymm19,ymm0,YMMWORD PTR [rax-0x60]
    25f3:	vfmadd132ps ymm16,ymm18,ymm1
    25f9:	vextracti32x4 xmm18,ymm15,0x1
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
    2600:	vextracti32x4 xmm15,ymm14,0x1
    2607:	vpmovsxwd ymm15,xmm15
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
    260c:	vpmovsxwd ymm18,xmm18
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
    2612:	vcvtdq2ps ymm15,ymm15
                        vp[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    2617:	vmulps ymm15,ymm15,ymm2
    261b:	vcvtdq2ps ymm14,ymm18
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
    2621:	vpmovsxwd ymm18,xmm12
    2627:	vextracti32x4 xmm12,ymm12,0x1
    262e:	vpmovsxwd ymm12,xmm12
    2633:	vcvtdq2ps ymm18,ymm18
    2639:	vcvtdq2ps ymm12,ymm12
    263e:	vfmadd132ps ymm14,ymm15,ymm1
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
    2643:	vpmovsxwd ymm15,xmm8
    2648:	vextracti32x4 xmm8,ymm8,0x1
    264f:	vpmovsxwd ymm8,xmm8
    2654:	vcvtdq2ps ymm15,ymm15
    2659:	vcvtdq2ps ymm8,ymm8
                        vp[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    265e:	vmulps ymm8,ymm8,ymm2
    2662:	vmulps ymm15,ymm15,ymm2
    2666:	vfmadd132ps ymm12,ymm8,ymm1
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
    266b:	vmovdqu ymm8,YMMWORD PTR [r11+rcx*1]
    2671:	add    rcx,0x20
    2675:	vfmadd132ps ymm18,ymm15,ymm1
    267b:	vpmovzxbw ymm15,xmm8
    2680:	vextracti32x4 xmm8,ymm8,0x1
    2687:	vpmovsxwd ymm20,xmm15
    268d:	vextracti32x4 xmm15,ymm15,0x1
    2694:	vpmovzxbw ymm8,xmm8
    2699:	vcvtdq2ps ymm20,ymm20
    269f:	vfmadd132ps ymm20,ymm21,ymm3
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
    26a5:	vpmovsxwd ymm21,xmm13
    26ab:	vextracti32x4 xmm13,ymm13,0x1
    26b2:	vpmovsxwd ymm13,xmm13
    26b7:	vcvtdq2ps ymm21,ymm21
    26bd:	vfmadd213ps ymm21,ymm0,YMMWORD PTR [rax-0x40]
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
    26c4:	vpmovsxwd ymm15,xmm15
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
    26c9:	vcvtdq2ps ymm13,ymm13
                        vp[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    26ce:	vfmadd213ps ymm13,ymm0,YMMWORD PTR [rax-0x20]
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
    26d4:	vcvtdq2ps ymm15,ymm15
    26d9:	vfmadd132ps ymm15,ymm19,ymm3
    26df:	vpmovsxwd ymm19,xmm8
    26e5:	vextracti32x4 xmm8,ymm8,0x1
    26ec:	vcvtdq2ps ymm19,ymm19
    26f2:	vpmovsxwd ymm8,xmm8
    26f7:	vcvtdq2ps ymm8,ymm8
                        vp[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    26fc:	vaddps ymm16,ymm16,ymm20
    2702:	vfmadd132ps ymm19,ymm21,ymm3
    2708:	vfmadd132ps ymm8,ymm13,ymm3
    270d:	vaddps ymm14,ymm14,ymm15
    2712:	vmovups YMMWORD PTR [rax-0x80],ymm16
    2719:	vmovups YMMWORD PTR [rax-0x60],ymm14
    271e:	vaddps ymm18,ymm18,ymm19
    2724:	vaddps ymm8,ymm8,ymm12
    2729:	vmovups YMMWORD PTR [rax-0x40],ymm18
    2730:	vmovups YMMWORD PTR [rax-0x20],ymm8
                    for (int k = 0; k < x_floats - xf; ++k) {
    2735:	cmp    rcx,rbx
    2738:	jne    2560 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x2560>
    273e:	mov    edi,DWORD PTR [rsp+0x1e8]
    2745:	shl    edi,0x5
    2748:	cmp    edi,DWORD PTR [rsp+0xc0]
    274f:	je     2e60 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x2e60>
    2755:	mov    esi,edi
    2757:	mov    r11d,DWORD PTR [rsp+0xc0]
    275f:	sub    r11d,edi
    2762:	lea    eax,[r11-0x1]
    2766:	cmp    eax,0xe
    2769:	jbe    372e <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x372e>
    276f:	mov    eax,edi
    2771:	mov    rbx,QWORD PTR [rsp+0xd8]
    2779:	lea    r10,[rax+r9*1]
    277d:	lea    rcx,[rax+r13*1]
    2781:	add    rax,r12
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
    2784:	vmovdqu xmm3,XMMWORD PTR [r8+r10*1]
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
    278a:	vmovdqu xmm0,XMMWORD PTR [r8+rcx*1]
    2790:	lea    rax,[rbx+rax*4]
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
    2794:	vpmovzxbw xmm1,xmm3
    2799:	vpsrldq xmm3,xmm3,0x8
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
    279e:	vpmovzxbw xmm16,xmm0
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
    27a4:	vpmovsxwd xmm12,xmm1
    27a9:	vpsrldq xmm1,xmm1,0x8
    27ae:	vpmovzxbw xmm3,xmm3
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
    27b3:	vpsrldq xmm0,xmm0,0x8
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
    27b8:	vpmovsxwd xmm1,xmm1
    27bd:	vcvtdq2ps xmm12,xmm12
    27c2:	vcvtdq2ps xmm1,xmm1
                        vp[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    27c6:	vmulps xmm1,xmm1,xmm25
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
    27cc:	vpmovzxbw xmm2,xmm0
    27d1:	vmovdqu xmm0,XMMWORD PTR [r8+rcx*1+0x3]
                        vp[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    27d8:	vmulps xmm12,xmm12,xmm25
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
    27de:	vpmovzxbw xmm8,xmm0
    27e3:	vpsrldq xmm0,xmm0,0x8
    27e8:	vpmovsxwd xmm13,xmm8
    27ed:	vpsrldq xmm8,xmm8,0x8
    27f3:	vpmovzxbw xmm0,xmm0
    27f8:	vpmovsxwd xmm8,xmm8
    27fd:	vcvtdq2ps xmm13,xmm13
    2802:	vcvtdq2ps xmm8,xmm8
    2807:	vfmadd132ps xmm8,xmm1,xmm17
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
    280d:	vpmovsxwd xmm1,xmm3
    2812:	vcvtdq2ps xmm1,xmm1
                        vp[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    2816:	vmulps xmm1,xmm1,xmm25
    281c:	vfmadd132ps xmm13,xmm12,xmm17
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
    2822:	vpmovsxwd xmm12,xmm0
    2827:	vcvtdq2ps xmm12,xmm12
    282c:	vfmadd132ps xmm12,xmm1,xmm17
    2832:	vpsrldq xmm1,xmm0,0x8
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
    2837:	vpsrldq xmm0,xmm3,0x8
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
    283c:	vpmovsxwd xmm3,xmm16
    2842:	vpmovsxwd xmm1,xmm1
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
    2847:	vpmovsxwd xmm0,xmm0
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
    284c:	vcvtdq2ps xmm3,xmm3
    2850:	vfmadd213ps xmm3,xmm9,XMMWORD PTR [rax]
    2855:	vcvtdq2ps xmm1,xmm1
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
    2859:	vcvtdq2ps xmm0,xmm0
                        vp[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    285d:	vmulps xmm0,xmm0,xmm25
    2863:	vfmadd132ps xmm1,xmm0,xmm17
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
    2869:	vmovdqu xmm0,XMMWORD PTR [r8+r10*1+0x3]
    2870:	vpmovzxbw xmm14,xmm0
    2875:	vpsrldq xmm0,xmm0,0x8
    287a:	vpmovsxwd xmm15,xmm14
    287f:	vpsrldq xmm14,xmm14,0x8
    2885:	vpmovzxbw xmm0,xmm0
    288a:	vcvtdq2ps xmm15,xmm15
    288f:	vfmadd132ps xmm15,xmm3,xmm11
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
    2894:	vpsrldq xmm3,xmm16,0x8
    289b:	vpmovsxwd xmm16,xmm2
    28a1:	vpmovsxwd xmm3,xmm3
    28a6:	vpsrldq xmm2,xmm2,0x8
    28ab:	vcvtdq2ps xmm16,xmm16
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
    28b1:	vpmovsxwd xmm14,xmm14
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
    28b6:	vcvtdq2ps xmm3,xmm3
    28ba:	vfmadd213ps xmm3,xmm9,XMMWORD PTR [rax+0x10]
    28c0:	vfmadd213ps xmm16,xmm9,XMMWORD PTR [rax+0x20]
    28c7:	vpmovsxwd xmm2,xmm2
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
    28cc:	vcvtdq2ps xmm14,xmm14
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
    28d1:	vcvtdq2ps xmm2,xmm2
                        vp[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    28d5:	vfmadd213ps xmm2,xmm9,XMMWORD PTR [rax+0x30]
    28db:	vaddps xmm13,xmm13,xmm15
    28e0:	vfmadd132ps xmm14,xmm3,xmm11
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
    28e5:	vpmovsxwd xmm3,xmm0
    28ea:	vpsrldq xmm0,xmm0,0x8
    28ef:	vcvtdq2ps xmm3,xmm3
    28f3:	vfmadd132ps xmm3,xmm16,xmm11
                        vp[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    28f9:	vmovups XMMWORD PTR [rax],xmm13
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
    28fd:	vpmovsxwd xmm0,xmm0
    2902:	vcvtdq2ps xmm0,xmm0
                        vp[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    2906:	vfmadd132ps xmm0,xmm2,xmm11
    290b:	vaddps xmm8,xmm8,xmm14
    2910:	vaddps xmm12,xmm12,xmm3
    2914:	vaddps xmm0,xmm0,xmm1
    2918:	vmovups XMMWORD PTR [rax+0x10],xmm8
    291d:	vmovups XMMWORD PTR [rax+0x20],xmm12
    2922:	vmovups XMMWORD PTR [rax+0x30],xmm0
                    for (int k = 0; k < x_floats - xf; ++k) {
    2927:	mov    eax,r11d
    292a:	and    eax,0xfffffff0
    292d:	test   r11b,0xf
    2931:	je     2e60 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x2e60>
    2937:	add    esi,eax
    2939:	sub    r11d,eax
    293c:	lea    ecx,[r11-0x1]
    2940:	cmp    ecx,0x6
    2943:	jbe    2b7b <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x2b7b>
    2949:	add    eax,edi
    294b:	mov    rbx,QWORD PTR [rsp+0xd8]
    2953:	vmovaps xmm16,xmm9
    2959:	mov    eax,eax
    295b:	lea    rdi,[rax+r9*1]
    295f:	lea    rcx,[rax+r13*1]
    2963:	add    rax,r12
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
    2966:	vmovq  xmm1,QWORD PTR [r8+rdi*1]
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
    296c:	vmovq  xmm0,QWORD PTR [r8+rcx*1]
    2972:	lea    rax,[rbx+rax*4]
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
    2976:	vpmovzxbw xmm12,xmm1
    297b:	vpsrlq xmm1,xmm1,0x20
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
    2980:	vpmovzxbw xmm8,xmm0
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
    2985:	vpmovzxwd xmm14,xmm12
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
    298a:	vpsrlq xmm0,xmm0,0x20
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
    298f:	vpmovzxbw xmm1,xmm1
    2994:	vmovq  xmm14,xmm14
    2999:	vpsrlq xmm12,xmm12,0x20
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
    299f:	vpmovzxbw xmm2,xmm0
    29a4:	vmovq  xmm0,QWORD PTR [r8+rcx*1+0x3]
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
    29ab:	vcvtdq2ps xmm14,xmm14
                        vp[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    29b0:	vmulps xmm14,xmm14,xmm25
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
    29b6:	vpmovzxwd xmm12,xmm12
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
    29bb:	vpmovzxbw xmm3,xmm0
    29c0:	vpsrlq xmm0,xmm0,0x20
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
    29c5:	vmovq  xmm12,xmm12
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
    29ca:	vpmovzxwd xmm13,xmm3
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
    29cf:	vcvtdq2ps xmm12,xmm12
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
    29d4:	vpsrlq xmm3,xmm3,0x20
    29d9:	vpmovzxbw xmm0,xmm0
                        vp[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    29de:	vmulps xmm12,xmm12,xmm25
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
    29e4:	vmovq  xmm13,xmm13
    29e9:	vpmovzxwd xmm3,xmm3
    29ee:	vcvtdq2ps xmm13,xmm13
    29f3:	vmovq  xmm3,xmm3
    29f7:	vfmadd132ps xmm13,xmm14,xmm17
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
    29fd:	vpmovzxwd xmm14,xmm1
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
    2a02:	vcvtdq2ps xmm3,xmm3
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
    2a06:	vmovq  xmm14,xmm14
    2a0b:	vcvtdq2ps xmm14,xmm14
                        vp[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    2a10:	vmulps xmm14,xmm14,xmm25
    2a16:	vfmadd132ps xmm3,xmm12,xmm17
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
    2a1c:	vpmovzxwd xmm12,xmm0
    2a21:	vmovq  xmm12,xmm12
    2a26:	vcvtdq2ps xmm12,xmm12
    2a2b:	vfmadd132ps xmm12,xmm14,xmm17
    2a31:	vpsrlq xmm14,xmm0,0x20
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
    2a36:	vpsrlq xmm0,xmm1,0x20
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
    2a3b:	vpmovzxwd xmm14,xmm14
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
    2a40:	vpmovzxwd xmm0,xmm0
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
    2a45:	vmovq  xmm14,xmm14
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
    2a4a:	vmovq  xmm0,xmm0
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
    2a4e:	vcvtdq2ps xmm14,xmm14
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
    2a53:	vcvtdq2ps xmm0,xmm0
                        vp[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    2a57:	vmulps xmm0,xmm0,xmm25
    2a5d:	vfmadd132ps xmm14,xmm0,xmm17
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
    2a63:	vmovq  xmm0,QWORD PTR [r8+rdi*1+0x3]
    2a6a:	vpmovzxbw xmm1,xmm0
    2a6f:	vpsrlq xmm0,xmm0,0x20
    2a74:	vpmovzxwd xmm15,xmm1
    2a79:	vpmovzxbw xmm0,xmm0
    2a7e:	vmovq  xmm18,xmm15
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
    2a84:	vpmovzxwd xmm15,xmm8
    2a89:	vmovq  xmm15,xmm15
    2a8e:	vcvtdq2ps xmm17,xmm15
                        vp[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    2a94:	vmovq  xmm15,QWORD PTR [rax]
    2a98:	vfmadd231ps xmm15,xmm17,xmm9
    2a9e:	vcvtdq2ps xmm9,xmm18
    2aa4:	vfmadd132ps xmm9,xmm15,xmm11
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
    2aa9:	vpsrlq xmm15,xmm1,0x20
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
    2aae:	vpsrlq xmm1,xmm8,0x20
                        vp[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    2ab4:	vmovq  xmm8,QWORD PTR [rax+0x8]
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
    2ab9:	vpmovzxwd xmm15,xmm15
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
    2abe:	vpmovzxwd xmm1,xmm1
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
    2ac3:	vmovq  xmm15,xmm15
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
    2ac8:	vmovq  xmm1,xmm1
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
    2acc:	vcvtdq2ps xmm15,xmm15
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
    2ad1:	vcvtdq2ps xmm1,xmm1
    2ad5:	vfmadd132ps xmm1,xmm8,xmm16
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
    2adb:	vpmovzxwd xmm8,xmm0
    2ae0:	vmovq  xmm8,xmm8
    2ae5:	vpsrlq xmm0,xmm0,0x20
                        vp[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    2aea:	vaddps xmm13,xmm13,xmm9
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
    2aef:	vcvtdq2ps xmm8,xmm8
    2af4:	vpmovzxwd xmm0,xmm0
    2af9:	vmovq  xmm0,xmm0
    2afd:	vcvtdq2ps xmm0,xmm0
                        vp[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    2b01:	vmovlps QWORD PTR [rax],xmm13
    2b05:	vfmadd132ps xmm15,xmm1,xmm11
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
    2b0a:	vpmovzxwd xmm1,xmm2
    2b0f:	vmovq  xmm1,xmm1
    2b13:	vcvtdq2ps xmm17,xmm1
                        vp[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    2b19:	vmovq  xmm1,QWORD PTR [rax+0x10]
    2b1e:	vfmadd231ps xmm1,xmm17,xmm16
    2b24:	vaddps xmm3,xmm3,xmm15
    2b29:	vmovlps QWORD PTR [rax+0x8],xmm3
    2b2e:	vfmadd132ps xmm8,xmm1,xmm11
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
    2b33:	vpsrlq xmm1,xmm2,0x20
                        vp[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    2b38:	vmovq  xmm2,QWORD PTR [rax+0x18]
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
    2b3d:	vpmovzxwd xmm1,xmm1
    2b42:	vmovq  xmm1,xmm1
    2b46:	vcvtdq2ps xmm1,xmm1
                        vp[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    2b4a:	vfmadd132ps xmm1,xmm2,xmm16
    2b50:	vaddps xmm12,xmm12,xmm8
    2b55:	vfmadd132ps xmm0,xmm1,xmm11
    2b5a:	vmovlps QWORD PTR [rax+0x10],xmm12
    2b5f:	vaddps xmm0,xmm0,xmm14
    2b64:	vmovlps QWORD PTR [rax+0x18],xmm0
                    for (int k = 0; k < x_floats - xf; ++k) {
    2b69:	mov    eax,r11d
    2b6c:	and    eax,0xfffffff8
    2b6f:	and    r11d,0x7
    2b73:	je     2e60 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x2e60>
    2b79:	add    esi,eax
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
    2b7b:	movsxd rcx,esi
                    for (int k = 0; k < x_floats - xf; ++k) {
    2b7e:	mov    ebx,DWORD PTR [rsp+0xc0]
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
    2b85:	lea    rax,[rcx+r13*1]
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
    2b89:	lea    r10,[rcx+r9*1]
                        vp[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    2b8d:	lea    ecx,[r15+rsi*1]
    2b91:	lea    rdi,[r14+rcx*4]
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
    2b95:	movzx  ecx,BYTE PTR [r8+rax*1]
    2b9a:	movzx  eax,BYTE PTR [r8+rax*1+0x3]
    2ba0:	vcvtusi2ss xmm0,xmm10,ecx
    2ba6:	vmovaps xmm2,xmm0
    2baa:	vcvtusi2ss xmm0,xmm10,eax
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
    2bb0:	movzx  eax,BYTE PTR [r8+r10*1]
    2bb5:	vfmadd213ss xmm2,xmm4,DWORD PTR [rdi]
    2bba:	vcvtusi2ss xmm1,xmm10,eax
    2bc0:	movzx  eax,BYTE PTR [r8+r10*1+0x3]
                        vp[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    2bc6:	vmulss xmm1,xmm1,xmm6
    2bca:	vfmadd231ss xmm1,xmm5,xmm0
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
    2bcf:	vcvtusi2ss xmm0,xmm10,eax
                    for (int k = 0; k < x_floats - xf; ++k) {
    2bd5:	lea    eax,[rsi+0x1]
                        vp[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    2bd8:	vfmadd132ss xmm0,xmm2,xmm7
    2bdd:	vaddss xmm0,xmm0,xmm1
    2be1:	vmovss DWORD PTR [rdi],xmm0
                    for (int k = 0; k < x_floats - xf; ++k) {
    2be5:	cmp    eax,ebx
    2be7:	jge    2e60 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x2e60>
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
    2bed:	mov    ecx,eax
                        vp[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    2bef:	add    eax,r15d
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
    2bf2:	lea    rdi,[rcx+r13*1]
                        vp[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    2bf6:	mov    eax,eax
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
    2bf8:	lea    r10,[rcx+r9*1]
                        vp[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    2bfc:	lea    rcx,[r14+rax*4]
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
    2c00:	movzx  eax,BYTE PTR [r8+rdi*1]
    2c05:	vcvtusi2ss xmm0,xmm10,eax
    2c0b:	movzx  eax,BYTE PTR [r8+rdi*1+0x3]
    2c11:	vmovaps xmm2,xmm0
    2c15:	vcvtusi2ss xmm0,xmm10,eax
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
    2c1b:	movzx  eax,BYTE PTR [r8+r10*1]
    2c20:	vfmadd213ss xmm2,xmm4,DWORD PTR [rcx]
    2c25:	vcvtusi2ss xmm1,xmm10,eax
    2c2b:	movzx  eax,BYTE PTR [r8+r10*1+0x3]
                        vp[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    2c31:	vmulss xmm1,xmm1,xmm6
    2c35:	vfmadd231ss xmm1,xmm5,xmm0
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
    2c3a:	vcvtusi2ss xmm0,xmm10,eax
                    for (int k = 0; k < x_floats - xf; ++k) {
    2c40:	lea    eax,[rsi+0x2]
                        vp[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    2c43:	vfmadd132ss xmm0,xmm2,xmm7
    2c48:	vaddss xmm0,xmm0,xmm1
    2c4c:	vmovss DWORD PTR [rcx],xmm0
                    for (int k = 0; k < x_floats - xf; ++k) {
    2c50:	cmp    eax,ebx
    2c52:	jge    2e60 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x2e60>
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
    2c58:	mov    ecx,eax
                        vp[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    2c5a:	add    eax,r15d
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
    2c5d:	lea    rdi,[rcx+r13*1]
                        vp[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    2c61:	mov    eax,eax
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
    2c63:	lea    r10,[rcx+r9*1]
                        vp[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    2c67:	lea    rcx,[r14+rax*4]
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
    2c6b:	movzx  eax,BYTE PTR [r8+rdi*1]
    2c70:	vcvtusi2ss xmm0,xmm10,eax
    2c76:	movzx  eax,BYTE PTR [r8+rdi*1+0x3]
    2c7c:	vmovaps xmm2,xmm0
    2c80:	vcvtusi2ss xmm0,xmm10,eax
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
    2c86:	movzx  eax,BYTE PTR [r8+r10*1]
    2c8b:	vfmadd213ss xmm2,xmm4,DWORD PTR [rcx]
    2c90:	vcvtusi2ss xmm1,xmm10,eax
    2c96:	movzx  eax,BYTE PTR [r8+r10*1+0x3]
                        vp[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    2c9c:	vmulss xmm1,xmm1,xmm6
    2ca0:	vfmadd231ss xmm1,xmm5,xmm0
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
    2ca5:	vcvtusi2ss xmm0,xmm10,eax
                    for (int k = 0; k < x_floats - xf; ++k) {
    2cab:	lea    eax,[rsi+0x3]
                        vp[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    2cae:	vfmadd132ss xmm0,xmm2,xmm7
    2cb3:	vaddss xmm0,xmm0,xmm1
    2cb7:	vmovss DWORD PTR [rcx],xmm0
                    for (int k = 0; k < x_floats - xf; ++k) {
    2cbb:	cmp    eax,ebx
    2cbd:	jge    2e60 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x2e60>
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
    2cc3:	mov    ecx,eax
                        vp[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    2cc5:	add    eax,r15d
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
    2cc8:	lea    rdi,[rcx+r13*1]
                        vp[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    2ccc:	mov    eax,eax
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
    2cce:	lea    r10,[rcx+r9*1]
                        vp[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    2cd2:	lea    rcx,[r14+rax*4]
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
    2cd6:	movzx  eax,BYTE PTR [r8+rdi*1]
    2cdb:	vcvtusi2ss xmm0,xmm10,eax
    2ce1:	movzx  eax,BYTE PTR [r8+rdi*1+0x3]
    2ce7:	vmovaps xmm2,xmm0
    2ceb:	vcvtusi2ss xmm0,xmm10,eax
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
    2cf1:	movzx  eax,BYTE PTR [r8+r10*1]
    2cf6:	vfmadd213ss xmm2,xmm4,DWORD PTR [rcx]
    2cfb:	vcvtusi2ss xmm1,xmm10,eax
    2d01:	movzx  eax,BYTE PTR [r8+r10*1+0x3]
                        vp[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    2d07:	vmulss xmm1,xmm1,xmm6
    2d0b:	vfmadd231ss xmm1,xmm5,xmm0
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
    2d10:	vcvtusi2ss xmm0,xmm10,eax
                    for (int k = 0; k < x_floats - xf; ++k) {
    2d16:	lea    eax,[rsi+0x4]
                        vp[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    2d19:	vfmadd132ss xmm0,xmm2,xmm7
    2d1e:	vaddss xmm0,xmm0,xmm1
    2d22:	vmovss DWORD PTR [rcx],xmm0
                    for (int k = 0; k < x_floats - xf; ++k) {
    2d26:	cmp    eax,ebx
    2d28:	jge    2e60 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x2e60>
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
    2d2e:	mov    ecx,eax
                        vp[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    2d30:	add    eax,r15d
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
    2d33:	lea    rdi,[rcx+r13*1]
                        vp[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    2d37:	mov    eax,eax
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
    2d39:	lea    r10,[rcx+r9*1]
                        vp[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    2d3d:	lea    rcx,[r14+rax*4]
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
    2d41:	movzx  eax,BYTE PTR [r8+rdi*1]
    2d46:	vcvtusi2ss xmm0,xmm10,eax
    2d4c:	movzx  eax,BYTE PTR [r8+rdi*1+0x3]
    2d52:	vmovaps xmm2,xmm0
    2d56:	vcvtusi2ss xmm0,xmm10,eax
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
    2d5c:	movzx  eax,BYTE PTR [r8+r10*1]
    2d61:	vfmadd213ss xmm2,xmm4,DWORD PTR [rcx]
    2d66:	vcvtusi2ss xmm1,xmm10,eax
    2d6c:	movzx  eax,BYTE PTR [r8+r10*1+0x3]
                        vp[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    2d72:	vmulss xmm1,xmm1,xmm6
    2d76:	vfmadd231ss xmm1,xmm5,xmm0
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
    2d7b:	vcvtusi2ss xmm0,xmm10,eax
                    for (int k = 0; k < x_floats - xf; ++k) {
    2d81:	lea    eax,[rsi+0x5]
                        vp[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    2d84:	vfmadd132ss xmm0,xmm2,xmm7
    2d89:	vaddss xmm0,xmm0,xmm1
    2d8d:	vmovss DWORD PTR [rcx],xmm0
                    for (int k = 0; k < x_floats - xf; ++k) {
    2d91:	cmp    eax,ebx
    2d93:	jge    2e60 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x2e60>
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
    2d99:	mov    ecx,eax
                        vp[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    2d9b:	add    eax,r15d
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
    2d9e:	lea    rdi,[rcx+r13*1]
                        vp[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    2da2:	mov    eax,eax
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
    2da4:	lea    r10,[rcx+r9*1]
                        vp[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    2da8:	lea    rcx,[r14+rax*4]
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
    2dac:	movzx  eax,BYTE PTR [r8+rdi*1]
    2db1:	vcvtusi2ss xmm0,xmm10,eax
    2db7:	movzx  eax,BYTE PTR [r8+rdi*1+0x3]
    2dbd:	vmovaps xmm2,xmm0
    2dc1:	vcvtusi2ss xmm0,xmm10,eax
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
    2dc7:	movzx  eax,BYTE PTR [r8+r10*1]
    2dcc:	vfmadd213ss xmm2,xmm4,DWORD PTR [rcx]
    2dd1:	vcvtusi2ss xmm1,xmm10,eax
    2dd7:	movzx  eax,BYTE PTR [r8+r10*1+0x3]
                        vp[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    2ddd:	vmulss xmm1,xmm1,xmm6
    2de1:	vfmadd231ss xmm1,xmm5,xmm0
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
    2de6:	vcvtusi2ss xmm0,xmm10,eax
                    for (int k = 0; k < x_floats - xf; ++k) {
    2dec:	lea    eax,[rsi+0x6]
                        vp[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    2def:	vfmadd132ss xmm0,xmm2,xmm7
    2df4:	vaddss xmm0,xmm0,xmm1
    2df8:	vmovss DWORD PTR [rcx],xmm0
                    for (int k = 0; k < x_floats - xf; ++k) {
    2dfc:	cmp    eax,ebx
    2dfe:	jge    2e60 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x2e60>
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
    2e00:	mov    ecx,eax
                        vp[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    2e02:	add    eax,r15d
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
    2e05:	lea    rsi,[rcx+r13*1]
                        vp[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    2e09:	mov    eax,eax
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
    2e0b:	lea    rdi,[rcx+r9*1]
                        vp[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    2e0f:	lea    rcx,[r14+rax*4]
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
    2e13:	movzx  eax,BYTE PTR [r8+rsi*1]
    2e18:	vcvtusi2ss xmm0,xmm10,eax
    2e1e:	movzx  eax,BYTE PTR [r8+rsi*1+0x3]
    2e24:	vfmadd213ss xmm4,xmm0,DWORD PTR [rcx]
    2e29:	vcvtusi2ss xmm0,xmm10,eax
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
    2e2f:	movzx  eax,BYTE PTR [r8+rdi*1]
    2e34:	vcvtusi2ss xmm1,xmm10,eax
    2e3a:	movzx  eax,BYTE PTR [r8+rdi*1+0x3]
                        vp[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    2e40:	vmulss xmm1,xmm1,xmm6
    2e44:	vfmadd231ss xmm1,xmm5,xmm0
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
    2e49:	vcvtusi2ss xmm0,xmm10,eax
                        vp[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    2e4f:	vfmadd132ss xmm0,xmm4,xmm7
    2e54:	vaddss xmm0,xmm0,xmm1
    2e58:	vmovss DWORD PTR [rcx],xmm0
                    for (int k = 0; k < x_floats - xf; ++k) {
    2e5c:	nop    DWORD PTR [rax+0x0]
            for (const SubParams& p : params) {
    2e60:	add    rdx,0x30
    2e64:	cmp    QWORD PTR [rsp+0xd0],rdx
    2e6c:	jne    578 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x578>
    2e72:	mov    rbx,QWORD PTR [rsp+0x30]
    2e77:	mov    r14d,DWORD PTR [rsp+0x58]
            for (int y = ty; y < tile_y_end; ++y) {
    2e7c:	mov    r13d,DWORD PTR [rsp+0xc4]
    2e84:	cmp    DWORD PTR [rsp+0x24],r13d
    2e89:	jge    2fc0 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x2fc0>
    2e8f:	test   r14d,r14d
    2e92:	jle    2fc0 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x2fc0>
    2e98:	lea    rax,[rbx+rbx*2]
    2e9c:	mov    r12,QWORD PTR [rsp+0xb0]
    2ea4:	lea    r8d,[r14+r14*2]
    2ea8:	mov    rdi,QWORD PTR [rsp+0xd8]
    2eb0:	lea    rbx,[rax*4+0x0]
    2eb8:	mov    rax,QWORD PTR [rsp+0x50]
    2ebd:	mov    r9,QWORD PTR [rsp+0x28]
    2ec2:	mov    r10d,DWORD PTR [rsp+0xe0]
                    outp[x*3    ] = (unsigned char)std::clamp(vp[x*3    ] * inv_c + 0.5f, 0.0f, 255.0f);
    2eca:	vmovss xmm3,DWORD PTR [rip+0x0]        # 2ed2 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x2ed2>
      if (__b < __a)
    2ed2:	vmovss xmm5,DWORD PTR [rip+0x0]        # 2eda <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x2eda>
    2eda:	mov    r14,QWORD PTR [rsp+0xb8]
    2ee2:	lea    r11,[rax+r12*4]
    2ee6:	mov    r15,QWORD PTR [rsp+0x40]
    2eeb:	nop    DWORD PTR [rax+rax*1+0x0]
                unsigned char* outp = output.data.data() + (size_t)(y * width + tx) * 3;
    2ef0:	lea    rax,[r12+r9*1]
                    outp[x*3 + 1] = (unsigned char)std::clamp(vp[x*3 + 1] * inv_c + 0.5f, 0.0f, 255.0f);
                    outp[x*3 + 2] = (unsigned char)std::clamp(vp[x*3 + 2] * inv_c + 0.5f, 0.0f, 255.0f);
    2ef4:	mov    QWORD PTR [rsp+0x1f0],r9
    2efc:	vmovss xmm2,DWORD PTR [rip+0x0]        # 2f04 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x2f04>
    2f04:	lea    rcx,[r11+r9*4]
                unsigned char* outp = output.data.data() + (size_t)(y * width + tx) * 3;
    2f08:	lea    rsi,[rax+rax*2]
                    outp[x*3 + 2] = (unsigned char)std::clamp(vp[x*3 + 2] * inv_c + 0.5f, 0.0f, 255.0f);
    2f0c:	vmovss xmm4,DWORD PTR [rip+0x0]        # 2f14 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x2f14>
                unsigned char* outp = output.data.data() + (size_t)(y * width + tx) * 3;
    2f14:	xor    edx,edx
    2f16:	add    rsi,QWORD PTR [r15+0x10]
    2f1a:	nop    WORD PTR [rax+rax*1+0x0]
                    int c = counts[y * width + (tx + x)];
    2f20:	mov    eax,DWORD PTR [rcx]
                    if (c == 0) continue;
    2f22:	test   eax,eax
    2f24:	je     2f96 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x2f96>
                    float inv_c = 1.0f / (float)c;
    2f26:	vcvtsi2ss xmm0,xmm10,eax
                    outp[x*3    ] = (unsigned char)std::clamp(vp[x*3    ] * inv_c + 0.5f, 0.0f, 255.0f);
    2f2a:	mov    eax,edx
      if (__a < __b)
    2f2c:	xor    r9d,r9d
                    float inv_c = 1.0f / (float)c;
    2f2f:	vdivss xmm0,xmm30,xmm0
                    outp[x*3    ] = (unsigned char)std::clamp(vp[x*3    ] * inv_c + 0.5f, 0.0f, 255.0f);
    2f35:	vmulss xmm1,xmm0,DWORD PTR [rdi+rax*4]
    2f3a:	vcomiss xmm29,xmm1
    2f40:	ja     2f4e <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x2f4e>
    2f42:	vaddss xmm1,xmm1,xmm3
      if (__b < __a)
    2f46:	vminss xmm1,xmm1,xmm5
    2f4a:	vcvttss2si r9d,xmm1
                    outp[x*3 + 1] = (unsigned char)std::clamp(vp[x*3 + 1] * inv_c + 0.5f, 0.0f, 255.0f);
    2f4e:	vmulss xmm1,xmm0,DWORD PTR [rdi+rax*4+0x4]
                    outp[x*3    ] = (unsigned char)std::clamp(vp[x*3    ] * inv_c + 0.5f, 0.0f, 255.0f);
    2f54:	mov    BYTE PTR [rsi+rax*1],r9b
      if (__a < __b)
    2f58:	xor    r9d,r9d
    2f5b:	vcomiss xmm29,xmm1
    2f61:	ja     2f6f <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x2f6f>
                    outp[x*3 + 1] = (unsigned char)std::clamp(vp[x*3 + 1] * inv_c + 0.5f, 0.0f, 255.0f);
    2f63:	vaddss xmm1,xmm1,xmm3
      if (__b < __a)
    2f67:	vminss xmm1,xmm1,xmm2
    2f6b:	vcvttss2si r9d,xmm1
                    outp[x*3 + 2] = (unsigned char)std::clamp(vp[x*3 + 2] * inv_c + 0.5f, 0.0f, 255.0f);
    2f6f:	vmulss xmm0,xmm0,DWORD PTR [rdi+rax*4+0x8]
                    outp[x*3 + 1] = (unsigned char)std::clamp(vp[x*3 + 1] * inv_c + 0.5f, 0.0f, 255.0f);
    2f75:	mov    BYTE PTR [rsi+rax*1+0x1],r9b
      if (__a < __b)
    2f7a:	xor    r9d,r9d
    2f7d:	vcomiss xmm29,xmm0
    2f83:	ja     2f91 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x2f91>
                    outp[x*3 + 2] = (unsigned char)std::clamp(vp[x*3 + 2] * inv_c + 0.5f, 0.0f, 255.0f);
    2f85:	vaddss xmm0,xmm0,xmm4
      if (__b < __a)
    2f89:	vminss xmm0,xmm0,xmm2
    2f8d:	vcvttss2si r9d,xmm0
    2f91:	mov    BYTE PTR [rsi+rax*1+0x2],r9b
                for (int x = 0; x < tile_w_actual; ++x) {
    2f96:	add    edx,0x3
    2f99:	add    rcx,0x4
    2f9d:	cmp    edx,r8d
    2fa0:	jne    2f20 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x2f20>
            for (int y = ty; y < tile_y_end; ++y) {
    2fa6:	mov    r9,QWORD PTR [rsp+0x1f0]
    2fae:	inc    r10d
    2fb1:	add    rdi,rbx
    2fb4:	add    r9,r14
    2fb7:	cmp    r13d,r10d
    2fba:	jne    2ef0 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x2ef0>
        for (int tx = 0; tx < w; tx += TILE_W) {
    2fc0:	add    QWORD PTR [rsp+0xb0],0x7f0
    2fcc:	mov    rax,QWORD PTR [rsp+0xb0]
    2fd4:	cmp    DWORD PTR [rsp+0x90],eax
    2fdb:	jg     491 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x491>
    for (int ty = 0; ty < h; ty += TILE_H) {
    2fe1:	add    QWORD PTR [rsp+0x78],0x8
    2fe7:	mov    rax,QWORD PTR [rsp+0x10]
    2fec:	mov    r14,QWORD PTR [rsp+0x28]
    2ff1:	mov    rbx,QWORD PTR [rsp+0x78]
    2ff6:	cmp    DWORD PTR [rsp+0x5c],ebx
    2ffa:	jle    3759 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x3759>
    3000:	mov    DWORD PTR [rsp+0xe0],ebx
    3007:	add    r14,rax
        const int tile_y_end    = std::min(ty + TILE_H, h);
    300a:	lea    edx,[rbx+0x8]
        for (int tx = 0; tx < w; tx += TILE_W) {
    300d:	jmp    458 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x458>
    3012:	nop    WORD PTR [rax+rax*1+0x0]
                    if (xf + 8 <= x_floats) {
    3018:	mov    esi,DWORD PTR [rsp+0x1f0]
    301f:	cmp    esi,0x7
    3022:	jg     3032 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x3032>
    3024:	mov    DWORD PTR [rsp+0x1a8],esi
    302b:	xor    esi,esi
    302d:	jmp    c27 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0xc27>
    3032:	mov    rsi,QWORD PTR [rsp+0x1c0]
    303a:	mov    QWORD PTR [rsp+0x110],r15
    3042:	mov    rcx,rax
    3045:	mov    QWORD PTR [rsp+0x118],r12
    304d:	mov    QWORD PTR [rsp+0x160],rsi
    3055:	mov    rsi,QWORD PTR [rsp+0x1d8]
    305d:	mov    QWORD PTR [rsp+0x170],rdx
    3065:	mov    QWORD PTR [rsp+0x180],rsi
    306d:	mov    rsi,QWORD PTR [rsp+0x1e0]
    3075:	mov    QWORD PTR [rsp+0x198],rbx
    307d:	mov    QWORD PTR [rsp+0x1a0],rsi
    3085:	mov    rsi,QWORD PTR [rsp+0x1e8]
    308d:	mov    QWORD PTR [rsp+0x1a8],rsi
    3095:	mov    esi,0x8
    309a:	jmp    ac8 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0xac8>
                        __m256 rl0 = load_cvt8(p.SUB + rb[0] + xf);
    309f:	lea    edi,[rsi+0x10]
                        xf += 8;
    30a2:	add    esi,0x18
                            __m256 v = _mm256_loadu_ps(vp0 + xf);
    30a5:	mov    r14,QWORD PTR [rsp+0x1a0]
                        xf += 8;
    30ad:	mov    DWORD PTR [rsp+0x1a8],esi
                            __m256 v = _mm256_loadu_ps(vp0 + xf);
    30b4:	lea    r11,[rdi*4+0x0]
                        __m256 rl0 = load_cvt8(p.SUB + rb[0] + xf);
    30bc:	lea    r10,[rcx+rdi*1]
                        __m256 rl1 = load_cvt8(p.SUB + rb[1] + xf);
    30c0:	lea    r9,[r13+rdi*1+0x0]
                            __m256 v = _mm256_loadu_ps(vp0 + xf);
    30c5:	lea    r8,[r14+r11*1]
                        __m256 rl2 = load_cvt8(p.SUB + rb[2] + xf);
    30c9:	add    rdi,rax
                            __m256 v = _mm256_loadu_ps(vp1 + xf);
    30cc:	add    r11,QWORD PTR [rsp+0x198]
    30d4:	mov    rsi,QWORD PTR [rsp+0x1d0]
    30dc:	vpmovzxbd ymm14,QWORD PTR [rsi+r10*1]
    30e2:	vpmovzxbd ymm8,QWORD PTR [rsi+r10*1+0x3]
    30e9:	vpmovzxbd ymm13,QWORD PTR [rsi+r9*1]
    30ef:	vpmovzxbd ymm12,QWORD PTR [rsi+r9*1+0x3]
  return (__m256)__builtin_ia32_cvtdq2ps256 ((__v8si) __A);
    30f6:	vcvtdq2ps ymm14,ymm14
    30fb:	vfmadd213ps ymm14,ymm0,YMMWORD PTR [r8]
    3100:	vcvtdq2ps ymm8,ymm8
    3105:	vcvtdq2ps ymm13,ymm13
    310a:	vcvtdq2ps ymm12,ymm12
    310f:	vfmadd132ps ymm8,ymm14,ymm1
    3114:	vpmovzxbd ymm14,QWORD PTR [rsi+rdi*1]
    311a:	vcvtdq2ps ymm14,ymm14
    311f:	vfmadd231ps ymm8,ymm2,ymm13
    3124:	vfmadd231ps ymm8,ymm3,ymm12
  *(__m256_u *)__P = __A;
    3129:	vmovups YMMWORD PTR [r8],ymm8
    312e:	vpmovzxbd ymm8,QWORD PTR [rsi+rdi*1+0x3]
    3135:	vfmadd213ps ymm13,ymm0,YMMWORD PTR [r11]
  return (__m256)__builtin_ia32_cvtdq2ps256 ((__v8si) __A);
    313a:	vcvtdq2ps ymm8,ymm8
    313f:	vfmadd132ps ymm12,ymm13,ymm1
    3144:	vfmadd231ps ymm12,ymm2,ymm14
    3149:	vfmadd132ps ymm8,ymm12,ymm3
  *(__m256_u *)__P = __A;
    314e:	vmovups YMMWORD PTR [r11],ymm8
                        xf += 8;
    3153:	jmp    10a9 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x10a9>
    3158:	mov    edi,DWORD PTR [rsp+0x1e0]
    315f:	cmp    edi,0x3
    3162:	jle    3752 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x3752>
    3168:	mov    rbx,QWORD PTR [rsp+0x1d0]
    3170:	mov    rsi,r11
    3173:	mov    r14,QWORD PTR [rsp+0x1e8]
    317b:	sub    edi,0x2
    317e:	mov    DWORD PTR [rsp+0x1b0],edi
    3185:	mov    rdi,QWORD PTR [rsp+0x1a0]
    318d:	shl    rsi,0x2
                        float s0l = p.SUB[rb[0]+xf+k], s0r = p.SUB[rb[0]+xf+k+3];
    3191:	mov    ecx,0x3
    3196:	lea    r11,[rbx+r13*1]
    319a:	lea    r8,[rbx+rax*1]
    319e:	mov    QWORD PTR [rsp+0x138],rax
    31a6:	movzx  r9d,BYTE PTR [r11]
    31aa:	movzx  r12d,BYTE PTR [r8]
    31ae:	lea    r10,[rbx+r14*1]
    31b2:	mov    QWORD PTR [rsp+0x150],rdx
    31ba:	mov    QWORD PTR [rsp+0x140],r13
    31c2:	movzx  r15d,BYTE PTR [r10]
    31c6:	add    rdi,rsi
    31c9:	mov    DWORD PTR [rsp+0x180],r12d
    31d1:	movzx  r12d,BYTE PTR [rbx+r14*1+0x1]
    31d7:	movzx  r14d,BYTE PTR [rbx+r14*1+0x2]
    31dd:	add    rsi,QWORD PTR [rsp+0x198]
    31e5:	mov    DWORD PTR [rsp+0x1c0],r9d
    31ed:	movzx  r9d,BYTE PTR [rbx+r13*1+0x1]
    31f3:	mov    DWORD PTR [rsp+0x160],r14d
    31fb:	movzx  r14d,BYTE PTR [rbx+r13*1+0x2]
    3201:	mov    DWORD PTR [rsp+0x170],r9d
    3209:	movzx  r9d,BYTE PTR [rbx+rax*1+0x1]
    320f:	mov    r13d,DWORD PTR [rsp+0x180]
    3217:	mov    DWORD PTR [rsp+0x1d8],r9d
    321f:	movzx  r9d,BYTE PTR [rbx+rax*1+0x2]
    3225:	mov    edx,DWORD PTR [rsp+0x170]
    322c:	mov    ebx,DWORD PTR [rsp+0x160]
    3233:	vcvtusi2ss xmm8,xmm10,r15d
                        float s1l = p.SUB[rb[1]+xf+k], s1r = p.SUB[rb[1]+xf+k+3];
    3239:	movzx  eax,BYTE PTR [r11+rcx*1]
                        float s0l = p.SUB[rb[0]+xf+k], s0r = p.SUB[rb[0]+xf+k+3];
    323e:	movzx  r15d,BYTE PTR [r10+rcx*1]
    3243:	vmovaps xmm16,xmm6
                        float s2l = p.SUB[rb[2]+xf+k], s2r = p.SUB[rb[2]+xf+k+3];
    3249:	vcvtusi2ss xmm12,xmm10,r13d
    324f:	movzx  r13d,BYTE PTR [r8+rcx*1]
    3254:	mov    QWORD PTR [rsp+0x180],rcx
    325c:	add    rdi,0xc
                        float s1l = p.SUB[rb[1]+xf+k], s1r = p.SUB[rb[1]+xf+k+3];
    3260:	vcvtusi2ss xmm13,xmm10,DWORD PTR [rsp+0x1c0]
    3268:	mov    DWORD PTR [rsp+0x1c0],eax
    326f:	add    rsi,0xc
                        float s0l = p.SUB[rb[0]+xf+k], s0r = p.SUB[rb[0]+xf+k+3];
    3273:	vmovaps xmm15,xmm8
                        float s1l = p.SUB[rb[1]+xf+k], s1r = p.SUB[rb[1]+xf+k+3];
    3278:	vcvtusi2ss xmm8,xmm10,eax
                        float s2l = p.SUB[rb[2]+xf+k], s2r = p.SUB[rb[2]+xf+k+3];
    327e:	movzx  eax,BYTE PTR [r8+rcx*1+0x1]
    3284:	vmovaps xmm14,xmm12
                        float s0l = p.SUB[rb[0]+xf+k], s0r = p.SUB[rb[0]+xf+k+3];
    3289:	vcvtusi2ss xmm12,xmm10,r15d
    328f:	vfmadd213ss xmm16,xmm13,DWORD PTR [rdi-0xc]
                        vp0[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    3296:	vmulss xmm18,xmm7,xmm8
    329c:	vfmadd132ss xmm12,xmm18,xmm5
    32a2:	vaddss xmm12,xmm12,xmm16
    32a8:	vmovaps xmm16,xmm6
    32ae:	vfmadd231ss xmm12,xmm4,xmm15
    32b3:	vmovss DWORD PTR [rdi-0xc],xmm12
                        float s2l = p.SUB[rb[2]+xf+k], s2r = p.SUB[rb[2]+xf+k+3];
    32b8:	vcvtusi2ss xmm12,xmm10,r13d
    32be:	vfmadd213ss xmm13,xmm4,DWORD PTR [rsi-0xc]
                        vp1[xf+k] += p.A*s1l + p.B*s1r + p.C*s2l + p.D*s2r;
    32c4:	vmulss xmm12,xmm12,xmm7
    32c8:	vfmadd132ss xmm8,xmm12,xmm5
                        float s2l = p.SUB[rb[2]+xf+k], s2r = p.SUB[rb[2]+xf+k+3];
    32cd:	vcvtusi2ss xmm12,xmm10,DWORD PTR [rsp+0x1d8]
    32d5:	mov    DWORD PTR [rsp+0x1d8],eax
                        vp1[xf+k] += p.A*s1l + p.B*s1r + p.C*s2l + p.D*s2r;
    32dc:	vaddss xmm8,xmm8,xmm13
                        float s1l = p.SUB[rb[1]+xf+k], s1r = p.SUB[rb[1]+xf+k+3];
    32e1:	vcvtusi2ss xmm13,xmm10,edx
    32e7:	movzx  edx,BYTE PTR [r11+rcx*1+0x1]
                        vp1[xf+k] += p.A*s1l + p.B*s1r + p.C*s2l + p.D*s2r;
    32ed:	vfmadd231ss xmm8,xmm6,xmm14
                        float s2l = p.SUB[rb[2]+xf+k], s2r = p.SUB[rb[2]+xf+k+3];
    32f2:	vmovaps xmm14,xmm12
                        vp1[xf+k] += p.A*s1l + p.B*s1r + p.C*s2l + p.D*s2r;
    32f7:	vmovss DWORD PTR [rsi-0xc],xmm8
                        float s0l = p.SUB[rb[0]+xf+k], s0r = p.SUB[rb[0]+xf+k+3];
    32fc:	vcvtusi2ss xmm8,xmm10,r12d
    3302:	movzx  r12d,BYTE PTR [r10+rcx*1+0x1]
    3308:	vfmadd213ss xmm16,xmm13,DWORD PTR [rdi-0x8]
    330f:	vcvtusi2ss xmm12,xmm10,r12d
    3315:	vmovaps xmm15,xmm8
                        float s1l = p.SUB[rb[1]+xf+k], s1r = p.SUB[rb[1]+xf+k+3];
    331a:	vcvtusi2ss xmm8,xmm10,edx
                        vp0[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    3320:	vmulss xmm18,xmm7,xmm8
    3326:	vfmadd132ss xmm12,xmm18,xmm5
    332c:	vaddss xmm12,xmm12,xmm16
    3332:	vmovaps xmm16,xmm6
    3338:	vfmadd231ss xmm12,xmm4,xmm15
    333d:	vmovss DWORD PTR [rdi-0x8],xmm12
                        float s2l = p.SUB[rb[2]+xf+k], s2r = p.SUB[rb[2]+xf+k+3];
    3342:	vcvtusi2ss xmm12,xmm10,eax
    3348:	vfmadd213ss xmm13,xmm4,DWORD PTR [rsi-0x8]
                        vp1[xf+k] += p.A*s1l + p.B*s1r + p.C*s2l + p.D*s2r;
    334e:	vmulss xmm12,xmm12,xmm7
    3352:	vfmadd132ss xmm8,xmm12,xmm5
                        float s2l = p.SUB[rb[2]+xf+k], s2r = p.SUB[rb[2]+xf+k+3];
    3357:	vcvtusi2ss xmm12,xmm10,r9d
    335d:	movzx  r9d,BYTE PTR [r8+rcx*1+0x2]
                        vp1[xf+k] += p.A*s1l + p.B*s1r + p.C*s2l + p.D*s2r;
    3363:	vaddss xmm8,xmm8,xmm13
                        float s1l = p.SUB[rb[1]+xf+k], s1r = p.SUB[rb[1]+xf+k+3];
    3368:	vcvtusi2ss xmm13,xmm10,r14d
    336e:	movzx  r14d,BYTE PTR [r11+rcx*1+0x2]
                        vp1[xf+k] += p.A*s1l + p.B*s1r + p.C*s2l + p.D*s2r;
    3374:	vfmadd231ss xmm8,xmm6,xmm14
                        float s2l = p.SUB[rb[2]+xf+k], s2r = p.SUB[rb[2]+xf+k+3];
    3379:	vmovaps xmm14,xmm12
                        vp1[xf+k] += p.A*s1l + p.B*s1r + p.C*s2l + p.D*s2r;
    337e:	vmovss DWORD PTR [rsi-0x8],xmm8
                        float s0l = p.SUB[rb[0]+xf+k], s0r = p.SUB[rb[0]+xf+k+3];
    3383:	vcvtusi2ss xmm8,xmm10,ebx
    3389:	movzx  ebx,BYTE PTR [r10+rcx*1+0x2]
    338f:	add    rcx,0x3
    3393:	vfmadd213ss xmm16,xmm13,DWORD PTR [rdi-0x4]
    339a:	lea    eax,[rcx-0x2]
    339d:	vcvtusi2ss xmm12,xmm10,ebx
    33a3:	vmovaps xmm15,xmm8
                        float s1l = p.SUB[rb[1]+xf+k], s1r = p.SUB[rb[1]+xf+k+3];
    33a8:	vcvtusi2ss xmm8,xmm10,r14d
                        vp0[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    33ae:	vmulss xmm18,xmm7,xmm8
    33b4:	vfmadd132ss xmm12,xmm18,xmm5
    33ba:	vaddss xmm12,xmm12,xmm16
    33c0:	vfmadd231ss xmm12,xmm4,xmm15
    33c5:	vmovss DWORD PTR [rdi-0x4],xmm12
                        float s2l = p.SUB[rb[2]+xf+k], s2r = p.SUB[rb[2]+xf+k+3];
    33ca:	vcvtusi2ss xmm12,xmm10,r9d
    33d0:	vfmadd213ss xmm13,xmm4,DWORD PTR [rsi-0x4]
                        vp1[xf+k] += p.A*s1l + p.B*s1r + p.C*s2l + p.D*s2r;
    33d6:	vmulss xmm12,xmm12,xmm7
    33da:	vfmadd132ss xmm8,xmm12,xmm5
    33df:	vaddss xmm8,xmm8,xmm13
    33e4:	vfmadd231ss xmm8,xmm6,xmm14
    33e9:	vmovss DWORD PTR [rsi-0x4],xmm8
                    for (int k = 0; k < x_floats - xf; ++k) {
    33ee:	cmp    DWORD PTR [rsp+0x1b0],eax
    33f5:	jg     3233 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x3233>
    33fb:	mov    rdx,QWORD PTR [rsp+0x150]
    3403:	mov    r13,QWORD PTR [rsp+0x140]
    340b:	mov    rax,QWORD PTR [rsp+0x138]
    3413:	mov    edi,DWORD PTR [rsp+0x180]
                        float s1l = p.SUB[rb[1]+xf+k], s1r = p.SUB[rb[1]+xf+k+3];
    341a:	mov    rbx,QWORD PTR [rsp+0x1d0]
                        float s0l = p.SUB[rb[0]+xf+k], s0r = p.SUB[rb[0]+xf+k+3];
    3422:	mov    r8d,edi
    3425:	mov    r11,QWORD PTR [rsp+0x1e8]
                        float s1l = p.SUB[rb[1]+xf+k], s1r = p.SUB[rb[1]+xf+k+3];
    342d:	lea    rcx,[r8+r13*1]
                        vp0[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    3431:	mov    r12d,DWORD PTR [rsp+0x1a8]
    3439:	mov    r14,QWORD PTR [rsp+0x1a0]
                        float s1l = p.SUB[rb[1]+xf+k], s1r = p.SUB[rb[1]+xf+k+3];
    3441:	movzx  esi,BYTE PTR [rbx+rcx*1]
    3445:	movzx  ecx,BYTE PTR [rbx+rcx*1+0x3]
                        float s0l = p.SUB[rb[0]+xf+k], s0r = p.SUB[rb[0]+xf+k+3];
    344a:	lea    r9,[r8+r11*1]
                        vp1[xf+k] += p.A*s1l + p.B*s1r + p.C*s2l + p.D*s2r;
    344e:	mov    r15,QWORD PTR [rsp+0x198]
                        float s1l = p.SUB[rb[1]+xf+k], s1r = p.SUB[rb[1]+xf+k+3];
    3456:	vcvtusi2ss xmm13,xmm10,ecx
                        float s2l = p.SUB[rb[2]+xf+k], s2r = p.SUB[rb[2]+xf+k+3];
    345c:	lea    rcx,[r8+rax*1]
                        float s1l = p.SUB[rb[1]+xf+k], s1r = p.SUB[rb[1]+xf+k+3];
    3460:	vcvtusi2ss xmm14,xmm10,esi
                        float s2l = p.SUB[rb[2]+xf+k], s2r = p.SUB[rb[2]+xf+k+3];
    3466:	movzx  esi,BYTE PTR [rbx+rcx*1]
    346a:	movzx  ecx,BYTE PTR [rbx+rcx*1+0x3]
    346f:	vcvtusi2ss xmm8,xmm10,esi
                        vp0[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    3475:	vmulss xmm18,xmm6,xmm14
                        vp1[xf+k] += p.A*s1l + p.B*s1r + p.C*s2l + p.D*s2r;
    347b:	vmulss xmm15,xmm6,xmm8
                        float s2l = p.SUB[rb[2]+xf+k], s2r = p.SUB[rb[2]+xf+k+3];
    3480:	vcvtusi2ss xmm8,xmm10,ecx
                        vp0[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    3486:	lea    ecx,[rdi+r12*1]
    348a:	lea    r8,[rcx*4+0x0]
                        float s0l = p.SUB[rb[0]+xf+k], s0r = p.SUB[rb[0]+xf+k+3];
    3492:	movzx  ecx,BYTE PTR [rbx+r9*1]
                        float s2l = p.SUB[rb[2]+xf+k], s2r = p.SUB[rb[2]+xf+k+3];
    3497:	vmovaps xmm12,xmm8
                        float s0l = p.SUB[rb[0]+xf+k], s0r = p.SUB[rb[0]+xf+k+3];
    349c:	vcvtusi2ss xmm8,xmm10,ecx
    34a2:	movzx  ecx,BYTE PTR [rbx+r9*1+0x3]
                    for (int k = 0; k < x_floats - xf; ++k) {
    34a8:	lea    r9d,[rdi+0x1]
                        float s0l = p.SUB[rb[0]+xf+k], s0r = p.SUB[rb[0]+xf+k+3];
    34ac:	vcvtusi2ss xmm16,xmm10,ecx
    34b2:	vfmadd213ss xmm8,xmm4,DWORD PTR [r14+r8*1]
    34b8:	vfmadd132ss xmm16,xmm18,xmm5
                        vp0[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    34be:	vfmadd231ss xmm8,xmm7,xmm13
    34c3:	vfmadd132ss xmm13,xmm15,xmm5
    34c8:	vaddss xmm8,xmm8,xmm16
    34ce:	vmovss DWORD PTR [r14+r8*1],xmm8
                        vp1[xf+k] += p.A*s1l + p.B*s1r + p.C*s2l + p.D*s2r;
    34d4:	vmovaps xmm8,xmm12
    34d9:	vfmadd213ss xmm14,xmm4,DWORD PTR [r15+r8*1]
    34df:	vfmadd132ss xmm8,xmm14,xmm7
    34e4:	vaddss xmm8,xmm8,xmm13
    34e9:	vmovss DWORD PTR [r15+r8*1],xmm8
                    for (int k = 0; k < x_floats - xf; ++k) {
    34ef:	cmp    r9d,DWORD PTR [rsp+0x1e0]
    34f7:	jge    229e <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x229e>
                        float s0l = p.SUB[rb[0]+xf+k], s0r = p.SUB[rb[0]+xf+k+3];
    34fd:	mov    r8d,r9d
                    for (int k = 0; k < x_floats - xf; ++k) {
    3500:	add    edi,0x2
                        float s1l = p.SUB[rb[1]+xf+k], s1r = p.SUB[rb[1]+xf+k+3];
    3503:	lea    rcx,[r8+r13*1]
                        float s0l = p.SUB[rb[0]+xf+k], s0r = p.SUB[rb[0]+xf+k+3];
    3507:	lea    r10,[r8+r11*1]
                        float s1l = p.SUB[rb[1]+xf+k], s1r = p.SUB[rb[1]+xf+k+3];
    350b:	movzx  esi,BYTE PTR [rbx+rcx*1]
    350f:	movzx  ecx,BYTE PTR [rbx+rcx*1+0x3]
    3514:	vcvtusi2ss xmm13,xmm10,ecx
                        float s2l = p.SUB[rb[2]+xf+k], s2r = p.SUB[rb[2]+xf+k+3];
    351a:	lea    rcx,[r8+rax*1]
                        float s1l = p.SUB[rb[1]+xf+k], s1r = p.SUB[rb[1]+xf+k+3];
    351e:	vcvtusi2ss xmm14,xmm10,esi
                        float s2l = p.SUB[rb[2]+xf+k], s2r = p.SUB[rb[2]+xf+k+3];
    3524:	movzx  esi,BYTE PTR [rbx+rcx*1]
    3528:	movzx  ecx,BYTE PTR [rbx+rcx*1+0x3]
    352d:	vcvtusi2ss xmm8,xmm10,esi
                        vp0[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    3533:	vmulss xmm18,xmm6,xmm14
                        vp1[xf+k] += p.A*s1l + p.B*s1r + p.C*s2l + p.D*s2r;
    3539:	vmulss xmm15,xmm6,xmm8
                        float s2l = p.SUB[rb[2]+xf+k], s2r = p.SUB[rb[2]+xf+k+3];
    353e:	vcvtusi2ss xmm8,xmm10,ecx
                        vp0[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    3544:	lea    ecx,[r12+r9*1]
    3548:	lea    r8,[rcx*4+0x0]
                        float s0l = p.SUB[rb[0]+xf+k], s0r = p.SUB[rb[0]+xf+k+3];
    3550:	movzx  ecx,BYTE PTR [rbx+r10*1]
                        float s2l = p.SUB[rb[2]+xf+k], s2r = p.SUB[rb[2]+xf+k+3];
    3555:	vmovaps xmm12,xmm8
                        float s0l = p.SUB[rb[0]+xf+k], s0r = p.SUB[rb[0]+xf+k+3];
    355a:	vcvtusi2ss xmm8,xmm10,ecx
    3560:	movzx  ecx,BYTE PTR [rbx+r10*1+0x3]
    3566:	vcvtusi2ss xmm16,xmm10,ecx
    356c:	vfmadd213ss xmm8,xmm4,DWORD PTR [r14+r8*1]
    3572:	vfmadd132ss xmm16,xmm18,xmm5
                        vp0[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    3578:	vfmadd231ss xmm8,xmm7,xmm13
    357d:	vfmadd132ss xmm13,xmm15,xmm5
    3582:	vaddss xmm8,xmm8,xmm16
    3588:	vmovss DWORD PTR [r14+r8*1],xmm8
                        vp1[xf+k] += p.A*s1l + p.B*s1r + p.C*s2l + p.D*s2r;
    358e:	vmovaps xmm8,xmm12
    3593:	vfmadd213ss xmm14,xmm4,DWORD PTR [r15+r8*1]
    3599:	vfmadd132ss xmm8,xmm14,xmm7
    359e:	vaddss xmm8,xmm8,xmm13
    35a3:	vmovss DWORD PTR [r15+r8*1],xmm8
                    for (int k = 0; k < x_floats - xf; ++k) {
    35a9:	cmp    edi,DWORD PTR [rsp+0x1e0]
    35b0:	jge    229e <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x229e>
                        float s0l = p.SUB[rb[0]+xf+k], s0r = p.SUB[rb[0]+xf+k+3];
    35b6:	mov    esi,edi
                        float s1l = p.SUB[rb[1]+xf+k], s1r = p.SUB[rb[1]+xf+k+3];
    35b8:	add    r13,rsi
                        float s2l = p.SUB[rb[2]+xf+k], s2r = p.SUB[rb[2]+xf+k+3];
    35bb:	add    rax,rsi
                        float s0l = p.SUB[rb[0]+xf+k], s0r = p.SUB[rb[0]+xf+k+3];
    35be:	lea    r8,[r11+rsi*1]
                        float s1l = p.SUB[rb[1]+xf+k], s1r = p.SUB[rb[1]+xf+k+3];
    35c2:	movzx  ecx,BYTE PTR [rbx+r13*1]
    35c7:	vcvtusi2ss xmm14,xmm10,ecx
    35cd:	movzx  ecx,BYTE PTR [rbx+r13*1+0x3]
    35d3:	vcvtusi2ss xmm13,xmm10,ecx
                        float s2l = p.SUB[rb[2]+xf+k], s2r = p.SUB[rb[2]+xf+k+3];
    35d9:	movzx  ecx,BYTE PTR [rbx+rax*1]
    35dd:	movzx  eax,BYTE PTR [rbx+rax*1+0x3]
    35e2:	vcvtusi2ss xmm8,xmm10,ecx
                        vp1[xf+k] += p.A*s1l + p.B*s1r + p.C*s2l + p.D*s2r;
    35e8:	vmulss xmm15,xmm6,xmm8
                        float s2l = p.SUB[rb[2]+xf+k], s2r = p.SUB[rb[2]+xf+k+3];
    35ed:	vcvtusi2ss xmm8,xmm10,eax
                        vp0[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    35f3:	lea    eax,[r12+rdi*1]
    35f7:	lea    rsi,[rax*4+0x0]
                        float s0l = p.SUB[rb[0]+xf+k], s0r = p.SUB[rb[0]+xf+k+3];
    35ff:	movzx  eax,BYTE PTR [rbx+r8*1]
                        float s2l = p.SUB[rb[2]+xf+k], s2r = p.SUB[rb[2]+xf+k+3];
    3604:	vmovaps xmm12,xmm8
                        float s0l = p.SUB[rb[0]+xf+k], s0r = p.SUB[rb[0]+xf+k+3];
    3609:	vcvtusi2ss xmm8,xmm10,eax
    360f:	movzx  eax,BYTE PTR [rbx+r8*1+0x3]
    3615:	vfmadd213ss xmm8,xmm4,DWORD PTR [r14+rsi*1]
    361b:	jmp    225b <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x225b>
                    if (xf + 8 <= x_floats) {
    3620:	cmp    r14d,0x7
    3624:	jg     3703 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x3703>
    362a:	mov    QWORD PTR [rsp+0x1d8],0x0
    3636:	mov    rdi,QWORD PTR [rdx+0x28]
    363a:	mov    DWORD PTR [rsp+0x1e0],r14d
                    int xf = 0;
    3642:	mov    DWORD PTR [rsp+0x1a8],0x0
    364d:	mov    QWORD PTR [rsp+0x1d0],rdi
    3655:	mov    r11,QWORD PTR [rsp+0x1d8]
    365d:	jmp    10e7 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x10e7>
                    for (int k = 0; k < x_floats - xf; ++k) {
    3662:	mov    ecx,DWORD PTR [rsp+0xc0]
    3669:	lea    r8,[r14+rbx*4]
    366d:	xor    eax,eax
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
    366f:	movzx  r9d,BYTE PTR [rdi+rax*1]
    3674:	vcvtusi2ss xmm0,xmm10,r9d
    367a:	movzx  r9d,BYTE PTR [rdi+rax*1+0x3]
    3680:	vmovaps xmm2,xmm0
    3684:	vcvtusi2ss xmm0,xmm10,r9d
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
    368a:	movzx  r9d,BYTE PTR [rsi+rax*1]
    368f:	vfmadd213ss xmm2,xmm4,DWORD PTR [r8+rax*4]
    3695:	vcvtusi2ss xmm1,xmm10,r9d
    369b:	movzx  r9d,BYTE PTR [rsi+rax*1+0x3]
                        vp[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    36a1:	vmulss xmm1,xmm1,xmm6
    36a5:	vfmadd231ss xmm1,xmm5,xmm0
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
    36aa:	vcvtusi2ss xmm0,xmm10,r9d
                        vp[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    36b0:	vfmadd132ss xmm0,xmm2,xmm7
    36b5:	vaddss xmm0,xmm0,xmm1
    36b9:	vmovss DWORD PTR [r8+rax*4],xmm0
                    for (int k = 0; k < x_floats - xf; ++k) {
    36bf:	inc    rax
    36c2:	cmp    ecx,eax
    36c4:	jg     366f <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x366f>
            for (const SubParams& p : params) {
    36c6:	add    rdx,0x30
    36ca:	cmp    QWORD PTR [rsp+0xd0],rdx
    36d2:	jne    578 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x578>
    36d8:	jmp    2e72 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x2e72>
                    for (int k = 0; k < x_floats - xf; ++k) {
    36dd:	xor    ecx,ecx
    36df:	jmp    18d3 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x18d3>
                        float s0l = p.SUB[rb[0]+xf+k], s0r = p.SUB[rb[0]+xf+k+3];
    36e4:	xor    r9d,r9d
                    for (int k = 0; k < x_floats - xf; ++k) {
    36e7:	xor    r8d,r8d
    36ea:	jmp    151e <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x151e>
                    if (xf + 8 <= x_floats) {
    36ef:	cmp    DWORD PTR [rsp+0x1f0],0x7
    36f7:	jg     373e <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x373e>
                    int xf = 0;
    36f9:	xor    r15d,r15d
    36fc:	xor    ebx,ebx
    36fe:	jmp    249c <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x249c>
    3703:	mov    r8,rsi
    3706:	mov    rsi,QWORD PTR [rdx+0x28]
    370a:	mov    r11,r9
                    if (xf + 8 <= x_floats) {
    370d:	mov    DWORD PTR [rsp+0x1a8],0x8
    3718:	mov    rdi,rax
    371b:	mov    r9,r13
    371e:	mov    r10,rcx
    3721:	mov    QWORD PTR [rsp+0x1d0],rsi
    3729:	jmp    30d4 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x30d4>
                    for (int k = 0; k < x_floats - xf; ++k) {
    372e:	xor    eax,eax
    3730:	jmp    2939 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x2939>
                    int xf = 0;
    3735:	xor    edi,edi
                    for (int k = 0; k < x_floats - xf; ++k) {
    3737:	xor    esi,esi
    3739:	jmp    2757 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x2757>
                    if (xf + 8 <= x_floats) {
    373e:	mov    rsi,r14
    3741:	mov    r10,r9
    3744:	mov    rcx,rdi
    3747:	mov    r15d,0x8
    374d:	jmp    2433 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x2433>
                        float s0l = p.SUB[rb[0]+xf+k], s0r = p.SUB[rb[0]+xf+k+3];
    3752:	xor    edi,edi
    3754:	jmp    341a <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x341a>
    3759:	mov    r15,QWORD PTR [rsp+0x18]
    375e:	vzeroupper
	_GLIBCXX_OPERATOR_DELETE(_GLIBCXX_SIZED_DEALLOC(__p, __n));
    3761:	mov    rdi,QWORD PTR [rsp+0xd8]
    3769:	mov    esi,0x2fa00
    376e:	call   3773 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x3773>
    3773:	mov    rax,QWORD PTR [rsp+0x50]
    3778:	test   rax,rax
    377b:	je     378a <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x378a>
    377d:	mov    rsi,QWORD PTR [rsp+0x38]
    3782:	mov    rdi,rax
    3785:	call   378a <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x378a>
    378a:	mov    rdi,QWORD PTR [rsp+0x80]
    3792:	test   rdi,rdi
    3795:	je     37a2 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x37a2>
	ptrdiff_t __n = _M_impl._M_end_of_storage - _M_impl._M_start;
    3797:	mov    rsi,r15
    379a:	sub    rsi,rdi
    379d:	call   37a2 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x37a2>
            }
        }
    }

    return output;
}
    37a2:	mov    rax,QWORD PTR [rsp+0x40]
    37a7:	lea    rsp,[rbp-0x28]
    37ab:	pop    rbx
    37ac:	pop    r12
    37ae:	pop    r13
    37b0:	pop    r14
    37b2:	pop    r15
    37b4:	pop    rbp
    37b5:	ret
        for (const auto& p : params) {
    37b6:	mov    rbx,QWORD PTR [rsp+0xd0]
	return __n != 0 ? _Tr::allocate(_M_impl, __n) : pointer();
    37be:	xor    edi,edi
    37c0:	cmp    QWORD PTR [rsp+0x80],rbx
    37c8:	jne    282 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x282>
        for (int y = 0; y < h; ++y) {
    37ce:	mov    r11d,DWORD PTR [rsp+0x5c]
    37d3:	test   r11d,r11d
    37d6:	jle    394 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x394>
    37dc:	mov    r10d,DWORD PTR [rsp+0x90]
    37e4:	test   r10d,r10d
    37e7:	jg     2ea <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x2ea>
    37ed:	jmp    394 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x394>
    37f2:	nop    WORD PTR [rax+rax*1+0x0]
    const int w = static_cast<int>(width);
    37f8:	mov    eax,DWORD PTR [rsp+0xb8]
	: _M_start(), _M_finish(), _M_end_of_storage()
    37ff:	mov    QWORD PTR [rsp+0x80],0x0
    380b:	xor    r15d,r15d
    380e:	mov    DWORD PTR [rsp+0x90],eax
    const int h = static_cast<int>(height);
    3815:	mov    eax,DWORD PTR [rsp+0x1e8]
    381c:	mov    DWORD PTR [rsp+0x5c],eax
    for (auto& sub : subapertures) {
    3820:	cmp    QWORD PTR [rsp+0x1f0],r14
    3828:	jne    c7 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0xc7>
    382e:	mov    QWORD PTR [rsp+0xd0],0x0
	return __n != 0 ? _Tr::allocate(_M_impl, __n) : pointer();
    383a:	mov    QWORD PTR [rsp+0x50],0x0
    3843:	jmp    21f <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x21f>
	ptrdiff_t __dif = this->_M_impl._M_finish - this->_M_impl._M_start;
    3848:	mov    r13,r15
    384b:	movabs rax,0xaaaaaaaaaaaaaaab
    3855:	sub    r13,QWORD PTR [rsp+0x80]
    385d:	mov    rdx,r13
    3860:	sar    rdx,0x4
    3864:	imul   rdx,rax
	if (max_size() - size() < __n)
    3868:	movabs rax,0x2aaaaaaaaaaaaaa
    3872:	cmp    rdx,rax
    3875:	je     387b <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x387b>
      if (__a < __b)
    387b:	test   rdx,rdx
    387e:	mov    eax,0x1
    3883:	mov    DWORD PTR [rsp+0x190],r11d
    388b:	cmovne rax,rdx
    388f:	mov    DWORD PTR [rsp+0x160],r10d
    3897:	mov    DWORD PTR [rsp+0x170],r8d
	const size_type __len = size() + (std::max)(size(), __n);
    389f:	add    rax,rdx
	return (__len < size() || __len > max_size()) ? max_size() : __len;
    38a2:	movabs rdx,0x2aaaaaaaaaaaaaa
    38ac:	mov    DWORD PTR [rsp+0x180],ecx
    38b3:	cmp    rax,rdx
    38b6:	mov    DWORD PTR [rsp+0x1b0],esi
    38bd:	cmova  rax,rdx
    38c1:	mov    DWORD PTR [rsp+0x1c0],r9d
      allocate(size_type __n, const void* = static_cast<const void*>(0))
    38c9:	vmovss DWORD PTR [rsp+0x198],xmm3
	  return static_cast<_Tp*>(_GLIBCXX_OPERATOR_NEW(__n * sizeof(_Tp)));
    38d2:	lea    rax,[rax+rax*2]
    38d6:	vmovss DWORD PTR [rsp+0x1a0],xmm0
    38df:	shl    rax,0x4
    38e3:	vmovss DWORD PTR [rsp+0x1a8],xmm1
    38ec:	mov    rdi,rax
    38ef:	mov    QWORD PTR [rsp+0x1e0],rax
    38f7:	vmovss DWORD PTR [rsp+0x1d0],xmm2
    3900:	call   3905 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x3905>
	{ ::new((void *)__p) _Up(std::forward<_Args>(__args)...); }
    3905:	vmovss xmm0,DWORD PTR [rsp+0x1a0]
    390e:	vmovss xmm2,DWORD PTR [rsp+0x1d0]
    3917:	mov    QWORD PTR [rax+r13*1+0x28],rbx
	  return static_cast<_Tp*>(_GLIBCXX_OPERATOR_NEW(__n * sizeof(_Tp)));
    391c:	mov    r12,rax
	{ ::new((void *)__p) _Up(std::forward<_Args>(__args)...); }
    391f:	mov    r9d,DWORD PTR [rsp+0x1c0]
    3927:	mov    esi,DWORD PTR [rsp+0x1b0]
    392e:	vinsertps xmm0,xmm0,DWORD PTR [rsp+0x198],0x10
    3939:	vinsertps xmm2,xmm2,DWORD PTR [rsp+0x1a8],0x10
    3944:	mov    ecx,DWORD PTR [rsp+0x180]
    394b:	mov    r10d,DWORD PTR [rsp+0x160]
    3953:	mov    DWORD PTR [rax+r13*1],r9d
    3957:	mov    r8d,DWORD PTR [rsp+0x170]
    395f:	mov    r11d,DWORD PTR [rsp+0x190]
    3967:	vmovlhps xmm2,xmm2,xmm0
    396b:	mov    DWORD PTR [rax+r13*1+0x4],esi
    3970:	mov    DWORD PTR [rax+r13*1+0x18],ecx
    3975:	mov    DWORD PTR [rax+r13*1+0x1c],r10d
    397a:	mov    DWORD PTR [rax+r13*1+0x20],r8d
    397f:	mov    DWORD PTR [rax+r13*1+0x24],r11d
    3984:	vmovups XMMWORD PTR [rax+r13*1+0x8],xmm2
    __relocate_a_1(_Tp* __first, _Tp* __last,
		   _Tp* __result,
		   [[__maybe_unused__]] allocator<_Up>& __alloc) noexcept
    {
      ptrdiff_t __count = __last - __first;
      if (__count > 0)
    398b:	test   r13,r13
    398e:	je     39a3 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x39a3>
	      __gnu_cxx::__normal_iterator<_Tp*, void> __out(__result);
	      __out = std::__relocate_a_1(__first, __last, __out, __alloc);
	      return __out.base();
	    }
#endif
	  __builtin_memcpy(__result, __first, __count * sizeof(_Tp));
    3990:	mov    rsi,QWORD PTR [rsp+0x80]
    3998:	mov    rdx,r13
    399b:	mov    rdi,rax
    399e:	call   39a3 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x39a3>
	  if (_M_storage)
    39a3:	mov    rdi,QWORD PTR [rsp+0x80]
	  {
	    // Relocation cannot throw.
	    __new_finish = std::__relocate_a(__old_start, __old_finish,
					     __new_start,
					     _M_get_Tp_allocator());
	    ++__new_finish;
    39ab:	lea    rax,[r12+r13*1+0x30]
    39b0:	mov    QWORD PTR [rsp+0xd0],rax
    39b8:	test   rdi,rdi
    39bb:	je     39c8 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x39c8>
	    // New storage has been fully initialized, destroy the old elements.
	    __guard_elts._M_first = __old_start;
	    __guard_elts._M_last = __old_finish;
	  }
	__guard._M_storage = __old_start;
	__guard._M_len = this->_M_impl._M_end_of_storage - __old_start;
    39bd:	mov    rsi,r15
    39c0:	sub    rsi,rdi
	_GLIBCXX_OPERATOR_DELETE(_GLIBCXX_SIZED_DEALLOC(__p, __n));
    39c3:	call   39c8 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x39c8>
      // deallocate should be called before assignments to _M_impl,
      // to avoid call-clobbering

      this->_M_impl._M_start = __new_start;
      this->_M_impl._M_finish = __new_finish;
      this->_M_impl._M_end_of_storage = __new_start + __len;
    39c8:	mov    r15,QWORD PTR [rsp+0x1e0]
      this->_M_impl._M_start = __new_start;
    39d0:	mov    QWORD PTR [rsp+0x80],r12
      this->_M_impl._M_end_of_storage = __new_start + __len;
    39d8:	add    r15,r12
    39db:	jmp    1cd <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x1cd>
    output.data.assign(width * height * 3, 0);
    39e0:	lea    r13,[rax+rax*2]
	if (__n > _S_max_size(_Tp_alloc_type(__a)))
    39e4:	test   r13,r13
    39e7:	js     39ed <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x39ed>
	  return static_cast<_Tp*>(_GLIBCXX_OPERATOR_NEW(__n * sizeof(_Tp)));
    39ed:	mov    rdi,r13
    39f0:	call   39f5 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x39f5>
	this->_M_impl._M_end_of_storage = this->_M_impl._M_start + __n;
    39f5:	lea    r8,[rax+r13*1]
		      __builtin_memset(__dest, (unsigned char)__x, __n);
    39f9:	xor    esi,esi
    39fb:	mov    rdx,r13
    39fe:	mov    rdi,rax
    3a01:	mov    QWORD PTR [rsp+0x1f0],r8
    3a09:	call   3a0e <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x3a0e>
	  _M_finish = __x._M_finish;
    3a0e:	mov    r8,QWORD PTR [rsp+0x1f0]
    3a16:	mov    rcx,rax
	  _M_start = __x._M_start;
    3a19:	mov    rax,QWORD PTR [rsp+0x40]
    3a1e:	mov    QWORD PTR [rax+0x10],rcx
	  _M_finish = __x._M_finish;
    3a22:	mov    QWORD PTR [rax+0x18],r8
	  _M_end_of_storage = __x._M_end_of_storage;
    3a26:	mov    QWORD PTR [rax+0x20],r8
	ptrdiff_t __dif = this->_M_impl._M_finish - this->_M_impl._M_start;
    3a2a:	mov    rax,QWORD PTR [r12+0x8]
    3a2f:	mov    QWORD PTR [rsp+0x1f0],rax
      if (this->capacity() < __n)
    3a37:	sub    rax,r14
    3a3a:	mov    r12,rax
    3a3d:	jne    8c <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x8c>
	: _M_start(), _M_finish(), _M_end_of_storage()
    3a43:	mov    QWORD PTR [rsp+0x80],0x0
    3a4f:	xor    r15d,r15d
    3a52:	jmp    a0 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0xa0>
        for (int y = 0; y < h; ++y) {
    3a57:	mov    edx,DWORD PTR [rsp+0x5c]
    3a5b:	test   edx,edx
    3a5d:	jle    38c <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x38c>
    3a63:	mov    eax,DWORD PTR [rsp+0x90]
    3a6a:	test   eax,eax
    3a6c:	jg     2ea <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x2ea>
    3a72:	jmp    38c <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x38c>
    for (auto& sub : subapertures) {
    3a77:	mov    rax,QWORD PTR [rsp+0x80]
    3a7f:	mov    QWORD PTR [rsp+0xd0],rax
    3a87:	jmp    1df <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x1df>
        for (int tx = 0; tx < w; tx += TILE_W) {
    3a8c:	xor    eax,eax
    for (int ty = 0; ty < h; ty += TILE_H) {
    3a8e:	mov    ebx,DWORD PTR [rsp+0x5c]
    3a92:	lea    rdx,[rax+0x8]
    3a96:	cmp    ebx,edx
    3a98:	jle    3761 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x3761>
    3a9e:	add    rax,0x10
    3aa2:	cmp    ebx,eax
    3aa4:	jg     3a8e <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x3a8e>
    3aa6:	jmp    3761 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x3761>
    3aab:	jmp    3ab0 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x3ab0>
    3ab0:	jmp    3ab5 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x3ab5>
    3ab5:	jmp    3aba <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x3aba>
    3aba:	mov    rbx,rax
    3abd:	vzeroupper
    3ac0:	jmp    3ac5 <.LC6+0x3ab9>

Disassembly of section .text.unlikely:

0000000000000000 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float) [clone .cold]>:
	  __throw_length_error(
   0:	lea    rdi,[rip+0x0]        # 7 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float) [clone .cold]+0x7>
   7:	call   c <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float) [clone .cold]+0xc>
	if (__p)
   c:	cmp    QWORD PTR [rsp+0x50],0x0
  12:	mov    r12,rax
  15:	jne    71 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float) [clone .cold]+0x71>
  17:	vzeroupper
      ~__new_allocator() _GLIBCXX_USE_NOEXCEPT { }
  1a:	mov    rbx,r12
  1d:	cmp    QWORD PTR [rsp+0x80],0x0
  26:	je     4f <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float) [clone .cold]+0x4f>
	ptrdiff_t __n = _M_impl._M_end_of_storage - _M_impl._M_start;
  28:	mov    rdi,QWORD PTR [rsp+0x80]
  30:	mov    rsi,r15
  33:	sub    rsi,rdi
	_GLIBCXX_OPERATOR_DELETE(_GLIBCXX_SIZED_DEALLOC(__p, __n));
  36:	call   3b <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float) [clone .cold]+0x3b>
      ~__new_allocator() _GLIBCXX_USE_NOEXCEPT { }
  3b:	jmp    4f <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float) [clone .cold]+0x4f>
	  __throw_length_error(
  3d:	lea    rdi,[rip+0x0]        # 44 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float) [clone .cold]+0x44>
  44:	call   49 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float) [clone .cold]+0x49>
	ptrdiff_t __n = _M_impl._M_end_of_storage - _M_impl._M_start;
  49:	mov    rbx,rax
  4c:	vzeroupper
  4f:	mov    rax,QWORD PTR [rsp+0x40]
  54:	mov    rdi,QWORD PTR [rax+0x10]
	if (__p)
  58:	test   rdi,rdi
  5b:	je     69 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float) [clone .cold]+0x69>
	ptrdiff_t __n = _M_impl._M_end_of_storage - _M_impl._M_start;
  5d:	mov    rsi,QWORD PTR [rax+0x20]
  61:	sub    rsi,rdi
	_GLIBCXX_OPERATOR_DELETE(_GLIBCXX_SIZED_DEALLOC(__p, __n));
  64:	call   69 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float) [clone .cold]+0x69>
      ~__new_allocator() _GLIBCXX_USE_NOEXCEPT { }
  69:	mov    rdi,rbx
  6c:	call   71 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float) [clone .cold]+0x71>
	_GLIBCXX_OPERATOR_DELETE(_GLIBCXX_SIZED_DEALLOC(__p, __n));
  71:	mov    rsi,QWORD PTR [rsp+0x38]
  76:	mov    rdi,QWORD PTR [rsp+0x50]
  7b:	vzeroupper
  7e:	call   83 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float) [clone .cold]+0x83>
  83:	jmp    1a <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float) [clone .cold]+0x1a>
	  __throw_length_error(__N(__s));
  85:	lea    rdi,[rip+0x0]        # 8c <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float) [clone .cold]+0x8c>
  8c:	call   91 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float) [clone .cold]+0x91>
	  __throw_length_error(
  91:	lea    rdi,[rip+0x0]        # 98 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float) [clone .cold]+0x98>
  98:	call   9d <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float) [clone .cold]+0x9d>
	if (__p)
  9d:	mov    rbx,rax
  a0:	vzeroupper
  a3:	jmp    1d <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float) [clone .cold]+0x1d>
  a8:	mov    rbx,rax
  ab:	vzeroupper
  ae:	jmp    1d <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float) [clone .cold]+0x1d>
