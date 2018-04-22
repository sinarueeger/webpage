+++
title = "Setting up the Blogdown Website"
description = ""
author = ""
date = 2018-04-14T10:00:03+02:00
tags = ["blogdown","github","hugo","workflow"]
category = ["workflow"]
draft = false
+++

To set up this website I have used some excellent material around [**blogdown**](https://bookdown.org/yihui/blogdown/get-started.html), [**github**](https://pages.github.com/) and [**hugo**](https://themes.gohugo.io/). 


## Motivation

Before going into the technical details, let me say something about motivation and inspiration. For me, it definitely helped to read the blogpost by [David Robinson](http://varianceexplained.org/r/start-blog/), being encouraged by [Ma&euml;lle Salmon](http://www.masalmon.eu/rladiesct/slides#1) and seeing many others leading by example (among many: Marie Christine Dussault on [mcdussault.rbind.io](http://mcdussault.rbind.io/post/building-your-blog-using-blogdown/) or [Kasia Kulma](https://kkulma.github.io/2017-12-29-end-of-year-thoughts/)).

I might get into a more personal motivation in a future blogpost.

## Instructions to get a first version running
- **blogdown** *package* & *instructions* by [Yihui Xie, Amber Thomas and Alison Presmanes Hill](https://bookdown.org/yihui/blogdown/get-started.html).


- [Emily Zabor](http://www.emilyzabor.com/tutorials/rmarkdown_websites_tutorial.html) gives a general **overview** of how to make websites, not limited to blogging. But from her tutorial I learned about the `serve site` feature.

- Instructions by [Marie Christine Dussault](http://mcdussault.rbind.io/post/building-your-blog-using-blogdown/) include the nitty-gritty details of **changing the domain name** when deploying to [Netlify](https://www.netlify.com/).

## Changing the layout

### 1. Choose a theme
Ideally, you should choose a theme **before** you create your website with blogdown. 

I did not, but my page had not much content yet. I had the *academic* theme first, then changed to *ghostwriter*, because I like simplicity and wanted the blog posts to have their own page.

Hugo has a [gallery](https://themes.gohugo.io/) with different themes. Choose one (be aware that not all themes were [tested against](https://bookdown.org/yihui/blogdown/other-themes.html) blogdown!).

While the *academic* theme offers different color palettes in the `.toml` file, the **ghostwriter** does not have this feature. 

### 2. Personalising the `.css` file
Luckily, you can access the `.css` file and change everything you want (depending on how experienced you are with css files).

The `.css` file is located in `/themes/ghostwriter/static/dist/style.css`.

I wanted to personalise two things:

- color
- font

#### Color
The default color theme is red. But I wanted something dark blue. So I went through all the colors (look for `#`) and changed all red to `#003366` and all light red to `#deebf7`.

#### Font

The default font is [<font face="Open Sans">Open Sans</font>](https://fonts.google.com/specimen/Open+Sans). I went for [Dosis](https://fonts.google.com/specimen/Dosis), simply, because I prefer it (currently).

### 3. Caution!
When choosing a theme and changing the `css` file keep the last paragraph from this [section](https://bookdown.org/yihui/blogdown/other-themes.html) from the blogdown instructions in mind!

## Incorporating *gist* files

My first post was written on [gist.github](https://gist.github.com/) first. To embed *gist* posts, I used the workaround documented [here](https://gohugo.io/content-management/shortcodes/#gist). 

The following code snippet will only display the file `encryption_files.md` from the *gist* `https://gist.github.com/sinarueeger/aadfe4916cf285e32d5a55f320a82a6f`. 

<pre><code class="language-md" data-lang="md">{{&lt; gist sinarueeger aadfe4916cf285e32d5a55f320a82a6f &#34;encryption_files.md&#34; &gt;}}
</code></pre>




