# Problem Set 3
Nicolas  
February 17, 2016  

Problem Set 3 : Diamonds
========================================================

***

### Loading the dataset


```r
library(ggplot2)
getwd()
```

```
## [1] "C:/Users/Nicolas/Desktop/Projets Tech/Data Analysis with R/Lesson 3"
```

```r
setwd('C:/Users/Nicolas/Desktop/Projets Tech/Data Analysis with R/Lesson 3')
list.files()
```

```
## [1] "birthdaysExample.csv"       "Electricity Generation.csv"
## [3] "Lesson 3.rmd"               "Lesson_3.html"             
## [5] "Lesson_3.md"                "Lesson_3_files"            
## [7] "Problem Set 3.rmd"          "Problem_Set_3.rmd"         
## [9] "pseudo_facebook.tsv"
```

```r
data(diamonds)
summary(diamonds)
```

```
##      carat               cut        color        clarity     
##  Min.   :0.2000   Fair     : 1610   D: 6775   SI1    :13065  
##  1st Qu.:0.4000   Good     : 4906   E: 9797   VS2    :12258  
##  Median :0.7000   Very Good:12082   F: 9542   SI2    : 9194  
##  Mean   :0.7979   Premium  :13791   G:11292   VS1    : 8171  
##  3rd Qu.:1.0400   Ideal    :21551   H: 8304   VVS2   : 5066  
##  Max.   :5.0100                     I: 5422   VVS1   : 3655  
##                                     J: 2808   (Other): 2531  
##      depth           table           price             x         
##  Min.   :43.00   Min.   :43.00   Min.   :  326   Min.   : 0.000  
##  1st Qu.:61.00   1st Qu.:56.00   1st Qu.:  950   1st Qu.: 4.710  
##  Median :61.80   Median :57.00   Median : 2401   Median : 5.700  
##  Mean   :61.75   Mean   :57.46   Mean   : 3933   Mean   : 5.731  
##  3rd Qu.:62.50   3rd Qu.:59.00   3rd Qu.: 5324   3rd Qu.: 6.540  
##  Max.   :79.00   Max.   :95.00   Max.   :18823   Max.   :10.740  
##                                                                  
##        y                z         
##  Min.   : 0.000   Min.   : 0.000  
##  1st Qu.: 4.720   1st Qu.: 2.910  
##  Median : 5.710   Median : 3.530  
##  Mean   : 5.735   Mean   : 3.539  
##  3rd Qu.: 6.540   3rd Qu.: 4.040  
##  Max.   :58.900   Max.   :31.800  
## 
```

```r
?diamonds       # help on the dataset
```

```
## starting httpd help server ...
```

```
##  done
```

```r
str(diamonds)   # structure of an object
```

```
## Classes 'tbl_df', 'tbl' and 'data.frame':	53940 obs. of  10 variables:
##  $ carat  : num  0.23 0.21 0.23 0.29 0.31 0.24 0.24 0.26 0.22 0.23 ...
##  $ cut    : Ord.factor w/ 5 levels "Fair"<"Good"<..: 5 4 2 4 2 3 3 3 1 3 ...
##  $ color  : Ord.factor w/ 7 levels "D"<"E"<"F"<"G"<..: 2 2 2 6 7 7 6 5 2 5 ...
##  $ clarity: Ord.factor w/ 8 levels "I1"<"SI2"<"SI1"<..: 2 3 5 4 2 6 7 3 4 5 ...
##  $ depth  : num  61.5 59.8 56.9 62.4 63.3 62.8 62.3 61.9 65.1 59.4 ...
##  $ table  : num  55 61 65 58 58 57 57 55 61 61 ...
##  $ price  : int  326 326 327 334 335 336 336 337 337 338 ...
##  $ x      : num  3.95 3.89 4.05 4.2 4.34 3.94 3.95 4.07 3.87 4 ...
##  $ y      : num  3.98 3.84 4.07 4.23 4.35 3.96 3.98 4.11 3.78 4.05 ...
##  $ z      : num  2.43 2.31 2.31 2.63 2.75 2.48 2.47 2.53 2.49 2.39 ...
```


***

## Create a histogram of the price of
## all the diamonds in the diamond data set.


```r
qplot(data = diamonds, price)
```

