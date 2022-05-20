##회귀분석 실습
#중회귀분석
install.packages("perturb") #condition
install.packages("car")
install.packages("lmtest")
library(perturb)
library(car)
library(lmtest)

#데이터 읽기
X<-read.csv("C:/Users/CBNU/Desktop/국가지하수+오염감시전용측정망+2013년.csv")
str(X)
GW<-data.frame(X$심도,X$pH,X$EC,X$DO)
names(GW)<-c("Depth","pH","EC","DO")
attach(GW)

#상관관계
cor(GW)

#상관관계 낮은 (pH, EC) 회귀분석
ph.1<-lm(Depth~pH, GW)
summary(ph.1)
ec.1<-lm(Depth~EC, GW)
summary(ec.1)
pe<-lm(Depth~pH+EC, GW)
summary(pe)

#상관계수 유의한 (DO, EC) 회귀분석
do.1<-lm(Depth~DO, GW)
summary(do.1)
de<-lm(Depth~DO+EC, GW)
summary(de)

#다중공선성
model<-lm(Depth~.,GW)
summary(model)
#vif
vif(model)
#condition
colldiag(model)

#EC 와 DO 상관관계
cor(GW$EC,GW$Depth)
cor(GW$DO,GW$Depth)

#최종모형
final<-lm(Depth~EC+DO, GW)
summary(final)
final2<-lm(Depth~EC, GW)
summary(final2)

##잔차분석
#정규성
shapiro.test(resid(final2))
#잔차의 등분산성
plot(resid(final2))
#잔차의 독립성
dwtest(final2)