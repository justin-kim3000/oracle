-- 1. 부하직원이 없는 직원 출력
SELECT
    ename
FROM
    employee
WHERE
    eno NOT IN (
        SELECT
            manager
        FROM
            employee
        WHERE
            manager IS NOT NULL
    );

SELECT
    eno,
    ename,
    salary
FROM
    employee
WHERE
    eno NOT IN (
        SELECT
            manager
        FROM
            employee
        WHERE
            manager IS NOT NULL
    );

-- 2. BLAKE와 동일한 부서에 속한 사원명, 입사일 출력 - BLAKE는 출력 제외
SELECT
    ename,
    hiredate,
    dno
FROM
    employee
WHERE
        dno = (
            SELECT
                dno
            FROM
                employee
            WHERE
                ename = 'BLAKE'
        )
    AND ename != 'BLAKE'; 


-- 3. 근무지가 DALLAS인 사원명, 부서번호, 담당업무 출력 - 이름 오름차순
-- 서브쿼리, 조인 방법

SELECT
    ename,
    dno,
    department.dname,
    loc
FROM
         employee
    INNER JOIN department USING ( dno )
WHERE
    loc = (
        SELECT
            loc
        FROM
            department
        WHERE
            loc = 'DALLAS'
    );
    

-- 저장된 데이터를 수정 (Update)
/*
UPDATE table_name
Set column_name1 = value1, column_name2
where conditins ;
*/
DROP TABLE dept_copy11;

CREATE TABLE dept_copy
    AS
        SELECT
            *
        FROM
            department;

UPDATE dept_copy
SET
    dname = 'PROGRAMMING'
WHERE
    dno = 10;

UPDATE dept_copy
SET
    loc = (
        SELECT
            loc
        FROM
            dept_copy
        WHERE
            dno = 20
    )
WHERE
    dno = 10;

UPDATE dept_copy
SET
    dname = (
        SELECT
            dname
        FROM
            dept_copy
        WHERE
            dno = 30
    ),
    loc = (
        SELECT
            loc
        FROM
            dept_copy
        WHERE
            dno = 30
    )
WHERE
    dno = 10;

-- delete 삭제
/*delete [from] table_name
where condigions;*/

DELETE dept_copy
WHERE
    dno = 10;

DELETE emp_copy
WHERE
    dno = (
        SELECT
            dno
        FROM
            department
        WHERE
            dname = 'SALES'
    );

/*
NOT NULL 칼럼에 NULL을 포함하지 못하도록
UNIQUE 테이블의 모든 로우에 대해서 유일한 값을 갖도록 한다.
PRIMARY KEY 테이블의 각 행을 식별하기 위한 것으로 NULL과
중복된 값을 모두 허용하지 않는다. 즉, NOT NULL 조건과 UNIQUE조건을 결합한 형태
FOREIGN KEY 참조되는 테이블에 칼럼 값이 항상 존재해야 한다.
*/

CREATE TABLE customer (
    id     VARCHAR2(20) NOT NULL,
    pwd    VARCHAR2(20) NOT NULL,
    name   VARCHAR2(20) NOT NULL,
    phone  VARCHAR2(30),
    adress VARCHAR2(100)
);

CREATE TABLE customer (
    id     VARCHAR2(20) UNIQUE,
    pwd    VARCHAR2(20) NOT NULL,
    name   VARCHAR2(20) NOT NULL,
    phone  VARCHAR2(30),
    adress VARCHAR2(100)
);

INSERT INTO customer VALUES (
    NULL,
    NULL,
    NULL,
    '010-111-1111',
    'seoul'
);

CREATE TABLE customer (
    id     VARCHAR2(20)
        CONSTRAINT customer_id_uk UNIQUE,
    pwd    VARCHAR2(20)
        CONSTRAINT customer_pwd_nn NOT NULL,
    name   VARCHAR2(20)
        CONSTRAINT customer_name_nn NOT NULL,
    phone  VARCHAR2(30),
    adress VARCHAR2(100)
);

CREATE TABLE customer (
    id     VARCHAR2(20),
    pwd    VARCHAR2(20)
        CONSTRAINT customer_pwd_nn NOT NULL,
    name   VARCHAR2(20)
        CONSTRAINT customer_name_nn NOT NULL,
    phone  VARCHAR2(30),
    adress VARCHAR2(100),
    CONSTRAINT customer_id_pk PRIMARY KEY ( id )
);

CREATE TABLE emp_second (
    eno   NUMBER(4) PRIMARY KEY,
    ename VARCHAR2(10),
    job   VARCHAR2(20),
    dno   NUMBER(4)
        CONSTRAINT emp_second_dno라
            REFERENCES department
);

CREATE TABLE emp_second (
    eno    NUMBER(4) PRIMARY KEY,
    ename  VARCHAR2(10),
    job    VARCHAR2(20),
    salary NUMBER(10)
        CONSTRAINT emp_second_salary_min CHECK ( salary > 0 )
);

CREATE TABLE emp_second (
    eno    NUMBER(4) PRIMARY KEY,
    ename  VARCHAR2(10),
    salary NUMBER(7) DEFAULT 1000
);

INSERT INTO emp_second (
    eno,
    ename
) VALUES (
    1,
    '홍길동'
);

/*
학생 테이블 생성 - student_t
1. id (문자열 5, 기본키), name(문자열 10 NULL 아님),
나이 (숫자, NULL아님), 성별(문자열 5, NULL 아님),
학년(문자열 10, NULL아님), 주소(문자열 50, NULL 아님)
2. 제약 조건 사용 
기본키 : id
check : (나이 >19), 성별('남','여'),
           학년('1학년','2학년','3학년','4학년')
3. 제약조건명은 임의로 작성 (테이블명_컬러명_제약조건명)
4. 실제 데이터를 입력하여 제약조건 위배를 테스트 하기
*/
drop table student_t;
CREATE TABLE student_t (
    id     VARCHAR2(5) primary key,
    name    VARCHAR2(10) NOT NULL,
    age NUMBER NOT NULL check (age>19),
    gender VARCHAR2(5) NOT NULL check (gender in ('남','여')),
    grade VARCHAR2(10) NOT NULL check (grade in ('1학년','2학년','3학년','4학년')),
    adress VARCHAR2(50) NOT NULL
);

CREATE TABLE student_t (
    id     VARCHAR2(5) primary key,
    name    VARCHAR2(10) NOT NULL,
    age NUMBER NOT NULL,
    gender VARCHAR2(5) NOT NULL ,
    grade VARCHAR2(10) NOT NULL,
    adress VARCHAR2(50) NOT NULL,
    constraint st_age_chk check (age>19),
    constraint st_gender_chk check (gender in ('남','여')),
    constraint st_grade_chk check (grade in ('1학년','2학년','3학년','4학년'))
);


insert into student_t values('1','김길동',20,'남','1학년','대구시');
insert into student_t values('2','김사랑',20,'여','1학년','대구시');
insert into student_t values('3','김사랑',20,'여','1학년','대구시');
insert into student_t values('4','박사랑',21,'여','3학년','서울시');