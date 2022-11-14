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

insert into professor_test values('P001','홍길동','컴퓨터과');
insert into professor_test values('P002','유관순','전기과');
insert into professor_test values('P003','최길동','수학과');

insert into student_test values('S001','전우치','컴퓨터과','P001');
insert into student_test values('S002','김우치','전기과','P002');
insert into student_test values('S003','박우치','수학과','P003');
insert into student_test values('S004','이우치','전기과','P002');
insert into student_test values('S005','임꺽정','전기과','P002');


ALTER TABLE student_test
ADD CONSTRAINT fk_midx foreign KEY(id) references professor_test (id);

select * from student_test,professor_test;
