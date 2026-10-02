# EKIO Academy

Site de ensino da EKIO, em português. Quarto + Netlify.

## Seções

Tutoriais (`tutorials/`), Gráficos (`weekly-charts/charts/`), Blog (`blog/posts/`), Cursos e Livros (em preparação). Thumbnails ausentes estão em `TODO_MISSING_IMAGES.txt`. Sem inglês, sem preços, sem ofertas que não existem.

## Identidade visual

* Segue a marca EKIO (`../design/marca/MARCA.md`) em versão mais leve: página cinza `#F1F1F1`, branco `#FEFEFE` como segunda superfície, navy nos títulos e links. Só fonte sem serifa: Host Grotesk no site, Fira Code no código.
* Imagem em primeiro lugar: grades de tiles (imagem + título curto), com hierarquias variadas (grande, média, pequena).
* Evitar: título à esquerda e imagem à direita; pilha de rótulo + título + subtítulo; ícones; títulos em caixa alta; caixas com sombra ou borda arredondada.
* Arte editorial: técnica da série Hokusai do ekio-site em tom claro; prompts em `_design/image-prompts.md`. A arte nunca carrega texto. Gráficos são saída real do ggplot2/ekioplot.

## Código

* R: tidyverse style guide, `|>`, `{cli}` para mensagens.
* `_freeze/` vai para o git; o Netlify não roda R.
