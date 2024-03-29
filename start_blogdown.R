
## installation
## https://bookdown.org/yihui/blogdown/installation.html
## library(blogdown)

## https://bookdown.org/yihui/blogdown/a-quick-example.html
## blogdown::new_site(theme = "gcushen/hugo-academic")
##blogdown::new_site(theme = "jbub/ghostwriter")

library(blogdown)

## 1) update content, whatever, create new post
#new_post(title="Workflow mgmt in R", kind = ".Rmd")

## 2) update website
blogdown::hugo_build()


## 3) commit changes to github >> do in terminal
path <- getwd()
 
comment <- "'update cv and update phd thesis link'"

## b) commit changes of webpage folder
## add files system("git add ...")
system(paste0("git commit -a -m ", comment))
system("git push")


## a) commit changes to github 
setwd("/Users/sinarueeger/webpage-stuff/sinarueeger.github.io")
system("git add -f *")
system(paste0("git commit -a -m ", comment))
system("git push")
setwd(path)
