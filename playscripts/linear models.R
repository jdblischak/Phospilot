n <- 200
X <- cbind(rep(1, n), rep(0:1, each = n/2))
Xsm <- cbind(rep(1, 2), 0:1)
beta <- c(5, 3)
y <- rnorm(n, mean = X %*% beta, sd = 1)#matrix mult here. 1/2 draws have a mean 5 and other half 8
nms <- c("A", "B")

# Plot the data y, and the group means as thick lines.
par(cex = 1.5)
plot(y, xaxt = "n", xlab = "groups", ylab = "observations")
axis(1, at = 0:1 * 100 + 50, labels = nms)
mus <- Xsm %*% beta
segments(1 + 0:1 * 100, mus, 1:2 * 100, mus, lwd = 5)


# Three group model

n <- 300
X <- cbind(rep(1, n), rep(c(0, 1, 0), each = n/3), rep(c(0, 0, 1), each = n/3))
Xsm <- cbind(c(1, 1, 1), c(0, 1, 0), c(0, 0, 1))
beta <- c(5, 3, -1)
y <- rnorm(n, mean = X %*% beta, sd = 1)
nms <- c("A", "B", "C")

# Plot the data y, and the group means as thick lines.

par(cex = 1.5)
plot(y, xaxt = "n", xlab = "groups", ylab = "observations")
axis(1, at = 0:2 * 100 + 50, labels = nms)
mus <- Xsm %*% beta
segments(1 + 0:2 * 100, mus, 1:3 * 100, mus, lwd = 5)


# Make some random data in a 2 by 2 crossed design.

n <- 400
X <- cbind(rep(1, n), rep(0:1, each = n/2), rep(rep(0:1, each = n/4), 2))
Xsm <- cbind(rep(1, 4), rep(0:1, each = 2), rep(0:1, 2))
beta <- c(5, 3, 7)
y <- rnorm(n, mean = X %*% beta, sd = 1)
nms <- c("A", "B", "C", "D")

# Plot the data y, and the group means as thick lines.

par(cex = 1.5)
plot(y, xaxt = "n", xlab = "groups", ylab = "observations")
axis(1, at = 0:3 * 100 + 50, labels = nms)
mus <- Xsm %*% beta
segments(1 + 0:3 * 100, mus, 1:4 * 100, mus, lwd = 5)

# Now add an interaction term as a fourth column of the matrix X.

Xi <- cbind(X, X[, 2] * X[, 3])
Xism <- cbind(Xsm, Xsm[, 2] * Xsm[, 3])
betai <- c(5, 3, 7, 4)
yi <- rnorm(n, mean = Xi %*% betai, sd = 1)

# Again, plot the data and the group means.

par(cex = 1.5)
plot(yi, xaxt = "n", xlab = "groups", ylab = "observations")
axis(1, at = 0:3 * 100 + 50, labels = nms)
musi <- Xism %*% betai
segments(1 + 0:3 * 100, musi, 1:4 * 100, musi, lwd = 5)
segments(301, musi[4] - betai[4], 400, musi[4] - betai[4], lwd = 4, lty = 3)



