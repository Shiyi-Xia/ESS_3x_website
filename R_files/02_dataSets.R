# Essex Summer School in Social Science Data Analysis
# 3X Introduction to R, 2022
# Winnie Xia
# Modified from 1X Introduction to R files by Lorenzo Crippa, 2021
# Sunday 6th August 2022, 11am-5pm BST
# File 02: importing data sets, R packages, managing data with the tidyverse




# 1 Import and Manage datasets ----

## Import Datasets ----

# Now, we will learn how to import different types of databases from outside.
# First, let's clean our environment before dealing with databases

rm(list = ls())

# Or by clicking on session -> clear workspace -> yes

# If you do it by code, make sure to keep that line *at the top* of your script.
# It's really important that you start fresh each time you do work in R, to make
# sure that your workflow (the order you do things) is replicable. In other words,
# it helps make sure that your future self or someone else can open up your script,
# run everything, and get the same result every time.




## Working directories ----

# Then, we must set up our working directory, the folder on our computer 
# where we are going to work from, where we store our data and 
# where perhaps we might want to save our plots or the outputs from the analysis.
# In R, we do it using the setwd() function:

setwd("~/Desktop/ESS_3x_website")#this is the file path where I have the course files - you'd need to fill in your own


 # you can view your current working director with getwd():
getwd()


## Import Data ----

# The choice across various functions of importing data
# depends on the data type, e.g. .dta, .csv, or .xlsx.
library(haven)
ANES <- read_dta("anesByState.dta")

# Now, let's try to import data from a csv file and save it in a names object
csvfile <- "https://raw.githubusercontent.com/lorenzo-crippa/Intro_to_R/master/2021/baseball.csv"
baseball <- read.csv(csvfile)

# Yes! We could import a data file from a URL
url <- "http://www.principlesofeconometrics.com/stata/broiler.dta"
data.df <- read_dta(url)

# In addition, although we won't get into the details of this method,
# some package 
library(WDI)
wdi_data <- WDI(country = "all", 
                indicator = c(population = "SP.POP.TOTL",
                              gdp_percapita = "NY.GDP.PCAP.KD"), 
                start = 2000, end = 2020, extra = TRUE)


# We can view a dataset in a pane either by clicking on its name in the global
# environemnt or with the View() function (note the capital V):
View(ANES)

# We can get a sense of our dataset by looking at the top few rows:
head(ANES)
glimpse(ANES)
?head

# And we can use the str() function to see what types of variable we have in
# our data frame:
str(ANES) # 'int' or 'integer' is one kind of numeric. The other you'll likely see is 'dbl' or 'double'. In R, 99% (or more) of the time you won't need to worry about this distinction

names(ANES)

# 2 Manage datasets ----

# In part one of this class, we learned the basics of subsetting and recoding
# with the base R square brackets.

# However, there's a suite of packages designed to help do the same thing with
# code that's much easier for a human to read. This suite is called the tidyverse
# and can be installed as a single package:

install.packages("tidyverse")
library(tidyverse)

# You can also load the packages individually if you wanted:
# library(dyplr)




## 2.1 filter ----

# before trying to recode or filter, it can be useful to get a sense of the
# variable(s) we want to recode:

unique(ches$country) # see the unique values
table(ches$country) # get a frequency table
# note these two aren't so useful for numerical data - we'll see some more
# for this in a bit

# If you read the CHES documentation, you'll see that country 11 is GB.

# In base R, if we only wanted to look at the GB CHES data, we'd filter it
# like this:
ches[ches$country == 11,]

# We can use the dplyr filter() function to do the same:
filter(ches, country == 11)




## 2.2 select ----

# before choosing variables, it can be good to get a sense of what's in
# our dataframe:
ncol(ches)
names(ches)
# though note the best way to get on top of these things is to read the 
# documentation!

# If we wanted to keep a select of variables, we might do it like so in base R:
ches[,c("party", "year", "lrecon", "eu_position", "galtan")]

# Alternatively, we can use the dplyr select function:
select(ches, party, year, lrecon, eu_position, galtan)




## 2.3 select & filter, pipes ----

# If we wanted to keep those variables for the GB parties, we could do the
# following in base R: 
ches[ches$country == 11, c("party", "year", "lrecon", "eu_position", "galtan")]


# In the tidyverse, we could wrap our functions...
select(filter(ches, country == 11), party, year, lrecon, eu_position, galtan)

