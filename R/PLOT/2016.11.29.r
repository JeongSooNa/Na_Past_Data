#R hw3
#2013016032 나정수
#연습문제

#1 내장된 데이터셋인 InsectSprays을 사용해 
#(a) spray종류에 따른 빈도표를 구하고 파이그림을 그리시오.
InsectSprays
##    count spray
## 1     10     A
## 2      7     A
## 3     20     A
## 4     14     A
## 5     14     A
## 6     12     A
## 7     10     A
## 8     23     A
## 9     17     A
## 10    20     A
## 11    14     A
## 12    13     A
## 13    11     B
## 14    17     B
## 15    21     B
## 16    11     B
## 17    16     B
## 18    14     B
## 19    17     B
## 20    17     B
## 21    19     B
## 22    21     B
## 23     7     B
## 24    13     B
## 25     0     C
## 26     1     C
## 27     7     C
## 28     2     C
## 29     3     C
## 30     1     C
## 31     2     C
## 32     1     C
## 33     3     C
## 34     0     C
## 35     1     C
## 36     4     C
## 37     3     D
## 38     5     D
## 39    12     D
## 40     6     D
## 41     4     D
## 42     3     D
## 43     5     D
## 44     5     D
## 45     5     D
## 46     5     D
## 47     2     D
## 48     4     D
## 49     3     E
## 50     5     E
## 51     3     E
## 52     5     E
## 53     3     E
## 54     6     E
## 55     1     E
## 56     1     E
## 57     3     E
## 58     2     E
## 59     6     E
## 60     4     E
## 61    11     F
## 62     9     F
## 63    15     F
## 64    22     F
## 65    15     F
## 66    16     F
## 67    13     F
## 68    10     F
## 69    26     F
## 70    26     F
## 71    24     F
## 72    13     F
x1=table(InsectSprays)
count=as.numeric(row.names(x1))
sum.count=x1*count
spraytype.sum=apply(sum.count,2,sum)
spraytype.sum
##   A   B   C   D   E   F 
## 174 184  25  59  42 200
pie(spraytype.sum,col=c('red','yellow','green','blue','purple','white'))
## pie.jpg
#(b) count 평균을 구하시오.
mean(spraytype.sum)
## [1] 114
#(c) spary 종류 별 count 의 합을 구하시오.
count=as.numeric(row.names(x1))
sum.count=x1*count
spraytype.sum=apply(sum.count,2,sum)
spraytype.sum
##   A   B   C   D   E   F 
## 174 184  25  59  42 200
#2. 균일분포 (0,1)을 따르는 20개의 난수로 구성된 vector x에 대해
#(a) 평균과 표준편차를 구하시오.
n=20
x2=runif(n,0,1)
x2
##  [1] 0.84599339 0.84729439 0.40448151 0.07136829 0.39672605 0.68485358
##  [7] 0.52667729 0.92407134 0.66764541 0.63060484 0.94972823 0.31424426
## [13] 0.65558207 0.57357416 0.27449662 0.91550060 0.41600405 0.79894623
## [19] 0.55452382 0.80629932
mean(x2)
## [1] 0.6129308
SE=sd(x2)/sqrt(n)
SE
## [1] 0.05457352
#(b) 평균  2 표준오차로 나타낸 신뢰구간 그림을 그리시오.
#표준오차 = s/n^(1/2)
nclass.Sturges(x2)
## [1] 6
hist(x2,breaks=6,prob=T,main="Uniform Distribution")
lines(density(x2,bw='SJ'),col='blue')
abline(v=mean(x2) + c(-1,1)*2*SE,col='red',lty=1)
## Uniform Distribution.png
#3. B 회사직원들의 월별 휴대폰 요금을 조사하여 얻은 데이터이다.
#20,870 39,400 65,000 45,000 35,890 29,000 56,770
#23,000 38,550 59,800 39,880 56,780 35,220 48,990

#(a) 평균 휴대폰요금을 추정하시오.
fee<-c("20,870","39,400","65,000","45,000","35,890","29,000","56,770","23,000","38,550","59,800","39,880","56,780","35,220","48,990")
fee<-as.numeric(gsub(",", "", fee)); fee
##  [1] 20870 39400 65000 45000 35890 29000 56770 23000 38550 59800 39880
## [12] 56780 35220 48990
mean(fee)
## [1] 42439.29
#(b) 평균 휴대폰 요금의 95% 신뢰구간을 추정하시오.
SE=sd(fee) / sqrt (length(fee))
alpha=0.05
t.value = qt(1-alpha/2,df=length(fee)-1); t.value
## [1] 2.160369
mean(fee) + c(-1,1)*t.value*SE
## [1] 34560.71 50317.86
#(c) 휴대폰 요금의 분산, 표준편차와 범위를 추정하시오.
s=sd(fee)
v=var(fee)
s
## [1] 13645.33
v
## [1] 186194930
max(fee)-min(fee)
## [1] 44130
#(d) 상자그림을 그리시오
boxplot(fee,main="Monthly Mobile Phone fee in B Company",horizontal=T)
## Monthly Mobile Phone fee in B Company.png
#(e) 확률밀도함수추정선과 히스토그램을 그리시오.
nclass.Sturges(fee)
## [1] 5
hist(fee,breaks=5,prob=T,main="Mobile fee in B Company")
lines(density(fee,bw='SJ'),col='red')
## Mobile fee in N Company.png
