+++
title = "satRday Cardiff 2018"
description = "Recap of the one-day R conference in Wales"
author = "Sina Rüeger"
date = 2018-07-04T10:20:22+02:00
tags = ["conference", "R", "satrday", "rppensci", "package", "dplyr"]
category = ["conference", "R"]
draft = false
+++

This is a brief write-up of my [satRdays Cardiff](http://cardiff2018.satrdays.org/) experience.

First - what is a [**satRday**](http://satrdays.org/)? 

It is an awesome concept: attending an **R conference** organised by a **local RUG** on a **Saturday**. 

The [programme](http://cardiff2018.satrdays.org/#programme) in Cardiff had parallel sessions - tough decision-making to pick between promising talks!

## `dplyr` workshop

Kathrine Tansey kept us busy with a workshop on `dplyr` in the morning.

💻 [rstudio-cloud project](https://rstudio.cloud/project/42122)

<img src="https://user-images.githubusercontent.com/4454726/41937493-bf142a7c-7990-11e8-9174-ddb57641438b.jpg" height="200" />

## Packaging workshop

[Heather Turner](https://twitter.com/HeathrTurnr) upgraded us on packaging. 

💡 useful tips and workflow! Eager to apply what I learned. 

💻 [rstudio-cloud project](https://rstudio.cloud/project/38916)

➡️ [Slides](https://github.com/forwards/workshops/blob/master/Cardiff-satRday/mini-course.pptx)


## Introduction to tidytext

Textmining with [Nujcharee (เป็ด)](https://twitter.com/Nujcharee), applied to #metoo twitter data:


<
<blockqe class="twitter-tweet" data-cards="hidden" data-lang="en"><p lang="en" dir="ltr">My slide on Introduction to Tidytext <a href="https://t.co/XOiEiedNjN">https://t.co/XOiEiedNjN</a> <a href="https://twitter.com/satRdays_org?ref_src=twsrc%5Etfw">@satRdays_org</a> <a href="https://twitter.com/hashtag/rstats?src=hash&amp;ref_src=twsrc%5Etfw">#rstats</a></p>&mdash; Nujcharee (เป็ด) (@Nujcharee) <a href="https://twitter.com/Nujcharee/status/1010521563676991489?ref_src=twsrc%5Etfw">June 23, 2018</a></blockquote>

<img src="https://user-images.githubusercontent.com/4454726/41937494-bf3e2020-7990-11e8-8453-a6b566e3b469.jpg" height="200" />

<img src="https://user-images.githubusercontent.com/4454726/41937495-bf6db1b4-7990-11e8-8ad3-cd9a5727feff.jpg" height="200" />


## Package reviews with rOpenSci

[Maëlle Salmon](https://twitter.com/ma_salmon) presented the review process of [rOpenSci](https://ropensci.org/) and then reviewed the review process using the force of textmining. 

💡 Rigorous, but friendly reviewing process at [rOpenSci](https://ropensci.org/).

More info on submitting a package for review [here](https://ropensci.github.io/dev_guide/policies.html).

➡️ [Slides](https://maelle.github.io/satrday_cardiff/slides)

<img src="https://user-images.githubusercontent.com/4454726/41937496-bf8bc802-7990-11e8-8ec5-7854d7b5bbf0.jpg" height="200" />

<img src="https://user-images.githubusercontent.com/4454726/41937497-bfa75bd0-7990-11e8-97a8-f4af880a2233.jpg" height="200" />

## Airtable & R

[Amy McDougall](https://twitter.com/AmyMcDougall96) presented [airtable](https://airtable.com/) (💡!) and the R interface [`airtabler`](https://github.com/bergant/airtabler).

➡️ [Slides](https://github.com/Amymcdougall/talks/tree/master/airtable-and-r)

<img src="https://user-images.githubusercontent.com/4454726/41937499-bfe9f562-7990-11e8-90f5-62c866c54055.jpg" height="200" />

## Lightening talks

### Counting and weighing Penguins

[Philipp Boersch-Supan](https://twitter.com/pboesu) telling us about the challenges of counting penguins (and apparently `Rcpp` helps). 

<img src="https://user-images.githubusercontent.com/4454726/41937501-c02f66ec-7990-11e8-8768-7c72c4347e7d.jpg" height="200" />

### Integrating command-line tools with R

[Erle Holgersen](https://twitter.com/wuergh): embrace the `system()` function for command-line snippets in R. 

For example:
```
ls.directory <- system("ls -all", intern = TRUE)
```

💡 `intern = TRUE` is my new friend!

Other tips: 
- use the command line functionality in `data.table::fread("")`
- make use of `tempfile()`

<img src="https://user-images.githubusercontent.com/4454726/41937502-c04b0a3c-7990-11e8-80d4-093b6e22ba5c.jpg" height="200" />

### git in five

[Steph Locke](https://twitter.com/TheStephLocke) gave *git in a nutshell*. 

💡 Recommendation: use [GitKraken](https://www.gitkraken.com/) as a GUI client.

### tidy eval

[Nic Crane](https://twitter.com/nic_crane) explaining the basics of [*tidy eval*](https://thisisnic.github.io/2018/03/29/what-is-tidy-eval-and-why-should-i-care/) and when it is needed (💡 functions!).

<img src="https://user-images.githubusercontent.com/4454726/41937503-c07f5328-7990-11e8-911d-0935036da635.jpg" height="200" />

### A simple Bayesian workflow

[Paul Robinson](https://twitter.com/brennanpcardiff) presented his [Bioconductor](https://bioconductor.org/) package dealing with proteins. 

➡️ [Slides](https://rpubs.com/brennanpincardiff/drawproteins_satRday_2018)

### R-Forwards and R-Ladies Remote

[Heather Turner](https://twitter.com/HeathrTurnr) presented two #rstats related initiatives.

[**R Forwards**](https://forwards.github.io/) is an initiative to widen the participation of under-represented groups ➡️ looking for volunteers that take on [tasks](https://github.com/forwards/tasks/issues).

<img src="https://user-images.githubusercontent.com/4454726/41937505-c0bee56a-7990-11e8-9ab3-ed7bf54967e0.jpg" height="200" />

[**R-Ladies remote**](https://twitter.com/rladiesremote?lang=en) chapter: has monthly coffee breaks on slack!

<img src="https://user-images.githubusercontent.com/4454726/41937506-c106292a-7990-11e8-9160-5e745c5de340.jpg" height="200" />


## Final remarks

👏 Kudos to the organisers! They paid lots of attention to details and did an awesome job in making everyone feel welcome!

✍️ Mental note to self: I should probably learn how to take pics at the right time + live tweet 😉


## Further information

📁 [Slides repo](https://github.com/satRdays/cardiff2018_talks).

📘 Check out Maëlle's blogpost on [Storrrify #satRdayCDF 2018](https://masalmon.eu/2018/06/26/storrrify-satrdaycdf-2018/).

[#satRdayCDF](https://twitter.com/search?q=satRdayCDF&src=typd) on Twitter.

⏭️ [Next satRday](https://amsterdam2018.satrdays.org/) is on September 1 2018 in Amsterdam. 


📅 Check all [upcoming events](satrdays.org/events/).


Also 👇

<blockquote class="twitter-tweet" data-lang="en"><p lang="en" dir="ltr">If you would like a satRday near you, why not run one?<br><br>Here&#39;s what you need to know to decide if it&#39;s right for you <a href="https://t.co/Szy7AMB3rF">https://t.co/Szy7AMB3rF</a></p>&mdash; satRdays (@satRdays_org) <a href="https://twitter.com/satRdays_org/status/1011627085507506177?ref_src=twsrc%5Etfw">June 26, 2018</a></blockquote>

