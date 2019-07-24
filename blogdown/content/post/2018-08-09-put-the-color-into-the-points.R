## ---- setup, include = FALSE, warning=FALSE, message=FALSE---------------
# library(showtext)
suppressPackageStartupMessages(library(tidyverse))


## ---- setup2, include = TRUE, warning=FALSE, message=FALSE---------------
library(httr)
library(jsonlite)
library(xml2)
library(ggplot2)
theme_set(theme_bw())
library(tibble)
library(tidyr)
library(magrittr)
library(glue)
library(purrr)
library(rsnps)
library(data.table)
library(janitor)
library(stringr)
library(rsnps)


## ---- load-data, echo=TRUE, results="hide", cache=TRUE, message = FALSE, warning = FALSE----

## Data Source URL
url <- "https://portals.broadinstitute.org/collaboration/giant/images/2/21/BMI_All_ancestry.fmt.gzip"

## Import BMI summary statistics dat.bmi <- read_tsv(file = url) ##
## taking too long, let's use fread instead.

dat.bmi <- data.table::fread(url, verbose = FALSE)

## Rename some columns
dat.bmi <- dat.bmi %>% rename(SNP = SNPNAME, P = Pvalue)

## Extract region
dat.bmi.sel <- dat.bmi %>% slice(which.min(P))
dat.bmi.sel

## range region
range <- 5e+05
sel.chr <- dat.bmi.sel$CHR
sel.pos <- dat.bmi.sel$POS

data <- dat.bmi %>%
  filter(CHR == sel.chr, between(POS, sel.pos -
    range, sel.pos + range))

head(data)

(snp <- dat.bmi.sel$SNP)


## ---- look-up-position---------------------------------------------------
sm <- rsnps::ncbi_snp_summary(snp) %>% separate(chrpos, c("chr", "pos"))
sel.pos == as.numeric(sm$pos)


## ------------------------------------------------------------------------
MYTOKEN <- "a_mix_of_numbers_and_characters"


## ---- echo = FALSE-------------------------------------------------------
MYTOKEN <- "975d104d9f13"


## ----ldproxy, eval = TRUE, cache = TRUE----------------------------------

LDproxy_raw <- system(
  glue::glue("curl -k -X GET 'https://ldlink.nci.nih.gov/LDlinkRest/ldproxy?var={snp}&pop=EUR&r2_d=r2&token={MYTOKEN}'"),
  intern = TRUE
)


## ----ldproxy-tidying, cache = TRUE---------------------------------------

LDproxy <- LDproxy_raw %>%
  purrr::map(., function(x) stringr::str_split(x, "\t") %>%
      unlist()) %>% ## remove all the tabs
  do.call(rbind, .) %>% ## turn into a matrix
  data.frame() %>% ## turn into a data frame
  janitor::row_to_names(1) %>% ## make the first row the column names
  rename(SNP = RS_Number) %>% ## rename RS_Number as SNP
  mutate_at(vars(MAF:R2), function(x) as.numeric(as.character(x))) %>% ## turn MAF:R2 columns numeric
  mutate(SNP = as.character(SNP)) ## turn SNP from a factor into a character
head(LDproxy)


## ----join-ldlink---------------------------------------------------------
data_ldproxy <- data %>%
  right_join(LDproxy, by = c("SNP" = "SNP"))


## ---- plot-summarystats-ldlink, fig.height = 5, eval=TRUE, cache=TRUE, warning = FALSE----

ggplot(data = data_ldproxy) +
  geom_point(aes(POS, -log10(P), color = R2), shape = 16) +
  labs(
    title = "Locuszoom plot for BMI GWAS",
    subtitle = paste(
      "Summary statistics for chromosome", sel.chr, "from",
      format((sel.pos - range), big.mark = "'"), "to",
      format((sel.pos + range), big.mark = "'"), "bp"
    ),
    caption = paste("Data source:", url)
  ) +
  geom_point(
    data = data_ldproxy %>% filter(SNP == snp),
    aes(POS, -log10(P)), color = "black", shape = 16
  ) +
  scale_color_distiller("R2 (LDproxy)",
    type = "div", palette = "Spectral",
    limits = c(0, 1)
  )


## ----ldmatrix, cache=TRUE, eval = TRUE-----------------------------------
snplist <- data %>%
  filter(str_detect(SNP, "rs")) %>%
  pull(SNP) %>%
  paste(collapse = "%0A")

LDmatrix_raw <- system(
  glue::glue("curl -k -X GET 'https://ldlink.nci.nih.gov/LDlinkRest/ldmatrix?snps={snplist}&pop=CEU%2BTSI%2BFIN%2BGBR%2BIBS&r2_d=r2&token={MYTOKEN}'"),
  intern = TRUE
)


## ----tidying, cache=TRUE-------------------------------------------------

LDmatrix <- LDmatrix_raw %>%
  purrr::map(., function(x) stringr::str_split(x, "\t") %>%
      unlist()) %>%
  do.call(rbind, .) %>% ## turn into a matrix
  data.frame() %>% ## turn into a data.frame
  janitor::row_to_names(1) ## make the first line the column names

LDmatrix_long <- LDmatrix %>%
  gather("SNP2", "R2", -RS_number) %>% ## from wide to long
  rename(SNP = RS_number) %>% ## rename RS_number
  mutate(R2 = as.numeric(R2)) %>% ## make R2 numeric
  mutate_if(is.factor, as.character) ## make all factor columns characters

