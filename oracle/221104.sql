-- equi 조인

--1. 사원이름과 해당 사원을 관리하는 관리자 출력(null값 출력x) - 셀프 조인
SELECT DISTINCT
    employees.ename,
    employees.manager
FROM
         employee employees
    JOIN employee manager ON employees.manager IS NOT NULL;


--2. WARD 사원보다 입사일이 늦은 사원명, 입사일 출력 - 입사일 기준 오름차순 -셀프조인
SELECT
    e.ename,
    e.hiredate
FROM
    employee e
WHERE
    e.hiredate > '81/02/22';

SELECT
    o.ename,
    o.hiredate
FROM
    employee w,
    employee o
WHERE
        o.hiredate > w.hiredate
    AND w.ename = 'WARD'
ORDER BY
    o.hiredate;

--3. 사원 이름과 해당 사원을 관리하는 관리자 출력(null값 출력) - 외부 조인
SELECT
    e.ename,
    e.manager
FROM
    employee   e,
    department d
WHERE
    e.dno = d.dno;

SELECT
    e.ename 사원,
    m.ename 관리자
FROM
    employee e
    LEFT OUTER JOIN employee m ON e.manager = m.eno;

--4. 사번, 사원명, 담당업무, 관리자번호, 부서번호, 부서명 출력 - 외부 조인 (left, right 비교)
SELECT
    e.eno,
    e.ename,
    e.job,
    e.manager,
    e.dno,
    d.dname
FROM
    employee   e,
    department d
WHERE
    e.dno = d.dno;

SELECT
    e.eno,
    e.ename,
    e.job,
    e.manager,
    e.dno,
    d.dname
FROM
    employee   e
    LEFT OUTER JOIN department d
WHERE
    e.dno = d.dno;

SELECT
    e.eno,
    e.ename,
    e.job,
    e.manager,
    e.dno,
    d.dname
FROM
    employee   e,
    department d
WHERE
    e.dno = d.dno;


--------------------------------------------------------
-- 서브 쿼리
SELECT
    ename,
    salary
FROM
    employee
WHERE
    salary > (
        SELECT
            salary
        FROM
            employee
        WHERE
            ename = 'WARD'
    );

-- 다중행 비교 연산자 (IN '=',(ANY,SOME) = 하나 이상 일치 참,
-- ALL= 모든 값이 일치하면 참,EXISTS= 하나 이상 존재시 참)

SELECT
    ename,
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
            ename = 'SCOTT'
    );

SELECT
    eno,
    ename
FROM
    employee
WHERE
    salary IN (
        SELECT
            MIN(salary)
        FROM
            employee
        GROUP BY
            dno
    );

SELECT
    e.eno,
    e.ename,
    d.dname,
    d.loc
FROM
    employee   e,
    department d
WHERE
    salary IN (
        SELECT
            MIN(salary)
        FROM
            employee
        GROUP BY
            dno
    )
    AND e.dno = d.dno;

-- any 연산자
SELECT
    eno,
    ename,
    job,
    salary
FROM
    employee
WHERE
    salary < ANY (
        SELECT
            salary
        FROM
            employee
        WHERE
            job = 'SALESMAN'
    )
    AND job <> 'SALESMAN';

-- all
SELECT
    eno,
    ename,
    job,
    salary
FROM
    employee
WHERE
    salary < ALL (
        SELECT
            salary
        FROM
            employee
        WHERE
            job = 'SALESMAN'
    )
    AND job <> 'SALESMAN';


-- 1. 사원번호가 7788인 사원과 담당업무가 같은 사원 출력
-- 사원명 담당업무 출력
SELECT
    eno,
    ename,
    job
FROM
    employee
WHERE
    ename = ANY (
        SELECT
            ename
        FROM
            employee
        WHERE
            eno = '7788'
    );


-- 2. 사원번호가 7499보다 급여가 많은 사원명, 담당업무, 급여 출력
SELECT
    eno,
    ename,
    job,
    salary
FROM
    employee
WHERE
    salary > ANY (
        SELECT
            salary
        FROM
            employee
        WHERE
            eno = '7499'
    );

--3. 최소, 최대 급여를 받는 사원명, 담당업무, 급여 출력
SELECT
    ename,
    job,
    salary
FROM
    employee
WHERE
    salary > ANY (
        SELECT
            max(salary)
        FROM
            employee
    ) or
(
    SELECT
        MIN(salary)
    FROM
        employee
);


-- 4. 각 부서의 최소 급여를 받는 사원명, 급여, 부서번호 출력
SELECT
    dno,
    ename,
    salary
FROM
    employee
WHERE
    salary = SOME (
        SELECT
            MIN(salary)
        FROM
            employee);


-- 5. 각 부서의 최소 급여를 받는 사원명, 급여, 부서번호 부서명, 근무지 출력
SELECT
    employee.dno,
    ename,
    salary, department.dname,loc
FROM
    employee, department
WHERE
    salary = SOME (
        SELECT
            MIN(salary)
        FROM
            employee)
    AND employee.dno = department.dno;
    
    
-- 6. 담당업무가 analyst인 사원보다 급여가 적으면서 업무가 analyst가 아닌
-- 사원들 출력 - 사번, 사원명, 담당업무, 급여
SELECT
    eno,
    ename,
    job,
    salary
FROM
    employee
WHERE
    salary < ANY (
        SELECT
            salary
        FROM
            employee
        WHERE
            job = 'ANALYST'
    );

-- 7. 직속상관이 없는 직원 출력
SELECT
    ename
FROM
    employee
WHERE
    ename = (
        SELECT
            ename
        FROM
            employee
        WHERE
            manager IS NULL
    ); 

-- 8. 직속상관이 없는 직원, 부서명, 근무지 출력
SELECT
    ename,
    dname,
    loc
FROM
    employee,
    department
WHERE
        ename = (
            SELECT
                ename
            FROM
                employee
            WHERE
                manager IS NULL
        )
    AND employee.dno = department.dno;

select count(*)
from employee 