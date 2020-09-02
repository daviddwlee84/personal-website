# README

> [template github](https://github.com/posquit0/Awesome-CV)

Compile:

```sh
xelatex resume.tex
```

> move the `resume.pdf` to `static/files/cv.pdf` which is configured in `menus.toml`

## Trouble Shooting

`LaTeX3 Error: Command '\FA' already defined`

* [Error: Command \FA already defined · Issue #234 · posquit0/Awesome-CV](https://github.com/posquit0/Awesome-CV/issues/234)

```diff
diff --git a/awesome-cv.cls b/awesome-cv.cls
index d1c1074..48c3da2 100644
--- a/awesome-cv.cls
+++ b/awesome-cv.cls
@@ -161,7 +161,7 @@
 %                Configuration for fonts
 %-------------------------------------------------------------------------------
 % Set the FontAwesome font to be up-to-date.
-\newfontfamily\FA[Path=\@fontdir]{FontAwesome}
+\setfontfamily\FA[Path=\@fontdir]{FontAwesome}
 % Set font for header (default is Roboto)
 \newfontfamily\headerfont[
   Path=\@fontdir,
```
