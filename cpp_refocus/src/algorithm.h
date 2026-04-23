#pragma once

#include <filesystem>
#include <iostream>
#include <cmath>
#include <algorithm>
#include "../deps/lodepng.h"

struct ImageData {
    size_t width = 0;
    size_t height = 0;
    std::vector<unsigned char> data; // RGB

    size_t index(size_t x, size_t y, size_t c) const {
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

    unsigned char &at(size_t x, size_t y, size_t c) {
        return data[index(x, y, c)];
    }

    const unsigned char &at(size_t x, size_t y, size_t c) const {
        return data[index(x, y, c)];
    }
};

struct SubApertureImage {
    ImageData data;
    float u = 0.0f;
    float v = 0.0f;
};

struct RGB {
    float r;
    float g;
    float b;
};

RGB sample_bilinear(const SubApertureImage& img, float x, float y){
    // Using the convention that if any RGB val is negative it is invalid
    if(x < 0 || x >= img.data.width - 1) return RGB{-1.0f, -1.0f, -1.0f};
    if(y < 0 || y >= img.data.height -1) return RGB{-1.0f, -1.0f, -1.0f};

    const int x0 = std::floor(x);
    const int x1 = std::ceil(x);
    const int y0 = std::floor(y);
    const int y1 = std::ceil(y);

    const float dx = x - x0;
    const float dy = y - y0;

    float out[3];

    for(int channel=0; channel<3; ++channel){
        const float p00 = img.data.at(x0, y0, channel);
        const float p10 = img.data.at(x1, y0, channel);
        const float p01 = img.data.at(x0, y1, channel);
        const float p11 = img.data.at(x1, y1, channel);

        const float top    = (1.0f - dx) * p00 + dx * p10;
        const float bottom = (1.0f - dx) * p01 + dx * p11;
        out[channel] = (1.0f - dy) * top + dy * bottom;
    }

    return RGB{out[0], out[1], out[2]};
}

unsigned char scale_round_clamp(float val, float scale){
    return (unsigned char) std::clamp(std::round(val / scale), (float) 0.0f, (float) 255.0f);
}

static ImageData refocus_shift_and_sum(std::vector<SubApertureImage>& subapertures, float focus) {
    const size_t width = subapertures.front().data.width;
    const size_t height = subapertures.front().data.height;
    ImageData output;
    output.width = width;
    output.height = height;
    output.data.assign(width * height * 3, 0);

    for(size_t y=0; y<height; ++y){
        for(size_t x=0; x<width; ++x){
            int count = 0;
            RGB sum{0.0f, 0.0f, 0.0f};
            for(SubApertureImage& sub : subapertures){
                float shift_x = focus * sub.u;
                float shift_y = focus * sub.v;

                RGB sample = sample_bilinear(sub, x + shift_x, y + shift_y);
                if(sample.r < 0) continue;

                sum.r += sample.r;
                sum.g += sample.g;
                sum.b += sample.b;
                ++count;
            }
            if(count == 0) continue;
            output.at(x, y, 0) = scale_round_clamp(sum.r, count);
            output.at(x, y, 1) = scale_round_clamp(sum.g, count);
            output.at(x, y, 2) = scale_round_clamp(sum.b, count);
        }
    }

    return output;
}

namespace fs = std::filesystem;

static ImageData load_png(const fs::path &path) {
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

static void save_png(const fs::path &path, const ImageData &image) {
    unsigned error = lodepng::encode(path.string(), image.data,
                                     static_cast<unsigned>(image.width),
                                     static_cast<unsigned>(image.height),
                                     LCT_RGB, 8);
    if (error != 0) {
        throw std::runtime_error("Failed to save PNG " + path.string() + ": " + lodepng_error_text(error));
    }
}

static std::vector<std::string> split(const std::string &value, char delimiter) {
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

static std::tuple<std::vector<std::tuple<fs::path, float, float>>, float, float, float>
find_subaperture_files(const fs::path &directory) {
    std::vector<std::tuple<fs::path, float, float>> files;
    float min_u = std::numeric_limits<float>::infinity();
    float max_u = -std::numeric_limits<float>::infinity();
    float min_v = std::numeric_limits<float>::infinity();
    float max_v = -std::numeric_limits<float>::infinity();
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

static std::vector<SubApertureImage> load_subaperture_images(const fs::path &directory) {
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
