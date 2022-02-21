#남북한의 인구
install.packages("ggplot2")
install.packages("ggmap")
library(ggplot2)
library(ggmap)
dat1<-read.table(textConnection("
Seoul     9,794,304 
Busan     3,414,950  
Incheon   2,662,509 
Daegu     2,446,418 
Daejeon   1,501,859 
Gwangju   1,469,293 
Ulsan     1,082,567 
Haeju     273,300 
Hamhung   768,551 
Kaesong   308,440 
Kanggye   251,971 
Nampo     366,341 
Pyongyang 3,255,288 
Sinuiju   359,341 
 "),header=FALSE,col.names=c("city","pop"),stringsAsFactors = F)
dat1
dat1$pop<-as.numeric(gsub(",", "", dat1$pop));
dat1
latlon<-geocode(dat1$city)
dat1<-cbind(dat1,latlon) 
dat1
koreamap<-ggmap(get_map(location="Korea",zoom=6), extent="panel")
koreamap
circle_scale=0.000005
koreamap+geom_point(aes(x=lon, y=lat),data=dat1, col='purple',
                   alpha=0.4, size=dat1$pop*circle_scale)