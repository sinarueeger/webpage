+++
title = "Improved imputation of summary statistics for realistic settings"
date = "2017-10-16"

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
abstract = "Summary statistics imputation can be used to impute association summary statistics of an already conducted, genotype-based meta-analysis to higher genomic resolution. This is typically needed when genotype imputation is not feasible. Oftentimes, cohorts of such a meta-analysis are variable in terms of ancestry and available sample size varies SNP-to-SNP. Both phenomena violate the assumption of current methods that an external LD matrix and the covariance of the Z-statistics are the same. To address these two issues, we present two extensions to existing summary statistics imputation method. Both extensions manipulate the LD matrix needed for summary statistics imputation. Based on simulations using real data we find that accounting for ancestry admixture only becomes relevant with sample size > 1000, while for smaller reference panels the total sample size (irrespective of ancestry) seems more relevant. Furthermore, incorporating varying sample size across SNPs reduces MSE by 2.6-fold compared to the conventional approach."

# Featured image thumbnail (optional)
image_preview = ""

# Is this a selected publication? (true/false)
selected = true

# Projects (optional).
#   Associate this publication with one or more of your projects.
#   Simply enter the filename (excluding '.md') of your project file in `content/project/`.
projects = ["ssimp-project"]

# Links (optional).
url_pdf = "https://www.biorxiv.org/content/early/2017/10/16/203927"
url_preprint = "https://www.biorxiv.org/content/early/2017/10/16/203927"
url_code = "#"
url_dataset = "#"
url_project = "#"
url_slides = "#"
url_video = "#"
url_poster = "#"
url_source = "#"

# Custom links (optional).
#   Uncomment line below to enable. For multiple links, use the form `[{...}, {...}, {...}]`.
url_custom = [{name = "Custom Link", url = "http://example.org"}]

# Does the content use math formatting?
math = true

# Does the content use source code highlighting?
highlight = true

# Featured image
# Place your image in the `static/img/` folder and reference its filename below, e.g. `image = "example.jpg"`.
[header]
image = "ssimp-method.png"
caption = ""

+++

## More detail can easily be written here using *Markdown* and $\rm \LaTeX$ math code.
