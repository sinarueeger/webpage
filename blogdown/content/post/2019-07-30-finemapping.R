## ----eval=FALSE, message=FALSE, warning=FALSE, include=FALSE-------------
## knitr::purl(input = "content/post/2019-07-30-finemapping.Rmd",
##             output = "content/post/2019-07-30-finemapping.R")
## 


## ----2019-07-16-amuse-bouche-from-user-2019-1, message=FALSE, warning=FALSE, include=FALSE----
# library(showtext)
#suppressPackageStartupMessages(library(tidyverse))
knitr::opts_chunk$set(cache = FALSE)


## ------------------------------------------------------------------------

## path to tools
## download from here:
## www.christianbenner.com
LDSTORE <- "~/tmp/finemap-example/bin/ldstore"
FINEMAP <- "~/tmp/finemap-example/bin/finemap"
PLINK2 <- "~/tmp/finemap-example/bin/plink2"

system_glued <- function(x)
{
  system(glue::glue(x))
}

## checks
if (!fs::file_exists(PLINK2)) 
  message("Download PLINK2 from here: http://www.cog-genomics.org/plink/2.0/ 
          and store the binary as bin/plink2 (v2.00 used).")

if (!fs::file_exists(FINEMAP)) 
  message("Download FINEMAP from here: http://www.christianbenner.com/ 
          and store the binary as bin/finemap (v1.3.1 used).")

if (!fs::file_exists(LDSTORE)) 
  message("Download LDSTORE from here: http://www.christianbenner.com/ 
          and store the binary as bin/ldstore (v1.1 used).")




## ----message=FALSE, warning=FALSE----------------------------------------
## accessed through ::
## fs          
## vroom    
## readr      
## data.table 
## GWAS.utils     
## install via devtools::install_github("sinarueeger/GWAS.utils")
## here
## glue
## ggrepel
## stringr
## requirements::req_file("R/howto_finemap.R") ## devtools::install_github("hadley/requirements")

library(ggplot2)
library(dplyr)
theme_set(theme_bw())
library(ggGWAS)        # for quick plotting
library(cowplot)
library(magrittr)


## ------------------------------------------------------------------------
## create a data folder
fs::dir_create("~/tmp/finemap-example/data/")
DIR_DATA <- "/Users/admin/tmp/finemap-example/data"

## create a bin folder
fs::dir_create("~/tmp/finemap-example/bin/")



## ----message=FALSE-------------------------------------------------------
## Chromosome and position (build 37, base-pairs)
url_summary_stats <- "mccarthy.well.ox.ac.uk/publications/2015/ENGAGE_1KG/HDL_Meta_ENGAGE_1000G.txt.gz"
path_summary_stats <- glue::glue("{DIR_DATA}/hdl_summarystats.txt.gz")

if (!fs::file_exists(path_summary_stats)) download.file(url_summary_stats, path_summary_stats)

dat_raw <- vroom::vroom(path_summary_stats,
                        col_select = list(p = `p-value`, n = n_samples, everything()))

## sanitychecks (some p values are 0, the ones with a high abs Z stats)

## calc p value again
dat_raw$p_sina <- GWAS.utils::z2p(abs(dat_raw$beta/dat_raw$se))
qplot(-log10(p), -log10(p_sina), data = dat_raw %>% sample_n(1000)) +
  geom_abline(intercept = 0, slope = 1)

## check how many p values are 0
dat_raw %>% filter(p_sina == 0)
dat_raw %>% filter(p == 0)

## lets display this with a qqplot, just a check
ggplot(data = dat_raw) +
  stat_gwas_qq_hex(aes(y = p_sina)) +
  geom_abline(intercept = 0, slope = 1)


## define a region 

## we are only interested in the region around
CHR <- 15
BP_SNP <- 58680954 ## centered around https://www.ncbi.nlm.nih.gov/snp/rs2043085
WINDOW <- 1e6
BP_FROM <- BP_SNP - WINDOW/2
BP_TO <- BP_SNP + WINDOW/2

dat <- dat_raw %>%
  filter(between(pos, BP_FROM, BP_TO) & chr == glue::glue("chr{CHR}"))

## lets make a locus plot
ggplot(data = dat) +
  geom_point(aes(pos, -log10(p_sina)))



## ------------------------------------------------------------------------

## sample info
## get chr 15
## on GRCh37
# samples
# ftp://ftp.1000genomes.ebi.ac.uk/vol1/ftp/release/20130502/integrated_call_samples_v2.20130502.ALL.ped
# ftp.1000genomes.ebi.ac.uk/vol1/ftp/technical/working/20130606_sample_info/20130606_sample_info.xlsx
url_reference_panel <- "ftp://ftp.1000genomes.ebi.ac.uk/vol1/ftp/release/20130502/ALL.chr15.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz"
path_reference_panel <- glue::glue("{DIR_DATA}/1000genomes_chr15.vcf.gz")

if (!fs::file_exists(path_reference_panel)) {
  download.file(url_reference_panel, path_reference_panel)
  download.file("ftp://ftp.1000genomes.ebi.ac.uk/vol1/ftp/release/20130502/ALL.chr15.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz.tbi",
                glue::glue("{DIR_DATA}/1000genomes_chr15.vcf.gz.tbi"))
  download.file("ftp://ftp.1000genomes.ebi.ac.uk/vol1/ftp/release/20130502/integrated_call_samples_v2.20130502.ALL.ped",
                glue::glue("{DIR_DATA}/samples_info.ped"))
  
}


## select individuals
## surakka et al mentions that the study was European
## --keep accepts a space/tab-delimited text file with family IDs in the first column and within-family IDs in the second column, and removes all unlisted samples from the current analysis. --remove does the same for all listed samples.
keep <- data.table::fread( glue::glue("{DIR_DATA}/samples_info.ped")) %>%
  filter(Population %in% c("GBR", "FIN", "TSI", "CEU", "IBS")) %>%
  select(`Family ID`, `Individual ID`) %>%
  mutate(`Family ID` = 0)

readr::write_delim(keep, path = glue::glue("{DIR_DATA}/keep.txt"), delim = " ", col_names = FALSE)

## vcf to plink
FILE_1KG <- glue::glue("{DIR_DATA}/1000genomes_chr15")
system_glued("{PLINK2} --vcf {FILE_1KG}.vcf.gz  --make-bed --out {FILE_1KG} --keep {DIR_DATA}/keep.txt --maf 0.001 --max-alleles 2 --mind 0.01 --geno 0.01 --hwe 1e-6 --from-bp {BP_FROM} --to-bp {BP_TO} --chr {CHR}")
## using a min maf because with maf = 0 FINEMAP won't work

## maf
system_glued("{PLINK2} --bfile {FILE_1KG} --freq --out {FILE_1KG}")



## ------------------------------------------------------------------------
FILE <- glue::glue("{DIR_DATA}/data-hdl")
sample_size <- median(dat_raw$n) ## look that up in the paper
master <- data.frame(z = glue::glue("{FILE}.z"),
                     ld = glue::glue("{FILE}.ld"),
                     snp = glue::glue("{FILE}.snp"),
                     config = glue::glue("{FILE}.config"),
                     cred = glue::glue("{FILE}.cred"),
                     log = glue::glue("{FILE}.log"),
                     n_samples = sample_size
)

readr::write_delim(master, path = glue::glue("{DIR_DATA}/master"), delim = ";")



## ------------------------------------------------------------------------
## check if they are in the bim file
snps_1kg <- data.table::fread(glue::glue("{FILE_1KG}.bim"), header = FALSE) %>%
  rename(chr = V1, rsid = V2, pos = V4, allele2 = V5, allele1 = V6)
# V5 (corresponding to clear bits in .bed; usually minor) > other allele
# V6 (corresponding to set bits in .bed; usually major) > reference allele

## maf from 1KG
maf_1kg <-  data.table::fread(glue::glue("{FILE_1KG}.afreq")) %>%
  rename(rsid = ID) %>%
  mutate(maf = GWAS.utils::eaf2maf(ALT_FREQS))

## then join + rearrange with 1KG data
data_z <- dat %>%
  rename(chromosome = chr, allele1 = reference_allele, allele2 = other_allele) %>%
  inner_join(snps_1kg %>% select(pos, rsid, allele1, allele2)) %>%
  rename(position = pos) %>%
  mutate(chromosome = CHR) %>% ## overwrite chromosome
  left_join(maf_1kg) %>%  ## join with MAF (cause there is no MAF in the summary stats file)
  select(rsid, chromosome, position, allele1, allele2, maf, beta, se)


## TODO: get proper MAF

readr::write_delim(
  data_z,
  path = glue::glue("{FILE}.z"),
  delim = " "
)

## --incl-variants 		Extract LD information for variants given in the specified text file.
## The specified file has 5 columns with a header: RSID, position, chromosome, A_allele and B_allele 		Requires --matrix or --table
incl_variants <- data_z %>%
  select(rsid, position, chromosome, allele1, allele2) %>%
  rename(RSID = rsid, A_allele = allele1, B_allele = allele2)

readr::write_delim(incl_variants,
                   path = glue::glue("{FILE}-incl-variants"),
                   delim = " ")



## ----cache = TRUE--------------------------------------------------------


if (!fs::file_exists(glue::glue("{FILE_1KG}.bcor_1"))) {
  ## sub bcor file
  system_glued(
    "{LDSTORE} --bplink {FILE_1KG} --bcor {FILE_1KG}.bcor --n-threads 1" 
  )
  
}



## ----cache = TRUE--------------------------------------------------------

## create LD matrix
system_glued(
  "{LDSTORE} --bcor {FILE_1KG}.bcor_1 --matrix {FILE}.ld --incl-variants {FILE}-incl-variants"
)


if (FALSE)
{
  ## create LD matrix
  system_glued(
    "{LDSTORE} --bcor {FILE_1KG}.bcor_1 --meta out --matrix {FILE}.ld --incl-variants {FILE}-incl-variants"
  )
  out <- readr::read_delim("out", " ")
  head(out %>% filter(RSID %in% data_z$rsid))
  data_z %>% anti_join(out, c("rsid" = "RSID"))
}



## ----cache = TRUE--------------------------------------------------------

system_glued(
  "{FINEMAP} --sss --in-files {DIR_DATA}/master --dataset 1"
)



## ------------------------------------------------------------------------

locuszoom_wrapper <- function(data, y, K = NA, horiz_line = NA, labs_bottom_logic = TRUE, labs_top_logic = TRUE) {
  
  
  
  ## sort out annotation
  if (labs_bottom_logic & labs_top_logic) {
    anno <- labs(
      title = glue::glue("Locuszoom plot for HDL GWAS"),
      subtitle = glue::glue("Summary statistics for chromosome {CHR}, {BP_FROM}-{BP_TO}"),
      caption = glue::glue(
        "Data source\nSummary statistics: Surakka et al. 2015: {url_summary_stats}\n1000 Genomes Reference Panel: {url_reference_panel}"
      )
    )
  }
  
  
  if (labs_bottom_logic & !labs_top_logic) {
    anno <- labs(
      caption = glue::glue(
        "Data source\nSummary statistics: Surakka et al. 2015: {url_summary_stats}\n1000 Genomes Reference Panel: {url_reference_panel}"
      )
    )
  }
  if (labs_top_logic & !labs_bottom_logic) {
    anno <- labs(
      title = glue::glue("Locuszoom plot for HDL GWAS"),
      subtitle = glue::glue("Summary statistics for chromosome {CHR}, {BP_FROM}-{BP_TO}"),
      caption = ""
    )
  }
  
  
  ## actual plotting
  
  ggplot(data = data) +
    ## add log10bf
    geom_point(aes(position, {{ y }}, color = abs(LD))) +
    scale_color_distiller("LD", type = "div", palette = "Spectral", limits = c(0, 1)) +
    
    ## mark the lead variants
    geom_point(aes(position, {{ y }}), shape = 3, size = 3, data = data %>% filter(lead_snp)) +
    
    ## mark the causal variants
    geom_point(aes(position, {{ y }}), shape = 1, size = 3, data = data %>% filter(causal_snps)) +
    
    ## color the causal variants
    ggrepel::geom_text_repel(aes(position, {{ y }}, label = rsid), data = data %>% filter(causal_snps)) +
    
    ## Dashed lines correspond respectively to a single-SNP Bayes factor of 100
    geom_hline(yintercept = horiz_line, linetype = 3) + 
    
    ## titles
    anno
  
  
}


## ----message=FALSE, warning=FALSE----------------------------------------

## results -------------------------------
snp <- data.table::fread(glue::glue("{FILE}.snp"))
config <- data.table::fread(glue::glue("{FILE}.config"))
ld_matrix <- data.table::fread(glue::glue("{FILE}.ld")) ## same order as data_z


## replicate Figure 7 ---------------------
top_hits_benner_finemap <- c("rs7350789", "rs1800588", "rs113298164")
top_hits_benner_cond <- c("rs7350789", "rs1800588", "rs2043085")

library(dplyr)
causal_snps <-
  config %>% slice(1) %>% pull(config) %>% stringr::str_split(",") %>% unlist()
lead_snp <- "rs2043085"
ld_top_snp <-
  data.frame(rsid = data_z$rsid, LD = as.data.frame(ld_matrix)[, which(data_z$rsid %in% lead_snp)])

## adding ld to snp
snp_plot <- snp %>%
  left_join(ld_top_snp) %>%
  mutate(causal_snps = case_when(rsid %in% causal_snps ~ TRUE,
                                 TRUE ~ FALSE),
         lead_snp = case_when(rsid %in% lead_snp ~ TRUE,
                              TRUE ~ FALSE)) %>%
  mutate(mlog10p = -log10(GWAS.utils::z2p(z)))

plot_finemap <- locuszoom_wrapper(data = snp_plot, y = log10bf, K = 1, horiz_line = log10(100), labs_bottom_logic = FALSE, labs_top_logic = TRUE)
plot_ss <- locuszoom_wrapper(data = snp_plot, y = mlog10p, K = 1, horiz_line = -log10(5*10^(-8) ), labs_bottom_logic = TRUE, labs_top_logic = FALSE)



## ----fig.height=10, fig.width=7------------------------------------------

library(cowplot)
plot_grid(plot_finemap, plot_ss, nrow = 2)


