-- 관리자 없는 사원이름 담당 업무 출력
SELECT
    ename,
    job
FROM
    employee
WHERE
    manager IS NULL;

-- 커미션 받을 수 있는 사원
SELECT
    ename,
    salary,
    commission
FROM
    employee
WHERE
    commission IS NOT NULL
    AND commission <> 0
ORDER BY
    salary DESC,
    commission DESC;

-- 3.이름의 3번째 문자 'R'
SELECT
    ename
FROM
    employee
WHERE
    ename LIKE '__R%';

-- 4. 이름에 A와 E모두 포함
SELECT
    ename
FROM
    employee
WHERE
    ename LIKE '%A%'
    AND ename LIKE '%E%';

-- 5. 담당업무 사무원
SELECT
    ename,
    job,
    salary
FROM
    employee
WHERE
    job = 'CLERK'
      OR job = 'SALESMAN'
    AND ( salary != 1600
          AND salary != 950
              AND salary != 1300 );
                  
    
-- 1. 업무별 급여
select job, max(salary) 최고, min(salary) as 최저, sum(salary) as 합, round(avg(salary)) as 평균
from employee
group by job
;

-- 2. 담당업무가 동일한 사원 수 출력
select job, count(*) 동일사원
from employee
group by job;

--3. 업무별로 사원 최저 급여
select job, min(salary) as 최저급여
from employee
group by job
HAVING min(salary) > 2000
order by 최저급여 desc;