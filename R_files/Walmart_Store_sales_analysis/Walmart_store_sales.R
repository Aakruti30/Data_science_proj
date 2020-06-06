# Walmart store sales 

# Initial work . 
# load the csv file, convert store and holiday flag to factor and date to date format.

WSS <- read.csv("C:\\Users\\Aakruti V\\Documents\\Data Science\\R_files\\Walmart_Store_sales.csv")

head(WSS) 

str(WSS)

WSS$Store <- as.factor(WSS$Store)
WSS$Holiday_Flag <- as.factor(WSS$Holiday_Flag)
WSS$Date <- as.Date(WSS$Date,format = "%d-%m-%Y")
str(WSS)

# ----------------------------------------------------------------------------------------------------------------------
# Basic Analysis tasks 

# 1 . Which store has maximum sales

# approach - calculate the sum of sales for each store and select the store with maximum sale . 
# Used aggregate to get the sum then max function to calculate the ma value . 

df1 <- aggregate(WSS$Weekly_Sales ~ WSS$Store,WSS,sum)

names(df1)[1] = "Store"
names(df1)[2] = "sum_sales"

library(dplyr)
filter(df1, df1$sum_sales == max(df1$sum_sales))

#   Store sum_sales
# 1    20 301397792

# store 20 has max sale of 301397792

# -------------------------------------------------------------------------------------------------------------------------

# 2. Which store has maximum standard deviation i.e., the sales vary a lot. 
# Also, find out the coefficient of mean to standard deviation

# approach - Use group by store and calculate the standard deviation . 
# Check the store with maximum standard deviation . USe aggregate and max . 
# calculate coefficient of mean to std deviation and check the max value . 

df2 <- aggregate(WSS$Weekly_Sales ~ WSS$Store,WSS,sd)
df2


names(df2)[1] = "Store"
names(df2)[2] = "sd_sales"

filter(df2, df2$sd_sales == max(df2$sd_sales))

#   Store sd_sales
# 1    14 317569.9

# store 14 has the max standard deviation of 317569.9

df3 <- aggregate(WSS$Weekly_Sales ~ WSS$Store,WSS,mean)
df3

names(df3)[1] = "Store"
names(df3)[2] = "mean_sales"

colnames(df3)

df4 <- cbind(df2,df3[2])
df4


df4 <- mutate(df4, cv_sales = (df4$sd_sales/df4$mean_sales))
df4

filter(df4, cv_sales == max(df4$cv_sales))

# Store sd_sales mean_sales  cv_sales
# 1    35 211243.5     919725 0.2296811

# store 35 has max coefficient of mean to sd

# -------------------------------------------------------------------------------------------------------------------------------

# 3. Which store has good q3 growth rate in 2012
# Approach - Used lubridate package quarter function to seggregate quarter 2 and quarter 3 records for 2012
# calculated the growth and displayed the stores where the rowth is positive as well the store with max growth 

library(lubridate)

WSS1 <- mutate(WSS,quarter_year = quarter(ymd(WSS$Date),with_year = TRUE))
View(WSS1)

WSS1$quarter_year <- as.factor(WSS1$quarter_year)
str(WSS1)

sum_weekly_sales <- aggregate(WSS1$Weekly_Sales,list(Store = WSS1$Store,quarter_year = WSS1$quarter_year),sum)
sum_weekly_sales

names(sum_weekly_sales)[3] = "sum_sales"

sum_quarter2_sales <- sum_weekly_sales %>% filter(quarter_year == "2012.2") 
sum_quarter2_sales

sum_quarter3_sales <- sum_weekly_sales %>% filter(quarter_year == "2012.3") 
sum_quarter3_sales

a <- cbind(sum_quarter2_sales,sum_quarter3_sales[2:3])
a
colnames(a)[2] = "Quarter_2"
colnames(a)[3] = "sum_quarter_2_sales"
colnames(a)[4] = "Quarter_3"
colnames(a)[5] = "sum_quarter_3_sales"

a <- mutate(a, q3_growth = (a$sum_quarter_3_sales - a$sum_quarter_2_sales)/a$sum_quarter_2_sales)
a

max_growth_rate <- subset(a,a$q3_growth == max(a$q3_growth))
max_growth_rate

# Store Quarter_2 sum_quarter_2_sales Quarter_3 sum_quarter_3_sales q3_growth
# 7     7    2012.2             7290859    2012.3             8262787 0.1333078

good_q3_growth <- filter(a,a$q3_growth >= 0)
good_q3_growth

