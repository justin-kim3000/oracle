-- About VIEW
CREATE VIEW v_emp_sample AS
    SELECT
        eno,
        ename,
        job,
        salary,
        dno
    FROM
        emp_second;

CREATE VIEW v_emp_complex2 AS
    SELECT
        e.eno,
        e.ename,
        e.salary,
        dno,
        d.dname,
        d.loc
    FROM
             emp_second e
        NATURAL JOIN dept_copy d;

-- 케쉬 데이터 비슷. 메모리 상에 저장
SELECT
    view_name,
    text
FROM
    user_views;

CREATE VIEW v_emp_salary AS
    SELECT
        dno,
        SUM(salary) AS "sal_sum",
        AVG(salary) AS "sal_avg"
    FROM
        emp_second
    GROUP BY
        dno;

DROP VIEW v_emp_salary;

CREATE VIEW v_emp_salary AS
    SELECT
        dno,
        SUM(salary) AS 급여합계,
        AVG(salary) AS 급여평균
    FROM
        employee
    GROUP BY
        dno;

SELECT
    급여합계,
    급여평균
FROM
    v_emp_salary;

SELECT
    level  직급순위,
    eno    사번,
    ename  사원명,
    job    담당업무,
    salary 급여
FROM
    employee
START WITH
    manager IS NULL
CONNECT BY
    PRIOR eno = manager
ORDER SIBLINGS BY
    manager;


-- 1. 직급순위, 사번, 사원명, 담당업무, 매니저번호, 입사일
-- 급여, 커미션, 부서번호, 부서명 출력.
SELECT
    level            직급순위,
    eno              사번,
    ename            사원명,
    job              담당업무,
    salary           급여,
    commission       커미션,
    dno              부서번호,
    department.dname 부서명
FROM
         employee
    INNER JOIN department USING ( dno )
START WITH
    manager IS NULL
CONNECT BY
    PRIOR eno = manager
ORDER BY
    직급순위;



-- 2. 1번 query를 view로 생성 - 직급순위 오름차순 정렬
DROP VIEW v_about_1query;

CREATE VIEW v_about_1query AS
    SELECT
        level            직급순위,
        eno              사번,
        ename            사원명,
        job              담당업무,
        salary           급여,
        commission       커미션,
        dno              부서번호,
        department.dname 부서명
    FROM
             employee
        INNER JOIN department USING ( dno )
    START WITH
        manager IS NULL
    CONNECT BY
        PRIOR eno = manager
    ORDER BY
        직급순위;

CREATE OR REPLACE VIEW jok_v AS
    SELECT
        level        직급순위,
        e.eno        사번,
        e.ename      사원명,
        e.job        담당업무,
        e.manager    상서번호,
        e.hiredate   입사일,
        e.salary     급여,
        e.commission 커미션,
        e.dno        부서번호,
        (
            SELECT
                dname
            FROM
                department
            WHERE
                e.dno = dno
        )            부서명
    FROM
        employee e
    START WITH
        manager IS NULL
    CONNECT BY
        PRIOR eno = manager
    ORDER SIBLINGS BY
        manager;

SELECT
    *
FROM
    jok_v
ORDER BY
    직급순위;

-- 오라클 시퀀스
-- currval
-- nextval
/*

SELECT 해당시퀀스.NEXTVAL FROM DUAL; - 해당 시퀀스의 다음 값

SELECT 해당시퀀스.CURRVAL FROM DUAL; - 해당 시퀀스의 현재 값

INSERT INTO example VALUES(해당시퀀스.NEXTVAL) - 해당 시퀀스의 다음 값을 insert

select문을 하지만 실행 마다 시퀀스 값이 증가된다 => 테이블과 시퀀스는 별도이기 때문에
*/
CREATE SEQUENCE dno_seq INCREMENT BY 10 START WITH 10;

INSERT INTO dept_second VALUES (
    dno_seq.NEXTVAL,
    'ACCOUNTING',
    'NEW YORK'
);

