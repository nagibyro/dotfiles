#!/usr/bin/env bash
#
# patch-berkeley-mono.sh
# Patch all Berkeley Mono .otf files with Nerd Fonts glyphs, forcing clean
# internal Family/Style names so the weights group correctly in font menus.
#
# Why this approach (the short version):
#   * The nerdfonts/patcher image patches EVERY file it finds in /in, in
#     parallel, and derives each output name from the font FAMILY only. All six
#     Berkeley Mono files share one family ("Berkeley Mono"), so left alone they
#     all compute the SAME output filename and clobber each other -> 1 survivor.
#   * Berkeley Mono's weight metadata is slightly off, so --makegroups can't
#     reliably split Black/Bold/Regular/Oblique apart either.
#   * Fix: set the names explicitly with --name "Family-Style". The patcher
#     splits --name on the hyphen into Family (name ID 1) and SubFamily (ID 2).
#   * Gotcha: the stock image entrypoint word-splits its arguments, so a --name
#     value containing spaces gets mangled ("unrecognized arguments"). We bypass
#     the entrypoint and invoke fontforge + the patcher script directly
#     (/nerd/font-patcher), which passes argv through verbatim and lets us keep
#     a nicely spaced family name.
#
# Usage:
#   ./patch-berkeley-mono.sh
#   IN_DIR=/some/dir OUT_DIR=/another ./patch-berkeley-mono.sh   # override paths

set -euo pipefail

# ---- config -----------------------------------------------------------------
IN_DIR="${IN_DIR:-$HOME/opt/berkeley-mono/original}"
OUT_DIR="${OUT_DIR:-$HOME/opt/berkeley-mono/patched}"
IMAGE="${IMAGE:-nerdfonts/patcher}"
FAMILY="${FAMILY:-BerkeleyMono Nerd Font Mono}"   # name ID 1; spaces OK, keep it hyphen-free

# Output is captured to a log, so --no-progressbars keeps it readable on failure.
PATCH_OPTS=(--no-progressbars --mono --adjust-line-height --complete)

# Map each source file (basename without .otf) to its target style string.
# Edit the right-hand side to taste. Oblique -> Italic so editors treat it as
# the italic member of the family; change to "Oblique" if you prefer literal
# naming. Keep styles hyphen-free (the hyphen is reserved for Family-Style).
declare -A STYLE=(
  ["BerkeleyMono-Regular"]="Regular"
  ["BerkeleyMono-Bold"]="Bold"
  ["BerkeleyMono-Oblique"]="Italic"
  ["BerkeleyMono-Bold-Oblique"]="Bold Italic"
  ["BerkeleyMono-Black"]="Black"
  ["BerkeleyMono-Black-Oblique"]="Black Italic"
)
# -----------------------------------------------------------------------------

# colours (disabled when stdout is not a terminal)
if [[ -t 1 ]]; then
  BOLD=$'\e[1m'; GREEN=$'\e[32m'; RED=$'\e[31m'; YELLOW=$'\e[33m'; DIM=$'\e[2m'; RESET=$'\e[0m'
else
  BOLD=""; GREEN=""; RED=""; YELLOW=""; DIM=""; RESET=""
fi
info() { printf '%s==>%s %s\n'  "$BOLD"   "$RESET" "$*"; }
ok()   { printf '%s  ok %s %s\n' "$GREEN"  "$RESET" "$*"; }
warn() { printf '%s  !! %s %s\n' "$YELLOW" "$RESET" "$*"; }
err()  { printf '%sfail %s %s\n' "$RED"    "$RESET" "$*"; }

# ---- preflight --------------------------------------------------------------
command -v docker >/dev/null 2>&1 || { err "docker not found on PATH"; exit 1; }
[[ -d "$IN_DIR" ]] || { err "input dir not found: $IN_DIR"; exit 1; }

