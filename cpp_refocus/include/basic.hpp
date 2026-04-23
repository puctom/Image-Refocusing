#pragma once
#include "utils.hpp"
#include <cmath>

ImageData refocus_shift_and_sum(std::vector<SubApertureImage> &subapertures, float focus);
