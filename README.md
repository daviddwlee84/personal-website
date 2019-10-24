# David's Personal Website

[![Analytics](https://ga-beacon.appspot.com/UA-150731639-1/personal-website/readme)](https://github.com/igrigorik/ga-beacon)
[![Netlify Status](https://api.netlify.com/api/v1/badges/e0ae2679-a864-4cf1-b9be-5eb1ba6069ad/deploy-status)](https://app.netlify.com/sites/dwlee-personal-website/deploys)

* Academic Kickstart Template
* Deploy on Netlify
* Using [HUGO](https://gohugo.io/) Framework - [github](https://github.com/gohugoio/hugo)

## Getting Started

> To setup this project follow academic kickstart's [official instruction](AcademicKickstart.md) or use [one click installation](https://sourcethemes.com/academic/docs/install/#install-with-web-browser)

View offline

1. Install HUGO CLI tool `brew install hugo`
2. Get the theme first `git submodule update --init --recursive`
3. Run HUGO server by `hugo server` (or execute `./view.sh`)
4. Default will run on `http://localhost:1313/`

### Add Content

> [Managing content | Academic](https://sourcethemes.com/academic/docs/managing-content/)

Generate template

* Project: `hugo new --kind project project/the-project-name`
* Publication:
  * Automatically: `academic import --bibtex <path_to_your/publications.bib>` (`pip3 install academic`)
  * Manually: `hugo new --kind publication publication/<the-publication-name>`

## Resources

### Diagram

* [mermaid - Markdownish syntax for generating flowcharts, sequence diagrams, class diagrams, gantt charts and git graphs.](https://mermaidjs.github.io/)

### Art

Icon

> [Academic Icon](https://sourcethemes.com/academic/docs/page-builder/#icons)

* [Academicons](https://jpswalsh.github.io/academicons/)
  * `"fab"`/`"fas"`, `"far"`/`"ai"`
* [Icons | Font Awesome](https://fontawesome.com/icons?d=gallery)

Emoji

* [🎁 Emoji cheat sheet for GitHub, Basecamp, Slack & more](https://www.webfx.com/tools/emoji-cheat-sheet/)
