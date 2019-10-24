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

Google Analytics

> * [Using a Beacon Image for GitHub, Website and Email Analytics](https://www.sitepoint.com/using-beacon-image-github-website-email-analytics/)

* [igrigorik/ga-beacon: Google Analytics collector-as-a-service (using GA measurement protocol).](https://github.com/igrigorik/ga-beacon) - follow the **Setup instructions**
* [Set up a property - Analytics Help](https://support.google.com/analytics/answer/1042508?hl=en)
  * [apply Google](https://analytics.google.com/analytics/web/?authuser=0#/provision)
  * track page
    * `[![Analytics](https://ga-beacon.appspot.com/UA-XXXXXXXXX-X/repo-name/page)](https://github.com/igrigorik/ga-beacon)`
    * `UA-XXXXXXXXX-X` is your Tracking ID (追蹤 ID)
    * add `?param` after image link to hide the image

Publication filtering

```md
{{% alert note %}}
Quickly discover relevant content by [filtering publications]({{< ref "/publication/_index.md" >}}).
{{% /alert %}}
```

---

## Trouble Shooting

* [failed to extract shortcode: template for shortcode "alert" not found · Issue #1034 · gcushen/hugo-academic](https://github.com/gcushen/hugo-academic/issues/1034)
