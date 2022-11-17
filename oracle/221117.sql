-- ���̺� ������ ���踦 ����Ͽ� �� ���� �����ص� ������ �߻����� �ʰ� ���ĵǾ����ϴ�.
-- ���̺� ����
--SELECT 'DROP TABLE "' || TABLE_NAME || '" CASCADE CONSTRAINTS;' FROM user_tables;

-- ���̺� ������ ���踦 ����Ͽ� �� ���� �����ص� ������ �߻����� �ʰ� ���ĵǾ����ϴ�.
-- ���̺� ����
drop table reservation_t;
drop table customer_t;
drop table room_t;
drop table business_t;
drop table owner_t;
drop table firm_t;

-- firm_t Table Create SQL ȸ�����̺�
CREATE TABLE firm_t
(
    fname       VARCHAR2(20)    NOT NULL, 
    femail     VARCHAR2(20)    NOT NULL, 
    ftel      VARCHAR2(20)    NOT NULL, 
    faddr       VARCHAR2(50)    NOT NULL, 
     PRIMARY KEY (fname)
)
/

COMMENT ON TABLE firm_t IS 'ȸ�����̺�'
/

COMMENT ON COLUMN firm_t.fname IS 'ȸ���̸�'
/

COMMENT ON COLUMN firm_t.femail IS '�̸���'
/

COMMENT ON COLUMN firm_t.ftel IS '��ȭ��ȣ'
/

COMMENT ON COLUMN firm_t.faddr IS '��ġ'
/


-- owner_t Table Create SQL �������̺�
CREATE TABLE owner_t
(
    ono       VARCHAR2(20)    NOT NULL, 
    oname     VARCHAR2(20)    NOT NULL, 
    onum      VARCHAR2(20)    NOT NULL, 
    oid       VARCHAR2(20)    NOT NULL, 
    opw       VARCHAR2(20)    NOT NULL, 
    oemail    VARCHAR2(20)    NOT NULL, 
    otel      VARCHAR2(20)    NOT NULL, 
    f_name    VARCHAR2(20)    NOT NULL, 
    PRIMARY KEY (ono)
)
/

COMMENT ON TABLE owner_t IS '�������̺�'
/

COMMENT ON COLUMN owner_t.ono IS '���ֹ�ȣ'
/

COMMENT ON COLUMN owner_t.oname IS '�̸�'
/

COMMENT ON COLUMN owner_t.onum IS '����ڹ�ȣ'
/

COMMENT ON COLUMN owner_t.oid IS '����ID'
/

COMMENT ON COLUMN owner_t.opw IS '����PW'
/

COMMENT ON COLUMN owner_t.oemail IS '�̸���'
/

COMMENT ON COLUMN owner_t.otel IS '�ڵ�����ȣ'
/

COMMENT ON COLUMN owner_t.f_name IS 'ȸ���̸�'
/

ALTER TABLE owner_t
    ADD CONSTRAINT FK_owner_t_f_name_firm_t_fname FOREIGN KEY (f_name)
        REFERENCES firm_t (fname)
/

-- business_t Table Create SQL  �������̺�
CREATE TABLE business_t
(
    bno      VARCHAR2(20)    NOT NULL, 
    baddr    VARCHAR2(100)    NOT NULL, 
    bname    VARCHAR2(40)    NOT NULL, 
    btype    VARCHAR2(20)    NOT NULL, 
    o_no     VARCHAR2(20)    NOT NULL, 
     PRIMARY KEY (bno)
)
/

COMMENT ON TABLE business_t IS '�������̺�'
/

COMMENT ON COLUMN business_t.bno IS '�Ϸù�ȣ'
/

COMMENT ON COLUMN business_t.baddr IS '�ּ�'
/

COMMENT ON COLUMN business_t.bname IS '������'
/

COMMENT ON COLUMN business_t.btype IS 'Ÿ��'
/

COMMENT ON COLUMN business_t.o_no IS '���ֹ�ȣ'
/

ALTER TABLE business_t
    ADD CONSTRAINT FK_business_t_o_no_owner_t_ono FOREIGN KEY (o_no)
        REFERENCES owner_t (ono)
/


-- room_t Table Create SQL �����̺�
CREATE TABLE room_t
(
    rname     VARCHAR2(20)    NOT NULL, 
    rprice    VARCHAR2(20)    NOT NULL, 
    rtype     VARCHAR2(20)    NOT NULL, 
    rnum      VARCHAR2(20)    NOT NULL, 
    b_no      VARCHAR2(20)    NOT NULL, 
     PRIMARY KEY (rname)
)
/

COMMENT ON TABLE room_t IS '�����̺�'
/

COMMENT ON COLUMN room_t.rname IS '���̸�'
/

COMMENT ON COLUMN room_t.rprice IS '����'
/

COMMENT ON COLUMN room_t.rtype IS 'Ÿ��'
/

COMMENT ON COLUMN room_t.rnum IS '����'
/

COMMENT ON COLUMN room_t.b_no IS '�����Ϸù�ȣ'
/

ALTER TABLE room_t
    ADD CONSTRAINT FK_room_t_b_no_business_t_bno FOREIGN KEY (b_no)
        REFERENCES business_t (bno)
/


-- customer_t Table Create SQL �����̺�
CREATE TABLE customer_t
(
    cno       VARCHAR2(20)    NOT NULL, 
    cname     VARCHAR2(20)    NOT NULL, 
    cid       VARCHAR2(20)    NOT NULL, 
    cpw       VARCHAR2(20)    NOT NULL, 
    cemail    VARCHAR2(20)    NOT NULL, 
    ctel      VARCHAR2(20)    NOT NULL, 
    f_name   VARCHAR2(20)    NOT NULL, 
     PRIMARY KEY (cno)
)
/

COMMENT ON TABLE customer_t IS '�����̺�'
/

COMMENT ON COLUMN customer_t.cno IS '����ȣ'
/

COMMENT ON COLUMN customer_t.cname IS '�̸�'
/

COMMENT ON COLUMN customer_t.cid IS '��ID'
/

COMMENT ON COLUMN customer_t.cpw IS '��PW'
/

COMMENT ON COLUMN customer_t.cemail IS '�̸���'
/

COMMENT ON COLUMN customer_t.ctel IS '�ڵ�����ȣ'
/

COMMENT ON COLUMN customer_t.f_name IS 'ȸ���̸�'
/

ALTER TABLE customer_t
    ADD CONSTRAINT FK_customer_t_f_name_firm_t_fname FOREIGN KEY (f_name)
        REFERENCES firm_t (fname)
/


-- reservation_t Table Create SQL �������̺�
CREATE TABLE reservation_t
(
    vno       VARCHAR2(20)    NOT NULL, 
    vtype     VARCHAR2(20)    NOT NULL, 
    vprice    VARCHAR2(20)    NOT NULL, 
    vnum      VARCHAR2(20)    NOT NULL, 
    vstart    DATE            NOT NULL, 
    vend      DATE            NOT NULL, 
    vvacant      VARCHAR2(20)   NOT NULL, 
    r_no      VARCHAR2(20)    NOT NULL, 
    c_no      VARCHAR2(20)    NOT NULL, 
     PRIMARY KEY (vno)
)
/

COMMENT ON TABLE reservation_t IS '�������̺�'
/

COMMENT ON COLUMN reservation_t.vno IS '�����ȣ'
/

COMMENT ON COLUMN reservation_t.vtype IS '�������'
/

COMMENT ON COLUMN reservation_t.vprice IS '�ݾ�'
/

COMMENT ON COLUMN reservation_t.vnum IS '�ο���'
/

COMMENT ON COLUMN reservation_t.vstart IS '���ڽ�����'
/

COMMENT ON COLUMN reservation_t.vend IS '����������'
/

COMMENT ON COLUMN reservation_t.vvacant IS '����÷�'
/

COMMENT ON COLUMN reservation_t.r_no IS '�����ѹ��ȣ'
/

COMMENT ON COLUMN reservation_t.c_no IS '�����Ѱ���ȣ'
/

ALTER TABLE reservation_t
    ADD CONSTRAINT FK_reservation_t_r_no_room_t_rname FOREIGN KEY (r_no)
        REFERENCES room_t (rname)
/

