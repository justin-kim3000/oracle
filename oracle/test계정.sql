-- ���̺� ����
/*
CREATE TABLE customer_t(
    name VARCHAR2(20),
    age number,
    gender char(1),
    rdate date default sysdate
);
*/

 -- ���� ����
 /*
INSERT INTO customer_t (
    name,
    age,
    gender
) VALUES (
    '��浿',
    100,
    'M'
);
*/
/*
-- �÷��� ������ ������ ������ ��ġ�ؾ� ��
INSERT INTO customer_t (
    name,
    age,
    gender
) VALUES (
    'ȫ�浿',
    100,
    'M'
);

-- �÷����� �����ϴ� ��쿡�� ��� ������ �߰��ؾ���
INSERT INTO customer_t VALUES (
    'ȫ�浿',
    100,
    'M',
    sysdate
);

-- ������ ����
SELECT
    name
FROM
    customer_t;

SELECT
    name,
    age,
    gender
FROM
    customer_t;

SELECT
    *
FROM
    customer_t
WHERE
    gender IS NULL;

SELECT
    name,age, count(*)
FROM
    customer_t
GROUP By CUBE(name,gender)
ORDER BY
    name;*/
  
  
-- ������ Ÿ��
/*
varchar2: �������� ���ڿ�(����) - 'ȫ�浿'
char : ���� ���� ���ڿ�
number: ����(����)
int: ����(����)
date: ��¥
clob : ��뷮 ���ڿ�
blob : �̹���, ������

*/
    
-- �л� ���̺� ����
/*
1. ���̺�� student_t
2. �÷��� �й�, �̸�, ����, �ּ�, ��ȭ��ȣ, �̸���, ī��id
3. �й�, ���̴� ����, �������� ���ڿ�
4. ���� ������ 10�� insert
5. select�� ����Ͽ� ������ ���
*/
-- ���̺� ����
/*
CREATE TABLE student_t1(
    id number,
    name VARCHAR2(20),
    age number,
    address VARCHAR2(20),
    phoneNumber VARCHAR2(20),
    email VARCHAR2(30),
    kakaoId VARCHAR2(20)
);

INSERT INTO student_t1 VALUES (
    2022000126,
    '�ڿ���',
    22,
    '�̱�',
    '011-0314-4444',
    'three55@naver.com',
    'three55'
);
*/

-- ���̺� ���ο� �÷� �߰�
ALTER TABLE student_t1 ADD (
    name2 VARCHAR2(40)
);

-- ���̺� �÷� ����
ALTER TABLE student_t1 MODIFY (
    name2 VARCHAR2(20)
);

-- ���� �˻�
SELECT
    id,
    name,
    phonenumber,
    age
FROM
    student_t1
WHERE
    name LIKE '%��ġ';

SELECT
    *
FROM
    student_t1;

DELETE FROM student_t1;

select age, count(*) as cantt
from student_t1
GROUP by age
ORDER by cantt ASC;


select destinct id from student_t1;