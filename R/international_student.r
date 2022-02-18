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