#     Store Quarter_2 sum_quarter_2_sales Quarter_3 sum_quarter_3_sales   q3_growth
# 1      7    2012.2             7290859    2012.3             8262787 0.133307760
# 2     16    2012.2             6564336    2012.3             7121542 0.084883781
# 3     23    2012.2            18488883    2012.3            18641489 0.008253951
# 4     24    2012.2            17684219    2012.3            17976378 0.016520877
# 5     26    2012.2            13155336    2012.3            13675692 0.039554775
# 6     35    2012.2            10838313    2012.3            11322421 0.044666372
# 7     39    2012.2            20214128    2012.3            20715116 0.024784040
# 8     40    2012.2            12727738    2012.3            12873195 0.011428413
# 9     41    2012.2            17659943    2012.3            18093844 0.024569801
# 10    44    2012.2             4306406    2012.3             4411251 0.024346377

# store 7 has the max growth rate in q3 2012
# stores 7,16,23,24,26,35,39,40,41,44 have positive growth in q3 2012

# ------------------------------------------------------------------------------------------------------------------------

# 4. Some holidays have a negative impact on sales. 
# Find out holidays which have higher sales than the mean sales in non-holiday season for all stores together

# approach - calculated the mean sales for non-holiday dates first . 
# Then grouped the records for holiday dates and compared the values with mean non holiday sale . 

WSS2 <- filter(WSS, WSS$Holiday_Flag == 0) 
WSS2
mean_non_holiday <- mean(WSS2$Weekly_Sales)
mean_non_holiday

# [1] 1041256

WSS3 <- filter(WSS,WSS$Holiday_Flag == 1)
WSS3

sum_sales <- aggregate(WSS3$Weekly_Sales, list(Date = WSS3$Date),sum)
colnames(sum_sales)[2] = "sum_hol_sale"
sum_sales

sales <- mutate(sum_sales, greater_mean = sum_sales$sum_hol_sale > mean_non_holiday)
sales


sales$holiday <- ifelse(month(ymd(sales$Date)) == 2, 'Super bowl',
                        ifelse(month(ymd(sales$Date)) == 9, 'Labour',
                               ifelse(month(ymd(sales$Date)) == 11, 'Thanksgiving', 'Christmas')))
                                      
sales

#       Date      sum_hol_sale greater_mean      holiday
# 1  2010-02-12     48336678         TRUE     Super bowl
# 2  2010-09-10     45634398         TRUE       Labour
# 3  2010-11-26     65821003         TRUE   Thanksgiving
# 4  2010-12-31     40432519         TRUE     Christmas
# 5  2011-02-11     47336193         TRUE     Super bowl
# 6  2011-09-09     46763228         TRUE       Labour
# 7  2011-11-25     66593605         TRUE   Thanksgiving
# 8  2011-12-30     46042461         TRUE     Christmas
# 9  2012-02-10     50009408         TRUE     Super bowl
# 10 2012-09-07     48330059         TRUE       Labour

# all holiday dates have greater sales than mean sales in non-holiday season

sum_hol_sales <- aggregate(sales$sum_hol_sale, list(holiday = sales$holiday),sum)

colnames(sum_hol_sales)[2] = "sum_holiday_sale"
sum_hol_sales


sum_hol_sales <- mutate(sum_hol_sales, greater_mean = sum_hol_sales$sum_holiday_sale > mean_non_holiday)
sum_hol_sales

#      holiday      sum_holiday_sale greater_mean
# 1    Christmas         86474980         TRUE
# 2       Labour        140727685         TRUE
# 3   Super bowl        145682278         TRUE
# 4 Thanksgiving        132414609         TRUE

# All holidays have greater sales than the mean sales in non holiday season

# -----------------------------------------------------------------------------------------------------------------------------

# 5. Provide a monthly and semester view of sales in units and give insights

# approach - Used the month , 
# year and semester methods from lubridate package to calculate the monthly and semester view 

WSS4 <- mutate(WSS,month.year = paste(month(ymd(WSS$Date)),year(ymd(WSS$Date)),sep = "."))
str(WSS4)
View(WSS4)               

monthly_sale <- aggregate(WSS4$Weekly_Sales,list(month.year = WSS4$month.year),sum)
names(monthly_sale)[2] = "month_sale"
monthly_sale

