# Essex Summer School in Social Science Data Analysis
# 3X Introduction to R, 2022
# Winnie Xia
# Modified from 1X Introduction to R files by Lorenzo Crippa, 2021
# Sunday 6th August 2022, 11am-5pm BST
# File 01: data types, data structures, using functions



# Introduction  ----

# First things first: text proceeded by a hashtag in R is a comment. If you 
# run a comment through R, it will ignore it! This is useful for helping both
# other people AND your future self in 6 months' time understand what your code
# was supposed to be doing.

# To run a piece of code in an R script, move your cursor to that line and press
# ctrl+enter (cmd+enter for Mac):
2 + 2

# You can also click the 'run' button at the top-right of the R script:
2 - 1

# To run a specific selection of code, or multiple unrelated lines, highlight
# them and then run them as normal:
3 * 5
20 / 10

# Note that running lines with ctrl+enter/cmd+enter/clicking 'run' skips comments:
2 * 10
# this line (32) will be ignored and the next line (33) run!
2 / 10

# ALWAYS (with one exception) do your work in R files - this ensures that you
# and others can replicate your steps

# Some other useful keyboard shortcuts in RStudio:
# ctrl+z (cmd+z for mac): undo
# ctrl+s (cmd+s for mac): save
# ctrl+shift+c (cmd+shift+s for mac): comment/uncomment current/highlighted lines
# crtl+f (cmd+f for mac - I think): search and replace. VERY useful, but be CAREFUL not to mess up your code!




# 1 R Data Types ----

# There are four main data types in R. We'll go over the first three now, and 
# talk about the last one later.

# 1) Numbers (we've seen these already)
0
1.5
3 ^ 4 # this would be 3 to the power of 4. 3^2 would be 3 squared, etc
pi # pi is coded in, should you ever need it
2e+10 # R can handle some pretty big numbers!

# 2) Strings
"abc"
"hello, world!"
'notice Strings can use double or single quotes'
"strings can also contain hastags without a problem #"
# "but a hastag BEFORE the quotes will mean it's a comment"
"you can include single quotes in side a double-quotes string: it's "
'or double quotes inside a single-quotes string: "hello!" '
"or you can use a backslash to include the same kind of quotes in the same kind of string: \"hello!\""
'as above: it\'s' # if you forget the backslash, bad things will happen

# 3) Logical (MUST be capitalised):
TRUE
FALSE
# Notice we can just use T or F
T
F

# 4) Categories: [England, Scotland, Wales, Northern Ireland]
# We'll talk about this one in a bit

# 5) Special cases
# Not really a data type in their own right, but can be important:
NA # missing data - the most important for today's purposes
NaN # not a number - will only happen if something has gone wrong!
NULL # basically an undefined value - there's nothing there (not even missing data!)



# 2 Creating and assigning objects ----

# In R (and other programming languages), it's useful to be able to access the
# same value again and again.

# So, we store data in *objects*, so we can keep accessing it (and to avoid using
# the wrong value later on!)

# To assign something to an object in R, we use an arrow: <-
# The name we want to give the object goes on the left-hand side, the data we want
# to assign to it on the right-hand side:

a <- 2

# The above code assigns the value of 2 to an object called a
# Notice that a is now in our *global environment* in the top-right part of 
# RStudio (unless you've changed your settings)

# Notice also that this time, the value of 2 didn't paste to our console like
# before!

# We can access the contents of a by running it as code:

a

# The name of 'a' is arbitrary. With a few limits (like not using NULL as a
# name, and not using spaces in the name), we can name objects whatever we want:

banana <- 10
banana

# Most importantly, we can use objects in operations:

a * banana
a + banana

# Note that objects in R are *mutable*. This means we can overwrite them:

a <- 5
a * banana
a + banana

# So be careful - only overwrite when you're sure you want to!




# 3 Using Functions ----

# You may have noticed that so far we've seen the following math operators:
# * / + - ^ (multiplication, division, addition, subtraction, exponentiation)

# But how do we get the square root of something?
# We use the sqrt() function:

sqrt(4)

# The real power of R is in its functions. Both base R and many packages (we'll
# get onto these in a bit) have many useful functions for us to use.


# The trick of course is in learning how to understand and find functions.
# The best place to begin (if you know a function's name) is by putting a question
# mark before it, dropping the parentheses and running it:

