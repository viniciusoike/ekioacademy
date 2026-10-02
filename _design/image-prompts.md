# EKIO Academy — image prompts

A lighter branch of the EKIO Hokusai series used on ekio.io. Same woodblock
print technique and the same blues, but on cool off-white paper with most of
the surface left empty. The site background is `#F1F1F1`; the art should sit
on it without looking like a dark block.

## How to use

Each prompt has two parts. Paste the **shared style** block first, then the
**composition** of the image you want. Attach
`static/images/art/hero-metropolitan-geometry.webp` as reference image 1, for
technique and geometry only.

Export as WebP, quality 85, longest side 1600px (heroes 2400px), and save in
`static/images/art/` under the file name given in each heading.

## Shared style

```text
Use case: stylized-concept. Create one finished website artwork, no mockup, no collage, no frame.

Reference image 1 is a style reference ONLY: keep its architectural geometry, crisp layered planes and the tactile mottled woodblock-print / washi-paper texture. Do NOT copy its dark navy sky or its heavy ink coverage.

Light key. The ground is cool off-white paper, #F1F1F1 to #FEFEFE, slightly cool, never cream, never yellow, never linen. At least 65% of the image is pale paper or very pale blue wash. Ink load is light, like a first-state print pulled with little pigment.

Palette, in order of area: paper #F1F1F1 / #FEFEFE; pale blue #E8F6FF and #B1D8F2; mid blue #84B8DD and #5597CC; slate blue #517A90. Navy #1E3A5F only as thin lines, small shadow planes or fine detail, under 10% of the area. Optional gold #D5AA48 under 2% of the area. No black fills. Muted, calm, airy. Flat printed illustration with dimensional planes, not photorealism, no glossy 3D, no gradients that look digital.

Absolute exclusions: all text, letters, numbers, labels, titles, captions, legends, signatures, seals, logos, watermarks; people, faces, hands, cars, animals, plants, mountains, sky with clouds. Full bleed, no paper border.
```

## Composition prompts

### hero-academy.webp

Home page hero. Aspect 2.4:1 (generate 2:1 and keep the middle).

```text
Asset/composition: Wide hero, landscape. An imaginary modernist city seen as a few tall pale architectural planes rising from the lower edge, cropped by the frame, with long horizontal parapets and one gentle curved facade. Buildings are mostly paper-white faces with pale blue shadow planes and thin navy edge lines. Upper 55% of the image is empty pale paper with a faint, even woodblock grain. Calm, bright, spacious; the opposite of a night skyline. Keep the important shapes inside the central 80% width so a 2.4:1 crop works.
```

### secao-tutoriais.webp

Home strip, square 1:1.

```text
Asset/composition: Square. A drafting-table view from above: a sheet of fine grid paper, slightly rotated, with one hand-drawn line chart rising across it in slate blue and a few small circular data points. A thin ruler and a set square lie across one corner as flat printed shapes. Most of the square is pale paper. No text, no tick labels, no numbers.
```

### secao-graficos.webp

Home strip, square 1:1.

```text
Asset/composition: Square. Three small flat charts printed on one pale sheet as if pulled from separate woodblocks: a short column chart in pale and mid blue, a thin connected line in navy, and a loose scatter of round points. They overlap slightly and are offset like misregistered print layers. Wide empty margins. No axes labels, no text, no numbers.
```

### secao-blog.webp

Home strip, square 1:1.

```text
Asset/composition: Square. A writing desk seen from above in light key: a few loose sheets of pale paper fanned out, one with a small printed line chart in slate blue, a fountain pen lying diagonally, and a thin navy ruled margin on each sheet. Mostly empty paper-white surface. No writing, no letters, no numbers.
```

### secao-cursos.webp

Home strip, square 1:1.

```text
Asset/composition: Square. A quiet empty lecture hall rendered as architecture only: rows of pale stepped benches converging toward a large blank light-blue panel at the far wall, tall vertical windows letting in white light on one side. Strong perspective, simple geometric planes, mostly paper-white with pale blue shadows. No people, no writing on the panel.
```

### secao-livros.webp

Home strip, square 1:1.

