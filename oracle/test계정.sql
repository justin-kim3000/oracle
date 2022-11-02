-- 테이블 생성
/*
CREATE TABLE customer_t(
    name VARCHAR2(20),
    age number,
    gender char(1),
    rdate date default sysdate
);
*/

 -- 정보 삽입
 /*
INSERT INTO customer_t (
    name,
    age,
    gender
) VALUES (
    '김길동',
    100,
    'M'
);
*/
/*
-- 컬럼명 개수와 데이터 개수가 일치해야 됨
INSERT INTO customer_t (
    name,
    age,
    gender
) VALUES (
    '홍길동',
    100,
    'M'
);

-- 컬럼명을 생략하는 경우에는 모든 정보를 추가해야함
INSERT INTO customer_t VALUES (
    '홍길동',
    100,
    'M',
    sysdate
);

-- 데이터 보기
SELECT
    name
FROM
    customer_t;

SELECT
    name,
    age,
    gender
FROM
    customer_t;

SELECT
    *
FROM
    customer_t
WHERE
    gender IS NULL;

SELECT
    name,age, count(*)
FROM
    customer_t
GROUP By CUBE(name,gender)
ORDER BY
    name;*/
  
  
-- 데이터 타입
/*
varchar2: 가변길이 문자열(권장) - '홍길동'
char : 고정 길이 문자열
number: 숫자(가변)
int: 숫자(고정)
date: 날짜
clob : 대용량 문자열
blob : 이미지, 동영상

*/
    
-- 학생 테이블 생성
/*
1. 테이블명 student_t
2. 컬럼은 학번, 이름, 나이, 주소, 전화번호, 이메일, 카톡id
3. 학번, 나이는 숫자, 나머지는 문자열
4. 랜덤 데이터 10개 insert
5. select를 사용하여 데이터 출력
*/
-- 테이블 생성
/*
CREATE TABLE student_t1(
    id number,
    name VARCHAR2(20),
    age number,
    address VARCHAR2(20),
    phoneNumber VARCHAR2(20),
    email VARCHAR2(30),
    kakaoId VARCHAR2(20)
);

INSERT INTO student_t1 VALUES (
    2022000126,
    '박오보',
    22,
    '미국',
    '011-0314-4444',
    'three55@naver.com',
    'three55'
);
*/

-- 테이블 새로운 컬럼 추가
ALTER TABLE student_t1 ADD (
    name2 VARCHAR2(40)
);

-- 테이블 컬럼 수정
ALTER TABLE student_t1 MODIFY (
    name2 VARCHAR2(20)
);

-- 조건 검색
SELECT
    id,
    name,
    phonenumber,
    age
FROM
    student_t1
WHERE
    name LIKE '%리치';

SELECT
    *
FROM
    student_t1;

DELETE FROM student_t1;

select age, count(*) as cantt
from student_t1
GROUP by age
ORDER by cantt ASC;


select destinct id from student_t1;