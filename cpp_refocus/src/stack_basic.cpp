#include "refocus_stack.hpp"
#include "refocus.hpp"

std::vector<ImageData> refocus_shift_and_sum_stack(std::vector<SubApertureImage> &subapertures, const std::vector<float>& focuses) {
    std::vector<ImageData> results;
    results.reserve(focuses.size());
    for (float f : focuses) {
        results.push_back(refocus_shift_and_sum(subapertures, f));
    }
    return results;
}
    