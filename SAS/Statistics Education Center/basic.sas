DATA students; 

INPUT id name $3-20 id_num gender $ dept $ exam1 exam2 exam3;

CARDS;

1 song jung ki        1905 m stat 30 30 40

2 song hye kyo      2009 f cs 30 30 40

3 hong gil dong      1750 m math 29 28 27

4 kong jui                1810 f cs 20 20 30

5 sim chung           1880 f math 29 28 27

;

RUN;

data students2;

input id exam4;

cards;

1 30

2 60

3 70

4 80

5 70

;

run;

PROC SORT data=students;

 BY id;

RUN;

PROC SORT data=students2;

 BY id;

RUN;

data students3;

merge students students2;

by id;

run;

proc print data=students3;

run;

 

data a;

input x y $;

cards;

1 f

2 f

3 m

4 m

5 f

6 m

7 m

8 f

9 f

10 f

;

run;

data b;

input x y $ z;

cards;

11 f 0

12 f 0

13 m 0

14 m 0

15 m 0

16 f 0

17 m 0

18 m 0

19 f 0

20 f 0

;

run;

data c;

set a b;

run;

proc print data=c; run;

 

data new3;

set a b;

run;

proc univariate data=new3;

run;

proc freq data=new3;

table x;

run;

 

data ex;

 

x1=x1=abs(-3.5);

x2=max(1,3,5);

x3=min(10,20);

x4=mod(15,4);

x5=sign(-3.14);

x6=sqrt(49);

 

y1=ceil(3.58);

y2=floor(-5.4);

y3=int(-1.58);

y4=round(132.46,0.1);

 

z1=exp(1);

z2=log(10);

z3=log10(100);

 

v1=mean(1,2,3,4,5);

v2=sum(1,2,3,4,5);

v3=std(1,2,3,4,5);

v4=var(1,2,3,4,5);

v5=cv(1,2,3,4,5);

v6=range(1,2,3,4,5);

v7=stderr(1,2,3,4,5);

v8=kurtosis(1,2,3,4,5);

v9=skewness(1,2,3,4,5);

run;

proc print data=ex; run;

 

data b20;

input name $ sex $ dist_code $ exam1-exam3 @@;

cards;

songjungki m 11055 96 89 93

songhyekyo f 11235 98 91 94

kimyeona f 21345 83 94 82

kimyeongcheol m 23012 83 82 96

;

run;

proc print data=b20;run;

data b21;

set b20;

sum=exam1+exam2+exam3;

average1=sum/3;

average2=exam1*0.3+exam2*0.4+exam3*0.3;

new_conde=substr(dist_code,1,2);

run;

proc print data=b21;run;

 

DATA B22 ;

SET B21 ;

average = round(average1, .1);

join = name || average;

year = substr(dist_code,1,2);

new_name = translate(name,'_',' ');

com1 = compress(name);

com2 = compress(new_name,'_');

RUN ;

proc print data=b22;run;

 

data sales;

input cd $ 23. sales;

cards;

3205057005677097810101 3715

3207011012357114910101 2150

2301052037643400811209 1252

2301052808983407912209 1063

3137033924556215112202 1354

;

run;

proc print data=sales;run;

data tsales1;

set sales;

sido=substr(cd,1,1);

run;

proc means data=tsales1;

var sales;

class sido;

run;

data tsales2;

set sales;

sido=substr(cd,1,1);

san2=substr(cd,18,2);

run;

proc freq data=tsales2;

tables san2*sido;

weight sales;

run;

 

data b23;

set b21;

if average1>=90 then grade='A';

else if average1>=80 then grade='B';

else if average1>=70 then grade='C';

else if average1>=60 then grade='D';

else grade='F';

run;

proc print data=b23; run;

 

data b24;

input name $ sex $ age @@;

cards;

sung m 33 park m 28 huh f 19 moon f 29 ahn m 34 kim m 39

;

run;

proc print data=b24;run;

 

data male female;

set b24;

if sex='m' then do;

gender='male';

output male;

end;

else do;

gender='female';

output female;

end;

run;

proc print data=male;run;

proc print data=female;run;

 

data paint;

do wood='strong','week';

do climate='dry','wet';

do i=1 to 5;

input durable @; output;

end;

end;

end;

drop i;

cards;

4.2 4.6 4.5 3.7 3.9

3.6 3.6 3.9 3.2 3.2