head(LDmatrix_long)


## ----join-ldlink-matrix--------------------------------------------------
data_ldmatrix <- data %>%
  right_join(LDmatrix_long, by = c("SNP" = "SNP"))


## ---- plot-summarystats-ldlink-matrix, fig.height = 5, eval=TRUE, cache=TRUE, warning = FALSE----

ggplot(data = data_ldmatrix %>% filter(SNP2 == snp)) +
  geom_point(aes(POS, -log10(P), color = R2)) +
  labs(
    title = "Locuszoom plot for BMI GWAS",
    subtitle = paste(
      "Summary statistics for chromosome", sel.chr, "from",
      format((sel.pos - range), big.mark = "'"), "to",
      format((sel.pos + range), big.mark = "'"), "bp"
    ),
    caption = paste("Data source:", url)
  ) +
  geom_point(
    data = data_ldmatrix %>% filter(SNP == snp & SNP2 == snp),
    aes(POS, -log10(P)), color = "black", shape = 16
  ) +
  scale_color_distiller("R2 (LDmatrix)",
    type = "div", palette = "Spectral",
    limits = c(0, 1)
  )


## ---- prep-packages-ensembl----------------------------------------------
library(httr)
library(jsonlite)
library(xml2)


## ---- populations--------------------------------------------------------


server <- "https://rest.ensembl.org"
ext <- "/info/variation/populations/homo_sapiens?filter=LD"

r <- GET(paste(server, ext, sep = ""), content_type("application/json"))

stop_for_status(r)

head(fromJSON(toJSON(content(r))))


## ----echo=TRUE-----------------------------------------------------------
snp
server <- "https://rest.ensembl.org"
ext <- glue::glue("/ld/human/{snp}/1000GENOMES:phase_3:EUR?")
## Window size in kb. The maximum allowed value for the window size is 500 kb. LD is computed for the given variant and all variants that are located within the specified window.

r <- GET(paste(server, ext, sep = ""), content_type("application/json"))
stop_for_status(r)
LD.SNP.region <- as_tibble(fromJSON(toJSON(content(r)))) %>%
  unnest() %>%
  mutate(r2 = as.numeric(r2))
head(LD.SNP.region)


## ---- calc-ld-matrix, eval=TRUE, cache=TRUE, include=TRUE----------------
## Query region. A maximum of 1Mb is allowed.

ext <- glue::glue("/ld/human/region/{sel.chr}:{sel.pos - range/20}..{sel.pos + range/20}/1000GENOMES:phase_3:EUR?")

r <- GET(paste(server, ext, sep = ""), content_type("application/json"))
stop_for_status(r)
LD.matrix.region <- as_tibble(fromJSON(toJSON(content(r)))) %>%
  unnest() %>%
  mutate(r2 = as.numeric(r2))

head(LD.matrix.region)


## ---- plot-ld-matrix, eval=FALSE, cache=TRUE, include=FALSE, fig.height = 4, fig.width = 4----
## 
## ggplot(data = LD.matrix.region) +
##   geom_tile(aes(x = variation1, y = variation2, fill = r2)) +
##   scale_fill_gradient(low = "white", high = "red")


## ----calc-ld-SNP-SNPS, eval=TRUE, cache=TRUE, include=TRUE---------------

extract_ld <- function(SNP.id2 = NULL, SNP.id1 = NULL, POP = NULL) {
  ext <- glue::glue("/ld/human/pairwise/{SNP.id1}/{SNP.id2}/") ## filter POP further down

  server <- "https://rest.ensembl.org"

  r <- GET(paste(server, ext, sep = ""), content_type("application/json"))
  stop_for_status(r)

  out <- as_tibble(fromJSON(toJSON(content(r)))) %>%
    unnest() %>%
    filter(stringr::str_detect(population_name, POP))

  return(out)
}


## see futher down why intersect here
other.snps <- intersect(LD.SNP.region$variation2, data$SNP)

## cacluate LD for all other.snps SNPs
LD.matrix.snps <- purrr::map_df(other.snps, extract_ld, snp, "EUR") %>%
  mutate(r2 = as.numeric(r2)) %>%
  bind_rows() %>%
  unnest()
LD.matrix.snps


## ---- join-ld------------------------------------------------------------
data_ensembl <- data %>%
  full_join(LD.SNP.region, by = c("SNP" = "variation2"))


## ---- plot-summarystats-ld, fig.height = 5, eval=TRUE, cache=TRUE, include=TRUE----

ggplot(data = data_ensembl) +
  geom_point(aes(POS, -log10(P), color = r2), shape = 16) +
  labs(
    title = "Locuszoom plot for BMI GWAS",
    subtitle = paste("Summary statistics for chromosome", sel.chr, "from", format((sel.pos - range), big.mark = "'"), "to", format((sel.pos + range), big.mark = "'"), "bp"),
    caption = paste("Data source:", url)
  ) +
  geom_point(
    data = data_ensembl %>% filter(SNP == "rs1421085"),
    aes(POS, -log10(P)), color = "black", shape = 16
  ) +
  scale_color_distiller("R2 (ensembl)", type = "div", palette = "Spectral", limits = c(0, 1))


## ---- sessioninfo, include = TRUE----------------------------------------
sessionInfo()