# But the tidyverse includes a VERY useful operator called the 'pipe'. This takes
# the output of your function, and puts it in the FIRST SLOT of the next function:

ches %>%
  filter(country == 11) %>%
  select(party, year, lrecon, eu_position, galtan)

# This code doesn't run ANY differently to the above, but it's much easier for a
# human to read.

# As of R version 4.1, there is now a base R pipe which doesn't need the tidyverse:
ches |>
  filter(country == 11) |>
  select(party, year, lrecon, eu_position, galtan)

# In general, I'd recommend that unless you have a particular use case, you use this
# one.

# To assign the final output:

chesGB <- ches |>
  filter(country == 11) |>
  select(party, year, lrecon, eu_position, galtan)
chesGB

# You don't have to use the pipe - but it's very, very nice for combining dplyr
# functions (and chaining others), and helps keep your code readable.

# Note also that I've used a different object rather than overwriting ches -
# in general to let yourself have room to make mistakes without needing to redo
# everything it's a good idea not to overwrite objects in your environment




## 2.4 mutate ----

# If we wanted to add a new variable to our data frame in base R:
chesGB$lrSquare <- chesGB$lrecon^2

# In the tidyverse, we can use the 'mutate' function:
chesGB <- chesGB |>
  mutate(euSquare = eu_position^2,
         galtanSquare = galtan^2,
         sumSquare = lrSquare + euSquare + galtanSquare)

# This lets us make lots of variables in one go, rather than writing a new
# assignment each time. Note we can use the new variables within the same
# command!

# It also lets us avoid the need to keep remembering the $ operator




## 2.5 ifelse() and case_when() ----

# It's often the case that we want to conditionally recode a variable.

# Here, base R's ifelse() and the tidyverse's really shine.

# Let's say we want to createa binary variable based on the 'ranking' variable
# in the aoe dataset, where above 2000 are 1, and the rest are 0.

# We could do something like this:
ifelse(aoe$rating > 2000, yes = 1, no = 0)

# Notice how the function works:
?ifelse

# We give a logical test, what to return if that test is TRUE, and what to return
# if the test is FALSE.


# What happens if we want to change this up a bit - those over 2000 are 2, those
# under that but over 1000 are 1, and the rest are 0.

# We can 'chain' our ifelse() statements:

ifelse(aoe$rating > 2000, yes = 2,
       no = ifelse(aoe$rating > 1000, yes = 1, no = 0))


# As you can imagine, this can start to get messy.

# Once again, the tidyverse has a function that helps us tidy this up a bit -
# case_when:
?case_when

# the documentation is a little unintuitive, but here's how it works:
case_when(aoe$rating > 2000 ~ 2,
          aoe$rating > 1000 ~ 1,
          !is.na(aoe$rating) ~ 0) #notice we need to be clever about dealing with missing values here

# we can mix it with mutate() to make it even easier to read and write:
aoe %>%
  mutate(test = case_when(rating > 2000 ~ 2,
                          rating > 1000 ~ 1,
                          !is.na(rating) ~ 0))


# Notice importantly that this STILL behaves like an ifelse() chain - anything
# that passes the first test will not go onto the second, and so on.




## 2.6 Renaming ----

# Base R and tidyverse renaming work in fairly different ways.
# With base R, you assign the name to the subset of the names
# vector:

names(ches)
names(ches)[2]
names(ches)[names(ches) == "party"]

# To rename, select the part of names() you want to change and assign to it:
names(ches)[2] <- "EastWest"
names(ches)[names(ches) == "party"] <- "Party"

# Result:
names(ches)
names(ches)[2]


# In the tidyverse, a rename() function is included:
ches <- ches |>
  rename(GalTan = galtan)

names(ches)[36]



# Exercises ----

# 1) read in the simpsons_episodes.csv file from the 'data' folder and store it in
# an object. Take a moment to explore it (hint - names and str will be useful
# here)


# 2) make a vector denoting whether the IMBD rating for an episode is above 8.
# try to do this using both base R and the tidyverse.


# 3) Filter for the first ten season and select, IMDB ratings, episode id, season
# number, title, and view number. Try to do it with both base R and the tidyverse.
# Store the output in a new object.


# 4) In this object, create a new variable showing the rating per views. Try doing
# this with both base R and the tidyverse.


# 5) Check out the write.csv function. Save the data frame you've ended up with
# after question 4 in the 'data' folder UNDER A DIFFERENT NAME! For example,
# simpsons10.csv.
?write.csv

