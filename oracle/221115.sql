

DROP TABLE student_1115;
CREATE TABLE student_1115 (
    id    VARCHAR2(20) PRIMARY KEY,
    name  VARCHAR2(20) NOT NULL,
    major VARCHAR2(20) NOT NULL
);


DROP TABLE subject_1115;
CREATE TABLE subject_1115 (
    SUB_id    VARCHAR2(20) PRIMARY KEY,
    name  VARCHAR2(20) NOT NULL,  
    grade NUMBER(2) NOT NULL
);


DROP TABLE regist_1115;
CREATE TABLE regist_1115 (
    ID VARCHAR2(30),
    CONSTRAINT FK_ID FOREIGN KEY(ID) REFERENCES student_1115(id),
    SUB_ID VARCHAR2(30),
    CONSTRAINT FK_SUB_ID FOREIGN KEY(SUB_id) REFERENCES subject_1115(SUB_id),
       
    CONSTRAINT TEST_PK PRIMARY KEY(ID, SUB_ID)
);




insert into student_1115 values('S001','홍길동','컴퓨터과');
insert into student_1115 values('S002','유관순','전기과');
insert into student_1115 values('S003','최길동','수학과');

insert into subject_1115 values('B001','자바',3);
insert into subject_1115 values('B002','회로이론',3);
insert into subject_1115 values('B003','선형대수',3);


insert into regist_1115 values('S001','B001');
insert into regist_1115 values('S001','B002');
insert into regist_1115 values('S002','B002');