ALTER TABLE reservation_t
    ADD CONSTRAINT FK_reservation_t_c_no_customer_t_cno FOREIGN KEY (c_no)
        REFERENCES customer_t (cno)
/


--------------------------------------------------------------------------
-- data
-- FIRM_T ������ �߰�
Insert into FIRM_T (FNAME,FEMAIL,FTEL,FADDR) values ('F001','F001@google.com','0531111111','�뱸������ ����');

-- OWNER_T ������ �߰�
Insert into OWNER_T (ONO,ONAME,ONUM,OID,OPW,OEMAIL,OTEL,F_NAME) values ('O001','�赵��','O0001','O101','0000','O001@google.com','053 5716030','F001');
Insert into OWNER_T (ONO,ONAME,ONUM,OID,OPW,OEMAIL,OTEL,F_NAME) values ('O002','���Ѽ�','O0002','O102','0000','O002@google.com','053 5542696','F001');
Insert into OWNER_T (ONO,ONAME,ONUM,OID,OPW,OEMAIL,OTEL,F_NAME) values ('O003','�����','O0003','O103','0000','O003@google.com','053 4231200','F001');
Insert into OWNER_T (ONO,ONAME,ONUM,OID,OPW,OEMAIL,OTEL,F_NAME) values ('O004','�迥Ƽ','O0004','O104','0000','O004@google.com','053 5542169','F001');
Insert into OWNER_T (ONO,ONAME,ONUM,OID,OPW,OEMAIL,OTEL,F_NAME) values ('O005','�����','O0005','O105','0000','O005@google.com','053 2573686','F001');
Insert into OWNER_T (ONO,ONAME,ONUM,OID,OPW,OEMAIL,OTEL,F_NAME) values ('O006','����','O0006','O106','0000','O006@google.com','053 2522286','F001');
Insert into OWNER_T (ONO,ONAME,ONUM,OID,OPW,OEMAIL,OTEL,F_NAME) values ('O007','��μ�','O0007','O107','0000','O007@google.com','053 4230031','F001');
Insert into OWNER_T (ONO,ONAME,ONUM,OID,OPW,OEMAIL,OTEL,F_NAME) values ('O008','�����','O0008','O108','0000','O008@google.com','053 2523750','F001');
Insert into OWNER_T (ONO,ONAME,ONUM,OID,OPW,OEMAIL,OTEL,F_NAME) values ('O009','�����','O0009','O109','0000','O009@google.com','053 4228902','F001');
Insert into OWNER_T (ONO,ONAME,ONUM,OID,OPW,OEMAIL,OTEL,F_NAME) values ('O010','��ȣ��','O0010','O110','0000','O010@google.com','053 2550059','F001');
Insert into OWNER_T (ONO,ONAME,ONUM,OID,OPW,OEMAIL,OTEL,F_NAME) values ('O011','����','O0011','O111','0000','O011@google.com','053 424 0025','F001');
Insert into OWNER_T (ONO,ONAME,ONUM,OID,OPW,OEMAIL,OTEL,F_NAME) values ('O012','��ѹ�','O0012','O112','0000','O012@google.com','053 2571116','F001');
Insert into OWNER_T (ONO,ONAME,ONUM,OID,OPW,OEMAIL,OTEL,F_NAME) values ('O013','������','O0013','O113','0000','O013@google.com','053 4225454','F001');
Insert into OWNER_T (ONO,ONAME,ONUM,OID,OPW,OEMAIL,OTEL,F_NAME) values ('O014','���Ʈ','O0014','O114','0000','O014@google.com','053 424 3224','F001');
Insert into OWNER_T (ONO,ONAME,ONUM,OID,OPW,OEMAIL,OTEL,F_NAME) values ('O015','��Ÿ��','O0015','O115','0000','O015@google.com','053 5617800','F001');
Insert into OWNER_T (ONO,ONAME,ONUM,OID,OPW,OEMAIL,OTEL,F_NAME) values ('O016','�����','O0016','O116','0000','O016@google.com','053 5887533','F001');
Insert into OWNER_T (ONO,ONAME,ONUM,OID,OPW,OEMAIL,OTEL,F_NAME) values ('O017','���','O0017','O117','0000','O017@google.com','053 5542557','F001');
Insert into OWNER_T (ONO,ONAME,ONUM,OID,OPW,OEMAIL,OTEL,F_NAME) values ('O018','�����','O0018','O118','0000','O018@google.com','053 2566789','F001');
Insert into OWNER_T (ONO,ONAME,ONUM,OID,OPW,OEMAIL,OTEL,F_NAME) values ('O019','����','O0019','O119','0000','O019@google.com','053 2538900','F001');
Insert into OWNER_T (ONO,ONAME,ONUM,OID,OPW,OEMAIL,OTEL,F_NAME) values ('O020','��µ�','O0020','O120','0000','O020@google.com','053 4287701','F001');
Insert into OWNER_T (ONO,ONAME,ONUM,OID,OPW,OEMAIL,OTEL,F_NAME) values ('O021','����','O0021','O121','0000','O021@google.com','053 9585559','F001');
Insert into OWNER_T (ONO,ONAME,ONUM,OID,OPW,OEMAIL,OTEL,F_NAME) values ('O022','��쳲','O0022','O122','0000','O022@google.com','053 421 6661','F001');
Insert into OWNER_T (ONO,ONAME,ONUM,OID,OPW,OEMAIL,OTEL,F_NAME) values ('O023','�豳��','O0023','O123','0000','O023@google.com','053 564 2727','F001');
Insert into OWNER_T (ONO,ONAME,ONUM,OID,OPW,OEMAIL,OTEL,F_NAME) values ('O024','�質��','O0024','O124','0000','O024@google.com','053 6563822','F001');
Insert into OWNER_T (ONO,ONAME,ONUM,OID,OPW,OEMAIL,OTEL,F_NAME) values ('O025','�赿��','O0025','O125','0000','O025@google.com','053 5933399','F001');
Insert into OWNER_T (ONO,ONAME,ONUM,OID,OPW,OEMAIL,OTEL,F_NAME) values ('O026','����ġ','O0026','O126','0000','O026@google.com','053 5935757','F001');
Insert into OWNER_T (ONO,ONAME,ONUM,OID,OPW,OEMAIL,OTEL,F_NAME) values ('O027','����','O0027','O127','0000','O027@google.com','053582 3319','F001');
Insert into OWNER_T (ONO,ONAME,ONUM,OID,OPW,OEMAIL,OTEL,F_NAME) values ('O028','��ž','O0028','O128','0000','O028@google.com','053 5935133','F001');
Insert into OWNER_T (ONO,ONAME,ONUM,OID,OPW,OEMAIL,OTEL,F_NAME) values ('O029','�迥','O0029','O129','0000','O029@google.com','053 2563127','F001');
Insert into OWNER_T (ONO,ONAME,ONUM,OID,OPW,OEMAIL,OTEL,F_NAME) values ('O030','�躽��','O0030','O130','0000','O030@google.com','053 2554900','F001');
Insert into OWNER_T (ONO,ONAME,ONUM,OID,OPW,OEMAIL,OTEL,F_NAME) values ('O031','������','O0031','O131','0000','O031@google.com','053 2538021','F001');
Insert into OWNER_T (ONO,ONAME,ONUM,OID,OPW,OEMAIL,OTEL,F_NAME) values ('O032','��纸','O0032','O132','0000','O032@google.com','053 2573182','F001');
Insert into OWNER_T (ONO,ONAME,ONUM,OID,OPW,OEMAIL,OTEL,F_NAME) values ('O033','��纸��','O0033','O133','0000','O033@google.com','053 6151331','F001');
Insert into OWNER_T (ONO,ONAME,ONUM,OID,OPW,OEMAIL,OTEL,F_NAME) values ('O034','��뱸','O0034','O134','0000','O034@google.com','053 6331089','F001');
Insert into OWNER_T (ONO,ONAME,ONUM,OID,OPW,OEMAIL,OTEL,F_NAME) values ('O035','������','O0035','O135','0000','O035@google.com','053 6335811','F001');
Insert into OWNER_T (ONO,ONAME,ONUM,OID,OPW,OEMAIL,OTEL,F_NAME) values ('O036','������','O0036','O136','0000','O036@google.com','053 6143641','F001');
Insert into OWNER_T (ONO,ONAME,ONUM,OID,OPW,OEMAIL,OTEL,F_NAME) values ('O037','����','O0037','O137','0000','O037@google.com','053616 6111','F001');
Insert into OWNER_T (ONO,ONAME,ONUM,OID,OPW,OEMAIL,OTEL,F_NAME) values ('O038','�����','O0038','O138','0000','O038@google.com','053 7679822','F001');
Insert into OWNER_T (ONO,ONAME,ONUM,OID,OPW,OEMAIL,OTEL,F_NAME) values ('O039','��V','O0039','O139','0000','O039@google.com','053 981 3777','F001');
Insert into OWNER_T (ONO,ONAME,ONUM,OID,OPW,OEMAIL,OTEL,F_NAME) values ('O040','���ϴ�','O0040','O140','0000','O040@google.com','053 9859925','F001');
Insert into OWNER_T (ONO,ONAME,ONUM,OID,OPW,OEMAIL,OTEL,F_NAME) values ('O041','����','O0041','O141','0000','O041@google.com','053 9566933','F001');
Insert into OWNER_T (ONO,ONAME,ONUM,OID,OPW,OEMAIL,OTEL,F_NAME) values ('O042','���','O0042','O142','0000','O042@google.com','053 588 7219','F001');
Insert into OWNER_T (ONO,ONAME,ONUM,OID,OPW,OEMAIL,OTEL,F_NAME) values ('O043','������','O0043','O143','0000','O043@google.com','053 6211985','F001');
Insert into OWNER_T (ONO,ONAME,ONUM,OID,OPW,OEMAIL,OTEL,F_NAME) values ('O044','�����','O0044','O144','0000','O044@google.com','053 5885990','F001');
Insert into OWNER_T (ONO,ONAME,ONUM,OID,OPW,OEMAIL,OTEL,F_NAME) values ('O045','������','O0045','O145','0000','O045@google.com','053 522 3991','F001');
Insert into OWNER_T (ONO,ONAME,ONUM,OID,OPW,OEMAIL,OTEL,F_NAME) values ('O046','����','O0046','O146','0000','O046@google.com','053585 6922','F001');
Insert into OWNER_T (ONO,ONAME,ONUM,OID,OPW,OEMAIL,OTEL,F_NAME) values ('O047','�赵Ʈ','O0047','O147','0000','O047@google.com','053 6258866','F001');
Insert into OWNER_T (ONO,ONAME,ONUM,OID,OPW,OEMAIL,OTEL,F_NAME) values ('O048','�����','O0048','O148','0000','O048@google.com','053 5852323','F001');
Insert into OWNER_T (ONO,ONAME,ONUM,OID,OPW,OEMAIL,OTEL,F_NAME) values ('O049','����õ','O0049','O149','0000','O049@google.com','053 5937898','F001');
Insert into OWNER_T (ONO,ONAME,ONUM,OID,OPW,OEMAIL,OTEL,F_NAME) values ('O050','���','O0050','O150','0000','O050@google.com','053 6281133','F001');

