setwd("C:/Users/Philmen/Desktop/MMU/Data Mining/Assignment/Part 2")
install.packages('arulesViz')
library(arules)
library(arulesViz)

help("read.transactions")
x <- read.transactions(file = "1000-out1.csv", format = "basket", sep = "," , cols = 1) 
inspect(x)
summary(x)


help("apriori")
rules <- apriori(x) # <-- No Rules found play with the support/Conf

#Apriori + Timemesure 
start.time <- Sys.time()
rules <- apriori(x, parameter=list(support=0.03, confidence=0.7))
end.time <- Sys.time()
time.taken <- end.time - start.time
time.taken

rules
summary(rules)
inspect(rules)
rules.sorted <- sort(rules,by="support")
inspect(rules.sorted)

#Redundant Rules 
subset.matrix <- is.subset(rules.sorted,rules.sorted)
subset.matrix[lower.tri(subset.matrix, diag = T)] <- NA
redundant <- colSums(subset.matrix, na.rm = T) >= 1
which(redundant)
rules.pruned <- rules.sorted[!redundant]
inspect(rules.pruned)

#Plot the rules

plot(rules)
plot(rules, method='grouped')
plot(rules, method='graph')
