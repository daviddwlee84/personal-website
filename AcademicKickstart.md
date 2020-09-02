# [Academic Kickstart](https://sourcethemes.com/academic/)

**Academic** makes it easy to create a beautiful website for free using Markdown, Jupyter, or RStudio. Customize anything on your site with widgets, themes, and language packs. [Check out the latest demo](https://academic-demo.netlify.com/) of what you'll get in less than 10 minutes, or [view the showcase](https://sourcethemes.com/academic/#expo).

**Academic Kickstart** provides a minimal template to kickstart your new website.

* [**Get Started**](#install)
* [View the documentation](https://sourcethemes.com/academic/docs/)
* [Ask a question](http://discuss.gohugo.io/)
* [Request a feature or report a bug](https://github.com/gcushen/hugo-academic/issues)
* Updating? View the [Update Guide](https://sourcethemes.com/academic/docs/update/) and [Release Notes](https://sourcethemes.com/academic/updates/)
* Support development of Academic:
  * [Donate a coffee](https://paypal.me/cushen)
  * [Become a backer on Patreon](https://www.patreon.com/cushen)
  * [Decorate your laptop or journal with an Academic sticker](https://www.redbubble.com/people/neutreno/works/34387919-academic)
  * [Wear the T-shirt](https://academic.threadless.com/)

[![Screenshot](https://raw.githubusercontent.com/gcushen/hugo-academic/master/academic.png)](https://github.com/gcushen/hugo-academic/)

## Install

You can choose from one of the following four methods to install:

* [**one-click install using your web browser (recommended)**](https://sourcethemes.com/academic/docs/install/#install-with-web-browser) <= I used this
* [install on your computer using **Git** with the Command Prompt/Terminal app](https://sourcethemes.com/academic/docs/install/#install-with-git)
* [install on your computer by downloading the **ZIP files**](https://sourcethemes.com/academic/docs/install/#install-with-zip)
* [install on your computer with **RStudio**](https://sourcethemes.com/academic/docs/install/#install-with-rstudio)

Then [personalize your new site](https://sourcethemes.com/academic/docs/get-started/).

## Ecosystem

* **[Academic Admin](https://github.com/sourcethemes/academic-admin):** An admin tool to import publications from BibTeX or import assets for an offline site
* **[Academic Scripts](https://github.com/sourcethemes/academic-scripts):** Scripts to help migrate content to new versions of Academic

## License

Copyright 2017-present [George Cushen](https://georgecushen.com).

Released under the [MIT](https://github.com/sourcethemes/academic-kickstart/blob/master/LICENSE.md) license.

---

Netlify

* [Overview | dwlee-personal-website](https://app.netlify.com/sites/dwlee-personal-website/overview) - Manage website on Netlify
* [Changes coming to Netlify site URLs - Support / Support Guides - Netlify Community](https://community.netlify.com/t/changes-coming-to-netlify-site-urls/8918)

Google Analytics

> * [Using a Beacon Image for GitHub, Website and Email Analytics](https://www.sitepoint.com/using-beacon-image-github-website-email-analytics/)
> * [Set up a property - Analytics Help](https://support.google.com/analytics/answer/1042508?hl=en)
>   * [apply Google](https://analytics.google.com/analytics/web/?authuser=0#/provision)

* Set on Github page?!
  * [igrigorik/ga-beacon: Google Analytics collector-as-a-service (using GA measurement protocol).](https://github.com/igrigorik/ga-beacon) - follow the **Setup instructions**
  * track page
    * `[![Analytics](https://ga-beacon.appspot.com/UA-XXXXXXXXX-X/repo-name/page)](https://github.com/igrigorik/ga-beacon)`
    * `UA-XXXXXXXXX-X` is your Tracking ID (追蹤 ID)
    * add `?param` after image link to hide the image
* Set on Academic Kickstart
  * [Customization | Academic](https://sourcethemes.com/academic/docs/customization/#analytics)

Publication filtering

```md
{{% alert note %}}
Quickly discover relevant content by [filtering publications]({{< ref "/publication/_index.md" >}}).
{{% /alert %}}
```

YAML vs. TOML

> academic predominantly ([Front Matter | Academic](https://sourcethemes.com/academic/docs/front-matter/))
>
> * use YAML to format the front matter of content files
> * use TOML to format the configuration files and widget files

* YAML
  * [Learn yaml in Y Minutes](https://learnxinyminutes.com/docs/yaml/)
  * warp in `---`
* TOML
  * [Learn toml in Y Minutes](https://learnxinyminutes.com/docs/toml/)
  * warp in `+++`

---

## Note

Currently, the default author is "admin". Use it in the `authors: ["admin", ...]` instead of the "literally name" (but if it's other's then whatever) so that it can link everything that labeled with same author name. (including showing a little name card at the bottom of the posts)

doi => [Digital Object Identifier System](https://www.doi.org/)

### Set Multi-Language

* [Language and translation | Academic](https://sourcethemes.com/academic/docs/language/)
* [HTML ISO Language Code Reference](https://www.w3schools.com/tags/ref_language_codes.asp)
* [Language Code Table](http://www.lingoes.cn/zh/translator/langcode.htm)

#### Issues of zh-Hant

* The `zh-Hant` vs. `zh-hant` problem: [i18n: add 中文 (繁體) by TMineCola · Pull Request #1381 · gcushen/hugo-academic](https://github.com/gcushen/hugo-academic/pull/1381)
* The content can use name `content/zh-Hant` but `static/zh-Hant` will cause problems...

> * Github submodule commit

### Math

> [Managing content | Academic](https://sourcethemes.com/academic/docs/managing-content/#math-and-code)

To enable LaTeX math rendering for a page, you should include `markup: mmark` and `math: true` in the page’s [front matter](https://sourcethemes.com/academic/docs/front-matter/).

```toml
markup: mmark
math: true
```

> I use this one currently

Otherwise, to enable math on the homepage or for all pages, you must globally set `math = true` in `config/_default/params.toml`.

### Contribute to Academic Kickstart

[Contributing to Academic](https://github.com/gcushen/hugo-academic/blob/master/.github/contributing.md)

## Trouble Shooting

* [failed to extract shortcode: template for shortcode "alert" not found · Issue #1034 · gcushen/hugo-academic](https://github.com/gcushen/hugo-academic/issues/1034)

### Submodule

* I forked the `themes/academic` [here](https://github.com/daviddwlee84/hugo-academic) to fix [`zh-Hant` problem](#issues-of-zh-hant).
* [Hugo Build Failing After Upgrading Theme Submodule - Support - Netlify Community](https://community.netlify.com/t/hugo-build-failing-after-upgrading-theme-submodule/3241/2)
* [error: Server does not allow request for unadvertised object · Issue #511 · AppImage/AppImageKit](https://github.com/AppImage/AppImageKit/issues/511)
  * `git submodule sync`
