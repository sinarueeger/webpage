
## installation
## https://bookdown.org/yihui/blogdown/installation.html
## library(blogdown)

## https://bookdown.org/yihui/blogdown/a-quick-example.html
## blogdown::new_site(theme = "gcushen/hugo-academic")


## 1) update content, whatever, create new post

## 2) update website
blogdown::hugo_build()

## 3) commit changes to github, 
system("cd /Users/admin/Documents/Privat/webpage/blogdown/public")
system("git commit -a -m 'update'")
system("git push")