-- CUSTOMER_T ������ �߰�
Insert into CUSTOMER_T (CNO,CNAME,CID,CPW,CEMAIL,CTEL,F_NAME) values ('C001','����','kim1','@l$eea12#awdwm','kim1@naver.com','010-0000-0001','F001');
Insert into CUSTOMER_T (CNO,CNAME,CID,CPW,CEMAIL,CTEL,F_NAME) values ('C002','������','kim2','@l$eea12#a@21!$','kim2@hanmail.net','010-0000-0002','F001');
Insert into CUSTOMER_T (CNO,CNAME,CID,CPW,CEMAIL,CTEL,F_NAME) values ('C003','�����','kim3','kim@a12#a!!#$','kim3@yahoo.com','010-0000-0003','F001');
Insert into CUSTOMER_T (CNO,CNAME,CID,CPW,CEMAIL,CTEL,F_NAME) values ('C004','�ڵ���','kim4','c$!hoi@!iasdft','kim4@hanmail.net','010-0000-0004','F001');
Insert into CUSTOMER_T (CNO,CNAME,CID,CPW,CEMAIL,CTEL,F_NAME) values ('C005','������','kim5','c$!hoi@!iasdft','kim5@naver.com','010-0000-0005','F001');
Insert into CUSTOMER_T (CNO,CNAME,CID,CPW,CEMAIL,CTEL,F_NAME) values ('C006','�ּ���','kim6','p!@a#rkt2!t@21!$','kim6@hanmail.net','010-0000-0006','F001');
Insert into CUSTOMER_T (CNO,CNAME,CID,CPW,CEMAIL,CTEL,F_NAME) values ('C007','�迵��','kim7','kim@i@!iwdwm','kim7@naver.com','010-0000-0007','F001');
Insert into CUSTOMER_T (CNO,CNAME,CID,CPW,CEMAIL,CTEL,F_NAME) values ('C008','����','kim8','p!@a#rka12#aasdft','kim8@gmail.com','010-0000-0008','F001');
Insert into CUSTOMER_T (CNO,CNAME,CID,CPW,CEMAIL,CTEL,F_NAME) values ('C009','������','kim9','kim@1ss2wdwm','kim9@gmail.com','010-0000-0009','F001');
Insert into CUSTOMER_T (CNO,CNAME,CID,CPW,CEMAIL,CTEL,F_NAME) values ('C010','������','kim10','@l$ee\@#oasdft','kim10@gmail.com','010-0000-0010','F001');
Insert into CUSTOMER_T (CNO,CNAME,CID,CPW,CEMAIL,CTEL,F_NAME) values ('C011','�ֵ���','kim11','@l$eea12#a@21!$','kim11@hanmail.net','010-0000-0011','F001');
Insert into CUSTOMER_T (CNO,CNAME,CID,CPW,CEMAIL,CTEL,F_NAME) values ('C012','�ڼ���','kim12','@l$ee\@#oasdft','kim12@hanmail.net','010-0000-0012','F001');
Insert into CUSTOMER_T (CNO,CNAME,CID,CPW,CEMAIL,CTEL,F_NAME) values ('C013','�迵��','kim13','p!@a#rkt2!tasdft','kim13@yahoo.com','010-0000-0013','F001');
Insert into CUSTOMER_T (CNO,CNAME,CID,CPW,CEMAIL,CTEL,F_NAME) values ('C014','�迵��','kim14','kim@i@!i!!#$','kim14@hanmail.net','010-0000-0014','F001');
Insert into CUSTOMER_T (CNO,CNAME,CID,CPW,CEMAIL,CTEL,F_NAME) values ('C015','�ֿ���','kim15','kim@1ss2wdwm','kim15@hanmail.net','010-0000-0015','F001');
Insert into CUSTOMER_T (CNO,CNAME,CID,CPW,CEMAIL,CTEL,F_NAME) values ('C016','�赿��','kim16','@l$ee1ss2asdft','kim16@yahoo.com','010-0000-0016','F001');
Insert into CUSTOMER_T (CNO,CNAME,CID,CPW,CEMAIL,CTEL,F_NAME) values ('C017','�̵���','kim17','c$!hoa12#awdwm','kim17@hanmail.net','010-0000-0017','F001');
Insert into CUSTOMER_T (CNO,CNAME,CID,CPW,CEMAIL,CTEL,F_NAME) values ('C018','�ڵ���','kim18','p!@a#rki@!i!!#$','kim18@hanmail.net','010-0000-0018','F001');
Insert into CUSTOMER_T (CNO,CNAME,CID,CPW,CEMAIL,CTEL,F_NAME) values ('C019','�ڵ���','kim19','c$!ho1ss2asdft','kim19@hanmail.net','010-0000-0019','F001');
Insert into CUSTOMER_T (CNO,CNAME,CID,CPW,CEMAIL,CTEL,F_NAME) values ('C020','������','kim20','c$!ho\@#owdwm','kim20@hanmail.net','010-0000-0020','F001');
Insert into CUSTOMER_T (CNO,CNAME,CID,CPW,CEMAIL,CTEL,F_NAME) values ('C021','������','kim21','@l$eet2!t!!#$','kim21@hanmail.net','010-0000-0021','F001');
Insert into CUSTOMER_T (CNO,CNAME,CID,CPW,CEMAIL,CTEL,F_NAME) values ('C022','�ڿ���','kim22','@l$ee\@#o@21!$','kim22@gmail.com','010-0000-0022','F001');
Insert into CUSTOMER_T (CNO,CNAME,CID,CPW,CEMAIL,CTEL,F_NAME) values ('C023','�ֵ���','kim23','kim@\@#owdwm','kim23@naver.com','010-0000-0023','F001');
Insert into CUSTOMER_T (CNO,CNAME,CID,CPW,CEMAIL,CTEL,F_NAME) values ('C024','�̿���','kim24','@l$eea12#awdwm','kim24@yahoo.com','010-0000-0024','F001');
Insert into CUSTOMER_T (CNO,CNAME,CID,CPW,CEMAIL,CTEL,F_NAME) values ('C025','�ڼ���','kim25','c$!ho1ss2wdwm','kim25@yahoo.com','010-0000-0025','F001');
Insert into CUSTOMER_T (CNO,CNAME,CID,CPW,CEMAIL,CTEL,F_NAME) values ('C026','������','kim26','kim@1ss2@21!$','kim26@naver.com','010-0000-0026','F001');
Insert into CUSTOMER_T (CNO,CNAME,CID,CPW,CEMAIL,CTEL,F_NAME) values ('C027','�ּ���','kim27','p!@a#rk1ss2@21!$','kim27@gmail.com','010-0000-0027','F001');
Insert into CUSTOMER_T (CNO,CNAME,CID,CPW,CEMAIL,CTEL,F_NAME) values ('C028','�ڿ���','kim28','@l$ee1ss2asdft','kim28@hanmail.net','010-0000-0028','F001');
Insert into CUSTOMER_T (CNO,CNAME,CID,CPW,CEMAIL,CTEL,F_NAME) values ('C029','�ֿ���','kim29','c$!hoa12#awdwm','kim29@hanmail.net','010-0000-0029','F001');
Insert into CUSTOMER_T (CNO,CNAME,CID,CPW,CEMAIL,CTEL,F_NAME) values ('C030','�̿���','kim30','c$!ho\@#o@21!$','kim30@hanmail.net','010-0000-0030','F001');
Insert into CUSTOMER_T (CNO,CNAME,CID,CPW,CEMAIL,CTEL,F_NAME) values ('C031','����','kim31','kim@i@!iwdwm','kim31@naver.com','010-0000-0031','F001');
Insert into CUSTOMER_T (CNO,CNAME,CID,CPW,CEMAIL,CTEL,F_NAME) values ('C032','�̵���','kim32','c$!ho\@#o@21!$','kim32@yahoo.com','010-0000-0032','F001');
Insert into CUSTOMER_T (CNO,CNAME,CID,CPW,CEMAIL,CTEL,F_NAME) values ('C033','������','kim33','@l$ee\@#oasdft','kim33@gmail.com','010-0000-0033','F001');
Insert into CUSTOMER_T (CNO,CNAME,CID,CPW,CEMAIL,CTEL,F_NAME) values ('C034','�ڼ���','kim34','p!@a#rk\@#oasdft','kim34@naver.com','010-0000-0034','F001');
Insert into CUSTOMER_T (CNO,CNAME,CID,CPW,CEMAIL,CTEL,F_NAME) values ('C035','�迵��','kim35','p!@a#rk\@#o!!#$','kim35@gmail.com','010-0000-0035','F001');
Insert into CUSTOMER_T (CNO,CNAME,CID,CPW,CEMAIL,CTEL,F_NAME) values ('C036','������','kim36','p!@a#rk\@#owdwm','kim36@gmail.com','010-0000-0036','F001');
Insert into CUSTOMER_T (CNO,CNAME,CID,CPW,CEMAIL,CTEL,F_NAME) values ('C037','�ּ���','kim37','p!@a#rk\@#o!!#$','kim37@gmail.com','010-0000-0037','F001');
Insert into CUSTOMER_T (CNO,CNAME,CID,CPW,CEMAIL,CTEL,F_NAME) values ('C038','������','kim38','c$!hoi@!i!!#$','kim38@naver.com','010-0000-0038','F001');
Insert into CUSTOMER_T (CNO,CNAME,CID,CPW,CEMAIL,CTEL,F_NAME) values ('C039','�ּ���','kim39','c$!ho1ss2!!#$','kim39@gmail.com','010-0000-0039','F001');
Insert into CUSTOMER_T (CNO,CNAME,CID,CPW,CEMAIL,CTEL,F_NAME) values ('C040','�ڼ���','kim40','kim@i@!iwdwm','kim40@hanmail.net','010-0000-0040','F001');
Insert into CUSTOMER_T (CNO,CNAME,CID,CPW,CEMAIL,CTEL,F_NAME) values ('C041','������','kim41','@l$eei@!iwdwm','kim41@hanmail.net','010-0000-0041','F001');
Insert into CUSTOMER_T (CNO,CNAME,CID,CPW,CEMAIL,CTEL,F_NAME) values ('C042','�ֵ���','kim42','kim@t2!t!!#$','kim42@naver.com','010-0000-0042','F001');
Insert into CUSTOMER_T (CNO,CNAME,CID,CPW,CEMAIL,CTEL,F_NAME) values ('C043','�赿��','kim43','@l$ee1ss2!!#$','kim43@gmail.com','010-0000-0043','F001');
Insert into CUSTOMER_T (CNO,CNAME,CID,CPW,CEMAIL,CTEL,F_NAME) values ('C044','�̿���','kim44','@l$eet2!t@21!$','kim44@naver.com','010-0000-0044','F001');
Insert into CUSTOMER_T (CNO,CNAME,CID,CPW,CEMAIL,CTEL,F_NAME) values ('C045','�ֿ���','kim45','c$!hoi@!iwdwm','kim45@yahoo.com','010-0000-0045','F001');
Insert into CUSTOMER_T (CNO,CNAME,CID,CPW,CEMAIL,CTEL,F_NAME) values ('C046','������','kim46','kim@a12#a@21!$','kim46@naver.com','010-0000-0046','F001');
Insert into CUSTOMER_T (CNO,CNAME,CID,CPW,CEMAIL,CTEL,F_NAME) values ('C047','������','kim47','@l$ee\@#o@21!$','kim47@yahoo.com','010-0000-0047','F001');
Insert into CUSTOMER_T (CNO,CNAME,CID,CPW,CEMAIL,CTEL,F_NAME) values ('C048','������','kim48','@l$ee\@#owdwm','kim48@hanmail.net','010-0000-0048','F001');
Insert into CUSTOMER_T (CNO,CNAME,CID,CPW,CEMAIL,CTEL,F_NAME) values ('C049','�ּ���','kim49','c$!ho\@#o@21!$','kim49@naver.com','010-0000-0049','F001');
Insert into CUSTOMER_T (CNO,CNAME,CID,CPW,CEMAIL,CTEL,F_NAME) values ('C050','������','kim50','c$!hot2!t@21!$','kim50@naver.com','010-0000-0050','F001');

