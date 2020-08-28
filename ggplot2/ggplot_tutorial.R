##############################
## ggplot tutorial
## Tom Smith 2020
## Fancy version here:
## http://htmlpreview.github.io/?https://github.com/smithtp/TeachingResources/blob/master/ggplot2/ggplot_tutorial.html
##############################

library("ggplot2")

# start with Iris dataset
data(iris)
head(iris)

# setting up a basic plot
ggplot(iris) # empty plot - we haven't told it what we want to plot

# basic scatterplot coloured by species
p <- ggplot(iris, aes(x = Sepal.Length, y = Sepal.Width, col = Species)) +
  geom_point()
p

# make it pretty
# concatenate additional layers onto existing plot
p <- p + theme_bw() # inverted white background, grey lines scheme
p

# remove the grid lines
p <- p + theme(panel.grid.major = element_blank(), 
               panel.grid.minor = element_blank())
p

# change axis labels
p <- p + labs(x = "Sepal Length (cm)", y = "Sepal Width (cm)")
p

# make it more colourblind friendly
p <- p + scale_colour_manual(values = c("red", "blue", "orange"))
p

# stick it all together into 1 line
# and also mess around with point size and axis text
ggplot(iris, aes(x = Sepal.Length, y = Sepal.Width, col = Species)) +
  geom_point(size = 3, alpha = 0.5) +
  scale_colour_manual(values = c("red", "blue", "orange")) +
  labs(x = "Sepal Length (cm)", y = "Sepal Width (cm)") +
  theme_bw() +
  theme(panel.grid.major = element_blank(), 
        panel.grid.minor = element_blank(),
        axis.title.x = element_text(size = 18))


# handy tip - consistent theme throughout
my_theme <- theme_bw() +
  theme(panel.grid.major = element_blank(), 
        panel.grid.minor = element_blank(),
        axis.title = element_text(size = 16),
        axis.text = element_text(size = 12))

ggplot(iris, aes(x = Sepal.Length, fill = Species)) +
  geom_histogram(position = "identity", alpha = 0.6, bins = 20) +
  my_theme

########################
# multiple geom layers
########################

# boxplot with overlaid points
ggplot(iris, aes(x = Species, y = Sepal.Length, fill = Species)) +
  geom_boxplot(alpha = 0.5) +
  geom_point(alpha = 0.5) +
  scale_fill_manual(values = c("red", "blue", "orange")) +
  labs(y = "Sepal Length (cm)") +
  my_theme  +
  theme(legend.position = "none")

# we can make it much prettier...
ggplot(iris, aes(x = Species, y = Sepal.Length, fill = Species)) +
  geom_boxplot(alpha = 0.5, outlier.shape = NA) +
  geom_point(alpha = 0.5, shape = 21, size = 3, position = position_jitterdodge()) +
  scale_fill_manual(values = c("red", "blue", "orange")) +
  labs(y = "Sepal Length (cm)") +
  my_theme  +
  theme(legend.position = "none")

#################################
# layers from multiple datasets 
#################################

data_1 <- data.frame(seq(1, 20, 1), rnorm(20, mean = 10, sd = 2))
data_2 <- data.frame(seq(1, 20, 1), seq(1, 20, 1) + runif(20, -1, 1))

names(data_1) <- c("Var1", "Var2")
names(data_2) <- c("newVar1", "newVar2")

ggplot() +
  geom_point(data = data_1, aes(x = Var1, y = Var2)) +
  geom_line(data = data_2, aes(x = newVar1, y = newVar2))


####################
## saving plots
####################

# Instead of this
# svg("my_boxplot.svg")
# ggplot(iris, aes(x = Species, y = Sepal.Length)) +
#   geom_boxplot(alpha = 0.5, aes(fill = Species), outlier.shape = NA) +
#   geom_point(aes(fill = Species), alpha = 0.5, shape = 21, size = 3, position = position_jitterdodge()) +
#   scale_fill_manual(values = c("red", "blue", "orange")) +
#   labs(y = "Sepal Length (cm)") +
#   theme_bw()  +
#   theme(legend.position = "none")
# dev.off()
#
# You can do this:

