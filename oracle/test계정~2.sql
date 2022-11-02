SELECT
    ename       AS �����,
    salary      AS �޿�,
    salary * 12 AS ���޿�
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

-- 2000�Ѵ� ���
SELECT
    ename,
    salary
FROM
    employee
WHERE
    salary > 2000
ORDER BY
    salary ASC;

-- 300 �޿� �λ�
SELECT
    ename,
    salary,
    salary + 300 AS upsalary
FROM
    employee;

-- ���� ���� ������ ���1
SELECT
    ename,
    salary,
    salary * 12 + commission AS yearsalary
FROM
    employee
ORDER BY
    yearsalary DESC;

-- ���� ���� ������ ���2
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


-- �޿� 2000 ~3000 ����
SELECT
    ename,
    salary
FROM
    employee
WHERE
    salary NOT BETWEEN 2000 AND 3000;
    
    
-- �޿� 2000 ~3000 ���� ���ԵǴ� ��� ���(2����)
Select ename
from employee
where salary between 2000 and 3000;


-- 1981/2/20 ~ 1982/5/1 ���̿� �Ի��� ��� �̸� ������, �Ի��� ���
Select ename, job,hiredate
from employee
where hiredate between '1981/2/20' and '1982/5/1';


-- �μ� ��ȣ�� 20 ~30�� ���� ����� �̸��� �μ���ȣ ��� - �̸� ���� ��������
Select ename, manager, dno
from employee
where dno between 20 and 30
order by ename desc;



-- ����� �޿��� 2000 ~ 3000 ���̿� ���Եǰ� �μ���ȣ�� 20 �Ǵ� 30��
-- ����� �̸�, �޿�, �μ���ȣ ��� - �̸� ���� ���� ����
Select ename, salary, dno
from employee
where salary between 2000 and 3000 and dno between 20 and 30
order by ename ;



-- 1981�⵵�� �Ի��� ����� �̸�, �Ի��� ���(like ���)
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
    