-- BUSINESS_T ������ �߰�
Insert into BUSINESS_T (BNO,BADDR,BNAME,BTYPE,O_NO) values ('B001','�뱸������ �߱� ������5�� 94-17, 2,3,4�� (�����1��)','�鵵��','������','O001');
Insert into BUSINESS_T (BNO,BADDR,BNAME,BTYPE,O_NO) values ('B002','�뱸������ �߱� �޼���21�� 9-9 (�޼���)','�Ѽ�','���μ���','O002');
Insert into BUSINESS_T (BNO,BADDR,BNAME,BTYPE,O_NO) values ('B003','�뱸������ �߱� �޼�������6�� 12 (��ŵ�)','����','������','O002');
Insert into BUSINESS_T (BNO,BADDR,BNAME,BTYPE,O_NO) values ('B004','�뱸������ �߱� ���� 37 (����2��)','��Ƽ ������ ����','������','O003');
Insert into BUSINESS_T (BNO,BADDR,BNAME,BTYPE,O_NO) values ('B005','�뱸������ �߱� �޼���21�� 9-10 (�޼���)','����','���μ���','O003');
Insert into BUSINESS_T (BNO,BADDR,BNAME,BTYPE,O_NO) values ('B006','�뱸������ �߱� �߾Ӵ��65�� 17 (���굿)','��¸���','������','O003');
Insert into BUSINESS_T (BNO,BADDR,BNAME,BTYPE,O_NO) values ('B007','�뱸������ �߱� ���� 44-31 (����1��)','�Ƹ��� �μӸ���','���ھ� ��Ÿ','O004');
Insert into BUSINESS_T (BNO,BADDR,BNAME,BTYPE,O_NO) values ('B008','�뱸������ �߱� �����26�� 61 (�����)','������','������','O005');
Insert into BUSINESS_T (BNO,BADDR,BNAME,BTYPE,O_NO) values ('B009','�뱸������ �߱� ��ä�����99�� 38 (����Ϸ�)','����(YAJA)�뱸����������','������','O005');
Insert into BUSINESS_T (BNO,BADDR,BNAME,BTYPE,O_NO) values ('B010','�뱸������ �߱� ����2�� 29-11 (����)','ȣ���忩��','������','O006');
Insert into BUSINESS_T (BNO,BADDR,BNAME,BTYPE,O_NO) values ('B011','�뱸������ �߱� �ϼ��� 100-23 (�ϼ���1��)','���','������','O006');
Insert into BUSINESS_T (BNO,BADDR,BNAME,BTYPE,O_NO) values ('B012','�뱸������ �߱� ������ 100 (��â��)','�ѹ�25 ��������','������','O007');
Insert into BUSINESS_T (BNO,BADDR,BNAME,BTYPE,O_NO) values ('B013','�뱸������ �߱� ������16�� 84 (��ȵ�)','��������','������','O007');
Insert into BUSINESS_T (BNO,BADDR,BNAME,BTYPE,O_NO) values ('B014','�뱸������ �߱� ��󰨿��� 298-7 (���ε�2��)','��Ʈ����','������','O007');
Insert into BUSINESS_T (BNO,BADDR,BNAME,BTYPE,O_NO) values ('B015','�뱸������ �߱� ��ä�����149�� 10-9 (���ε�4��)','Ÿ�Ӹ���','������','O008');
Insert into BUSINESS_T (BNO,BADDR,BNAME,BTYPE,O_NO) values ('B016','�뱸������ �߱� �߾Ӵ��79�� 32 (����2��, ����3~5��)','�����Խ�Ʈ�Ͽ콺','������','O008');
Insert into BUSINESS_T (BNO,BADDR,BNAME,BTYPE,O_NO) values ('B017','�뱸������ �޼��� �޼����95�� 18 (ȣ�굿)','��(view)����','������','O009');
Insert into BUSINESS_T (BNO,BADDR,BNAME,BTYPE,O_NO) values ('B018','�뱸������ �߱� �޼�������4�� 39-20 (����Ϸ�)','��������','������','O009');
Insert into BUSINESS_T (BNO,BADDR,BNAME,BTYPE,O_NO) values ('B019','�뱸������ �߱� ����� 71-5 (���굿)','e-����','������','O009');
Insert into BUSINESS_T (BNO,BADDR,BNAME,BTYPE,O_NO) values ('B020','�뱸������ �߱� �߾Ӵ��81�� 101 (������)','�µ�ȣ��','������','O010');
Insert into BUSINESS_T (BNO,BADDR,BNAME,BTYPE,O_NO) values ('B021','�뱸������ �߱� �����4�� 31 (�����2��)','��ο�ȣ��','�Ϲ�ȣ��','O010');
Insert into BUSINESS_T (BNO,BADDR,BNAME,BTYPE,O_NO) values ('B022','�뱸������ �߱� �ϼ��� 104-6 (���̵�)','�쳲','������','O011');
Insert into BUSINESS_T (BNO,BADDR,BNAME,BTYPE,O_NO) values ('B023','�뱸������ �߱� �߾Ӵ�� 446-2 (ȭ����, ����2,3��)','�����Խ�Ʈ�Ͽ콺','���ھ� ��Ÿ','O012');
Insert into BUSINESS_T (BNO,BADDR,BNAME,BTYPE,O_NO) values ('B024','�뱸������ �޼��� ���� 161 (���ﵿ)','����','������','O012');
Insert into BUSINESS_T (BNO,BADDR,BNAME,BTYPE,O_NO) values ('B025','�뱸������ �޼��� �����21�� 62 (���絿)','�����忩��','������','O013');
Insert into BUSINESS_T (BNO,BADDR,BNAME,BTYPE,O_NO) values ('B026','�뱸������ �޼��� �޼����95�� 23 (ȣ�굿)','��ġ(Touch)����','������','O014');
Insert into BUSINESS_T (BNO,BADDR,BNAME,BTYPE,O_NO) values ('B027','�뱸������ �޼��� �̰�� 12 (�̰)','�����','������','O015');
Insert into BUSINESS_T (BNO,BADDR,BNAME,BTYPE,O_NO) values ('B028','�뱸������ �޼��� �̰�� 7, 5~8�� (�̰)','žȣ��','�Ϲ�ȣ��','O015');
Insert into BUSINESS_T (BNO,BADDR,BNAME,BTYPE,O_NO) values ('B029','�뱸������ �޼��� �������ܷ�15�� 14, ����1~����5�� (ȣ����)','���÷���(M+)','������','O016');
Insert into BUSINESS_T (BNO,BADDR,BNAME,BTYPE,O_NO) values ('B030','�뱸������ �߱� ���� 23-23 (�����, ����1,2��)','�����','���ھ� ��Ÿ','O016');
Insert into BUSINESS_T (BNO,BADDR,BNAME,BTYPE,O_NO) values ('B031','�뱸������ �߱� ��󰨿��� 300 (���ε�2��)','�����ڸ���','������','O017');
Insert into BUSINESS_T (BNO,BADDR,BNAME,BTYPE,O_NO) values ('B032','�뱸������ �߱� ���� 76 (��ȵ�)','�纸�� ȣ��','������','O017');
Insert into BUSINESS_T (BNO,BADDR,BNAME,BTYPE,O_NO) values ('B033','�뱸������ �߱� ������14�� 68-1 (��ȵ�)','�纸�� ȣ�� ����','������','O017');
Insert into BUSINESS_T (BNO,BADDR,BNAME,BTYPE,O_NO) values ('B034','�뱸������ �߱� �߾Ӵ��77�� 47 (�����, ����1~6��)','�뱸�̵�Ÿ��ȣ����','���ھ� ��Ÿ','O017');
Insert into BUSINESS_T (BNO,BADDR,BNAME,BTYPE,O_NO) values ('B035','�뱸������ �޼��� ȭ���� �񽽷� 2701','����(Jeep)','������','O018');
Insert into BUSINESS_T (BNO,BADDR,BNAME,BTYPE,O_NO) values ('B036','�뱸������ �޼��� ȭ���� �񽽷�512�� 2','�����忩��','������','O018');
Insert into BUSINESS_T (BNO,BADDR,BNAME,BTYPE,O_NO) values ('B037','�뱸������ �޼��� ����� �񽽷� 1768 ((�����պ�����1968-1->1963��������))','������','������','O019');
Insert into BUSINESS_T (BNO,BADDR,BNAME,BTYPE,O_NO) values ('B038','�뱸������ �޼��� ����� ������ 10','����������','������','O020');
Insert into BUSINESS_T (BNO,BADDR,BNAME,BTYPE,O_NO) values ('B039','�뱸������ �޼��� ��â�� ��ϱ� 93','V������','������','O021');
Insert into BUSINESS_T (BNO,BADDR,BNAME,BTYPE,O_NO) values ('B040','�뱸������ ���� �İ��138�� 42 (�ߴ뵿)','�ϴ��̿����½�ī�̸���','������','O021');
Insert into BUSINESS_T (BNO,BADDR,BNAME,BTYPE,O_NO) values ('B041','�뱸������ ���� �Ȱ����185�� 43 (�����)','���ڰ��Ÿ��','������','O022');
Insert into BUSINESS_T (BNO,BADDR,BNAME,BTYPE,O_NO) values ('B042','�뱸������ ���� ȿ���� 51-1 (ȿ��)','��(YA)����','������','O023');
Insert into BUSINESS_T (BNO,BADDR,BNAME,BTYPE,O_NO) values ('B043','�뱸������ �޼��� �޼����91�� 22, 1~5�� (ȣ�굿)','����ġȣ��','������','O023');
Insert into BUSINESS_T (BNO,BADDR,BNAME,BTYPE,O_NO) values ('B044','�뱸������ �޼��� ����� 13-4 (�η���)','������(2)����','������','O023');
Insert into BUSINESS_T (BNO,BADDR,BNAME,BTYPE,O_NO) values ('B045','�뱸������ �޼��� �޼����95�� 40 (ȣ�굿)','����','�Ϲ�ȣ��','O024');
Insert into BUSINESS_T (BNO,BADDR,BNAME,BTYPE,O_NO) values ('B046','�뱸������ �޼��� �����34�� 6 (���ε�)','�ʸ���','������','O024');
Insert into BUSINESS_T (BNO,BADDR,BNAME,BTYPE,O_NO) values ('B047','�뱸������ �޼��� �������ܷ�11�� 64-5, ����1~����6�� (ȣ�굿)','���Ʈȣ�ڴ뱸������','������','O025');
Insert into BUSINESS_T (BNO,BADDR,BNAME,BTYPE,O_NO) values ('B048','�뱸������ �޼��� ������11�� 78 (������)','ȣ�ڿ���(HOTEL5��)','������','O025');
Insert into BUSINESS_T (BNO,BADDR,BNAME,BTYPE,O_NO) values ('B049','�뱸������ �޼��� ��õ�� 68, 2~5�� (��õ��)','��õ����','������','O026');
Insert into BUSINESS_T (BNO,BADDR,BNAME,BTYPE,O_NO) values ('B050','�뱸������ �޼��� ���õ�� 203 (������)','��ȣ��','������','O027');

