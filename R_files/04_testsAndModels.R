# Essex Summer School in Social Science Data Analysis
# 3X Introduction to R, 2022
# Winnie Xia
# Modified from 1X Introduction to R files by Lorenzo Crippa, 2021
# Sunday 6th August 2022, 11am-5pm BST
# File 04: statistical tests, OLS, generalised linear models


# Before proceeding: clear your environment, restart R
rm(list=ls())


## Packages
install.packages(c("stargazer", "texreg"))
library(tidyverse)
library(stargazer)
library(texreg)


## Data
aoe <- read.csv("data/match_players.csv") %>%
  mutate(win = as.logical(tolower(winner)))
avocado <- read.csv("data/avocado.csv")
books <- read.csv("data/bestsellers with categories.csv")




# 1 t-tests ----

# As you may know, the reason why millennials can't afford a home is because
# they buy too much avocado toast. We're going to perform a t-test to get a
# sense of the mean price so that millennials can make better spending decisions.

# To test whether the mean avocado price is different from 0, we can use
# the t.test function:
t.test(avocado$AveragePrice) # by default a two-tailed t-test with null value = 0

# the t.test() function is VERY customisable to your needs:
?t.test

# We can also test to see whether the avocado price is the same as other values,
# like the median price of a house in the US:
t.test(avocado$AveragePrice, mu = 374900) #sets the null to 374900, which according to a brief google is the median house price in the US - https://www.fool.com/the-ascent/research/average-house-price-state/#:~:text=Key%20findings,416%25%20from%201980%20to%202020.

# We can perform one-sided tests:
t.test(avocado$AveragePrice, mu = 374900, alternative = "less")
t.test(avocado$AveragePrice, mu = 374900, alternative = "greater")

# We can also perform difference in means tests. We may for instance want
# to test to see whether conventional and organic avocados have the same mean
# price, so we can advise millennials looking to buy a house on whether avoiding
# organic will help them save up.
t.test(x = avocado$AveragePrice[avocado$type == "conventional"],
       y = avocado$AveragePrice[avocado$type == "organic"])

# Conventional avocados are cheaper! Maybe this is the secret to millennial
# home ownership...


# There are lots of other tests in base R via the stats package. These include
# but are by no means limited to:
# chisq.test() # Chi Square test
# prop.test() # Proportion test
# wilcox.test() # both Wilcoxon and Mann-Whitney U test

# As always, if you need to find a certain test - google is your friend!




# 2 Statistical models ----

## 2.1 OLS ----

# We're now going to switch things up and look at a dataset of Amazon bestselling
# books. We're interested in the effect of price and genre (fiction or
# non-fiction) on reader reviews.

# Let's start with a simple model looking at price. We build models in R like
# so:

model1 <- User.Rating ~ Price

# Our DV goes on the left-hand side of the tilde (~), our independent variables
# on the right-hand side. Here, we are regressing User.Rating on Price (note
# that these need to match the variable names exactly)

# We can then use the lm() function to run our model:
?lm
result1 <- lm(model1, books)


# Base R offers a way of looking at our results with the summary() function:
summary(result1)


# But we probably want to look at more than one variable - let's also look
# at genre. We add more variables with a + sign followed by the next variable
# name:

model2 <- User.Rating ~ Price + Genre
result2 <- lm(model2, books)
summary(result2)

# Notice that the character variable Genre was automatically treated as 
# a factor variable. Obviously, factors are too!

# For those who use STATA, this differs a lot from what you're used to - declaring
# variables as factors in the model. In R, the data type of your variables matters
# much more.




## 2.2 Outputting results ----

# Since you'll probably want to produce nice tables of your regression results,
# I've included two good packages (stargazer and texreg) for doing this in R. 
# Both are compatible with a very wide range of R packages.

# I personally prefer texreg of the two, so we'll be using that.

# Texreg contains three main workhorse functions: texreg, screenreg, htmlreg.

