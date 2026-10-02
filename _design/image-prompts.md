# EKIO Academy — image prompts

## Purpose and status

Imagery for learning to use data to understand a problem and communicate an
answer. Subjects include data science, economics, AI, R, visualization,
reports, and dashboards. Each artwork should show one recognizable analytical
operation or relationship: organizing, comparing, estimating, checking, or
communicating.

The light background and restrained Yoro blue and green palettes are the
shared foundation. The chosen direction is editorial illustration with the compositional
discipline of a scientific atlas. The compositions remain working subject
briefs to assess through pilots before generating the collection.

The current direction is flat statistical illustration: distributions,
connections, selection regions, boxes, and coordinated views. Lightness and
roundness remain the foundation. Books, notebooks, physical device mockups,
landscape scenery, shadows, and depth are excluded. A dashboard is a graphic
arrangement of views, not a rendered screen.

Use invented maps, spatial linework, or dot fields when they support the
subject. Sparse abstract backgrounds and bolder geometric treatments are
optional variations, not ingredients for every image. Vary the number, size,
and arrangement of views across the collection; do not default to three
panels or three stages.

## How to use

Combine the shared constraints, the aesthetic prompt, and one asset
composition. Choose references that demonstrate that aesthetic. The existing
`static/images/art/hero-metropolitan-geometry.webp` is optional layout context;
the Yoro palettes below take precedence over its colors. Use the successful flat analytical arrangements listed below as composition
references, while removing any shadows or dimensional treatment they contain.

Treat these generated artworks as editorial illustrations. Produce real charts,
code samples, report pages, and dashboard examples from code or the actual
product whenever accuracy or readable information matters. Add any required
artwork typography in layout rather than asking the image model to render it.

After generation, crop and convert to WebP, quality 85, longest side 1600px
(heroes 2400px), and save in `static/images/art/` under the specified filename.
For a centered 2.4:1 crop from a 2:1 image, roughly 8.3% is removed from both
the top and bottom. Keep essential artwork within the central 80% of the
source image's height. Check the actual page crop on desktop and mobile.

## Shared constraints

```text
Use case: editorial illustration for an educational website about data and economics. Create one finished artwork, no surrounding frame or watermark.

Show the analytical relationship specified in the composition. Use one clear focal point and generous open space. Analytical marks should communicate that relationship; use connections to explain correspondence, selection, projection, or comparison. Thin linking lines and restrained arrows are welcome when their endpoints have meaning. Do not add arbitrary charts, connecting ribbons, or interface panels as decoration. Do not default to rising trends.

Depict analytical relationships schematically. A scatter of points around a fitted line may suggest modeling; grouped marks may suggest classification; contrasting shapes may suggest comparison. Keep these relationships visually plausible without requiring numerical precision.

For histograms, use solid filled bars with subtly rounded corners. Never build a histogram or frequency distribution from stacked dots, circles, beads, or dot columns. Dots remain welcome for scatterplots, spatial observations, and individual residuals; do not stack them to encode bin counts.

Avoid details that invite factual inspection: axis titles, units, tick values, dates, named variables, source notes, recognizable datasets, or specific geographic boundaries. Omit axes unless they help the composition; when used, keep them unmarked. Do not imply a particular empirical finding.

Use enough structure to make the idea recognizable, while leaving its interpretation broad. Judge the image by whether it communicates the concept, rather than whether a viewer could reconstruct an analysis from it.

Use an off-white ground (#F1F1F1 / #FEFEFE), Yoro blue as the main color family, and Yoro green as a secondary accent. Yoro blue: #CFE2E9, #97BACB, #6590A7, #40667C, #284355. Yoro green: #E1E1B8, #ABBC8E, #78936B, #4C694D, #2F4633. Select a few shades per image rather than using the full palette. Reserve the darkest shades for focal marks and preserve contrast at thumbnail size. These are palette priorities, not exact area quotas.

Draw analytical motifs directly on the ground or inside flat boxes and selection regions. Use shared color, alignment, or selective connecting lines to relate views. Connections should identify corresponding observations or summaries, not form a decorative network. Keep the image entirely two-dimensional: no perspective, thickness, shadows, gradients, lighting effects, bevels, or raised cards. An overlap is a flat graphic intersection, not one object casting a shadow on another.

Keep the scene bright and readable. No books, notebooks, pages, cover mockups, physical tablets, scenery, cities, skylines, trees, mountains, horizons, or decorative plants. Spatial imagery means an invented plan-view map, boundaries, routes, or point pattern, never a landscape backdrop. No cyberpunk, futuristic control rooms, dark backgrounds, neon colors, glowing networks, robot heads, or decorative circuit boards.

For generated decorative artwork, omit text, letters, numbers, labels, signatures, and logos. Do not use simulated writing. A coding IDE may use broad, indented color strokes to suggest structure, but no readable syntax or interface labels. This restriction does not apply to real instructional charts, code, reports, or dashboard examples, which need their actual labels and content.
```

