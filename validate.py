import os
import multiprocessing as mp
import subprocess
import zipfile

from io import BytesIO
from urllib.request import urlopen

from PIL import Image

# Jelly Beans is the smallest dataset (1024 x 512)
SOURCE       = "https://graphics.stanford.edu/data/LF/data/jelly_beans_lf/rectified.zip"
PATH         = os.path.join("in", "validation")
OUT          = "out"
FOCUS_VALUES = [-49.3, -20, 0, 12.352, 33.33]
EPSILON      = 1


def test_images_exist():
    if not os.path.exists(PATH):
        return False
    
    if not os.path.isdir(PATH):
        return False

    files = os.listdir(PATH)
    for x in range(17):
        for y in range(17):
            found = False
            for f in files:
                if f.startswith(f"out_{x:02d}_{y:02d}_"):
                    found = True
                    break
            if not found:
                return False
    return True

def download_test_images():
    os.makedirs(PATH, exist_ok=True)
    with urlopen(SOURCE) as response:
        data = response.read()
    with zipfile.ZipFile(BytesIO(data)) as zf:
        zf.extractall(PATH)

    # Move images out of 'rectified'
    rect_path = os.path.join(PATH, "rectified")
    for name in os.listdir(rect_path):
        src = os.path.join(rect_path, name)
        dst = os.path.join(PATH, name)
        os.rename(src, dst)
    os.rmdir(rect_path)

    """
    For some weird reason, the jelly beans dataset images do not have 
    a '_' character before ".png", so we have to manually add it
    """
    for file in os.listdir(os.path.join(PATH)):
        if not file.endswith(".png"):
            continue
        if file.endswith("_.png"):
            continue
        old = os.path.join(PATH, file)
        new = os.path.join(PATH, file[0:-4] + '_.png')
        os.rename(old, new)

def build_cpp():
    subprocess.run("cd cpp_refocus && make", shell=True, check=True)

def run_case(focus):
    binary_path = os.path.join("cpp_refocus", "refocus")
    output_path = os.path.join(OUT, "cpp", f"{str(focus).replace('.', '_')}.png")
    subprocess.run(
        [binary_path, PATH, str(focus), output_path],
        check=True,
    )

def run_cpp():
    with mp.Pool() as pool:
        pool.map(run_case, FOCUS_VALUES)

def compare_single(focus):
    fname = str(focus).replace(".", "_") + ".png"
    rust = Image.open(os.path.join(OUT, "rust", fname))
    cpp = Image.open(os.path.join(OUT, "cpp", fname))

    rust_data = rust.get_flattened_data()
    cpp_data = cpp.get_flattened_data()

    if len(rust_data) != len(cpp_data):
        raise RuntimeError(f"Rust and CPP versions of {fname} have different sizes!")


    for i in range(len(rust_data)):
        for band in range(3):
            diff = abs(rust_data[i][band] - cpp_data[i][band])  # type: ignore
            if diff > EPSILON:
                print(f"Rust and CPP pixel values differ by {diff} on position {i} band {band} in image {fname}")
                return False
    return True

def compare():
    with mp.Pool() as pool:
        results = pool.map(compare_single, FOCUS_VALUES)
    if all(results):
        print("\u001b[32mVALIDATION SUCCESSFUL\u001b[0m")
    else:
        print("\u001b[31mVALIDATION FAILED\u001b[0m")


def main():
    if not test_images_exist():
        print("Test images not found, downloading...")
        download_test_images()
    build_cpp()
    run_cpp()
    compare()

if __name__ == "__main__":
    main()
