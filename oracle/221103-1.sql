SELECT
    *
FROM
    employee;


-- 1. 각부서에 대해서 부서번호, 사원수, 부서 내의 모든 사원의 평균 급여를
-- 부서별로 오름차순 출력. 평균급여 반올림
SELECT
    dno,
    COUNT(*)           AS 사원수,
    round(AVG(salary)) AS "평균 급여"
FROM
    employee
GROUP BY
    dno
ORDER BY
    dno;

-- 2. 각 부서에 대해 부서번호 이름, 지역명, 사원수, 부서내의 모든 사원의
-- 평균 급여 출력 - 평균 급여 반올림

SELECT
    dno,
    ename,
    COUNT(dno) AS 사원수,
    CASE
        WHEN dno = '10' THEN
            '대구'
        WHEN dno = '20' THEN
            '부산'
        ELSE
            '서울'
    END        AS 지역명
FROM
    employee
GROUP BY
    dno,
    ename
ORDER BY
    dno;

-- 3. 부서번호, 사원명, 사원수, 부서별 인원 소합계, 모든 부서 인원, 금액 총합계 출력
-- rollup 사용 -> 교재 참조
SELECT
    dno,
    ename,
    COUNT(*)    사원수,
    SUM(salary) AS 총합계
FROM
    employee
GROUP BY
    ROLLUP(dno,
           ename);

-- 4. 3문제를 cube 사용(rollup 비교)

SELECT
    dno,
    ename,
    COUNT(*)    사원수,
    SUM(salary) AS 총합계
FROM
    employee
GROUP BY
    CUBE(dno,
         ename);

SELECT
    *
FROM
    employee,
    department;

SELECT
    *
FROM
         employee
    CROSS JOIN department;

SELECT
    *
FROM
    employee,
    department
-- join시 where 절 필요!!
WHERE
    employee.dno = department.dno;

SELECT
    em.eno,
    em.ename,
    de.dname,
    de.dno
FROM
    employee   em,
    department de
WHERE
        em.dno = de.dno
    AND em.eno = 7788;

SELECT
    em.eno,
    em.ename,
    de.dname,
    dno
FROM
         employee em
    NATURAL JOIN department de
WHERE
    em.eno = 7788;

SELECT
    em.eno,
    em.ename,
    de.dname,
    dno
FROM
         employee em
    JOIN department de
-- where employee.dno= department.dno = using(dno)
     USING ( dno )
WHERE
    em.eno = 7788;

SELECT
    em.eno,
    em.ename,
    de.dname,
    de.dno
FROM
         employee em
    JOIN department de
-- where employee.dno= department.dno = using(dno)
     ON em.dno = de.dno
WHERE
    em.eno = 7788;

SELECT
    ename,
    salary,
    grade
FROM
    employee,
    salgrade
WHERE
    salary BETWEEN losal AND hisal;

SELECT
    e.ename,
    d.dname,
    e.salary,
    s.grade
FROM
    employee   e,
    department d,
    salgrade   s
WHERE
        e.dno = d.dno
    AND salary BETWEEN losal AND hisal;

SELECT
    e.ename   AS "사원이름",
    e.manager "상관",
    d.dname,
    e.salary,
    s.grade
FROM
    employee   e,
    department d,
    salgrade   s
WHERE
        e.dno = d.dno
    AND salary BETWEEN losal AND hisal;

SELECT
    employees.ename
    || '의 직속 상관은'
    || manager.ename
FROM
         employee employees
    JOIN employee manager ON employees.manager = manager.eno (+);

-- ANSI OUTER JOIN
SELECT
    employees.ename
    || '의 직속 상관은'
    || manager.ename
FROM
    employee employees
    LEFT OUTER JOIN employee manager ON employees.manager = manager.eno;

-- 1. SCOTT 사원의 이름, 부서번호, 부서이름 출력 - 내부조인(EQUI 조인)
SELECT
    e.ename,
    e.dno,
    d.dname
FROM
    employee   e,
    department d
WHERE
        e.dno = d.dno
    AND e.ename = 'SCOTT';

-- 2. 사원명, 부서명, 지역명 출력
-- 내부조인(표준), join~on, join~using, equi 조인 4가지
SELECT
    em.ename,
    em.dno,
    de.loc
FROM
    employee em,
    department de
WHERE
    em.dno = de.dno;


-- 3. 이름에 A가 포함된 모든 사원의 이름, 부서명 출력 (equi, natural)
select e.ename,d.dname
from employee e,department d
where  e.dno = d.dno and e.ename like '%A%';

select e.ename,d.dname
from employee e NATURAL join department d
where  e.ename like '%A%';

-- 4. 커미션을 받는 사원명, 부서명, 근무지 출력(equi, natural)
select e.ename,d.dname, d.loc
from employee e,department d
where  e.dno = d.dno and e.commission is not null;

select e.ename,d.dname, d.loc
from employee e natural join department d
where e.commission is not null;

-- 5. 뉴욕에 근무하는 모든 사원의 이름, 업무, 부서번호, 부서명 출력(equi, natural)
select e.ename, e.job, e.dno, d.dname, d.loc
from employee e,department d
where  e.dno = d.dno and d.loc = 'NEW YORK';

select e.ename, e.job, dno, d.dname, d.loc
from employee e natural join department d
where d.loc = 'NEW YORK';

