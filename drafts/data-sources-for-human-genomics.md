+++
title = "Data Sources for human genomics"
description = "(Data Science in Genomics)"
author = "Sina R&uuml;eger"
date = 2018-05-07T19:28:31+02:00
tags = ["R","genomics","data"]
category = ["concepts", "data science in genomics"]
draft = true
+++


<img src="/post/types_of_data.jpeg" alt="This is me." align="middle" style="width: 200px;"/>

In principle, there are five sources for genomic data: 

1. Local study cohorts ([UK Biobank](http://www.ukbiobank.ac.uk/), [Health and Retirement Study](http://hrsonline.isr.umich.edu/), [CoLaus](https://www.colaus-psycolaus.ch/colaus/), [Cebu Longitudinal Health and Nutrition Survey](http://www.cpc.unc.edu/projects/cebu/about) and many many [more](https://media.nature.com/original/nature-assets/nature/journal/v542/n7640/extref/nature21039-s2.xlsx), check STable1) > A + B
2. Summary statistics from study cohorts ([GWAS catalog](https://www.ebi.ac.uk/gwas/), [UKBB neale lab](https://nealelab.github.io/UKBB_ldsc/), [MRbase](http://www.mrbase.org/), local summary stats: [GIANT](https://portals.broadinstitute.org/collaboration/giant/index.php/GIANT_consortium_data_files), [Psychiatric Genomics Consortium (PGC)](https://www.med.unc.edu/pgc/results-and-downloads))  > C
3. Genetic reference panels ([1KG](http://www.internationalgenome.org/), [Human Genetic Diversity Project (HGDP)](http://www.hagsc.org/hgdp/files.html), [UK10K](https://www.uk10k.org/data_access.html), [POPRES](https://www.ncbi.nlm.nih.gov/projects/gap/cgi-bin/dataset.cgi?study_id=phs000145.v4.p2&phv=173964&phd=&pha=&pht=2998&phvf=&phdf=&phaf=&phtf=&dssp=1&consent=&temp=1)) > mainly A (+B)
4. People like yourself uploading the data to platforms ([openSNP](https://opensnp.org/)) > A + B
5. Your own data (23andme, Family Tree, Ancestry.com). > (A+B, but for n = 1)

To draw conclusions about ... 

managed access (UK10K)

https://dna.land/ > impute
http://compass.dna.land/ > estimate
https://www.nebulagenomics.io/ > 



Are you familiar with the genetic cascade? Or with the [central dogma](https://en.wikipedia.org/wiki/Central_dogma_of_molecular_biology).

This theory has two implications:

- There is a flow from the left to the right: if you tune something on the DNA part, the right-hand side is affected. 
- Many little streams flow into the right (like a real cascade). For example: human height is affected by many different genes, not only one. So if you want to change height, you need to tune at many different genes to make a big change. 

In my work, I am mostly looking at everything that is more to the left (DNA and gene expression) and at traits more rightish hand side of the cascade. I do sometimes look at gene expression. 

Let's first look at the left hand side. 



yaniv erlich, dermitzakis




"statgen", "dataset"

[//]: ------------------------------- ## Version (hg18, hg19, hg20)

[//]: --- | UCSC | |
[//]: --- | --------- |:----------------------------------:|
[//]: --- | hg20 | Genome Reference Consortium GRCh38 |
[//]: --- | hg19 | Genome Reference Consortium GRCh37 |
[//]: --- | hg18 | NCBI Build 36 |

http://blog.kaggle.com/2017/09/11/how-can-i-find-a-dataset-on-kaggle/

 [Disclaimer](https://sinarueeger.github.io/2018/05/07/post/2018-05-07-why-DS-for-genomics.md)
 
