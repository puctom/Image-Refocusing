#pragma once
#include <vector>
#include "utils.hpp"

std::vector<ImageData> refocus_shift_and_sum_stack(std::vector<SubApertureImage> &subapertures, const std::vector<float>& focuses);