# The first creates LaTeX output, the second is good for building tables within
# R, the last one creates HTML output (this is what you'll want if you're writing
# papers in word. Word can open them and you'll see them as regular tables, and
# you'll be able to copy them over to a regular word document)

# Let's get going:
modelList <- list(result1, result2)
screenreg(modelList)

# There's a huge scope for customisation with texreg:
?screenreg # most of the important arguments are the same for the three functions
screenreg(modelList,
          custom.model.names = c("Partial", "Full"),
          custom.coef.names = c("Intercept", "Price", "Non-Fiction"),
          custom.gof.names = c("R-Squared", "Adjusted R-Squared", "N"))

# texreg() and htmlreg() generally take the same arguments in terms of 
# customisation, with a few specific differences relating to LaTeX/HTML specific
# things
texreg(modelList,
       file = "myResults.tex",
       custom.model.names = c("Partial", "Full"),
       custom.coef.names = c("Intercept", "Price", "Non-Fiction"),
       custom.gof.names = c("R-Squared", "Adjusted R-Squared", "N"),
       float.pos = "h")

htmlreg(modelList,
        custom.model.names = c("Partial", "Full"),
        custom.coef.names = c("Intercept", "Price", "Non-Fiction"),
        custom.gof.names = c("R-Squared", "Adjusted R-Squared", "N"))




## 2.3 Useful stuff ----

# Remember lists? notice something particular about our outputs:
is.list(result2)
is.list(summary(result2))


# This means if we know the structure of these objects, we can pull out
# useful information by knowing how to subset lists!

# This is a lot when you're new to R:
str(result2)

# But we can do lots of useful things:
result2$coefficients
result2$residuals
result2$fitted.values

# The coefficients from the summary() are stored in a matrix:
summary(result2)$coefficients

# Meaning we can 'chain' our subsetting to get lots of info out of them:
summary(result2)$coefficients[,2] # Standard errors of the coefficients
summary(result2)$coefficients[,4] # P-values of the coefficients

# Naturally, we can put this information in R objects!

# Finally
prediction <- as.data.frame(predict(result1, interval = "confidence"))
?predict




## 2.4 Generalized linear models ----

# In R, the majority of models you'll use (both from base R and other packages)
# have syntaxes similar to lm(). The formula structure is fairly ubiquitous,
# with some adjusments depending what the package is adding.

# We won't be covering these packges or models in today's class (as we risk
# going outside of general stats knowledge/stuff that's useful for
# everyone) but we will briefly look at generalized linear models.

# If you haven't heard the term before, this includes things like logit and
# probit models.

# Let's look at the effect of player ranking and civ on likelihood to win.

# We build our model in much the same way:
glmModel <- win ~ rating + civ

# And run it with the glm() function:
logit <- glm(glmModel, aoe, family = binomial(link = "logit"))
probit <- glm(glmModel, aoe, family = binomial(link = "probit"))

# Summary() and screenreg() work just as well here too:
screenreg(list(logit, probit))




# 3 R like Stata ----

# A question that arised last year is how to treat R like Stata
# - i.e. without having to use the name of the dataframe. You
# can use attach() and detch() to do this:

attach(books)

Price / 1000

detach(books)

# In general though, I'd recommend avoiding this style of syntax




# That's all for today folks!



# Exercises ----

# 1) Run a t-test on the mean user rating in the books data frame.


# 2) Run another t-test, this time testing the difference in mean price between
# fiction and non-fiction books. Feel free to use either Base R or the tidyverse.


# 3) Read in the simpsons_episodes.csv file from the data folder and store
# it in an object. Build and run an OLS model regressing IMDB rating on season.
# Store the result in an object.


# 4) Run another model regressing IMDB rating on both season and views. Store
# this in another object.


# 5) Print out the results from questions 3 and 4 next to each other using
# screenreg(). If you're feeling brave, check out the help file and try to
# customise the output.

