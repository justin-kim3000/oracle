-- ������ ���� ����̸� ��� ���� ���
SELECT
    ename,
    job
FROM
    employee
WHERE
    manager IS NULL;

-- Ŀ�̼� ���� �� �ִ� ���
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

-- 3.�̸��� 3��° ���� 'R'
SELECT
    ename
FROM
    employee
WHERE
    ename LIKE '__R%';

-- 4. �̸��� A�� E��� ����
SELECT
    ename
FROM
    employee
WHERE
    ename LIKE '%A%'
    AND ename LIKE '%E%';

-- 5. ������ �繫��
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
                  
    
-- 1. ������ �޿�
select job, max(salary) �ְ�, min(salary) as ����, sum(salary) as ��, round(avg(salary)) as ���
from employee
group by job
;

-- 2. �������� ������ ��� �� ���
select job, count(*) ���ϻ��
from employee
group by job;

--3. �������� ��� ���� �޿�
select job, min(salary) as �����޿�
from employee
group by job
HAVING min(salary) > 2000
order by �����޿� desc;