-- 특수한 테이블 정보
CREATE INDEX idx_employee_ename ON
    employee (
        ename
    );

/*
1. 학생 테이블 생성
학번(문자), 이름(문자), 학과(문자), 나이(숫자), 성별(문자),
전화(문자), 주소(문자), 취미(문자), 교수번호(문자)
제약조건1: 기본키(학번), 참조키(교수번호)
제약조건2: 학과('컴퓨터과', '통계과', '건축과','전기과','전자과')
                나이(age >19), 성별('남','여')
제약조건3: 취미(NULL)를 제외하고 모든 컬럼(NOT NULL)
-----------------------------------------------------
2. 교수 테이블 생성
교수번호(문자), 이름(문자), 학과(문자), 나이(숫자), 전화(문자)
제약조건1 : 기본키(교수번호), 나이(age>30),
                학과('컴퓨터과', '통계과', '건축과','전기과','전자과')
제약조건2: 모든 컬럼 NOT NULL
-----------------------------------------------------
각 테이블에 데이터 10개 이상 추가.
-----------------------------------------------------
3. 부서별로 사원명, 부서명, 급여, 급여평균, 급여등급, 성과급 출력
-----------------------------------------------------
4. 3번 sql문장을 이용하여 가상테이블을 생성하여 모든 정보 출력
*/

/*
1. 학생 테이블 생성
학번(문자), 이름(문자), 학과(문자), 나이(숫자), 성별(문자),
전화(문자), 주소(문자), 취미(문자), 교수번호(문자)
제약조건1: 기본키(학번), 참조키(교수번호)
제약조건2: 학과('컴퓨터과', '통계과', '건축과','전기과','전자과')
                나이(age >19), 성별('남','여')
제약조건3: 취미(NULL)를 제외하고 모든 컬럼(NOT NULL)*/
drop table student_uni;
CREATE TABLE student_uni (
    id     VARCHAR2(5) primary key,
    name    VARCHAR2(10) NOT NULL,
    depart VARCHAR2(30) NOT NULL check (depart in ('컴퓨터과', '통계과', '건축과','전기과','전자과')),
    age NUMBER NOT NULL check (age>19),
    gender VARCHAR2(5) NOT NULL check (gender in ('남','여')),
    phone VARCHAR2(20) NOT NULL,
    adress VARCHAR2(50) NOT NULL,
    hobby VARCHAR2(20),
    -- 교수 참조
    pro_number     VARCHAR2(10),
    CONSTRAINT pro_fk FOREIGN KEY (pro_number)
    REFERENCES professor_uni (pro_number)
);

INSERT INTO student_uni VALUES('1','Kim','컴퓨터과',25,'남','02-122-1246','서울시','독서','0001');
/*
2. 교수 테이블 생성
교수번호(문자), 이름(문자), 학과(문자), 나이(숫자), 전화(문자)
제약조건1 : 기본키(교수번호), 나이(age>30),
                학과('컴퓨터과', '통계과', '건축과','전기과','전자과')
제약조건2: 모든 컬럼 NOT NULL
*/

drop table professor_uni;
CREATE TABLE professor_uni (
    pro_number     VARCHAR2(10) primary key,
    name    VARCHAR2(10) NOT NULL,
    depart VARCHAR2(30) NOT NULL check (depart in ('컴퓨터과', '통계과', '건축과','전기과','전자과')),
    age NUMBER NOT NULL CHECK ( age > 30 ),
    phone VARCHAR2(20) NOT NULL
);
insert into professor_uni values('0001','Kim','컴퓨터과',38,'192-281-2122');

/*
3. 사원명, 부서명, 급여, 급여등급, 성과급 출력
-----------------------------------------------------
4. 3번 sql문장을 이용하여 가상테이블을 생성하여 모든 정보 출력
*/

select ename, dno, salary, dense_rank() over (order by salary desc) all_rank, commission
--급여등급,
from employee;

CREATE VIEW rank_employee AS
select ename, dno, salary, dense_rank() over (order by salary desc) all_rank, commission
--급여등급,
from employee;