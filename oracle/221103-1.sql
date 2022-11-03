SELECT
    *
FROM
    employee;


-- 1. ���μ��� ���ؼ� �μ���ȣ, �����, �μ� ���� ��� ����� ��� �޿���
-- �μ����� �������� ���. ��ձ޿� �ݿø�
SELECT
    dno,
    COUNT(*)           AS �����,
    round(AVG(salary)) AS "��� �޿�"
FROM
    employee
GROUP BY
    dno
ORDER BY
    dno;

-- 2. �� �μ��� ���� �μ���ȣ �̸�, ������, �����, �μ����� ��� �����
-- ��� �޿� ��� - ��� �޿� �ݿø�

SELECT
    dno,
    ename,
    COUNT(dno) AS �����,
    CASE
        WHEN dno = '10' THEN
            '�뱸'
        WHEN dno = '20' THEN
            '�λ�'
        ELSE
            '����'
    END        AS ������
FROM
    employee
GROUP BY
    dno,
    ename
ORDER BY
    dno;

-- 3. �μ���ȣ, �����, �����, �μ��� �ο� ���հ�, ��� �μ� �ο�, �ݾ� ���հ� ���
-- rollup ��� -> ���� ����
SELECT
    dno,
    ename,
    COUNT(*)    �����,
    SUM(salary) AS ���հ�
FROM
    employee
GROUP BY
    ROLLUP(dno,
           ename);

-- 4. 3������ cube ���(rollup ��)

SELECT
    dno,
    ename,
    COUNT(*)    �����,
    SUM(salary) AS ���հ�
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
-- join�� where �� �ʿ�!!
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
    e.ename   AS "����̸�",
    e.manager "���",
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
    || '�� ���� �����'
    || manager.ename
FROM
         employee employees
    JOIN employee manager ON employees.manager = manager.eno (+);

-- ANSI OUTER JOIN
SELECT
    employees.ename
    || '�� ���� �����'
    || manager.ename
FROM
    employee employees
    LEFT OUTER JOIN employee manager ON employees.manager = manager.eno;

-- 1. SCOTT ����� �̸�, �μ���ȣ, �μ��̸� ��� - ��������(EQUI ����)
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

-- 2. �����, �μ���, ������ ���
-- ��������(ǥ��), join~on, join~using, equi ���� 4����
SELECT
    em.ename,
    em.dno,
    de.loc
FROM
    employee em,
    department de
WHERE
    em.dno = de.dno;


-- 3. �̸��� A�� ���Ե� ��� ����� �̸�, �μ��� ��� (equi, natural)
select e.ename,d.dname
from employee e,department d
where  e.dno = d.dno and e.ename like '%A%';

select e.ename,d.dname
from employee e NATURAL join department d
where  e.ename like '%A%';

-- 4. Ŀ�̼��� �޴� �����, �μ���, �ٹ��� ���(equi, natural)
select e.ename,d.dname, d.loc
from employee e,department d
where  e.dno = d.dno and e.commission is not null;

select e.ename,d.dname, d.loc
from employee e natural join department d
where e.commission is not null;

-- 5. ���忡 �ٹ��ϴ� ��� ����� �̸�, ����, �μ���ȣ, �μ��� ���(equi, natural)
select e.ename, e.job, e.dno, d.dname, d.loc
from employee e,department d
where  e.dno = d.dno and d.loc = 'NEW YORK';

select e.ename, e.job, dno, d.dname, d.loc
from employee e natural join department d
where d.loc = 'NEW YORK';

