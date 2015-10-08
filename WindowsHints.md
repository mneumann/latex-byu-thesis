# Introduction #

I used WinEdt, MikTex, and `pdflatex` on WindowsXP to prepare my thesis. As such, some system specific tweaks were required. The problems along with the fixes I used are listed below.

# Details #

**Long chapter titles do not wrap to multiple lines in the Table of Contents**

This is caused by the default options passed to the hyperfer package in the `example.tex` file. Changing the first option from `ps2pdf` to `pdftex` and chaning the `breaklinks` option from `false` to `true` will correct the problem. (Note: Chris has indicated that there are compelling reasons not to use `pdflatex`. I don't know the reasons, but I'm sure he can give you more information if you're interested.)

With these changes, my `\usepackage` command for the `hyperref` package looks like this:

```
\usepackage[
    pdftex,
    bookmarks=true,
    breaklinks=true,
    raiselinks=true,
    pdfborder={0 0 0},
    colorlinks=false,
    ]{hyperref}
```

**References section does not appear in the Table of Contents**

Chris's hack in the example file does work with my configuration. However, before he came up with that one, I used another solution which I will post here for completeness.

The `tocbibind` package allows users to control which sections are included in the Table of Contents. This pacakge is included in the default MikTek installation. The commands to use it are shown below.

```
\usepackage[nottoc,notlof,notlot]{tocbibind}
\settocbibname{References}
```