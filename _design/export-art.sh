#!/usr/bin/env bash
# Export the chosen pilots to static/images/art/.
#
# Each pilot's near-white background is replaced with the surface it sits on:
# #F1F1F1 (page) for full-bleed heroes and banners, #FEFEFE (paper) for tiles
# and cards. WebP quality 85, native size (no upscaling).
#
# Usage: bash _design/export-art.sh   (from the project root; needs ImageMagick)

set -euo pipefail

pilots="_design/pilots"
out="static/images/art"
page="#F1F1F1"
paper="#FEFEFE"

export_art() {
  local src="$1" dest="$2" bg="$3"
  # Most frequent color is the background.
  local from
  from=$(magick "$src" -format %c histogram:info:- |
    sort -rn | sed -n '1s/.*\(#[0-9A-F]\{6\}\).*/\1/p')
  magick "$src" -fuzz 2.5% -fill "$bg" -opaque "$from" \
    -quality 85 "$out/$dest"
  echo "$dest  <-  $src  ($from -> $bg)"
}

export_art "$pilots/flat-exploration-v2/hero-01-orbital-selection.png" hero-academy.webp "$page"
export_art "$pilots/remaining-briefs-v1/sobre-banner-03.png" sobre-banner.webp "$page"

export_art "$pilots/remaining-briefs-v1/secao-tutoriais-01.png" secao-tutoriais.webp "$paper"
export_art "$pilots/remaining-briefs-v1/secao-graficos-02.png" secao-graficos.webp "$paper"
export_art "$pilots/remaining-briefs-v1/secao-blog-01.png" secao-blog.webp "$paper"
export_art "$pilots/remaining-briefs-v1/secao-cursos-01.png" secao-cursos.webp "$paper"
export_art "$pilots/remaining-briefs-v1/secao-livros-02.png" secao-livros.webp "$paper"
export_art "$pilots/remaining-briefs-v1/secao-sobre-01.png" secao-sobre.webp "$paper"

export_art "$pilots/flat-exploration-v2/economics-05-signal-ribbon.png" curso-r-para-economistas.webp "$paper"
export_art "$pilots/remaining-briefs-v1/curso-analise-urbana-02.png" curso-analise-urbana.webp "$paper"
export_art "$pilots/remaining-briefs-v1/livro-r-para-economia-urbana-01.png" livro-r-para-economia-urbana.webp "$paper"
export_art "$pilots/remaining-briefs-v1/livro-guia-de-dados-03.png" livro-guia-de-dados.webp "$paper"
