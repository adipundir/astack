#!/usr/bin/env bash
# astack installer — copies every skill in this repo into ~/.claude/skills/
# Usage:
#   curl -fsSL https://raw.githubusercontent.com/adipundir/astack/main/install.sh | bash
#   # or, from a local clone:
#   bash install.sh

set -euo pipefail

REPO_URL="https://github.com/adipundir/astack.git"
DEST="${HOME}/.claude/skills"

cyan()  { printf "\033[36m%s\033[0m\n" "$*"; }
green() { printf "\033[32m%s\033[0m\n" "$*"; }
red()   { printf "\033[31m%s\033[0m\n" "$*" 1>&2; }

mkdir -p "${DEST}"

# If we're already inside a clone (skills/ directory present), install from here.
# Otherwise, clone to a temp dir and install from there.
if [[ -d "skills" && -f "README.md" && "$(grep -c '^# astack' README.md 2>/dev/null || echo 0)" -gt 0 ]]; then
  SRC="$(pwd)/skills"
  cyan "Installing from local clone: ${SRC}"
else
  TMP="$(mktemp -d)"
  trap 'rm -rf "${TMP}"' EXIT
  cyan "Cloning ${REPO_URL} ..."
  git clone --depth=1 "${REPO_URL}" "${TMP}/astack" >/dev/null 2>&1 || {
    red "Failed to clone ${REPO_URL}. Is git installed and online?"
    exit 1
  }
  SRC="${TMP}/astack/skills"
fi

if [[ ! -d "${SRC}" ]]; then
  red "No skills/ directory found at ${SRC}"
  exit 1
fi

installed=0
for skill in "${SRC}"/*/; do
  name="$(basename "${skill}")"
  target="${DEST}/${name}"
  if [[ -d "${target}" ]]; then
    cyan "Updating ${name}"
    rm -rf "${target}"
  else
    cyan "Installing ${name}"
  fi
  cp -R "${skill}" "${target}"
  installed=$((installed + 1))
done

green "Done. ${installed} skill(s) installed to ${DEST}"
green "Open a new Claude Code session to start using them."
