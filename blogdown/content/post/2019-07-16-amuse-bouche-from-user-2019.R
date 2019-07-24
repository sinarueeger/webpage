## ----2019-07-16-amuse-bouche-from-user-2019-0, eval=FALSE, message=FALSE, warning=FALSE, include=FALSE----
## knitr::purl(input = "content/post/2019-07-16-amuse-bouche-from-user-2019.Rmd",
##             output = "content/post/2019-07-16-amuse-bouche-from-user-2019.R")
## 


## ----2019-07-16-amuse-bouche-from-user-2019-1, message=FALSE, warning=FALSE, include=FALSE----
# library(showtext)
#suppressPackageStartupMessages(library(tidyverse))
knitr::opts_chunk$set(cache = TRUE)


## ----2019-07-16-amuse-bouche-from-user-2019-2----------------------------
library(dplyr)
iris %>% 
  group_by(Species) %>%
  summarise(avg = mean(Petal.Length, na.rm = TRUE))


## ----2019-07-16-amuse-bouche-from-user-2019-3----------------------------
group_mean <- function(data, by, var) {
  
  data %>%
    group_by({{ by }}) %>%
    summarise(avg = mean({{ var }}, na.rm = TRUE))
}


## ----2019-07-16-amuse-bouche-from-user-2019-4, echo=TRUE, results='hide'----
library(ggplot2)
group_mean(data = msleep, by = vore, var = sleep_total)



## ----2019-07-16-amuse-bouche-from-user-2019-5, message=FALSE, warning=FALSE----
library(ggplot2)
theme_set(theme_bw())
ggplot(data = iris, 
       aes(x = Sepal.Length, y = Petal.Length, group = Species, color = Species)
       ) +
  geom_point() +
  geom_smooth(method = "lm") + 
  ggtitle("Pack this plot into a function.")


## ----2019-07-16-amuse-bouche-from-user-2019-6, message=FALSE, warning=FALSE, echo=TRUE, results='hide'----
plot_point_smooth <- function(data, x, y, gr = NULL, method = "lm") {
  
  ggplot(data = data, 
         aes({{ x }}, {{ y }}, group = {{ gr }}, color = {{ gr }})
         ) +
    geom_point() +
    geom_smooth(method = method)
  
}


## ----2019-07-16-amuse-bouche-from-user-2019-6b, message=FALSE, warning=FALSE, echo=TRUE,fig.show = 'hide', results='hide'----
plot_point_smooth(msleep, x = sleep_total, y = sleep_rem, gr = NULL) + 
  ggtitle("Tidy eval with the msleep dataset")


## ----2019-07-16-amuse-bouche-from-user-2019-7, message=FALSE, warning=FALSE----
# install.packages("usethis")
library(usethis)


## ----2019-07-16-amuse-bouche-from-user-2019-8, eval=FALSE, include=TRUE, echo=TRUE, results='hide'----
## ## 1. create the package skeleton
## create_package("~/tmp/mypackage")
## 
## ## 2. use git
## use_git()
## 
## ## 3. add a license
## use_mit_license()
## 
## ## 4. run check
## # install.packages("devtools")
## devtools::check()
## 
## ## 5. commit all files with git
## 
## ## 6. set up git + github
## use_github()
## ## will update the DESCRIPTION file
## 
## ## 7. install the package
## devtools::install()
## 
## ## 8. add a rmarkdown readme file
## use_readme_rmd()
## ## knit + commit + push
## 
## ## 9. clean up if this was only a demo
## ## install.packages("fs")
## ## fs::dir_delete("~/tmp/mypackage")


## ----2019-07-16-amuse-bouche-from-user-2019-9----------------------------
# install.packages("pak") ## or
# devtools::install_github("r-lib/pak")


## ----2019-07-16-amuse-bouche-from-user-2019-10, eval = FALSE, echo=TRUE, results='hide'----
## pak::pkg_install("usethis")
## pak::pkg_remove("usethis")
## pak::pkg_install("r-lib/usethis")
## pak::pkg_status("usethis")


## ----2019-07-16-amuse-bouche-from-user-2019-11, eval=FALSE, include=TRUE, echo=TRUE, results='hide'----
## usethis::create_project("~/tmp/test")
## 
## ## check the directory
## dir()
## 
## ## initialise a dedicated R packages folder
## pak:::proj_create()
## 
## ## check the directory again
## dir()
## 
## ## check the DESCRIPTION file
## readLines("DESCRIPTION")
## 
## ## install usethis
## pak:::proj_install("usethis")
## 
## ## this installs dependencies into a private project library
## readLines("DESCRIPTION")
## 
## ## remove the project folder again
## fs::dir_delete("~/tmp/test")


## ----2019-07-16-amuse-bouche-from-user-2019-12b , echo=TRUE, results='hide'----
# install.packages("tidyverse/tidyr")
library(tidyr)


## ----2019-07-16-amuse-bouche-from-user-2019-12---------------------------
# devtools::install_github("chrk623/dataAnim")
# Master's Thesis project by Charco Hui
library(dataAnim)

## Our two toy datasets
datoy_wide
datoy_long


