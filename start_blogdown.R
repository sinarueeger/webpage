
## installation
## https://bookdown.org/yihui/blogdown/installation.html
## library(blogdown)

## https://bookdown.org/yihui/blogdown/a-quick-example.html
## blogdown::new_site(theme = "gcushen/hugo-academic")


library(blogdown)

## 1) update content, whatever, create new post
#new_post(title="A first post using blogdown", kind = ".Rmd")

## 2) update website
blogdown::hugo_build()

## 3) commit changes to github >> do in terminal
#system("cd /Users/admin/Documents/Projects/webpage/sinarueeger.github.io")
#system("git add *")
#system("git commit -a -m 'update'")
#system("git push")

