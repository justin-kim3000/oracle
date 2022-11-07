-- 1. ���������� ���� ���� ���
SELECT
    ename
FROM
    employee
WHERE
    eno NOT IN (
        SELECT
            manager
        FROM
            employee
        WHERE
            manager IS NOT NULL
    );

SELECT
    eno,
    ename,
    salary
FROM
    employee
WHERE
    eno NOT IN (
        SELECT
            manager
        FROM
            employee
        WHERE
            manager IS NOT NULL
    );

-- 2. BLAKE�� ������ �μ��� ���� �����, �Ի��� ��� - BLAKE�� ��� ����
SELECT
    ename,
    hiredate,
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
                ename = 'BLAKE'
        )
    AND ename != 'BLAKE'; 


-- 3. �ٹ����� DALLAS�� �����, �μ���ȣ, ������ ��� - �̸� ��������
-- ��������, ���� ���

SELECT
    ename,
    dno,
    department.dname,
    loc
FROM
         employee
    INNER JOIN department USING ( dno )
WHERE
    loc = (
        SELECT
            loc
        FROM
            department
        WHERE
            loc = 'DALLAS'
    );
    

-- ����� �����͸� ���� (Update)
/*
UPDATE table_name
Set column_name1 = value1, column_name2
where conditins ;
*/
DROP TABLE dept_copy11;

CREATE TABLE dept_copy
    AS
        SELECT
            *
        FROM
            department;

UPDATE dept_copy
SET
    dname = 'PROGRAMMING'
WHERE
    dno = 10;

UPDATE dept_copy
SET
    loc = (
        SELECT
            loc
        FROM
            dept_copy
        WHERE
            dno = 20
    )
WHERE
    dno = 10;

UPDATE dept_copy
SET
    dname = (
        SELECT
            dname
        FROM
            dept_copy
        WHERE
            dno = 30
    ),
    loc = (
        SELECT
            loc
        FROM
            dept_copy
        WHERE
            dno = 30
    )
WHERE
    dno = 10;

-- delete ����
/*delete [from] table_name
where condigions;*/

DELETE dept_copy
WHERE
    dno = 10;

DELETE emp_copy
WHERE
    dno = (
        SELECT
            dno
        FROM
            department
        WHERE
            dname = 'SALES'
    );

/*
NOT NULL Į���� NULL�� �������� ���ϵ���
UNIQUE ���̺��� ��� �ο쿡 ���ؼ� ������ ���� ������ �Ѵ�.
PRIMARY KEY ���̺��� �� ���� �ĺ��ϱ� ���� ������ NULL��
�ߺ��� ���� ��� ������� �ʴ´�. ��, NOT NULL ���ǰ� UNIQUE������ ������ ����
FOREIGN KEY �����Ǵ� ���̺� Į�� ���� �׻� �����ؾ� �Ѵ�.
*/

CREATE TABLE customer (
    id     VARCHAR2(20) NOT NULL,
    pwd    VARCHAR2(20) NOT NULL,
    name   VARCHAR2(20) NOT NULL,
    phone  VARCHAR2(30),
    adress VARCHAR2(100)
);

CREATE TABLE customer (
    id     VARCHAR2(20) UNIQUE,
    pwd    VARCHAR2(20) NOT NULL,
    name   VARCHAR2(20) NOT NULL,
    phone  VARCHAR2(30),
    adress VARCHAR2(100)
);

INSERT INTO customer VALUES (
    NULL,
    NULL,
    NULL,
    '010-111-1111',
    'seoul'
);

CREATE TABLE customer (
    id     VARCHAR2(20)
        CONSTRAINT customer_id_uk UNIQUE,
    pwd    VARCHAR2(20)
        CONSTRAINT customer_pwd_nn NOT NULL,
    name   VARCHAR2(20)
        CONSTRAINT customer_name_nn NOT NULL,
    phone  VARCHAR2(30),
    adress VARCHAR2(100)
);

CREATE TABLE customer (
    id     VARCHAR2(20),
    pwd    VARCHAR2(20)
        CONSTRAINT customer_pwd_nn NOT NULL,
    name   VARCHAR2(20)
        CONSTRAINT customer_name_nn NOT NULL,
    phone  VARCHAR2(30),
    adress VARCHAR2(100),
    CONSTRAINT customer_id_pk PRIMARY KEY ( id )
);

CREATE TABLE emp_second (
    eno   NUMBER(4) PRIMARY KEY,
    ename VARCHAR2(10),
    job   VARCHAR2(20),
    dno   NUMBER(4)
        CONSTRAINT emp_second_dno��
            REFERENCES department
);

CREATE TABLE emp_second (
    eno    NUMBER(4) PRIMARY KEY,
    ename  VARCHAR2(10),
    job    VARCHAR2(20),
    salary NUMBER(10)
        CONSTRAINT emp_second_salary_min CHECK ( salary > 0 )
);

CREATE TABLE emp_second (
    eno    NUMBER(4) PRIMARY KEY,
    ename  VARCHAR2(10),
    salary NUMBER(7) DEFAULT 1000
);

INSERT INTO emp_second (
    eno,
    ename
) VALUES (
    1,
    'ȫ�浿'
);

/*
�л� ���̺� ���� - student_t
1. id (���ڿ� 5, �⺻Ű), name(���ڿ� 10 NULL �ƴ�),
���� (����, NULL�ƴ�), ����(���ڿ� 5, NULL �ƴ�),
�г�(���ڿ� 10, NULL�ƴ�), �ּ�(���ڿ� 50, NULL �ƴ�)
2. ���� ���� ��� 
�⺻Ű : id
check : (���� >19), ����('��','��'),
           �г�('1�г�','2�г�','3�г�','4�г�')
3. �������Ǹ��� ���Ƿ� �ۼ� (���̺��_�÷���_�������Ǹ�)
4. ���� �����͸� �Է��Ͽ� �������� ���踦 �׽�Ʈ �ϱ�
*/
drop table student_t;
CREATE TABLE student_t (
    id     VARCHAR2(5) primary key,
    name    VARCHAR2(10) NOT NULL,
    age NUMBER NOT NULL check (age>19),
    gender VARCHAR2(5) NOT NULL check (gender in ('��','��')),
    grade VARCHAR2(10) NOT NULL check (grade in ('1�г�','2�г�','3�г�','4�г�')),
    adress VARCHAR2(50) NOT NULL
);

CREATE TABLE student_t (
    id     VARCHAR2(5) primary key,
    name    VARCHAR2(10) NOT NULL,
    age NUMBER NOT NULL,
    gender VARCHAR2(5) NOT NULL ,
    grade VARCHAR2(10) NOT NULL,
    adress VARCHAR2(50) NOT NULL,
    constraint st_age_chk check (age>19),
    constraint st_gender_chk check (gender in ('��','��')),
    constraint st_grade_chk check (grade in ('1�г�','2�г�','3�г�','4�г�'))
);


insert into student_t values('1','��浿',20,'��','1�г�','�뱸��');
insert into student_t values('2','����',20,'��','1�г�','�뱸��');
insert into student_t values('3','����',20,'��','1�г�','�뱸��');
insert into student_t values('4','�ڻ��',21,'��','3�г�','�����');