## Aesthetic prompt

```text
Create an editorial illustration for an educational website about data, economics, and computational methods.

Organize the composition with the discipline of a scientific atlas: deliberate alignment, clear groupings, and generous space between elements. This influence governs visual hierarchy, not empirical precision. Show one analytical idea through a recognizable relationship among observations, shapes, or views.

Use simplified flat forms, crisp edges, and selective fine linework. Introduce gentle curves and restrained asymmetry to give the composition character. Keep analytical marks visually clear; allow supporting shapes more freedom. Use solid color fields and strictly flat geometry. Rounded boxes, circular observations, and gently curved lines establish the base vocabulary. No objects, material rendering, paper texture, shadows, shading, gradients, perspective, or depth. Where the composition explicitly calls for a bold treatment, contrast the rounded marks with sharp boundaries, angular linework, or a flat geometric overlay.

Work on an off-white ground with muted Yoro blue supporting forms and focal details, plus selective Yoro green accents. Use a small selection of palette shades. Keep enough contrast to remain legible at small sizes. Let distributions, selection regions, and relationships among views carry the subject. Leave the background empty unless the composition explicitly requests sparse, pale abstract or spatial elements.

Let the subject provide the visual interest: variation, comparison, grouping, uncertainty, or transformation. Make connections selective and meaningful. Avoid arbitrary chart fragments, decorative networks, and uniformly rising curves. Do not force the idea into three elements: a single integrated figure, a pair of unequal views, a continuous field, or a deliberately denser dashboard may suit it better. The image should feel considered, approachable, and intellectually curious.

Avoid futuristic imagery, neon, dark backgrounds, glossy 3D, period ornament, distressed textures, and simulated writing. Leave typography to the website layout.
```

## Composition briefs — provisional

Small section tiles need one strong relationship that survives thumbnail size.
Wider cards can carry a comparison or transformation. Repeated subjects should
have different compositions so that section and content cards remain distinct.
Choose the arrangement to fit the relationship, not a fixed panel count.
Do not use every optional treatment in every asset.

### hero-academy.webp

Home page hero, 2.4:1.

```text
Wide composition dominated by one integrated field of observations with a selected subset and a compact distribution summarizing that subset. Use alignment and a few precise linking lines to make their relationship legible. Avoid an equal-width three-stage sequence. Keep the upper half calm for the page heading. No skyline or catalog of disciplines. Protect the subject from the vertical crop described above.
```

### secao-tutoriais.webp

Home strip, 1:1.

```text
A compact transformation from unordered records to grouped observations. Preserve a recognizable set of marks across both arrangements. Make the change in organization the focal point. Use two unequal flat regions with a few links between corresponding marks, no physical object.
```

### secao-graficos.webp

Home strip, 1:1.

```text
Two coordinated views of a small set of observations, with the same group highlighted in both. Use a shared blue emphasis to make the relationship legible. No decorative connecting ribbon.
```

### secao-blog.webp

Home strip, 1:1.

```text
One compact analytical figure with a single observation singled out by a restrained annotation line. Suggest examining and interpreting evidence. Leave annotation text absent; do not simulate writing.
```

### secao-cursos.webp

Home strip, 1:1.

```text
One integrated fitted relationship with circular observations and a few thin residual segments showing their distance from the curve. Make comparison the focal point within a single figure. No staged triptych, classroom, or projection screen.
```

### secao-livros.webp

Home strip, 1:1.

```text
One large histogram formed from solid blue bars with subtly rounded corners, with a small highlighted interval and a restrained bracket indicating a closer reading. Keep the silhouette compact and recognizable. The adjacent website label identifies the books section; do not depict a book or cover.
```

### secao-sobre.webp

Home strip, 1:1.

```text
A small field of observations beside a clear explanatory chart, with one shared highlighted group. Emphasize the Academy's connection between applied analysis and teaching. Use an unequal pair of views, with the explanatory chart dominant; no architecture.
```

### curso-r-para-economistas.webp

Course card, 3:2.

```text
A time series of observations with visible fluctuations around a distinct smoother trend. Make the separation between observations and trend the central idea. Avoid a uniformly rising trajectory. A narrow residual strip beneath the main figure can show deviations, with a few thin links to corresponding observations. Keep the views unequal in size and fully flat. Let the adjacent page title identify R; do not invent code.
```

### curso-analise-urbana.webp

Course card, 3:2.

```text
A simplified plan of adjacent urban blocks paired with a compact comparison of their densities. Use consistent blue shades to link areas and measurements. Make spatial variation the focal point, rather than sculptural buildings. This is a conceptual illustration, not an asserted map of a real place.
```

### livro-r-para-economia-urbana.webp

Book card, 3:2.

