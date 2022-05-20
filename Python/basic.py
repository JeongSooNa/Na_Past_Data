# 1. 자료형 변환 함수

### 1) float()
my_int = 123	# 정수형(Integer) 자료형인 my_int
float(my_int)	# 실수형(Floating-point) 자료형으로 변경
# 123.0

### str()
str(my_int)		# 문자열(String) 자료형으로 변경
# '123’

# list()
my_name= "hyunjoon"	# 문자열(String) 자료형인 my_name
list(my_name)		# 리스트(List) 자료형으로 변경
# ['h', 'y', 'u', 'n', 'j', 'o', 'o', 'n']

# tuple()
tuple(my_name)		# 튜플(Tuple) 자료형으로 변경
# ('h', 'y', 'u', 'n', 'j', 'o', 'o', 'n')
    # 튜플형 자료형은 생성, 삭제, 수정 불가능한 자료형들의 모음

# dict()
my_friend = [('김경민',25),('배윤종',27),('나정수',25)] 	# Tuple List
dict(my_friend)					# 딕서녀리(Dictionary) 자료형으로 변경
# {'김경민': 25, '배윤종': 27, '나정수': 25}
	# 딕셔너리 자료형은 Key와 Value를 가지고 있는 자료형들의 모음
	# ex) Key ‘김경민’, Value 25 

#*****************************************************#

# 2. 자료형에 관련된 함수

# float() - // : 소수점 아랫자리 버리기
my_int
# 123
my_int//2
# 61

# str() - upper() : 소문자를 대문자로 바꾸기
my_name
# 'hyunjoon'
my_name.upper()
# 'HYUNJOON’

# list() - sort() : 리스트의 요소를 순서대로 정렬
a = list(my_name)
a
# ['h', 'y', 'u', 'n', 'j', 'o', 'o', 'n']
a.sort()
a
# ['h', 'j', 'n', 'n', 'o', 'o', 'u', 'y']

# tuple() - * :  튜플 곱하기(반복)
b = tuple(my_name)
b
# ('h', 'y', 'u', 'n', 'j', 'o', 'o', 'n')
b * 2
# ('h', 'y', 'u', 'n', 'j', 'o', 'o', 'n', 'h', 'y', 'u', 'n', 'j', 'o', 'o', 'n')

# dict() - get() : Key로 Value 얻기
c = dict(my_friend)
c
# {'김경민': 25, '배윤종': 27, '나정수': 25}
c.get('김경민')
# 25