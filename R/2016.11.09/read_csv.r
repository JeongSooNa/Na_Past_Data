> #   hw3
> #1. Master.csv, Batting.csv, Salaries.csv을 읽어들여 data frame master, batting, salaries를 생성하시오.
> #   3 data frame의  행의수와 열의 수는?
> setwd("C:/baseballdatabank-master_2016-03-02 (3)/baseballdatabank-master/core")
> getwd()
[1] "C:/baseballdatabank-master_2016-03-02 (3)/baseballdatabank-master/core"
> Master=read.csv("Master.csv")
> Batting=read.csv("Batting.csv")
> Salaries=read.csv("Salaries.csv")
> #2. data frame batting 내에 변수 OBP를 생성하시오.
> Batting$OBP=((Batting$H+Batting$BB+Batting$HBP)/(Batting$AB+Batting$BB+Batting$HBP+Batting$SF))
> batting<-subset(Batting,!is.na(OBP))
> head(Batting)
   playerID yearID stint teamID lgID  G  AB  R  H X2B X3B HR RBI SB CS BB SO IBB
1 abercda01   1871     1    TRO <NA>  1   4  0  0   0   0  0   0  0  0  0  0  NA
2  addybo01   1871     1    RC1 <NA> 25 118 30 32   6   0  0  13  8  1  4  0  NA
3 allisar01   1871     1    CL1 <NA> 29 137 28 40   4   5  0  19  3  1  2  5  NA
4 allisdo01   1871     1    WS3 <NA> 27 133 28 44  10   2  2  27  1  1  0  2  NA
5 ansonca01   1871     1    RC1 <NA> 25 120 29 39  11   3  0  16  6  2  2  1  NA
6 armstbo01   1871     1    FW1 <NA> 12  49  9 11   2   1  0   5  0  1  0  1  NA
  HBP SH SF GIDP OBP
1  NA NA NA   NA  NA
2  NA NA NA   NA  NA
3  NA NA NA   NA  NA
4  NA NA NA   NA  NA
5  NA NA NA   NA  NA
6  NA NA NA   NA  NA
> #3. 3개의 data frame을 자료결합하여  data frame merged를 만드시오.
> #   merged 의 행의 수 와 열의 수는?
> merged=merge(Master,merge(Batting,Salaries,all=T),all=T)
> dim(merged)
[1] 102477     47
> merged[is.na(merged)]=0
There were 17 warnings (use warnings() to see them)
> head(merged)
   playerID birthYear birthMonth birthDay birthCountry birthState birthCity
1 aardsda01      1981         12       27          USA         CO    Denver
2 aardsda01      1981         12       27          USA         CO    Denver
3 aardsda01      1981         12       27          USA         CO    Denver
4 aardsda01      1981         12       27          USA         CO    Denver
5 aardsda01      1981         12       27          USA         CO    Denver
6 aardsda01      1981         12       27          USA         CO    Denver
  deathYear deathMonth deathDay deathCountry deathState deathCity nameFirst
1         0          0        0                                       David
2         0          0        0                                       David
3         0          0        0                                       David
4         0          0        0                                       David
5         0          0        0                                       David
6         0          0        0                                       David
  nameLast   nameGiven weight height bats throws      debut  finalGame  retroID
1  Aardsma David Allan    220     75    R      R 2004-04-06 2015-08-23 aardd001
2  Aardsma David Allan    220     75    R      R 2004-04-06 2015-08-23 aardd001
3  Aardsma David Allan    220     75    R      R 2004-04-06 2015-08-23 aardd001
4  Aardsma David Allan    220     75    R      R 2004-04-06 2015-08-23 aardd001
5  Aardsma David Allan    220     75    R      R 2004-04-06 2015-08-23 aardd001
6  Aardsma David Allan    220     75    R      R 2004-04-06 2015-08-23 aardd001
    bbrefID yearID teamID lgID stint  G AB R H X2B X3B HR RBI SB CS BB SO IBB HBP
