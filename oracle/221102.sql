SELECT
    ename,
    hiredate,
    to_char(hiredate, 'yy-mm') AS 년월,
    to_char(hiredate, 'yyyy-mm/d day') as 년월일
FROM
    employee;
