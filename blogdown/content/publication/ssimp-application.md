+++
title = "Evaluation and application of summary statistic imputation to discover new height-associated loci"
date = "2017-10-18"

# Authors. Comma separated list, e.g. `["Bob Smith", "David Jones"]`.
authors = ["S Rüeger", "A McDaid", "Z Kutalik"]

# Publication type.
# Legend:
# 0 = Uncategorized
# 1 = Conference proceedings
# 2 = Journal
# 3 = Work in progress
# 4 = Technical report
# 5 = Book
# 6 = Book chapter
publication_types = ["2"]

# Publication name and optional abbreviated version.
publication = "bioRxiv"
publication_short = "bioRxiv"

# Abstract and optional shortened version.
abstract = "As most of the heritability of complex traits is attributed to common and low frequency genetic variants, imputing them by combining genotyping chips and large sequenced reference panels is the most cost-effective approach to discover the genetic basis of these traits. Association summary statistics from genome-wide meta-analyses are available for hundreds of traits. Updating these to ever-increasing reference panels is very cumbersome as it requires reimputation of the genetic data, rerunning the association scan, and meta-analysing the results. A much more efficient method is to directly impute the summary statistics, termed as summary statistics imputation. Its performance relative to genotype imputation and practical utility has not yet been fully investigated. To this end, we compared the two approaches on real (genotyped and imputed) data from 120K samples from the UK Biobank and show that, while genotype imputation boasts a 2- to 5-fold lower root-mean-square error, summary statistics imputation better distinguishes true associations from null ones: We observed the largest differences in power for variants with low minor allele frequency and low imputation quality. For fixed false positive rates of 0.001, 0.01, 0.05, using summary statistics imputation yielded an increase in statistical power by 15, 10 and 3%, respectively. To test its capacity to discover novel associations, we applied summary statistics imputation to the GIANT height meta-analysis summary statistics covering HapMap variants, and identified 34 novel loci, 19 of which replicated using data in the UK Biobank. Additionally, we successfully replicated 55 out of the 111 variants published in an exome chip study. Our study demonstrates that summary statistics imputation is a very efficient and cost-effective way to identify and fine-map trait-associated loci. Moreover, the ability to impute summary statistics is important for follow-up analyses, such as Mendelian randomisation or LD-score regression."

# Featured image thumbnail (optional)
image_preview = ""

# Is this a selected publication? (true/false)
selected = true

# Projects (optional).
#   Associate this publication with one or more of your projects.
#   Simply enter the filename (excluding '.md') of your project file in `content/project/`.
projects = ["ssimp-project"]

# Links (optional).
url_pdf = "https://www.biorxiv.org/content/early/2017/10/18/204560"
url_preprint = "https://www.biorxiv.org/content/early/2017/10/18/204560"
url_code = "#"
url_dataset = "#"
url_project = "#"
url_slides = "#"
url_video = "#"
url_poster = "#"
url_source = "#"

# Custom links (optional).
#   Uncomment line below to enable. For multiple links, use the form `[{...}, {...}, {...}]`.
## url_custom = [{name = "Custom Link", url = "http://example.org"}]

# Does the content use math formatting?
math = true

# Does the content use source code highlighting?
highlight = true

# Featured image
# Place your image in the `static/img/` folder and reference its filename below, e.g. `image = "example.jpg"`.
[header]
image = "ssimp-application.png"
caption = ""

+++

## More detail can easily be written here using *Markdown* and $\rm \LaTeX$ math code.
