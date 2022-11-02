SELECT
    ename       AS 사원명,
    salary      AS 급여,
    salary * 12 AS 월급여
FROM
    employee;

SELECT
    eno,
    ename,
    salary,
    RANK()
    OVER(
        ORDER BY
            salary DESC
    ) AS rank
FROM
    employee;

SELECT
    *
FROM
    employee
WHERE
    dno <> 30;

SELECT
    *
FROM
    employee
WHERE
    salary BETWEEN 1000 AND 1500;

SELECT
    *
FROM
    employee
WHERE
    hiredate BETWEEN '81/01/01' AND '1981/12/31';

SELECT
    *
FROM
    employee
WHERE
    commission IS NULL;

SELECT
    *
FROM
    employee
WHERE
    job LIKE '%_N%';

SELECT
    eno,
    ename,
    manager
FROM
    employee
WHERE
    eno = 7788;

-- 2000넘는 경우
SELECT
    ename,
    salary
FROM
    employee
WHERE
    salary > 2000
ORDER BY
    salary ASC;

-- 300 급여 인상
SELECT
    ename,
    salary,
    salary + 300 AS upsalary
FROM
    employee;

-- 수입 많은 순으로 출력1
SELECT
    ename,
    salary,
    salary * 12 + commission AS yearsalary
FROM
    employee
ORDER BY
    yearsalary DESC;

-- 수입 많은 순으로 출력2
SELECT
    ename,
    salary,
    commission,
    CASE
        WHEN commission is null THEN
            salary * 12
        ELSE
            salary * 12 + commission
    END AS yearsalary
FROM
    employee
ORDER BY
    yearsalary DESC;


-- 급여 2000 ~3000 사이
SELECT
    ename,
    salary
FROM
    employee
WHERE
    salary NOT BETWEEN 2000 AND 3000;
    
    
-- 급여 2000 ~3000 사이 포함되는 사원 출력(2가지)
Select ename
from employee
where salary between 2000 and 3000;


-- 1981/2/20 ~ 1982/5/1 사이에 입사한 사원 이름 담당업무, 입사일 출력
Select ename, job,hiredate
from employee
where hiredate between '1981/2/20' and '1982/5/1';


-- 부서 번호가 20 ~30에 속한 사원의 이름과 부서번호 출력 - 이름 기준 내림차순
Select ename, manager, dno
from employee
where dno between 20 and 30
order by ename desc;



-- 사원의 급여가 2000 ~ 3000 사이에 포함되고 부서번호가 20 또는 30인
-- 사원의 이름, 급여, 부서번호 출력 - 이름 기준 오름 차순
Select ename, salary, dno
from employee
where salary between 2000 and 3000 and dno between 20 and 30
order by ename ;



-- 1981년도에 입사한 사원의 이름, 입사일 출력(like 사용)
Select ename, hiredate
from employee
where hiredate between '1981/1/1' and '1981/12/31';

Select ename, hiredate
from employee
where hiredate like '81/%/%';
        

drop TABLE EMPLOYEES
CREATE TABLE EMPLOYEES (
	EMPLOYEE_ID	VARCHAR(3),
	NAME		VARCHAR(15),
	SALARY		NUMBER
);

INSERT INTO EMPLOYEES VALUES('103','Alexander',10000);
INSERT INTO EMPLOYEES VALUES('104','Bruce',10000);
INSERT INTO EMPLOYEES VALUES('105','David',4800);
INSERT INTO EMPLOYEES VALUES('106','Valli',4800);
INSERT INTO EMPLOYEES VALUES('107','Diana',4200);

COMMIT;


SELECT EMPLOYEE_ID,
	   NAME,
	   SALARY,
	   SUM(SALARY) OVER (ORDER BY SALARY) AS SUM1,
	   SUM(SALARY) OVER (ORDER BY SALARY 
	   					 RANGE UNBOUNDED PRECEDING) AS SUM2
  FROM EMPLOYEES; 
    
    
    
select LENGTH('oracle')
from dual;
    