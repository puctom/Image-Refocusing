#!/bin/bash

TARGET_DIR="in/validation1515"

# Regular expression matching the specific zero-padded numbers
# 00, 04, 08, 12, 16
ALLOWED_RE="^(00|04|08|12|01|05|09|13|02|06|10|14|03|07|11)$"

# Loop safely over the glob. This avoids the pitfalls of parsing 'ls'
for filepath in "$TARGET_DIR"/out_*_*_*.png; do
    
    # Safety check: ensure the file exists (handles the case where the glob matches nothing)
    [ -e "$filepath" ] || continue

    # Strip the directory path to isolate the filename
    filename=$(basename "$filepath")

    # Efficiently split the filename into variables using the underscore as a delimiter
    # Format: out_XX_YY_-702...png -> prefix=out, num1=XX, num2=YY, remainder=-702...png
    IFS='_' read -r prefix num1 num2 remainder <<< "$filename"

    # Evaluate if BOTH numbers match the allowed regular expression
    if [[ $num1 =~ $ALLOWED_RE && $num2 =~ $ALLOWED_RE ]]; then
        # Action: Keep
        echo "Keeping:  $filename"
    else
        # Action: Remove
        # REMOVE THE 'echo' ON THE LINE BELOW ONCE YOU VERIFY IT WORKS
        rm "$filepath"
    fi
done