```
## `stat_bin()` using `bins = 30`. Pick better value with `binwidth`.
```

![](Problem_Set_3_files/figure-html/unnamed-chunk-2-1.png)

```r
summary(diamonds$price)
```

```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##     326     950    2401    3933    5324   18820
```

***

## Diamonds counts


```r
dim( subset(diamonds, price < 500) )
```

```
## [1] 1729   10
```

```r
dim( subset(diamonds, price < 250) )
```

```
## [1]  0 10
```

```r
dim( subset(diamonds, price >= 15000) )
```

```
## [1] 1656   10
```

***

## Explore the histogram of the price


```r
qplot(data = diamonds, price, binwidth = 20) +
  scale_x_continuous(limits = c(300, 1500),
                     breaks = seq(300, 1500, 100))
```

```
## Warning: Removed 33930 rows containing non-finite values (stat_bin).
```

```
## Warning: Removed 2 rows containing missing values (geom_bar).
```

![](Problem_Set_3_files/figure-html/unnamed-chunk-4-1.png)

```r
ggsave('priceHistogram.png')
```

```
## Saving 7 x 5 in image
```

```
## Warning: Removed 33930 rows containing non-finite values (stat_bin).

## Warning: Removed 2 rows containing missing values (geom_bar).
```

***

## Explore the histogram of the price, by cut


```r
qplot(data = diamonds, price, binwidth = 20) +
  scale_x_continuous(limits = c(300, 15000),
                     breaks = seq(300, 15000, 1000)) +   
  facet_wrap(~cut, ncol = 1)   
```

```
## Warning: Removed 1655 rows containing non-finite values (stat_bin).
```

```
## Warning: Removed 10 rows containing missing values (geom_bar).
```

![](Problem_Set_3_files/figure-html/unnamed-chunk-5-1.png)

```r
# display the max price per cut
by(diamonds$price, diamonds$cut, max) 
```

```
## diamonds$cut: Fair
## [1] 18574
## -------------------------------------------------------- 
## diamonds$cut: Good
## [1] 18788
## -------------------------------------------------------- 
## diamonds$cut: Very Good
## [1] 18818
## -------------------------------------------------------- 
## diamonds$cut: Premium
## [1] 18823
## -------------------------------------------------------- 
## diamonds$cut: Ideal
## [1] 18806
```

```r
max( by(diamonds$price, diamonds$cut, max) )
```

```
## [1] 18823
```

```r
# display the min price per cut
by(diamonds$price, diamonds$cut, min)
```

```
## diamonds$cut: Fair
## [1] 337
## -------------------------------------------------------- 
## diamonds$cut: Good
## [1] 327
## -------------------------------------------------------- 
## diamonds$cut: Very Good
## [1] 336
## -------------------------------------------------------- 
## diamonds$cut: Premium
## [1] 326
## -------------------------------------------------------- 
## diamonds$cut: Ideal
## [1] 326
```

```r
min( by(diamonds$price, diamonds$cut, min) )
```

```
## [1] 326
```

```r
# display the median price per cut
by(diamonds$price, diamonds$cut, median)
```

```
## diamonds$cut: Fair
## [1] 3282
## -------------------------------------------------------- 
## diamonds$cut: Good
## [1] 3050.5
## -------------------------------------------------------- 
## diamonds$cut: Very Good
## [1] 2648
## -------------------------------------------------------- 
## diamonds$cut: Premium
## [1] 3185
## -------------------------------------------------------- 
## diamonds$cut: Ideal
## [1] 1810
```

```r
min( by(diamonds$price, diamonds$cut, median) )
```

```
## [1] 1810
```


***

## Histogram of the price, by cut - with free scale on y-axis


```r
qplot(data = diamonds, price, binwidth = 20) +
  scale_x_continuous(limits = c(300, 15000),
                     breaks = seq(300, 15000, 1000)) +   
  facet_wrap(~cut, ncol = 1, scales = 'free_y')   
```

```
## Warning: Removed 1655 rows containing non-finite values (stat_bin).
```

```
## Warning: Removed 10 rows containing missing values (geom_bar).
```

![](Problem_Set_3_files/figure-html/unnamed-chunk-6-1.png)


***

## Histogram of the price/carat, by cut - with free scale on y-axis


