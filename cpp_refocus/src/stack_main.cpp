#include <cstdlib>
#include <iostream>
#include <stdexcept>

#include "utils.hpp"
#include "refocus_stack.hpp"

static std::tuple<fs::path, std::vector<float>, fs::path> parse_args(int argc, char** argv) {
    if (argc < 4)
        throw std::runtime_error("Usage: <directory> <out_dir> <focus1> [focus2 ...]");
    std::vector<float> focuses;
    for (int i = 3; i < argc; ++i)
        focuses.push_back(std::stof(argv[i]));
    return {argv[1], focuses, argv[2]};
}

int main(int argc, char** argv) {
    try {
        auto [directory, focuses, out_dir] = parse_args(argc, argv);
        fs::create_directories(out_dir);
        auto subapertures = load_subaperture_images(directory);
        std::cout << "Loaded " << subapertures.size() << " sub-aperture images\n";
        flush_caches();
        auto images = refocus_shift_and_sum_stack(subapertures, focuses);
        for (size_t i = 0; i < images.size(); ++i) {
            auto output = out_dir / ("stack_" + std::to_string(i) + ".png");
            save_png(output, images[i]);
            std::cout << "Saved refocused image to " << output.string() << "\n";
        }
    } catch (const std::exception &ex) {
        std::cerr << ex.what() << "\n";
        return 1;
    }
    return 0;
}