-- ROOM_T ������ �߰�
Insert into ROOM_T (RNAME,RPRICE,RTYPE,RNUM,B_NO) values ('RNAME001','157000','5STAR','1','B001');
Insert into ROOM_T (RNAME,RPRICE,RTYPE,RNUM,B_NO) values ('RNAME002','163000','5STAR','6','B002');
Insert into ROOM_T (RNAME,RPRICE,RTYPE,RNUM,B_NO) values ('RNAME003','74000','3STAR','3','B003');
Insert into ROOM_T (RNAME,RPRICE,RTYPE,RNUM,B_NO) values ('RNAME004','114000','4STAR','6','B004');
Insert into ROOM_T (RNAME,RPRICE,RTYPE,RNUM,B_NO) values ('RNAME005','100000','4STAR','6','B005');
Insert into ROOM_T (RNAME,RPRICE,RTYPE,RNUM,B_NO) values ('RNAME006','154000','5STAR','10','B006');
Insert into ROOM_T (RNAME,RPRICE,RTYPE,RNUM,B_NO) values ('RNAME007','164000','5STAR','8','B007');
Insert into ROOM_T (RNAME,RPRICE,RTYPE,RNUM,B_NO) values ('RNAME008','193000','5STAR','2','B008');
Insert into ROOM_T (RNAME,RPRICE,RTYPE,RNUM,B_NO) values ('RNAME009','156000','5STAR','9','B009');
Insert into ROOM_T (RNAME,RPRICE,RTYPE,RNUM,B_NO) values ('RNAME010','91000','3STAR','1','B010');
Insert into ROOM_T (RNAME,RPRICE,RTYPE,RNUM,B_NO) values ('RNAME011','130000','4STAR','4','B011');
Insert into ROOM_T (RNAME,RPRICE,RTYPE,RNUM,B_NO) values ('RNAME012','198000','5STAR','10','B012');
Insert into ROOM_T (RNAME,RPRICE,RTYPE,RNUM,B_NO) values ('RNAME013','52000','2STAR','9','B013');
Insert into ROOM_T (RNAME,RPRICE,RTYPE,RNUM,B_NO) values ('RNAME014','51000','2STAR','3','B014');
Insert into ROOM_T (RNAME,RPRICE,RTYPE,RNUM,B_NO) values ('RNAME015','197000','5STAR','7','B015');
Insert into ROOM_T (RNAME,RPRICE,RTYPE,RNUM,B_NO) values ('RNAME016','187000','5STAR','6','B016');
Insert into ROOM_T (RNAME,RPRICE,RTYPE,RNUM,B_NO) values ('RNAME017','25000','1STAR','6','B017');
Insert into ROOM_T (RNAME,RPRICE,RTYPE,RNUM,B_NO) values ('RNAME018','90000','3STAR','8','B018');
Insert into ROOM_T (RNAME,RPRICE,RTYPE,RNUM,B_NO) values ('RNAME019','147000','4STAR','6','B019');
Insert into ROOM_T (RNAME,RPRICE,RTYPE,RNUM,B_NO) values ('RNAME020','129000','4STAR','4','B020');
Insert into ROOM_T (RNAME,RPRICE,RTYPE,RNUM,B_NO) values ('RNAME021','90000','3STAR','2','B021');
Insert into ROOM_T (RNAME,RPRICE,RTYPE,RNUM,B_NO) values ('RNAME022','182000','5STAR','10','B022');
Insert into ROOM_T (RNAME,RPRICE,RTYPE,RNUM,B_NO) values ('RNAME023','70000','3STAR','3','B023');
Insert into ROOM_T (RNAME,RPRICE,RTYPE,RNUM,B_NO) values ('RNAME024','103000','4STAR','9','B024');
Insert into ROOM_T (RNAME,RPRICE,RTYPE,RNUM,B_NO) values ('RNAME025','147000','4STAR','2','B025');
Insert into ROOM_T (RNAME,RPRICE,RTYPE,RNUM,B_NO) values ('RNAME026','46000','2STAR','10','B026');
Insert into ROOM_T (RNAME,RPRICE,RTYPE,RNUM,B_NO) values ('RNAME027','37000','2STAR','2','B027');
Insert into ROOM_T (RNAME,RPRICE,RTYPE,RNUM,B_NO) values ('RNAME028','108000','4STAR','3','B028');
Insert into ROOM_T (RNAME,RPRICE,RTYPE,RNUM,B_NO) values ('RNAME029','119000','4STAR','10','B029');
Insert into ROOM_T (RNAME,RPRICE,RTYPE,RNUM,B_NO) values ('RNAME030','69000','3STAR','4','B030');
Insert into ROOM_T (RNAME,RPRICE,RTYPE,RNUM,B_NO) values ('RNAME031','87000','3STAR','9','B031');
Insert into ROOM_T (RNAME,RPRICE,RTYPE,RNUM,B_NO) values ('RNAME032','105000','4STAR','9','B032');
Insert into ROOM_T (RNAME,RPRICE,RTYPE,RNUM,B_NO) values ('RNAME033','185000','5STAR','10','B033');
Insert into ROOM_T (RNAME,RPRICE,RTYPE,RNUM,B_NO) values ('RNAME034','127000','4STAR','10','B034');
Insert into ROOM_T (RNAME,RPRICE,RTYPE,RNUM,B_NO) values ('RNAME035','26000','1STAR','6','B035');
Insert into ROOM_T (RNAME,RPRICE,RTYPE,RNUM,B_NO) values ('RNAME036','154000','5STAR','7','B036');
Insert into ROOM_T (RNAME,RPRICE,RTYPE,RNUM,B_NO) values ('RNAME037','172000','5STAR','6','B037');
Insert into ROOM_T (RNAME,RPRICE,RTYPE,RNUM,B_NO) values ('RNAME038','110000','4STAR','7','B038');
Insert into ROOM_T (RNAME,RPRICE,RTYPE,RNUM,B_NO) values ('RNAME039','60000','3STAR','1','B039');
Insert into ROOM_T (RNAME,RPRICE,RTYPE,RNUM,B_NO) values ('RNAME040','73000','3STAR','10','B040');
Insert into ROOM_T (RNAME,RPRICE,RTYPE,RNUM,B_NO) values ('RNAME041','177000','5STAR','6','B041');
Insert into ROOM_T (RNAME,RPRICE,RTYPE,RNUM,B_NO) values ('RNAME042','110000','4STAR','5','B042');
Insert into ROOM_T (RNAME,RPRICE,RTYPE,RNUM,B_NO) values ('RNAME043','184000','5STAR','2','B043');
Insert into ROOM_T (RNAME,RPRICE,RTYPE,RNUM,B_NO) values ('RNAME044','73000','3STAR','9','B044');
Insert into ROOM_T (RNAME,RPRICE,RTYPE,RNUM,B_NO) values ('RNAME045','178000','5STAR','1','B045');
Insert into ROOM_T (RNAME,RPRICE,RTYPE,RNUM,B_NO) values ('RNAME046','95000','3STAR','9','B046');
Insert into ROOM_T (RNAME,RPRICE,RTYPE,RNUM,B_NO) values ('RNAME047','47000','2STAR','6','B047');
Insert into ROOM_T (RNAME,RPRICE,RTYPE,RNUM,B_NO) values ('RNAME048','173000','5STAR','1','B048');
Insert into ROOM_T (RNAME,RPRICE,RTYPE,RNUM,B_NO) values ('RNAME049','121000','4STAR','6','B049');
Insert into ROOM_T (RNAME,RPRICE,RTYPE,RNUM,B_NO) values ('RNAME050','142000','4STAR','2','B050');

