# EKIO Academy

Site de ensino da EKIO, em português. Quarto + Netlify.

## Seções

Tutoriais (`tutoriais/`), Gráficos (`graficos/`), Cursos e Livros (em preparação). Sem inglês, sem preços, sem ofertas que não existem.

## Identidade visual

* Segue a marca EKIO (`../design/marca/MARCA.md`) em versão mais leve: fundo paper, uma faixa linho no máximo, navy nos títulos e links.
* Imagem em primeiro lugar: grades de tiles (imagem + título curto), com hierarquias variadas (grande, média, pequena).
* Evitar: título à esquerda e imagem à direita; pilha de rótulo + título + subtítulo; ícones; títulos em caixa alta; caixas com sombra ou borda arredondada.
* Arte editorial vem da série Hokusai do ekio-site e nunca carrega texto. Gráficos são saída real do ggplot2/ekioplot.

## Código

* R: tidyverse style guide, `|>`, `{cli}` para mensagens.
* `_freeze/` vai para o git; o Netlify não roda R.
