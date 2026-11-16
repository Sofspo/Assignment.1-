install.packages("sampling")

library(tidyverse)
library(renv)
library(GGally)
library(sampling)

renv::snapshot()


head(iris)
summary(iris) 
str(iris)

# 5: Data manipulaion task

    # The iris datset

data(iris)
iris <- as_tibble(iris)
iris

print(iris, n = 3, width = Inf)

    # Data quality 

summary(iris)

iris %>% summarize_if(is.numeric, mean)

ggpairs(iris, aes(color = Species))

clean.data <- iris %>% drop_na() %>% unique()
summary(clean.data)

    # Aggregation 

iris %>% group_by(Species) %>% summarize_all(mean)

iris %>% group_by(Species) %>% summarize_all(median)

    # Sampling

       # Random sampling 
sample(c("A", "B", "C"), size = 10, replace = TRUE)

take <- sample(seq(nrow(iris)), size = 15)
take

iris[take, ]

set.seed(1000)

s <- iris %>% slice_sample(n = 15)
ggpairs(s, aes(color = Species))
 
        # Stratified samling 

id2 <- strata(iris, stratanames = "Species", size = c(5,5,5), method = "srswor")
id2

s2 <- iris %>% slice(id2$ID_unit)
ggpairs(s2, aes(color = Species))


# Features 

    # Dimensionality Reduction





# Introduction to tidyverse 

# load data
data(iris)

# provide you the first 6 rows of the data
head(iris)

# check the structure of data. Very handy function to get a basic information about the data.
str(iris)

# create tibble format table
df <- tibble::as_tibble(iris) 
df

# Filter rows with filter()
# here df is the object where we had store our tibble data
# yes, you need to use ==
filter(df, Species == "versicolor")

# Comparisons
filter(df, Petal.Length > 2)

# Logical operators
filter(df, Petal.Length > 6 & Sepal.Length > 7)

# arrange by sepal length then petal width. Default is ascending order. 
arrange(df, Sepal.Length, Petal.Width)

# allows to arrange in descending order. 
arrange(df, desc(Sepal.Length))

# from iris data, lets select only three columns - Species, Petal width and Petal length
select(df, Species, Petal.Width, Petal.Length)

mutate(df, log.Sepal.length = log(Sepal.Length))

# find mean of peteal length
summarise(df, mean(Petal.Length))

# find mean of petal length for each species
group_by(df, Species) %>% count(n())

df %>% 
  group_by(Species) %>%
  summarise(mean(Petal.Length))

#1 Scatter PLot
ggplot(data=df, aes(x = Sepal.Length, y = Sepal.Width))+
  geom_point(aes(color=Species, shape=Species)) +
  xlab("Sepal Length") +
  ylab("Sepal Width") +
  ggtitle("Sepal Length-Width")

# 2) Box Plot

box <- ggplot(data=df, aes(x=Species, y=Sepal.Length))

box + 
  geom_boxplot(aes(fill=Species)) +
  ylab("Sepal Length") +
  ggtitle("Iris Boxplot") +
  stat_summary(fun.y=mean, geom="point", shape=5, size=4)

# 3) Histogram
histogram <- ggplot(data=df, aes(x=Sepal.Width))

histogram +
  geom_histogram(binwidth=0.2, color="black", aes(fill=Species)) +
  xlab("Sepal Width") + 
  ylab("Frequency") + 
  ggtitle("Histogram of Sepal Width")

# 4) bar plot
bar <- ggplot(data=df, aes(x=Species))

bar +
  geom_bar(aes(fill=Species)) +
  scale_fill_manual(values=c("pink", "lightblue", "lightgreen")) +
  xlab("Species") +
  ylab("Count") +
  ggtitle("Bar plot of Iris Species")

# 5) Faceting
facet <- ggplot(data=df, aes(Sepal.Length, y=Sepal.Width, color=Species)) +
  geom_point(aes(shape=Species), size=1.5) +
  xlab("Sepal Length") +
  ylab("Sepal Width") +
  ggtitle("Faceting") 

# Along columns
facet + facet_grid(. ~ Species)