## ---- setup, include = FALSE, warning=FALSE, message=FALSE---------------
library(showtext)
library(tidyverse)
#library(icon) ## for fa icons, installed via gh: https://github.com/ropenscilabs/icon


## ---- sketch-data, eval = TRUE, echo = FALSE, warning=FALSE--------------
## get data
url <- "https://portals.broadinstitute.org/collaboration/giant/images/2/21/BMI_All_ancestry.fmt.gzip"
dat.bmi <- data.table::fread(url, verbose = FALSE)
start <- 45e6
end <- 55e6
dat.bmi.sketch <- dat.bmi %>% filter(CHR == 12 & POS >=  start & POS <= end)




## ---- sketch, eval = FALSE, echo = FALSE---------------------------------
## 
## # Code bits and showtext package from https://github.com/yixuan/showtext
## ## Loading Google fonts (http://www.google.com/fonts)
## font_add_google(name = "Caveat", family = "Caveat", regular.wt = 400, bold.wt = 700)
## 
## ## Automatically use showtext to render text for future devices
## showtext_auto()
## 
## ## Tell showtext the resolution of the device,
## ## only needed for bitmap graphics. Default is 96
## ## showtext_opts(dpi = 96)
## 
## 
## ## Plotting functions as usual
## col.blue <- "#377eb8"
## col.red <- "#e41a1c"
## font <- "Caveat"
## 
## png("../../static/post/2018-07-04-plotting-local-genomic-association-results-in-r/locuszoom-sketch.png", 800, 600, res = 96)
## 
## op <- par(cex.lab = 1.8, cex.axis = 1.3, cex.main = 2, las = 1, family = font, mar = c(5, 5, 5, 1))
## plot(dat.bmi.sketch$POS, -log10(dat.bmi.sketch$Pvalue), xlab = "Chromosomal position (bp)", ylab = "-log10(P-value)", ylim = c(-10, 40), yaxt="n")
## axis(2, at = seq(-10,40, 10), labels = c("", seq(0, 40, 10)))
## title("Zoom into GWAS results")
## dat.bmi.sketch.min <- dat.bmi.sketch %>% slice(which.min(Pvalue))
## text(dat.bmi.sketch.min$POS, -log10(dat.bmi.sketch.min$Pvalue), "Each dot is a SNP",cex = 1.5, col = col.red, srt = 0, pos = 4)
## 
## ## add horizontal lines
## text(end - 2e6, -5, "This is a gene",cex = 1.5, col = col.blue, srt = 0, pos = 4)
## text(start + 4e5, -10, "This is another gene", cex = 1.5, col = col.blue, pos = 4)
## lines(c(start + 3e6, end - 2e6), c(-5, -5), col = col.blue, lwd = 5)
## lines(c(start + 1e5, start + 4e5), c(-10, -10), col = col.blue, lwd = 5)
## par(op)
## dev.off()
## 


## ----sketch-table, echo = FALSE, results = 'asis', cache = TRUE----------

## SNP ids from https://www.ncbi.nlm.nih.gov/pmc/articles/PMC4382211/
dat.bmi.head <- dat.bmi %>% filter(SNPNAME %in% c("rs657452", "rs12286929","rs7903146", "rs11057405","rs1167827"))
## annotate dat.bmi.sketch
library(biomaRt)
snp.ensembl <- useEnsembl(biomart = "snp", dataset = "hsapiens_snp")
out.bm.snp <- getBM(
  attributes = c('ensembl_gene_stable_id','phenotype_name', 'refsnp_id','minor_allele_freq'), 
      filters = 'snp_filter', 
      values = dat.bmi.head$SNPNAME, 
      mart = snp.ensembl)

gene.ensembl <- useEnsembl(biomart = "ensembl", dataset = "hsapiens_gene_ensembl") # we will need an additional mart for genes
out.bm.gene <- getBM(attributes = c('external_gene_name','ensembl_gene_id'), 
      filters = c('ensembl_gene_id'),
      values = unique(out.bm.snp$ensembl_gene_stable_id), 
      mart = gene.ensembl)