4.9 4.1 4.9 4.5 4.1

3.7 3.7 3.5 3.5 3.6

;

run;

proc print data=paint;run;

 

/* sql.kbl1 */

 

LIBNAME sql 'c:\sql';

DATA sql.kbl1;

    INPUT team $ name $ posi $ backn score freeth freetry reb

          assist foul time;

CARDS;

대우 김훈       F  7 24 1  2  1 4 3 38

대우 우지원     F 10 22 7  8  8 2 2 36

기아 강동희     G  5 14 5  6  2 7 0 32

기아 리드       C 22 27 5  9 19 1 4 35

삼성 문경은     F 14 37 9 11  2 3 2 40

삼성 스트릭랜   C 55 45 5  9 14 1 4 40

나래 정인교     G  5 28 8 10  2 2 2 36

나래 주희정     G 15 11 1  1  2 2 5 38

나산 조던       G  9 23 7  9  2 4 0 34

나산 이민형     F 14 14 2  3  3 3 0 36

동양 그레이     G  9 33 1  3 14 1 2 40

동양 전희철     F 13 16 3  6  8 1 2 32

;

RUN;

 

/* sql.kbl2 */

 

DATA sql.kbl2;

    INPUT name $ backn suc2p try2p suc3p try3p;

CARDS;

김훈        7 10 11 1  4

우지원     10  6 10 1  4

강동희      5  3  6 1  3

리드       22 11 15 0  1

문경은     14  5 11 6 11

스트릭랜   55 20 31 0  0

정인교      5  4  7 4 12

주희정     15  5  6 0  0

조던        9  5  8 2  8

이민형     14  3  6 2  5

그레이      9 14 18 1  3

전희철     13  2  7 3  6

;

RUN;

 

 

/* sql.kbl3 */

 

DATA sql.kbl3;

    INPUT team $ name $ posi $ backnum score freeth freetry reb

          assist foul time;

CARDS;

대우 데이비스   F 44 21 1  2  7 2 1 35

대우 우지원     F 10 22 3  4  3 2 4 37

기아 허재       G  9 24 4  4  7 2 3 38

기아 김영만     F 11 18 4  4  3 3 2 36

삼성 문경은     F 14 16 9 11  5 4 2 40

삼성 스트릭랜   C 55 27 5  5 12 0 1 34

나래 장윤섭     F 13 18 3  3  6 1 3 27

나래 윌리포드   C 22 22 1  4 16 1 3 38

나산 조던       G  9 28 5 13  3 3 0 40

나산 이민형     F 14 21 1  1  5 0 3 38

동양 그레이     G  9 21 2  4  3 2 4 38

동양 김병철     G 10 23 5  6  8 6 3 40

;

RUN;

 

 

 

/* ex 5.1 : 테이블에서 특정 열을 추출하기*/

 

PROC SQL;

    SELECT * FROM sql.kbl1;   /* 모든 열  불러오기 = 기본 데이터셋과 동일 */

RUN;

 

PROC SQL;

    SELECT team, posi FROM sql.kbl1;  /* 특정 열(team, posi) 불러오기 */

RUN;

 

/* 지정된 열만 제외*/

 

PROC SQL;

    SELECT * FROM sql.kbl1(DROP=assist);   /* 어시스트(assist) 제외한 모든 열  */

RUN;

 

 

 

/* ex 5.2 : 중복된 행을 제거하기*/

 

PROC SQL;

    SELECT DISTINCT team, posi FROM sql.kbl1; /* 특정 열(team, posi) 제거하고 출력 */

RUN;

 

 

/* ex 5.3 : 수식을 이용하여 새로운 열을 생성하기*/

 

TITLE '자유투 성공률';

PROC SQL;

    SELECT name, freeth, (freeth/freetry)*100 AS percent   /*수식결과를 percent로 출력 */

           FROM sql.kbl1;

RUN;

 

 

/* ex 5.4 : 조건식을 이용하기*/

 

/* CASE 뒤에 반드시 END로 끝내야 함 */

 

/* 자유투 성공률이 60 퍼센트 미만인 선수에 대해서 **** 표시하여 출력 예 */

 

TITLE '자유투 성공률이 낮은 선수';

