
## installation
## https://bookdown.org/yihui/blogdown/installation.html
## library(blogdown)

## https://bookdown.org/yihui/blogdown/a-quick-example.html
## blogdown::new_site(theme = "gcushen/hugo-academic")
##blogdown::new_site(theme = "jbub/ghostwriter")

library(blogdown)

## 1) update content, whatever, create new post
#new_post(title="A first post using blogdown", kind = ".Rmd")

## 2) update website
blogdown::hugo_build()

## add
# <script id="Cookiebot" src="https://consent.cookiebot.com/uc.js" data-cbid="119ec67e-e76e-474f-98e1-db5f9991a5e7" type="text/javascript" async></script>

#  to index.html file

  ## 3) commit changes to github >> do in terminal
#system("cd /Users/admin/Documents/Projects/webpage/sinarueeger.github.io")
#system("git add *")
#system("git commit -a -m 'update'")
#system("git push")

