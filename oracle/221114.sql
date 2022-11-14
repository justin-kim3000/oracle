DROP TABLE professor_test;

CREATE TABLE professor_test (
    id    VARCHAR2(20) PRIMARY KEY,
    name  VARCHAR2(20) NOT NULL,
    major VARCHAR2(20) NOT NULL
);

DROP TABLE student_test;

CREATE TABLE student_test (
    id    VARCHAR2(20) PRIMARY KEY,
    name  VARCHAR2(20) NOT NULL,
    major VARCHAR2(20) NOT NULL,
        
    INFONO VARCHAR2(20),
    CONSTRAINT FK_INFONO FOREIGN KEY(INFONO) REFERENCES professor_test(id)

);

insert into professor_test values('P001','ȫ�浿','��ǻ�Ͱ�');
insert into professor_test values('P002','������','�����');
insert into professor_test values('P003','�ֱ浿','���а�');

insert into student_test values('S001','����ġ','��ǻ�Ͱ�','P001');
insert into student_test values('S002','���ġ','�����','P002');
insert into student_test values('S003','�ڿ�ġ','���а�','P003');
insert into student_test values('S004','�̿�ġ','�����','P002');
insert into student_test values('S005','�Ӳ���','�����','P002');


ALTER TABLE student_test
ADD CONSTRAINT fk_midx foreign KEY(id) references professor_test (id);

select * from student_test,professor_test;