PROC SQL;

    SELECT name, freeth, (freeth/freetry)*100 AS percent,

        CASE

            WHEN CALCULATED percent<60 THEN '****'   /* select문에서 새로 생성된 열을 이용할 경우에 반드시 CALCULATED를 표시해야 함*/

            ELSE '  '

        END                      

        FROM sql.kbl1;

RUN;

 

 

/* ex 5.5 : 출력형식과 레이블의 지정*/

 

PROC SQL;

    SELECT name, freeth, (freeth/freetry)*100 AS percent

        FORMAT=4.1 LABEL='백분율'

        FROM sql.kbl1;

RUN;

 

 

/* ex 5.6 : 테이블의 정렬*/

/* 포지션 알파벳 순으로 정렬 후 같은 포지션내에서 득점 순위로 정렬*/

 

TITLE '포지션별 득점 순위';

PROC SQL;

    SELECT name, posi, score FROM sql.kbl1

        ORDER BY posi, score;   

RUN;

 

/* 새로 생성한 열의 변수이름을 지정하지 않은 경우에 그 변수에 의해 정렬하고자 할때는 */

/* ORDER BY 명령어 뒤에 해당되는 변수의 위치를 지정하면 됨 */

 

SELECT name, freeth, (freeth/freetry)*100 FORMAT=4.1 LABEL='백분율'

    FROM sql.kbl1

    ORDER BY 3;    /*해당되는 변수의 위치 지정 */

 

 

/* ex 5.7 : 함수를 이용한 테이블의 요약*/

 

TITLE ' ';

SELECT AVG(freeth/freetry*100) AS avgper

    FORMAT=4.1 LABEL='평균 자유투 성공률 '

    FROM sql.kbl1;

 

SELECT COUNT(*) LABEL='행의 수' FROM sql.kbl1;

 

SELECT MIN(score) LABEL='최하 득점',

             MAX(score) LABEL='최고 득점'

    FROM sql.kbl1;

 

SELECT SUM(score) LABEL='총득점' FROM sql.kbl1;

 

 

/* ex 5.8 : 그룹별 데이터 처리*/

 

PROC SQL;

TITLE '포지션별 자유투 성공률';

    SELECT posi, AVG(freeth/freetry*100) AS avgper

        FORMAT=4.1 LABEL='평균 자유투 성공률'

        FROM sql.kbl1

        GROUP BY posi;

 

TITLE '포지션별 선수 수';

SELECT posi, count(posi) FROM sql.kbl1

    GROUP BY posi;

 

 

/* ex 5.9 : 조건문을 이용한 데이터의 추출*/

 

PROC SQL;

TITLE '자유투 성공률이 높은 팀';

SELECT team, avg(freeth/freetry*100) AS avgper 

    FORMAT=4.1 LABEL=' 자유투 성공률'

    FROM sql.kbl1 GROUP BY team

    HAVING avgper>70;

RUN;

 

PROC SQL;

TITLE '가드의 자유투 성공률';

    SELECT posi, name, avg(freeth/freetry*100) AS avgper 

        FORMAT=4.1 LABEL='자유투 성공률'

        FROM sql.kbl1

        WHERE posi='G'

        ORDER BY avgper;

RUN;

 

PROC SQL;

TITLE '가드의 평균 자유투 성공률이 높은 팀';

    SELECT team, avg(freeth/freetry*100) AS avgper 

        FORMAT=4.1 LABEL=' 자유투 성공률' FROM sql.kbl1

        WHERE posi='G'

        GROUP BY team

        HAVING avgper>70;

RUN;

 

 

/* ex 5.10 : 두개의 테이블로부터 데이터 추출*/

 

PROC SQL;

TITLE '두 경기에 모두 출전한 선수';

    SELECT name FROM sql.kbl1

    INTERSECT

    SELECT name FROM sql.kbl3;

RUN;

 

PROC SQL;

TITLE '12월 경기에만 출전한 선수';

    SELECT team, name FROM sql.kbl1

    EXCEPT

    SELECT team, name FROM sql.kbl3;

RUN;

 

PROC SQL;

TITLE '나래팀 출전 선수';

    SELECT team, name FROM sql.kbl1 WHERE team='나래'

    UNION

    SELECT team, name FROM sql.kbl3 WHERE team='나래';

RUN;

 

 

/* ex 5.11 : UNION 명령어를 이용한 데이터의 요약*/

 

PROC SQL;