-- RESERVATION_T ������ �߰�
Insert into RESERVATION_T (VNO,VTYPE,VPRICE,VNUM,VSTART,VEND,R_NO,C_NO,VVACANT) values ('R002','ī��','163000','2',to_date('22/11/18','RR/MM/DD'),to_date('22/11/19','RR/MM/DD'),'RNAME002','C008','1');
Insert into RESERVATION_T (VNO,VTYPE,VPRICE,VNUM,VSTART,VEND,R_NO,C_NO,VVACANT) values ('R003','īī������','74000','2',to_date('22/11/18','RR/MM/DD'),to_date('22/11/19','RR/MM/DD'),'RNAME003','C009','0');
Insert into RESERVATION_T (VNO,VTYPE,VPRICE,VNUM,VSTART,VEND,R_NO,C_NO,VVACANT) values ('R004','�Ｚ����','114000','2',to_date('22/11/18','RR/MM/DD'),to_date('22/11/19','RR/MM/DD'),'RNAME004','C010','0');
Insert into RESERVATION_T (VNO,VTYPE,VPRICE,VNUM,VSTART,VEND,R_NO,C_NO,VVACANT) values ('R005','����','100000','2',to_date('22/11/18','RR/MM/DD'),to_date('22/11/19','RR/MM/DD'),'RNAME005','C011','0');
Insert into RESERVATION_T (VNO,VTYPE,VPRICE,VNUM,VSTART,VEND,R_NO,C_NO,VVACANT) values ('R006','ī��','154000','2',to_date('22/11/18','RR/MM/DD'),to_date('22/11/19','RR/MM/DD'),'RNAME006','C012','1');
Insert into RESERVATION_T (VNO,VTYPE,VPRICE,VNUM,VSTART,VEND,R_NO,C_NO,VVACANT) values ('R007','īī������','164000','2',to_date('22/11/18','RR/MM/DD'),to_date('22/11/19','RR/MM/DD'),'RNAME007','C013','1');
Insert into RESERVATION_T (VNO,VTYPE,VPRICE,VNUM,VSTART,VEND,R_NO,C_NO,VVACANT) values ('R008','�Ｚ����','193000','2',to_date('22/11/18','RR/MM/DD'),to_date('22/11/19','RR/MM/DD'),'RNAME008','C014','1');
Insert into RESERVATION_T (VNO,VTYPE,VPRICE,VNUM,VSTART,VEND,R_NO,C_NO,VVACANT) values ('R009','����','156000','2',to_date('22/11/18','RR/MM/DD'),to_date('22/11/19','RR/MM/DD'),'RNAME009','C015','0');
Insert into RESERVATION_T (VNO,VTYPE,VPRICE,VNUM,VSTART,VEND,R_NO,C_NO,VVACANT) values ('R010','ī��','91000','2',to_date('22/11/18','RR/MM/DD'),to_date('22/11/19','RR/MM/DD'),'RNAME010','C016','1');
Insert into RESERVATION_T (VNO,VTYPE,VPRICE,VNUM,VSTART,VEND,R_NO,C_NO,VVACANT) values ('R011','īī������','130000','2',to_date('22/11/18','RR/MM/DD'),to_date('22/11/19','RR/MM/DD'),'RNAME011','C017','0');
Insert into RESERVATION_T (VNO,VTYPE,VPRICE,VNUM,VSTART,VEND,R_NO,C_NO,VVACANT) values ('R012','�Ｚ����','198000','3',to_date('22/11/18','RR/MM/DD'),to_date('22/11/19','RR/MM/DD'),'RNAME012','C018','1');
Insert into RESERVATION_T (VNO,VTYPE,VPRICE,VNUM,VSTART,VEND,R_NO,C_NO,VVACANT) values ('R013','����','52000','1',to_date('22/11/18','RR/MM/DD'),to_date('22/11/19','RR/MM/DD'),'RNAME013','C019','1');
Insert into RESERVATION_T (VNO,VTYPE,VPRICE,VNUM,VSTART,VEND,R_NO,C_NO,VVACANT) values ('R014','ī��','51000','1',to_date('22/11/18','RR/MM/DD'),to_date('22/11/19','RR/MM/DD'),'RNAME014','C020','0');
Insert into RESERVATION_T (VNO,VTYPE,VPRICE,VNUM,VSTART,VEND,R_NO,C_NO,VVACANT) values ('R015','īī������','197000','3',to_date('22/11/18','RR/MM/DD'),to_date('22/11/19','RR/MM/DD'),'RNAME015','C021','1');
Insert into RESERVATION_T (VNO,VTYPE,VPRICE,VNUM,VSTART,VEND,R_NO,C_NO,VVACANT) values ('R016','�Ｚ����','187000','3',to_date('22/11/18','RR/MM/DD'),to_date('22/11/19','RR/MM/DD'),'RNAME016','C022','0');
Insert into RESERVATION_T (VNO,VTYPE,VPRICE,VNUM,VSTART,VEND,R_NO,C_NO,VVACANT) values ('R017','����','25000','1',to_date('22/11/18','RR/MM/DD'),to_date('22/11/19','RR/MM/DD'),'RNAME017','C023','1');
Insert into RESERVATION_T (VNO,VTYPE,VPRICE,VNUM,VSTART,VEND,R_NO,C_NO,VVACANT) values ('R018','ī��','90000','3',to_date('22/11/19','RR/MM/DD'),to_date('22/11/20','RR/MM/DD'),'RNAME018','C024','1');
Insert into RESERVATION_T (VNO,VTYPE,VPRICE,VNUM,VSTART,VEND,R_NO,C_NO,VVACANT) values ('R019','īī������','147000','2',to_date('22/11/19','RR/MM/DD'),to_date('22/11/20','RR/MM/DD'),'RNAME019','C025','0');
Insert into RESERVATION_T (VNO,VTYPE,VPRICE,VNUM,VSTART,VEND,R_NO,C_NO,VVACANT) values ('R020','�Ｚ����','129000','2',to_date('22/11/19','RR/MM/DD'),to_date('22/11/20','RR/MM/DD'),'RNAME020','C026','1');
Insert into RESERVATION_T (VNO,VTYPE,VPRICE,VNUM,VSTART,VEND,R_NO,C_NO,VVACANT) values ('R021','����','270000','2',to_date('22/11/19','RR/MM/DD'),to_date('22/11/20','RR/MM/DD'),'RNAME021','C027','0');
Insert into RESERVATION_T (VNO,VTYPE,VPRICE,VNUM,VSTART,VEND,R_NO,C_NO,VVACANT) values ('R022','ī��','182000','2',to_date('22/11/19','RR/MM/DD'),to_date('22/11/20','RR/MM/DD'),'RNAME022','C028','0');
Insert into RESERVATION_T (VNO,VTYPE,VPRICE,VNUM,VSTART,VEND,R_NO,C_NO,VVACANT) values ('R023','īī������','70000','2',to_date('22/11/19','RR/MM/DD'),to_date('22/11/20','RR/MM/DD'),'RNAME023','C029','1');
Insert into RESERVATION_T (VNO,VTYPE,VPRICE,VNUM,VSTART,VEND,R_NO,C_NO,VVACANT) values ('R024','�Ｚ����','103000','2',to_date('22/11/19','RR/MM/DD'),to_date('22/11/20','RR/MM/DD'),'RNAME024','C030','0');
Insert into RESERVATION_T (VNO,VTYPE,VPRICE,VNUM,VSTART,VEND,R_NO,C_NO,VVACANT) values ('R025','����','147000','2',to_date('22/11/19','RR/MM/DD'),to_date('22/11/20','RR/MM/DD'),'RNAME025','C031','1');
Insert into RESERVATION_T (VNO,VTYPE,VPRICE,VNUM,VSTART,VEND,R_NO,C_NO,VVACANT) values ('R026','ī��','46000','2',to_date('22/11/19','RR/MM/DD'),to_date('22/11/20','RR/MM/DD'),'RNAME026','C032','1');
Insert into RESERVATION_T (VNO,VTYPE,VPRICE,VNUM,VSTART,VEND,R_NO,C_NO,VVACANT) values ('R027','īī������','37000','2',to_date('22/11/19','RR/MM/DD'),to_date('22/11/20','RR/MM/DD'),'RNAME027','C033','1');
Insert into RESERVATION_T (VNO,VTYPE,VPRICE,VNUM,VSTART,VEND,R_NO,C_NO,VVACANT) values ('R028','�Ｚ����','108000','2',to_date('22/11/19','RR/MM/DD'),to_date('22/11/20','RR/MM/DD'),'RNAME028','C034','1');
Insert into RESERVATION_T (VNO,VTYPE,VPRICE,VNUM,VSTART,VEND,R_NO,C_NO,VVACANT) values ('R029','����','119000','2',to_date('22/11/19','RR/MM/DD'),to_date('22/11/20','RR/MM/DD'),'RNAME029','C035','1');
Insert into RESERVATION_T (VNO,VTYPE,VPRICE,VNUM,VSTART,VEND,R_NO,C_NO,VVACANT) values ('R030','ī��','69000','2',to_date('22/11/19','RR/MM/DD'),to_date('22/11/20','RR/MM/DD'),'RNAME030','C036','0');
Insert into RESERVATION_T (VNO,VTYPE,VPRICE,VNUM,VSTART,VEND,R_NO,C_NO,VVACANT) values ('R031','īī������','87000','1',to_date('22/11/19','RR/MM/DD'),to_date('22/11/20','RR/MM/DD'),'RNAME031','C037','0');
Insert into RESERVATION_T (VNO,VTYPE,VPRICE,VNUM,VSTART,VEND,R_NO,C_NO,VVACANT) values ('R032','�Ｚ����','105000','2',to_date('22/11/19','RR/MM/DD'),to_date('22/11/20','RR/MM/DD'),'RNAME032','C038','1');
Insert into RESERVATION_T (VNO,VTYPE,VPRICE,VNUM,VSTART,VEND,R_NO,C_NO,VVACANT) values ('R033','����','185000','2',to_date('22/11/19','RR/MM/DD'),to_date('22/11/20','RR/MM/DD'),'RNAME033','C039','1');
Insert into RESERVATION_T (VNO,VTYPE,VPRICE,VNUM,VSTART,VEND,R_NO,C_NO,VVACANT) values ('R034','ī��','127000','2',to_date('22/11/19','RR/MM/DD'),to_date('22/11/20','RR/MM/DD'),'RNAME034','C040','0');
Insert into RESERVATION_T (VNO,VTYPE,VPRICE,VNUM,VSTART,VEND,R_NO,C_NO,VVACANT) values ('R035','īī������','26000','2',to_date('22/11/19','RR/MM/DD'),to_date('22/11/20','RR/MM/DD'),'RNAME035','C041','0');
Insert into RESERVATION_T (VNO,VTYPE,VPRICE,VNUM,VSTART,VEND,R_NO,C_NO,VVACANT) values ('R036','�Ｚ����','154000','2',to_date('22/11/20','RR/MM/DD'),to_date('22/11/21','RR/MM/DD'),'RNAME036','C042','1');
Insert into RESERVATION_T (VNO,VTYPE,VPRICE,VNUM,VSTART,VEND,R_NO,C_NO,VVACANT) values ('R037','����','172000','2',to_date('22/11/20','RR/MM/DD'),to_date('22/11/21','RR/MM/DD'),'RNAME037','C043','0');
Insert into RESERVATION_T (VNO,VTYPE,VPRICE,VNUM,VSTART,VEND,R_NO,C_NO,VVACANT) values ('R038','ī��','110000','2',to_date('22/11/20','RR/MM/DD'),to_date('22/11/21','RR/MM/DD'),'RNAME038','C044','0');
Insert into RESERVATION_T (VNO,VTYPE,VPRICE,VNUM,VSTART,VEND,R_NO,C_NO,VVACANT) values ('R039','īī������','120000','1',to_date('22/11/20','RR/MM/DD'),to_date('22/11/21','RR/MM/DD'),'RNAME039','C045','1');
Insert into RESERVATION_T (VNO,VTYPE,VPRICE,VNUM,VSTART,VEND,R_NO,C_NO,VVACANT) values ('R040','�Ｚ����','73000','1',to_date('22/11/20','RR/MM/DD'),to_date('22/11/21','RR/MM/DD'),'RNAME040','C045','1');
Insert into RESERVATION_T (VNO,VTYPE,VPRICE,VNUM,VSTART,VEND,R_NO,C_NO,VVACANT) values ('R041','����','177000','3',to_date('22/11/20','RR/MM/DD'),to_date('22/11/21','RR/MM/DD'),'RNAME041','C046','1');
Insert into RESERVATION_T (VNO,VTYPE,VPRICE,VNUM,VSTART,VEND,R_NO,C_NO,VVACANT) values ('R042','����','110000','2',to_date('22/11/20','RR/MM/DD'),to_date('22/11/21','RR/MM/DD'),'RNAME042','C046','0');
Insert into RESERVATION_T (VNO,VTYPE,VPRICE,VNUM,VSTART,VEND,R_NO,C_NO,VVACANT) values ('R043','īī������','184000','3',to_date('22/11/20','RR/MM/DD'),to_date('22/11/21','RR/MM/DD'),'RNAME043','C047','0');
Insert into RESERVATION_T (VNO,VTYPE,VPRICE,VNUM,VSTART,VEND,R_NO,C_NO,VVACANT) values ('R044','īī������','73000','1',to_date('22/11/20','RR/MM/DD'),to_date('22/11/21','RR/MM/DD'),'RNAME044','C047','0');
Insert into RESERVATION_T (VNO,VTYPE,VPRICE,VNUM,VSTART,VEND,R_NO,C_NO,VVACANT) values ('R045','����','178000','2',to_date('22/11/20','RR/MM/DD'),to_date('22/11/21','RR/MM/DD'),'RNAME045','C048','0');
Insert into RESERVATION_T (VNO,VTYPE,VPRICE,VNUM,VSTART,VEND,R_NO,C_NO,VVACANT) values ('R046','����','95000','2',to_date('22/11/20','RR/MM/DD'),to_date('22/11/21','RR/MM/DD'),'RNAME046','C048','0');
Insert into RESERVATION_T (VNO,VTYPE,VPRICE,VNUM,VSTART,VEND,R_NO,C_NO,VVACANT) values ('R047','�Ｚ����','141000','1',to_date('22/11/20','RR/MM/DD'),to_date('22/11/21','RR/MM/DD'),'RNAME047','C049','0');
Insert into RESERVATION_T (VNO,VTYPE,VPRICE,VNUM,VSTART,VEND,R_NO,C_NO,VVACANT) values ('R048','�Ｚ����','173000','3',to_date('22/11/20','RR/MM/DD'),to_date('22/11/21','RR/MM/DD'),'RNAME048','C049','0');
Insert into RESERVATION_T (VNO,VTYPE,VPRICE,VNUM,VSTART,VEND,R_NO,C_NO,VVACANT) values ('R049','ī��','121000','2',to_date('22/11/20','RR/MM/DD'),to_date('22/11/21','RR/MM/DD'),'RNAME049','C050','0');
Insert into RESERVATION_T (VNO,VTYPE,VPRICE,VNUM,VSTART,VEND,R_NO,C_NO,VVACANT) values ('R050','ī��','142000','2',to_date('22/11/20','RR/MM/DD'),to_date('22/11/21','RR/MM/DD'),'RNAME050','C050','1');
Insert into RESERVATION_T (VNO,VTYPE,VPRICE,VNUM,VSTART,VEND,R_NO,C_NO,VVACANT) values ('R001','����','157000','2',to_date('22/11/17','RR/MM/DD'),to_date('22/11/18','RR/MM/DD'),'RNAME001','C007','0');

