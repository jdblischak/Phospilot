# Here I am making a formula f which will help me make make a design matrix for linear modeling applications. 
# I want to compare four samples with assignment into two groups.

# The first example can be used for a comparison of the means between two groups

# in order to produce design matrices (also known as model matrices) for a variety of linear models.
# 
# The choice of design matrix is a critical step in linear modeling as it encodes which coefficients will be fit in the model, and the inter-relationship between the samples.
# 
# The very simplest design matrix is a column of 1's, where a single coefficient is fit for all the samples, called the Intercept. For standard linear modeling, this fitted coefficient will just be the average of the y values, e.g., the log expression values for all samples.
# 
# However, the design matrices we typically work with have at least two columns: an intercept column as before which consists of a column of 1's, and a second column which species which samples are in a second group. In this case, two coefficients are fit in the linear model: the intercept, which captures the base level of the first group, and a second coefficient which captures the difference between the second group and the first group. This is typically the coefficient we are interested in for performing statistical testing: we want to know if difference between the two groups is zero or not.
# 
# We encode this experimental design in R by first specifying a variable which tells us which samples are in which group, and then using the 'tilde' symbol, ~, to say that the y values should be modeled using this variable.
# 
# Suppose we have two groups, 1 and 2, with two samples each. We might start to encode this experimental design like so:


x <- c(1,1,2,2)
f <- formula(~ x) #or x +1 to add a constant (see below as this is automatically added by the model matrix function)
f
model.matrix(f)
model.matrix(~x)


# Note that the "intercept" is automatically included and I could have written ~x +1
# Note, this is not the design matrix we wanted, and the reason is that we provided a numeric variable to the formula and model.matrix functions, without saying that these numbers actually referred to different groups.
# 
# We should instead first tell R that these values should not be interpreted numerically, but as different levels of a factor variable:
x <- factor(c(1,1,2,2))
model.matrix(~ x)

# Note that the constrasts attribute was not assigned correctly in the first model.matrix call

# Here is an example for three groups

x <- factor(c(1,1,2,2,3,3))
model.matrix(~ x)

# I can make the third gruoup explicit

model.matrix(~ x +0)

# This group now fits a separate coefficient for each group. In order to compare the levels to each other, we need to use some additional steps, which is called the construction of contrasts. These are covered in the limma package vignette for microarray analysis with multiple groups.

# I can simply add additional variables with a + sign, in order to build a design matrix which fits based on the information in additional variables:

x <- factor(c(1,1,1,1,2,2,2,2))
y <- factor(c("a","a","b","b","a","a","b","b"))
model.matrix(~ x + y)

# Note the 'attr(,"assign")' has a 0,1,2

# We could say that this linear model accounts for differences in both the x and y variables.
# 
# We assume in the above model specification, that the effect of the x and y variables are simply additive. Being in group 2 and group b is equal to the difference between 2 and 1 and the difference between b and a.
# 
# Another model is possible which fits and additional term, which encodes the potential interaction of x and y variables. This can be written in either of the following two formula:

model.matrix(~ x + y + x:y)

# I think the message above is meant to imply an additive/independent model. Whereas the last statement includes an interaction term. This means that the effects are not independent right? This is equivalent to 

model.matrix(~x*y)




# ********************************************************************

# Releveling
# 
# The level which is chosen for the base level, i.e., the level which is contrasted against, is simply the first level alphabetically. We can specify that we want group 2 to be the base level by either using the relevel function, or by providing the levels explicitly in the factor call:


x <- factor(c(1,1,2,2))
model.matrix(~ x)

x <- relevel(x,"2")
model.matrix(~ x)

x <- factor(x, levels=c("1","2"))#not sure what this does
model.matrix(~x)


# This can be used to identify the proper control sample in a series of comparisons


# ***********************************************************************

# Numeric variables
# 
# In the beginning of this lab, we assumed that we didn't want to encode the variable as a numeric, but in certain designs we might be interested in using numeric variables in the design formula, not converting them to a factor first. For example, we could be interested in testing various dosage of a treatment, where we expect a specific relationship between log gene expression and the dosage, e.g. 0 mg, 10mg, 20mg. Here we show how to encode a numeric variable: a linear model with an intercept, without an intercept, and additionally as a quadratic relationship.

z <- 1:4
model.matrix(~ z)
model.matrix(~ 0 + z)
model.matrix(~ z + I(z^2))

# The I function above is necessary to specify a mathematical transformation of a variable. See ?I for more information.

# Where does model.matrix look for the data?
# 
# Finally, notice that the model.matrix function will grab the variable from the R environment, unless the data is explicitly provided in the data argument:


x <- 1:4
model.matrix(~ x)


model.matrix(~ x, data=data.frame(x=5:8))