TITLE '두 경기의 평균 득점';

    SELECT '12월 경기:', avg(score) FORMAT=5.2 LABEL='평균 득점'

    FROM sql.kbl1

    UNION

SELECT '2월 경기:', avg(score) FORMAT=5.2 LABEL=' 평균 득점'

    FROM sql.kbl3;

RUN;

 

 

/* ex 5.12 : 새로운 테이블의 생성*/

 

TITLE '포지션별  자유투 성공률';

PROC SQL;

    CREATE TABLE sql.fthrow AS    /* 새로운 테이블을 만들고 결과는 SQL.FTHROW 이름으로 저장 */

        SELECT posi, avg(freeth/freetry*100) AS avgper

FORMAT=4.1 LABEL='자유투 성공률'

        FROM sql.kbl1 GROUP BY posi;

    SELECT * from sql.fthrow;

RUN;

 

 

/* p. 138 */

/* sql.kbl1 에서 네 개의 열을 선택하여 포지션이 가드인 선수만을 모아 */

/* sql.score라는 테이블 새로 만들어 보자.*/

PROC SQL;

    CREATE TABLE sql.score AS SELECT team, name, posi, score

        FROM sql.kbl1 WHERE posi='G';

    SELECT * FROM sql.score;

RUN;

 

 

/* ex 5.13  : INSERT 문을 이용한 행 끼워 넣기*/

 

PROC SQL;

    INSERT INTO sql.score

        SELECT team, name, posi, score FROM sql.kbl1

        WHERE team IN ('동양');

    SELECT * FROM sql.score;

RUN;

 

 

/* ex 5.14 : SET 문을 이용한 행 끼워 넣기*/

 

PROC SQL;

INSERT INTO sql.score

  SET team='나래',

        name='윌리포드',

        posi='C',

        score=31;

SELECT * FROM sql.score;

 

 

/* ex 5.15 : VALUES 문을 이용한 행 끼워 넣기 */

 

PROC SQL;

INSERT INTO sql.score

  VALUES ('기아','김유택','F',8)

  VALUES ('기아','김영만','F',12);

SELECT * FROM sql.score;

 

 

/* ex 5.16  : UPDATE 문을 이용한 데이터의 수정*/

/*

PROC SQL; /* Insert this PROC SQL */

   /* CREATE TABLE sql.score AS SELECT team, name, posi, score

        FROM sql.kbl1 WHERE posi='G';

    SELECT * FROM sql.score; */

/*RUN;*/

 

PROC SQL;

UPDATE sql.score

  SET score=score*1.5;

SELECT * FROM sql.score;

 

 

/* ex 5.17   : UPDATE 문과 WHERE 문의 이용 */

/*

PROC SQL; /* Insert this PROC SQL */

  /*  CREATE TABLE sql.score AS SELECT team, name, posi, score

        FROM sql.kbl1 WHERE posi='G';

    SELECT * FROM sql.score;

/*RUN;*/

 

PROC SQL;

UPDATE sql.score

  SET score=score+5

  WHERE team IN ('동양');

UPDATE sql.score

  SET score=score-5

  WHERE team IN ('나래');

SELECT * FROM sql.score;

 

 

/* p. 142 */

 

PROC SQL; /* Insert this PROC SQL */

    CREATE TABLE sql.score AS SELECT team, name, posi, score

        FROM sql.kbl1 WHERE posi='G';

    SELECT * FROM sql.score;

RUN;

 

UPDATE sql.score

  SET score=score+

    CASE WHEN team IN ('동양') THEN  5

         WHEN team IN ('나래') THEN -5

         ELSE 0

    END;

 

 

/* ex 5.18  : ADD 명령어를 이용한 새로운 열의 생성*/

 

PROC SQL;

ALTER TABLE sql.kbl1

  ADD pof num LABEL='자유투 성공률' FORMAT 6.2;

SELECT team, name, posi, score, pof

  FROM sql.kbl1

  WHERE posi='G';

 

UPDATE sql.kbl1

  SET pof=(freeth/freetry)*100;

SELECT team, name, posi, score, pof

  FROM sql.kbl1

  WHERE posi='G';

 

 

/* p. 144 */

 

CREATE TABLE sql.pof AS

SELECT team, name, posi, score, (freeth/freetry)*100 AS pof

    LABEL='자유투 성공률' FORMAT 6.2

  FROM sql.kbl1

  WHERE posi='G';

SELECT * FROM sql.pof;

 

 

