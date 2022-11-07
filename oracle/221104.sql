-- equi ����

--1. ����̸��� �ش� ����� �����ϴ� ������ ���(null�� ���x) - ���� ����
SELECT DISTINCT
    employees.ename,
    employees.manager
FROM
         employee employees
    JOIN employee manager ON employees.manager IS NOT NULL;


--2. WARD ������� �Ի����� ���� �����, �Ի��� ��� - �Ի��� ���� �������� -��������
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

--3. ��� �̸��� �ش� ����� �����ϴ� ������ ���(null�� ���) - �ܺ� ����
SELECT
    e.ename,
    e.manager
FROM
    employee   e,
    department d
WHERE
    e.dno = d.dno;

SELECT
    e.ename ���,
    m.ename ������
FROM
    employee e
    LEFT OUTER JOIN employee m ON e.manager = m.eno;

--4. ���, �����, ������, �����ڹ�ȣ, �μ���ȣ, �μ��� ��� - �ܺ� ���� (left, right ��)
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
-- ���� ����
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

-- ������ �� ������ (IN '=',(ANY,SOME) = �ϳ� �̻� ��ġ ��,
-- ALL= ��� ���� ��ġ�ϸ� ��,EXISTS= �ϳ� �̻� ����� ��)

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

-- any ������
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


-- 1. �����ȣ�� 7788�� ����� �������� ���� ��� ���
-- ����� ������ ���
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


-- 2. �����ȣ�� 7499���� �޿��� ���� �����, ������, �޿� ���
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

--3. �ּ�, �ִ� �޿��� �޴� �����, ������, �޿� ���
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


-- 4. �� �μ��� �ּ� �޿��� �޴� �����, �޿�, �μ���ȣ ���
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


-- 5. �� �μ��� �ּ� �޿��� �޴� �����, �޿�, �μ���ȣ �μ���, �ٹ��� ���
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
    
    
-- 6. �������� analyst�� ������� �޿��� �����鼭 ������ analyst�� �ƴ�
-- ����� ��� - ���, �����, ������, �޿�
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

-- 7. ���ӻ���� ���� ���� ���
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

-- 8. ���ӻ���� ���� ����, �μ���, �ٹ��� ���
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