?sqrt

# As you can see, this opens the function's documentation in the *help* pane
# in the bottom-right of RStudio. These documents can be a little daunting sometimes,
# but you'll get used to them. The most important parts are:

# Usage - this shows us what order the arguments are in and what defaults if any 
# there are

# Arguments - these tell us what *inputs* the function is expecting

# Value - this tells us what *output* we expect from the function - note that sqrt()'s
# documentation doesn't have the value header but DOES describe the output under details

# Many documentations also include examples at the bottom.



# That may have been a lot - let's look at another example:

?log

# notice for log() we have TWO arguments. The first is our input (x), the second
# is the base of the logarithm. Notice that the default is that we use the natural
# logarithm.

# If there is a default argument, R will use this UNLESS you overwrite it!

# To take the base 10 logarithm of the number 2:

log(2, 10)

# Notice that we don't need to explicitly name arguments. If we don't name our
# arguments, R will assume that we're giving them in the order listed in
# the 'usage' section of the documentation.



# Notice also that we can 'chain' functions together:
log(sqrt(4), 10) # gives exactly the same as log(2, 10) above as sqrt(4) = 2

# The evaluation order for R is inside to outside. In other words, R will
# evaluate the function on the inside first, and the one on the outside second.



# If you don't know the name of a function or want to find one, google is your
# best friend. A big chunk of getting good at R is going to be getting good at 
# finding what you need via google.

# For example, to find the exponential function:
# https://www.google.com/search?q=r+exponential+function&oq=R+exponential+function&aqs=chrome.0.0l2j0i22i30l4j69i60l2.3764j0j4&sourceid=chrome&ie=UTF-8



# Let's try one more before we move on:
?paste
paste("This", "is", "a", "full", "sentence")

# Notice the "..." in the arguments. This means we can give it as many inputs as
# we want, BUT we'll need to *explicity* name any further arguments:
paste("This", "is", "a", "full", "sentence", sep="-")




# 4 Data Structures ----

# It's not very useful to use just one value on its own a time!
# We can store lots of data in larger *data structures*.

# There are four main data structures you're likely to see in R. These are:
# 1) vectors
# 2) matrixes (2-dimensional vectors)
# 3) data frames
# 4) lists

# We can roughly summarise objects we'll work with in R based on whether they 
# contain data of the same type (homogeneous) or not (heterogeneous), and based on 
# their number of dimensions:

#	               | Homogeneous |	Heterogeneous |
# ---------------+-------------+----------------+
# One dimension  |	 Vectors   |	    Lists     |
# Two dimensions |	Matrices	 |	 Data frames  |
# ---------------+-------------+----------------+




## 4.1 vectors ----

#	               | Homogeneous |	Heterogeneous |
# ---------------+-------------+----------------+
# One dimension  |	 Vectors   |	    Lists     |
# Two dimensions |	Matrices	 |	 Data frames  |
# ---------------+-------------+----------------+

# Vectors are one-dimensional objects that can have different lengths and can
# contain different values, but all of the same data type (all numeric, all 
# characters, all logical...)

# we can create them by using c():
?c
vec1 <- c(1, 5, 2, 6, 8, 9, 12, 2.4, 0.3, -2.56)
vec2 <- c("vectors", "can", "contain", "any", "data", "type")

# the c() function stands for "concatenate" and is used to join objects together
vec1
vec2

# we can quickly create numeric vectors with certain patterns using the seq() 
# function :

?seq
vec3 <- seq(1, 11, 2)
vec3

# If you only want to increment by 1, there is a shorthand (syntactic sugar):

vec4 <- 11:20
vec4

# We can get information about our vectors using some functions:

# how long is my vector?
length(vec1) # it's a vector of length 10

# what data type is in my vector?
class(vec1)




### 4.1.1 Subsetting ----

# It's useful to be able to access or recode certain parts. We can access parts
# of our vector using square brackets [] immediately after their name.

# If we want to access the second value of a vector:

vec2[2]
vec4[2]

# If we want to access more than one part of a vector, we can put a vector
# INSIDE the square brackets to get at it:

vec4[1:5] # don't forget inside-out - 1:5 becomes a vector of 5 values, which are then used


# Notice also that we can use a vector of TRUEs and FALSEs the *same length* as
# vector we are subsetting to extract values. So if I only want the first value:

