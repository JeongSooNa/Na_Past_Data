#arma model
arma11<-arima.sim(n=100,list(order=c(1,0,1),ar=0.3,ma=0.7))
par(mfrow=c(1,1))
plot(arma11)
par(mfrow=c(2,1))
acf(arma11)
pacf(arma11)

##05.17(수) 시계열 실습
##모수추정 및 모형 진단, 예측

##모형식별, 모수추정
#준비
install.packages("forecast")
library(forecast)
install.packages("lmtest")
library(lmtest)
install.packages("tseries")
library(tseries)
#모형식별
arma11_2<-auto.arima(arma11)
    #auto.arima를 통해 aic,bic의 최적값을 찾는다.
summary(arma11_2)
arma21<-arima(arma11,order=c(2,0,1))
summary((arma21))
#모수추정
coeftest(arma11_2)
coeftest(arma21)
#모수신뢰구간추정
confint(arma11_2)
confint(arma21)
#모형진단(표준화,잔차도,잔차의 acf, 포토맨토우 검정)
tsdiag(arma11_2) #(잔차도,잔차의acf,p-value)그림이 나옴

##백색잡음과정
#방범1
set.seed(1) #난수발생할때 사용
whitenoise<-rnorm(1000)
par(mfrow=c(1,1))
plot(whitenoise,type="l")
#방법2
whitenoise1<-arima.sim(list(),n=1000)
plot(whitenoise1,type="l")
#정상성 test
adf.test(whitenoise1)
    # 이론상으로는 평균, 분산, 자기공분산함수가 t에 의존x
    # R에서 그래프상으로도 확인이 가능
##확률보행과정
set.seed(1)
x<-rep(NA,100)
e<-rnorm(1000)
for(t in 2:1000){
  x[1]<-e[1]
  x[t]<-x[t-1]+e[t]
}
par(mfrow=c(1,1))
plot(x,type="l")
#확률보행 acf,pact
par(mfrow=c(2,1))
acf(x)
pacf(x)
#정상성 test
adf.test(x) # p-value값이 0.356으로 유의수준 0.05보다
            # 크기때문에 귀무가설을 채택/비정상시계열