```r
qplot(data = diamonds, x = price/carat, binwidth = 0.05) +
  scale_x_log10() +
  facet_wrap(~cut, ncol = 1, scales = 'free_y')   
```

![](Problem_Set_3_files/figure-html/unnamed-chunk-7-1.png)

***

## Investigate the price of diamonds using box plots,
## numerical summaries, and one of the following categorical
## variables: cut, clarity, or color.


```r
qplot(data = diamonds, x = cut, y = price, 
      geom = 'boxplot')   
```

![](Problem_Set_3_files/figure-html/unnamed-chunk-8-1.png)

```r
qplot(data = diamonds, x = clarity, y = price, 
      geom = 'boxplot')   
```

![](Problem_Set_3_files/figure-html/unnamed-chunk-8-2.png)

```r
qplot(data = diamonds, x = color, y = price, 
      geom = 'boxplot')   
```

![](Problem_Set_3_files/figure-html/unnamed-chunk-8-3.png)


***

## Interquartile (IQR)


```r
# returns the summary per color
by(diamonds$price, diamonds$color, summary)
```

```
## diamonds$color: D
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##     357     911    1838    3170    4214   18690 
## -------------------------------------------------------- 
## diamonds$color: E
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##     326     882    1739    3077    4003   18730 
## -------------------------------------------------------- 
## diamonds$color: F
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##     342     982    2344    3725    4868   18790 
## -------------------------------------------------------- 
## diamonds$color: G
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##     354     931    2242    3999    6048   18820 
## -------------------------------------------------------- 
## diamonds$color: H
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##     337     984    3460    4487    5980   18800 
## -------------------------------------------------------- 
## diamonds$color: I
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##     334    1120    3730    5092    7202   18820 
## -------------------------------------------------------- 
## diamonds$color: J
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##     335    1860    4234    5324    7695   18710
```

```r
# returns the IQR (3rd quart - 1rd quart = 75% - 25%) of price for best color
IQR(subset(diamonds, color == 'D')$price)
```

```
## [1] 3302.5
```

```r
# returns the IQR of price for worst color
IQR(subset(diamonds, color == 'J')$price)
```

```
## [1] 5834.5
```

***

## Investigate the price per carat of diamonds across
## the different colors of diamonds using boxplots.

Note: color doesnt affect very much the price/carat


```r
qplot(data = diamonds, x = color, y = price/carat, 
      geom = 'boxplot') 
```

![](Problem_Set_3_files/figure-html/unnamed-chunk-10-1.png)

***

## Investigate the weight of the diamond (carat) using a frequency polygon


```r
qplot(data = diamonds, x = carat, binwidth = 0.007, 
      geom = 'freqpoly') +
  scale_x_continuous(limits = c(0, 1.5),
                     breaks = seq(0, 1.5, 0.1)) 
```

```
## Warning: Removed 5442 rows containing non-finite values (stat_bin).
```

```
## Warning: Removed 3 rows containing missing values (geom_path).
```

![](Problem_Set_3_files/figure-html/unnamed-chunk-11-1.png)

***

## Data munging or data wrangling

tidyr -a package that reshapes the layout of your data

dplyr - a package that helps you transform tidy, tabular data

***

## Gapminder Data : Energy use in the world, per person

#Loading data


```r
list.files()
```

```
##  [1] "birthdaysExample.csv"       "Electricity Generation.csv"
##  [3] "Lesson 3.rmd"               "Lesson_3.html"             
##  [5] "Lesson_3.md"                "Lesson_3_files"            
##  [7] "priceHistogram.png"         "Problem Set 3.rmd"         
##  [9] "Problem_Set_3.rmd"          "Problem_Set_3_files"       
## [11] "pseudo_facebook.tsv"
```

```r
electricity_df <- read.csv('Electricity Generation.csv', stringsAsFactors=FALSE
                        ,sep=",",head=TRUE)

summary(electricity_df)
```

