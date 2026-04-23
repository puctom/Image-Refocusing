#include <cstdlib>
#include <iostream>
#include <stdexcept>

#include "utils.hpp"

#ifdef BASIC 
#include "basic.hpp"
#else
#error "Method must be defined at compile time"
#endif

static std::tuple<fs::path, float, fs::path> parse_args(int argc, char **argv) {
    if (argc < 3 || argc > 4)
        throw std::runtime_error("Usage: <directory> <focus> [output.png]");
    return {argv[1], std::stof(argv[2]), argc > 3 ? fs::path(argv[3]) : fs::path("refocused.png")};
}

int main(int argc, char **argv) {
    try {
        auto [directory, focus, output] = parse_args(argc, argv);
        auto subapertures = load_subaperture_images(directory);
        std::cout << "Loaded " << subapertures.size() << " sub-aperture images\n";
        ImageData image;
        image = refocus_shift_and_sum(subapertures, focus);
        save_png(output, image);
        std::cout << "Saved refocused image to " << output.string() << "\n";
    } catch (const std::exception &ex) {
        std::cerr << ex.what() << "\n";
        return 1;
    }
    return 0;
}
