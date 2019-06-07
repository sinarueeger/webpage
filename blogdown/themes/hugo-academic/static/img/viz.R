library(ggplot2)
library(wesanderson)
pal <- wes_palette("Zissou1", 21, type = "continuous")
#https://github.com/karthik/wesanderson

n.sample <- 1e5
df <- data.frame(P = runif(n.sample), GWAS = sample(c("a","b"), n.sample, replace = TRUE))
N <- nrow(df)
expected <- sort(-log10((1:N) / N - 1 / (2 * N)))
observed <- sort(-log10(df$P))
df2 <- data.frame(expected = expected, observed = observed)

## black white
ggplot(df2, aes(expected, observed)) + stat_density_2d(geom = "point", aes(size = stat(density)), n = 100, contour = FALSE) + theme_void()+ guides(fill=FALSE)

## colors
set.seed(3)
N <- 1000
df <- data.frame(x = runif(N, 0, 3), y = runif(N), col = sample(colors(), N, replace= TRUE), size = runif(N, 1, 10))

## border
ggplot(df, aes(x, y)) + geom_point(aes(size = size, fill = I(alpha(col, 0.3)), color = I(alpha(col, 0.2))), shape = 21, stroke = 5) + theme_void() +
  theme(legend.position="none") +
  scale_size_continuous(range = c(1, 60))


## no border
ggplot(df, aes(x, y)) + geom_point(aes(size = size, fill = I(col), color = I(col)), alpha = 0.2, shape = 16) + theme_void() +
  theme(legend.position="none") +
  scale_size_continuous(range = c(1, 60))

## black
pal <- wes_palette("Zissou1", 100, type = "continuous")
ggplot(df, aes(x, y)) + geom_point(aes(size = size, fill = size), alpha = 0.2, shape = 16) + theme_void() +
  theme(legend.position="none") +
  scale_size_continuous(range = c(1, 60)) + 
  scale_fill_gradientn(colours = pal)

## wes anderson colors
df$col2 <- runif(nrow(df))
pal <- wes_palette("Zissou1", 100, type = "continuous")
qp <- ggplot(df, aes(x, y)) + geom_point(aes(size = size, color = col2, fill = col2), alpha = 0.4) + theme_void() +
  theme(legend.position="none") +
  scale_size_continuous(range = c(1, 60)) + 
  scale_color_gradientn(colours = pal) + xlim(-0.1, 3.1)+ ylim(-0.1, 1.1)

png("viz.png", width = 1800, height = 600)
print(qp)
dev.off() 