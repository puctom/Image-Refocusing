use std::{
    env, fs, io, ops,
    path::{Path, PathBuf},
};

struct SubApertureImage {
    data: ImageData,
    u: f32,
    v: f32,
}

struct ImageData {
    width: usize,
    height: usize,
    data: Vec<u8>,
}

fn sample_bilinear(image: &SubApertureImage, x: f32, y: f32) -> Option<[f32; 3]> {
    // Check if the coordinates are within the valid range, otherwise this
    // sub-aperture image is ignored for this pixel.
    if x < 0.0 || x >= (image.data.width - 1) as f32 {
        return None;
    }
    if y < 0.0 || y >= (image.data.height - 1) as f32 {
        return None;
    }
    // The four corner pixels coordinates for interpolation.
    let x0 = x.floor() as usize;
    let x1 = x.ceil() as usize;
    let y0 = y.floor() as usize;
    let y1 = y.ceil() as usize;
    // The interpolation weights based on the distance from the corners.
    let dx = x - x0 as f32;
    let dy = y - y0 as f32;

    let mut out = [0.0; 3];
    for c in 0..3 {
        let p00 = image.data[(x0, y0, c)] as f32;
        let p10 = image.data[(x1, y0, c)] as f32;
        let p01 = image.data[(x0, y1, c)] as f32;
        let p11 = image.data[(x1, y1, c)] as f32;
        // Perform bilinear interpolation.
        let top = (1.0 - dx) * p00 + dx * p10;
        let bottom = (1.0 - dx) * p01 + dx * p11;
        out[c] = (1.0 - dy) * top + dy * bottom;
    }
    Some(out)
}

fn refocus_shift_and_sum(subapertures: &[SubApertureImage], focus: f32) -> ImageData {
    let total_subs = subapertures.len();
    println!("Loaded {total_subs} sub-aperture images");

    let width = subapertures[0].data.width;
    let height = subapertures[0].data.height;
    let data = vec![0u8; width * height * 3];
    let mut output = ImageData {
        width,
        height,
        data,
    };
    for y in 0..height {
        for x in 0..width {
            let mut count = 0usize;
            let mut sum = [0.0f32; 3];
            for sub in subapertures {
                // Shift is dependent of focus value and sub-aperture coordinates.
                let shift_x = focus * sub.u;
                let shift_y = focus * sub.v;
                // Sample the sub-aperture image at the shifted coordinates using bilinear interpolation.
                let sample = sample_bilinear(sub, x as f32 + shift_x, y as f32 + shift_y);
                // Only include valid samples that are within the image bounds after shifting.
                let Some(sample) = sample else { continue };
                for c in 0..3 {
                    sum[c] += sample[c];
                }
                count += 1;
            }
            if count == 0 {
                continue;
            }
            for c in 0..3 {
                // Calculate the mean colour value for this pixel.
                let value = sum[c] / count as f32;
                let value = value.round().clamp(0.0, 255.0) as u8;
                output[(x, y, c)] = value;
            }
        }
    }
    output
}

/// Scans the given directory for files matching the pattern "out_XX_XX_U_V_.png",
/// where U and V are floating-point numbers. Returns a vector of (path, u, v)
/// tuples, along with the mean U and V values and a scale factor to normalize
/// the coordinates to a range of [0, 0.9].
fn find_subaperture_files(directory: &Path) -> (Vec<(PathBuf, f32, f32)>, f32, f32, f32) {
    let mut files: Vec<(PathBuf, f32, f32)> = Vec::new();
    let mut min_u = f32::INFINITY;
    let mut max_u = f32::NEG_INFINITY;
    let mut min_v = f32::INFINITY;
    let mut max_v = f32::NEG_INFINITY;
    let mut mean_u = 0.0;
    let mut mean_v = 0.0;

    for entry in fs::read_dir(directory).unwrap() {
        let entry = entry.unwrap();
        let path = entry.path();
        let Some(name) = path.file_name() else {
            continue;
        };
        let name = name.to_str().unwrap();
        let parts: Vec<_> = name.split('_').collect();
        if parts.len() < 6 {
            continue;
        }
        if parts[0] != "out" || parts.last() != Some(&".png") {
            continue;
        }
        let v: f32 = parts[3].parse().unwrap();
        let u: f32 = parts[4].parse().unwrap();
        files.push((path, u, v));
        min_u = min_u.min(u);
        max_u = max_u.max(u);
        min_v = min_v.min(v);
        max_v = max_v.max(v);
        mean_u += u;
        mean_v += v;
    }

    let count = files.len() as f32;
    if count > 0.0 {
        mean_u /= count;
        mean_v /= count;
    }
    let span_u = max_u - min_u;
    let span_v = max_v - min_v;
    let denom = if span_u > span_v { span_u } else { span_v };
    let scale = if denom > 0.0 { 0.9 / denom } else { 0.0 };

    (files, mean_u, mean_v, scale)
}

