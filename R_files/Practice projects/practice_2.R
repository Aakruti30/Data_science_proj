# question 1

numvec <- c(2,5,8,9,0,6,7,8,4,5,7,11) 
charvec <- c("David","James","Sara","Tim","Pierre","Janice","Sara","Priya","Keith", "Mark", "Apple", "Sara") 
gender <- c("M","M","F","M","M","M","F","F","F","M","M","F") 
state <- c("CO","KS","CA","IA","MO","FL","CA","CO","FL","CA","WY","AZ") 

df1 <- data.frame(numvec,charvec,gender,state)
df1

df2 <- subset(df1,numvec<=5)
df2

df3 <- subset(df1,charvec=="Sara")
df3

df4 <- subset(df1,numvec==5,select=c("charvec","state"))
df4

df5 <- subset(df1,charvec != "Sara" & gender == "F" & numvec > 5 )
df5

# question 2

df6 <- data.frame(gender = rep(c("M","F"),times = 5),Age = c(22,35,43,52,58,23,36,46,39,31))
df6

coffee <- c(3, 1, 2, 5, 0, 2, 0, 1, 3, 2) 
df6 <- data.frame(df6,coffee)
df6

df7 <- df6[,2]
df7

df8 <- df6[c(1,3,8),]
df8
