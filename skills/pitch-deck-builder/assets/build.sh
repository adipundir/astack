#!/usr/bin/env bash
# pitch-deck-builder: render the deck HTML to a 16:9 PDF via headless Chromium.
#
# Usage:
#   build.sh <input.html> <output.pdf>
#
# Auto-discovers Chrome, Chromium, Brave, or Edge on macOS or Linux.
# Exits non-zero with a clear message if no Chromium-based browser is found.

set -euo pipefail

if [[ $# -ne 2 ]]; then
  echo "usage: $0 <input.html> <output.pdf>" >&2
  exit 2
fi

INPUT_HTML="$1"
OUTPUT_PDF="$2"

if [[ ! -f "$INPUT_HTML" ]]; then
  echo "error: input file not found: $INPUT_HTML" >&2
  exit 1
fi

# Resolve to absolute paths (Chrome headless requires file:// with an absolute path)
case "$(uname -s)" in
  Darwin)
    ABS_INPUT="$(python3 -c "import os,sys; print(os.path.abspath(sys.argv[1]))" "$INPUT_HTML")"
    ABS_OUTPUT="$(python3 -c "import os,sys; print(os.path.abspath(sys.argv[1]))" "$OUTPUT_PDF")"
    ;;
  *)
    ABS_INPUT="$(readlink -f "$INPUT_HTML")"
    ABS_OUTPUT="$(readlink -f "$OUTPUT_PDF" 2>/dev/null || echo "$(pwd)/$OUTPUT_PDF")"
    ;;
esac

# Candidate Chromium-family binaries, in priority order.
CANDIDATES=(
  # macOS
  "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"
  "/Applications/Google Chrome Canary.app/Contents/MacOS/Google Chrome Canary"
  "/Applications/Chromium.app/Contents/MacOS/Chromium"
  "/Applications/Brave Browser.app/Contents/MacOS/Brave Browser"
  "/Applications/Microsoft Edge.app/Contents/MacOS/Microsoft Edge"
  "/Applications/Arc.app/Contents/MacOS/Arc"
  # Linux
  "/usr/bin/google-chrome"
  "/usr/bin/google-chrome-stable"
  "/usr/bin/chromium"
  "/usr/bin/chromium-browser"
  "/usr/bin/brave-browser"
  "/usr/bin/microsoft-edge"
  "/snap/bin/chromium"
)

BROWSER=""
for candidate in "${CANDIDATES[@]}"; do
  if [[ -x "$candidate" ]]; then
    BROWSER="$candidate"
    break
  fi
done

# Fallback to PATH lookup
if [[ -z "$BROWSER" ]]; then
  for name in google-chrome chrome chromium chromium-browser brave-browser microsoft-edge; do
    if command -v "$name" >/dev/null 2>&1; then
      BROWSER="$(command -v "$name")"
      break
    fi
  done
fi

if [[ -z "$BROWSER" ]]; then
  echo "error: no Chromium-based browser found." >&2
  echo "install one of: Google Chrome, Chromium, Brave, Microsoft Edge." >&2
  exit 1
fi

# Render. --virtual-time-budget gives Google Fonts time to load before snapshot.
"$BROWSER" \
  --headless=new \
  --disable-gpu \
  --no-sandbox \
  --no-pdf-header-footer \
  --print-to-pdf-no-header \
  --hide-scrollbars \
  --virtual-time-budget=10000 \
  --print-to-pdf="$ABS_OUTPUT" \
  "file://$ABS_INPUT" \
  >/dev/null 2>&1

if [[ ! -f "$ABS_OUTPUT" ]]; then
  echo "error: PDF was not written. Browser may have failed silently." >&2
  exit 1
fi

SIZE=$(wc -c < "$ABS_OUTPUT" | tr -d ' ')
echo "ok: wrote $ABS_OUTPUT ($SIZE bytes) via $BROWSER"