/* ex 5.19 */

 

PROC SQL;

  CREATE VIEW sql.view1 AS

  SELECT team LABEL=' 구단',

         COUNT(team) AS number LABEL=' 선수 수',

         SUM(score) AS tot LABEL='총득점',

         AVG(score) AS aos FORMAT=5.2 LABEL='평균득점'

   FROM sql.kbl1

   GROUP BY team;

SELECT * FROM sql.view1;

 

 

/* p. 146 */

 

DESCRIBE VIEW sql.view1;

 

DESCRIBE TABLE sql.kbl1;

 

 

/* p. 147 */

 

PROC MEANS DATA=sql.view1 MAXDEC=2;

  VAR tot aos;

RUN;

 

 

/* p. 148 */

 

PROC SQL; 

CREATE TABLE sql.kbl1 AS

SELECT team, name, posi

  FROM sql.kbl1;

 

PROC MEANS DATA=sql.view1 MAXDEC=2;

  VAR tot aos;

RUN;

 

 

/* ex 5.20 */

 

DATA so2;

    INPUT city $ so2;

CARDS;

서울    0.013

부산    0.022

;

RUN;

 

DATA co;

    INPUT city $ co;

CARDS;

부산    1.2

대구    1.0

인천    1.3

;

RUN;

 

PROC SQL;

  SELECT * FROM so2, co;

 

 

/* p. 150 */

 

PROC SQL;

  SELECT * FROM so2, co

  WHERE so2.city=co.city;

 

 

/* p. 150 */

 

LIBNAME sql 'c:\sql';

DATA sql.kbl1;

    INPUT team $ name $ posi $ backn score freeth freetry reb

          assist foul time;

CARDS;

대우 김훈       F  7 24 1  2  1 4 3 38

대우 우지원     F 10 22 7  8  8 2 2 36

기아 강동희     G  5 14 5  6  2 7 0 32

기아 리드       C 22 27 5  9 19 1 4 35

삼성 문경은     F 14 37 9 11  2 3 2 40

삼성 스트릭랜   C 55 45 5  9 14 1 4 40

나래 정인교     G  5 28 8 10  2 2 2 36

나래 주희정     G 15 11 1  1  2 2 5 38

나산 조던       G  9 23 7  9  2 4 0 34

나산 이민형     F 14 14 2  3  3 3 0 36

동양 그레이     G  9 33 1  3 14 1 2 40

동양 전희철     F 13 16 3  6  8 1 2 32

;

RUN;

 

DATA sql.kbl2;

    INPUT name $ backn suc2p try2p suc3p try3p;

CARDS;

김훈        7 10 11 1  4

우지원     10  6 10 1  4

강동희      5  3  6 1  3

리드       22 11 15 0  1

문경은     14  5 11 6 11

스트릭랜   55 20 31 0  0

정인교      5  4  7 4 12

주희정     15  5  6 0  0

조던        9  5  8 2  8

이민형     14  3  6 2  5

그레이      9 14 18 1  3

전희철     13  2  7 3  6

;

RUN;

 

DATA sql.kbl3;

    INPUT team $ name $ posi $ backnum score freeth freetry reb

          assist foul time;

CARDS;

대우 데이비스   F 44 21 1  2  7 2 1 35

대우 우지원     F 10 22 3  4  3 2 4 37

기아 허재       G  9 24 4  4  7 2 3 38

기아 김영만     F 11 18 4  4  3 3 2 36

삼성 문경은     F 14 16 9 11  5 4 2 40

삼성 스트릭랜   C 55 27 5  5 12 0 1 34

나래 장윤섭     F 13 18 3  3  6 1 3 27

나래 윌리포드   C 22 22 1  4 16 1 3 38

나산 조던       G  9 28 5 13  3 3 0 40

나산 이민형     F 14 21 1  1  5 0 3 38

동양 그레이     G  9 21 2  4  3 2 4 38

동양 김병철     G 10 23 5  6  8 6 3 40

;

RUN;

 

PROC SQL;

SELECT kbl1.team, kbl1.name, kbl1.posi, suc3p,

       kbl1.score AS score1, kbl3.score AS score2

    FROM sql.kbl1, sql.kbl2, sql.kbl3

    WHERE kbl1.name=kbl2.name=kbl3.name

          AND kbl3.posi='G';

 

 

/* p. 151 */

 

