-- �μ����̺� dno, dname, loc �߰�
create or replace procedure dept_ins_p(
    v_dno in number,
    v_dname in department.dname%type,
    v_loc in varchar2,
    v_result out varchar2
)is
    cnt number := 0;
    
    -- ����� ���� exception
    EXIST_DNO_ERR exception;
begin
    select count(*) into cnt from department
        where dno = v_dno and rownum =1;
    if cnt >0 then
        v_result := '��ϵ� �μ���ȣ';
        raise EXIST_DNO_ERR;
    else
        insert into department(dno,dname, loc)
            values(v_dno, v_dname,v_loc);
        commit;
        v_result := '�����Է�!';
    end if;
    exception
        when EXIST_DNO_ERR then
            rollback;
            dbms_output.put_line('DB error');

end;
/
-- out ���� bind ����
var v_res1 varchar2(50);
execute dept_ins_p(12,'���ߺ�','�뱸',:v_res1);
print v_res1;



-- ���ϰ��� �����ϴ� ����(C���� return �Լ�)
create or replace function get_name(
    v_dno department.dno%type
) return department.dname%type
is
    v_dname department.dname%type;
begin
    select dname into v_dname from department
        where dno = v_dno;
        return v_dname;
    exception
        when others then
            dbms_output.put_line(sqlcode || sqlerrm);
            return 0;
end;
/

select dno �μ���ȣ, eno ���, ename �����,
    get_name(dno) �μ��� from employee;


-- Ʈ����
create or replace trigger emp_tr before
    insert or update of ename, salary or delete on employee
    
begin
    case
        when inserting then
            dbms_output.put_line('T[insert Ʈ����]');
        when updating('salary') then
            dbms_output.put_line('T[�޿� ���� Ʈ����]');
        when updating('ename') then
            dbms_output.put_line('T[����� ���� Ʈ����]');
        when deleting then
            dbms_output.put_line('T[delete Ʈ����]');
        end case;
        
end;
/

insert into employee (eno, ename, job) values (999, 'ȫ�浿', '������');
update employee set ename ='��浿' where eno =999;
delete from employee where eno=999;


-- Ʈ����2
create table dept_hist as select * from department where 0=1;
create or replace trigger dept_tr before
    insert on department for each row
begin
    if inserting then
        insert into dept_hist(dno,dname,loc)
            values(:new.dno,:new.dname,:new.loc);
        end if;
    end;
/
insert into department values (33,'����5��','�뱸');
select *from dept_hist;