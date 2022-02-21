## 나정수
## 2016.11.15
## 남북한의 인구
library(ggplot2)
## Warning: package 'ggplot2' was built under R version 3.3.2
library(ggmap)
## Warning: package 'ggmap' was built under R version 3.3.2
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
##         city       pop
## 1      Seoul 9,794,304
## 2      Busan 3,414,950
## 3    Incheon 2,662,509
## 4      Daegu 2,446,418
## 5    Daejeon 1,501,859
## 6    Gwangju 1,469,293
## 7      Ulsan 1,082,567
## 8      Haeju   273,300
## 9    Hamhung   768,551
## 10   Kaesong   308,440
## 11   Kanggye   251,971
## 12     Nampo   366,341
## 13 Pyongyang 3,255,288
## 14   Sinuiju   359,341
dat1$pop<-as.numeric(gsub(",", "", dat1$pop));
dat1
##         city     pop
## 1      Seoul 9794304
## 2      Busan 3414950
## 3    Incheon 2662509
## 4      Daegu 2446418
## 5    Daejeon 1501859
## 6    Gwangju 1469293
## 7      Ulsan 1082567
## 8      Haeju  273300
## 9    Hamhung  768551
## 10   Kaesong  308440
## 11   Kanggye  251971
## 12     Nampo  366341
## 13 Pyongyang 3255288
## 14   Sinuiju  359341
latlon<-geocode(dat1$city)
## Information from URL : http://maps.googleapis.com/maps/api/geocode/json?address=Seoul&sensor=false
## Information from URL : http://maps.googleapis.com/maps/api/geocode/json?address=Busan&sensor=false
## Information from URL : http://maps.googleapis.com/maps/api/geocode/json?address=Incheon&sensor=false
## Information from URL : http://maps.googleapis.com/maps/api/geocode/json?address=Daegu&sensor=false
## Information from URL : http://maps.googleapis.com/maps/api/geocode/json?address=Daejeon&sensor=false
## Information from URL : http://maps.googleapis.com/maps/api/geocode/json?address=Gwangju&sensor=false
## Information from URL : http://maps.googleapis.com/maps/api/geocode/json?address=Ulsan&sensor=false
## Information from URL : http://maps.googleapis.com/maps/api/geocode/json?address=Haeju&sensor=false
## Information from URL : http://maps.googleapis.com/maps/api/geocode/json?address=Hamhung&sensor=false
## Information from URL : http://maps.googleapis.com/maps/api/geocode/json?address=Kaesong&sensor=false
## .
## Information from URL : http://maps.googleapis.com/maps/api/geocode/json?address=Kanggye&sensor=false
## .
## Information from URL : http://maps.googleapis.com/maps/api/geocode/json?address=Nampo&sensor=false
## .
## Information from URL : http://maps.googleapis.com/maps/api/geocode/json?address=Pyongyang&sensor=false
## .
## Information from URL : http://maps.googleapis.com/maps/api/geocode/json?address=Sinuiju&sensor=false
dat1<-cbind(dat1,latlon) 
dat1
##         city     pop      lon      lat
## 1      Seoul 9794304 126.9780 37.56654
## 2      Busan 3414950 129.0756 35.17955
## 3    Incheon 2662509 126.7052 37.45626
## 4      Daegu 2446418 128.6014 35.87144
## 5    Daejeon 1501859 127.3845 36.35041
## 6    Gwangju 1469293 126.8526 35.15955
## 7      Ulsan 1082567 129.3114 35.53838
## 8      Haeju  273300 125.7079 38.03750
## 9    Hamhung  768551 127.6125 39.98380
## 10   Kaesong  308440 126.5878 37.93819
## 11   Kanggye  251971 126.5991 40.96767
## 12     Nampo  366341 125.3247 38.75226
## 13 Pyongyang 3255288 125.7625 39.03922
## 14   Sinuiju  359341 124.4489 40.08232
koreamap<-ggmap(get_map(location="Korea",zoom=6), extent="panel")
## Map from URL : http://maps.googleapis.com/maps/api/staticmap?center=Korea&zoom=6&size=640x640&scale=2&maptype=terrain&language=en-EN&sensor=false
## .
## Information from URL : http://maps.googleapis.com/maps/api/geocode/json?address=Korea&sensor=false
koreamap
## koreamap.jpg
circle_scale=0.000005
koreamap+geom_point(aes(x=lon, y=lat),data=dat1, col='purple',
                    alpha=0.4, size=dat1$pop*circle_scale)
## koreamapcircle