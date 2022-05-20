/* sql.kbl1 */

LIBNAME sql 'c:\sql';
DATA sql.kbl1;
    INPUT posi $ team $ name $  backn score freeth freetry reb
          assist time foul;
CARDS;
F 대우 김훈         7 24 1  2  1 4 3 38
F 대우 우지원      10 22 7  8  8 2 2 36
G 기아 강동희       5 14 5  6  2 7 0 32
C 기아 리드        22 27 5  9 19 1 4 35
F 삼성 문경은      14 37 9 11  2 3 2 40
C 삼성 스트릭랜    55 45 5  9 14 1 4 40
G 나래 정인교       5 28 8 10  2 2 2 36
G 나래 주희정      15 11 1  1  2 2 5 38
G 나산 조던         9 23 7  9  2 4 0 34
F 나산 이민형      14 14 2  3  3 3 0 36
G 동양 그레이       9 33 1  3 14 1 2 40
F 동양 전희철      13 16 3  6  8 1 2 32
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


/* p. 123 */
/* sql를 이용하는 경우                                  */
/* sql.kbl1 테이블을 이용하여,                       */
/* 각 팀의 가드 진이 얻은 총득점을 계산하고,  */
/* 그 결과를 총득점 순서대로 출력                  */
PROC SQL;
    SELECT team, SUM(score) AS totscore FROM sql.kbl1  
    WHERE posi='G'
    GROUP BY team
    ORDER BY totscore;
RUN;

/* 기존의 SAS 프로그램을 이용하는 경우 */
PROC SUMMARY DATA=sql.kbl1;
    WHERE posi='G';
    CLASS team;
    VAR score;
    OUTPUT OUT=sumscore SUM=totscore;
RUN;
PROC SORT DATA=sumscore;
    BY totscore;
RUN;
PROC PRINT DATA=sumscore NOOBS;
    VAR team totscore;
    WHERE _type_=1;
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
    SELECT * FROM sql.kbl1
    UNION
    SELECT * FROM sql.kbl3 ;
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
/* ADD 명령어 이용시 열의 이름과 형태를 지정해야 함*/
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


/* ex 5.20 : 두 테이블의 내적 결합(inner join)*/

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
/*열인 도시명(CITY)이 일치하는 (부산) 행을 출력해보자 */
PROC SQL;
  SELECT * FROM so2, co
  WHERE so2.city=co.city;   /* 테이블이름.열이름 */


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

/*같은 이름의 열이 여러 개의 테이블에 있다면 주의가 필요 함.  */
/*즉 SELECT문에서 테이블의 이름과 열의 이름을 일일이 지정해야 함*/

PROC SQL;
SELECT kbl1.team, kbl1.name, kbl1.posi, suc3p,
       kbl1.score AS score1, kbl3.score AS score2
    FROM sql.kbl1, sql.kbl2, sql.kbl3
    WHERE kbl1.name=kbl2.name=kbl3.name
          AND kbl3.posi='G';


/* p. 151 */
/* Alias를 정의하여 사용 하는 예 */

SELECT k1.team, k1.name, k1.posi, suc3p,
       k1.score AS score1, k3.score AS score2
    FROM sql.kbl1 AS k1, sql.kbl2 AS k2, sql.kbl3 AS k3
    WHERE k1.name=k2.name=k3.name
            AND k3.posi='G';



/*외적결합은 동시에 두 개의 테이블만을 대상으로 함
   두 테이블의 행이 연결될 수 없는 부분은 결측값으로 처리하여 출력 됨.*/

/* ex 5.21 : 테이블의 좌측결합*/
/*좌측 테이블의 값은 모두 출력되고 결합된 테이블에서는 기준변수의 동일한 값만 출력 됨. */

PROC SQL;
SELECT k1.name, k1.posi, k1.reb as reb1, k3.reb as reb2
   FROM sql.kbl1 AS k1 LEFT JOIN sql.kbl3 as k3
   ON k1.name=k3.name;      /*조건 1개 일때*/

PROC SQL;
SELECT k1.name, k1.posi, k1.reb as reb1, k3.reb as reb2
   FROM sql.kbl1 AS k1 LEFT JOIN sql.kbl3 as k3
   ON k1.name=k3.name AND k3.posi='G';     /*조건 2개 일때 */


/* ex 5.22 : 테이블의 우측결합*/
/*우측 테이블의 값은 모두 출력되고 결합된 테이블에서는 기준변수의 동일한 값만 출력 됨.*/

PROC SQL;
SELECT k1.name, k1.posi, k1.reb as reb1, k3.reb as reb2
   FROM sql.kbl1 AS k1 RIGHT JOIN sql.kbl3 as k3
   ON k1.name=k3.name;



 /* ex 5.23 : 테이블의 완전결합*/
/*좌측 테이블의 모든 값과 결합된 테이블에서 동일한 기준 및 모든 값이 출력 됨 즉. 합집합이 만들어지게 됨*/

PROC SQL;
SELECT k1.name, k1.posi, k1.reb AS reb1, k3.reb AS reb2
   FROM sql.kbl1 AS k1 FULL JOIN sql.kbl3 AS k3
   ON k1.name=k3.name;



/* ex 5.24 : 테이블의 겹쳐 쓰기 */
/* sql.kbl1 테이블에서  posi, name, score 선택하고, score는 sql.kbl3의 데이터로 수정하는 프로그램 */

PROC SQL;
SELECT k1.posi, k1.name, COALESCE(k3.score, k1.score)
LABEL='최근 득점'
   FROM sql.kbl1 AS k1 LEFT JOIN sql.kbl3 AS k3
   ON k1.name=k3.name;
