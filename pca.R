# $B@55,2=!&<g@.J,J,@O$r9T$&%W%m%0%i%`(B
# 2016/4/2
frame()

labels <- c('Before Normalization', 'After Normalization', 'After PCA')
cols <- c('red','blue','black')

x1 <- c(1,4)
x2 <- c(11,4)
x3 <- c(1,2)
x4 <- c(11,2)

X <- cbind(x1, x2, x3, x4)

# $B@55,2=A0$K%W%m%C%H$9$k(B
maxX <- max(abs(X[1,]))
maxY <- max(abs(X[2,]))
maximum <- if(maxX > maxY) maxX else maxY
plot(X[1,],X[2,],xlim=c(-maximum, maximum),ylim=c(-maximum, maximum),pch=16,col=cols[1],cex=2)
cat('X\n')
print(X)

# $B@55,2=(B($BJ?6Q(B0, $BJ,;6(B1)
cat('normalMatrix\n')
print(normalMatrix(X))
Y <- normalMatrix(deviation(X)) %*% deviation(X)
points(Y[1,], Y[2,], pch=16, col=cols[2], cex=2)
cat('Y\n')
print(Y)

# $BJ,;66&J,;69TNs(B
cat('Variance Covariance Matrix\n')
vcm = varCovMatrix(Y)
print(vcm)

# $BAj4X78?t$r5a$a$k(B
cat('\n################\n')
cat('Correlation[%]\n')
correlation <- vcm[1,2]^2 / (vcm[1,1]*vcm[2,2]) * 100
print(correlation)
cat('################\n\n')

# $BBh0l<g@.J,$N8GM-%Y%/%H%k$r<h$j=P$9(B
# $B@55,2=$5$l$F$$$l$P!"8GM-CM(B($B&K(B=1$B!^(Ba)(a:$B6&J,;6(B), $B8GM-%Y%/%H%k(B(1,$B!^(B1)
vec <- eigen(vcm)[[2]][,1]
if(sign(vec[1])==-1 && sign(vec[2])==-1) vec = -vec
tilt <- if(vec[1] != 0) vec[2]/vec[1] else 0
invtilt <- 1/tilt
abline(0, tilt)
cat('eigen\n')
print(eigen(vcm))

# $B<g@.J,J,@O$r9T$$!"0l<!85$K$9$k(B
Z <- t(vec) %*% Y
cat('Z\n')
print(Z)
x <- (1/sqrt(1+tilt^2))*Z
y <- (1/sqrt(1+invtilt^2))*Z
if(sign(vec[1]*vec[2])==-1) if(sign(vec[1])==1) y = -y else x = -x
cat('x\n')
print(x)
cat('y\n')
print(y)
points(x, y, pch=16, col=cols[3], cex=2)

legend('topleft', legend=labels, col=cols, pch=16)