/// Loads a PNG image from the given path and converts it to RGB format if
/// necessary.
fn load_png(path: &Path) -> ImageData {
    let file = io::BufReader::new(fs::File::open(path).unwrap());
    let decoder = png::Decoder::new(file);
    let mut reader = decoder.read_info().unwrap();
    let mut buf = vec![0; reader.output_buffer_size()];
    let info = reader.next_frame(&mut buf).unwrap();
    buf.truncate(info.buffer_size());

    let width = info.width as usize;
    let height = info.height as usize;
    let data = match info.color_type {
        png::ColorType::Rgb => buf,
        png::ColorType::Rgba => {
            let mut rgb = Vec::with_capacity(width * height * 3);
            for chunk in buf.chunks_exact(4) {
                rgb.push(chunk[0]);
                rgb.push(chunk[1]);
                rgb.push(chunk[2]);
            }
            rgb
        }
        png::ColorType::Grayscale => {
            let mut rgb = Vec::with_capacity(width * height * 3);
            for value in buf {
                rgb.push(value);
                rgb.push(value);
                rgb.push(value);
            }
            rgb
        }
        png::ColorType::GrayscaleAlpha => {
            let mut rgb = Vec::with_capacity(width * height * 3);
            for chunk in buf.chunks_exact(2) {
                let value = chunk[0];
                rgb.push(value);
                rgb.push(value);
                rgb.push(value);
            }
            rgb
        }
        other => panic!("Unsupported PNG colour type: {other:?}"),
    };
    ImageData {
        width,
        height,
        data,
    }
}

/// Loads all sub-aperture images from the given directory, extracting their U and V
/// coordinates from the filename. Normalizes the U and V values to a range of
/// approximately [-0.45, 0.45] by subtracting the mean and applying a scale
/// factor. Returns a vector of SubApertureImage structs containing the image
/// data and coordinates. All images must have the same dimensions.
fn load_subaperture_images(directory: &Path) -> Vec<SubApertureImage> {
    let (files, mean_u, mean_v, scale) = find_subaperture_files(directory);
    let mut subapertures: Vec<SubApertureImage> = Vec::new();

    for (path, u, v) in files {
        let data = load_png(&path);
        if let Some(first) = subapertures.first() {
            assert_eq!(
                data.width, first.data.width,
                "Image width mismatch for {path:?}"
            );
            assert_eq!(
                data.height, first.data.height,
                "Image height mismatch for {path:?}"
            );
        }
        subapertures.push(SubApertureImage {
            data,
            u: (u - mean_u) * scale,
            v: (v - mean_v) * scale,
        });
    }
    assert!(!subapertures.is_empty(), "No sub-aperture images found in {directory:?}. Expected files named like out_00_00_-780.134705_-3355.331299_.png");
    subapertures
}

/// Saves the given image data as a PNG file at the specified path. The image
/// data must be in RGB format (3 bytes per pixel). The output PNG will have 8
/// bits per channel.
fn save_png(path: &Path, image: &ImageData) {
    let w = io::BufWriter::new(fs::File::create(path).unwrap());
    let mut encoder = png::Encoder::new(w, image.width as u32, image.height as u32);
    encoder.set_color(png::ColorType::Rgb);
    encoder.set_depth(png::BitDepth::Eight);
    let mut writer = encoder.write_header().unwrap();
    writer.write_image_data(&image.data).unwrap();
}

fn parse_args() -> Result<(PathBuf, f32, PathBuf), String> {
    let args: Vec<String> = env::args().collect();
    if args.len() < 3 || args.len() > 4 {
        return Err("Usage: <directory> <focus> [output.png]".to_string());
    }
    let directory = PathBuf::from(&args[1]);
    let focus: f32 = args[2]
        .parse()
        .map_err(|_| "Focus must be a number".to_string())?;
    let output = if args.len() > 3 {
        PathBuf::from(&args[3])
    } else {
        PathBuf::from("refocused.png")
    };
    Ok((directory, focus, output))
}

fn main() {
    let (directory, focus, output) = match parse_args() {
        Ok(values) => values,
        Err(err) => {
            eprintln!("{err}");
            return;
        }
    };
    let subapertures = load_subaperture_images(&directory);
    let image = refocus_shift_and_sum(&subapertures, focus);
    save_png(&output, &image);
    println!("Saved refocused image to {}", output.display());
}

impl ImageData {
    /// Convenience method to calculate the 1D index into the data vector for a given
    /// (x, y, c) coordinate, where x and y are pixel coordinates and c is the
    /// colour channel (0 for R, 1 for G, 2 for B).
    fn index(&self, x: usize, y: usize, c: usize) -> usize {
        assert!(x < self.width, "X coordinate out of bounds");
        assert!(y < self.height, "Y coordinate out of bounds");
        assert!(c < 3, "Colour channel index out of bounds");
        (y * self.width + x) * 3 + c
    }
}

impl ops::Index<(usize, usize, usize)> for ImageData {
    type Output = u8;
    fn index(&self, (x, y, c): (usize, usize, usize)) -> &Self::Output {
        let idx = self.index(x, y, c);
        &self.data[idx]
    }
}

impl ops::IndexMut<(usize, usize, usize)> for ImageData {
    fn index_mut(&mut self, (x, y, c): (usize, usize, usize)) -> &mut Self::Output {
        let idx = self.index(x, y, c);
        &mut self.data[idx]
    }
}
