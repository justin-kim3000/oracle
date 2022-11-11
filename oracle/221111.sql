-- 부서테이블에 dno, dname, loc 추가
create or replace procedure dept_ins_p(
    v_dno in number,
    v_dname in department.dname%type,
    v_loc in varchar2,
    v_result out varchar2
)is
    cnt number := 0;
    
    -- 사용자 정의 exception
    EXIST_DNO_ERR exception;
begin
    select count(*) into cnt from department
        where dno = v_dno and rownum =1;
    if cnt >0 then
        v_result := '등록된 부서번호';
        raise EXIST_DNO_ERR;
    else
        insert into department(dno,dname, loc)
            values(v_dno, v_dname,v_loc);
        commit;
        v_result := '정상입력!';
    end if;
    exception
        when EXIST_DNO_ERR then
            rollback;
            dbms_output.put_line('DB error');

end;
/
-- out 전용 bind 변수
var v_res1 varchar2(50);
execute dept_ins_p(12,'개발부','대구',:v_res1);
print v_res1;



-- 리턴값이 존재하는 형태(C에서 return 함수)
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

select dno 부서번호, eno 사번, ename 사원명,
    get_name(dno) 부서명 from employee;


-- 트리거
create or replace trigger emp_tr before
    insert or update of ename, salary or delete on employee
    
begin
    case
        when inserting then
            dbms_output.put_line('T[insert 트리거]');
        when updating('salary') then
            dbms_output.put_line('T[급여 수정 트리거]');
        when updating('ename') then
            dbms_output.put_line('T[사원명 수정 트리거]');
        when deleting then
            dbms_output.put_line('T[delete 트리거]');
        end case;
        
end;
/

insert into employee (eno, ename, job) values (999, '홍길동', '감사팀');
update employee set ename ='김길동' where eno =999;
delete from employee where eno=999;


-- 트리거2
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
insert into department values (33,'개발5팀','대구');
select *from dept_hist;