# David's Personal Website

[![Analytics](https://ga-beacon.appspot.com/UA-150731639-1/personal-website/readme)](https://github.com/igrigorik/ga-beacon)
[![Netlify Status](https://api.netlify.com/api/v1/badges/e0ae2679-a864-4cf1-b9be-5eb1ba6069ad/deploy-status)](https://app.netlify.com/sites/dwlee-personal-website/deploys)

* [Academic](https://themes.gohugo.io/academic/) [Kickstart](https://sourcethemes.com/academic/) [Template](https://github.com/sourcethemes/academic-kickstart)
* Deploy on [Netlify](https://www.netlify.com/)
* Using [HUGO](https://gohugo.io/) Framework - [github](https://github.com/gohugoio/hugo)

> Seems this Acadamic theme is moving on to be the [Wowchemy: Free Website Builder for Hugo](https://wowchemy.com/) project. ([issue](https://github.com/daviddwlee84/personal-website/issues/10))

## Getting Started

> To setup project like this, follow academic kickstart's [official instruction](AcademicKickstart.md) or use [one click installation](https://sourcethemes.com/academic/docs/install/#install-with-web-browser)

View offline

1. Install HUGO CLI tool `brew install hugo` / `apt install hugo`
   * [Install Hugo | Hugo](https://gohugo.io/getting-started/installing/)
   * [Install Hugo on WSL - sal.as](https://sal.as/post/install-hugo-on-wsl/)
   * [Releases · gohugoio/hugo](https://github.com/gohugoio/hugo/releases)
     * Make sure you download the "extended version"
     * Better use the same version as deployment (i.e. [version 0.58.3](https://github.com/gohugoio/hugo/releases/tag/v0.58.3))
       1. `wget https://github.com/gohugoio/hugo/releases/download/v0.58.3/hugo_extended_0.58.3_Linux-64bit.deb`
       2. `sudo dpkg -i hugo_extended_0.58.3_Linux-64bit.deb`
     * [TOCSS: failed to transform "main_parsed.scss" (text/x-scss): this feature is not available in your current Hugo version · Issue #1129 · gcushen/hugo-academic](https://github.com/gcushen/hugo-academic/issues/1129)
   * [klakegg/hugo](https://hub.docker.com/r/klakegg/hugo/)
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

Markdown Badges

* [badges/shields: Concise, consistent, and legible badges in SVG and raster format](https://github.com/badges/shields)
  * [Shields.io: Quality metadata badges for open source projects](https://shields.io/)
  * Github stars: `/github/stars/:user/:repo?style=social`
* [Naereen/badges: Markdown code for lots of small badges (shields.io, forthebadge.com etc) . Contributions are welcome! Please add yours!](https://github.com/Naereen/badges)
* [ddavison/github-badges: Star / Fork badges for your GitHub Repository!](https://github.com/ddavison/github-badges)

### CV/Resume Template

* [Resume: A Tale of Desire, Intrigue, and Formatting](http://www.zackgrossbart.com/hackito/resume/)

#### LaTeX

* [LaTeX Templates » Curricula Vitae/Résumés](https://www.latextemplates.com/cat/curricula-vitae)
* [posquit0/Awesome-CV: Awesome CV is LaTeX template for your outstanding job application](https://github.com/posquit0/Awesome-CV)
* [dyweb/awesome-resume-for-chinese](https://github.com/dyweb/awesome-resume-for-chinese) - a collection of template that support Chinese (including LaTeX, HTML/JS)

#### Online Resume Builder

* [CakeResume](https://www.cakeresume.com/) - free for only one document
* [五百丁](https://www.500d.me/) - not free
