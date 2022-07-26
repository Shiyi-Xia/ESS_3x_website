# Essex Summer School in Social Science Data Analysis
# 3X Introduction to R, 2022
# Winnie Xia
# Modified from 1X Introduction to R files by Lorenzo Crippa, 2021
# Sunday 6th August 2022, 11am-5pm BST
# File 05: Additional Sources

# User-written functions ----

# We could write our own functions, which runs a series of commands. It usually includes 
# input and output variables. You must also name the function yourself.
# Once the function has been run, it is saved in your work environment by R and 
# you can run data through it by calling it as you would do with other function in R.

# The general structure looks like:

myfunction <- function(x){
  a <- x/2
  return(a)
}


# Let's see whether it works.
myfunction(4)

# Loop

# If/else statements
# There are various commands we can run within for loops to edit their functionality. 
# like If/else statements
# Let's see some example first. 
library(WDI)
wdi_data <- WDI(country = "all", 
                indicator = c(population = "SP.POP.TOTL",
                              gdp_percapita = "NY.GDP.PCAP.KD"), 
                start = 2000, end = 2020, extra = TRUE)

glimpse(wdi_data)

# If we would like to create a new binary variable based on
# whether the country is located in Europe and Central Asia, we could write this:

wdi_data$euro_central <- ifelse(wdi_data$region == "Europe & Central Asia",
                                TRUE, FALSE)

table(wdi_data$region)
table(wdi_data$euro_central)


