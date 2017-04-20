# Convert econometrics -
# linear modeling

data(mtcars)


mod = lm(mpg ~ cyl, data = mtcars)

summary(mod)

library(scatterplot3d) 
attach(mtcars) 
scatterplot3d(wt,disp,mpg, pch=16, highlight.3d=TRUE,
  type="h", main="3D Scatterplot")