out.bm.table <- dat.bmi.head %>% right_join(out.bm.snp, by = c("SNPNAME" = "refsnp_id")) %>% right_join(out.bm.gene, by = c("ensembl_gene_stable_id" = "ensembl_gene_id")) %>% filter(phenotype_name != "")

suppressPackageStartupMessages(library(kableExtra))
kable(out.bm.table %>% as_tibble %>% dplyr::select(CHR, POS, SNPNAME, REF, ALT, beta, se, external_gene_name, phenotype_name, minor_allele_freq) %>% dplyr::rename(Gene = external_gene_name, `Linked phenotype` = phenotype_name, `Global MAF` = minor_allele_freq)) %>%
  kableExtra::kable_styling("striped", full_width = F) %>%
  kableExtra::column_spec(8:10, bold = F, color = "white", background = "#31a354") %>%
  kableExtra::add_header_above(c("GWAS summary statistics dataset" = 7, "Annotation" = 3)) %>%  
  kableExtra::kable_styling(font_size = 13)
  


## ---- install-packages, echo=TRUE----------------------------------------
## Packages needed to run code
## ----------------------------
# install.packages("dplyr")     ## data manipulation
# install.packages("data.table") ## read data, fast!
# install.packages("forcats")   ## dealing with factors
# install.packages("ggplot2")   ## dataviz
# install.packages("magrittr")  ## piping
# install.packages("metafolio")  ## colorpalette
# install.packages("skimr")     ## summarising data
# install.packages("qqman")     ## Manhattan plot
# install.packages("patchwork") ## assembling plots

# source("https://bioconductor.org/biocLite.R")
# biocLite("biomaRt")           ## annotation

## Optional packages for Rmd
## --------------------------
# install.packages("kableExtra") ## making pretty tables
# install.packages("devtools")
# devtools::install_github("hadley/emo")        ## emojis
# devtools::install_github("ropenscilabs/icon") ## icons



## ---- load-packages, include=FALSE,warning=FALSE,message=FALSE-----------
## we are gonna need this
library(tidyverse)
theme_set(theme_bw())  ## make all ggplots white-ish



## ---- load-data, echo=TRUE, results="hide", cache=TRUE, message = FALSE, warning = FALSE----

## Data Source URL
url <- "https://portals.broadinstitute.org/collaboration/giant/images/2/21/BMI_All_ancestry.fmt.gzip"

#url <- "jenger.riken.jp/1analysisresult_qtl_download/All_2017_BMI_BBJ_autosome.txt.gz"

## Import BMI summary statistics dat.bmi <- read_tsv(file = url) ##
## taking too long, let's use fread instead.

dat.bmi <- data.table::fread(url, verbose = FALSE)



## ---- rename-data, echo=TRUE, results="hide", cache=TRUE, message = FALSE----
## Rename some columns
dat.bmi <- dat.bmi %>% rename(SNP = SNPNAME, P = Pvalue)


## ---- overview-data, warning = FALSE-------------------------------------
skimr::skim(dat.bmi)


## ---- mhtplot, warning =FALSE, message=FALSE-----------------------------
qqman::manhattan(dat.bmi %>% mutate(CHR = as.numeric(as.character(fct_recode(CHR, "23" = "X")))) %>%   filter(-log10(P)>1), chr="CHR", bp="POS", snp="SNP", p="P", suggestiveline =FALSE, genomewideline = FALSE, chrlabs = c(1:22, "X"), cex = 0.4)



## ---- define-bmi-selection, warning =FALSE-------------------------------

dat.bmi.sel <- dat.bmi %>% slice(which.min(P))
dat.bmi.sel



## ---- prep-selection-data, include = TRUE--------------------------------
range <- 5e+05
sel.chr <- dat.bmi.sel$CHR
sel.pos <- dat.bmi.sel$POS

