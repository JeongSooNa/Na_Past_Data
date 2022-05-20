### python.org

### anaconda 다운받기

### numpy 패키지 다운 받는 법
idle 속성의 파일 위치에서 32 까지 복사, script 까지 붙이고 윈도우 실행창 cmd에 넣고
pip install numpy 작성하면 완료

 
---
import os # 패키지 이용
 
import numpy as np #numpy를 np로 줄이기

### np.함수 로 함수 사용
a=np.array([1,2,3])
print(a)

### 주석1
'''
주석
주석
'''
'''

### R과 Python의 차이
- R : Vector 벡터로 값을 추출
ex) 
```r
    a=1:3

    b=1:2

    a[b]

    > 1 2
```
- Python : Vector X
ex) 
```python
#List
a=[1,2,3,4,5] #자료형들을 모을 수 있는 자료형
b=[1,2]
```

### numpy : array 자료형을 사용하는 패키지

R
```r
install.packages('')
window-cmd
```
R
consol로 치면
```r
$
    1
$
    2
$
    3
$
    4
```
벡터형 자료가 없이 아닌 하나씩 있어 오류.

### 숫자형
```python
a=3 # 3
print(a)
n=4 # 4
print(n)
```
### 문자형
```python
c='9시'
d='수업'
print(c+d)
print(c,d)
```