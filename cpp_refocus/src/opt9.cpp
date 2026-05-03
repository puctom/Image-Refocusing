#include "refocus.hpp"
#include "utils.hpp"
#include <vector>
#include <cmath>
#include <algorithm>
#include <immintrin.h>

/*
*   List of Optimizations:
*       - Change the loop order to [Subaperture, y, x] for improved locality
*       - Common subexpression elimination
*       - use better bounds for the x-y loops
*       - use unchecked array access
*       - function inlining
*       - unroll channel loop to expose independent scalar ops for ILP
*       - reduce number of loads in innermost loop
*       - use AVX float32 FMA with unaligned loads
* */

ImageData refocus_shift_and_sum(std::vector<SubApertureImage>& subapertures, float focus) {
    const size_t width = subapertures.front().data.width;
    const size_t height = subapertures.front().data.height;
    ImageData output;
    output.width = width;
    output.height = height;
    output.data.assign(width * height * 3, 0);

    std::vector<__m256> counts(width * height * 3 / 8, _mm256_setzero_ps());
    std::vector<__m256> vals(width * height * 3 / 8, _mm256_setzero_ps());

    const int w = static_cast<int>(width);
    const int h = static_cast<int>(height);

    for(SubApertureImage& sub : subapertures){
        float shift_x = focus * sub.u;
        float shift_y = focus * sub.v;

        const int sx = std::floor(shift_x);
        const int sy = std::floor(shift_y);
        float dx = shift_x - sx;
        float dy = shift_y - sy;

        float A = (1 - dx) * (1 - dy);
        float B = dx * (1 - dy);
        float C = (1 - dx) * dy;
        float D = dx * dy;

        const int x_begin = std::max(0, -sx);
        const int x_end = std::min(w, w - sx - 1);
        const int y_begin = std::max(0, -sy);
        const int y_end = std::min(h, h - sy - 1);

        if(x_begin >= x_end || y_begin >= y_end) continue;


        const unsigned char * SUB = sub.data.data.data();
        
        const __m256 Avx     = _mm256_set1_ps(A);
        const __m256 Bvx     = _mm256_set1_ps(B);
        const __m256 Cvx     = _mm256_set1_ps(C);
        const __m256 Dvx     = _mm256_set1_ps(D);
        const __m256 ONEvx   = _mm256_set1_ps(1.0f);
        const __m256i ZEROvx = _mm256_setzero_si256();


        for (int y = y_begin; y < y_end; ++y) {

            size_t ind_ltop = ((y + sy) * width + (x_begin + sx)) * 3;
            size_t ind_lbot = ind_ltop + width * 3;
            size_t ind_rtop = ind_ltop + 3; 
            size_t ind_rbot = ind_lbot + 3; 

            // Handle columns until we first reach the one divisible by 8
            int x = 3 * x_begin;
            int mx = x % 8;
            if(mx != 0) {
                uint8_t mask = 0xFFu << mx;
                ind_ltop -= mx;
                ind_lbot -= mx;
                ind_rtop -= mx;
                ind_rbot -= mx;
                    
                __m128i ltop_bytes = _mm_loadl_epi64(reinterpret_cast<const __m128i*>(SUB + ind_ltop));
                __m128i lbot_bytes = _mm_loadl_epi64(reinterpret_cast<const __m128i*>(SUB + ind_lbot));
                __m128i rtop_bytes = _mm_loadl_epi64(reinterpret_cast<const __m128i*>(SUB + ind_rtop));
                __m128i rbot_bytes = _mm_loadl_epi64(reinterpret_cast<const __m128i*>(SUB + ind_rbot));

                __m256i ltop_ints = _mm256_mask_cvtepu8_epi32(ZEROvx, mask, ltop_bytes);
                __m256i lbot_ints = _mm256_mask_cvtepu8_epi32(ZEROvx, mask, lbot_bytes);
                __m256i rtop_ints = _mm256_mask_cvtepu8_epi32(ZEROvx, mask, rtop_bytes);
                __m256i rbot_ints = _mm256_mask_cvtepu8_epi32(ZEROvx, mask, rbot_bytes);

                __m256 ltop_floats = _mm256_cvtepi32_ps(ltop_ints);
                __m256 lbot_floats = _mm256_cvtepi32_ps(lbot_ints);
                __m256 rtop_floats = _mm256_cvtepi32_ps(rtop_ints);
                __m256 rbot_floats = _mm256_cvtepi32_ps(rbot_ints);

                const size_t idx = (static_cast<size_t>(y) * width * 3 + static_cast<size_t>(x - mx)) / 8;
                __m256 val = _mm256_load_ps((float *)(vals.data() + idx));
                val = _mm256_fmadd_ps(Avx, ltop_floats, val);
                val = _mm256_fmadd_ps(Bvx, rtop_floats, val);
                val = _mm256_fmadd_ps(Cvx, lbot_floats, val);
                val = _mm256_fmadd_ps(Dvx, rbot_floats, val);
                _mm256_store_ps((float *)(vals.data() + idx), val);

                __m256 cnt = _mm256_mask_add_ps(counts[idx], mask, ONEvx, counts[idx]);
                _mm256_store_ps((float *)(counts.data() + idx), cnt);

                x = x - mx + 8;
                ind_ltop += 8;
                ind_lbot += 8;
                ind_rtop += 8;
                ind_rbot += 8;
            }

            // Handle 8 columns at a time for this row
            for (; x <= 3 * x_end - 8; x+=8) {
                // Load 8 bytes from topleft bottomleft topright bottomright
                __m128i ltop_bytes = _mm_loadl_epi64(reinterpret_cast<const __m128i*>(SUB + ind_ltop));
                __m128i lbot_bytes = _mm_loadl_epi64(reinterpret_cast<const __m128i*>(SUB + ind_lbot));
                __m128i rtop_bytes = _mm_loadl_epi64(reinterpret_cast<const __m128i*>(SUB + ind_rtop));
                __m128i rbot_bytes = _mm_loadl_epi64(reinterpret_cast<const __m128i*>(SUB + ind_rbot));

                // Convert the bytes into int32
                // This is because only int32 can be converted to float32 in AVX
                __m256i ltop_ints = _mm256_cvtepu8_epi32(ltop_bytes);
                __m256i lbot_ints = _mm256_cvtepu8_epi32(lbot_bytes);
                __m256i rtop_ints = _mm256_cvtepu8_epi32(rtop_bytes);
                __m256i rbot_ints = _mm256_cvtepu8_epi32(rbot_bytes);

                // Convert the int32s to float32s
                __m256 ltop_floats = _mm256_cvtepi32_ps(ltop_ints);
                __m256 lbot_floats = _mm256_cvtepi32_ps(lbot_ints);
                __m256 rtop_floats = _mm256_cvtepi32_ps(rtop_ints);
                __m256 rbot_floats = _mm256_cvtepi32_ps(rbot_ints);

                const size_t idx = (static_cast<size_t>(y) * width * 3 + static_cast<size_t>(x)) / 8;
                __m256 val = _mm256_load_ps((float *)(vals.data() + idx));
                val = _mm256_fmadd_ps(Avx, ltop_floats, val);
                val = _mm256_fmadd_ps(Bvx, rtop_floats, val);
                val = _mm256_fmadd_ps(Cvx, lbot_floats, val);
                val = _mm256_fmadd_ps(Dvx, rbot_floats, val);
                _mm256_store_ps((float *)(vals.data() + idx), val);

                __m256 cnt = _mm256_add_ps(ONEvx, counts[idx]);
                _mm256_store_ps((float *)(counts.data() + idx), cnt);

                ind_ltop += 8;
                ind_lbot += 8;
                ind_rtop += 8;
                ind_rbot += 8;
            }
            
            // Handle the remaining columns
            uint8_t rmn = 3 * x_end - x;
            if(rmn == 0) continue;

            uint8_t mask = (1u << rmn) - 1;

            __m128i ltop_bytes = _mm_loadl_epi64(reinterpret_cast<const __m128i*>(SUB + ind_ltop));
            __m128i lbot_bytes = _mm_loadl_epi64(reinterpret_cast<const __m128i*>(SUB + ind_lbot));
            __m128i rtop_bytes = _mm_loadl_epi64(reinterpret_cast<const __m128i*>(SUB + ind_rtop));
            __m128i rbot_bytes = _mm_loadl_epi64(reinterpret_cast<const __m128i*>(SUB + ind_rbot));

            __m256i ltop_ints = _mm256_mask_cvtepu8_epi32(ZEROvx, mask, ltop_bytes);
            __m256i lbot_ints = _mm256_mask_cvtepu8_epi32(ZEROvx, mask, lbot_bytes);
            __m256i rtop_ints = _mm256_mask_cvtepu8_epi32(ZEROvx, mask, rtop_bytes);
            __m256i rbot_ints = _mm256_mask_cvtepu8_epi32(ZEROvx, mask, rbot_bytes);

            __m256 ltop_floats = _mm256_cvtepi32_ps(ltop_ints);
            __m256 lbot_floats = _mm256_cvtepi32_ps(lbot_ints);
            __m256 rtop_floats = _mm256_cvtepi32_ps(rtop_ints);
            __m256 rbot_floats = _mm256_cvtepi32_ps(rbot_ints);

            const size_t idx = (static_cast<size_t>(y) * width * 3 + static_cast<size_t>(x)) / 8;
            __m256 val = _mm256_load_ps((float *)(vals.data() + idx));
            val = _mm256_fmadd_ps(Avx, ltop_floats, val);
            val = _mm256_fmadd_ps(Bvx, rtop_floats, val);
            val = _mm256_fmadd_ps(Cvx, lbot_floats, val);
            val = _mm256_fmadd_ps(Dvx, rbot_floats, val);
            _mm256_store_ps((float *)(vals.data() + idx), val);

            __m256 cnt = _mm256_mask_add_ps(counts[idx], mask, ONEvx, counts[idx]);
            _mm256_store_ps((float *)(counts.data() + idx), cnt);
        }
    }

    for(size_t y=0; y<height; ++y){
        for(size_t x=0; x<width*3; x += 32){  // Assuming that width is a multiple of 32
            const size_t idx1 = (static_cast<size_t>(y) * width * 3 + static_cast<size_t>(x)) / 8;
            const size_t idx2 = (static_cast<size_t>(y) * width * 3 + static_cast<size_t>(x + 8)) / 8;
            const size_t idx3 = (static_cast<size_t>(y) * width * 3 + static_cast<size_t>(x + 16)) / 8;
            const size_t idx4 = (static_cast<size_t>(y) * width * 3 + static_cast<size_t>(x + 24)) / 8;
            __m256 f1 = _mm256_div_ps(vals[idx1], counts[idx1]);
            __m256 f2 = _mm256_div_ps(vals[idx2], counts[idx2]);
            __m256 f3 = _mm256_div_ps(vals[idx3], counts[idx3]);
            __m256 f4 = _mm256_div_ps(vals[idx4], counts[idx4]);

            __m256i i1 = _mm256_cvtps_epi32(f1); 
            __m256i i2 = _mm256_cvtps_epi32(f2); 
            __m256i i3 = _mm256_cvtps_epi32(f3); 
            __m256i i4 = _mm256_cvtps_epi32(f4); 

            __m256i p1 = _mm256_packus_epi32(i1, i2);
            __m256i p2 = _mm256_packus_epi32(i3, i4);

            __m256i res = _mm256_packus_epi16(p1, p2);

            // packus works in 128-bit lanes so we need a permute
            res = _mm256_permutevar8x32_epi32(res, _mm256_set_epi32(7, 3, 6, 2, 5, 1, 4, 0));

            __m256i * out = reinterpret_cast<__m256i *>(output.data.data() + y * width * 3 + x);
            _mm256_storeu_si256(out, res);
        }
    }

    return output;
}




