#2015년 범죄자 교육정도
X<-read.csv("C:/Users/Administrator/Desktop/2015년 범죄자 교육정도.csv",sep=',')
X
attach(X)
X$초졸.<-as.numeric(X$초등학교.졸업.)+as.numeric(X$중학교.재중.)+as.numeric(X$중학교.중퇴.)
X$중졸.<-as.numeric(X$중학교.재중.)+as.numeric(X$중학교.중퇴.)+as.numeric(X$중학교.졸업.)
X$고졸.<-as.numeric(X$고등학교.졸업.)+as.numeric(X$대학.4년미만..재중.)+as.numeric(X$대학.4년미만..중퇴.)+as.numeric(X$대학.4년이상..재중.)+as.numeric(X$대학.4년이상..중퇴.)
X$대졸.<-as.numeric(X$대학.4년미만..졸업.)+as.numeric(X$대학.4년이상..졸업.)+as.numeric(X$대학원.재중.)+as.numeric(X$대학원.중퇴.)+as.numeric(X$대학원.졸업.)
X$기타.<-as.numeric(X$초등학교.재중.)+as.numeric(X$초등학교.중퇴.)+as.numeric(X$불취학)+as.numeric(X$기타)+as.numeric(X$미상)
Y<-matrix(c(X$초졸.,0,X$중졸.,0,X$고졸.,0,X$대졸.,0,X$기타.,0),ncol=39,byrow=T)
for(i in 1:5){
  Y[i,39]<-sum(Y[i,])
}
name<-as.character(X$범죄중분류)
rownames(Y)<-c("초졸","중졸","고졸","대졸","기타")
names(Y)<-c(name,"계")

Z<-as.data.frame(Y)
rownames(Z)<-c("초졸","중졸","고졸","대졸","기타")
names(Z)<-c(name,"계")
Z
Z$강력범죄<-(Z$살인기수+Z$살인미수등+Z$강도+Z$강간+Z$유사강간+Z$강제추행+Z$`기타 강간 강제추행 등`+Z$방화)/8
Z$절도범죄<-Z$절도
Z$폭력범죄<-(Z$상해+Z$폭행+Z$`체포 감금`+Z$협박+Z$`약취 유인`+Z$폭력행위등+Z$공갈+Z$손괴)/8
Z$지능범죄<-(Z$직무유기+Z$직권남용+Z$증수뢰+Z$통화+Z$`문서 인장`+Z$유가증권인지+Z$사기+Z$횡령+Z$배임)/9

CRIME<-matrix(c(Z$강력범죄,Z$절도범죄,Z$폭력범죄,Z$지능범죄,Z$계/38),ncol=5)
rownames(CRIME)<-c("초졸","중졸","고졸","대졸","기타")
colnames(CRIME)<-c("강력범죄","절도범죄","폭력범죄","지능범죄","전체평균")
CRIME
color<-c("lightskyblue","skyblue3","skyblue4","slategrey","grey30")
barplot(CRIME,col=color,xlab="교육정도에 따른 범죄",beside=T)
legend(27,40,rownames(CRIME),col=color,pch=16)
install.packages("plotrix")
library(plotrix)
ST<-t(CRIME)[-5,]
pie3D(ST[,1],explode=0.1,main="초등학교 졸업자의 범죄유형")
pie3D(ST[,2],explode=0.1,main="중학교 졸업자의 범죄유형")
pie3D(ST[,3],explode=0.1,main="고등학교 졸업자의 범죄유형")
pie3D(ST[,4],explode=0.1,main="대학교 졸업자의 범죄유형")

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

#외국인유학생
FO<-read.csv("C:/Users/Administrator/Desktop/국내유학중인+외국인유학생+데이터(2016년+12월기준).csv")
FO$국적명[which(FO$국적명=="중국")]
levels(FO$국적명)
C<-matrix(rep(0,8),ncol=8)
C[,1]<-length(FO$국적명[which(FO$국적명=="기타")])
C[,2]<-length(FO$국적명[which(FO$국적명=="러시아")])
C[,3]<-length(FO$국적명[which(FO$국적명=="몽골")])
C[,4]<-length(FO$국적명[which(FO$국적명=="베트남")])
C[,5]<-length(FO$국적명[which(FO$국적명=="우즈베키스탄")])
C[,6]<-length(FO$국적명[which(FO$국적명=="일본")])
C[,7]<-length(FO$국적명[which(FO$국적명=="중국")])
C[,8]<-length(FO$국적명[which(FO$국적명=="프랑스")])
colnames(C)<-c("기타","RUS","MNG","VNM","UZB","JAP","CHN","FRA")
names(C)<-c("기타","RUS","MNG","VNM","UZB","JAP","CHN","FRA")
C
install.packages("plotrix")
library(plotrix)
pie3D(C,explode=0.3,main="외국인유학생 국적")
FO$체류지.시도
levels(FO$체류지.시도)
D<-matrix(rep(0,18),ncol=18)
for(i in 1:18){
  D[,i]<-length(FO$체류지.시도[which(FO$체류지.시도==levels(FO$체류지.시도)[i])])
}
colnames(D)<-levels(FO$체류지.시도)
D_1<-as.data.frame(t(D))
D_1$위도<-c(37.809171,37.539606,35.379460,36.944881,35.168684,35.843905,36.336628,35.159702,37.557027,36.504597,1,35.536065,37.469882,34.745489,35.826092,33.389682,36.442907,36.764821)
D_1$경도<-c(128.387137, 127.524711, 128.255301, 128.815604, 126.849051, 128.562919, 127.398368, 129.062797, 126.991874, 127.228080,1, 129.288016, 126.579886, 126.925956, 127.288505, 126.542656, 126.784355, 127.657768)
install.packages("ggmap")
library(ggmap)
D.map<-get_map(location="Jeonju",zoom=7,maptype="roadmap",source="google")
ggmap(D.map)+geom_point(data=D_1,
                        aes(x=D_1$경도,y=D_1$위도,colour=D_1$V1,size=D_1$V1))
