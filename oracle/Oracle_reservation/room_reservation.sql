select bname �ǹ��̸�, rname ���̸�, rtype ���, rprice "1�� ����", baddr �ּ�
from room_t r inner join reservation_t v
on r.rname = v.r_no
inner join business_t b
on b.bno=r.b_no;

-- ���Ȯ��
select *
from room_t r inner join reservation_t v
on vvacant = 1 and r.rname = v.r_no
inner join business_t b
on b.bno=r.b_no;

select bname �ǹ��̸�, rname ���̸�, rtype ���, rprice "1�� ����", baddr �ּ�
from room_t r inner join reservation_t v
on vvacant = 1 and r.rname = v.r_no
inner join business_t b
on b.bno=r.b_no;

-- �����Ⱓ�� ���� �� ����
select bname �ǹ��̸�, rname ���̸�, rtype ���, rprice "1�� ����", baddr �ּ�, vperiod �����Ⱓ, vprice*vperiod �Ѱ���
from room_t r inner join reservation_t v
on vvacant = 1 and r.rname = v.r_no
inner join business_t b
on b.bno=r.b_no;

-- �ּ��� �˻� : ����
select bname �ǹ��̸�, rname ���̸�, rtype ���, rprice "1�� ����", baddr �ּ�
from room_t r inner join reservation_t v
on vvacant = 1 and r.rname = v.r_no
inner join business_t b
on b.bno=r.b_no
where baddr like '%����%';

-- ���ݰ˻� 30000~60000��
select bname �ǹ��̸�, rname ���̸�, rtype ���, rprice "1�� ����",  
        decode(vvacant, 1, '���డ��',
                                0, '����Ұ���') �������, baddr �ּ�
from room_t r inner join reservation_t v
on r.rname = v.r_no
inner join business_t b
on b.bno=r.b_no
where rprice between 30000 and 60000;

-- �ǹ��̸����� �˻�(���������� �˻� : �Ŷ�ȣ��, toyoco-in, �纸��)
select bname �ǹ��̸�, rname ���̸�, rtype ���, rprice "1�� ����",  
            decode(vvacant, 1, '���డ��',
                                     0, '����Ұ���') �������, baddr �ּ�
from room_t r inner join reservation_t v
on r.rname = v.r_no
inner join business_t b
on b.bno=r.b_no
where bname like '%�纸��%';

-- n���� ���� �˻� : 3����, 4����
select bname �ǹ��̸�, rname ���̸�, rtype ���, rprice "1�� ����",  
            decode(vvacant, 1, '���డ��',
                                     0, '����Ұ���') �������, baddr �ּ�
from room_t r inner join reservation_t v
on r.rname = v.r_no
inner join business_t b
on b.bno=r.b_no
where rtype in ('3STAR', '4STAR')
order by �������, rtype;

select bname �ǹ��̸�, rname ���̸�, rtype ���, rprice "1�� ����",  
            decode(vvacant, 1, '���డ��',
                                     0, '����Ұ���') �������, baddr �ּ�
from room_t r inner join reservation_t v
on r.rname = v.r_no
inner join business_t b
on b.bno=r.b_no
where rtype like '3%' or rtype like '4%'
order by �������, rtype;

-- 50���� ������ 2�� �̻��� ��
select bname �ǹ��̸�, rname ���̸�, rtype ���, rprice "1�� ����",  
            decode(vvacant, 1, '���డ��',
                                     0, '����Ұ���') �������, baddr �ּ�, vperiod �����Ⱓ, vprice*vperiod �Ѱ���
from room_t r inner join reservation_t v
on r.rname = v.r_no
inner join business_t b
on b.bno=r.b_no
where vperiod >= 2 and vprice*vperiod <= 500000;

-- ��������� ����
-- ���̸�(��t) �ǹ��̸�(����t) ���̸�(��t) ���(��t) 1�ϰ���(��t) �����ϼ�(����t) ������ �Ѱ�����(1�ϰ���*�����ϼ�*������)
-- �������� 3���̻��̸� 5%����(�� ���̺��� 3���� �ִ� ����, ������ �߰��ϸ� 5or10���� 5%, 20�� �Ѿ�� 10%
select cname ���̸�, bname �ǹ��̸�, rname ���̸�, rtype ���, rprice "1�� ����", vperiod �����ϼ�, 
        case when vperiod >=3 then vprice*vperiod*0.95
        else vprice*vperiod
        end as �Ѱ���
from room_t r inner join reservation_t v
on r.rname = v.r_no
inner join business_t b
on b.bno=r.b_no
inner join customer_t c
on c.cno = v.c_no
where vperiod >=3;

-- ���������+���ݰ��� ����
-- �������� 3���̻��̸� 5%����(�� ���̺��� 3���� �ִ� ����, ������ �߰��ϸ� 5or10���� 5%, 20�� �Ѿ�� 10%
-- ������� = �����̸� ���� 5%
-- ���̸�(��t) �ǹ��̸�(����t) ���̸�(��t) ���(��t) 1�ϰ���(��t) ������� �����ϼ�(����t) ������ �Ѱ�����(1�ϰ���*�����ϼ�*������)
select cname ���̸�, bname �ǹ��̸�, rname ���̸�, rtype ���, rprice "1�� ����", vtype "���� ���", vperiod �����ϼ�, vprice*vperiod "���� �� ����",
        case when vperiod >=3 and vtype = '����' then vprice*vperiod*0.95*0.95
                when (vperiod >=3 and vtype != '����') or (vperiod <3 and vtype = '����') then vprice*vperiod*0.95
        else vprice*vperiod
        end as �Ѱ���
from room_t r inner join reservation_t v
on r.rname = v.r_no
inner join business_t b
on b.bno=r.b_no
inner join customer_t c
on c.cno = v.c_no;
--where vperiod >=3 and vtype = '����';  --���������, ���� �����߰�



 
 -- ���̿�� ��������
-- ���̸�(��t) �ǹ��̸�(����t) ���̸�(��t) ���(��t) 1�ϰ���(��t) �̿�Ƚ��(����t����ī��Ʈ) ������ �����ϼ�(����t) �Ѱ�����(1�ϰ���*�����ϼ�*������)
select cname ���̸�, bname �ǹ��̸�, rname ���̸�, rtype ���, rprice "1�� ����", vperiod �����ϼ�, vprice*vperiod �Ѱ���, count(*)
from room_t r inner join reservation_t v
on r.rname = v.r_no
inner join business_t b
on b.bno=r.b_no
inner join customer_t c
on c.cno = v.c_no
group by c.cno;
-- �������̺��� ��������ȣ �˻����� �������� �̻��� �˻��Ǹ� ������ ����