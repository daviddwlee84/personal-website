# David's Personal Website

[![Analytics](https://ga-beacon.appspot.com/UA-150731639-1/personal-website/readme)](https://github.com/igrigorik/ga-beacon)
[![Netlify Status](https://api.netlify.com/api/v1/badges/e0ae2679-a864-4cf1-b9be-5eb1ba6069ad/deploy-status)](https://app.netlify.com/sites/dwlee-personal-website/deploys)

* [Academic](https://themes.gohugo.io/academic/) [Kickstart](https://sourcethemes.com/academic/) [Template](https://github.com/sourcethemes/academic-kickstart)
* Deploy on Netlify
* Using [HUGO](https://gohugo.io/) Framework - [github](https://github.com/gohugoio/hugo)

## Getting Started

> To setup project like this, follow academic kickstart's [official instruction](AcademicKickstart.md) or use [one click installation](https://sourcethemes.com/academic/docs/install/#install-with-web-browser)

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

* [academic主題 - Hugo學習筆記](https://skyao.io/learning-hugo/theme/academic.html)

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

### CV/Resume Template

* [Resume: A Tale of Desire, Intrigue, and Formatting](http://www.zackgrossbart.com/hackito/resume/)

#### LaTeX

* [LaTeX Templates » Curricula Vitae/Résumés](https://www.latextemplates.com/cat/curricula-vitae)
* [posquit0/Awesome-CV: Awesome CV is LaTeX template for your outstanding job application](https://github.com/posquit0/Awesome-CV)
* [dyweb/awesome-resume-for-chinese](https://github.com/dyweb/awesome-resume-for-chinese) - a collection of template that support Chinese (including LaTeX, HTML/JS)

#### Online Resume Builder

* [CakeResume](https://www.cakeresume.com/) - free for only one document
* [五百丁](https://www.500d.me/) - not free