```
##    country              X1990               X1991          
##  Length:64          Min.   :4.510e+09   Min.   :4.494e+09  
##  Class :character   1st Qu.:2.618e+10   1st Qu.:2.911e+10  
##  Mode  :character   Median :5.246e+10   Median :5.411e+10  
##                     Mean   :1.764e+11   Mean   :1.804e+11  
##                     3rd Qu.:1.389e+11   3rd Qu.:1.379e+11  
##                     Max.   :3.185e+12   Max.   :3.223e+12  
##      X1992               X1993               X1994          
##  Min.   :4.546e+09   Min.   :4.727e+09   Min.   :4.780e+09  
##  1st Qu.:2.903e+10   1st Qu.:3.005e+10   1st Qu.:2.953e+10  
##  Median :5.523e+10   Median :5.795e+10   Median :5.831e+10  
##  Mean   :1.823e+11   Mean   :1.865e+11   Mean   :1.913e+11  
##  3rd Qu.:1.468e+11   3rd Qu.:1.497e+11   3rd Qu.:1.506e+11  
##  Max.   :3.235e+12   Max.   :3.354e+12   Max.   :3.407e+12  
##      X1995               X1996               X1997          
##  Min.   :4.976e+09   Min.   :5.113e+09   Min.   :5.580e+09  
##  1st Qu.:2.762e+10   1st Qu.:2.981e+10   1st Qu.:3.165e+10  
##  Median :6.196e+10   Median :6.280e+10   Median :6.260e+10  
##  Mean   :1.979e+11   Mean   :2.041e+11   Mean   :2.082e+11  
##  3rd Qu.:1.566e+11   3rd Qu.:1.660e+11   3rd Qu.:1.754e+11  
##  Max.   :3.517e+12   Max.   :3.611e+12   Max.   :3.661e+12  
##      X1998               X1999               X2000          
##  Min.   :6.275e+09   Min.   :7.185e+09   Min.   :7.679e+09  
##  1st Qu.:3.498e+10   1st Qu.:3.715e+10   1st Qu.:3.568e+10  
##  Median :6.504e+10   Median :6.739e+10   Median :6.865e+10  
##  Mean   :2.137e+11   Mean   :2.193e+11   Mean   :2.292e+11  
##  3rd Qu.:1.744e+11   3rd Qu.:1.763e+11   3rd Qu.:1.897e+11  
##  Max.   :3.797e+12   Max.   :3.876e+12   Max.   :3.990e+12  
##      X2001               X2002               X2003          
##  Min.   :8.028e+09   Min.   :8.411e+09   Min.   :8.495e+09  
##  1st Qu.:3.731e+10   1st Qu.:3.851e+10   1st Qu.:4.057e+10  
##  Median :7.449e+10   Median :7.584e+10   Median :8.395e+10  
##  Mean   :2.327e+11   Mean   :2.407e+11   Mean   :2.498e+11  
##  3rd Qu.:1.938e+11   3rd Qu.:2.026e+11   3rd Qu.:2.110e+11  
##  Max.   :3.924e+12   Max.   :4.050e+12   Max.   :4.076e+12  
##      X2004               X2005               X2006          
##  Min.   :8.618e+09   Min.   :8.680e+09   Min.   :9.548e+09  
##  1st Qu.:4.101e+10   1st Qu.:4.184e+10   1st Qu.:4.509e+10  
##  Median :8.716e+10   Median :8.484e+10   Median :9.026e+10  
##  Mean   :2.610e+11   Mean   :2.721e+11   Mean   :2.832e+11  
##  3rd Qu.:2.193e+11   3rd Qu.:2.288e+11   3rd Qu.:2.376e+11  
##  Max.   :4.168e+12   Max.   :4.257e+12   Max.   :4.266e+12  
##      X2007               X2008          
##  Min.   :1.198e+10   Min.   :1.401e+10  
##  1st Qu.:4.264e+10   1st Qu.:4.322e+10  
##  Median :9.343e+10   Median :9.029e+10  
##  Mean   :2.961e+11   Mean   :3.005e+11  
##  3rd Qu.:2.454e+11   3rd Qu.:2.425e+11  
##  Max.   :4.365e+12   Max.   :4.316e+12
```

```r
str(electricity_df)
```