vec4[c(T,replicate(9,F))]

# this might be starting to look a little complicated. Don't forget, inside-out order!
# If you want to understand what's going on, break it down into steps:

?replicate
replicate(9,F)
c(T,replicate(9,F))
vec4[c(T,replicate(9,F))]
vec4[1]




### 4.1.2 Logical expressions ----

# This becomes useful once we introduce two further concepts: logical expressions
# and vectorisation.

# Let's start with vectorisation. Most (though not all) things in R are
# *vectorised*. This means if I try and add 10 to a numeric vector, it will add
# 10 to all components of that vector:

1:10
1:10 + 10

# It also means that were necessary, R can *recycle* one of the two vectors you're
# adding to each other if they're not the same length:

1:10 + c(10,20)

# BUT: the longer vector needs to be a multiple of the shorter vector for
# this to work:
1:10 + 1:3 # Gives a warning because 10 isn't a multiple of 3 - this is usually bad!




# On to logical operations. To introduce the main ones:

# == equal to
# != is not equal to
# > greater than
# < less than
# >= greater than or equal to
# <= less than or equal to
# | or
# & and
# ! not

# These can seem like a lot at first. Let's see them in action:

10 == 10
10 == 11
10 > 4
10 < 4
10 > 4 | 10 < 4
10 > 4 & 10 < 4
!10 < 4

# so - we have two statements either side, and the expression returns
# TRUE or FALSE. So far so good. Now, recall the concept of vectorisation -
# these expressions are vectorised too!

# For example:

1:10 < 5
# this returns a vector of the same length of TRUES and FALSES to give us
# a TRUE or FALSE for each component of the vector


# Hopefully you can see where this starts to become useful. Let's say
# I want to subset all elements of my vector that are greater than 15:
vec4[vec4 > 15]


# You can check the type of your data with the following functions:
is.logical(T)
is.logical(2)
is.numeric(2)
is.numeric(T)
is.character("hello, world!")
is.character(TRUE)

# If you want to check whether you have a vector, use the is.atomic() function:
is.atomic(1:10)
# DON'T get this confused with is.vector() - this isn't doing what you think
# it's doing!



# One last thing - notice the numbers by the side? What do you think they mean?
100:200

# They show the position of the first number in the vector. So 129 is the 30th
# item in the vector!

# Notice that when we output just one number, it still has the number:
100

# A useful fiction we're working with is that we put data inside vectors. And
# you should keep that fiction - it's helpful for wrapping your mind around R.
is.atomic(100)

# BUT - it's also good to know it's a fiction. Remember the sqrt() function
# from earlier? Let's look at the documentation again:

?sqrt

# Notice that the input says it expects a vector or array, rather than just
# a number. That's because like most functions it's vectorised! Hopefully
# this won't confuse you *too much*, but will help with understanding some
# of R's documentation (which can be notoriously difficult at first)





### 4.1.3 Recoding ----

# We can also use the square brackets to recode subsections of our vector. Let's
# say I want to change the second word in vec2 to "banana":

vec2
vec2[2] <- "banana"
vec2

# As you can imagine, this becomes very useful when combined with logical
# expressions. We can conditionally recode subsections of our vectors!

vec1
vec1[vec1 < 3] <- 100
vec1




### 4.1.4 Coercion ----

# We can change vectors of one data type to another using the following functions:

# as.numeric()
as.numeric(TRUE) # TRUE will become 1, FALSE will become 0
as.numeric("a") #notice the warning - R doesn't know how to convert characters to numeric
as.numeric("2") #though it WILL get numbers stored in strings right


# as.logical()
as.logical(1) # vice versa
as.logical("true") #pretty handy 
as.logical("tRuE") # but we can't push it too far


# as.character()
as.character(1)
as.character(TRUE)
# it's very easy to turn things into characters!
# but NAs will (appropriately) stay NA:
as.character(NA)


# There is also *implicit* conversion in R. What happens if we try to replace
# the fourth component of vec2 with the number 20?

vec2
vec2[4] <- 20
vec2

# It worked - BUT converted our number to a character!

# In general, try to avoid implicit conversion. It won't always work outside
# of the square brackets, and can lead to unintended consequences if you're not
# careful.




### 4.1.5 Factors ----

# Factor variables are the last data type. They can be a little finciky to
# work with and only really make sense to use once you're using vectors.

