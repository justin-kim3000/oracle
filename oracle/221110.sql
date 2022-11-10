set SERVEROUTPUT on
begin
dbms_output.put_line('welcome '||'~to Oracle');
end;
/

--declare
--v_eno employee.eno%type;
--v_ename employee.ename%type;

-- ���
declare
    grade char(10);
    result varchar(30);
begin
    grade := 'B';
    if grade = 'A' then
        result := 'A����';
    elsif grade = 'B' then
        result := 'B����';
    elsif grade = 'C' then
        result := 'C����';
    else
        result := '����';
    end if;
    dbms_output.put_line('����: ' || grade || '=>' || result);
    exception
        when others then
        dbms_output.put_line('���� �߻�');
        
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
        result := 'A����';
    elsif grade = 'B' and score >=80 then
        result := 'B����';
    elsif grade = 'C' then
        result := 'C����';
    else
        result := '����';
    end if;
    dbms_output.put_line('����: ' || grade || '=>' || result);
    exception
        when others then
        dbms_output.put_line('���� �߻�');
        
end;
/

-- �ݺ��� for

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

-- �ݺ��� while

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

-- ���� ����

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

-- 1~100 ���� 3�� ���

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

-- cursor ������ ǥ��
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


-- ���ν��� -void �Լ� ����
create or replace procedure emp_info(
    p_empno in employee.eno%type
) is
v_eno employee.eno%type;
v_sal number;
v_ename employee.ename%type;

begin
    select eno, ename, salary into v_eno,v_ename,v_sal
    from employee where eno = p_empno;
    dbms_output.put_line('���: ' || v_eno);
    dbms_output.put_line('�̸�: ' || v_ename);
    dbms_output.put_line('�޿�: ' || v_sal);
exception
        when others then
            dbms_output.put_line('ORalcle DB ����');
end;

execute emp_info(7788);