```
## 'data.frame':	64 obs. of  20 variables:
##  $ country: chr  "Algeria" "Argentina" "Australia" "Austria" ...
##  $ X1990  : num  1.61e+10 5.09e+10 1.56e+11 5.04e+10 2.32e+10 ...
##  $ X1991  : num  1.73e+10 5.41e+10 1.58e+11 5.15e+10 2.34e+10 ...
##  $ X1992  : num  1.83e+10 5.63e+10 1.62e+11 5.12e+10 1.97e+10 ...
##  $ X1993  : num  1.94e+10 6.25e+10 1.66e+11 5.27e+10 1.91e+10 ...
##  $ X1994  : num  1.99e+10 6.56e+10 1.70e+11 5.33e+10 1.76e+10 ...
##  $ X1995  : num  1.97e+10 6.72e+10 1.76e+11 5.66e+10 1.70e+10 ...
##  $ X1996  : num  2.07e+10 6.98e+10 1.80e+11 5.48e+10 1.71e+10 ...
##  $ X1997  : num  2.12e+10 7.25e+10 1.90e+11 5.69e+10 1.68e+10 ...
##  $ X1998  : num  2.36e+10 7.42e+10 2.00e+11 5.74e+10 1.79e+10 ...
##  $ X1999  : num  2.48e+10 8.07e+10 2.06e+11 6.04e+10 1.81e+10 ...
##  $ X2000  : num  2.50e+10 8.90e+10 2.12e+11 6.18e+10 1.87e+10 ...
##  $ X2001  : num  2.63e+10 9.01e+10 2.22e+11 6.18e+10 1.90e+10 ...
##  $ X2002  : num  2.74e+10 8.46e+10 2.27e+11 6.27e+10 1.87e+10 ...
##  $ X2003  : num  2.92e+10 9.20e+10 2.28e+11 6.02e+10 2.13e+10 ...
##  $ X2004  : num  3.09e+10 1.00e+11 2.37e+11 6.43e+10 2.17e+10 ...
##  $ X2005  : num  3.36e+10 1.06e+11 2.49e+11 6.06e+10 2.29e+10 ...
##  $ X2006  : num  3.50e+10 1.17e+11 2.55e+11 6.34e+10 2.45e+10 ...
##  $ X2007  : num  3.70e+10 1.21e+11 2.61e+11 6.37e+10 2.18e+10 ...
##  $ X2008  : num  4.00e+10 1.25e+11 2.72e+11 6.78e+10 2.16e+10 ...
```

#Distribution of electricty generation in the world in 1990 


```r
#Distribution of electricty generation in the world in 1990 (log scale)
qplot(data = electricity_df, x = X1990/10^9,
      xlab = 'Electricty generation (GWh)',
      ylab = 'Number of country in sample',
      main="Distribution of electricty generation in the world in 1990")
```

```
## `stat_bin()` using `bins = 30`. Pick better value with `binwidth`.
```

![](Problem_Set_3_files/figure-html/unnamed-chunk-13-1.png)

```r
#Distribution of electricty generation in the world in 1990 (log scale)
qplot(data = electricity_df, x = X1990/10^9,
      xlab = 'Electricty generation (GWh)',
      ylab = 'Number of country in sample',
      main="Distribution of electricty generation in the world in 1990 (log scale)") +
  scale_x_log10()
```

```
## `stat_bin()` using `bins = 30`. Pick better value with `binwidth`.
```

![](Problem_Set_3_files/figure-html/unnamed-chunk-13-2.png)

# Energy generation of Canada over time


```r
#install.packages('dplyr', dependencies = T)
#install.packages('tidyr', dependencies = T)
library(dplyr)
```

```
## 
## Attaching package: 'dplyr'
```

```
## The following objects are masked from 'package:stats':
## 
##     filter, lag
```

```
## The following objects are masked from 'package:base':
## 
##     intersect, setdiff, setequal, union
```

```r
library(tidyr)
library(ggplot2)

canada_df <- electricity_df[ electricity_df$country == 'Canada' ,] 

canada_df <- canada_df[, -1]  #remove first column (to avoid the df to be factors and not numeric)

canada_df <- as.data.frame( t(canada_df) )

canada_df <- canada_df / 10^9

ggplot(data = canada_df,
       aes(x = rownames(canada_df), y = canada_df[,1] , group = 1   )) +
  geom_line() + geom_point() + geom_smooth() +
  ggtitle('Electricty generation in Canada')+
  xlab('Year') +
  ylab('Electricty generation (GWh)')
```