dat.bmi.sel.region <- dat.bmi %>% filter(CHR == sel.chr, between(POS, sel.pos - 
      range, sel.pos + range))


## ---- plot-summarystats, include = TRUE----------------------------------

p1 <- ggplot(data = dat.bmi.sel.region) + 
  geom_point(aes(POS, -log10(P)), shape = 1) + 
  labs(title = "Locuszoomplot for BMI GWAS", subtitle = paste("Summary   statistics for chromosome", sel.chr, "from", format((sel.pos - range), big.mark = "'"), "to", format((sel.pos + range), big.mark = "'"), "bp"), caption = paste("Data source:", url))
print(p1)



## ---- load-biomart, include = TRUE---------------------------------------
library(biomaRt) 


## ---- choose-mart, include = TRUE----------------------------------------

snp.ensembl <- useEnsembl(biomart = "snp", dataset = "hsapiens_snp")

class(snp.ensembl)

# other ways of selecting the mart snp.mart <- useMart(biomart =
# 'ENSEMBL_MART_SNP', dataset='hsapiens_snp') 
# gene.mart <- useMart('ensembl', dataset='hsapiens_gene_ensembl')



## ---- get-snp-chr-pos, include = TRUE------------------------------------

out.bm <- getBM(
  attributes = c("ensembl_gene_stable_id", 
                 "refsnp_id", 
                 "chr_name", 
                 "chrom_start", 
                 "chrom_end", 
                 "minor_allele", 
                 "minor_allele_freq"),
                # "ensembl_transcript_stable_id",
                # "consequence_type_tv"),
  filters = "snp_filter", 
  values = "rs1421085",#dat.bmi.sel$SNP, 
  mart = snp.ensembl)



## ---- print-get-snp-chr-pos, include = TRUE------------------------------
out.bm


## ---- sanitychecks, include = TRUE---------------------------------------

ifelse(sel.pos == out.bm$chrom_start, 
       "\u2713: same assembley (GRCh38)", 
       "\u2717: not the same assembley")



## ---- get-snp-chr-pos-grch37, include = TRUE-----------------------------

snp.ensembl.grch37 <- useMart(host='http://grch37.ensembl.org', 
                     biomart='ENSEMBL_MART_SNP', 
                     dataset='hsapiens_snp')

out.bm.grch37 <- getBM(
  attributes = c('ensembl_gene_stable_id', 'refsnp_id', 'chr_name', 'chrom_start', 'chrom_end', 'minor_allele', 'minor_allele_freq'),
  filters = 'snp_filter',
  values = dat.bmi.sel$SNP,
  mart = snp.ensembl.grch37
)
out.bm.grch37



## ---- sanitychecks-grch37, include = TRUE--------------------------------

ifelse(sel.pos == out.bm.grch37$chrom_start,
       "\u2713: same assembley (grch37)", 
       "\u2717: not the same assembley")


## ---- get-snp-chr-pos-grch37-alternative, include = TRUE-----------------

snp.ensembl.grch37.alt <- useEnsembl(biomart = "snp", dataset = "hsapiens_snp", GRCh = 37)


out.bm.grch37 <- getBM(
  attributes = c('ensembl_gene_stable_id', 'refsnp_id', 'chr_name', 'chrom_start', 'chrom_end', 'minor_allele', 'minor_allele_freq'),
  filters = 'snp_filter',
  values = dat.bmi.sel$SNP,
  mart = snp.ensembl.grch37.alt
)
out.bm.grch37


## ---- sanitychecks-grch37-alternative, include = TRUE--------------------

ifelse(sel.pos == out.bm.grch37$chrom_start,
       "\u2713: same assembley (grch37)", 
       "\u2717: not the same assembley")



## ---- check-attributes, include = TRUE-----------------------------------
listAttributes(snp.ensembl) %>% slice(str_which(name, "gene")) 


## ---- get-snp-info, include = TRUE---------------------------------------