## ----2019-07-16-amuse-bouche-from-user-2019-12c, echo=TRUE, results='hide'----

## lets make it longer
datoy_wide %>%
  pivot_longer(-Name, names_to = "Subject", values_to = "Score")

## lets make it wider
datoy_long %>%
  dplyr::mutate(Time = 1:nrow(datoy_long)) %>%
  pivot_wider(names_from = "Subject", values_from = c("Score", "Time"))



## ----2019-07-16-amuse-bouche-from-user-2019-13, echo=TRUE, results='hide', message=FALSE, warning=FALSE----
## install.packages("vroom")
library(vroom)


## ----2019-07-16-amuse-bouche-from-user-2019-14---------------------------

## Source: https://portals.broadinstitute.org/collaboration/giant/index.php/GIANT_consortium_data_files

path_to_file_1 <- "Height_AA_add_SV.txt.gz"
path_to_file_2 <- "BMI_African_American.fmt.gzip" 


## Height
download.file(
  "https://portals.broadinstitute.org/collaboration/giant/images/8/80/Height_AA_add_SV.txt.gz",
  path_to_file_1)

## BMI
download.file(
  "https://portals.broadinstitute.org/collaboration/giant/images/3/33/BMI_African_American.fmt.gzip",
  path_to_file_2)


## File size
## install.packages("fs")
fs::file_size(path_to_file_1)
fs::file_size(path_to_file_2)


## ----2019-07-16-amuse-bouche-from-user-2019-15, message=FALSE, warning=FALSE, echo=TRUE, results='hide'----
library(dplyr)

## With vroom
giant_vroom <- vroom::vroom(path_to_file_1)
giant_vroom_subset <- giant_vroom %>% select(CHR, POS) %>% filter(CHR == 1)

## The equivalent with data.table
giant_DT <- data.table::fread(path_to_file_1)
giant_DT_subset <- giant_DT %>% select(CHR, POS) %>% filter(CHR == 1)



## ----2019-07-16-amuse-bouche-from-user-2019-16, message=FALSE, warning=FALSE, echo=TRUE, results='hide'----
## Selecting columns
giant_vroom_select <- vroom::vroom(path_to_file_1, 
                                   col_select = list(SNPNAME, ends_with("_MAF")))
head(giant_vroom_select)

## Preventing columns from being imported
giant_vroom_remove <- vroom::vroom(path_to_file_1, 
                                   col_select = -ExAC_AFR_MAF)
head(giant_vroom_remove)

## Renaming on the fly
giant_vroom_rename <- vroom::vroom(path_to_file_1, 
                                   col_select = list(p = Pvalue, everything()))
head(giant_vroom_rename)


## ----2019-07-16-amuse-bouche-from-user-2019-17, echo=TRUE, results='hide', message=FALSE, warning=FALSE----
data_combined <- vroom::vroom( 
                    c(path_to_file_1, path_to_file_2), 
                    id = "path")
table(data_combined$path)


## ----2019-07-16-amuse-bouche-from-user-2019-18 , echo=TRUE, results='hide'----
# install.packages("data.table")
library(data.table)

## Create a giant data.table
p <- 2e6
dat <- data.table(x = sample(1e5, p, TRUE), y = runif(p))

## Let's select a few rows
system.time(
  tmp <- dat[x %in% 2000:3000 ]
)

## do the same operation again
system.time(
  tmp <- dat[x %in% 2000:3000 ]
)



## ----2019-07-16-amuse-bouche-from-user-2019-19a, error=TRUE--------------

mat_1 <- matrix(c(15, 10, 8, 6, 12, 9), byrow = FALSE, nrow = 2) 
mat_2 <- matrix(c(5, 2, 3), nrow = 1)

## broadcasting won't work ❌
mat_1 + mat_2



## ----2019-07-16-amuse-bouche-from-user-2019-19b, error=TRUE--------------
dim(mat_1[,2:3]) ## selecting two columns is fine

## subsetting won't preserve the matrix class ❌
dim(mat_1[,1]) ## why not 2x1?

length(mat_1[,1]) ## ah, it turned into a vector!

dim(mat_1[,1, drop = FALSE]) ## but with drop = FALSE we can keep it a matrix


## ----2019-07-16-amuse-bouche-from-user-2019-20 , echo=TRUE, results='hide'----
library(rray)

(mat_1_rray <- rray(c(15, 10, 8, 6, 12, 9), dim = c(2, 3)))
(mat_2_rray <- rray(c(5, 2, 3), dim = c(1, 3)))

## Broadcasting works ✓
mat_1_rray + mat_2_rray

## Subsetting works ✓
dim(mat_1_rray[,2:3])
dim(mat_1_rray[,1])

## smart functions
mat_1_rray / rray_sum(mat_1_rray, axes = 1)
rray_bind(mat_1_rray, mat_2_rray, .axis = 1)
rray_bind(mat_1_rray, mat_2_rray, .axis = 2)



## ----2019-07-16-amuse-bouche-from-user-2019-21, message=FALSE, warning=FALSE, echo=TRUE, results='hide'----
# devtools::install_github("favstats/rstatsmemes")
library(rstatsmemes)
show_me_an_R_meme()