![](Problem_Set_3_files/figure-html/unnamed-chunk-14-1.png)

***

## Exploring Your Friends' Birthdays

#Loading data


```r
list.files()
```

```
##  [1] "birthdaysExample.csv"       "Electricity Generation.csv"
##  [3] "Lesson 3.rmd"               "Lesson_3.html"             
##  [5] "Lesson_3.md"                "Lesson_3_files"            
##  [7] "priceHistogram.png"         "Problem Set 3.rmd"         
##  [9] "Problem_Set_3.rmd"          "Problem_Set_3_files"       
## [11] "pseudo_facebook.tsv"
```

```r
birthday_df <- read.csv('birthdaysExample.csv', stringsAsFactors=FALSE
                        ,sep=",",head=TRUE)

summary(birthday_df)
```

```
##     dates          
##  Length:1033       
##  Class :character  
##  Mode  :character
```

```r
str(birthday_df)
```

```
## 'data.frame':	1033 obs. of  1 variable:
##  $ dates: chr  "11/25/14" "6/8/14" "9/12/14" "5/26/14" ...
```

```r
birthday_df$dates <- strptime(birthday_df$dates,format='%m/%d/%y')
```

# How many people share your birthday? Do you know them?
# (Reserve time with them or save money to buy them a gift!)


```r
birthday_df$day <- as.numeric(format(birthday_df$dates, "%d"))  # equivalent to weekdays(birthday_df$dates)
birthday_df$month <- as.numeric(format(birthday_df$dates, "%m"))
birthday_df$year <- as.numeric(format(birthday_df$dates, "%Y"))

str(birthday_df)
```

```
## 'data.frame':	1033 obs. of  4 variables:
##  $ dates: POSIXlt, format: "2014-11-25" "2014-06-08" ...
##  $ day  : num  25 8 12 26 20 19 10 22 6 20 ...
##  $ month: num  11 6 9 5 2 6 10 10 7 9 ...
##  $ year : num  2014 2014 2014 2014 2014 ...
```

```r
birthday_df[ (birthday_df$month == 1) &  (birthday_df$day == 19) , ]
```

```
##          dates day month year
## 539 2014-01-19  19     1 2014
## 685 2014-01-19  19     1 2014
## 729 2014-01-19  19     1 2014
## 837 2014-01-19  19     1 2014
## 916 2014-01-19  19     1 2014
```

Note : 5 people share my BD.

# Which month contains the most number of birthdays?


```r
birthday_df$number <- 1
# group by month and sum 'birthday_df$number'
aggr1_df <- aggregate(birthday_df$number, by=list(birthday_df$month), FUN=sum)
aggr1_df
```

```
##    Group.1  x
## 1        1 89
## 2        2 79
## 3        3 98
## 4        4 81
## 5        5 72
## 6        6 93
## 7        7 86
## 8        8 91
## 9        9 96
## 10      10 89
## 11      11 87
## 12      12 72
```

```r
str(aggr1_df)
```

```
## 'data.frame':	12 obs. of  2 variables:
##  $ Group.1: num  1 2 3 4 5 6 7 8 9 10 ...
##  $ x      : num  89 79 98 81 72 93 86 91 96 89 ...
```

```r
# get the month with the max number
which.max(aggr1_df$x)
```

```
## [1] 3
```

The month with most number of birthdays is MARCH.

# How many birthdays are in each month?


```r
library(ggplot2)

ggplot(data=aggr1_df, aes(x=factor(Group.1),y=x)) +    # factor the months, for a better x scale
    geom_bar(stat="identity") +                       # use of stat="identity", cf below
    xlab('Month') +
    ylab('Number of people in sample')
```

![](Problem_Set_3_files/figure-html/unnamed-chunk-18-1.png)

```r
# here, the height of the bar will represent the value in a column of the data frame. This is done by using stat="identity" instead of the default, stat="bin".
```

# Which day of the year has the most number of birthdays?


```r
# add a new column "day of year"
birthday_df$doy <- as.numeric(strftime(birthday_df$dates, format = "%j"))

birthday_df$number <- 1
# group by day of year and sum 'birthday_df$number'
aggr2_df <- aggregate(birthday_df$number, by=list(birthday_df$doy), FUN=sum)
aggr2_df
```

