#!/usr/bin/env bash
set -euo pipefail

echo "=================================================================="
echo "WARNING: Tested with samsungexynos850/android_device_samsung_a21s"
echo "Experimental script. Use at your own risk."
echo "Note: This is for device tree only. Check README for common tree."
echo "=================================================================="

read -rp "A21s Tree Path / Git URL: " A21S_SRC
read -rp "A13 Output Directory: " OUT_DIR

if [[ -z "$A21S_SRC" || -z "$OUT_DIR" ]]; then
    echo "Error: Source or output path cannot be empty." >&2
    exit 1
fi

if [[ -d "$OUT_DIR" ]]; then
    echo "Error: Directory $OUT_DIR already exists." >&2
    exit 1
fi

if [[ -d "$A21S_SRC" ]]; then
    cp -r "$A21S_SRC" "$OUT_DIR"
elif [[ "$A21S_SRC" =~ ^https:// || "$A21S_SRC" =~ ^git@ ]]; then
    git clone "$A21S_SRC" "$OUT_DIR" --depth=1
else
    echo "Error: Invalid source path or git URL." >&2
    exit 1
fi

cd "$OUT_DIR"
rm -rf .git

# Replace strings across makefiles, python scripts, and dependency configs
find . -type f \( -name "*.mk" -o -name "*.py" -o -name "*.dependencies" \) -exec sed -i \
    -e 's/SM-A217X/SM-A135F/g' \
    -e 's/a21nsxx/a13nsxx/g' \
    -e 's/a21s-common/a13-common/g' \
    -e 's/a21s/a13/g' \
    -e 's/A21S/A13/g' {} +

if [[ -f "lineage.dependencies" ]]; then
    cat << 'EOF' > lineage.dependencies
[
    {
        "remote": "github",
        "repository": "Samsung-Galaxy-A13-A135F-Development/android_device_samsung_a13-common",
        "target_path": "device/samsung/a13-common"
    }
]
EOF
fi

if [[ -f "lineage_a21s.mk" ]]; then
    mv lineage_a21s.mk lineage_a13.mk
fi

if [[ -f "lineage_a13.mk" ]]; then
    sed -i \
        -e 's/TARGET_SCREEN_HEIGHT := 1600/TARGET_SCREEN_HEIGHT := 2408/g' \
        -e 's/TARGET_SCREEN_WIDTH := 720/TARGET_SCREEN_WIDTH := 1080/g' \
        -e 's/PRODUCT_SHIPPING_API_LEVEL := 29/PRODUCT_SHIPPING_API_LEVEL := 31/g' lineage_a13.mk
fi

git init -b lineage-24.0

echo "Done. Output saved to $OUT_DIR"