# Let's say we have a vector where we want to set the following codings:
# 1 = Wales
# 2 = England
# 3 = Scotland
# 4 = Northern Ireland

n <- 5
countries <- c(replicate(n, 1), replicate(n, 2), replicate(n, 3), replicate(n, 4))


# We use the factor() function to make factors:
?factor

# the relevant parts here are 'levels' and 'labels':
countriesFac <- factor(countries, 1:4, c("Wales", "England", "Scotland", "Northern Ireland"))

countries
countriesFac


# note that we don't have to use numbers as the levels/values: we can just turn
# character vectors into factors:

size <- c("Small", "Big", "Medium", "Small")
factor(size)

# use the 'levels' argument if you want to put values in a particular order:
factor(size, levels=c("Small", "Medium", "Big"))

# you can explicitly declare the factor as ordered with the ordered argument,
# but whether this matters can depend a bit on what you're doing and the package(s)
# you're using:

sizeFac <- factor(size, levels=c("Tiny", "Small", "Medium", "Big", "Huge"), ordered=T)
sizeFac

# some useful factor functions:
sizeFac <- droplevels(sizeFac) # removes any unused levels from a factor. Will keep ordering
sizeFac
is.factor(countriesFac) # tests whether a vector is a factor
is.ordered(sizeFac) #tests whether a factor is ordered




## 4.2 matrices ----

#	               | Homogeneous |	Heterogeneous |
# ---------------+-------------+----------------+
# One dimension  |	 Vectors   |	    Lists     |
# Two dimensions |	Matrices	 |	 Data frames  |
# ---------------+-------------+----------------+

# We can think of matrices as two-dimensional vectors. They also have to contain
# the same data type (i.e. no mixing or matching). The above functions like
# as.character() will work on them too!

# We create matrices with the matrix() function:
?matrix


# Let's create a 3x4 matrix with numbers from 1 to 12 in its cells:  
myMatrix <- matrix(data = c(1, 100, 50, 4:12), # the data in our matrix. Pick all integers from 1 to 12 (included)
            nrow = 3, # the number of rows 
            ncol = 4, # the number of columns
            byrow = TRUE) # do we want data to be stored in cells by row or by column?
myMatrix

# One thing to pick up before we continue - notice how we can spread our
# functions across several lines. Notice also that ctrl+enter (cmd+enter) will
# run the whole thing UNLESS we're highlighting a particular part of it.


# Subsetting matrices is VERY similar to subsetting vectors, except now we have
# two dimensions to work with. So, we introduce a comma into the square brackets
# [,] and just like in linear algebra, we use a [row, column] format. Let's
# see some examples:

myMatrix[2,4] # the value in the 2nd row, 4th column
myMatrix[,1] # all the first column (notice the row slot is left blank)
myMatrix[1,] # all the first row (notice the column slot is left blank)
myMatrix[,2:3] #2nd and 3rd column



# We can also give names to our columns and rows:
colnames(myMatrix) <- c("one", "two", "three", "four")
rownames(myMatrix) <- c("a", "b", "c")
myMatrix


# I won't be showing you matrix algebra in action during this class (you're
# unlikely to need it outside of introductory exercises and advanced programming)
# But to summarise the available functions:

# + matrix addition
# * multiplication by a scalar
# %*% matrix multiplication
# t() transpose
# solve() inverse
# diag() get the diagonal

# finally, to introduce the relevant logical check:
is.matrix(myMatrix)




## 4.3 data frames ----

#	               | Homogeneous |	Heterogeneous |
# ---------------+-------------+----------------+
# One dimension  |	 Vectors   |	    Lists     |
# Two dimensions |	Matrices	 |	 Data frames  |
# ---------------+-------------+----------------+

# So far, so good. But realistically, we're probably going to have a mix of
# data types in the datasets we're using. This is where the heterogeneous
# data structures come in.

# By far one of the most important in R is the data frame. This is similar to 
# a matrix with the very important exception that its columns can be of different
# data types.

# Another way of thinking of a data frame is that all of its columns are vectors.
# They follow all the same rules as vectors outside of data frames AND they must
# be of the same length.

# They're more than a little reminiscent of excel spreadsheets, data loaded into
# stata, etc.

# We create data frames with the data.frame() function:
?data.frame

