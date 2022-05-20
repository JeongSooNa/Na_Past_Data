#준비
install.packages("forecast")
install.packages("lmtest")
library(forecast)
library(lmtest)

#연간 스웨덴 출생율
born<-read.csv("C:/Users/Administrator/Desktop/average-annual-temperature-centr.csv")
born_1<-born[,-1]
born_1<-born_1[-249][-249]


born<-ts(born_1,start=c(1723,1),frequency=1) #시계열변수로 변환하기 위해 ts함수 사용 1999년1월부터 주기는 12월로 시작
plot.ts(born) #계절성 판단여부는 그래프가 주기를 보이면 계절성을 가지고 있는것이다, 이 그래프를 보면 추세가 있고 변동의 폭이 일정하지 않다
born          #그래프만 보고 판단하기 어려우니 acf, pacf를 보고 판단한다

#acf,pacf
par(mfrow=c(2,1))
acf(born)
pacf(born)
par(mfrow=c(1,1))
#로그변환
lborn<-log(born)
plot.ts(lborn)

#로그변환한 acf,pacf
par(mfrow=c(2,1))
acf(lborn)
pacf(lborn)
par(mfrow=c(1,1))

#1차 차분
dlborn<-diff(born)
plot.ts(dlborn) #차분은 하면할수록 원자료와 달라지기 때문에 2차차분까지만

#1차 차분한 acf,pacf
par(mfrow=c(2,1))
acf(dlborn)  #시차1에서 절단된다고 할 수 있다
pacf(dlborn)
par(mfrow=c(1,1))

#모형식별,모수추정
arima101<-arima(dlborn,order=c(1,0,1))
arima201<-arima(dlborn,order=c(2,0,1))
arima102<-arima(dlborn,order=c(1,0,2))
arima202<-arima(dlborn,order=c(2,0,2))
summary(arima101)
summary(arima201)
summary(arima102)
summary(arima202)


arima211<-arima(dlborn,order=c(2,1,1))
summary(arima211)
coeftest(arima211) #lmtest에 들어있다
arima111<-arima(dlborn,order=c(1,1,1))
summary(arima111)
coeftest(arima111)
arima212<-arima(dlborn,order=c(2,1,2))
summary(arima212)
coeftest(arima212)


#최종적으로 고려한 모델은 arima011과 arima111이다

auto.arima(born,stepwise=FALSE) #forecast패키지에 들어있다
#auto.arima사용시 원자료를 사용해야된다

#모형진단
tsdiag(arima211,gof.lag=24)
tsdiag(arima212,gof.lag=24)

#arima012가 더 적합한 모형이라 판단되어 012채택