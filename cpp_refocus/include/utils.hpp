#pragma once

#include <filesystem>
#include <stdexcept>
#include <string>
#include <tuple>
#include <vector>

namespace fs = std::filesystem;

struct ImageData {
    size_t width = 0;
    size_t height = 0;
    std::vector<unsigned char> data; // RGB

    inline size_t index(size_t x, size_t y, size_t c) const {
        if (x >= width) {
            throw std::out_of_range("X coordinate out of bounds");
        }
        if (y >= height) {
            throw std::out_of_range("Y coordinate out of bounds");
        }
        if (c >= 3) {
            throw std::out_of_range("Colour channel index out of bounds");
        }
        return (y * width + x) * 3 + c;
    }

    inline unsigned char &at(size_t x, size_t y, size_t c) {
        return data[index(x, y, c)];
    }

    const inline unsigned char &at(size_t x, size_t y, size_t c) const {
        return data[index(x, y, c)];
    }
};

struct SubApertureImage {
    ImageData data;
    float u = 0.0f;
    float v = 0.0f;
};

ImageData load_png(const fs::path &path);
void save_png(const fs::path &path, const ImageData &image);
std::vector<std::string> split(const std::string &value, char delimiter);
std::tuple<std::vector<std::tuple<fs::path, float, float>>, float, float, float>
find_subaperture_files(const fs::path &directory);
std::vector<SubApertureImage> load_subaperture_images(const fs::path &directory);
static void flush_caches();
