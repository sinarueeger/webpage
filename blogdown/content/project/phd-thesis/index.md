+++
# Project title.
title = "Integrative Statistical Analysis of -omics and GWAS data"

# Date this page was created.
date = 2019-05-28T00:00:00

# Project summary to display on homepage.
summary = "PhD thesis material."

# Tags: can be used for filtering projects.
# Example: `tags = ["machine-learning", "deep-learning"]`
tags = ["statistical genetics"]

# Slides (optional).
#   Associate this project with Markdown slides.
#   Simply enter your slide deck's filename without extension.
#   E.g. `slides = "example-slides"` references 
#   `content/slides/example-slides.md`.
#   Otherwise, set `slides = ""`.
slides = ""

# Links (optional).
url_pdf = "https://drive.switch.ch/index.php/s/FpWZlbw4Rfq20le"
url_slides = "https://sinarueeger.github.io/publicdefense/slides#1"
url_video = ""
url_code = "https://github.com/sinarueeger/publicdefense"

# Custom links (optional).
#   Uncomment line below to enable. For multiple links, use the form `[{...}, {...}, {...}]`.
#links = [{icon_pack = "fab", icon="twitter", name="Follow", url = "https://twitter.com/georgecushen"}]

# Featured image
# To use, add an image named `featured.jpg/png` to your project's folder. 
[image]
  # Caption (optional)
  caption = "Analogy to summary statistic imputation"
  
  # Focal point (optional)
  # Options: Smart, Center, TopLeft, Top, TopRight, Left, Right, BottomLeft, Bottom, BottomRight
  focal_point = "Smart"
+++

I finished my PhD under the main supervison of <a href="https://wp.unil.ch/sgg/">Zolt&#225;n Kutalik</a> in September 2018.

You can download [my thesis](https://drive.switch.ch/index.php/s/FpWZlbw4Rfq20le), or checkout the [slides](https://sinarueeger.github.io/publicdefense/slides#1) from my public defense. 


## Abstract

Increasing our knowledge about biology in humans is essential for advances in medicine, such as early-stage diagnoses of diseases, drug development, public health strategies, and precision medicine. 
One approach to tackle this task is, to collect data on different components of a biological mechanism of interest, link these parts and try to construct an underlying model that helps us to explain the disease. 
To collect data, DNA is measured and the status of a disease is recorded for each individual in a dedicated group of people. 
In a first step, an analyst compares for each genetic variant across the whole genome the genetic mutations between people with the disease and healthy people; this is called a genome-wide association study (GWAS). 
Such first association screens rarely point right away to the true causal variants, but combined with additional biomedical (-omics) data and additional statistical methods it is possible to narrow down the true cause and gain insight into the biology of a disease. 
For example, by using GWAS results for two diseases (e.g. cardiovascular disease and obesity) and a statistical method called Mendelian randomisation, we are able to examine the causal effect of obesity on cardiovascular disease, or vice versa. 
These statistical follow-up investigations often require GWAS results for genetic variants than were unmeasured. 
During my PhD, I investigated a method called summary statistic imputation that precisely aims to solve the problem of inferring GWAS results for unmeasured genetic variants. Summary statistic imputation uses GWAS results and data from public sequencing data. My main findings were that imputation accuracy varies depending on certain characteristics of a genetic variant (e.g. low accuracy for rare mutations), as well as the size of publicly available sequencing data (low accuracy for small sized sequencing data).
A further finding is, that summary statistic imputation can compete with imputation techniques that are based on individual-level data for certain subgroups of genetic variants (e.g. common variants). 

With the help of summary statistic imputation researchers can facilitate follow-up investigations and thus gain more insight into the biology of diseases. 

