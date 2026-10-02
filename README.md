# EKIO Academy

Site de ensino da [EKIO](https://ekio.io): tutoriais de R, gráficos comentados, blog e, em breve, cursos e livros. Feito em Quarto e publicado no Netlify.

## Estrutura

| Caminho | Conteúdo |
|---|---|
| `index.qmd` | Página inicial |
| `tutorials/` | Tutoriais, uma pasta por tema; a listagem fica em `index.qmd` |
| `weekly-charts/charts/` | Um `.qmd` por gráfico; imagens em `assets/images/weekly-charts/` |
| `blog/posts/` | Posts do blog, uma pasta por post |
| `cursos.qmd`, `livros.qmd` | Ofertas em preparação |
| `static/theme.scss` | Tema, a partir dos tokens de `ekio/design/marca` |
| `static/tiles.ejs` | Template das grades de imagem |
| `static/images/art/` | Arte editorial, a mesma série do ekio-site |

## Publicar

```sh
quarto render
```

Tutoriais e posts executam R. O resultado fica em `_freeze/`, que vai para o git, e o projeto usa `freeze: true`, então o Netlify renderiza o site sem R. Para atualizar um tutorial, renderize o arquivo localmente com `quarto render caminho/do/arquivo.qmd --execute`.

Todo tutorial e gráfico precisa de `image:` no front matter; a imagem é o card na listagem.
