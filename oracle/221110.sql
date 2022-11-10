set SERVEROUTPUT on
begin
dbms_output.put_line('welcome '||'~to Oracle');
end;
/

--declare
--v_eno employee.eno%type;
--v_ename employee.ename%type;

-- 제어문
declare
    grade char(10);
    result varchar(30);
begin
    grade := 'B';
    if grade = 'A' then
        result := 'A학점';
    elsif grade = 'B' then
        result := 'B학점';
    elsif grade = 'C' then
        result := 'C학점';
    else
        result := '제적';
    end if;
    dbms_output.put_line('학점: ' || grade || '=>' || result);
    exception
        when others then
        dbms_output.put_line('에러 발생');
        
end;
/

declare
    grade char(10);
    result varchar(30);
    score number;
begin
    grade := 'B';
    score := 90;
    if grade = 'A' and score >= 90 then
        result := 'A학점';
    elsif grade = 'B' and score >=80 then
        result := 'B학점';
    elsif grade = 'C' then
        result := 'C학점';
    else
        result := '제적';
    end if;
    dbms_output.put_line('학점: ' || grade || '=>' || result);
    exception
        when others then
        dbms_output.put_line('에러 발생');
        
end;
/

-- 반복문 for

declare
    i number :=0;
    res number :=0;

begin
    for i in 1..10 loop
        res:= i*2;
        dbms_output.put_line(res);
    end loop;
end;
/

-- 반복문 while

declare
    i number :=0;
    res number :=0;

begin
    while i <= 10 loop
        res:= i*2;
        dbms_output.put_line(res);
        i := i+1;
    end loop;
end;
/

-- 무한 루프

declare
    V_num number :=0;
    res number :=0;

begin
    loop
        res := res + V_num;
        if V_num >= 10 then
            exit;
        end if;
        V_num := V_num +1;
        dbms_output.put_line(res);
    end loop;
end;
/

-- 1~100 사이 3의 배수

declare
    i number :=1;
    res number :=0;

begin
    while i <= 100 loop
        res:= i;
        dbms_output.put_line(res);
        i := i*3;
    end loop;
end;
/

-- use cursor
declare
    cursor emp_cursor is
    select * from employee where dno = 20;
    emp_buf employee%rowtype;
begin
    open emp_cursor;
    loop
    
    fetch emp_cursor into emp_buf;
    exit when emp_cursor%notfound;
    dbms_output.put_line(emp_buf.eno || ':' || emp_buf.ename);
    end loop;
    close emp_cursor;
end;
/

-- cursor 간결한 표현
declare
begin
    for emp_buf in
    (
        select * from employee where dno =20
        )
    loop
        dbms_output.put_line(emp_buf.eno || ':' || emp_buf.ename);
    end loop;
    
end;
/


-- 프로시저 -void 함수 형태
create or replace procedure emp_info(
    p_empno in employee.eno%type
) is
v_eno employee.eno%type;
v_sal number;
v_ename employee.ename%type;

begin
    select eno, ename, salary into v_eno,v_ename,v_sal
    from employee where eno = p_empno;
    dbms_output.put_line('사번: ' || v_eno);
    dbms_output.put_line('이름: ' || v_ename);
    dbms_output.put_line('급여: ' || v_sal);
exception
        when others then
            dbms_output.put_line('ORalcle DB 에러');
end;

execute emp_info(7788);