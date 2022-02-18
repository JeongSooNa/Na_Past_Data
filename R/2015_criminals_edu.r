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