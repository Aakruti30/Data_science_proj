# question 1 - Create a vector ‘vec1’ and ‘vec2’ with elements 1 to 15 and 115 to 101. 

vec1 <- c(1:15)
vec2 <- c(115:101)
vec1
vec2

# question 2 - Create a vector ‘vec3’ of the sum of the log values of vec1 and vec2 in one argument and 
# print the result. 

vec3 <- log(vec1)+log(vec2)
vec3

# question 3 - Print the 7th element in vec2. 

vec2[7]

# question 4 - Create matrix ‘mat1’ by combining the vec1 and vec2 column wise

mat1 <- cbind(vec1,vec2)
mat1

# question 5 - Change the dimensions of mat1 to 5 x 6 and print mat1. 

mat1 <- matrix(mat1,nrow = 5,ncol = 6)
mat1

# question 6 - Generate a 5 x 5 matrix ‘mat2’ with elements 1:5 in the diagonal and other elements being 0

mat2 <- diag(1:5,nrow = 5,ncol = 5)
mat2

# question 7 - Add another column of elements 6:10 in mat2, making it 5 x 6 matrix. 

mat2 <- cbind(mat2,6:10)
mat2

# question 8 - Print the values of 4th column of mat2

mat2[,4]

# question 9 - Find which elements in mat2 are greater than or equal to 5. 
greaterthan5 <- mat2[mat2>=5]
greaterthan5

# question 10 - Create the vectors: 

# a - (1, 2, 3, . . . , 19, 20) 
v1 <- c(1:20)
v1

# b - (20, 19, . . . , 2, 1) 
v2 <- c(20:1)
v2

# c - (1, 2, 3, . . . , 19, 20, 19, 18, . . . , 2, 1) 
v3 <- c(v1,v2[2:20])
v3

# d - (4, 6, 3) and assign it to the name tmp
tmp <- c(4,6,3)

# e - (4, 6, 3, 4, 6, 3, . . . , 4, 6, 3) where there are 10 occurrences of 4. 
rep(tmp,times =10)

# f - (4, 6, 3, 4, 6, 3, . . . , 4, 6, 3, 4) where there are 11 occurrences of 4, 10 occurrences of 6 and 10 occurrences of 3. 
rep(tmp,times =10,length=31)

# g - (4, 4, . . . , 4, 6, 6, . . . , 6, 3, 3, . . . , 3) where there are 10 occurrences of 4, 20 occurrences of 6 and 30 occurrences of 3. 
rep(tmp,times=c(10,20,30))
