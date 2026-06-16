
asm/opt17_ilp_only.o:     file format elf64-x86-64


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
      2b:	mov    QWORD PTR [rsp+0x40],rdi
    const size_t width  = subapertures.front().data.width;
      30:	vmovdqu xmm0,XMMWORD PTR [rbx]
      34:	mov    QWORD PTR [rdi+0x20],0x0
      3c:	vmovdqu XMMWORD PTR [rdi+0x10],xmm1
      41:	vmovq  rax,xmm0
      46:	vpextrq rdx,xmm0,0x1
      4c:	vmovq  QWORD PTR [rsp+0x38],xmm0
    const int h = static_cast<int>(height);

    ImageData output;
    output.width = width;
    output.height = height;
    output.data.assign(width * height * 3, 0);
      52:	mov    r12,rax
      55:	mov    QWORD PTR [rsp+0x100],rdx
      5d:	imul   r12,rdx
    output.width = width;
      61:	vmovdqu XMMWORD PTR [rdi],xmm0
    void
    vector<_Tp, _Alloc>::
    _M_fill_assign(size_t __n, const value_type& __val)
    {
      const size_type __sz = size();
      if (__n > capacity())
      65:	test   r12,r12
      68:	jne    172d <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x172d>
      /**  Returns the number of elements in the %vector.  */
      _GLIBCXX_NODISCARD _GLIBCXX20_CONSTEXPR
      size_type
      size() const _GLIBCXX_NOEXCEPT
      {
	ptrdiff_t __dif = this->_M_impl._M_finish - this->_M_impl._M_start;
      6e:	mov    rcx,QWORD PTR [rsi+0x8]
      if (this->capacity() < __n)
      72:	mov    rdi,rcx
      75:	mov    QWORD PTR [rsp+0x118],rcx
      7d:	sub    rdi,rbx
      80:	mov    QWORD PTR [rsp+0x28],rdi
      85:	je     1548 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x1548>
	    return static_cast<_Tp*>(_GLIBCXX_OPERATOR_NEW(__n * sizeof(_Tp),
							   __al));
	  }
#endif
	else
	  return static_cast<_Tp*>(_GLIBCXX_OPERATOR_NEW(__n * sizeof(_Tp)));
      8b:	mov    r15,QWORD PTR [rsp+0x28]
      90:	mov    rdi,r15
      93:	call   98 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x98>
      98:	mov    QWORD PTR [rsp+0x70],rax
	  this->_M_impl._M_end_of_storage = this->_M_impl._M_start + __n;
      9d:	lea    r13,[rax+r15*1]
    const int w = static_cast<int>(width);
      a1:	mov    eax,DWORD PTR [rsp+0x38]
    const int h = static_cast<int>(height);
      a5:	mov    r14d,DWORD PTR [rsp+0x100]
    const int w = static_cast<int>(width);
      ad:	mov    DWORD PTR [rsp+0x54],eax

    std::vector<SubParams> params;
    params.reserve(subapertures.size());
    for (auto& sub : subapertures) {
      b1:	cmp    QWORD PTR [rsp+0x118],rbx
      b9:	je     17ac <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x17ac>
	: _M_start(), _M_finish(), _M_end_of_storage()
      bf:	mov    r15,QWORD PTR [rsp+0x70]
        SubParams p;
        float shift_x = focus * sub.u;
      c4:	vmovss xmm3,DWORD PTR [rsp+0xe0]
        float dy = shift_y - p.sy;
        p.A = (1.0f - dx) * (1.0f - dy);
        p.B = dx           * (1.0f - dy);
        p.C = (1.0f - dx) * dy;
        p.D = dx           * dy;
        p.x_begin = std::max(0, -p.sx);
      cd:	xor    r8d,r8d
        float shift_x = focus * sub.u;
      d0:	vmulss xmm4,xmm3,DWORD PTR [rbx+0x28]
        float shift_y = focus * sub.v;
      d5:	vmulss xmm2,xmm3,DWORD PTR [rbx+0x2c]
  using ::floor;

#ifndef __CORRECT_ISO_CPP_MATH_H_PROTO
  inline _GLIBCXX_CONSTEXPR float
  floor(float __x)
  { return __builtin_floorf(__x); }
      da:	vrndscaless xmm0,xmm4,xmm4,0x9
        p.sx = static_cast<int>(std::floor(shift_x));
      e1:	vcvttss2si r10d,xmm0
      e5:	vrndscaless xmm1,xmm2,xmm2,0x9
        p.sy = static_cast<int>(std::floor(shift_y));
      ec:	vcvttss2si esi,xmm1
        p.x_begin = std::max(0, -p.sx);
      f0:	mov    eax,r10d
      f3:	neg    eax
      f5:	test   r10d,r10d
      f8:	cmovs  r8d,eax
        p.x_end   = std::min(w, w - p.sx - 1);
      fc:	mov    eax,DWORD PTR [rsp+0x54]
     100:	mov    ecx,eax
     102:	sub    ecx,r10d
     105:	dec    ecx
    min(const _Tp& __a, const _Tp& __b)
    {
      // concept requirements
      __glibcxx_function_requires(_LessThanComparableConcept<_Tp>)
      //return __b < __a ? __b : __a;
      if (__b < __a)
     107:	cmp    ecx,eax
     109:	cmovg  ecx,eax
        p.y_begin = std::max(0, -p.sy);
     10c:	mov    eax,esi
     10e:	xor    r9d,r9d
     111:	neg    eax
     113:	test   esi,esi
     115:	cmovs  r9d,eax
        p.y_end   = std::min(h, h - p.sy - 1);
     119:	mov    eax,r14d
     11c:	sub    eax,esi
     11e:	dec    eax
     120:	cmp    eax,r14d
     123:	cmovg  eax,r14d
     127:	mov    r11d,eax
        p.SUB = sub.data.data.data();
        if (p.x_begin >= p.x_end || p.y_begin >= p.y_end) continue;
     12a:	cmp    r8d,ecx
     12d:	jge    1b5 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x1b5>
     133:	cmp    r9d,eax
     136:	jge    1b5 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x1b5>
        float dy = shift_y - p.sy;
     138:	vsubss xmm5,xmm2,xmm1
        float dx = shift_x - p.sx;
     13c:	vsubss xmm3,xmm4,xmm0
       *   range.  For a non-empty %vector, data() == &front().
       */
      _GLIBCXX_NODISCARD _GLIBCXX20_CONSTEXPR
      _Tp*
      data() _GLIBCXX_NOEXCEPT
      { return _M_data_ptr(this->_M_impl._M_start); }
     140:	mov    rdi,QWORD PTR [rbx+0x10]
       */
      _GLIBCXX20_CONSTEXPR
      void
      push_back(const value_type& __x)
      {
	if (this->_M_impl._M_finish != this->_M_impl._M_end_of_storage)
     144:	mov    rax,QWORD PTR [rsp+0x70]
        p.A = (1.0f - dx) * (1.0f - dy);
     149:	vaddss xmm0,xmm0,DWORD PTR [rip+0x0]        # 151 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x151>
     151:	vaddss xmm1,xmm1,DWORD PTR [rip+0x0]        # 159 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x159>
      { return _M_data_ptr(this->_M_impl._M_start); }
     159:	mov    QWORD PTR [rsp+0xf0],rdi
     161:	vsubss xmm0,xmm0,xmm4
     165:	vsubss xmm1,xmm1,xmm2
     169:	vmulss xmm2,xmm0,xmm1
        p.B = dx           * (1.0f - dy);
     16d:	vmulss xmm1,xmm1,xmm3
        p.C = (1.0f - dx) * dy;
     171:	vmulss xmm0,xmm0,xmm5
        p.D = dx           * dy;
     175:	vmulss xmm3,xmm3,xmm5
	if (this->_M_impl._M_finish != this->_M_impl._M_end_of_storage)
     179:	cmp    rax,r13
     17c:	je     1580 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x1580>
      template<typename _Up, typename... _Args>
	__attribute__((__always_inline__))
	void
	construct(_Up* __p, _Args&&... __args)
	noexcept(__is_nothrow_new_constructible<_Up, _Args...>)
	{ ::new((void *)__p) _Up(std::forward<_Args>(__args)...); }
     182:	vunpcklps xmm0,xmm0,xmm3
     186:	vunpcklps xmm2,xmm2,xmm1
     18a:	mov    DWORD PTR [rax],r10d
	  {
	    _GLIBCXX_ASAN_ANNOTATE_GROW(1);
	    _Alloc_traits::construct(this->_M_impl, this->_M_impl._M_finish,
				     __x);
	    ++this->_M_impl._M_finish;
     18d:	add    rax,0x30
     191:	vmovlhps xmm2,xmm2,xmm0
     195:	mov    DWORD PTR [rax-0x2c],esi
     198:	vmovups XMMWORD PTR [rax-0x28],xmm2
     19d:	mov    DWORD PTR [rax-0x18],r8d
     1a1:	mov    DWORD PTR [rax-0x14],ecx
     1a4:	mov    DWORD PTR [rax-0x10],r9d
     1a8:	mov    DWORD PTR [rax-0xc],r11d
     1ac:	mov    QWORD PTR [rax-0x8],rdi
     1b0:	mov    QWORD PTR [rsp+0x70],rax
      __attribute__((__always_inline__))
      _GLIBCXX14_CONSTEXPR
      __normal_iterator&
      operator++() _GLIBCXX_NOEXCEPT
      {
	++_M_current;
     1b5:	add    rbx,0x30
    for (auto& sub : subapertures) {
     1b9:	cmp    rbx,QWORD PTR [rsp+0x118]
     1c1:	jne    c4 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0xc4>
	ptrdiff_t __n = _M_impl._M_end_of_storage - _M_impl._M_start;
     1c7:	mov    rax,r13
     1ca:	sub    rax,r15
     1cd:	mov    QWORD PTR [rsp+0x28],rax
     1d2:	mov    rax,QWORD PTR [rsp+0x70]
     1d7:	mov    QWORD PTR [rsp+0x70],r15
     1dc:	mov    QWORD PTR [rsp+0x98],rax

      // Called by constructors to check initial size.
      static _GLIBCXX20_CONSTEXPR size_type
      _S_check_init_len(size_type __n, const allocator_type& __a)
      {
	if (__n > _S_max_size(_Tp_alloc_type(__a)))
     1e4:	mov    rax,r12
     1e7:	shr    rax,0x3d
     1eb:	jne    1f1 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x1f1>
	return __n != 0 ? _Tr::allocate(_M_impl, __n) : pointer();
     1f1:	test   r12,r12
     1f4:	je     1572 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x1572>
	  return static_cast<_Tp*>(_GLIBCXX_OPERATOR_NEW(__n * sizeof(_Tp)));
     1fa:	shl    r12,0x2
     1fe:	mov    rdi,r12
     201:	call   206 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x206>
	  // Allow std::_Construct to be used in constant expressions.
	  std::construct_at(__p, std::forward<_Args>(__args)...);
	  return;
	}
#endif
      ::new(static_cast<void*>(__p)) _Tp(std::forward<_Args>(__args)...);
     206:	mov    rdx,r12
     209:	xor    esi,esi
     20b:	mov    rdi,rax
     20e:	mov    QWORD PTR [rsp+0x48],rax
     213:	call   218 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x218>
        params.push_back(p);
    }

    std::vector<int> counts(width * height, 0);
    {
        std::vector<int> diff((width + 1) * (height + 1), 0);
     218:	mov    rax,QWORD PTR [rsp+0x38]
     21d:	mov    rbx,QWORD PTR [rsp+0x100]
     225:	lea    r15,[rax+0x1]
     229:	inc    rbx
     22c:	imul   rbx,r15
	if (__n > _S_max_size(_Tp_alloc_type(__a)))
     230:	mov    rax,rbx
     233:	shr    rax,0x3d
     237:	jne    23d <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x23d>
	return __n != 0 ? _Tr::allocate(_M_impl, __n) : pointer();
     23d:	test   rbx,rbx
     240:	je     1513 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x1513>
     246:	shl    rbx,0x2
     24a:	mov    rdi,rbx
     24d:	call   252 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x252>
     252:	mov    rdi,rax
     255:	mov    rdx,rbx
     258:	xor    esi,esi
     25a:	call   25f <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x25f>
        for (const auto& p : params) {
     25f:	mov    rcx,QWORD PTR [rsp+0x98]
     267:	mov    rdi,rax
     26a:	cmp    QWORD PTR [rsp+0x70],rcx
     26f:	je     1792 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x1792>
     275:	mov    rax,QWORD PTR [rsp+0x70]
            diff[p.y_begin * (width + 1) + p.x_begin] += 1;
     27a:	movsxd rdx,DWORD PTR [rax+0x20]
     27e:	movsxd rsi,DWORD PTR [rax+0x18]
     282:	add    rax,0x30
            diff[p.y_begin * (width + 1) + p.x_end  ] -= 1;
            diff[p.y_end   * (width + 1) + p.x_begin] -= 1;
     286:	movsxd r8,DWORD PTR [rax-0xc]
            diff[p.y_begin * (width + 1) + p.x_begin] += 1;
     28a:	imul   rdx,r15
            diff[p.y_end   * (width + 1) + p.x_begin] -= 1;
     28e:	imul   r8,r15
            diff[p.y_begin * (width + 1) + p.x_begin] += 1;
     292:	lea    rcx,[rdx+rsi*1]
     296:	inc    DWORD PTR [rdi+rcx*4]
            diff[p.y_begin * (width + 1) + p.x_end  ] -= 1;
     299:	movsxd rcx,DWORD PTR [rax-0x14]
     29d:	add    rdx,rcx
     2a0:	dec    DWORD PTR [rdi+rdx*4]
            diff[p.y_end   * (width + 1) + p.x_begin] -= 1;
     2a3:	lea    rdx,[rsi+r8*1]
     2a7:	dec    DWORD PTR [rdi+rdx*4]
            diff[p.y_end   * (width + 1) + p.x_end  ] += 1;
     2aa:	lea    rdx,[rcx+r8*1]
     2ae:	inc    DWORD PTR [rdi+rdx*4]
        for (const auto& p : params) {
     2b1:	cmp    rax,QWORD PTR [rsp+0x98]
     2b9:	jne    27a <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x27a>
        }
        for (int y = 0; y < h; ++y) {
     2bb:	test   r14d,r14d
     2be:	jle    37a <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x37a>
     2c4:	mov    ecx,DWORD PTR [rsp+0x54]
     2c8:	test   ecx,ecx
     2ca:	jle    37a <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x37a>
            int row = 0;
            for (int x = 0; x < w; ++x) {
     2d0:	mov    rax,QWORD PTR [rsp+0x38]
            int row = 0;
     2d5:	xor    ecx,ecx
     2d7:	lea    edx,[rax-0x1]
        for (const auto& p : params) {
     2da:	xor    eax,eax
     2dc:	lea    rsi,[rdx+0x1]
                row += diff[y * (width + 1) + x];
                counts[y * w + x] = row + (y > 0 ? counts[(y - 1) * w + x] : 0);
     2e0:	mov    rdx,QWORD PTR [rsp+0x48]
                row += diff[y * (width + 1) + x];
     2e5:	add    ecx,DWORD PTR [rdi+rax*4]
                counts[y * w + x] = row + (y > 0 ? counts[(y - 1) * w + x] : 0);
     2e8:	mov    DWORD PTR [rdx+rax*4],ecx
            for (int x = 0; x < w; ++x) {
     2eb:	inc    rax
     2ee:	cmp    rsi,rax
     2f1:	jne    2e0 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x2e0>
        for (int y = 0; y < h; ++y) {
     2f3:	cmp    r14d,0x1
     2f7:	jle    37f <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x37f>
     2fd:	mov    eax,DWORD PTR [rsp+0x54]
     301:	shl    r15,0x2
            for (int x = 0; x < w; ++x) {
     305:	xor    r11d,r11d
        for (int y = 0; y < h; ++y) {
     308:	mov    r10d,0x1
     30e:	lea    rdx,[rdi+r15*1]
     312:	lea    r8,[rax*4+0x0]
     31a:	mov    rax,QWORD PTR [rsp+0x48]
     31f:	lea    r9,[rax+r8*1]
            for (int x = 0; x < w; ++x) {
     323:	mov    rcx,QWORD PTR [rsp+0x48]
     328:	movsxd rax,r11d
     32b:	add    r11d,DWORD PTR [rsp+0x38]
            int row = 0;
     330:	mov    QWORD PTR [rsp+0x110],rdi
     338:	lea    rax,[rcx+rax*4]
     33c:	xor    ecx,ecx
     33e:	mov    QWORD PTR [rsp+0x118],rax
        for (int y = 0; y < h; ++y) {
     346:	xor    eax,eax
                counts[y * w + x] = row + (y > 0 ? counts[(y - 1) * w + x] : 0);
     348:	mov    rdi,QWORD PTR [rsp+0x118]
                row += diff[y * (width + 1) + x];
     350:	add    ecx,DWORD PTR [rdx+rax*4]
                counts[y * w + x] = row + (y > 0 ? counts[(y - 1) * w + x] : 0);
     353:	mov    edi,DWORD PTR [rdi+rax*4]
     356:	add    edi,ecx
     358:	mov    DWORD PTR [r9+rax*4],edi
            for (int x = 0; x < w; ++x) {
     35c:	inc    rax
     35f:	cmp    rax,rsi
     362:	jne    348 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x348>
        for (int y = 0; y < h; ++y) {
     364:	inc    r10d
     367:	mov    rdi,QWORD PTR [rsp+0x110]
     36f:	add    rdx,r15
     372:	add    r9,r8
     375:	cmp    r14d,r10d
     378:	jg     323 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x323>
	if (__p)
     37a:	test   rdi,rdi
     37d:	je     387 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x387>
	_GLIBCXX_OPERATOR_DELETE(_GLIBCXX_SIZED_DEALLOC(__p, __n));
     37f:	mov    rsi,rbx
     382:	call   387 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x387>
	  return static_cast<_Tp*>(_GLIBCXX_OPERATOR_NEW(__n * sizeof(_Tp)));
     387:	mov    edi,0x2fa00
     38c:	call   391 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x391>
     391:	mov    DWORD PTR [rax],0x0
      typedef typename __gnu_cxx::__conditional_type<__load_outside_loop,
						     const _Tp,
						     const _Tp&>::__type _Up;
      _Up __val(__value);
      for (; __first != __last; ++__first)
	*__first = __val;
     397:	xor    esi,esi
	  if (__n > 0)
	    {
	      typename iterator_traits<_ForwardIterator>::value_type* __val
		= std::addressof(*__first);
	      std::_Construct(__val);
	      ++__first;
     399:	lea    rdi,[rax+0x4]
     39d:	mov    edx,0x2f9fc
     3a2:	mov    QWORD PTR [rsp+0xf8],rax
     3aa:	call   3af <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x3af>
    const int TILE_H = 8;
    const int TILE_W = 2032;

    std::vector<float> tile_vals(TILE_H * TILE_W * 3);

    for (int ty = 0; ty < h; ty += TILE_H) {
     3af:	test   r14d,r14d
     3b2:	jle    13e3 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x13e3>
     3b8:	mov    edx,DWORD PTR [rsp+0x54]
     3bc:	test   edx,edx
     3be:	jle    13e3 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x13e3>

                const int x_floats = (x_end - x_begin) * 3;

                for (int y = y_begin; y < y_end; ++y) {
                    const size_t rb0 = ((size_t)(y + p.sy) * width + (size_t)(x_begin + p.sx)) * 3;
                    const size_t rb1 = rb0 + width * 3;
     3c4:	mov    rax,QWORD PTR [rsp+0x38]
                unsigned char* outp = output.data.data() + (size_t)(y * width + tx) * 3;

                for (int x = 0; x < tile_w_actual; ++x) {
                    int c = counts[y * width + (tx + x)];
                    if (c == 0) continue;
                    float inv_c = 1.0f / (float)c;
     3c9:	vmovss xmm20,DWORD PTR [rip+0x0]        # 3d3 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x3d3>
                    const size_t rb1 = rb0 + width * 3;
     3d3:	mov    QWORD PTR [rsp+0x58],0x0
     3dc:	vxorps xmm4,xmm4,xmm4
      if (__a < __b)
     3e0:	vmovss xmm13,DWORD PTR [rip+0x0]        # 3e8 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x3e8>
     3e8:	mov    QWORD PTR [rsp+0x10],r12
     3ed:	lea    rcx,[rax+rax*2]
     3f1:	lea    r12,[rax*8+0x0]
     3f9:	mov    QWORD PTR [rsp+0xc0],rcx
     401:	xor    ecx,ecx
     403:	mov    rdi,QWORD PTR [rsp+0x58]
        const int tile_h_actual = tile_y_end - ty;
     408:	mov    r10,QWORD PTR [rsp+0x38]
     40d:	mov    DWORD PTR [rsp+0x18],r14d
     412:	mov    QWORD PTR [rsp+0x20],rcx
        const int tile_y_end    = std::min(ty + TILE_H, h);
     417:	lea    eax,[rdi+0x8]
     41a:	mov    DWORD PTR [rsp+0x50],edi
      if (__b < __a)
     41e:	cmp    eax,r14d
     421:	mov    DWORD PTR [rsp+0x30],edi
     425:	cmovg  eax,r14d
        const int tile_h_actual = tile_y_end - ty;
     429:	mov    QWORD PTR [rsp+0x8],r12
     42e:	xor    r12d,r12d
     431:	mov    r15d,eax
     434:	sub    eax,edi
     436:	mov    DWORD PTR [rsp+0x1c],eax
     43a:	mov    ecx,DWORD PTR [rsp+0x54]
            const int tile_x_end    = std::min(tx + TILE_W, w);
     43e:	lea    eax,[r12+0x7f0]
     446:	mov    r13d,r12d
     449:	cmp    eax,ecx
     44b:	cmovg  eax,ecx
            const int tile_w_actual = tile_x_end - tx;
     44e:	mov    ecx,eax
     450:	mov    r14d,eax
                      tile_vals.begin() + tile_h_actual * tile_w_actual * 3,
     453:	mov    eax,DWORD PTR [rsp+0x1c]
            const int tile_w_actual = tile_x_end - tx;
     457:	sub    ecx,r12d
                      tile_vals.begin() + tile_h_actual * tile_w_actual * 3,
     45a:	imul   eax,ecx
            const size_t tile_row_stride = (size_t)tile_w_actual * 3;
     45d:	movsxd r11,ecx
                      tile_vals.begin() + tile_h_actual * tile_w_actual * 3,
     460:	lea    edx,[rax+rax*2]

      _GLIBCXX_NODISCARD __attribute__((__always_inline__))
      _GLIBCXX_CONSTEXPR
      __normal_iterator
      operator+(difference_type __n) const _GLIBCXX_NOEXCEPT
      { return __normal_iterator(_M_current + __n); }
     463:	movsxd rdx,edx
      for (; __first != __last; ++__first)
     466:	shl    rdx,0x2
     46a:	je     4d0 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x4d0>
     46c:	mov    QWORD PTR [rsp+0xf0],r10
	*__first = __val;
     474:	mov    rdi,QWORD PTR [rsp+0xf8]
     47c:	xor    esi,esi
     47e:	mov    DWORD PTR [rsp+0x110],ecx
     485:	mov    QWORD PTR [rsp+0x118],r11
     48d:	vmovaps XMMWORD PTR [rsp+0x100],xmm4
     496:	vzeroupper
     499:	call   49e <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x49e>
     49e:	mov    r10,QWORD PTR [rsp+0xf0]
     4a6:	vmovaps xmm4,XMMWORD PTR [rsp+0x100]
     4af:	vmovss xmm13,DWORD PTR [rip+0x0]        # 4b7 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x4b7>
     4b7:	vmovss xmm20,DWORD PTR [rip+0x0]        # 4c1 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x4c1>
     4c1:	mov    ecx,DWORD PTR [rsp+0x110]
     4c8:	mov    r11,QWORD PTR [rsp+0x118]
            for (const SubParams& p : params) {
     4d0:	mov    rax,QWORD PTR [rsp+0x70]
     4d5:	cmp    rax,QWORD PTR [rsp+0x98]
     4dd:	je     1287 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x1287>
     4e3:	mov    rdx,rax
     4e6:	lea    rax,[r11+r11*2]
     4ea:	mov    QWORD PTR [rsp+0x68],r11
     4ef:	mov    r9d,DWORD PTR [rsp+0x50]
     4f4:	mov    QWORD PTR [rsp+0xd0],rax
     4fc:	shl    rax,0x2
     500:	mov    QWORD PTR [rsp+0xc8],rax
     508:	mov    DWORD PTR [rsp+0x34],ecx
     50c:	mov    DWORD PTR [rsp+0x94],r14d
     514:	mov    QWORD PTR [rsp+0x60],r12
     519:	nop    DWORD PTR [rax+0x0]
      if (__a < __b)
     520:	mov    eax,DWORD PTR [rdx+0x20]
      if (__b < __a)
     523:	mov    ecx,DWORD PTR [rdx+0x1c]
     526:	mov    esi,DWORD PTR [rsp+0x94]
      if (__a < __b)
     52d:	cmp    r9d,eax
     530:	mov    edi,eax
      if (__b < __a)
     532:	mov    eax,DWORD PTR [rdx+0x24]
      if (__a < __b)
     535:	cmovge edi,r9d
      if (__b < __a)
     539:	cmp    r15d,eax
     53c:	cmovle eax,r15d
      if (__a < __b)
     540:	mov    DWORD PTR [rsp+0x118],edi
      if (__b < __a)
     547:	mov    DWORD PTR [rsp+0xd8],eax
     54e:	mov    ebx,eax
      if (__a < __b)
     550:	mov    eax,DWORD PTR [rdx+0x18]
     553:	cmp    r13d,eax
     556:	cmovge rax,r13
      if (__b < __a)
     55a:	cmp    esi,ecx
     55c:	cmovle ecx,esi
                if (x_begin >= x_end || y_begin >= y_end) continue;
     55f:	cmp    ecx,eax
     561:	jle    1267 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x1267>
     567:	cmp    ebx,edi
     569:	jle    1267 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x1267>
                const __m256 Avx = _mm256_set1_ps(p.A);
     56f:	mov    r8d,edi
                const int x_floats = (x_end - x_begin) * 3;
     572:	sub    ecx,eax
                    const size_t rb0 = ((size_t)(y + p.sy) * width + (size_t)(x_begin + p.sx)) * 3;
     574:	mov    esi,DWORD PTR [rdx]
     576:	mov    r14,QWORD PTR [rsp+0xf8]
     57e:	mov    rdi,r8
                const int x_floats = (x_end - x_begin) * 3;
     581:	lea    ebx,[rcx+rcx*2]
                    float* vp = tile_vals.data() + (size_t)(y - ty) * tile_row_stride + (size_t)(x_begin - tx) * 3;
     584:	mov    ecx,eax
                const __m256 Avx = _mm256_set1_ps(p.A);
     586:	vmovss xmm19,DWORD PTR [rdx+0x8]
     58d:	sub    rdi,QWORD PTR [rsp+0x58]
                    float* vp = tile_vals.data() + (size_t)(y - ty) * tile_row_stride + (size_t)(x_begin - tx) * 3;
     592:	sub    ecx,r13d
                    const size_t rb0 = ((size_t)(y + p.sy) * width + (size_t)(x_begin + p.sx)) * 3;
     595:	add    esi,eax
     597:	sub    rax,QWORD PTR [rsp+0x60]
     59c:	imul   rdi,QWORD PTR [rsp+0x68]
                    float* vp = tile_vals.data() + (size_t)(y - ty) * tile_row_stride + (size_t)(x_begin - tx) * 3;
     5a2:	movsxd rcx,ecx
                const int x_floats = (x_end - x_begin) * 3;
     5a5:	mov    DWORD PTR [rsp+0x110],ebx
                    const size_t rb0 = ((size_t)(y + p.sy) * width + (size_t)(x_begin + p.sx)) * 3;
     5ac:	movsxd rsi,esi
                const __m256 Bvx = _mm256_set1_ps(p.B);
     5af:	vmovss xmm18,DWORD PTR [rdx+0xc]
                const __m256 Cvx = _mm256_set1_ps(p.C);
     5b6:	vmovss xmm17,DWORD PTR [rdx+0x10]
     5bd:	mov    QWORD PTR [rsp+0x88],rdx
                const __m256 Avx = _mm256_set1_ps(p.A);
     5c5:	vbroadcastss ymm10,xmm19
                const __m256 Dvx = _mm256_set1_ps(p.D);
     5cb:	vmovss xmm16,DWORD PTR [rdx+0x14]
                        __m256 rl0 = load_cvt8(p.SUB + rb0 + xf);
     5d2:	mov    r12,QWORD PTR [rdx+0x28]
     5d6:	mov    QWORD PTR [rsp+0x80],r10
/* Create a vector with all elements equal to A.  */
extern __inline __m256 __attribute__((__gnu_inline__, __always_inline__, __artificial__))
_mm256_set1_ps (float __A)
{
  return __extension__ (__m256){ __A, __A, __A, __A,
				 __A, __A, __A, __A };
     5de:	vmovaps ymm3,ymm10
                const __m256 Bvx = _mm256_set1_ps(p.B);
     5e2:	add    rcx,rdi
     5e5:	add    rax,rdi
     5e8:	mov    DWORD PTR [rsp+0x7c],r13d
     5ed:	vbroadcastss ymm11,xmm18
  return __extension__ (__m256){ __A, __A, __A, __A,
     5f3:	lea    rcx,[rcx+rcx*2]
     5f7:	lea    rax,[rax+rax*2]
     5fb:	mov    DWORD PTR [rsp+0x78],r9d
                const __m256 Cvx = _mm256_set1_ps(p.C);
     600:	vbroadcastss ymm12,xmm17
     606:	lea    r11,[r14+rcx*4]
     60a:	movsxd rcx,DWORD PTR [rdx+0x4]
     60e:	mov    QWORD PTR [rsp+0xe8],rax
     616:	lea    eax,[rbx-0x10]
     619:	mov    edi,eax
     61b:	shr    eax,0x4
                const __m256 Dvx = _mm256_set1_ps(p.D);
     61e:	vbroadcastss ymm9,xmm16
     624:	mov    DWORD PTR [rsp+0x90],r15d
     62c:	add    r8,rcx
     62f:	and    edi,0xfffffff0
     632:	inc    eax
     634:	mov    r15,r11
     637:	imul   r8,r10
                    if (xf + 8 <= x_floats) {
     63b:	lea    ebx,[rdi+0x17]
     63e:	mov    DWORD PTR [rsp+0xb8],edi
                        __m256 rl0 = load_cvt8(p.SUB + rb0 + xf);
     645:	add    edi,0x10
     648:	mov    QWORD PTR [rsp+0xa8],rdi
     650:	shl    rax,0x6
                        __m256 v = _mm256_loadu_ps(vp + xf);
     654:	shl    rdi,0x2
				 __A, __A, __A, __A };
     658:	vmovaps ymm2,ymm11
                    if (xf + 8 <= x_floats) {
     65c:	mov    DWORD PTR [rsp+0xbc],ebx
     663:	vmovaps ymm1,ymm12
     667:	vmovaps ymm0,ymm9
                for (int y = y_begin; y < y_end; ++y) {
     66b:	lea    rcx,[rsi+r8*1]
                        __m256 v = _mm256_loadu_ps(vp + xf);
     66f:	mov    QWORD PTR [rsp+0xa0],rdi
     677:	add    rsi,r10
     67a:	mov    QWORD PTR [rsp+0xb0],rax
     682:	add    rsi,r8
     685:	lea    rcx,[rcx+rcx*2]
     689:	lea    r14,[rsi+rsi*2]
     68d:	nop    DWORD PTR [rax]
                    for (; xf + 16 <= x_floats; xf += 16) {
     690:	cmp    DWORD PTR [rsp+0x110],0xf
     698:	jle    14b8 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x14b8>
     69e:	mov    rax,QWORD PTR [rsp+0xb0]
     6a6:	lea    rdx,[r12+r14*1]
     6aa:	lea    rdi,[rax+r15*1]
     6ae:	mov    rax,r15
     6b1:	nop    DWORD PTR [rax+0x0]
}

extern __inline __m128i __attribute__((__gnu_inline__, __always_inline__, __artificial__))
_mm_loadl_epi64 (__m128i_u const *__P)
{
  return _mm_set_epi64 ((__m64)0LL, *(__m64_u *)__P);
     6b8:	mov    rsi,rdx

extern __inline __m256i
__attribute__ ((__gnu_inline__, __always_inline__, __artificial__))
_mm256_cvtepu8_epi32 (__m128i __X)
{
  return (__m256i) __builtin_ia32_pmovzxbd256 ((__v16qi)__X);
     6bb:	vpmovzxbd ymm8,QWORD PTR [rdx]
     6c0:	vpmovzxbd ymm7,QWORD PTR [rdx+0x8]
     6c6:	add    rax,0x40
     6ca:	sub    rsi,r14
     6cd:	vpmovzxbd ymm6,QWORD PTR [rdx+0x3]
     6d3:	vpmovzxbd ymm5,QWORD PTR [rdx+0xb]
     6d9:	add    rdx,0x10
     6dd:	vpmovzxbd ymm22,QWORD PTR [rsi+rcx*1]
     6e4:	vpmovzxbd ymm21,QWORD PTR [rsi+rcx*1+0x8]
  return (__m256)__builtin_ia32_cvtdq2ps256 ((__v8si) __A);
     6ec:	vcvtdq2ps ymm8,ymm8
     6f1:	vcvtdq2ps ymm7,ymm7
     6f5:	vpmovzxbd ymm15,QWORD PTR [rsi+rcx*1+0x3]
     6fc:	vpmovzxbd ymm14,QWORD PTR [rsi+rcx*1+0xb]
     703:	vcvtdq2ps ymm6,ymm6
     707:	vcvtdq2ps ymm5,ymm5
     70b:	vcvtdq2ps ymm22,ymm22
     711:	vcvtdq2ps ymm21,ymm21

extern __inline __m256
__attribute__((__gnu_inline__, __always_inline__, __artificial__))
_mm256_fmadd_ps (__m256 __A, __m256 __B, __m256 __C)
{
  return (__m256)__builtin_ia32_vfmaddps256 ((__v8sf)__A, (__v8sf)__B,
     717:	vfmadd213ps ymm22,ymm3,YMMWORD PTR [rax-0x40]
     71e:	vfmadd213ps ymm21,ymm3,YMMWORD PTR [rax-0x20]
     725:	vcvtdq2ps ymm15,ymm15
     72a:	vcvtdq2ps ymm14,ymm14
     72f:	vfmadd132ps ymm15,ymm22,ymm2
     735:	vfmadd132ps ymm14,ymm21,ymm2
     73b:	vfmadd132ps ymm8,ymm15,ymm1
     740:	vfmadd132ps ymm7,ymm14,ymm1
     745:	vfmadd132ps ymm6,ymm8,ymm0
     74a:	vfmadd132ps ymm5,ymm7,ymm0
  *(__m256_u *)__P = __A;
     74f:	vmovups YMMWORD PTR [rax-0x40],ymm6
     754:	vmovups YMMWORD PTR [rax-0x20],ymm5
     759:	cmp    rdi,rax
     75c:	jne    6b8 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x6b8>
                    if (xf + 8 <= x_floats) {
     762:	mov    edi,DWORD PTR [rsp+0xb8]
     769:	mov    ebx,DWORD PTR [rsp+0x110]
     770:	lea    eax,[rdi+0x10]
     773:	mov    DWORD PTR [rsp+0x100],eax
     77a:	cmp    DWORD PTR [rsp+0xbc],ebx
     781:	jge    7eb <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x7eb>
                        __m256 rl0 = load_cvt8(p.SUB + rb0 + xf);
     783:	mov    rax,QWORD PTR [rsp+0xa8]
                        __m256 v = _mm256_loadu_ps(vp + xf);
     78b:	add    edi,0x18
     78e:	mov    DWORD PTR [rsp+0x100],edi
                        __m256 rl0 = load_cvt8(p.SUB + rb0 + xf);
     795:	lea    rsi,[rcx+rax*1]
                        __m256 rl1 = load_cvt8(p.SUB + rb1 + xf);
     799:	lea    rdx,[rax+r14*1]
                        __m256 v = _mm256_loadu_ps(vp + xf);
     79d:	mov    rax,QWORD PTR [rsp+0xa0]
     7a5:	add    rax,r15
     7a8:	vpmovzxbd ymm8,QWORD PTR [r12+rsi*1]
     7ae:	vpmovzxbd ymm7,QWORD PTR [r12+rsi*1+0x3]
     7b5:	vpmovzxbd ymm6,QWORD PTR [r12+rdx*1]
     7bb:	vpmovzxbd ymm5,QWORD PTR [r12+rdx*1+0x3]
  return (__m256)__builtin_ia32_cvtdq2ps256 ((__v8si) __A);
     7c2:	vcvtdq2ps ymm8,ymm8
     7c7:	vfmadd213ps ymm8,ymm3,YMMWORD PTR [rax]
     7cc:	vcvtdq2ps ymm7,ymm7
     7d0:	vcvtdq2ps ymm6,ymm6
     7d4:	vcvtdq2ps ymm5,ymm5
     7d8:	vfmadd132ps ymm7,ymm8,ymm2
     7dd:	vfmadd132ps ymm6,ymm7,ymm1
     7e2:	vfmadd132ps ymm5,ymm6,ymm0
  *(__m256_u *)__P = __A;
     7e7:	vmovups YMMWORD PTR [rax],ymm5
                    for (int k = 0; k < x_floats - xf; ++k) {
     7eb:	mov    edi,DWORD PTR [rsp+0x110]
     7f2:	mov    eax,DWORD PTR [rsp+0x100]
     7f9:	sub    edi,eax
     7fb:	test   edi,edi
     7fd:	jle    1204 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x1204>
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
     803:	mov    r10d,eax
     806:	lea    r8,[rcx+r10*1]
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
     80a:	lea    r9,[r10+r14*1]
     80e:	mov    rax,QWORD PTR [rsp+0xe8]
     816:	mov    rsi,QWORD PTR [rsp+0xf8]
     81e:	mov    r11d,edi
     821:	lea    r13,[r11+r9*1+0x3]
     826:	lea    rbx,[rax+r10*1]
     82a:	add    r13,r12
     82d:	lea    rax,[rsi+rbx*4]
     831:	lea    rdx,[rbx+r11*1]
     835:	mov    QWORD PTR [rsp+0xf0],rbx
     83d:	cmp    rax,r13
     840:	lea    rbx,[rsi+rdx*4]
     844:	lea    rsi,[r12+r8*1]
     848:	setae  BYTE PTR [rsp+0xdc]
     850:	lea    rdx,[r12+r9*1]
     854:	cmp    rdx,rbx
     857:	mov    QWORD PTR [rsp+0xe0],rsi
     85f:	movzx  esi,BYTE PTR [rsp+0xdc]
     867:	setae  r13b
     86b:	or     sil,r13b
     86e:	je     1438 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x1438>
     874:	lea    r11,[r11+r8*1+0x3]
     879:	mov    rsi,QWORD PTR [rsp+0xe0]
     881:	add    r11,r12
     884:	cmp    rax,r11
     887:	setae  r11b
     88b:	cmp    rsi,rbx
     88e:	setae  bl
     891:	or     r11b,bl
     894:	je     1438 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x1438>
     89a:	lea    r10d,[rdi-0x1]
     89e:	cmp    r10d,0x1e
     8a2:	jbe    14dd <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x14dd>
     8a8:	mov    r10d,edi
     8ab:	lea    rbx,[r12+r9*1+0x3]
     8b0:	lea    r11,[r12+r8*1+0x3]
     8b5:	shr    r10d,0x5
     8b9:	mov    r13d,r10d
     8bc:	mov    DWORD PTR [rsp+0xe0],r10d
                    int xf = 0;
     8c4:	xor    r10d,r10d
     8c7:	shl    r13,0x5
     8cb:	nop    DWORD PTR [rax+rax*1+0x0]
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
     8d0:	vmovdqu ymm5,YMMWORD PTR [rdx+r10*1]
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
     8d6:	vmovdqu ymm6,YMMWORD PTR [r11+r10*1]
     8dc:	sub    rax,0xffffffffffffff80
     8e0:	vmovdqu ymm7,YMMWORD PTR [rsi+r10*1]
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
     8e6:	vpmovzxbw ymm8,xmm5
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
     8eb:	vpmovzxbw ymm14,xmm6
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
     8f0:	vextracti32x4 xmm5,ymm5,0x1
     8f7:	vpmovsxwd ymm21,xmm8
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
     8fd:	vpmovsxwd ymm15,xmm14
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
     902:	vpmovzxbw ymm5,xmm5
     907:	vcvtdq2ps ymm21,ymm21
                        vp[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
     90d:	vmulps ymm21,ymm21,ymm1
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
     913:	vcvtdq2ps ymm15,ymm15
     918:	vextracti32x4 xmm6,ymm6,0x1
     91f:	vpmovzxbw ymm22,xmm7
     925:	vpmovzxbw ymm6,xmm6
     92a:	vpmovsxwd ymm24,xmm22
     930:	vextracti32x4 xmm7,ymm7,0x1
     937:	vcvtdq2ps ymm24,ymm24
     93d:	vfmadd213ps ymm24,ymm3,YMMWORD PTR [rax-0x80]
     944:	vextracti32x4 xmm22,ymm22,0x1
     94b:	vpmovzxbw ymm7,xmm7
     950:	vpmovsxwd ymm22,xmm22
     956:	vcvtdq2ps ymm22,ymm22
     95c:	vfmadd213ps ymm22,ymm3,YMMWORD PTR [rax-0x60]
     963:	vfmadd132ps ymm15,ymm21,ymm2
     969:	vextracti32x4 xmm21,ymm14,0x1
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
     970:	vextracti32x4 xmm14,ymm8,0x1
     977:	vpmovsxwd ymm14,xmm14
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
     97c:	vpmovsxwd ymm21,xmm21
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
     982:	vcvtdq2ps ymm14,ymm14
                        vp[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
     987:	vmulps ymm14,ymm14,ymm1
     98b:	vcvtdq2ps ymm8,ymm21
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
     991:	vpmovsxwd ymm21,xmm6
     997:	vextracti32x4 xmm6,ymm6,0x1
     99e:	vpmovsxwd ymm6,xmm6
     9a3:	vcvtdq2ps ymm21,ymm21
     9a9:	vcvtdq2ps ymm6,ymm6
     9ad:	vfmadd132ps ymm8,ymm14,ymm2
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
     9b2:	vpmovsxwd ymm14,xmm5
     9b7:	vextracti32x4 xmm5,ymm5,0x1
     9be:	vpmovsxwd ymm5,xmm5
     9c3:	vcvtdq2ps ymm14,ymm14
     9c8:	vcvtdq2ps ymm5,ymm5
                        vp[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
     9cc:	vmulps ymm5,ymm5,ymm1
     9d0:	vmulps ymm14,ymm14,ymm1
     9d4:	vfmadd132ps ymm6,ymm5,ymm2
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
     9d9:	vmovdqu ymm5,YMMWORD PTR [rbx+r10*1]
     9df:	add    r10,0x20
     9e3:	vfmadd132ps ymm21,ymm14,ymm2
     9e9:	vpmovzxbw ymm14,xmm5
     9ee:	vextracti32x4 xmm5,ymm5,0x1
     9f5:	vpmovsxwd ymm23,xmm14
     9fb:	vextracti32x4 xmm14,ymm14,0x1
     a02:	vpmovzxbw ymm5,xmm5
     a07:	vcvtdq2ps ymm23,ymm23
     a0d:	vfmadd132ps ymm23,ymm24,ymm0
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
     a13:	vpmovsxwd ymm24,xmm7
     a19:	vextracti32x4 xmm7,ymm7,0x1
     a20:	vpmovsxwd ymm7,xmm7
     a25:	vcvtdq2ps ymm24,ymm24
     a2b:	vfmadd213ps ymm24,ymm3,YMMWORD PTR [rax-0x40]
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
     a32:	vpmovsxwd ymm14,xmm14
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
     a37:	vcvtdq2ps ymm7,ymm7
                        vp[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
     a3b:	vfmadd213ps ymm7,ymm3,YMMWORD PTR [rax-0x20]
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
     a41:	vcvtdq2ps ymm14,ymm14
     a46:	vfmadd132ps ymm14,ymm22,ymm0
     a4c:	vpmovsxwd ymm22,xmm5
     a52:	vextracti32x4 xmm5,ymm5,0x1
     a59:	vcvtdq2ps ymm22,ymm22
     a5f:	vpmovsxwd ymm5,xmm5
     a64:	vcvtdq2ps ymm5,ymm5
                        vp[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
     a68:	vaddps ymm15,ymm15,ymm23
     a6e:	vfmadd132ps ymm22,ymm24,ymm0
     a74:	vfmadd132ps ymm5,ymm7,ymm0
     a79:	vaddps ymm8,ymm8,ymm14
     a7e:	vmovups YMMWORD PTR [rax-0x80],ymm15
     a83:	vmovups YMMWORD PTR [rax-0x60],ymm8
     a88:	vaddps ymm21,ymm21,ymm22
     a8e:	vaddps ymm5,ymm5,ymm6
     a92:	vmovups YMMWORD PTR [rax-0x40],ymm21
     a99:	vmovups YMMWORD PTR [rax-0x20],ymm5
                    for (int k = 0; k < x_floats - xf; ++k) {
     a9e:	cmp    r10,r13
     aa1:	jne    8d0 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x8d0>
     aa7:	mov    r10d,DWORD PTR [rsp+0xe0]
     aaf:	shl    r10d,0x5
     ab3:	cmp    r10d,edi
     ab6:	je     1204 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x1204>
     abc:	mov    edx,edi
     abe:	mov    eax,r10d
     ac1:	sub    edx,r10d
     ac4:	lea    esi,[rdx-0x1]
     ac7:	cmp    esi,0xe
     aca:	jbe    14f3 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x14f3>
     ad0:	mov    esi,r10d
     ad3:	mov    r13,QWORD PTR [rsp+0xf8]
     adb:	lea    r11,[rsi+r9*1]
     adf:	lea    rbx,[rsi+r8*1]
     ae3:	add    rsi,QWORD PTR [rsp+0xf0]
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
     aeb:	vmovdqu xmm5,XMMWORD PTR [r12+r11*1]
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
     af1:	vmovdqu xmm6,XMMWORD PTR [r12+rbx*1+0x3]
     af8:	lea    rsi,[r13+rsi*4+0x0]
     afd:	vmovdqu xmm7,XMMWORD PTR [r12+rbx*1]
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
     b03:	vpmovzxbw xmm14,xmm5
     b08:	vpsrldq xmm5,xmm5,0x8
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
     b0d:	vpmovzxbw xmm8,xmm6
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
     b12:	vpmovsxwd xmm15,xmm14
     b17:	vpsrldq xmm14,xmm14,0x8
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
     b1d:	vpmovsxwd xmm21,xmm8
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
     b23:	vpmovsxwd xmm14,xmm14
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
     b28:	vpsrldq xmm8,xmm8,0x8
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
     b2e:	vpmovzxbw xmm5,xmm5
     b33:	vcvtdq2ps xmm15,xmm15
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
     b38:	vcvtdq2ps xmm21,xmm21
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
     b3e:	vcvtdq2ps xmm14,xmm14
                        vp[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
     b43:	vmulps xmm14,xmm14,xmm12
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
     b48:	vpmovsxwd xmm8,xmm8
     b4d:	vpmovzxbw xmm22,xmm7
                        vp[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
     b53:	vmulps xmm15,xmm15,xmm12
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
     b58:	vcvtdq2ps xmm8,xmm8
     b5d:	vpsrldq xmm6,xmm6,0x8
     b62:	vpmovsxwd xmm24,xmm22
     b68:	vcvtdq2ps xmm24,xmm24
     b6e:	vfmadd213ps xmm24,xmm10,XMMWORD PTR [rsi]
     b74:	vpsrldq xmm7,xmm7,0x8
     b79:	vpmovzxbw xmm6,xmm6
     b7e:	vpsrldq xmm22,xmm22,0x8
     b85:	vpmovzxbw xmm7,xmm7
     b8a:	vpmovsxwd xmm22,xmm22
     b90:	vfmadd132ps xmm8,xmm14,xmm11
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
     b95:	vpmovsxwd xmm14,xmm5
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
     b9a:	vcvtdq2ps xmm22,xmm22
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
     ba0:	vpsrldq xmm5,xmm5,0x8
     ba5:	vcvtdq2ps xmm14,xmm14
     baa:	vfmadd132ps xmm21,xmm15,xmm11
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
     bb0:	vpmovsxwd xmm15,xmm6
                        vp[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
     bb5:	vmulps xmm14,xmm14,xmm12
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
     bba:	vpsrldq xmm6,xmm6,0x8
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
     bbf:	vpmovsxwd xmm5,xmm5
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
     bc4:	vcvtdq2ps xmm15,xmm15
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
     bc9:	vcvtdq2ps xmm5,xmm5
                        vp[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
     bcd:	vmulps xmm5,xmm5,xmm12
     bd2:	vfmadd213ps xmm22,xmm10,XMMWORD PTR [rsi+0x10]
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
     bd9:	vpmovsxwd xmm6,xmm6
     bde:	vcvtdq2ps xmm6,xmm6
     be2:	vfmadd132ps xmm15,xmm14,xmm11
     be7:	vfmadd132ps xmm6,xmm5,xmm11
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
     bec:	vmovdqu xmm5,XMMWORD PTR [r12+r11*1+0x3]
     bf3:	vpmovzxbw xmm14,xmm5
     bf8:	vpsrldq xmm5,xmm5,0x8
     bfd:	vpmovsxwd xmm23,xmm14
     c03:	vpsrldq xmm14,xmm14,0x8
     c09:	vpmovzxbw xmm5,xmm5
     c0e:	vcvtdq2ps xmm23,xmm23
     c14:	vfmadd132ps xmm23,xmm24,xmm9
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
     c1a:	vpmovsxwd xmm24,xmm7
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
     c20:	vpmovsxwd xmm14,xmm14
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
     c25:	vpsrldq xmm7,xmm7,0x8
     c2a:	vcvtdq2ps xmm24,xmm24
     c30:	vfmadd213ps xmm24,xmm10,XMMWORD PTR [rsi+0x20]
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
     c37:	vcvtdq2ps xmm14,xmm14
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
     c3c:	vpmovsxwd xmm7,xmm7
     c41:	vfmadd132ps xmm14,xmm22,xmm9
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
     c47:	vpmovsxwd xmm22,xmm5
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
     c4d:	vcvtdq2ps xmm7,xmm7
                        vp[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
     c51:	vfmadd213ps xmm7,xmm10,XMMWORD PTR [rsi+0x30]
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
     c57:	vpsrldq xmm5,xmm5,0x8
     c5c:	vcvtdq2ps xmm22,xmm22
     c62:	vpmovsxwd xmm5,xmm5
     c67:	vcvtdq2ps xmm5,xmm5
                        vp[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
     c6b:	vaddps xmm21,xmm21,xmm23
     c71:	vfmadd132ps xmm22,xmm24,xmm9
     c77:	vaddps xmm8,xmm8,xmm14
     c7c:	vfmadd132ps xmm5,xmm7,xmm9
     c81:	vmovups XMMWORD PTR [rsi],xmm21
     c87:	vmovups XMMWORD PTR [rsi+0x10],xmm8
     c8c:	vaddps xmm15,xmm15,xmm22
     c92:	vaddps xmm5,xmm5,xmm6
     c96:	vmovups XMMWORD PTR [rsi+0x20],xmm15
     c9b:	vmovups XMMWORD PTR [rsi+0x30],xmm5
                    for (int k = 0; k < x_floats - xf; ++k) {
     ca0:	mov    esi,edx
     ca2:	and    esi,0xfffffff0
     ca5:	test   dl,0xf
     ca8:	je     1204 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x1204>
     cae:	add    eax,esi
     cb0:	sub    edx,esi
     cb2:	lea    r11d,[rdx-0x1]
     cb6:	cmp    r11d,0x6
     cba:	jbe    f12 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0xf12>
     cc0:	add    esi,r10d
     cc3:	mov    rbx,QWORD PTR [rsp+0xf8]
     ccb:	mov    esi,esi
     ccd:	lea    r11,[rsi+r8*1]
     cd1:	lea    r10,[rsi+r9*1]
     cd5:	add    rsi,QWORD PTR [rsp+0xf0]
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
     cdd:	vmovq  xmm5,QWORD PTR [r12+r11*1]
     ce3:	lea    rbx,[rbx+rsi*4]
     ce7:	vpmovzxbw xmm7,xmm5
     cec:	vpsrlq xmm5,xmm5,0x20
     cf1:	vpmovzxbw xmm6,xmm5
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
     cf6:	vmovq  xmm5,QWORD PTR [r12+r10*1]
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
     cfc:	vmovq  rsi,xmm6
     d01:	vmovq  xmm6,QWORD PTR [r12+r11*1+0x3]
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
     d08:	vpmovzxbw xmm8,xmm5
     d0d:	vpsrlq xmm5,xmm5,0x20
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
     d12:	vpmovzxbw xmm14,xmm6
     d17:	vpsrlq xmm6,xmm6,0x20
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
     d1c:	vpmovzxbw xmm5,xmm5
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
     d21:	vpmovzxwd xmm15,xmm14
     d26:	vpsrlq xmm14,xmm14,0x20
     d2c:	vpmovzxbw xmm6,xmm6
     d31:	vmovq  xmm15,xmm15
     d36:	vpmovzxwd xmm14,xmm14
     d3b:	vcvtdq2ps xmm22,xmm15
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
     d41:	vpmovzxwd xmm15,xmm8
     d46:	vpsrlq xmm8,xmm8,0x20
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
     d4c:	vmovq  xmm14,xmm14
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
     d51:	vpmovzxwd xmm8,xmm8
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
     d56:	vcvtdq2ps xmm14,xmm14
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
     d5b:	vmovq  xmm21,xmm15
     d61:	vmovq  xmm8,xmm8
     d66:	vcvtdq2ps xmm21,xmm21
     d6c:	vcvtdq2ps xmm8,xmm8
                        vp[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
     d71:	vmulps xmm8,xmm8,xmm12
     d76:	vmulps xmm21,xmm21,xmm12
     d7c:	vfmadd132ps xmm14,xmm8,xmm11
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
     d81:	vpmovzxwd xmm8,xmm6
     d86:	vpsrlq xmm6,xmm6,0x20
     d8b:	vfmadd132ps xmm22,xmm21,xmm11
     d91:	vmovq  xmm8,xmm8
     d96:	vpmovzxwd xmm6,xmm6
     d9b:	vcvtdq2ps xmm15,xmm8
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
     da0:	vmovq  xmm8,QWORD PTR [r12+r10*1+0x3]
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
     da7:	vmovq  xmm6,xmm6
     dab:	vcvtdq2ps xmm6,xmm6
     daf:	vmovaps xmm24,xmm14
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
     db5:	vpmovzxwd xmm14,xmm5
     dba:	vpsrlq xmm5,xmm5,0x20
     dbf:	vmovq  xmm14,xmm14
     dc4:	vpmovzxwd xmm5,xmm5
     dc9:	vcvtdq2ps xmm14,xmm14
                        vp[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
     dce:	vmulps xmm14,xmm14,xmm12
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
     dd3:	vmovq  xmm5,xmm5
     dd7:	vcvtdq2ps xmm5,xmm5
                        vp[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
     ddb:	vmulps xmm5,xmm5,xmm12
     de0:	vfmadd132ps xmm15,xmm14,xmm11
     de5:	vmovq  xmm14,QWORD PTR [rbx]
     de9:	vfmadd132ps xmm6,xmm5,xmm11
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
     dee:	vpmovzxbw xmm5,xmm8
     df3:	vpsrlq xmm8,xmm8,0x20
     df9:	vpmovzxbw xmm8,xmm8
     dfe:	vmovaps xmm26,xmm15
     e04:	vmovaps xmm21,xmm6
     e0a:	vpmovzxwd xmm6,xmm5
     e0f:	vmovq  xmm6,xmm6
     e13:	vpsrlq xmm5,xmm5,0x20
     e18:	vcvtdq2ps xmm15,xmm6
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
     e1c:	vpmovzxwd xmm6,xmm7
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
     e21:	vpmovzxwd xmm5,xmm5
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
     e26:	vmovq  xmm6,xmm6
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
     e2a:	vmovq  xmm25,xmm5
     e30:	vpmovzxwd xmm5,xmm8
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
     e35:	vcvtdq2ps xmm6,xmm6
     e39:	vfmadd231ps xmm14,xmm6,xmm10
     e3e:	vpsrlq xmm6,xmm7,0x20
     e43:	vmovq  xmm7,rsi
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
     e48:	vcvtdq2ps xmm25,xmm25
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
     e4e:	vpmovzxwd xmm6,xmm6
     e53:	vpmovzxwd xmm7,xmm7
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
     e58:	vmovq  xmm5,xmm5
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
     e5c:	vmovq  xmm6,xmm6
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
     e60:	vcvtdq2ps xmm5,xmm5
     e64:	vpsrlq xmm8,xmm8,0x20
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
     e6a:	vmovq  xmm7,xmm7
     e6e:	vcvtdq2ps xmm7,xmm7
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
     e72:	vpmovzxwd xmm8,xmm8
     e77:	vmovq  xmm8,xmm8
     e7c:	vfmadd132ps xmm15,xmm14,xmm9
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
     e81:	vcvtdq2ps xmm14,xmm6
                        vp[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
     e85:	vmovq  xmm6,QWORD PTR [rbx+0x8]
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
     e8a:	vcvtdq2ps xmm8,xmm8
     e8f:	vfmadd231ps xmm6,xmm14,xmm10
                        vp[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
     e94:	vmovq  xmm14,QWORD PTR [rbx+0x10]
     e99:	vfmadd132ps xmm7,xmm14,xmm10
     e9e:	vmovaps xmm23,xmm15
     ea4:	vmovq  xmm15,QWORD PTR [rbx+0x18]
     ea9:	vfmadd132ps xmm25,xmm6,xmm9
     eaf:	vfmadd132ps xmm5,xmm7,xmm9
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
     eb4:	vmovq  xmm7,rsi
     eb9:	mov    esi,edx
     ebb:	vpsrlq xmm14,xmm7,0x20
     ec0:	and    esi,0xfffffff8
     ec3:	and    edx,0x7
     ec6:	vpmovzxwd xmm14,xmm14
     ecb:	vmovq  xmm14,xmm14
                        vp[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
     ed0:	vaddps xmm7,xmm24,xmm25
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
     ed6:	vcvtdq2ps xmm14,xmm14
                        vp[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
     edb:	vfmadd132ps xmm14,xmm15,xmm10
     ee0:	vaddps xmm5,xmm26,xmm5
     ee6:	vmovlps QWORD PTR [rbx+0x8],xmm7
     eeb:	vmovlps QWORD PTR [rbx+0x10],xmm5
     ef0:	vfmadd132ps xmm8,xmm14,xmm9
     ef5:	vaddps xmm14,xmm8,xmm21
     efb:	vaddps xmm8,xmm22,xmm23
     f01:	vmovlps QWORD PTR [rbx+0x18],xmm14
     f06:	vmovlps QWORD PTR [rbx],xmm8
     f0a:	je     1204 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x1204>
     f10:	add    eax,esi
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
     f12:	movsxd rdx,eax
                        vp[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
     f15:	mov    ebx,DWORD PTR [rsp+0x100]
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
     f1c:	lea    r10,[rdx+r8*1]
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
     f20:	add    rdx,r9
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
     f23:	movzx  r11d,BYTE PTR [r12+r10*1]
     f28:	movzx  r10d,BYTE PTR [r12+r10*1+0x3]
                        vp[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
     f2e:	lea    esi,[rbx+rax*1]
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
     f31:	vcvtusi2ss xmm5,xmm4,r11d
     f37:	vmovaps xmm7,xmm5
     f3b:	vcvtusi2ss xmm5,xmm4,r10d
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
     f41:	movzx  r10d,BYTE PTR [r12+rdx*1]
     f46:	movzx  edx,BYTE PTR [r12+rdx*1+0x3]
     f4c:	vfmadd213ss xmm7,xmm19,DWORD PTR [r15+rsi*4]
     f53:	vcvtusi2ss xmm6,xmm4,r10d
                        vp[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
     f59:	vmulss xmm6,xmm6,xmm17
     f5f:	vfmadd231ss xmm6,xmm18,xmm5
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
     f65:	vcvtusi2ss xmm5,xmm4,edx
                        vp[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
     f6b:	vfmadd132ss xmm5,xmm7,xmm16
     f71:	vaddss xmm5,xmm5,xmm6
     f75:	vmovss DWORD PTR [r15+rsi*4],xmm5
                    for (int k = 0; k < x_floats - xf; ++k) {
     f7b:	lea    esi,[rax+0x1]
     f7e:	cmp    esi,edi
     f80:	jge    1204 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x1204>
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
     f86:	mov    edx,esi
                        vp[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
     f88:	add    esi,ebx
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
     f8a:	lea    r10,[rdx+r8*1]
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
     f8e:	add    rdx,r9
                        vp[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
     f91:	mov    esi,esi
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
     f93:	movzx  r11d,BYTE PTR [r12+r10*1]
     f98:	movzx  r10d,BYTE PTR [r12+r10*1+0x3]
     f9e:	vcvtusi2ss xmm5,xmm4,r11d
     fa4:	vmovaps xmm7,xmm5
     fa8:	vcvtusi2ss xmm5,xmm4,r10d
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
     fae:	movzx  r10d,BYTE PTR [r12+rdx*1]
     fb3:	movzx  edx,BYTE PTR [r12+rdx*1+0x3]
     fb9:	vfmadd213ss xmm7,xmm19,DWORD PTR [r15+rsi*4]
     fc0:	vcvtusi2ss xmm6,xmm4,r10d
                        vp[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
     fc6:	vmulss xmm6,xmm6,xmm17
     fcc:	vfmadd231ss xmm6,xmm18,xmm5
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
     fd2:	vcvtusi2ss xmm5,xmm4,edx
                        vp[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
     fd8:	vfmadd132ss xmm5,xmm7,xmm16
     fde:	vaddss xmm5,xmm5,xmm6
     fe2:	vmovss DWORD PTR [r15+rsi*4],xmm5
                    for (int k = 0; k < x_floats - xf; ++k) {
     fe8:	lea    esi,[rax+0x2]
     feb:	cmp    esi,edi
     fed:	jge    1204 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x1204>
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
     ff3:	mov    edx,esi
                        vp[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
     ff5:	add    esi,ebx
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
     ff7:	lea    r10,[rdx+r8*1]
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
     ffb:	add    rdx,r9
                        vp[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
     ffe:	mov    esi,esi
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
    1000:	movzx  r11d,BYTE PTR [r12+r10*1]
    1005:	movzx  r10d,BYTE PTR [r12+r10*1+0x3]
    100b:	vcvtusi2ss xmm5,xmm4,r11d
    1011:	vmovaps xmm7,xmm5
    1015:	vcvtusi2ss xmm5,xmm4,r10d
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
    101b:	movzx  r10d,BYTE PTR [r12+rdx*1]
    1020:	movzx  edx,BYTE PTR [r12+rdx*1+0x3]
    1026:	vfmadd213ss xmm7,xmm19,DWORD PTR [r15+rsi*4]
    102d:	vcvtusi2ss xmm6,xmm4,r10d
                        vp[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    1033:	vmulss xmm6,xmm6,xmm17
    1039:	vfmadd231ss xmm6,xmm18,xmm5
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
    103f:	vcvtusi2ss xmm5,xmm4,edx
                        vp[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    1045:	vfmadd132ss xmm5,xmm7,xmm16
    104b:	vaddss xmm5,xmm5,xmm6
    104f:	vmovss DWORD PTR [r15+rsi*4],xmm5
                    for (int k = 0; k < x_floats - xf; ++k) {
    1055:	lea    esi,[rax+0x3]
    1058:	cmp    esi,edi
    105a:	jge    1204 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x1204>
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
    1060:	mov    edx,esi
                        vp[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    1062:	add    esi,ebx
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
    1064:	lea    r10,[rdx+r8*1]
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
    1068:	add    rdx,r9
                        vp[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    106b:	mov    esi,esi
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
    106d:	movzx  r11d,BYTE PTR [r12+r10*1]
    1072:	movzx  r10d,BYTE PTR [r12+r10*1+0x3]
    1078:	vcvtusi2ss xmm5,xmm4,r11d
    107e:	vmovaps xmm7,xmm5
    1082:	vcvtusi2ss xmm5,xmm4,r10d
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
    1088:	movzx  r10d,BYTE PTR [r12+rdx*1]
    108d:	movzx  edx,BYTE PTR [r12+rdx*1+0x3]
    1093:	vfmadd213ss xmm7,xmm19,DWORD PTR [r15+rsi*4]
    109a:	vcvtusi2ss xmm6,xmm4,r10d
                        vp[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    10a0:	vmulss xmm6,xmm6,xmm17
    10a6:	vfmadd231ss xmm6,xmm18,xmm5
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
    10ac:	vcvtusi2ss xmm5,xmm4,edx
                        vp[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    10b2:	vfmadd132ss xmm5,xmm7,xmm16
    10b8:	vaddss xmm5,xmm5,xmm6
    10bc:	vmovss DWORD PTR [r15+rsi*4],xmm5
                    for (int k = 0; k < x_floats - xf; ++k) {
    10c2:	lea    esi,[rax+0x4]
    10c5:	cmp    esi,edi
    10c7:	jge    1204 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x1204>
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
    10cd:	mov    edx,esi
                        vp[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    10cf:	add    esi,ebx
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
    10d1:	lea    r10,[rdx+r8*1]
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
    10d5:	add    rdx,r9
                        vp[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    10d8:	mov    esi,esi
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
    10da:	movzx  r11d,BYTE PTR [r12+r10*1]
    10df:	movzx  r10d,BYTE PTR [r12+r10*1+0x3]
    10e5:	vcvtusi2ss xmm5,xmm4,r11d
    10eb:	vmovaps xmm7,xmm5
    10ef:	vcvtusi2ss xmm5,xmm4,r10d
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
    10f5:	movzx  r10d,BYTE PTR [r12+rdx*1]
    10fa:	movzx  edx,BYTE PTR [r12+rdx*1+0x3]
    1100:	vfmadd213ss xmm7,xmm19,DWORD PTR [r15+rsi*4]
    1107:	vcvtusi2ss xmm6,xmm4,r10d
                        vp[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    110d:	vmulss xmm6,xmm6,xmm17
    1113:	vfmadd231ss xmm6,xmm18,xmm5
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
    1119:	vcvtusi2ss xmm5,xmm4,edx
                        vp[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    111f:	vfmadd132ss xmm5,xmm7,xmm16
    1125:	vaddss xmm5,xmm5,xmm6
    1129:	vmovss DWORD PTR [r15+rsi*4],xmm5
                    for (int k = 0; k < x_floats - xf; ++k) {
    112f:	lea    esi,[rax+0x5]
    1132:	cmp    edi,esi
    1134:	jle    1204 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x1204>
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
    113a:	mov    edx,esi
                        vp[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    113c:	add    esi,ebx
                    for (int k = 0; k < x_floats - xf; ++k) {
    113e:	add    eax,0x6
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
    1141:	lea    r10,[r8+rdx*1]
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
    1145:	add    rdx,r9
                        vp[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    1148:	mov    esi,esi
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
    114a:	movzx  r11d,BYTE PTR [r12+r10*1]
    114f:	movzx  r10d,BYTE PTR [r12+r10*1+0x3]
    1155:	vcvtusi2ss xmm5,xmm4,r11d
    115b:	vmovaps xmm7,xmm5
    115f:	vcvtusi2ss xmm5,xmm4,r10d
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
    1165:	movzx  r10d,BYTE PTR [r12+rdx*1]
    116a:	movzx  edx,BYTE PTR [r12+rdx*1+0x3]
    1170:	vfmadd213ss xmm7,xmm19,DWORD PTR [r15+rsi*4]
    1177:	vcvtusi2ss xmm6,xmm4,r10d
                        vp[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    117d:	vmulss xmm6,xmm6,xmm17
    1183:	vfmadd231ss xmm6,xmm18,xmm5
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
    1189:	vcvtusi2ss xmm5,xmm4,edx
                        vp[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    118f:	vfmadd132ss xmm5,xmm7,xmm16
    1195:	vaddss xmm5,xmm5,xmm6
    1199:	vmovss DWORD PTR [r15+rsi*4],xmm5
                    for (int k = 0; k < x_floats - xf; ++k) {
    119f:	cmp    edi,eax
    11a1:	jle    1204 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x1204>
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
    11a3:	mov    edx,eax
                        vp[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    11a5:	add    eax,ebx
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
    11a7:	add    r8,rdx
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
    11aa:	add    rdx,r9
                        vp[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    11ad:	mov    eax,eax
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
    11af:	movzx  esi,BYTE PTR [r12+r8*1]
    11b4:	vcvtusi2ss xmm5,xmm4,esi
    11ba:	movzx  esi,BYTE PTR [r12+r8*1+0x3]
    11c0:	vmovaps xmm7,xmm5
    11c4:	vcvtusi2ss xmm5,xmm4,esi
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
    11ca:	movzx  esi,BYTE PTR [r12+rdx*1]
    11cf:	movzx  edx,BYTE PTR [r12+rdx*1+0x3]
    11d5:	vfmadd213ss xmm7,xmm19,DWORD PTR [r15+rax*4]
    11dc:	vcvtusi2ss xmm6,xmm4,esi
                        vp[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    11e2:	vmulss xmm6,xmm6,xmm17
    11e8:	vfmadd231ss xmm6,xmm18,xmm5
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
    11ee:	vcvtusi2ss xmm5,xmm4,edx
                        vp[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    11f4:	vfmadd132ss xmm5,xmm7,xmm16
    11fa:	vaddss xmm5,xmm5,xmm6
    11fe:	vmovss DWORD PTR [r15+rax*4],xmm5
                for (int y = y_begin; y < y_end; ++y) {
    1204:	inc    DWORD PTR [rsp+0x118]
    120b:	mov    rdi,QWORD PTR [rsp+0xc0]
    1213:	mov    rbx,QWORD PTR [rsp+0xd0]
    121b:	add    r15,QWORD PTR [rsp+0xc8]
    1223:	add    rcx,rdi
    1226:	add    r14,rdi
    1229:	add    QWORD PTR [rsp+0xe8],rbx
    1231:	mov    eax,DWORD PTR [rsp+0x118]
    1238:	cmp    eax,DWORD PTR [rsp+0xd8]
    123f:	jl     690 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x690>
    1245:	mov    rdx,QWORD PTR [rsp+0x88]
    124d:	mov    r10,QWORD PTR [rsp+0x80]
    1255:	mov    r15d,DWORD PTR [rsp+0x90]
    125d:	mov    r13d,DWORD PTR [rsp+0x7c]
    1262:	mov    r9d,DWORD PTR [rsp+0x78]
            for (const SubParams& p : params) {
    1267:	add    rdx,0x30
    126b:	cmp    QWORD PTR [rsp+0x98],rdx
    1273:	jne    520 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x520>
    1279:	mov    r11,QWORD PTR [rsp+0x68]
    127e:	mov    ecx,DWORD PTR [rsp+0x34]
    1282:	mov    r12,QWORD PTR [rsp+0x60]
            for (int y = ty; y < tile_y_end; ++y) {
    1287:	cmp    DWORD PTR [rsp+0x30],r15d
    128c:	jge    13a6 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x13a6>
    1292:	test   ecx,ecx
    1294:	jle    13a6 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x13a6>
    129a:	lea    rax,[r11+r11*2]
    129e:	mov    rdi,QWORD PTR [rsp+0xf8]
    12a6:	mov    r9,QWORD PTR [rsp+0x20]
    12ab:	lea    r8d,[rcx+rcx*2]
    12af:	lea    r13,[rax*4+0x0]
    12b7:	mov    rax,QWORD PTR [rsp+0x48]
    12bc:	mov    r11d,DWORD PTR [rsp+0x50]
                    outp[x*3    ] = (unsigned char)std::clamp(vp[x*3    ] * inv_c + 0.5f, 0.0f, 255.0f);
    12c1:	vmovss xmm3,DWORD PTR [rip+0x0]        # 12c9 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x12c9>
    12c9:	vmovss xmm6,DWORD PTR [rip+0x0]        # 12d1 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x12d1>
    12d1:	mov    r14,QWORD PTR [rsp+0x40]
    12d6:	lea    rbx,[rax+r12*4]
    12da:	nop    WORD PTR [rax+rax*1+0x0]
                unsigned char* outp = output.data.data() + (size_t)(y * width + tx) * 3;
    12e0:	lea    rax,[r9+r12*1]
                    outp[x*3 + 1] = (unsigned char)std::clamp(vp[x*3 + 1] * inv_c + 0.5f, 0.0f, 255.0f);
                    outp[x*3 + 2] = (unsigned char)std::clamp(vp[x*3 + 2] * inv_c + 0.5f, 0.0f, 255.0f);
    12e4:	mov    QWORD PTR [rsp+0x118],r9
    12ec:	vmovss xmm2,DWORD PTR [rip+0x0]        # 12f4 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x12f4>
    12f4:	lea    rcx,[rbx+r9*4]
                unsigned char* outp = output.data.data() + (size_t)(y * width + tx) * 3;
    12f8:	lea    rsi,[rax+rax*2]
                    outp[x*3 + 2] = (unsigned char)std::clamp(vp[x*3 + 2] * inv_c + 0.5f, 0.0f, 255.0f);
    12fc:	vmovss xmm5,DWORD PTR [rip+0x0]        # 1304 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x1304>
                unsigned char* outp = output.data.data() + (size_t)(y * width + tx) * 3;
    1304:	xor    edx,edx
    1306:	add    rsi,QWORD PTR [r14+0x10]
    130a:	nop    WORD PTR [rax+rax*1+0x0]
                    int c = counts[y * width + (tx + x)];
    1310:	mov    eax,DWORD PTR [rcx]
                    if (c == 0) continue;
    1312:	test   eax,eax
    1314:	je     1380 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x1380>
                    float inv_c = 1.0f / (float)c;
    1316:	vcvtsi2ss xmm0,xmm4,eax
                    outp[x*3    ] = (unsigned char)std::clamp(vp[x*3    ] * inv_c + 0.5f, 0.0f, 255.0f);
    131a:	mov    eax,edx
      if (__a < __b)
    131c:	xor    r9d,r9d
                    float inv_c = 1.0f / (float)c;
    131f:	vdivss xmm0,xmm20,xmm0
                    outp[x*3    ] = (unsigned char)std::clamp(vp[x*3    ] * inv_c + 0.5f, 0.0f, 255.0f);
    1325:	vmulss xmm1,xmm0,DWORD PTR [rdi+rax*4]
    132a:	vcomiss xmm13,xmm1
    132e:	ja     133c <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x133c>
    1330:	vaddss xmm1,xmm1,xmm3
      if (__b < __a)
    1334:	vminss xmm1,xmm1,xmm6
    1338:	vcvttss2si r9d,xmm1
                    outp[x*3 + 1] = (unsigned char)std::clamp(vp[x*3 + 1] * inv_c + 0.5f, 0.0f, 255.0f);
    133c:	vmulss xmm1,xmm0,DWORD PTR [rdi+rax*4+0x4]
                    outp[x*3    ] = (unsigned char)std::clamp(vp[x*3    ] * inv_c + 0.5f, 0.0f, 255.0f);
    1342:	mov    BYTE PTR [rsi+rax*1],r9b
      if (__a < __b)
    1346:	xor    r9d,r9d
    1349:	vcomiss xmm13,xmm1
    134d:	ja     135b <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x135b>
                    outp[x*3 + 1] = (unsigned char)std::clamp(vp[x*3 + 1] * inv_c + 0.5f, 0.0f, 255.0f);
    134f:	vaddss xmm1,xmm1,xmm3
      if (__b < __a)
    1353:	vminss xmm1,xmm1,xmm2
    1357:	vcvttss2si r9d,xmm1
                    outp[x*3 + 2] = (unsigned char)std::clamp(vp[x*3 + 2] * inv_c + 0.5f, 0.0f, 255.0f);
    135b:	vmulss xmm0,xmm0,DWORD PTR [rdi+rax*4+0x8]
                    outp[x*3 + 1] = (unsigned char)std::clamp(vp[x*3 + 1] * inv_c + 0.5f, 0.0f, 255.0f);
    1361:	mov    BYTE PTR [rsi+rax*1+0x1],r9b
      if (__a < __b)
    1366:	xor    r9d,r9d
    1369:	vcomiss xmm13,xmm0
    136d:	ja     137b <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x137b>
                    outp[x*3 + 2] = (unsigned char)std::clamp(vp[x*3 + 2] * inv_c + 0.5f, 0.0f, 255.0f);
    136f:	vaddss xmm0,xmm0,xmm5
      if (__b < __a)
    1373:	vminss xmm0,xmm0,xmm2
    1377:	vcvttss2si r9d,xmm0
    137b:	mov    BYTE PTR [rsi+rax*1+0x2],r9b
                for (int x = 0; x < tile_w_actual; ++x) {
    1380:	add    edx,0x3
    1383:	add    rcx,0x4
    1387:	cmp    edx,r8d
    138a:	jne    1310 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x1310>
            for (int y = ty; y < tile_y_end; ++y) {
    138c:	mov    r9,QWORD PTR [rsp+0x118]
    1394:	inc    r11d
    1397:	add    rdi,r13
    139a:	add    r9,r10
    139d:	cmp    r15d,r11d
    13a0:	jne    12e0 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x12e0>
        for (int tx = 0; tx < w; tx += TILE_W) {
    13a6:	add    r12,0x7f0
    13ad:	cmp    DWORD PTR [rsp+0x54],r12d
    13b2:	jg     43a <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x43a>
    for (int ty = 0; ty < h; ty += TILE_H) {
    13b8:	add    QWORD PTR [rsp+0x58],0x8
    13be:	mov    rcx,QWORD PTR [rsp+0x20]
    13c3:	mov    r12,QWORD PTR [rsp+0x8]
    13c8:	mov    r14d,DWORD PTR [rsp+0x18]
    13cd:	add    rcx,r12
    13d0:	cmp    r14d,DWORD PTR [rsp+0x58]
    13d5:	jg     403 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x403>
    13db:	mov    r12,QWORD PTR [rsp+0x10]
    13e0:	vzeroupper
	_GLIBCXX_OPERATOR_DELETE(_GLIBCXX_SIZED_DEALLOC(__p, __n));
    13e3:	mov    rdi,QWORD PTR [rsp+0xf8]
    13eb:	mov    esi,0x2fa00
    13f0:	call   13f5 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x13f5>
    13f5:	mov    rax,QWORD PTR [rsp+0x48]
    13fa:	test   rax,rax
    13fd:	je     140a <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x140a>
    13ff:	mov    rsi,r12
    1402:	mov    rdi,rax
    1405:	call   140a <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x140a>
    140a:	mov    rax,QWORD PTR [rsp+0x70]
    140f:	test   rax,rax
    1412:	je     1421 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x1421>
    1414:	mov    rsi,QWORD PTR [rsp+0x28]
    1419:	mov    rdi,rax
    141c:	call   1421 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x1421>
            }
        }
    }

    return output;
}
    1421:	mov    rax,QWORD PTR [rsp+0x40]
    1426:	lea    rsp,[rbp-0x28]
    142a:	pop    rbx
    142b:	pop    r12
    142d:	pop    r13
    142f:	pop    r14
    1431:	pop    r15
    1433:	pop    rbp
    1434:	ret
    1435:	nop    DWORD PTR [rax]
                    for (int k = 0; k < x_floats - xf; ++k) {
    1438:	mov    rsi,QWORD PTR [rsp+0xe0]
    1440:	lea    r8,[r15+r10*4]
    1444:	xor    eax,eax
    1446:	cs nop WORD PTR [rax+rax*1+0x0]
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
    1450:	movzx  r9d,BYTE PTR [rsi+rax*1]
    1455:	vcvtusi2ss xmm5,xmm4,r9d
    145b:	movzx  r9d,BYTE PTR [rsi+rax*1+0x3]
    1461:	vmovaps xmm7,xmm5
    1465:	vcvtusi2ss xmm5,xmm4,r9d
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
    146b:	movzx  r9d,BYTE PTR [rdx+rax*1]
    1470:	vfmadd213ss xmm7,xmm19,DWORD PTR [r8+rax*4]
    1477:	vcvtusi2ss xmm6,xmm4,r9d
    147d:	movzx  r9d,BYTE PTR [rdx+rax*1+0x3]
                        vp[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    1483:	vmulss xmm6,xmm6,xmm17
    1489:	vfmadd231ss xmm6,xmm18,xmm5
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
    148f:	vcvtusi2ss xmm5,xmm4,r9d
                        vp[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
    1495:	vfmadd132ss xmm5,xmm7,xmm16
    149b:	vaddss xmm5,xmm5,xmm6
    149f:	vmovss DWORD PTR [r8+rax*4],xmm5
                    for (int k = 0; k < x_floats - xf; ++k) {
    14a5:	inc    rax
    14a8:	cmp    edi,eax
    14aa:	jg     1450 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x1450>
    14ac:	jmp    1204 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x1204>
    14b1:	nop    DWORD PTR [rax+0x0]
                    if (xf + 8 <= x_floats) {
    14b8:	mov    edi,DWORD PTR [rsp+0x110]
    14bf:	cmp    edi,0x7
    14c2:	jg     14fa <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x14fa>
                    int xf = 0;
    14c4:	mov    DWORD PTR [rsp+0x100],0x0
                    if (xf + 8 <= x_floats) {
    14cf:	mov    r9,r14
    14d2:	mov    r8,rcx
    14d5:	xor    r10d,r10d
    14d8:	jmp    80e <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x80e>
                    int xf = 0;
    14dd:	xor    r10d,r10d
    14e0:	mov    edx,edi
                    for (int k = 0; k < x_floats - xf; ++k) {
    14e2:	xor    eax,eax
    14e4:	sub    edx,r10d
    14e7:	lea    esi,[rdx-0x1]
    14ea:	cmp    esi,0xe
    14ed:	ja     ad0 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0xad0>
    14f3:	xor    esi,esi
    14f5:	jmp    cb0 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0xcb0>
                    if (xf + 8 <= x_floats) {
    14fa:	mov    DWORD PTR [rsp+0x100],0x8
    1505:	mov    rax,r15
    1508:	mov    rdx,r14
    150b:	mov    rsi,rcx
    150e:	jmp    7a8 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x7a8>
        for (const auto& p : params) {
    1513:	mov    rcx,QWORD PTR [rsp+0x98]
	return __n != 0 ? _Tr::allocate(_M_impl, __n) : pointer();
    151b:	xor    edi,edi
    151d:	cmp    QWORD PTR [rsp+0x70],rcx
    1522:	jne    275 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x275>
        for (int y = 0; y < h; ++y) {
    1528:	test   r14d,r14d
    152b:	jle    387 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x387>
    1531:	mov    esi,DWORD PTR [rsp+0x54]
    1535:	test   esi,esi
    1537:	jg     2d0 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x2d0>
    153d:	jmp    387 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x387>
    1542:	nop    WORD PTR [rax+rax*1+0x0]
	: _M_start(), _M_finish(), _M_end_of_storage()
    1548:	mov    QWORD PTR [rsp+0x70],0x0
    const int h = static_cast<int>(height);
    1551:	mov    r14d,edx
    1554:	xor    r13d,r13d
    const int w = static_cast<int>(width);
    1557:	vmovd  DWORD PTR [rsp+0x54],xmm0
    for (auto& sub : subapertures) {
    155d:	cmp    rbx,rcx
    1560:	jne    bf <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0xbf>
    1566:	mov    QWORD PTR [rsp+0x98],0x0
	return __n != 0 ? _Tr::allocate(_M_impl, __n) : pointer();
    1572:	mov    QWORD PTR [rsp+0x48],0x0
    157b:	jmp    218 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x218>
	ptrdiff_t __dif = this->_M_impl._M_finish - this->_M_impl._M_start;
    1580:	mov    rax,r13
    1583:	sub    rax,r15
    1586:	mov    QWORD PTR [rsp+0x110],rax
    158e:	sar    rax,0x4
    1592:	mov    rdx,rax
    1595:	movabs rax,0xaaaaaaaaaaaaaaab
    159f:	imul   rdx,rax
	if (max_size() - size() < __n)
    15a3:	movabs rax,0x2aaaaaaaaaaaaaa
    15ad:	cmp    rdx,rax
    15b0:	je     15b6 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x15b6>
      if (__a < __b)
    15b6:	test   rdx,rdx
    15b9:	mov    eax,0x1
    15be:	mov    DWORD PTR [rsp+0xa0],r11d
    15c6:	cmovne rax,rdx
    15ca:	mov    DWORD PTR [rsp+0xa8],ecx
    15d1:	mov    DWORD PTR [rsp+0xb0],r9d
	const size_type __len = size() + (std::max)(size(), __n);
    15d9:	add    rax,rdx
	return (__len < size() || __len > max_size()) ? max_size() : __len;
    15dc:	movabs rdx,0x2aaaaaaaaaaaaaa
    15e6:	mov    DWORD PTR [rsp+0xb8],r8d
    15ee:	cmp    rax,rdx
    15f1:	mov    DWORD PTR [rsp+0xd8],esi
    15f8:	cmova  rax,rdx
    15fc:	mov    DWORD PTR [rsp+0xdc],r10d
      allocate(size_type __n, const void* = static_cast<const void*>(0))
    1604:	vmovss DWORD PTR [rsp+0xbc],xmm3
	  return static_cast<_Tp*>(_GLIBCXX_OPERATOR_NEW(__n * sizeof(_Tp)));
    160d:	lea    rax,[rax+rax*2]
    1611:	vmovss DWORD PTR [rsp+0xc0],xmm0
    161a:	shl    rax,0x4
    161e:	vmovss DWORD PTR [rsp+0xc8],xmm1
    1627:	mov    rdi,rax
    162a:	mov    QWORD PTR [rsp+0xe8],rax
    1632:	vmovss DWORD PTR [rsp+0xd0],xmm2
    163b:	call   1640 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x1640>
	// taking the element by lvalue ref (see last bullet of C++11
	// [res.on.arguments]).

	// If this throws, the existing elements are unchanged.
#if __cplusplus >= 201103L
	_Alloc_traits::construct(this->_M_impl,
    1640:	mov    rdx,QWORD PTR [rsp+0x110]
	{ ::new((void *)__p) _Up(std::forward<_Args>(__args)...); }
    1648:	mov    ecx,DWORD PTR [rsp+0xa8]
	  return static_cast<_Tp*>(_GLIBCXX_OPERATOR_NEW(__n * sizeof(_Tp)));
    164f:	mov    QWORD PTR [rsp+0xf8],rax
    1657:	mov    rdi,rax
	{ ::new((void *)__p) _Up(std::forward<_Args>(__args)...); }
    165a:	vmovss xmm0,DWORD PTR [rsp+0xc0]
    1663:	vmovss xmm2,DWORD PTR [rsp+0xd0]
    166c:	mov    r10d,DWORD PTR [rsp+0xdc]
    1674:	mov    esi,DWORD PTR [rsp+0xd8]
    167b:	mov    DWORD PTR [rax+rdx*1+0x1c],ecx
    167f:	vinsertps xmm0,xmm0,DWORD PTR [rsp+0xbc],0x10
    168a:	vinsertps xmm2,xmm2,DWORD PTR [rsp+0xc8],0x10
    1695:	mov    r8d,DWORD PTR [rsp+0xb8]
    169d:	mov    r9d,DWORD PTR [rsp+0xb0]
    16a5:	mov    DWORD PTR [rax+rdx*1],r10d
    16a9:	mov    r11d,DWORD PTR [rsp+0xa0]
    16b1:	mov    rcx,QWORD PTR [rsp+0xf0]
    16b9:	vmovlhps xmm2,xmm2,xmm0
    16bd:	mov    DWORD PTR [rax+rdx*1+0x4],esi
    16c1:	mov    DWORD PTR [rax+rdx*1+0x18],r8d
    16c6:	mov    DWORD PTR [rax+rdx*1+0x20],r9d
    16cb:	mov    DWORD PTR [rax+rdx*1+0x24],r11d
    16d0:	mov    QWORD PTR [rax+rdx*1+0x28],rcx
    16d5:	vmovups XMMWORD PTR [rax+rdx*1+0x8],xmm2
    __relocate_a_1(_Tp* __first, _Tp* __last,
		   _Tp* __result,
		   [[__maybe_unused__]] allocator<_Up>& __alloc) noexcept
    {
      ptrdiff_t __count = __last - __first;
      if (__count > 0)
    16db:	test   rdx,rdx
    16de:	je     16e8 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x16e8>
	      __gnu_cxx::__normal_iterator<_Tp*, void> __out(__result);
	      __out = std::__relocate_a_1(__first, __last, __out, __alloc);
	      return __out.base();
	    }
#endif
	  __builtin_memcpy(__result, __first, __count * sizeof(_Tp));
    16e0:	mov    rsi,r15
    16e3:	call   16e8 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x16e8>
	  {
	    // Relocation cannot throw.
	    __new_finish = std::__relocate_a(__old_start, __old_finish,
					     __new_start,
					     _M_get_Tp_allocator());
	    ++__new_finish;
    16e8:	mov    rax,QWORD PTR [rsp+0xf8]
    16f0:	mov    rcx,QWORD PTR [rsp+0x110]
    16f8:	lea    rax,[rax+rcx*1+0x30]
    16fd:	mov    QWORD PTR [rsp+0x70],rax
	  if (_M_storage)
    1702:	test   r15,r15
    1705:	je     1715 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x1715>
	    // New storage has been fully initialized, destroy the old elements.
	    __guard_elts._M_first = __old_start;
	    __guard_elts._M_last = __old_finish;
	  }
	__guard._M_storage = __old_start;
	__guard._M_len = this->_M_impl._M_end_of_storage - __old_start;
    1707:	mov    rsi,r13
	_GLIBCXX_OPERATOR_DELETE(_GLIBCXX_SIZED_DEALLOC(__p, __n));
    170a:	mov    rdi,r15
    170d:	sub    rsi,r15
    1710:	call   1715 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x1715>
      // deallocate should be called before assignments to _M_impl,
      // to avoid call-clobbering

      this->_M_impl._M_start = __new_start;
      this->_M_impl._M_finish = __new_finish;
      this->_M_impl._M_end_of_storage = __new_start + __len;
    1715:	mov    r13,QWORD PTR [rsp+0xe8]
    171d:	mov    r15,QWORD PTR [rsp+0xf8]
    1725:	add    r13,r15
    1728:	jmp    1b5 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x1b5>
    output.data.assign(width * height * 3, 0);
    172d:	lea    r14,[r12+r12*2]
	if (__n > _S_max_size(_Tp_alloc_type(__a)))
    1731:	test   r14,r14
    1734:	js     173a <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x173a>
	  return static_cast<_Tp*>(_GLIBCXX_OPERATOR_NEW(__n * sizeof(_Tp)));
    173a:	mov    rdi,r14
    173d:	call   1742 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x1742>
		      __builtin_memset(__dest, (unsigned char)__x, __n);
    1742:	xor    esi,esi
    1744:	mov    rdx,r14
	this->_M_impl._M_end_of_storage = this->_M_impl._M_start + __n;
    1747:	lea    r15,[rax+r14*1]
    174b:	mov    rdi,rax
    174e:	call   1753 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x1753>
    1753:	mov    rcx,rax
	  _M_start = __x._M_start;
    1756:	mov    rax,QWORD PTR [rsp+0x40]
    175b:	mov    QWORD PTR [rax+0x10],rcx
	  _M_finish = __x._M_finish;
    175f:	mov    QWORD PTR [rax+0x18],r15
	  _M_end_of_storage = __x._M_end_of_storage;
    1763:	mov    QWORD PTR [rax+0x20],r15
	ptrdiff_t __dif = this->_M_impl._M_finish - this->_M_impl._M_start;
    1767:	mov    rax,QWORD PTR [r13+0x8]
    176b:	mov    QWORD PTR [rsp+0x118],rax
      if (this->capacity() < __n)
    1773:	sub    rax,rbx
    1776:	mov    QWORD PTR [rsp+0x28],rax
    177b:	jne    8b <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x8b>
	: _M_start(), _M_finish(), _M_end_of_storage()
    1781:	mov    QWORD PTR [rsp+0x70],0x0
    178a:	xor    r13d,r13d
    178d:	jmp    a1 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0xa1>
        for (int y = 0; y < h; ++y) {
    1792:	test   r14d,r14d
    1795:	jle    37f <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x37f>
    179b:	mov    eax,DWORD PTR [rsp+0x54]
    179f:	test   eax,eax
    17a1:	jg     2d0 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x2d0>
    17a7:	jmp    37f <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x37f>
    for (auto& sub : subapertures) {
    17ac:	mov    rax,QWORD PTR [rsp+0x70]
    17b1:	mov    QWORD PTR [rsp+0x98],rax
    17b9:	jmp    1e4 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x1e4>
    17be:	jmp    17c3 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x17c3>
    17c3:	jmp    17c8 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x17c8>
    17c8:	mov    rbx,rax
    17cb:	vzeroupper
    17ce:	jmp    17d3 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float)+0x17d3>
    17d3:	jmp    17d8 <.LC6+0x17cc>

Disassembly of section .text.unlikely:

0000000000000000 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float) [clone .cold]>:
	  __throw_length_error(
   0:	lea    rdi,[rip+0x0]        # 7 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float) [clone .cold]+0x7>
   7:	call   c <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float) [clone .cold]+0xc>
	if (__p)
   c:	mov    rbx,rax
   f:	vzeroupper
  12:	cmp    QWORD PTR [rsp+0x70],0x0
  18:	je     32 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float) [clone .cold]+0x32>
	ptrdiff_t __n = _M_impl._M_end_of_storage - _M_impl._M_start;
  1a:	mov    rdi,QWORD PTR [rsp+0x70]
  1f:	mov    rsi,r13
  22:	sub    rsi,rdi
	_GLIBCXX_OPERATOR_DELETE(_GLIBCXX_SIZED_DEALLOC(__p, __n));
  25:	call   2a <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float) [clone .cold]+0x2a>
      ~__new_allocator() _GLIBCXX_USE_NOEXCEPT { }
  2a:	jmp    32 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float) [clone .cold]+0x32>
  2c:	mov    rbx,rax
  2f:	vzeroupper
  32:	mov    rax,QWORD PTR [rsp+0x40]
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
  60:	cmp    QWORD PTR [rsp+0x48],0x0
  66:	mov    rbx,rax
  69:	je     7d <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float) [clone .cold]+0x7d>
	_GLIBCXX_OPERATOR_DELETE(_GLIBCXX_SIZED_DEALLOC(__p, __n));
  6b:	mov    rdi,QWORD PTR [rsp+0x48]
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
  9a:	mov    QWORD PTR [rsp+0x70],r15
  9f:	mov    rbx,rax
  a2:	vzeroupper
  a5:	jmp    12 <refocus_shift_and_sum(std::vector<SubApertureImage, std::allocator<SubApertureImage> >&, float) [clone .cold]+0x12>