```
##     Group.1 x
## 1         1 4
## 2         2 1
## 3         3 5
## 4         4 3
## 5         5 1
## 6         6 1
## 7         7 3
## 8         8 1
## 9         9 6
## 10       10 2
## 11       11 4
## 12       12 3
## 13       13 4
## 14       14 7
## 15       15 3
## 16       16 3
## 17       17 2
## 18       18 1
## 19       19 5
## 20       20 2
## 21       21 2
## 22       22 5
## 23       23 1
## 24       24 2
## 25       25 1
## 26       26 4
## 27       27 5
## 28       28 2
## 29       29 3
## 30       30 1
## 31       31 2
## 32       32 3
## 33       33 7
## 34       34 2
## 35       35 1
## 36       36 1
## 37       37 8
## 38       38 1
## 39       40 2
## 40       41 5
## 41       42 2
## 42       43 2
## 43       44 5
## 44       45 3
## 45       46 1
## 46       47 4
## 47       48 4
## 48       49 2
## 49       50 1
## 50       51 3
## 51       54 7
## 52       55 5
## 53       56 2
## 54       57 2
## 55       58 5
## 56       59 1
## 57       60 3
## 58       61 6
## 59       62 3
## 60       63 2
## 61       64 3
## 62       66 2
## 63       67 1
## 64       68 4
## 65       69 3
## 66       70 1
## 67       71 4
## 68       72 5
## 69       73 1
## 70       74 1
## 71       75 6
## 72       76 3
## 73       77 3
## 74       78 6
## 75       79 4
## 76       80 6
## 77       81 4
## 78       82 3
## 79       83 4
## 80       84 3
## 81       85 2
## 82       86 3
## 83       87 5
## 84       88 3
## 85       89 3
## 86       90 1
## 87       91 3
## 88       92 1
## 89       93 1
## 90       94 3
## 91       95 3
## 92       96 4
## 93       97 1
## 94       98 6
## 95       99 2
## 96      100 3
## 97      101 1
## 98      102 4
## 99      103 2
## 100     104 7
## 101     105 1
## 102     107 3
## 103     108 2
## 104     109 3
## 105     110 1
## 106     112 3
## 107     113 5
## 108     114 2
## 109     115 3
## 110     116 5
## 111     117 3
## 112     118 3
## 113     119 3
## 114     120 3
## 115     121 1
## 116     122 2
## 117     124 4
## 118     125 3
## 119     126 1
## 120     127 4
## 121     128 4
## 122     129 3
## 123     130 1
## 124     131 2
## 125     132 2
## 126     133 1
## 127     134 2
## 128     135 1
## 129     136 2
## 130     137 2
## 131     138 4
## 132     139 4
## 133     140 2
## 134     141 1
## 135     142 8
## 136     143 3
## 137     145 2
## 138     146 3
## 139     147 1
## 140     148 4
## 141     149 2
## 142     150 2
## 143     151 1
## 144     152 4
## 145     153 4
## 146     154 2
## 147     155 2
## 148     156 3
## 149     157 5
## 150     158 3
## 151     159 3
## 152     160 5
## 153     161 6
## 154     162 2
## 155     163 3
## 156     164 3
## 157     165 2
## 158     166 2
## 159     167 1
## 160     168 5
## 161     169 3
## 162     170 4
## 163     171 3
## 164     172 1
## 165     173 3
## 166     174 4
## 167     175 3
## 168     176 6
## 169     178 1
## 170     179 2
## 171     180 2
## 172     181 6
## 173     182 3
## 174     183 3
## 175     184 1
## 176     185 1
## 177     186 3
## 178     187 4
## 179     188 5
## 180     189 7
## 181     190 2
## 182     191 1
## 183     192 1
## 184     193 3
## 185     194 2
## 186     195 1
## 187     196 3
## 188     197 8
## 189     198 1
## 190     199 4
## 191     200 5
## 192     201 4
## 193     202 3
## 194     203 2
## 195     204 3
## 196     205 1
## 197     206 2
## 198     207 1
## 199     208 1
## 200     209 3
## 201     210 3
## 202     211 2
## 203     212 3
## 204     213 3
## 205     214 2
## 206     216 3
## 207     217 5
## 208     219 5
## 209     220 3
## 210     221 3
## 211     222 3
## 212     223 1
## 213     224 3
## 214     225 1
## 215     226 4
## 216     227 3
## 217     228 3
## 218     229 4
## 219     230 7
## 220     231 2
## 221     232 1
## 222     233 5
## 223     234 3
## 224     236 1
## 225     237 3
## 226     238 6
## 227     239 7
## 228     240 2
## 229     241 2
## 230     242 2
## 231     243 4
## 232     244 6
## 233     245 1
## 234     246 2
## 235     247 3
## 236     248 2
## 237     249 3
## 238     250 2
## 239     251 3
## 240     252 4
## 241     253 4
## 242     254 1
## 243     255 3
## 244     256 3
## 245     257 7
## 246     258 2
## 247     259 5
## 248     260 3
## 249     261 1
## 250     262 4
## 251     263 5
## 252     264 4
## 253     265 1
## 254     266 4
## 255     267 6
## 256     268 1
## 257     269 2
## 258     270 3
## 259     271 3
## 260     272 7
## 261     273 1
## 262     274 2
## 263     275 3
## 264     276 2
## 265     277 4
## 266     278 2
## 267     279 3
## 268     280 4
## 269     281 2
## 270     282 2
## 271     283 1
## 272     284 4
## 273     285 2
## 274     286 4
## 275     287 5
## 276     288 3
## 277     289 3
## 278     290 3
## 279     291 2
## 280     292 3
## 281     293 2
## 282     294 4
## 283     295 2
## 284     296 4
## 285     297 3
## 286     298 3
## 287     299 2
## 288     300 3
## 289     301 5
## 290     302 4
## 291     303 1
## 292     304 2
## 293     305 3
## 294     306 3
## 295     307 6
## 296     308 3
## 297     309 6
## 298     310 4
## 299     311 1
## 300     312 4
## 301     313 2
## 302     314 4
## 303     316 3
## 304     318 4
## 305     319 1
## 306     320 3
## 307     321 6
## 308     322 4
## 309     323 1
## 310     324 3
## 311     325 3
## 312     326 2
## 313     327 5
## 314     328 2
## 315     329 2
## 316     330 1
## 317     331 3
## 318     332 2
## 319     333 2
## 320     334 4
## 321     335 1
## 322     336 3
## 323     337 2
## 324     338 4
## 325     339 2
## 326     341 3
## 327     342 2
## 328     343 5
## 329     344 2
## 330     345 2
## 331     346 1
## 332     348 5
## 333     349 3
## 334     350 1
## 335     351 4
## 336     352 6
## 337     353 2
## 338     354 1
## 339     355 2
## 340     356 2
## 341     358 3
## 342     359 1
## 343     360 2
## 344     361 1
## 345     362 5
## 346     363 1
## 347     364 3
## 348     365 3
```