1 aardsda01   2011    SEA   AL     0  0  0 0 0   0   0  0   0  0  0  0  0   0   0
2 aardsda01   2015    ATL   NL     1 33  1 0 0   0   0  0   0  0  0  0  1   0   0
3 aardsda01   2006    CHN   NL     1 45  2 0 0   0   0  0   0  0  0  0  0   0   0
4 aardsda01   2012    NYA   AL     1  1  0 0 0   0   0  0   0  0  0  0  0   0   0
5 aardsda01   2013    NYN   NL     1 43  0 0 0   0   0  0   0  0  0  0  0   0   0
6 aardsda01   2004    SFN   NL     1 11  0 0 0   0   0  0   0  0  0  0  0   0   0
  SH SF GIDP OBP  salary
1  0  0    0   0 4500000
2  0  0    0   0       0
3  1  0    0   0       0
4  0  0    0   0  500000
5  0  0    0   0       0
6  0  0    0   0  300000
> #4. 다음을 구하는 함수 salaries_OBP_stat 을 만드시오.
> #   인수 : yearStart, yearEnd, birthCountry,
> #   년도별, 국가별, salary의 평균, OBP평균을 구함.
> salaries_OBP_stat=function(yearStart,yearEnd,birthCountry){
+ x<-merged[which(merged[,"birthCountry"]==birthCountry),]
+ Avg_Salary<-mean(subset(x,yearID<=yearEnd&yearStart<=yearID)[,"salary"])
+ Avg_OBP<-mean(subset(x,yearID<=yearEnd&yearStart<=yearID)[,"OBP"])
+ return(c("birthCountry"=birthCountry,"yearStart"=yearStart,"yearEnd"=yearEnd,
+ "Avg_Salary"=Avg_Salary,"Avg_OBP"=Avg_OBP))
+ }
> salaries_OBP_stat(1990,2010,"USA")
       birthCountry           yearStart             yearEnd          Avg_Salary 
              "USA"              "1990"              "2010"  "1199532.18977482" 
            Avg_OBP 
"0.189260558776712" 
> #5. 4)에서 만든 함수를 사용하여
> #   한국, 일본, 미국 선수의 1990년이후 10년간씩 salary와 OBP의 평균을 구하시오.
> #   함수를 실행하는 방법 (1990-1999 까지 한국선수의 자료를 분석하고자 할 때)
> #   salaries_OPS_stat(1990, 1999, “South Korea”)
> kor1=salaries_OBP_stat(1990, 1999, "South Korea")
> kor2=salaries_OBP_stat(2000, 2009, "South Korea")
> kor3=salaries_OBP_stat(2010, 2015, "South Korea")
> jap1=salaries_OBP_stat(1990, 1999, "Japan")
> jap2=salaries_OBP_stat(2000, 2009, "Japan")
> jap3=salaries_OBP_stat(2010, 2015, "Japan")
> usa1=salaries_OBP_stat(1990, 1999, "USA")
> usa2=salaries_OBP_stat(2000, 2009, "USA")
> usa3=salaries_OBP_stat(2010, 2015, "USA")
> rbind(kor1,kor2,kor3,jap1,jap2,jap3,usa1,usa2,usa3)
     birthCountry  yearStart yearEnd Avg_Salary         Avg_OBP             
kor1 "South Korea" "1990"    "1999"  "486611.111111111" "0.0807981141314475"
kor2 "South Korea" "2000"    "2009"  "1552210.64285714" "0.165139685603642" 
kor3 "South Korea" "2010"    "2015"  "4313648.69230769" "0.258397871937141" 
jap1 "Japan"       "1990"    "1999"  "766000"           "0.073727753684735" 
jap2 "Japan"       "2000"    "2009"  "3090324.47712418" "0.188126343596635" 
jap3 "Japan"       "2010"    "2015"  "4754883.5952381"  "0.133461610585153" 
usa1 "USA"         "1990"    "1999"  "792302.570012019" "0.191517181206859" 
usa2 "USA"         "2000"    "2009"  "1536590.44977909" "0.187821338004505" 
usa3 "USA"         "2010"    "2015"  "2047103.08866046" "0.172686779962224"