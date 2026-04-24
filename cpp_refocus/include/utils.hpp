#pragma once

#include <filesystem>
#include <algorithm>
#include "lodepng.h"

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

inline ImageData load_png(const fs::path &path) {
    std::vector<unsigned char> rgb;
    unsigned width = 0;
    unsigned height = 0;
    unsigned error = lodepng::decode(rgb, width, height, path.string(), LCT_RGB, 8);
    if (error != 0) {
        throw std::runtime_error("Failed to load PNG " + path.string() + ": " + lodepng_error_text(error));
    }

    ImageData image;
    image.width = static_cast<size_t>(width);
    image.height = static_cast<size_t>(height);
    image.data = std::move(rgb);
    return image;
}

inline void save_png(const fs::path &path, const ImageData &image) {
    unsigned error = lodepng::encode(path.string(), image.data,
                                     static_cast<unsigned>(image.width),
                                     static_cast<unsigned>(image.height),
                                     LCT_RGB, 8);
    if (error != 0) {
        throw std::runtime_error("Failed to save PNG " + path.string() + ": " + lodepng_error_text(error));
    }
}

inline std::vector<std::string> split(const std::string &value, char delimiter) {
    std::vector<std::string> parts;
    std::string current;
    for (char ch : value) {
        if (ch == delimiter) {
            parts.push_back(current);
            current.clear();
        } else {
            current.push_back(ch);
        }
    }
    parts.push_back(current);
    return parts;
}

inline std::tuple<std::vector<std::tuple<fs::path, float, float>>, float, float, float>
find_subaperture_files(const fs::path &directory) {
    std::vector<std::tuple<fs::path, float, float>> files;
    float min_u = std::numeric_limits<float>::max();
    float max_u = std::numeric_limits<float>::min();
    float min_v = std::numeric_limits<float>::max();
    float max_v = std::numeric_limits<float>::min();
    float mean_u = 0.0f;
    float mean_v = 0.0f;

    for (const auto &entry : fs::directory_iterator(directory)) {
        if (!entry.is_regular_file()) {
            continue;
        }
        const auto &path = entry.path();
        const std::string name = path.filename().string();
        const auto parts = split(name, '_');
        if (parts.size() < 6) {
            continue;
        }
        if (parts.front() != "out" || parts.back() != ".png") {
            continue;
        }
        float v = std::stof(parts[3]);
        float u = std::stof(parts[4]);
        files.emplace_back(path, u, v);
        min_u = std::min(min_u, u);
        max_u = std::max(max_u, u);
        min_v = std::min(min_v, v);
        max_v = std::max(max_v, v);
        mean_u += u;
        mean_v += v;
    }

    const float count = static_cast<float>(files.size());
    if (count > 0.0f) {
        mean_u /= count;
        mean_v /= count;
    }

    const float span_u = max_u - min_u;
    const float span_v = max_v - min_v;
    const float denom = span_u > span_v ? span_u : span_v;
    const float scale = denom > 0.0f ? 0.9f / denom : 0.0f;

    return {files, mean_u, mean_v, scale};
}

inline std::vector<SubApertureImage> load_subaperture_images(const fs::path &directory) {
    auto [files, mean_u, mean_v, scale] = find_subaperture_files(directory);
    std::vector<SubApertureImage> subapertures;
    subapertures.reserve(files.size());

    for (const auto &[path, u, v] : files) {
        ImageData data = load_png(path);
        if (!subapertures.empty()) {
            if (data.width != subapertures.front().data.width) {
                throw std::runtime_error("Image width mismatch for " + path.string());
            }
            if (data.height != subapertures.front().data.height) {
                throw std::runtime_error("Image height mismatch for " + path.string());
            }
        }
        subapertures.push_back(SubApertureImage{
            std::move(data),
            (u - mean_u) * scale,
            (v - mean_v) * scale,
        });
    }

    if (subapertures.empty()) {
        throw std::runtime_error("No sub-aperture images found in " + directory.string() +
                                ". Expected files named like out_00_00_-780.134705_-3355.331299_.png");
    }
    return subapertures;
}
