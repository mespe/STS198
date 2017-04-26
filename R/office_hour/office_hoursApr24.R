library(plot3D)

par(mfrow = c(2, 2), mar = c(0, 0, 0, 0))
# Shape 1
M <- mesh(seq(0, 6*pi, length.out = 80),
          seq(pi/3, pi, length.out = 80))
u <- M$x
v <- M$y
x <- u/2 * sin(v) * cos(u)
y <- u/2 * sin(v) * sin(u)
z <- u/2 * cos(v)
surf3D(x, y, z, colvar = z, colkey = FALSE, box = FALSE)
# Shape 2: add border
M <- mesh(seq(0, 2*pi, length.out = 80),
seq(0, 2*pi, length.out = 80))
u <- M$x ; v <- M$y
x <- sin(u)
y <- sin(v)
z <- sin(u + v)
surf3D(x, y, z, colvar = z, border = "black", colkey = FALSE)
# shape 3: uses same mesh, white facets
x <- (3 + cos(v/2)*sin(u) - sin(v/2)*sin(2*u))*cos(v)
y <- (3 + cos(v/2)*sin(u) - sin(v/2)*sin(2*u))*sin(v)

################################################################################

l
