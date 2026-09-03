# Galaxy A21s to A13 Device Tree Converter

A Bash script designed to automate the conversion of a **Samsung Galaxy A21s** (`a21s`) device tree into a **Samsung Galaxy A13** (`A135F` / `a13`) device tree for LineageOS builds.

> ⚠️ **Disclaimer:** This script is experimental. Inspect the output diff before using it in production builds. Use at your own risk.

---

## Features

- Automates renaming of board-specific strings (`a21s` -> `a13`, `SM-A217X` -> `SM-A135F`, etc.).
- Adjusts display dimensions (FHD+ 1080x2408) and shipping API levels.
- Replaces dependency configurations for `a13-common`.
- Initializes a clean Git repository tracking changes.

---

## Usage

1. **Clone the repository:**
   ```bash
   git clone https://github.com/ynbton/android_device_converter_a21s_to_a13.git
   cd android_device_converter_a21s_to_a13
   ```

2. **Run the script:**
   ```bash
   bash lineage.sh
   ```

3. **Provide inputs when prompted:**
   - **Source Tree / URL:** `https://github.com/samsungexynos850/android_device_samsung_a21s`
   - **Output Path:** Target path for the converted device tree (e.g., `device/samsung/a13`).

---

## Branches

Check out other branches in this repository for different Custom ROMs / OS targets:
- `lineage` - LineageOS tree conversion (default)
- Feel free to inspect other branches for alternative ROM bases.

---
## Message

 I haven't created a script for the common device tree yet, but I'll make one later.


## License

This project is licensed under the **GNU General Public License v3.0 (GPL-3.0)**. See the `LICENSE` file for details.

---

## Credits

- **Tested Base Tree:** [samsungexynos850/android_device_samsung_a21s](https://github.com/samsungexynos850/android_device_samsung_a21s)
- **Reference Tree:** [Samsung-Galaxy-A13-A135F-Development](https://github.com/Samsung-Galaxy-A13-A135F-Development)