shopt -s nullglob
FONTS=("$IN_DIR"/*.otf)            # bash returns this already sorted
shopt -u nullglob
(( ${#FONTS[@]} > 0 )) || { err "no .otf files in $IN_DIR"; exit 1; }

mkdir -p "$OUT_DIR"

info "Input : $IN_DIR"
info "Output: $OUT_DIR"
info "Image : $IMAGE"
info "Family: $FAMILY"
info "Found ${#FONTS[@]} font file(s) to patch"
echo

# ---- patch loop -------------------------------------------------------------
declare -i n_ok=0 n_fail=0
declare -a failed=()
log="$(mktemp)"
trap 'rm -f "$log"' EXIT

for src in "${FONTS[@]}"; do
  base="$(basename "$src")"        # e.g. BerkeleyMono-Bold.otf
  stem="${base%.otf}"              # e.g. BerkeleyMono-Bold

  style="${STYLE[$stem]:-}"
  if [[ -z "$style" ]]; then
    warn "no style mapping for '$stem' — skipping (add it to the STYLE array)"
    echo
    continue
  fi

  forced_name="${FAMILY}-${style}"
  info "Patching ${BOLD}${stem}${RESET}  ->  name \"${forced_name}\""

  # Bypass the image entrypoint (it word-splits args and mangles names with
  # spaces). Invoke fontforge + the patcher script directly so argv — including
  # the spaced --name value — is passed through verbatim.
  if docker run --rm \
        -v "$IN_DIR":/in:ro \
        -v "$OUT_DIR":/out \
        --entrypoint fontforge \
        "$IMAGE" \
        -script /nerd/font-patcher \
        -out /out \
        "${PATCH_OPTS[@]}" \
        --name "$forced_name" \
        /in/"$base" \
        >"$log" 2>&1
  then
    outfile="$(grep -oE "/out/[^']+\.otf" "$log" | tail -n1 | sed 's|/out/||')"
    ok "${stem}  ->  ${outfile:-"(written to $OUT_DIR)"}"
    n_ok+=1
  else
    err "${stem} failed — last lines of patcher output:"
    tail -n 15 "$log" | sed "s/^/${DIM}      /; s/\$/${RESET}/"
    failed+=("$stem")
    n_fail+=1
  fi
  echo
done

# ---- summary ----------------------------------------------------------------
info "Done. ${GREEN}${n_ok} patched${RESET}, ${RED}${n_fail} failed${RESET}."
(( n_fail > 0 )) && warn "Failed: ${failed[*]}"
echo

# ---- verify internal names --------------------------------------------------
info "Patched files in $OUT_DIR:"
reader=""
if   command -v otfinfo >/dev/null 2>&1; then reader="otfinfo"
elif command -v fc-scan >/dev/null 2>&1; then reader="fc-scan"; fi

found_any=0
for f in "$OUT_DIR"/*.otf; do
  [[ -e "$f" ]] || break
  found_any=1
  size="$(du -h "$f" | cut -f1)"
  case "$reader" in
    otfinfo)
      fam="$(otfinfo --info "$f" 2>/dev/null | sed -n 's/^Family: *//p')"
      sub="$(otfinfo --info "$f" 2>/dev/null | sed -n 's/^Subfamily: *//p')"
      printf '   %s%-42s%s %6s   %s / %s\n' "$BOLD" "$(basename "$f")" "$RESET" "$size" "${fam:-?}" "${sub:-?}" ;;
    fc-scan)
      fam="$(fc-scan --format '%{family}' "$f" 2>/dev/null)"
      sty="$(fc-scan --format '%{style}'  "$f" 2>/dev/null)"
      printf '   %s%-42s%s %6s   %s / %s\n' "$BOLD" "$(basename "$f")" "$RESET" "$size" "${fam:-?}" "${sty:-?}" ;;
    *)
      printf '   %s%-42s%s %6s\n' "$BOLD" "$(basename "$f")" "$RESET" "$size" ;;
  esac
done
(( found_any )) || warn "  (no .otf files found in output)"

if [[ -z "$reader" ]]; then
  echo
  warn "Install 'otfinfo' (lcdf-typetools) or 'fc-scan' (fontconfig) to print the"
  warn "internal Family/SubFamily names alongside each file above."
fi

# non-zero exit if anything failed, so CI / && chains notice
(( n_fail == 0 ))