```text
Asset/composition: Square. A few closed books stacked and leaning, seen as clean geometric blocks: paper-white page edges, pale and mid blue covers, one thin gold band on a spine. Behind them, a tall pale window frame casting a soft diagonal blue shadow. Very spare, lots of empty paper. No titles or text on spines or covers.
```

### secao-sobre.webp

Home strip, square 1:1.

```text
Asset/composition: Square. Close crop of a São Paulo modernist facade in light key: a sinuous horizontal brise-soleil band recalling Copan, rendered as pale paper-white curves with thin navy edges and pale blue shadow bands between them. Clean, rhythmic, bright. No street, no sky detail.
```

### curso-r-para-economistas.webp

Course card, aspect 3:2.

```text
Asset/composition: Landscape 3:2. An open notebook lying flat, its right page a fine grid with a hand-plotted time-series line in slate blue that rises with realistic dips; the left page holds a small column chart in pale blue. A pencil rests diagonally across the spread. Flat top-down view, woodblock texture, wide paper margins around the notebook. No writing, no numbers, no labels.
```

### curso-analise-urbana.webp

Course card, aspect 3:2.

```text
Asset/composition: Landscape 3:2. An abstract city block in light isometric view, buildings as pale paper-white volumes of different heights, a few roofs tinted in pale and mid blue as if shaded by a data value, one tower in navy line work only. Generous empty paper around the block. Reads as an urban model on a light table. No streets with cars, no map labels, no text.
```

### livro-r-para-economia-urbana.webp

Book card, aspect 3:2.

```text
Asset/composition: Landscape 3:2. A single closed book standing upright, seen slightly from the side, its cover a pale blue field with a small printed architectural motif of layered towers in navy line work. It stands on a pale ledge against an empty off-white wall with a faint vertical shadow. Calm and centered with wide margins. No title, no author, no text of any kind on the cover.
```

### livro-guia-de-dados.webp

Book card, aspect 3:2.

```text
Asset/composition: Landscape 3:2. A row of plain archive boxes and file folders on a long pale shelf, drawn as clean geometric blocks, alternating paper-white, pale blue and mid blue, one folder slightly pulled out. Thin navy edge lines, soft blue shadows, lots of empty wall above. Suggests an organized data catalog. No labels, no text, no numbers on boxes or folders.
```

### sobre-banner.webp

About page banner. Aspect 2.4:1 (generate 2:1 and keep the middle).

```text
Asset/composition: Wide banner, landscape. A light-key elevation of São Paulo's historic downtown: an ornate theater facade recalling Theatro Municipal beside two simple modern towers, all rendered as pale paper-white faces with pale blue shadows and thin navy contour lines. Buildings occupy the lower half; the upper half is empty pale paper. Ornament simplified into geometric woodcut shapes. No street, no sky detail.
```

## Wiring the new files

The pages still point to the ekio-site art. When the new files exist, swap the
paths below and delete the old WebPs that are no longer referenced.

| Slot | Current file | New file |
|---|---|---|
| Home hero (`index.qmd`) | `hero-metropolitan-geometry.webp` | `hero-academy.webp` |
| Strip: Tutoriais | `card-positive-correlation.webp` | `secao-tutoriais.webp` |
| Strip: Gráficos | `insight-market-cycles.webp` | `secao-graficos.webp` |
| Strip: Blog | `insight-signal-and-cycle.webp` | `secao-blog.webp` |
| Strip: Cursos | `insight-sao-paulo-copan.webp` | `secao-cursos.webp` |
| Strip: Livros | `cover-layered-inquiry.webp` | `secao-livros.webp` |
| Strip: Sobre | `banner-sao-paulo-heritage.webp` | `secao-sobre.webp` |
| `cursos.qmd`, first card | `insight-office-towers.webp` | `curso-r-para-economistas.webp` |
| `cursos.qmd`, second card | `insight-old-and-new.webp` | `curso-analise-urbana.webp` |
| `livros.qmd`, first card | `cover-layered-inquiry.webp` | `livro-r-para-economia-urbana.webp` |
| `livros.qmd`, second card | `cover-metropolitan-fields.webp` | `livro-guia-de-dados.webp` |
| `sobre.qmd` banner | `banner-sao-paulo-heritage.webp` | `sobre-banner.webp` |

Keep `hero-metropolitan-geometry.webp` after the swap: it is the style
reference for the prompts above.
