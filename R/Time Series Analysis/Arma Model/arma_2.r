/*백색잡음과정을 따르는 난수 생성*/
data wn;
do t=1 to 1000;
e=rannor(1234);
z=e;
output;
end; run;
/*난수 발생 자료로 백색잡음과정 시계열 그래프 그리기*/
symbol1 ci=black v=dot cv=black i=join h=0.5;
proc gplot data=wn;
plot z*t=1; run; quit;
/*acf, pacf*/
proc arima data=wn;
identify var=z nlag=24;
run;

 

 


/*확률보행과정을 따르는 난수 생성*/
data rw;
z0=0;
do t=1 to 100;
et=rannor(1234);
z=z0+et;
output;
z0=z;
end; run;
/*난수 발생 자료로 확률보행과정 시계열 그래프 그리기*/
symbol1 ci=black v=dot cv=black i=join h=0.5;

/*확률보행과정 1차 차분*/
data drw; set rw;
dif1=dif1(z);
run;
/*난수 발생 자료로 확률보행과정 시계열 1차 차분한 그래프 그리기*/
symbol1 ci=black v=dot cv=black i=join h=0.5;
proc gplot data=drw;
label dif1='Zt';
label t='time';
plot dif1*t=1; run; quit;
/*acf, pacf*/
proc arima data=drw;
identify var=dif1 nlag=10;
run;

 


/*AR(1) 모형을 따르는 난수 생성*/
data ar1;
z0=0;
do t=1 to 1000;
e=rannor(1234);
z=.9*z0+e;
output;
z0=z;
end; run;
/*난수 발생 자료로 AR(1) 모형 시계열 그래프 그리기*/
symbol1 ci=black v=dot cv=black i=join h=0.5;
proc gplot data=ar1;
plot z*t=1;run; quit;

/*acf, pacf*/
proc arima data=ar1;
identify var=z nlag=24;
run;

/*MA(1)모형을 따르는 난수 생성*/
data ma1;
e0=0;
do t=1 to 1000;
e=rannor(1234);
z=e+0.9+e0;
output;
e0=e;
end; run;
/*난수 발생 자료로 MA(1)모형 시계열 그래프 그리기*/
symbol1 ci=black v=dot cv=black i=join h=0.5;
proc gplot data=ma1;
plot z*t=1;
run; quit;
/*acf, pacf*/
proc arima data=ma1;
identify var=z nlag=24;
run;

*ARMA(1,1)모형;
data arma11;
e0=0; z0=0;
do t=1 to 1000;
e=rannor(1234);
z=0.8*z0+e+0.6*e0;
output;
e0=e; z0=z;
end; run;
/*ARMA(1,1)모형 그래프 그리기*/
symbol1 ci=black v=dot cv=black i=join h=0.5;
proc gplot data=arma11;
plot z*t=1;
run; quit;
/*acf, pacf*/
proc arima data=arma11;
identify var=z nlag=24;
run;
/*모형식별*/
proc arima data=ar1;
identify var=z nlag=24;
run;
/*모수추정, 모형잔차*/
proc arima data=ar1;
identify var=z nlag=24;
estimate p=1 method=m1;
estimate q=1 method=m1;
estimate p=1 q=1 method=uls;
run;