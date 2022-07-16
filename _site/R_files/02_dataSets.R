# Essex Summer School in Social Science Data Analysis
# 3X Introduction to R, 2022
# Winnie Xia
# Modified from 1X Introduction to R files by Lorenzo Crippa, 2021
# Sunday 6th August 2022, 11am-5pm BST
# File 02: importing data sets, R packages, managing data with the tidyverse




# 1 Importing datasets ----

## 1.1 Clearing the environment ----

# Before we begin, let's make sure to clear our global environment. We can do
# this either with the following line of code:

rm(list = ls())

# Or by clicking on session -> clear workspace -> yes

# If you do it by code, make sure to keep that line *at the top* of your script.
# It's really important that you start fresh each time you do work in R, to make
# sure that your workflow (the order you do things) is replicable. In other words,
# it helps make sure that your future self or someone else can open up your script,
# run everything, and get the same result every time.




## 1.2 Working directories ----

# To read in and save files, R needs to know where in your computer to look.
# One way of doing this is by using the setwd() function to set your *working
# directory*. This is basically a location in your files that R will try and
# read files from and will save files to:

setwd("C:/Users/User/Documents/Projects/ESS2022-1X-Intro-To-R") #this is the file path where I have the course files - you'd need to fill in your own


# you can view your current working director with getwd():
getwd()


# However, an easier and better way of managing this is with R projects. By
# opening a project in RStudio, your working directory will automatically be
# set to the location the project is in.

# This is especially useful if you ever need to move your files around or
# work with collaborators - it gets rid of all the hassle of file paths.

# In our class files I've included a project called 2X.Rproj. Go to file ->
# Open Project and open it now.

# You can create a new project from the file window. Doing so will also create
# a new folder with the project inside.

# In general, I would *strongly* recommend using R projects to manage your
# file paths.




## 1.3 CSV files ----

# csv (comma separated values) are a common file format across the world. R
# comes with a ready-made read.csv() function for csv files. Let's use it to
# read in match_players.csv:

aoe <- read.csv("data/match_players.csv") #data/ is because it's stored in the 'data' folder of these files
class(aoe)

# match_players.csv contains player data from matches from the game Age of 
# Empires 2. You can find the full version of the dataset on Kaggle at
# https://www.kaggle.com/jerkeeler/age-of-empires-ii-de-match-data?select=match_players.csv


# We can view a dataset in a pane either by clicking on its name in the global
# environemnt or with the View() function (note the capital V):
View(aoe)

# We can get a sense of our dataset by looking at the top few rows:
head(aoe)
?head

# And we can use the str() function to see what types of variable we have in
# our data frame:
str(aoe) # 'int' or 'integer' is one kind of numeric. The other you'll likely see is 'dbl' or 'double'. In R, 99% (or more) of the time you won't need to worry about this distinction

names(aoe)


# We can remove columns we don't need by assigning NULL to them:
aoe$X <- NULL
head(aoe)




## 1.4 Other file types ----

# Often, you won't find files in a csv format. One format that's very common
# (at least in political science) is STATA's dta file format. For this, we need
# to use an R package because base R doesn't have the functionality to import
# them.

# R packages contain code written by other R users that have been bundled up and
# made available on CRAN (from where you downloaded R).

# Often, if you need to do something in R, you'll probably be using a package to
# do it. The best way to find them is by using google, but I'll include some
# recommendations at the end of today's class.

# I've downloaded the 2019 Chapel Hill Expert survey from their website
# (https://www.chesdata.eu/our-surveys). But I've downloaded it in dta format.

# Since it's a fairly recent file (STATA version 13 or later), we'll use the
# readstat13 package. To install it, we use the install.packages function:

install.packages("readstata13")


# You only need to install a package once. However, since we don't want all
# of our packages in memory all the time when using R, we have to explicitly
# load them for each fresh R session. We do this with the library() function:
library(readstata13)


# While I've written this library call here, normally it's a good
# idea to have library calls at the TOP of your script. This helps your future
# self, collaborators, and replicators know in advance what packages you used.

# Now, we'll use the read.dta13 function from readstata13 to load in the CHES
# dataset:
ches <- read.dta13("data/1999-2019_CHES_dataset_means(v3).dta")


# Some other packages you'll want installed are the foreign and readxl packages:
install.packages(c("foreign", "readxl"))

# Foreign is a good workhorse package for reading in data. It has read.dta (for
# STATA versions prior to 13 - probably more common that later dta files) and
# read.spss() among other functions.

# readxl is the package you want for reading in excel files - read_xls() and
# read_xlsx() depending on your need.

# We'll also be installing readr later on in this class - I'll mention when we
# do.




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

