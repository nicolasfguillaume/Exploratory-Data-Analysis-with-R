Lesson 3: Explore One Variable
========================================================


***

### Pseudo-Facebook User Data


```r
pf <- read.csv('pseudo_facebook.tsv', sep='\t')
names(pf)
```

```
##  [1] "userid"                "age"                  
##  [3] "dob_day"               "dob_year"             
##  [5] "dob_month"             "gender"               
##  [7] "tenure"                "friend_count"         
##  [9] "friendships_initiated" "likes"                
## [11] "likes_received"        "mobile_likes"         
## [13] "mobile_likes_received" "www_likes"            
## [15] "www_likes_received"
```

***

### Histogram of Users' Birthdays


```r
library(ggplot2)
qplot(x= dob_day, data = pf) +
  scale_x_continuous(breaks=1:31)
```


![](Lesson_3_files/figure-html/Histogram of Users' Birthdays-1.png)

***

### Faceting

```r
qplot(x= dob_day, data = pf) +
  scale_x_continuous(breaks=1:31) +
  facet_wrap(~dob_month, ncol=3)
```

![](Lesson_3_files/figure-html/Faceting-1.png)


#### What code would you enter to create a histogram of friend counts?

```r
qplot(x = friend_count, data = pf)
```

![](Lesson_3_files/figure-html/Friend Count-1.png)


### Limiting the Axes

```r
#qplot(x = friend_count, data = pf, xlim = c(0, 1000) )
# or
qplot(x = friend_count, data = pf) +
  scale_x_continuous( limits = c(0,1000))
```

![](Lesson_3_files/figure-html/Limiting the Axes-1.png)


### Faceting Friend Count

```r
# What code would you add to create a facet the histogram by gender?

qplot(x = friend_count, data = pf, binwidth = 25) +
  scale_x_continuous(limits = c(0, 1000),
                     breaks = seq(0, 1000, 50)) +    # update the x-axis label
  facet_wrap(~gender)   
```

![](Lesson_3_files/figure-html/Faceting Friend Count-1.png)

***

### Omitting NA Values

```r
#qplot(x = friend_count, data = na.omit(pf), binwidth = 25) +
#  scale_x_continuous(limits = c(0, 1000),
#                     breaks = seq(0, 1000, 50)) +    # update the x-axis label
#  facet_wrap(~gender)

# or

qplot(x = friend_count, data = subset(pf, !is.na(gender)), binwidth = 25) +
  scale_x_continuous(limits = c(0, 1000),
                     breaks = seq(0, 1000, 50)) +    # update the x-axis label
  facet_wrap(~gender)
```

![](Lesson_3_files/figure-html/Omitting NA Values-1.png)

***

### Statistics 'by' Gender

```r
table(pf$gender)   # returns the number of female and male
```

```
## 
## female   male 
##  40254  58574
```

```r
by(pf$friend_count, pf$gender, summary)
```

```
## pf$gender: female
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##       0      37      96     242     244    4923 
## -------------------------------------------------------- 
## pf$gender: male
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##       0      27      74     165     182    4917
```

#### Why would the median be a better measure than the mean?
Response: more robust statistics

***

### Tenure

```r
qplot(x = tenure, data = pf, color = I('black'), fill= I('#099DD9') )
```

![](Lesson_3_files/figure-html/Tenure-1.png)

***

#### How would you create a histogram of tenure by year?

```r
qplot(x = tenure/365, data = pf, 
      color = I('black'), fill= I('#099DD9') , 
      binwidth = 0.25 ) +
  scale_x_continuous(limits = c(0, 7),
                     breaks = seq(0, 7, 1))
```

![](Lesson_3_files/figure-html/Tenure Histogram by Year-1.png)

***

### Labeling Plots

```r
qplot(x = tenure/365, data = pf, 
      xlab = 'Number of years using Facbook',
      ylab = 'Number of users in sample',
      color = I('black'), fill= I('#099DD9') , 
      binwidth = 0.25 ) +
  scale_x_continuous(limits = c(0, 7),
                     breaks = seq(0, 7, 1))
```


![](Lesson_3_files/figure-html/Labeling Plots-1.png)

***

### User Ages

```r
qplot(x = age, data = pf, 
      xlab = 'Age of Users',
      ylab = 'Number of users in sample',
      color = I('black'), fill= I('#099DD9') , 
      binwidth = 1 ) +
  scale_x_continuous(limits = c(10, 115),
                     breaks = seq(10, 115, 10)) 
```

![](Lesson_3_files/figure-html/User Ages-1.png)


### Transforming Data

```r
summary( pf$friend_count   )
```

```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##     0.0    31.0    82.0   196.4   206.0  4923.0
```

```r
summary( log10( pf$friend_count + 1)   )  #  + 1 to avoid to deal with - infinity
```

```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##   0.000   1.505   1.919   1.868   2.316   3.692
```

```r
summary( sqrt( pf$friend_count + 1)   )
```

```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##   1.000   5.657   9.110  11.180  14.390  70.170
```


***

### Add a Scaling Layer

```r
library(gridExtra) 

# define individual plots
p1 <- qplot(x = friend_count, data = pf)
p2 <- qplot(x = friend_count, data = pf) +          # log10(friend_count+1)
  scale_x_log10()
p3 <- qplot(x = friend_count, data = pf) +          # sqrt(friend_count)
  scale_x_sqrt()
# arrange plots in grid
grid.arrange(p1, p2, p3, ncol=1)
```

![](Lesson_3_files/figure-html/Add a Scaling Layer-1.png)

```r
# alternative:
# p1 <- ggplot(aes(x = friend_count), data = pf) + geom_histogram()
# p2 <- p1 + scale_x_log10()
# p3 <- p1 + scale_x_sqrt()
#grid.arrange(p1, p2, p3, ncol=1)
```

***


### Frequency Polygons


```r
qplot(x = friend_count, y = ..count../sum(..count..), 
      data = subset(pf, !is.na(gender)), 
      xlab = 'Friend count',
      ylab = 'Proportion of users with that friend count',
      color = gender , 
      binwidth = 10,
      geom = 'freqpoly') +
  scale_x_continuous(limits = c(0, 1000),
                     breaks = seq(0, 1000, 50)) 
```

![](Lesson_3_files/figure-html/Frequency Polygons-1.png)

***

### Likes on the Web


```r
qplot(x = www_likes, y = ..count../sum(..count..), 
      data = subset(pf, !is.na(gender)), 
      xlab = 'Likes on the WWW',
      ylab = 'Proportion of users with that number of likes',
      color = gender , 
      binwidth = 0.25,
      geom = 'freqpoly') +
  scale_x_continuous(limits = c(0, 10),
                     breaks = seq(0, 10, 1)) + 
  scale_x_log10()
```


![](Lesson_3_files/figure-html/Likes on the Web-1.png)

```r
# number of total likes per gender
by(pf$www_likes, pf$gender, sum)
```

```
## pf$gender: female
## [1] 3507665
## -------------------------------------------------------- 
## pf$gender: male
## [1] 1430175
```


***

### Box Plots

```r
qplot(x =gender, y = friend_count, 
      data = subset(pf, !is.na(gender)), 
      geom = 'boxplot')
```

![](Lesson_3_files/figure-html/Box Plots-1.png)

#### Adjust the code to focus on users who have friend counts between 0 and 1000.

```r
qplot(x =gender, y = friend_count, 
      data = subset(pf, !is.na(gender)), 
      geom = 'boxplot', ylim = c(0,1000))
```

![](Lesson_3_files/figure-html/unnamed-chunk-3-1.png)

```r
# OR
qplot(x =gender, y = friend_count, 
      data = subset(pf, !is.na(gender)), 
      geom = 'boxplot') +
  scale_y_continuous(limits = c(0,1000))
```

![](Lesson_3_files/figure-html/unnamed-chunk-3-2.png)

```r
# OR MORE ACCURATELY
qplot(x =gender, y = friend_count, 
      data = subset(pf, !is.na(gender)), 
      geom = 'boxplot') +
  coord_cartesian(ylim = c(0,1000))    # used so the summary output matches the box plot
```

![](Lesson_3_files/figure-html/unnamed-chunk-3-3.png)

```r
by(pf$friend_count, pf$gender, summary)
```

```
## pf$gender: female
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##       0      37      96     242     244    4923 
## -------------------------------------------------------- 
## pf$gender: male
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##       0      27      74     165     182    4917
```

***

### Box Plots, Quartiles, and Friendships

```r
qplot(x =gender, y = friend_count, 
      data = subset(pf, !is.na(gender)), 
      geom = 'boxplot') +
  coord_cartesian(ylim = c(0,250))
```

![](Lesson_3_files/figure-html/Box Plots, Quartiles, and Friendships-1.png)

```r
qplot(x =gender, y = friendships_initiated, 
      data = subset(pf, !is.na(gender)), 
      geom = 'boxplot') +
  coord_cartesian(ylim = c(0,150))
```

![](Lesson_3_files/figure-html/Friend Requests by Gender-1.png)

```r
by(pf$friendships_initiated, pf$gender, summary)
```

```
## pf$gender: female
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##     0.0    19.0    49.0   113.9   124.8  3654.0 
## -------------------------------------------------------- 
## pf$gender: male
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##     0.0    15.0    44.0   103.1   111.0  4144.0
```

***

### Getting Logical

```r
summary(pf$mobile_likes)
```

```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##     0.0     0.0     4.0   106.1    46.0 25110.0
```

```r
qplot(data = pf, x = mobile_likes)+
    scale_x_continuous(limits = c(0, 10),
                     breaks = seq(0, 10, 1))
```


![](Lesson_3_files/figure-html/Getting Logical-1.png)

```r
summary(pf$mobile_likes > 0)
```

```
##    Mode   FALSE    TRUE    NA's 
## logical   35056   63947       0
```

```r
mobile_check_in <- NA     # creating a new variable
pf$mobile_check_in <- ifelse(pf$mobile_likes > 0, 1, 0)
pf$mobile_check_in <- factor(pf$mobile_check_in)
summary(pf$mobile_check_in)
```

```
##     0     1 
## 35056 63947
```

```r
sum(pf$mobile_check_in == 1) / length(pf$mobile_check_in)
```

```
## [1] 0.6459097
```

Response: percent of check-in using mobile = 65%

***

### Analyzing One Variable
Reflection:
- look at the data distribution to find insightful information
- look for outliers and missing values
- plotting the data helps a lot, conveys more information
- use data transformation can be very helpful too

***
