#교통사고
accident<-read.csv("C:/Users/Administrator/Desktop/22_2013년+연령층별+성별+사상자.csv")
accident
ACD<-as.matrix(accident)
D<-ACD[(which(ACD[,2]=="사망자수")),][-10,]
H<-ACD[(which(ACD[,2]=="부상자수")),][-10,]
D
H
install.packages("pyramid")
library(pyramid)
ages<-D[,"연령"]
D.man<-as.numeric(D[,"남"])
D.woman<-as.numeric(D[,"여"])
H.man<-as.numeric(H[,"남"])
H.woman<-as.numeric(H[,"여"])
data.D<-data.frame(D.man,D.woman,ages)
data.H<-data.frame(H.man/100,H.woman/100,ages)
pyramid(data.D,Laxis=seq(0,800,100),main="연령별 사망자 수")
pyramid(data.H,Laxis=seq(0,500,100),main="연령별 부상자 수(단위:100명)")