```text
An abstract spatial pattern beside a distribution of its measurements, linked by a single highlighted subset. Use standalone flat subject artwork, with invented map boundaries and a compact solid-bar histogram. No generated book or cover; an actual published cover, if needed, is a separate site asset.
```

### livro-guia-de-dados.webp

Book card, 3:2.

```text
Two arrangements of records, before and after organizing inconsistent groups into a clear shared structure. Use alignment and spacing to show the transformation. Use flat boxes and selective links between corresponding records. Vary the widths and spacing of the two arrangements; no guidebook, report page, or storage props.
```

### sobre-banner.webp

About page banner, 2.4:1.

```text
A broad composition connecting an invented urban pattern with a schematic analytical representation. Give the spatial subject and the analytical motif comparable visual weight; avoid a decorative skyline. Leave generous calm space and protect the subject from the vertical crop described above.
```

## Direction after the roundness exploration

Composition references from `_design/pilots/roundness-exploration-v1/`:

- `dashboard-5-selection-detail`: a selection related to summary views.
- `dashboard-3-three-soft-windows`: unequal boxes and coordinated views.
- `dashboard-1-rounded-tablet`: an enclosing shape and clear chart grouping;
  retain the arrangement, remove the device reading and shadow.
- `economics-5-cycle-and-residuals`: a dominant curve, residual strip, and
  meaningful links.
- `hero-5-layered-observations`: grouping and transformation within boxes;
  retain the relationship without making three boxes a collection template.

The book-based pilots are rejected directions. Earlier prompts and images
remain in `_design/pilots/` as history, not instructions for new artwork.

## Optional variation studies

Combine each study with the shared constraints and aesthetic prompt. These
are alternatives to test, not features to combine into every composition.
Use the same subject across alternatives when comparing treatments.

### Sparse abstract background

```text
Landscape 3:2. One dominant blue solid-bar histogram with a sage highlighted interval and a small linked summary curve. Add only a few very pale blue broken arcs or short line segments in otherwise empty margins. Keep the background marks sparse, flat, and subordinate; they must not resemble scenery or extra data panels. No three-part layout.
```

### Spatial selection

```text
Landscape 3:2. A large invented plan-view map made of sparse angular boundaries and blue circular observations. Highlight a small spatial subset in muted green and relate it through two fine lines to a narrow solid-bar histogram at the edge. Use an unequal map-and-summary composition, no third panel. No recognizable geography, buildings, terrain, map labels, or shadows.
```

### Bold geometric overlay

```text
Landscape 3:2. One integrated scatter field crosses a sharp-edged pale-blue polygon. A flat sage selection band intersects the field, with selected circular observations emphasized in dark blue. Use hard boundaries and overlapping solid color regions as graphic art, with no depth or shadow. Add one small bracket or angular accent where it clarifies the selected region. Preserve generous off-white space. No separate dashboard cards or ornamental scenery.
```

### Connected pair

```text
Landscape 3:2. A dominant fluctuating series around a smooth curve and a slim residual plot of individual unstacked dots beneath it. Use a few fine straight linking lines to connect observations to their residuals. Rounded dots contrast with crisp linework. Empty off-white background, no containers, no decorative accents. Avoid a uniformly rising trend.
```

### Uneven dashboard

```text
Landscape 3:2. One large rounded scatter region beside four small, differently sized summary boxes arranged with deliberate spacing. The same muted-green selection appears across views through color and a few selective linking lines. Keep summaries simple enough to read at thumbnail size. Completely flat fills; boxes have no thickness or shadows. No device outline, background motifs, or decorative network.
```

## Pilot and acceptance checks

Earlier pilots and their exact prompts remain in `_design/pilots/` as a
historical record; they do not override this current brief.

Before generating the full collection, test the hero, the R/economics card,
and a temporary AI or dashboard study using the same chosen aesthetic.
The third study tests topic coverage; it does not add a new site slot.

For AI, compare model predictions with observations, including a visible
mismatch. For dashboards, use a few aligned views sharing one highlighted
selection. Pick one study for the pilot.

Inspect the results together at their intended display sizes and page crops.
Check that the analytical idea is recognizable, subjects are distinguishable,
blue and green details remain visible, and the style holds across topics.
Check that every image is strictly flat: no shadows, depth, physical objects,
or landscape scenery. Connections must explain a visible relationship.
Compare the collection side by side for repeated panel counts, equal-width
triptychs, and repeated silhouettes. Keep sparse backgrounds, spatial motifs,
and bold angular treatments selective; some images should remain very simple.
Roundness is the base vocabulary, not a ban on deliberate sharp accents.
Relationships should be visually plausible without implying specific
measurements or empirical findings. Ask whether the idea reads clearly, not
whether measurements or correspondences are exact. Reject details that invite
factual inspection. Real instructional figures remain separate from these
artworks.

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

Keep `hero-metropolitan-geometry.webp` after the swap as optional layout
context; use the Yoro palettes for new artwork.
