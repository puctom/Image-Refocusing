# Light Field Refocus Project Implementation

## Run

After implementing your algorithm, run from this directory with:

```bash
make && ./refocus <directory> <focus> [output.png]
```

Arguments:
- `directory`: folder containing sub-aperture PNGs named like `out_00_00_-780.134705_-3355.331299_.png`
- `focus`: focus scale (expected range -50.0 to 50.0)
- `output.png`: optional output filename (default: `refocused.png`)
