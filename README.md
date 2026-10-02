# EKIO Academy

Site de ensino da [EKIO](https://ekio.io): tutoriais de R, gráficos comentados e, em breve, cursos e livros. Feito em Quarto e publicado no Netlify.

## Estrutura

| Caminho | Conteúdo |
|---|---|
| `index.qmd` | Página inicial |
| `tutoriais/` | Um `.qmd` por tutorial; a listagem fica em `index.qmd` |
| `graficos/` | Um `.qmd` por gráfico; imagens em `static/images/graficos/` |
| `cursos.qmd`, `livros.qmd` | Ofertas em preparação |
| `static/theme.scss` | Tema, a partir dos tokens de `ekio/design/marca` |
| `static/tiles.ejs` | Template das grades de imagem |
| `static/images/art/` | Arte editorial, a mesma série do ekio-site |

## Publicar

```sh
quarto render
```

Os tutoriais executam R. O resultado fica em `_freeze/`, que vai para o git, então o Netlify renderiza o site sem R.

Todo tutorial e gráfico precisa de `image:` no front matter; a imagem é o card na listagem.