SELECT k1.team, k1.name, k1.posi, suc3p,

       k1.score AS score1, k3.score AS score2

    FROM sql.kbl1 AS k1, sql.kbl2 AS k2, sql.kbl3 AS k3

    WHERE k1.name=k2.name=k3.name

            AND k3.posi='G';

 

 

/* ex 5.21 */

 

PROC SQL;

SELECT k1.name, k1.posi, k1.reb as reb1, k3.reb as reb2

   FROM sql.kbl1 AS k1 LEFT JOIN sql.kbl3 as k3

   ON k1.name=k3.name;

 

PROC SQL;

SELECT k1.name, k1.posi, k1.reb as reb1, k3.reb as reb2

   FROM sql.kbl1 AS k1 LEFT JOIN sql.kbl3 as k3

   ON k1.name=k3.name AND k3.posi='G';

 

 

/* ex 5.22 */

 

PROC SQL;

SELECT k1.name, k1.posi, k1.reb as reb1, k3.reb as reb2

   FROM sql.kbl1 AS k1 RIGHT JOIN sql.kbl3 as k3

   ON k1.name=k3.name;

 

 

/* ex 5.23 */

 

PROC SQL;

SELECT k1.name, k1.posi, k1.reb AS reb1, k3.reb AS reb2

   FROM sql.kbl1 AS k1 FULL JOIN sql.kbl3 AS k3

   ON k1.name=k3.name;

 

 

/* ex 5.24 */

 

PROC SQL;

SELECT k1.posi, k1.name, COALESCE(k3.score, k1.score)

LABEL='최근 득점'

   FROM sql.kbl1 AS k1 LEFT JOIN sql.kbl3 AS k3

   ON k1.name=k3.name;

QUIT;

 

 

/* 매크로 */

 

DATA bankdata;

    INPUT name $ bis bcredit per @@;

CARDS;

조흥  6.50 26232  7.0 상업  7.62 14512  4.8 제일 -2.70 30559 11.4

한일  6.90 13224  3.6 서울  0.97 24040 10.3 외환  6.79 25176  5.7

국민  9.78  8921  3.2 주택 10.29  5887  2.0 신한 10.29 11066  4.1

한미  8.57  3293  3.4 동화  5.34  6023  7.9 동남  4.54  2930  5.7

대동  2.98  4869  9.6 하나  9.29  2494  2.4 보람  9.32  2894  3.2

평화  5.45  2283 4.5

;

RUN;

/* ex 4.26 :연결 연산자 || 와 LEFT(_N_)의 이용*/

 

%LET b1='해당사항없음';

%LET b2='경영개선권고';

%LET b3='경영개선조치';

DATA new5; SET bankdata; 

  trt=SYMGET('b'||LEFT(_n_)); 

RUN;

PROC PRINT; RUN;

 

 

/* ex 4.27 :SYMPUT 함수의 사용*/

 

DATA bank2;

  INPUT name $ bis @@;

  CALL SYMPUT('bis', bis);     /*bis변수에 bis의 값 할당 */

  CALL SYMPUT('name', name);

  CALL SYMPUT('test', 'testing value');  /*test변수에 직접 표시. 인용부호와 함께*/

CARDS;

상업   7.62 제일  -2.70 서울   0.97 국민   9.78

;

RUN;

 

%PUT &bis;       /*bis의 최종값이  출력됨(Log창 확인) */

%PUT &name;   /*name값의 최종값이  출력됨(Log창 확인)  */

%PUT &test;      /*test값 'testing value'가  출력됨(Log창 확인)   */

 

 

/* p. 104 : PUT문을 사용한 출력형식 변경*/

 

DATA bank2;

  INPUT name $ bis @@;

  IF _N_=2 then CALL SYMPUT('bis', bis); 

CARDS;

상업   7.62 제일  -2.70 서울   0.97 국민   9.78

;

RUN;

 

%PUT &bis; /* bis에 -2.7이 저장됨(LOG창 확인) */

 

 

/* ex 4.28 : PUT문을 사용한 출력형식 변경*/

 

DATA day;

  INPUT samil mmddyy.;

  CALL SYMPUT('day', PUT(samil, worddate.));   /*66페이지참조*/

CARDS;

030198       

;/*월-일-년 형식*/

RUN;

 

%PUT &day;  /* 출력 값 March 1, 1998 */