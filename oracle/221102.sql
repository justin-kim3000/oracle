SELECT
    ename,
    hiredate,
    to_char(hiredate, 'yy-mm') AS ���,
    to_char(hiredate, 'yyyy-mm/d day') as �����
FROM
    employee;
