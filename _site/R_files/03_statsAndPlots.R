# Essex Summer School in Social Science Data Analysis
# 3X Introduction to R, 2022
# Winnie Xia
# Modified from 1X Introduction to R files by Lorenzo Crippa, 2021
# Sunday 6th August 2022, 11am-5pm BST
# File 03: Summary statistics and plots


rm(list=ls())
# Before you begin - empty your environment as before. This time, we also want
# to start with a fresh R session (no packages loaded) to make sure our work is
# replicable.

# Note the important thing - I can go back to file 02 and recreate the
# data frames I made from the raw data. NONE of the raw data has been
# overwritten!

# To restart your R session, click on Session -> Restart R

# Once this two things are done, go ahead and load the packages:


## Packages
# install.packages("psych") # normally I wouldn't include this line in a script, but today we're installing as we go
library(tidyverse)
library(readstata13)
library(psych)


## Data
library(haven)
setwd("~/Desktop/ESS_3x_website")
ANES <- read_dta("anesByState.dta")


# 1 Summary statistics ----

## 1.1 Summary statistics ----

# base R's summary function is a good workhorse function for descriptive stats:
summary(ANES$poor)

# it can be used for an entire dataset:
summary(ANES)


# the stats package is installed with base R and doesn't need to be called via
# the library() function. That means we have functions for most descriptive
# statistics:

mean(ANES$voteDem)
sd(ANES$poor)
var(ches$eu_position)
median(ANES$dem)
min(ANES$year)
max(ANES$voteDem)
quantile(ANES$poor, 0.3) # the observation that leaves 30% of the observations to its left
quantile(ANES$poor, 0.5) # this will be the median
var(ANES$dem)

# some useful functions for categorical data (especially if it's in character form):
table(ANES$year)
prop.table(table(ANES$year)) # note that prop.table takes a table as input

range(ANES$year)



## 1.2 Covariance and correlation matrices ----
ches |> 
  filter(country == 11) |>
  select(lrecon, eu_position, galtan) |>
  cor()

ches |>
  filter(country == 11) |>
  select(lrecon, eu_position, galtan) |>
  cov()

# note cor uses Pearson's correlation by default:
?cor

# if you have missing data, you want to set the argument use="complete.obs" to
# filter for missing data via casewise deletion:
ches |>
  select(lrecon, eu_position, galtan) |>
  cor(use="complete.obs")




## 1.3 Describe ----

# finally, the psych package includes the describe() and describeBy() functions
# which are *amazing* for continuous data:
describe(aoe, omit = T)
describeBy(aoe$rating, aoe$team)

# note the *'s next to some variables - this is telling us they were originally
# characters and were converted to numeric by the function. Some of these
# stats are probably meaningless!

# to select only numeric variables with dplyr:
aoe |>
  select_if(is.numeric) |> #this is one case where you don't want to include the parantheses for the is.numeric function
  describe()

# we might want to combine filtering from file 02 with these functions:
describe(aoe[aoe$civ == "Franks",])
describe(aoe |> filter(civ == "Franks"))

# there's a lot of room to customise the output:
describe(aoe, skew = FALSE, IQR = TRUE, ranges = FALSE)

test <- describe(aoe, skew = FALSE, IQR = TRUE, ranges = FALSE)
class(test)


# Let's say we want to look at some variables in CHES for the UK, Germany, and France.
# From the codebook, the codes for these countries are 11, 3, and 6 respectively.

# We could do this:
ches |>
  filter(country == 11 | country == 3 | country == 6) |>
  select(country, lrecon, eu_position) %>%
  describeBy(., .$country) #if you want to pipe into more than one slot or a slot other than the first, use the full stop - this is specific to %>%

# But the %in% operator can be VERY useful for larger OR expressions:
ches |>
  filter(country %in% c(3,6,11)) |>
  select(country, lrecon, eu_position) %>%
  describeBy(., .$country)




# 2 Plotting ----

# Here, we'll be doing a mix of base R plotting and tidyverse plotting via
# the tidyverse package ggplot2 (already loaded earlier).

# We'll look at four kinds of plot:
# 1) Boxplots
# 2) Histograms
# 3) Density plots
# 4) Twoway plots

# Obviously, many others can be done - especially via ggplot2 (and associated
# packages)


## 2.1 Boxplots ----

# In base R we use the boxplot() function:
boxplot(ANES$white)

# We can use arguments to modify its appearance:
boxplot(ANES$white, frame = F, ylab = "white", main = "A boxplot")

# It's a little more involved in the tidyverse:
ggplot(ANES, aes(y = white)) +
  geom_boxplot() +
  theme_minimal()

# We start by using the ggplot() function to create a graph. Here we tell it
# what dataset to use, and what the relevant 'aesthetics' to use are. The most
# common ones are y axis, x axis, group, and fill (similar to group).

# Then, ggplot2 brings some unique syntax. After the ggplot() function, we put
# a plus sign. After that, we add a geom (geometry). We can also add further
# geoms and other features after that, each time chaining things together with
# the + sign.