```r
str(aggr2_df)
```

```
## 'data.frame':	348 obs. of  2 variables:
##  $ Group.1: num  1 2 3 4 5 6 7 8 9 10 ...
##  $ x      : num  4 1 5 3 1 1 3 1 6 2 ...
```

```r
# get the doy with the max number
the_date <- as.numeric(which.max(aggr2_df$x))
the_date
```

```
## [1] 37
```

```r
# and get the associated date
temp1 <- birthday_df[ birthday_df$doy == the_date, ]['dates']
head(temp1,1)
```

```
##          dates
## 159 2014-02-06
```

```r
# and the number of occurences
dim(temp1)[1]
```

```
## [1] 8
```

This #37 has the most number of birthday. The date is Feb 6th. and occurs 8 times.


# Do you have at least 365 friends that have birthdays on everyday
# of the year?


```r
# create a list of 365 days
total_list_doy <- seq(1, 365, by=1)

# create a list of unique
unique_list_doy <- unique(sort(c(birthday_df$doy)))
length(unique_list_doy)
```

```
## [1] 348
```

```r
# what is different in total_list_doy
days_wo_birthday <- setdiff(total_list_doy,unique_list_doy)   
days_wo_birthday
```

```
##  [1]  39  52  53  65 106 111 123 144 177 215 218 235 315 317 340 347 357
```

```r
length(days_wo_birthday)
```

```
## [1] 17
```

Note : on 17 specific days of the year, there are no birthdays.
