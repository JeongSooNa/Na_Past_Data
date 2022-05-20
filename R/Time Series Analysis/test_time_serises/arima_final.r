#준비
install.packages("forecast")
install.packages("lmtest")
library(forecast)
library(lmtest)

#잉글랜드 중부의 연평균 기온 데이터
born<-read.csv("C:/Users/cbnu/Desktop/average-annual-temperature-centr.csv")
born_1<-born[,-1]
born_1<-born_1[-249][-249]

born<-ts(born_1,start=c(1723,1),frequency=1)
      # plot.ts를 이용하기 위해서 시계열 데이터로 변형
      # 1년 단위로 1723년부터 1970년 까지의 데이터
born
plot.ts(born)
      # 그래프만 보고 계절성이 없는 것으로 예상만 되기 때문에 ACF와 PACF를 그려봄
    
#원자료의 acf,pacf 확인
par(mfrow=c(2,1))
acf(born)
pacf(born)
par(mfrow=c(1,1))
      #PACF에서 판단이 어렵기 때문에 로그변환

#로그변환
lborn<-log(born)
plot.ts(lborn)
      #log변환을 통해 분산 안정화

#로그변환한 acf,pacf
par(mfrow=c(2,1))
acf(lborn)
pacf(lborn)
par(mfrow=c(1,1))
      #ACF에서 지수적 감소를 보이고, PACF 시차 1에서 절단되므로 AR(1)model로 추정
      #정상적으로 판단

#모형식별,모수추정
arima100<-arima(lborn,order=c(1,0,0))
arima101<-arima(lborn,order=c(1,0,1))
arima201<-arima(lborn,order=c(2,0,1))
arima102<-arima(lborn,order=c(1,0,2))
arima202<-arima(lborn,order=c(2,0,2))
summary(arima100)
summary(arima101)
summary(arima201)
summary(arima102)
summary(arima202)

      #aic가 작은 두개의 arima100model과 arima202model

coeftest(arima100) #lmtest
coeftest(arima202)

  #최종적으로 적합한 모델은 arima100과 arima202이나 coeftest결과
  #arima100model이 더 적합

auto.arima(born,stepwise=FALSE) #forecast
      #auto.arima 결과는 ARIMA(2,0,2)model이 적합하다고 나오나 신뢰도가 떨어진다.

#모형진단
tsdiag(arima100,gof.lag=24)
tsdiag(arima202,gof.lag=24)

#arima100가 더 적합한 모형이라 판단되어 ARIMA(100)채택