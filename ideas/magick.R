library(magick)
library(ggplot2)
fig <- image_graph(res = 96)
ggplot2::qplot(mpg, wt, data = mtcars, colour = cyl)
dev.off()

logo <- image_read("/Users/admin/Documents/Work/Projects/tagging/documentation/ssimp_documentation/application-paper/plosgen/figures/submission/Fig4.pdf", density = 100, depth = 16)
#612x504
(logo2 <- image_crop(logo, "900x700+0+0"))#: crop out width:100px and height:150px starting +50px from the left
(logo2 <- image_crop(logo, "100x100"))#: crop out width:100px and height:150px starting +50px from the left
(logo2 <- image_crop(logo, "200x700+650+0"))#: crop out width:100px and height:150px starting +50px from the left

out <- image_composite(fig, image_scale(logo, "x150"), offset = "+80+380")

# Show preview
image_browse(out)

# Write to file
image_write(out, "myplot.png")

## (1) make boxplot with legend
## -----------------------------


## (2) make graph without legend
## ------------------------------
pdf.without <- image_read("/Users/admin/Documents/Work/Projects/tagging/documentation/ssimp_documentation/application-paper/plosgen/figures/submission/Fig3.tiff", density = 100, depth = 16)
#612x504


## crop from (1) and add legend to graph (2)
## ------------------------------------------


## draw legend to graph (2)
## -------------------------
drawing <- image_draw(pdf.without)
legend("topright",c("SSimp","GTimp"), col = c("green","blue"), pch = c(1,16), bty = "n")


image_browse(drawing)

dev.off()
image_write(drawing, 'Fig3_manual.pdf')

## move parts of a pdf
## --------------------