# This can get fairly involved, but it's *very* powerful:
ggplot(aoe, aes(y = rating)) + 
  geom_boxplot(fill = "gray", alpha = 0.5) +
  labs(y = "Rating", title = "Player Rating") +
  scale_y_continuous(breaks = seq(0, 3200, 800), limits = c(0, 3200), expand = c(0,0)) +
  theme(axis.line.x = element_blank(),
        axis.text.x = element_blank(),
        axis.ticks.x = element_blank(),
        panel.background=element_blank(),
        axis.line.y = element_line(colour = "black"),
        plot.title = element_text(hjust = 0.5, vjust = 5),
        aspect.ratio = 1,
        plot.margin = unit(rep(1, 4), "cm"))

# Don't worry - there are good pre-built themes! theme_classic(), theme_bw() and 
# theme_minimal() are all popular choices. There are also several packages out
# there containing other possible ggplot2 themes - the sky really is the limit
# here.

# To show the distribution of a variable in separate boxplots:
aoeSelect <- aoe %>%
  filter(civ %in% c("Franks", "Teutons", "Chinese"))

# In base R:
boxplot(aoeSelect$rating ~ aoeSelect$civ, #plot rating by civ
        frame = F, ylab = "Rating", xlab = "Civ", main = "Player Ratings by Civ")

# In the tidyverse:
ggplot(aoeSelect, aes(y = rating, x=civ)) + 
  geom_boxplot(fill = "gray", alpha = 0.5) +
  labs(y = "Rating", x = "Civlisation", title = "Player Rating") +
  scale_y_continuous(breaks = seq(0, 3200, 800), limits = c(0, 3200), expand = c(0,0)) +
  theme_classic() +
  theme(plot.title = element_text(hjust = 0.5, vjust = 5),
        aspect.ratio = 0.8,
        plot.margin = unit(rep(1, 4), "cm"))

# Note here that it was easier to mix and match a default theme with some
# extra adjustments of our own




## 2.2 Histograms ----

# Plotting histograms is fairly easy in base R:
hist(ches$eu_position, main = "EU Party Positions", xlab = "Position")

# We can ask for probability densities instead of frequencies:
hist(ches$eu_position, main = "EU Party Positions", xlab = "Position", probability = TRUE) # to have probabilities


# In the tidyverse:
ggplot(ches, aes(x = eu_position)) + 
  geom_histogram()

# With more details:
ggplot(ches, aes(x = eu_position)) + 
  geom_histogram(binwidth = 1, fill="purple4", alpha=0.8, colour="black") +
  scale_y_continuous(breaks = seq(0,500,50), limits=c(0,500), expand=c(0,0)) +
  scale_x_continuous(breaks=seq(1,7,1), limits=c(0.5,7.5), expand=c(0,0)) +
  labs(x = "EU Position", y = "Count", title = "CHES Party EU Positions") +
  theme_classic()




## 2.3 Density plots ----

# We can also obtain kernel densities of our data:
density(ches$lrecon) # this function takes our data as input and computes the kernel density

# To make a density plot in base R:
plot(density(ches$lrecon))

# In the tidyverse things are, again, simpler:
ggplot(ches, aes(x = lrecon)) + 
  geom_density()

# As before, you can mess around with customising both kinds of plot - but 
# I suspect you know that by now!




## 2.4 Twoway plots ----

# Of course, we often aren't just interested in plotting single variables. We're
# probably more often interested in two-way relationships. One example might be
# the relationship between how left-wing a party is and its EU position. Let's
# focus on the case of the UK to begin with:

csvfile <- "https://raw.githubusercontent.com/lorenzo-crippa/Intro_to_R/master/2021/baseball.csv"
baseball <- read.csv(csvfile)

plot(x = baseball$heightinches, y = baseball$weightpounds,
     frame.plot = FALSE, xlab = "height", ylab = "weight",
     pch = 20) # pch is an option that selects the shape of dots we want 

# what if we want to add lines on this plot? We use the abline() function
# Maybe we want to plot a line corresponding to the mean height 
# lwd makes it thicker
abline(v = mean(baseball$heightinches, na.rm = TRUE), col = "red", lwd = 5) 


# Again, tidyverse makes things much easier. Let’s re-do all the steps we did before. 
# First, we created a scatter plot. This time, l
# let’s save the plot in an object:

my.plot <- ggplot(baseball, aes(x = heightinches, y = weightpounds)) +
  geom_point() +
  theme_minimal()
my.plot

# It's much simpler to save plots in the tidyverse:
ggsave(my.plot, filename = "my_first_ggplot.pdf")
?ggsave #saves the last created plot by default, else specify plot in plot argument



# Exercises ----

# 1) Get a summary of the 'redistribution' variable from the CHES dataset. Put
# the same variable through Psych's describe() function


# 2) Describe the redistribution variable by party for the German (country = 3)
# data in CHES. Feel free to use any mix of base R or tidyverse you want.


# 3) Read in the simpsons_episodes.csv file from the 'data' folder. Make
# a boxplot of the IMDB ratings variable in base R.


# 4) Make a scatter plot of IMDB ratings and season. Store the plot in an object.


# 5) Add a theme and a regression line to the object you just made - so if your
# object is called myPlot, myPlot + theme() will for instance work. I.e. you
# can keep adding to ggplots after you've stored them in an object! (note that
# this won't overwrite the object unless you assign it)

