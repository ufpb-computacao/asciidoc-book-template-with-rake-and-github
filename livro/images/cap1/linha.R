gnp <- ts(cumsum(1 + round(10*rnorm(100), 2)), start = c(2005, 7), frequency = 12)
plot(gnp,xlab="Período",ylab="Rendimento") # using 'plot.ts' for time-series plot