QUIT;



/* 보충자료1 : payrollmaster */
/*문1*/
PROC SQL;
SELECT  empID, Salary, 
              DateofBirth As Birth, DateofHire As Hire,
			  Salary*0.3 As bonus
FROM   sql.payrollmaster
WHERE salary >=100000
ORDER BY salary DESC;
QUIT;


/*문2*/
PROC SQL;
SELECT  gender, 
              avg(salary) as avg,
			  max(salary) as max
FROM   sql.payrollmaster
WHERE salary >=100000
GROUP BY gender;
QUIT;

/*참고:만나이 계산*/

PROC SQL;
SELECT  empid, jobcode, int((today()-dateofbirth)/365.25) as Age
FROM   sql.payrollmaster;
QUIT;



/*활용 예 */
/*라이브러리 설정*/
LIBNAME sql 'c:\sql';

/*데이터 불러오기 */
proc import datafile='c:\sql\진료명세서.xlsx' dbms=xlsx out=paper;run;
															/*dbms-> 파일 형식 지정 */

proc import datafile='c:\sql\병원정보.xlsx' dbms=xlsx out=hos;run;



/*레이블 이름 지정*/
proc sql;
create table hos_label as
select YNO as YNO label="요양기관번호",
           DGSBJT as DGSBJT label="진료과목코드",
		   TOT_BED as TOT_BED label="병상수",
		   DCT_CNT as DCT_CNT label="의사수",
		   NURSE_CNT as NURSE_CNT label="간호사수"
from hos;
quit;


proc sql;
create table paper_label as
select obs as obs label="명세서번호",
		  No as no label="환자번호",
		  age as age label="나이",
		  VST_DDCNT as VST_DDCNT label="입원일수",
		  RVD_SLF_BRAMT as BRAMT label="심결본인부담금",
		  MSICK_CD as SICK label="상병코드",
		  YNO as YNO label="요양기관번호"
from paper;
quit;


/*데이터 요약*/
/* sum,avg,max,min등 여러가지가 있다 */
proc sql;
create table paper_summary as
select yno,avg(age) as avg label="평균나이",
		  sum(VST_DDCNT) as sum_VST_DDCNT label="환자총입원일수",
		  sum(BRAMT) as sum_BRAMT label="총부담금",
		  avg(BRAMT) as avg_BRAMT label="평균부담금"
from paper_label
group by yno
order by sum_BRAMT;
quit;


/*조인하기 - inner join (left나 rigt해도 상관 없음 -지금데이터에 한해서)*/
proc sql;
create table out as
select *
from paper_summary as t1, hos_label as t2
where t1.yno=t2.yno;
quit;



/* 활용 예2 : 서브쿼리(sub-query)*/
/* Select sub-query*/
/*일반명세와 명세서 상 가장 많이 사용된 약의 1회 투여량*/
Proc SQL;
	create table nps_20_2 as
	select key, no, agg, sex_tp_cd, 
		(select max(b.FQ1_MDCT_QTY)
		from sql.nps_30 as b
		where a.key=b.key
		group by key)
	from sql.nps_20 as a;
quit;

/*From sub-query*/

/*일반 명세 내역*/
Proc SQL;
	create table join1 as
	select key, no, agg, sex_tp_cd
	from sql.nps_20;
quit;

Proc SQL;
	create table join2 as
	select key, sum(UNPRC) as sum_UNPRC
	from sql.nps_30
	where UNPRC>=1000 and AMT<10000
	group by key;
quit;

Proc SQL;
	create table join as
	select a.key, a.no, a.agg, a.sex_tp_cd, b.sum_UNPRC
	from join1 as a, join2 as b
	where a.key=b.key;
quit;

/*Sub-Query 이용*/
Proc SQL;
	create table join_sub as
	select a.key, a.no, a.agg, a.sex_tp_cd, b.sum_UNPRC
	from sql.nps_20 as a,
		(select key, sum(UNPRC) as sum_UNPRC
		from sql.nps_30
		where  UNPRC>=1000 and AMT<10000
		group by key) as b
	where a.key=b.key;
quit;


/*Where sub-query single*/
Proc SQL;
	create table nps_20_3 as
	select a.key, a.no, a.agg, a.sex_tp_cd, max(b.UNPRC) as max_UNPRC
	from sql.nps_20 as a, sql.nps_30 as b
	where a.key=b.key
		and b.UNPRC>(select avg(UNPRC) from sql.nps_30)
	group by a.key;
quit;

proc sql;
	create table test as
	select avg(UNPRC)
	from sql.nps_30
	;
quit;


/*Wehre sub-query multiple*/
Proc SQL;
	create table nps_20_4 as
	select key, no, agg, sex_tp_cd
	from sql.nps_20
	where key in (select key
						  from sql.nps_40
						  where DMD_SICK_SYM like 'K%');
quit;



proc import datafile="C:\sql\응급실사용코드.xlsx" dbms=xlsx out=emerge_code;run;

Proc SQL;
	create table avg_RVD_SLF as
	select avg(a.RVD_SLF_BRDN_AMT) as avg_RVD_SLF
	from sql.nps_20 as a left join sql.nps_30 as b 
		on a.key=b.key , (select DIV_CD from emerge_code) as c
	where a.key in (select key 
							from sql.nps_40
							where DMD_SICK_SYM like 'K%') and
				b.DIV_CD=c.DIV_CD;
quit;
			