p <- ggplot(iris, aes(x = Species, y = Sepal.Length)) +
  geom_boxplot(alpha = 0.5, aes(fill = Species), outlier.shape = NA) +
  geom_point(aes(fill = Species), alpha = 0.5, shape = 21, size = 3, position = position_jitterdodge()) +
  scale_fill_manual(values = c("red", "blue", "orange")) +
  labs(y = "Sepal Length (cm)") +
  theme_bw()  +
  theme(legend.position = "none")

ggsave("my_boxplot.svg", p)

###################################
# More complex things (for fun?)
###################################

# Facets
ggplot(iris, aes(x = Sepal.Length, y = Sepal.Width)) +
  geom_point(size = 3, alpha = 0.5) +
  geom_smooth(method = lm, se = FALSE) +
  labs(x = "Sepal Length (cm)", y = "Sepal Width (cm)") +
  my_theme +
  facet_wrap(~Species)


# annotations
data(faithful)

ggplot(faithful, aes(x=eruptions, y=waiting)) +
  geom_point() + 
  geom_density_2d() +
  labs(x = expression(paste("This axis label has fancy characters ", alpha, degree, Beta^2, Sigma[E]))) +
  theme_bw() +
  annotate("text", x = 2, y = 90, label = "some words are here") +
  annotate("text", x = 4, y = 50, label = "some more words are here and they're red", col = "red")


# removing all of the plotting axes, grid, etc within the theme
library("reshape2")
GenerateMatrix <- function(N){
  M <- matrix(runif(N * N), N, N)
  return(M)
}

M <- GenerateMatrix(10)
Melt <- melt(M)
head(Melt)

p <- ggplot(Melt, aes(Var1, Var2, fill = value)) + 
  geom_tile(colour = "black") + 
  scale_fill_gradientn(colours = rainbow(10)) +
  theme(aspect.ratio = 1,
        legend.position = "none", 
        panel.background = element_blank(),
        axis.ticks = element_blank(), 
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        axis.text.x = element_blank(),
        axis.title.x = element_blank(),
        axis.text.y = element_blank(),
        axis.title.y = element_blank())
p

# fun with fractals
iter <- 10000
p <- runif(iter)
coord <- matrix(c(0, 0), ncol = 1)
df <- rbind(data.frame(), t(coord))
for (i in 1:iter) {
  if (p[i] <= 0.05) {
    m <- matrix(c(0, 0, 0, 0.16), nrow = 2, ncol = 2)
    const <- matrix(c(0, 0), ncol = 1)
  } else if (p[i] > 0.05 && p[i] <= 0.86) {
    m <- matrix(c(0.85, -0.04, 0.04, 0.85), nrow = 2, ncol = 2)
    const <- matrix(c(0, 1.6), ncol = 1)
  } else if (p[i] > 0.86 && p[i] <= 0.93) {
    m <- matrix(c(0.2, 0.23, -0.26, 0.22), nrow = 2, ncol = 2)
    const <- matrix(c(0, 1.6), ncol = 1)
    
  } else {
    m <- matrix(c(-0.15, 0.26, 0.28, 0.24), nrow = 2, ncol = 2)
    const <- matrix(c(0, 0.44), ncol = 1)
  }
  coord <- m %*% coord + const
  df <- rbind(df, t(coord))
}


ggplot(df, aes(x = V1, y = V2, col = V2)) + 
  geom_point() +
  scale_colour_gradient2(low = "green", mid = "orange", high = "yellow", midpoint = 7) +
  theme(aspect.ratio = 1,
        legend.position = "none", 
        panel.background = element_blank(),
        axis.ticks = element_blank(), 
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        axis.text.x = element_blank(),
        axis.title.x = element_blank(),
        axis.text.y = element_blank(),
        axis.title.y = element_blank())