## extract gene
## ----------
out.bm.snp2gene <- getBM(
  attributes = c('refsnp_id', 'allele', 'chrom_start', 'chr_name', 'ensembl_gene_stable_id'), 
      filters = c('snp_filter'), 
      values = dat.bmi.sel$SNP, 
      mart = snp.ensembl)
out.bm.snp2gene

## Attribute `associated_gene` is `Associated gene with phenotype`.

## Extract string
## ----------
gene.ensembl <- useEnsembl(biomart = "ensembl", dataset = "hsapiens_gene_ensembl", GRCh = 37) # we will need an additional mart for genes
## because we are using positions from GRCh = 37 in a next query, we need to pass that information on.
out.bm.gene <- getBM(attributes = c('external_gene_name'), 
      filters = c('ensembl_gene_id'),
      values = unique(out.bm.snp2gene$ensembl_gene_stable_id), 
      mart = gene.ensembl)
out.bm.gene




## ---- get-all-genes-in-range, include=TRUE, cache=TRUE-------------------

out.bm.genes.region <- getBM(
  attributes = c('start_position','end_position','ensembl_gene_id','external_gene_name', 'gene_biotype'), 
      filters = c('chromosome_name','start','end'), 
      values = list(sel.chr, sel.pos - range, sel.pos + range), 
      mart = gene.ensembl)
head(out.bm.genes.region)




## ---- plot-genes, include = TRUE, fig.height = 3-------------------------

## rank gene names according to start position
out.bm.genes.region <- out.bm.genes.region %>% mutate(external_gene_name = fct_reorder(external_gene_name, 
      start_position, .desc = TRUE))

## plot
ggplot(data = out.bm.genes.region) + 
      geom_linerange(aes(x = external_gene_name, ymin = start_position, ymax = end_position)) + 
  coord_flip() + 
  ylab("")



## ---- plot-genes-pretty, include = TRUE, fig.height = 5------------------

## define plot range for x-axis
plot.range <- c(min(sel.pos - range, out.bm.genes.region$start_position), 
      max(sel.pos + range, out.bm.genes.region$end_position))

## rank gene_biotype label
out.bm.genes.region <- out.bm.genes.region %>% mutate(gene_biotype_fac = fct_relevel(as.factor(gene_biotype), 
      "protein_coding"), external_gene_name = fct_reorder2(external_gene_name, 
      start_position, gene_biotype_fac, .desc = TRUE))


## plot
p2 <- ggplot(data = out.bm.genes.region) + 
  geom_linerange(aes(x = external_gene_name, ymin = start_position, ymax = end_position, colour = gene_biotype_fac, group = gene_biotype_fac)) +
  coord_flip() + ylab("") +
  ylim(plot.range) + 
  geom_text(aes(x = external_gene_name, y = start_position, label = external_gene_name, colour = gene_biotype_fac), fontface = 2, alpha = I(0.7), hjust = "right", size= 2.5) + 
  labs(title = "", subtitle = paste0("Genes"), caption = paste0("Data source: ", gene.ensembl@host, " + Data set: ", gene.ensembl@dataset), color = "Gene Biotype") +
  theme(axis.title.y=element_blank(),
        axis.text.y=element_blank(),
        axis.ticks.y=element_blank(), 
        strip.text.y = element_text(angle = 0),
        legend.position="bottom", 
        panel.grid.major.y = element_blank()) + 
  expand_limits(y=c(-1, 1)) +
  scale_color_manual(values = c("black", metafolio::gg_color_hue(nlevels(out.bm.genes.region$gene_biotype_fac)-1)))
  ## hack to have 11 colors, but probably merging some gene biotype groups could make sense too. 
  ## consider colorblindr::palette_OkabeIto_black
print(p2)



## ---- summarystats-genes, include = TRUE, fig.height = 9-----------------

library(patchwork)

p1b <- p1 + xlab("") + theme(axis.title.x=element_blank(), axis.text.x=element_blank(), axis.ticks.x=element_blank()) + xlim(plot.range)

p1b + p2 + plot_layout(ncol = 1, heights = c(6, 6))


