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

-- �ɽ� ������ ���. �޸� �� ����
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
        SUM(salary) AS �޿��հ�,
        AVG(salary) AS �޿����
    FROM
        employee
    GROUP BY
        dno;

SELECT
    �޿��հ�,
    �޿����
FROM
    v_emp_salary;

SELECT
    level  ���޼���,
    eno    ���,
    ename  �����,
    job    ������,
    salary �޿�
FROM
    employee
START WITH
    manager IS NULL
CONNECT BY
    PRIOR eno = manager
ORDER SIBLINGS BY
    manager;


-- 1. ���޼���, ���, �����, ������, �Ŵ�����ȣ, �Ի���
-- �޿�, Ŀ�̼�, �μ���ȣ, �μ��� ���.
SELECT
    level            ���޼���,
    eno              ���,
    ename            �����,
    job              ������,
    salary           �޿�,
    commission       Ŀ�̼�,
    dno              �μ���ȣ,
    department.dname �μ���
FROM
         employee
    INNER JOIN department USING ( dno )
START WITH
    manager IS NULL
CONNECT BY
    PRIOR eno = manager
ORDER BY
    ���޼���;



-- 2. 1�� query�� view�� ���� - ���޼��� �������� ����
DROP VIEW v_about_1query;

CREATE VIEW v_about_1query AS
    SELECT
        level            ���޼���,
        eno              ���,
        ename            �����,
        job              ������,
        salary           �޿�,
        commission       Ŀ�̼�,
        dno              �μ���ȣ,
        department.dname �μ���
    FROM
             employee
        INNER JOIN department USING ( dno )
    START WITH
        manager IS NULL
    CONNECT BY
        PRIOR eno = manager
    ORDER BY
        ���޼���;

CREATE OR REPLACE VIEW jok_v AS
    SELECT
        level        ���޼���,
        e.eno        ���,
        e.ename      �����,
        e.job        ������,
        e.manager    �󼭹�ȣ,
        e.hiredate   �Ի���,
        e.salary     �޿�,
        e.commission Ŀ�̼�,
        e.dno        �μ���ȣ,
        (
            SELECT
                dname
            FROM
                department
            WHERE
                e.dno = dno
        )            �μ���
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
    ���޼���;

-- ����Ŭ ������
-- currval
-- nextval
/*

SELECT �ش������.NEXTVAL FROM DUAL; - �ش� �������� ���� ��

SELECT �ش������.CURRVAL FROM DUAL; - �ش� �������� ���� ��

INSERT INTO example VALUES(�ش������.NEXTVAL) - �ش� �������� ���� ���� insert

select���� ������ ���� ���� ������ ���� �����ȴ� => ���̺�� �������� �����̱� ������
*/
CREATE SEQUENCE dno_seq INCREMENT BY 10 START WITH 10;

INSERT INTO dept_second VALUES (
    dno_seq.NEXTVAL,
    'ACCOUNTING',
    'NEW YORK'
);

-- Ư���� ���̺� ����
CREATE INDEX idx_employee_ename ON
    employee (
        ename
    );

/*
1. �л� ���̺� ����
�й�(����), �̸�(����), �а�(����), ����(����), ����(����),
��ȭ(����), �ּ�(����), ���(����), ������ȣ(����)
��������1: �⺻Ű(�й�), ����Ű(������ȣ)
��������2: �а�('��ǻ�Ͱ�', '����', '�����','�����','���ڰ�')
                ����(age >19), ����('��','��')
��������3: ���(NULL)�� �����ϰ� ��� �÷�(NOT NULL)
-----------------------------------------------------
2. ���� ���̺� ����
������ȣ(����), �̸�(����), �а�(����), ����(����), ��ȭ(����)
��������1 : �⺻Ű(������ȣ), ����(age>30),
                �а�('��ǻ�Ͱ�', '����', '�����','�����','���ڰ�')
��������2: ��� �÷� NOT NULL
-----------------------------------------------------
�� ���̺� ������ 10�� �̻� �߰�.
-----------------------------------------------------
3. �μ����� �����, �μ���, �޿�, �޿����, �޿����, ������ ���
-----------------------------------------------------
4. 3�� sql������ �̿��Ͽ� �������̺��� �����Ͽ� ��� ���� ���
*/

/*
1. �л� ���̺� ����
�й�(����), �̸�(����), �а�(����), ����(����), ����(����),
��ȭ(����), �ּ�(����), ���(����), ������ȣ(����)
��������1: �⺻Ű(�й�), ����Ű(������ȣ)
��������2: �а�('��ǻ�Ͱ�', '����', '�����','�����','���ڰ�')
                ����(age >19), ����('��','��')
��������3: ���(NULL)�� �����ϰ� ��� �÷�(NOT NULL)*/
drop table student_uni;
CREATE TABLE student_uni (
    id     VARCHAR2(5) primary key,
    name    VARCHAR2(10) NOT NULL,
    depart VARCHAR2(30) NOT NULL check (depart in ('��ǻ�Ͱ�', '����', '�����','�����','���ڰ�')),
    age NUMBER NOT NULL check (age>19),
    gender VARCHAR2(5) NOT NULL check (gender in ('��','��')),
    phone VARCHAR2(20) NOT NULL,
    adress VARCHAR2(50) NOT NULL,
    hobby VARCHAR2(20),
    -- ���� ����
    pro_number     VARCHAR2(10),
    CONSTRAINT pro_fk FOREIGN KEY (pro_number)
    REFERENCES professor_uni (pro_number)
);

INSERT INTO student_uni VALUES('1','Kim','��ǻ�Ͱ�',25,'��','02-122-1246','�����','����','0001');
/*
2. ���� ���̺� ����
������ȣ(����), �̸�(����), �а�(����), ����(����), ��ȭ(����)
��������1 : �⺻Ű(������ȣ), ����(age>30),
                �а�('��ǻ�Ͱ�', '����', '�����','�����','���ڰ�')
��������2: ��� �÷� NOT NULL
*/

drop table professor_uni;
CREATE TABLE professor_uni (
    pro_number     VARCHAR2(10) primary key,
    name    VARCHAR2(10) NOT NULL,
    depart VARCHAR2(30) NOT NULL check (depart in ('��ǻ�Ͱ�', '����', '�����','�����','���ڰ�')),
    age NUMBER NOT NULL CHECK ( age > 30 ),
    phone VARCHAR2(20) NOT NULL
);
insert into professor_uni values('0001','Kim','��ǻ�Ͱ�',38,'192-281-2122');

/*
3. �����, �μ���, �޿�, �޿����, ������ ���
-----------------------------------------------------
4. 3�� sql������ �̿��Ͽ� �������̺��� �����Ͽ� ��� ���� ���
*/

select ename, dno, salary, dense_rank() over (order by salary desc) all_rank, commission
--�޿����,
from employee;

CREATE VIEW rank_employee AS
select ename, dno, salary, dense_rank() over (order by salary desc) all_rank, commission
--�޿����,
from employee;