#     month.year month_sale
# 1      1.2011  163703967
# 2      1.2012  168894472
# 3     10.2010  217161824
# 4     10.2011  183261283
# 5     10.2012  184361680
# 6     11.2010  202853370
# 7     11.2011  210162355
# 8     12.2010  288760533
# 9     12.2011  288078102
# 10     2.2010  190332983
# 11     2.2011  186331328
# 12     2.2012  192063580
# 13     3.2010  181919803
# 14     3.2011  179356448
# 15     3.2012  231509650
# 16     4.2010  231412368
# 17     4.2011  226526511
# 18     4.2012  188920906
# 19     5.2010  186710934
# 20     5.2011  181648158
# 21     5.2012  188766479
# 22     6.2010  192246172
# 23     6.2011  189773385
# 24     6.2012  240610329
# 25     7.2010  232580126
# 26     7.2011  229911399
# 27     7.2012  187509452
# 28     8.2010  187640111
# 29     8.2011  188599332
# 30     8.2012  236850766
# 31     9.2010  177267896
# 32     9.2011  220847738
# 33     9.2012  180645544

filter(monthly_sale, month_sale == max(monthly_sale$month_sale))

#    month.year month_sale
# 1    12.2010  288760533

WSS4 <- mutate(WSS4,sem.year = paste(semester(ymd(WSS4$Date)),year(ymd(WSS4$Date)),sep = "."))
str(WSS4)

semester_sales <- aggregate(WSS4$Weekly_Sales,list(sem.year = WSS4$sem.year),sum)
names(semester_sales)[2] = "sem_sales"
semester_sales

#    sem.year  sem_sales
# 1   1.2010  982622260
# 2   1.2011 1127339797
# 3   1.2012 1210765416
# 4   2.2010 1306263860
# 5   2.2011 1320860210
# 6   2.2012  789367443

filter(semester_sales, sem_sales == max(semester_sales$sem_sales))

#    sem.year  sem_sales
# 1   2.2011 1320860210

# December 2010 has max monthly sale and second semester of 2011 has max semester sale
# -----------------------------------------------------------------------------------------------------------------------

# Statistical Model
# 
# For Store 1 - Build  prediction models to forecast demand
# 
# Linear Regression - Utilize variables like date and restructure dates as 1 for 5 Feb 2010 (starting from the earliest date in order). Hypothesize if CPI, unemployment, and fuel price have any impact on sales.
# 
# Change dates into days by creating new variable.
# 
# Select the model which gives best accuracy.

# get store 1 records

store_1 <- subset(WSS, WSS$Store == 1)
str(store_1)
View(store_1)

# convert dates into days by creating new column 
# restructure dates as 1 for 5 Feb 2010 (starting from the earliest date in order) 

store_1 <- mutate(store_1, Day = yday(Date - yday(Date - 1)[1]))
head(store_1)

#     Store       Date Weekly_Sales Holiday_Flag Temperature Fuel_Price      CPI Unemployment Day
# 1     1 2010-02-05      1643691            0       42.31      2.572 211.0964        8.106   1
# 2     1 2010-02-12      1641957            1       38.51      2.548 211.2422        8.106   8
# 3     1 2010-02-19      1611968            0       39.93      2.514 211.2891        8.106  15
# 4     1 2010-02-26      1409728            0       46.63      2.561 211.3196        8.106  22
# 5     1 2010-03-05      1554807            0       46.50      2.625 211.3501        8.106  29
# 6     1 2010-03-12      1439542            0       57.79      2.667 211.3806        8.106  36

summary(store_1)

#----------------------------------------------------------------------------------------------------------------------------------

# multiple linear regression

pred_sales <- lm(Weekly_Sales ~ CPI + Unemployment + Fuel_Price, store_1)
predict_sales <- predict(pred_sales,store_1)

R_squared <- summary(pred_sales)$r.squared
R_squared  # 0.08498556

library(Metrics)
RMSE <- rmse(store_1$Weekly_Sales,predict_sales)
RMSE  # 148683

summary(pred_sales)

# Call:
#   lm(formula = Weekly_Sales ~ CPI + Unemployment + Fuel_Price, 
#      data = store_1)
# 
# Residuals:
#   Min      1Q  Median      3Q     Max 
# -287777  -86699  -23987   61849  882877 
# 
# Coefficients:
#   Estimate Std. Error t value Pr(>|t|)   
# (Intercept)  -3887096    1740276  -2.234  0.02711 * 
#   CPI             21792       6785   3.212  0.00164 **
#   Unemployment   124064      58779   2.111  0.03659 * 
#   Fuel_Price     -64838      46842  -1.384  0.16851   
# ---
#   Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
# 
# Residual standard error: 150800 on 139 degrees of freedom
# Multiple R-squared:  0.08499,	Adjusted R-squared:  0.06524 
# F-statistic: 4.303 on 3 and 139 DF,  p-value: 0.006162


# Comparing the p-value of CPI , Unemployment and Fuel price with alpha(0.05) , we can say that 
# CPI and Unemployment have an impact on sales . Fuel_price does not impact sales . 
# R squared value for the model is very low hence this is not a good model . 
# ------------------------------------------------------------------------------------------------------

