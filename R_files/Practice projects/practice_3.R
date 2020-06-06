Retail.Data <- read.csv("RetailScoreData.csv")
View(Retail.Data)

# Mean 
M1 <- mean(Retail.Data$creddebt)
M1
M2 <- mean(Retail.Data$othdebt)
M2

#Median
M3 <- median(Retail.Data$creddebt)
M3
M4 <- median(Retail.Data$othdebt)
M4

# Round of the elements in vector ‘total.debt’ in multiples of tens
Retail.Data$totaldebt <- Retail.Data$creddebt + Retail.Data$othdebt
library(plyr)
round_any(Retail.Data$totaldebt,10)

#Paste the elements of the two vectors, ‘credit.debt’ and ‘other.debt’ using separator “,”. 
paste(Retail.Data$creddebt,Retail.Data$othdebt,sep = ',')

# Create a data.frame ‘Retail.3779 with all the observations where ncust is 3779
Reatil.3779 <- subset(Retail.Data,Retail.Data$ncust=='3779')
Reatil.3779

# Sort the data.frame ‘Retail.3779’ in the decreasing order of variable ‘age’ and assign it to  
# Retail.3779.sort.  

Retail.3779.sort <- Reatil.3779[order(-Reatil.3779$age),]
Retail.3779.sort

# See how many observations in ‘Retail.3779’ are employed for more than 10 years

Retail.emp <- subset(Reatil.3779,Reatil.3779$employ>=10)
Retail.emp
nrow(Retail.emp)

# Find the mean of all observations in ‘Retail.data’ in variables ‘creddebt’ and ‘othdebt’  
# grouped by ‘ncust’. 

aggregate(Retail.Data$creddebt,list(ncust=Retail.Data$ncust),mean)
aggregate(Retail.Data$othdebt,list(ncust=Retail.Data$ncust),mean)