n <- 10 # good programming practice: program any constants you're using more than once
mydf <- data.frame(
  var1 = replicate(n, "a"),
  var2 = rnorm(n = n, mean = 0, sd = 1.3),
  var3 = c(1, -4, 2, 4.2, 5.3333, 1/9, 7.5, 0.000, 1-12, sqrt(2)))
mydf

# If putting named objects in, you don't have to (but can) name them:
mydf2 <- data.frame(vec1, vec4)
mydf2


# A brief note on distributions
?rnorm # there are lots of functions for distributions in r
?runif # I won't stop to show more, but if you ever need them they're fairly easy to find!


# Class and a logical test
class(mydf)
is.data.frame(mydf)



# we can use the square brackets in much the same way as with matrices:

mydf[1:3,] # first three rows
mydf[2,2] # second row, second column

# if we ignore the comma, numbers will pull out columns:
mydf[2]

# note we can also use variable names in the brackets:
mydf["var1"]

# However, something important to understand is heterogenous data structures
# have more complex subsetting because they store data of different types.

# Pay attention to all of these outputs:
mydf[2]
mydf[[2]]
is.data.frame(mydf[2]) #this is a data frame with one column
is.data.frame(mydf[[2]]) #this is a vector
is.atomic(mydf[[2]])
is.atomic(mydf[["var1"]])

# In short - just square brackets on its own returns an object of the same
# type as before (data frame). Doubling up pulls out the actual vector.

# Importantly, the doubled-up square bracketes will only work on *one* vector
# at a time!


# importantly, we can access variables by their name using the dollar sign $:
mydf$var2

# we can go a step further and subset from the vectors:
mydf$var2[2] #the 2nd element of the vector var2 inside the data frame mydf

# recoding works as before:
mydf$var1 <- replicate(10, "hello, world!")
mydf$var1
mydf$var1[5] <- "banana bread"
mydf$var1

# we can also add new variables:
mydf$var4 <- 10:1 #this works in reverse!




## 4.4 lists ----

#	               | Homogeneous |	Heterogeneous |
# ---------------+-------------+----------------+
# One dimension  |	 Vectors   |	    Lists     |
# Two dimensions |	Matrices	 |	 Data frames  |
# ---------------+-------------+----------------+

# Lists are a fairly unique data structure in R - at least compared to the others.
# In one way, they're as data frames are to matrices in that they can store
# different data types (this is the 'heterogeneous' part)

# Unlike every other data type in R however, lists don't have to be 'flat'.
# What this means is that they don't just store different data types -
# they also store other data structures, including other lists!

# We can make lists with the list() function:

myList <- list(1, "banana", TRUE, mydf, 1:20)
myList

myList2 <- list(index = 1:11, anotherList = myList)
myList2


# Lists follow the same square bracket notation as other objects:

myList[5]

# but notice that this item is still a list of length one:
is.list(myList[5])
length(myList[5])

# similar to data frames, we need to double up on our square brackets to
# get to the object inside
is.list(myList[[5]])
length(myList[[5]])

# Also similar to data frames, if the stuff inside our list is named, we
# can pull it out by name using the $ operator:
myList2$index
myList2$anotherList


# in fact, here's an 'under the hood' R secret: data frames are really just
# lists of vectors where the vectors have to be the same length:
is.list(mydf)

# if this confuses you, feel free to forget it - at this level it's more fun
# fact than useful information. Later on in your R careers this may be good to
# know however - as it helps explain some of R's quirkier behaviours (like the
# fact that this returns true)!




## 4.5 Coercion ----

# Just like vectors, we can coerce R data structures of one kind to another
# kind, again with varying degrees of success depending on how well they fit
# each other:

# as.matrix()
# as.data.frame()
# as.list()




# Exercises ----

# 1) Create a vector of even numbers ranging from 2 to 100 and store it in
# an object



# 2) Create another vector ranging from 1 to 50 and store it in an object



# 3) Run the below lines of code. Put the 'binary' vector along with the 
# two vectors you just made in a data frame and store it in an object.
set.seed(42)
binary <- rbinom(50, 1, 0.5)



# 4) Filter the data frame you just made for rows where the binary variable is
# equal to 1. Store the output in a new object



# 5) Pull the first vector you made in question 1 out of the object from question 4. 
# Try doing this with both the $ operator and doubled-up square brackets [[]]



