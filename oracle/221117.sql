-- 테이블 순서는 관계를 고려하여 한 번에 실행해도 에러가 발생하지 않게 정렬되었습니다.
-- 테이블 삭제
--SELECT 'DROP TABLE "' || TABLE_NAME || '" CASCADE CONSTRAINTS;' FROM user_tables;

-- 테이블 순서는 관계를 고려하여 한 번에 실행해도 에러가 발생하지 않게 정렬되었습니다.
-- 테이블 삭제
drop table reservation_t;
drop table customer_t;
drop table room_t;
drop table business_t;
drop table owner_t;
drop table firm_t;

-- firm_t Table Create SQL 회사테이블
CREATE TABLE firm_t
(
    fname       VARCHAR2(20)    NOT NULL, 
    femail     VARCHAR2(20)    NOT NULL, 
    ftel      VARCHAR2(20)    NOT NULL, 
    faddr       VARCHAR2(50)    NOT NULL, 
     PRIMARY KEY (fname)
)
/

COMMENT ON TABLE firm_t IS '회사테이블'
/

COMMENT ON COLUMN firm_t.fname IS '회사이름'
/

COMMENT ON COLUMN firm_t.femail IS '이메일'
/

COMMENT ON COLUMN firm_t.ftel IS '전화번호'
/

COMMENT ON COLUMN firm_t.faddr IS '위치'
/


-- owner_t Table Create SQL 업주테이블
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

COMMENT ON TABLE owner_t IS '업주테이블'
/

COMMENT ON COLUMN owner_t.ono IS '업주번호'
/

COMMENT ON COLUMN owner_t.oname IS '이름'
/

COMMENT ON COLUMN owner_t.onum IS '사업자번호'
/

COMMENT ON COLUMN owner_t.oid IS '업주ID'
/

COMMENT ON COLUMN owner_t.opw IS '업주PW'
/

COMMENT ON COLUMN owner_t.oemail IS '이메일'
/

COMMENT ON COLUMN owner_t.otel IS '핸드폰번호'
/

COMMENT ON COLUMN owner_t.f_name IS '회사이름'
/

ALTER TABLE owner_t
    ADD CONSTRAINT FK_owner_t_f_name_firm_t_fname FOREIGN KEY (f_name)
        REFERENCES firm_t (fname)
/

-- business_t Table Create SQL  업소테이블
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

COMMENT ON TABLE business_t IS '업소테이블'
/

COMMENT ON COLUMN business_t.bno IS '일련번호'
/

COMMENT ON COLUMN business_t.baddr IS '주소'
/

COMMENT ON COLUMN business_t.bname IS '사업장명'
/

COMMENT ON COLUMN business_t.btype IS '타입'
/

COMMENT ON COLUMN business_t.o_no IS '업주번호'
/

ALTER TABLE business_t
    ADD CONSTRAINT FK_business_t_o_no_owner_t_ono FOREIGN KEY (o_no)
        REFERENCES owner_t (ono)
/


-- room_t Table Create SQL 방테이블
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

COMMENT ON TABLE room_t IS '방테이블'
/

COMMENT ON COLUMN room_t.rname IS '방이름'
/

COMMENT ON COLUMN room_t.rprice IS '가격'
/

COMMENT ON COLUMN room_t.rtype IS '타입'
/

COMMENT ON COLUMN room_t.rnum IS '개수'
/

COMMENT ON COLUMN room_t.b_no IS '업소일련번호'
/

ALTER TABLE room_t
    ADD CONSTRAINT FK_room_t_b_no_business_t_bno FOREIGN KEY (b_no)
        REFERENCES business_t (bno)
/


-- customer_t Table Create SQL 고객테이블
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

COMMENT ON TABLE customer_t IS '고객테이블'
/

COMMENT ON COLUMN customer_t.cno IS '고객번호'
/

COMMENT ON COLUMN customer_t.cname IS '이름'
/

COMMENT ON COLUMN customer_t.cid IS '고객ID'
/

COMMENT ON COLUMN customer_t.cpw IS '고객PW'
/

COMMENT ON COLUMN customer_t.cemail IS '이메일'
/

COMMENT ON COLUMN customer_t.ctel IS '핸드폰번호'
/

COMMENT ON COLUMN customer_t.f_name IS '회사이름'
/

ALTER TABLE customer_t
    ADD CONSTRAINT FK_customer_t_f_name_firm_t_fname FOREIGN KEY (f_name)
        REFERENCES firm_t (fname)
/


-- reservation_t Table Create SQL 예약테이블
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

COMMENT ON TABLE reservation_t IS '예약테이블'
/

COMMENT ON COLUMN reservation_t.vno IS '예약번호'
/

COMMENT ON COLUMN reservation_t.vtype IS '결제방식'
/

COMMENT ON COLUMN reservation_t.vprice IS '금액'
/

COMMENT ON COLUMN reservation_t.vnum IS '인원수'
/

COMMENT ON COLUMN reservation_t.vstart IS '숙박시작일'
/

COMMENT ON COLUMN reservation_t.vend IS '숙박종료일'
/

COMMENT ON COLUMN reservation_t.vvacant IS '빈방컬럼'
/

COMMENT ON COLUMN reservation_t.r_no IS '예약한방번호'
/

COMMENT ON COLUMN reservation_t.c_no IS '예약한고객번호'
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
-- FIRM_T 데이터 추가
Insert into FIRM_T (FNAME,FEMAIL,FTEL,FADDR) values ('F001','F001@google.com','0531111111','대구광역시 동구');

-- OWNER_T 데이터 추가
Insert into OWNER_T (ONO,ONAME,ONUM,OID,OPW,OEMAIL,OTEL,F_NAME) values ('O001','김도시','O0001','O101','0000','O001@google.com','053 5716030','F001');
Insert into OWNER_T (ONO,ONAME,ONUM,OID,OPW,OEMAIL,OTEL,F_NAME) values ('O002','김한성','O0002','O102','0000','O002@google.com','053 5542696','F001');
Insert into OWNER_T (ONO,ONAME,ONUM,OID,OPW,OEMAIL,OTEL,F_NAME) values ('O003','김신흥','O0003','O103','0000','O003@google.com','053 4231200','F001');
Insert into OWNER_T (ONO,ONAME,ONUM,OID,OPW,OEMAIL,OTEL,F_NAME) values ('O004','김엠티','O0004','O104','0000','O004@google.com','053 5542169','F001');
Insert into OWNER_T (ONO,ONAME,ONUM,OID,OPW,OEMAIL,OTEL,F_NAME) values ('O005','김수복','O0005','O105','0000','O005@google.com','053 2573686','F001');
Insert into OWNER_T (ONO,ONAME,ONUM,OID,OPW,OEMAIL,OTEL,F_NAME) values ('O006','김라온','O0006','O106','0000','O006@google.com','053 2522286','F001');
Insert into OWNER_T (ONO,ONAME,ONUM,OID,OPW,OEMAIL,OTEL,F_NAME) values ('O007','김민속','O0007','O107','0000','O007@google.com','053 4230031','F001');
Insert into OWNER_T (ONO,ONAME,ONUM,OID,OPW,OEMAIL,OTEL,F_NAME) values ('O008','김삼익','O0008','O108','0000','O008@google.com','053 2523750','F001');
Insert into OWNER_T (ONO,ONAME,ONUM,OID,OPW,OEMAIL,OTEL,F_NAME) values ('O009','김야자','O0009','O109','0000','O009@google.com','053 4228902','F001');
Insert into OWNER_T (ONO,ONAME,ONUM,OID,OPW,OEMAIL,OTEL,F_NAME) values ('O010','김호원','O0010','O110','0000','O010@google.com','053 2550059','F001');
Insert into OWNER_T (ONO,ONAME,ONUM,OID,OPW,OEMAIL,OTEL,F_NAME) values ('O011','김명신','O0011','O111','0000','O011@google.com','053 424 0025','F001');
Insert into OWNER_T (ONO,ONAME,ONUM,OID,OPW,OEMAIL,OTEL,F_NAME) values ('O012','김넘버','O0012','O112','0000','O012@google.com','053 2571116','F001');
Insert into OWNER_T (ONO,ONAME,ONUM,OID,OPW,OEMAIL,OTEL,F_NAME) values ('O013','김지프','O0013','O113','0000','O013@google.com','053 4225454','F001');
Insert into OWNER_T (ONO,ONAME,ONUM,OID,OPW,OEMAIL,OTEL,F_NAME) values ('O014','김아트','O0014','O114','0000','O014@google.com','053 424 3224','F001');
Insert into OWNER_T (ONO,ONAME,ONUM,OID,OPW,OEMAIL,OTEL,F_NAME) values ('O015','김타임','O0015','O115','0000','O015@google.com','053 5617800','F001');
Insert into OWNER_T (ONO,ONAME,ONUM,OID,OPW,OEMAIL,OTEL,F_NAME) values ('O016','김공감','O0016','O116','0000','O016@google.com','053 5887533','F001');
Insert into OWNER_T (ONO,ONAME,ONUM,OID,OPW,OEMAIL,OTEL,F_NAME) values ('O017','김뷰','O0017','O117','0000','O017@google.com','053 5542557','F001');
Insert into OWNER_T (ONO,ONAME,ONUM,OID,OPW,OEMAIL,OTEL,F_NAME) values ('O018','김궁전','O0018','O118','0000','O018@google.com','053 2566789','F001');
Insert into OWNER_T (ONO,ONAME,ONUM,OID,OPW,OEMAIL,OTEL,F_NAME) values ('O019','김이','O0019','O119','0000','O019@google.com','053 2538900','F001');
Insert into OWNER_T (ONO,ONAME,ONUM,OID,OPW,OEMAIL,OTEL,F_NAME) values ('O020','김온도','O0020','O120','0000','O020@google.com','053 4287701','F001');
Insert into OWNER_T (ONO,ONAME,ONUM,OID,OPW,OEMAIL,OTEL,F_NAME) values ('O021','김멜로','O0021','O121','0000','O021@google.com','053 9585559','F001');
Insert into OWNER_T (ONO,ONAME,ONUM,OID,OPW,OEMAIL,OTEL,F_NAME) values ('O022','김우남','O0022','O122','0000','O022@google.com','053 421 6661','F001');
Insert into OWNER_T (ONO,ONAME,ONUM,OID,OPW,OEMAIL,OTEL,F_NAME) values ('O023','김교동','O0023','O123','0000','O023@google.com','053 564 2727','F001');
Insert into OWNER_T (ONO,ONAME,ONUM,OID,OPW,OEMAIL,OTEL,F_NAME) values ('O024','김나나','O0024','O124','0000','O024@google.com','053 6563822','F001');
Insert into OWNER_T (ONO,ONAME,ONUM,OID,OPW,OEMAIL,OTEL,F_NAME) values ('O025','김동진','O0025','O125','0000','O025@google.com','053 5933399','F001');
Insert into OWNER_T (ONO,ONAME,ONUM,OID,OPW,OEMAIL,OTEL,F_NAME) values ('O026','김터치','O0026','O126','0000','O026@google.com','053 5935757','F001');
Insert into OWNER_T (ONO,ONAME,ONUM,OID,OPW,OEMAIL,OTEL,F_NAME) values ('O027','김뷰모','O0027','O127','0000','O027@google.com','053582 3319','F001');
Insert into OWNER_T (ONO,ONAME,ONUM,OID,OPW,OEMAIL,OTEL,F_NAME) values ('O028','김탑','O0028','O128','0000','O028@google.com','053 5935133','F001');
Insert into OWNER_T (ONO,ONAME,ONUM,OID,OPW,OEMAIL,OTEL,F_NAME) values ('O029','김엠','O0029','O129','0000','O029@google.com','053 2563127','F001');
Insert into OWNER_T (ONO,ONAME,ONUM,OID,OPW,OEMAIL,OTEL,F_NAME) values ('O030','김봄고','O0030','O130','0000','O030@google.com','053 2554900','F001');
Insert into OWNER_T (ONO,ONAME,ONUM,OID,OPW,OEMAIL,OTEL,F_NAME) values ('O031','김프라','O0031','O131','0000','O031@google.com','053 2538021','F001');
Insert into OWNER_T (ONO,ONAME,ONUM,OID,OPW,OEMAIL,OTEL,F_NAME) values ('O032','김사보','O0032','O132','0000','O032@google.com','053 2573182','F001');
Insert into OWNER_T (ONO,ONAME,ONUM,OID,OPW,OEMAIL,OTEL,F_NAME) values ('O033','김사보이','O0033','O133','0000','O033@google.com','053 6151331','F001');
Insert into OWNER_T (ONO,ONAME,ONUM,OID,OPW,OEMAIL,OTEL,F_NAME) values ('O034','김대구','O0034','O134','0000','O034@google.com','053 6331089','F001');
Insert into OWNER_T (ONO,ONAME,ONUM,OID,OPW,OEMAIL,OTEL,F_NAME) values ('O035','김지프','O0035','O135','0000','O035@google.com','053 6335811','F001');
Insert into OWNER_T (ONO,ONAME,ONUM,OID,OPW,OEMAIL,OTEL,F_NAME) values ('O036','김유성','O0036','O136','0000','O036@google.com','053 6143641','F001');
Insert into OWNER_T (ONO,ONAME,ONUM,OID,OPW,OEMAIL,OTEL,F_NAME) values ('O037','김젠','O0037','O137','0000','O037@google.com','053616 6111','F001');
Insert into OWNER_T (ONO,ONAME,ONUM,OID,OPW,OEMAIL,OTEL,F_NAME) values ('O038','김오데','O0038','O138','0000','O038@google.com','053 7679822','F001');
Insert into OWNER_T (ONO,ONAME,ONUM,OID,OPW,OEMAIL,OTEL,F_NAME) values ('O039','김V','O0039','O139','0000','O039@google.com','053 981 3777','F001');
Insert into OWNER_T (ONO,ONAME,ONUM,OID,OPW,OEMAIL,OTEL,F_NAME) values ('O040','김하늘','O0040','O140','0000','O040@google.com','053 9859925','F001');
Insert into OWNER_T (ONO,ONAME,ONUM,OID,OPW,OEMAIL,OTEL,F_NAME) values ('O041','김골든','O0041','O141','0000','O041@google.com','053 9566933','F001');
Insert into OWNER_T (ONO,ONAME,ONUM,OID,OPW,OEMAIL,OTEL,F_NAME) values ('O042','김야','O0042','O142','0000','O042@google.com','053 588 7219','F001');
Insert into OWNER_T (ONO,ONAME,ONUM,OID,OPW,OEMAIL,OTEL,F_NAME) values ('O043','김프렌','O0043','O143','0000','O043@google.com','053 6211985','F001');
Insert into OWNER_T (ONO,ONAME,ONUM,OID,OPW,OEMAIL,OTEL,F_NAME) values ('O044','김시즌','O0044','O144','0000','O044@google.com','053 5885990','F001');
Insert into OWNER_T (ONO,ONAME,ONUM,OID,OPW,OEMAIL,OTEL,F_NAME) values ('O045','김폭스','O0045','O145','0000','O045@google.com','053 522 3991','F001');
Insert into OWNER_T (ONO,ONAME,ONUM,OID,OPW,OEMAIL,OTEL,F_NAME) values ('O046','김필','O0046','O146','0000','O046@google.com','053585 6922','F001');
Insert into OWNER_T (ONO,ONAME,ONUM,OID,OPW,OEMAIL,OTEL,F_NAME) values ('O047','김도트','O0047','O147','0000','O047@google.com','053 6258866','F001');
Insert into OWNER_T (ONO,ONAME,ONUM,OID,OPW,OEMAIL,OTEL,F_NAME) values ('O048','김오월','O0048','O148','0000','O048@google.com','053 5852323','F001');
Insert into OWNER_T (ONO,ONAME,ONUM,OID,OPW,OEMAIL,OTEL,F_NAME) values ('O049','김진천','O0049','O149','0000','O049@google.com','053 5937898','F001');
Insert into OWNER_T (ONO,ONAME,ONUM,OID,OPW,OEMAIL,OTEL,F_NAME) values ('O050','김온','O0050','O150','0000','O050@google.com','053 6281133','F001');

-- CUSTOMER_T 데이터 추가
Insert into CUSTOMER_T (CNO,CNAME,CID,CPW,CEMAIL,CTEL,F_NAME) values ('C001','김희서','kim1','@l$eea12#awdwm','kim1@naver.com','010-0000-0001','F001');
Insert into CUSTOMER_T (CNO,CNAME,CID,CPW,CEMAIL,CTEL,F_NAME) values ('C002','이희종','kim2','@l$eea12#a@21!$','kim2@hanmail.net','010-0000-0002','F001');
Insert into CUSTOMER_T (CNO,CNAME,CID,CPW,CEMAIL,CTEL,F_NAME) values ('C003','이희원','kim3','kim@a12#a!!#$','kim3@yahoo.com','010-0000-0003','F001');
Insert into CUSTOMER_T (CNO,CNAME,CID,CPW,CEMAIL,CTEL,F_NAME) values ('C004','박동훈','kim4','c$!hoi@!iasdft','kim4@hanmail.net','010-0000-0004','F001');
Insert into CUSTOMER_T (CNO,CNAME,CID,CPW,CEMAIL,CTEL,F_NAME) values ('C005','최희은','kim5','c$!hoi@!iasdft','kim5@naver.com','010-0000-0005','F001');
Insert into CUSTOMER_T (CNO,CNAME,CID,CPW,CEMAIL,CTEL,F_NAME) values ('C006','최성훈','kim6','p!@a#rkt2!t@21!$','kim6@hanmail.net','010-0000-0006','F001');
Insert into CUSTOMER_T (CNO,CNAME,CID,CPW,CEMAIL,CTEL,F_NAME) values ('C007','김영서','kim7','kim@i@!iwdwm','kim7@naver.com','010-0000-0007','F001');
Insert into CUSTOMER_T (CNO,CNAME,CID,CPW,CEMAIL,CTEL,F_NAME) values ('C008','김희서','kim8','p!@a#rka12#aasdft','kim8@gmail.com','010-0000-0008','F001');
Insert into CUSTOMER_T (CNO,CNAME,CID,CPW,CEMAIL,CTEL,F_NAME) values ('C009','박정범','kim9','kim@1ss2wdwm','kim9@gmail.com','010-0000-0009','F001');
Insert into CUSTOMER_T (CNO,CNAME,CID,CPW,CEMAIL,CTEL,F_NAME) values ('C010','최정서','kim10','@l$ee\@#oasdft','kim10@gmail.com','010-0000-0010','F001');
Insert into CUSTOMER_T (CNO,CNAME,CID,CPW,CEMAIL,CTEL,F_NAME) values ('C011','최동은','kim11','@l$eea12#a@21!$','kim11@hanmail.net','010-0000-0011','F001');
Insert into CUSTOMER_T (CNO,CNAME,CID,CPW,CEMAIL,CTEL,F_NAME) values ('C012','박성원','kim12','@l$ee\@#oasdft','kim12@hanmail.net','010-0000-0012','F001');
Insert into CUSTOMER_T (CNO,CNAME,CID,CPW,CEMAIL,CTEL,F_NAME) values ('C013','김영범','kim13','p!@a#rkt2!tasdft','kim13@yahoo.com','010-0000-0013','F001');
Insert into CUSTOMER_T (CNO,CNAME,CID,CPW,CEMAIL,CTEL,F_NAME) values ('C014','김영범','kim14','kim@i@!i!!#$','kim14@hanmail.net','010-0000-0014','F001');
Insert into CUSTOMER_T (CNO,CNAME,CID,CPW,CEMAIL,CTEL,F_NAME) values ('C015','최영종','kim15','kim@1ss2wdwm','kim15@hanmail.net','010-0000-0015','F001');
Insert into CUSTOMER_T (CNO,CNAME,CID,CPW,CEMAIL,CTEL,F_NAME) values ('C016','김동종','kim16','@l$ee1ss2asdft','kim16@yahoo.com','010-0000-0016','F001');
Insert into CUSTOMER_T (CNO,CNAME,CID,CPW,CEMAIL,CTEL,F_NAME) values ('C017','이동혜','kim17','c$!hoa12#awdwm','kim17@hanmail.net','010-0000-0017','F001');
Insert into CUSTOMER_T (CNO,CNAME,CID,CPW,CEMAIL,CTEL,F_NAME) values ('C018','박동은','kim18','p!@a#rki@!i!!#$','kim18@hanmail.net','010-0000-0018','F001');
Insert into CUSTOMER_T (CNO,CNAME,CID,CPW,CEMAIL,CTEL,F_NAME) values ('C019','박동혜','kim19','c$!ho1ss2asdft','kim19@hanmail.net','010-0000-0019','F001');
Insert into CUSTOMER_T (CNO,CNAME,CID,CPW,CEMAIL,CTEL,F_NAME) values ('C020','김희훈','kim20','c$!ho\@#owdwm','kim20@hanmail.net','010-0000-0020','F001');
Insert into CUSTOMER_T (CNO,CNAME,CID,CPW,CEMAIL,CTEL,F_NAME) values ('C021','이정서','kim21','@l$eet2!t!!#$','kim21@hanmail.net','010-0000-0021','F001');
Insert into CUSTOMER_T (CNO,CNAME,CID,CPW,CEMAIL,CTEL,F_NAME) values ('C022','박영종','kim22','@l$ee\@#o@21!$','kim22@gmail.com','010-0000-0022','F001');
Insert into CUSTOMER_T (CNO,CNAME,CID,CPW,CEMAIL,CTEL,F_NAME) values ('C023','최동서','kim23','kim@\@#owdwm','kim23@naver.com','010-0000-0023','F001');
Insert into CUSTOMER_T (CNO,CNAME,CID,CPW,CEMAIL,CTEL,F_NAME) values ('C024','이영은','kim24','@l$eea12#awdwm','kim24@yahoo.com','010-0000-0024','F001');
Insert into CUSTOMER_T (CNO,CNAME,CID,CPW,CEMAIL,CTEL,F_NAME) values ('C025','박성종','kim25','c$!ho1ss2wdwm','kim25@yahoo.com','010-0000-0025','F001');
Insert into CUSTOMER_T (CNO,CNAME,CID,CPW,CEMAIL,CTEL,F_NAME) values ('C026','이희은','kim26','kim@1ss2@21!$','kim26@naver.com','010-0000-0026','F001');
Insert into CUSTOMER_T (CNO,CNAME,CID,CPW,CEMAIL,CTEL,F_NAME) values ('C027','최성종','kim27','p!@a#rk1ss2@21!$','kim27@gmail.com','010-0000-0027','F001');
Insert into CUSTOMER_T (CNO,CNAME,CID,CPW,CEMAIL,CTEL,F_NAME) values ('C028','박영은','kim28','@l$ee1ss2asdft','kim28@hanmail.net','010-0000-0028','F001');
Insert into CUSTOMER_T (CNO,CNAME,CID,CPW,CEMAIL,CTEL,F_NAME) values ('C029','최영원','kim29','c$!hoa12#awdwm','kim29@hanmail.net','010-0000-0029','F001');
Insert into CUSTOMER_T (CNO,CNAME,CID,CPW,CEMAIL,CTEL,F_NAME) values ('C030','이영혜','kim30','c$!ho\@#o@21!$','kim30@hanmail.net','010-0000-0030','F001');
Insert into CUSTOMER_T (CNO,CNAME,CID,CPW,CEMAIL,CTEL,F_NAME) values ('C031','이희서','kim31','kim@i@!iwdwm','kim31@naver.com','010-0000-0031','F001');
Insert into CUSTOMER_T (CNO,CNAME,CID,CPW,CEMAIL,CTEL,F_NAME) values ('C032','이동원','kim32','c$!ho\@#o@21!$','kim32@yahoo.com','010-0000-0032','F001');
Insert into CUSTOMER_T (CNO,CNAME,CID,CPW,CEMAIL,CTEL,F_NAME) values ('C033','최정혜','kim33','@l$ee\@#oasdft','kim33@gmail.com','010-0000-0033','F001');
Insert into CUSTOMER_T (CNO,CNAME,CID,CPW,CEMAIL,CTEL,F_NAME) values ('C034','박성혜','kim34','p!@a#rk\@#oasdft','kim34@naver.com','010-0000-0034','F001');
Insert into CUSTOMER_T (CNO,CNAME,CID,CPW,CEMAIL,CTEL,F_NAME) values ('C035','김영훈','kim35','p!@a#rk\@#o!!#$','kim35@gmail.com','010-0000-0035','F001');
Insert into CUSTOMER_T (CNO,CNAME,CID,CPW,CEMAIL,CTEL,F_NAME) values ('C036','최정혜','kim36','p!@a#rk\@#owdwm','kim36@gmail.com','010-0000-0036','F001');
Insert into CUSTOMER_T (CNO,CNAME,CID,CPW,CEMAIL,CTEL,F_NAME) values ('C037','최성서','kim37','p!@a#rk\@#o!!#$','kim37@gmail.com','010-0000-0037','F001');
Insert into CUSTOMER_T (CNO,CNAME,CID,CPW,CEMAIL,CTEL,F_NAME) values ('C038','박정종','kim38','c$!hoi@!i!!#$','kim38@naver.com','010-0000-0038','F001');
Insert into CUSTOMER_T (CNO,CNAME,CID,CPW,CEMAIL,CTEL,F_NAME) values ('C039','최성범','kim39','c$!ho1ss2!!#$','kim39@gmail.com','010-0000-0039','F001');
Insert into CUSTOMER_T (CNO,CNAME,CID,CPW,CEMAIL,CTEL,F_NAME) values ('C040','박성서','kim40','kim@i@!iwdwm','kim40@hanmail.net','010-0000-0040','F001');
Insert into CUSTOMER_T (CNO,CNAME,CID,CPW,CEMAIL,CTEL,F_NAME) values ('C041','최정범','kim41','@l$eei@!iwdwm','kim41@hanmail.net','010-0000-0041','F001');
Insert into CUSTOMER_T (CNO,CNAME,CID,CPW,CEMAIL,CTEL,F_NAME) values ('C042','최동훈','kim42','kim@t2!t!!#$','kim42@naver.com','010-0000-0042','F001');
Insert into CUSTOMER_T (CNO,CNAME,CID,CPW,CEMAIL,CTEL,F_NAME) values ('C043','김동혜','kim43','@l$ee1ss2!!#$','kim43@gmail.com','010-0000-0043','F001');
Insert into CUSTOMER_T (CNO,CNAME,CID,CPW,CEMAIL,CTEL,F_NAME) values ('C044','이영훈','kim44','@l$eet2!t@21!$','kim44@naver.com','010-0000-0044','F001');
Insert into CUSTOMER_T (CNO,CNAME,CID,CPW,CEMAIL,CTEL,F_NAME) values ('C045','최영훈','kim45','c$!hoi@!iwdwm','kim45@yahoo.com','010-0000-0045','F001');
Insert into CUSTOMER_T (CNO,CNAME,CID,CPW,CEMAIL,CTEL,F_NAME) values ('C046','박정은','kim46','kim@a12#a@21!$','kim46@naver.com','010-0000-0046','F001');
Insert into CUSTOMER_T (CNO,CNAME,CID,CPW,CEMAIL,CTEL,F_NAME) values ('C047','이정범','kim47','@l$ee\@#o@21!$','kim47@yahoo.com','010-0000-0047','F001');
Insert into CUSTOMER_T (CNO,CNAME,CID,CPW,CEMAIL,CTEL,F_NAME) values ('C048','김희은','kim48','@l$ee\@#owdwm','kim48@hanmail.net','010-0000-0048','F001');
Insert into CUSTOMER_T (CNO,CNAME,CID,CPW,CEMAIL,CTEL,F_NAME) values ('C049','최성혜','kim49','c$!ho\@#o@21!$','kim49@naver.com','010-0000-0049','F001');
Insert into CUSTOMER_T (CNO,CNAME,CID,CPW,CEMAIL,CTEL,F_NAME) values ('C050','김정종','kim50','c$!hot2!t@21!$','kim50@naver.com','010-0000-0050','F001');

-- BUSINESS_T 데이터 추가
Insert into BUSINESS_T (BNO,BADDR,BNAME,BTYPE,O_NO) values ('B001','대구광역시 중구 동성로5길 94-17, 2,3,4층 (삼덕동1가)','백도시','여관업','O001');
Insert into BUSINESS_T (BNO,BADDR,BNAME,BTYPE,O_NO) values ('B002','대구광역시 중구 달성로21길 9-9 (달성동)','한성','여인숙업','O002');
Insert into BUSINESS_T (BNO,BADDR,BNAME,BTYPE,O_NO) values ('B003','대구광역시 중구 달성공원로6길 12 (대신동)','신흥','여관업','O002');
Insert into BUSINESS_T (BNO,BADDR,BNAME,BTYPE,O_NO) values ('B004','대구광역시 중구 종로 37 (종로2가)','엠티 라이프 모텔','여관업','O003');
Insert into BUSINESS_T (BNO,BADDR,BNAME,BTYPE,O_NO) values ('B005','대구광역시 중구 달성로21길 9-10 (달성동)','수복','여인숙업','O003');
Insert into BUSINESS_T (BNO,BADDR,BNAME,BTYPE,O_NO) values ('B006','대구광역시 중구 중앙대로65길 17 (남산동)','라온모텔','여관업','O003');
Insert into BUSINESS_T (BNO,BADDR,BNAME,BTYPE,O_NO) values ('B007','대구광역시 중구 종로 44-31 (종로1가)','아리랑 민속모텔','숙박업 기타','O004');
Insert into BUSINESS_T (BNO,BADDR,BNAME,BTYPE,O_NO) values ('B008','대구광역시 중구 명륜로26길 61 (대봉동)','삼익장','여관업','O005');
Insert into BUSINESS_T (BNO,BADDR,BNAME,BTYPE,O_NO) values ('B009','대구광역시 중구 국채보상로99길 38 (시장북로)','야자(YAJA)대구서문시장점','여관업','O005');
Insert into BUSINESS_T (BNO,BADDR,BNAME,BTYPE,O_NO) values ('B010','대구광역시 중구 교동2길 29-11 (교동)','호원장여관','여관업','O006');
Insert into BUSINESS_T (BNO,BADDR,BNAME,BTYPE,O_NO) values ('B011','대구광역시 중구 북성로 100-23 (북성로1가)','명신','여관업','O006');
Insert into BUSINESS_T (BNO,BADDR,BNAME,BTYPE,O_NO) values ('B012','대구광역시 중구 서성로 100 (수창동)','넘버25 동성로점','여관업','O007');
Insert into BUSINESS_T (BNO,BADDR,BNAME,BTYPE,O_NO) values ('B013','대구광역시 중구 서성로16길 84 (대안동)','지프모텔','여관업','O007');
Insert into BUSINESS_T (BNO,BADDR,BNAME,BTYPE,O_NO) values ('B014','대구광역시 중구 경상감영길 298-7 (동인동2가)','아트모텔','여관업','O007');
Insert into BUSINESS_T (BNO,BADDR,BNAME,BTYPE,O_NO) values ('B015','대구광역시 중구 국채보상로149길 10-9 (동인동4가)','타임모텔','여관업','O008');
Insert into BUSINESS_T (BNO,BADDR,BNAME,BTYPE,O_NO) values ('B016','대구광역시 중구 중앙대로79길 32 (종로2가, 지상3~5층)','공감게스트하우스','여관업','O008');
Insert into BUSINESS_T (BNO,BADDR,BNAME,BTYPE,O_NO) values ('B017','대구광역시 달서구 달서대로95길 18 (호산동)','뷰(view)모텔','여관업','O009');
Insert into BUSINESS_T (BNO,BADDR,BNAME,BTYPE,O_NO) values ('B018','대구광역시 중구 달성공원로4길 39-20 (시장북로)','궁전여관','여관업','O009');
Insert into BUSINESS_T (BNO,BADDR,BNAME,BTYPE,O_NO) values ('B019','대구광역시 중구 명덕로 71-5 (남산동)','e-모텔','여관업','O009');
Insert into BUSINESS_T (BNO,BADDR,BNAME,BTYPE,O_NO) values ('B020','대구광역시 중구 중앙대로81길 101 (남성로)','온도호텔','여관업','O010');
Insert into BUSINESS_T (BNO,BADDR,BNAME,BTYPE,O_NO) values ('B021','대구광역시 중구 공평로4길 31 (삼덕동2가)','멜로우호텔','일반호텔','O010');
Insert into BUSINESS_T (BNO,BADDR,BNAME,BTYPE,O_NO) values ('B022','대구광역시 중구 북성로 104-6 (향촌동)','우남','여관업','O011');
Insert into BUSINESS_T (BNO,BADDR,BNAME,BTYPE,O_NO) values ('B023','대구광역시 중구 중앙대로 446-2 (화전동, 지상2,3층)','교동게스트하우스','숙박업 기타','O012');
Insert into BUSINESS_T (BNO,BADDR,BNAME,BTYPE,O_NO) values ('B024','대구광역시 달서구 당산로 161 (감삼동)','나나','여관업','O012');
Insert into BUSINESS_T (BNO,BADDR,BNAME,BTYPE,O_NO) values ('B025','대구광역시 달서구 성당로21길 62 (성당동)','동진장여관','여관업','O013');
Insert into BUSINESS_T (BNO,BADDR,BNAME,BTYPE,O_NO) values ('B026','대구광역시 달서구 달서대로95길 23 (호산동)','터치(Touch)모텔','여관업','O014');
Insert into BUSINESS_T (BNO,BADDR,BNAME,BTYPE,O_NO) values ('B027','대구광역시 달서구 이곡서로 12 (이곡동)','뷰모텔','여관업','O015');
Insert into BUSINESS_T (BNO,BADDR,BNAME,BTYPE,O_NO) values ('B028','대구광역시 달서구 이곡동로 7, 5~8층 (이곡동)','탑호텔','일반호텔','O015');
Insert into BUSINESS_T (BNO,BADDR,BNAME,BTYPE,O_NO) values ('B029','대구광역시 달서구 성서공단로15길 14, 지하1~지상5층 (호림동)','엠플러스(M+)','여관업','O016');
Insert into BUSINESS_T (BNO,BADDR,BNAME,BTYPE,O_NO) values ('B030','대구광역시 중구 종로 23-23 (장관동, 지상1,2층)','봄고로','숙박업 기타','O016');
Insert into BUSINESS_T (BNO,BADDR,BNAME,BTYPE,O_NO) values ('B031','대구광역시 중구 경상감영길 300 (동인동2가)','프라자모텔','여관업','O017');
Insert into BUSINESS_T (BNO,BADDR,BNAME,BTYPE,O_NO) values ('B032','대구광역시 중구 종로 76 (대안동)','사보이 호텔','여관업','O017');
Insert into BUSINESS_T (BNO,BADDR,BNAME,BTYPE,O_NO) values ('B033','대구광역시 중구 서성로14길 68-1 (대안동)','사보이 호텔 별관','여관업','O017');
Insert into BUSINESS_T (BNO,BADDR,BNAME,BTYPE,O_NO) values ('B034','대구광역시 중구 중앙대로77길 47 (장관동, 지상1~6층)','대구미드타운호스텔','숙박업 기타','O017');
Insert into BUSINESS_T (BNO,BADDR,BNAME,BTYPE,O_NO) values ('B035','대구광역시 달성군 화원읍 비슬로 2701','지프(Jeep)','여관업','O018');
Insert into BUSINESS_T (BNO,BADDR,BNAME,BTYPE,O_NO) values ('B036','대구광역시 달성군 화원읍 비슬로512길 2','유성장여관','여관업','O018');
Insert into BUSINESS_T (BNO,BADDR,BNAME,BTYPE,O_NO) values ('B037','대구광역시 달성군 논공읍 비슬로 1768 ((토지합병으로1968-1->1963으로통합))','젠모텔','여관업','O019');
Insert into BUSINESS_T (BNO,BADDR,BNAME,BTYPE,O_NO) values ('B038','대구광역시 달성군 논공읍 남리길 10','오데오여관','여관업','O020');
Insert into BUSINESS_T (BNO,BADDR,BNAME,BTYPE,O_NO) values ('B039','대구광역시 달성군 가창면 우록길 93','V원모텔','여관업','O021');
Insert into BUSINESS_T (BNO,BADDR,BNAME,BTYPE,O_NO) values ('B040','대구광역시 동구 파계로138길 42 (중대동)','하늘이열리는스카이모텔','여관업','O021');
Insert into BUSINESS_T (BNO,BADDR,BNAME,BTYPE,O_NO) values ('B041','대구광역시 동구 팔공산로185길 43 (용수동)','모텔골든타임','여관업','O022');
Insert into BUSINESS_T (BNO,BADDR,BNAME,BTYPE,O_NO) values ('B042','대구광역시 동구 효동로 51-1 (효목동)','야(YA)모텔','여관업','O023');
Insert into BUSINESS_T (BNO,BADDR,BNAME,BTYPE,O_NO) values ('B043','대구광역시 달서구 달서대로91길 22, 1~5층 (호산동)','프렌치호텔','여관업','O023');
Insert into BUSINESS_T (BNO,BADDR,BNAME,BTYPE,O_NO) values ('B044','대구광역시 달서구 명덕로 13-4 (두류동)','시즌투(2)모텔','여관업','O023');
Insert into BUSINESS_T (BNO,BADDR,BNAME,BTYPE,O_NO) values ('B045','대구광역시 달서구 달서대로95길 40 (호산동)','폭스','일반호텔','O024');
Insert into BUSINESS_T (BNO,BADDR,BNAME,BTYPE,O_NO) values ('B046','대구광역시 달서구 월배로34길 6 (상인동)','필모텔','여관업','O024');
Insert into BUSINESS_T (BNO,BADDR,BNAME,BTYPE,O_NO) values ('B047','대구광역시 달서구 성서공단로11길 64-5, 지하1~지상6층 (호산동)','브라운도트호텔대구성서점','여관업','O025');
Insert into BUSINESS_T (BNO,BADDR,BNAME,BTYPE,O_NO) values ('B048','대구광역시 달서구 구마로11길 78 (본리동)','호텔오월(HOTEL5月)','여관업','O025');
Insert into BUSINESS_T (BNO,BADDR,BNAME,BTYPE,O_NO) values ('B049','대구광역시 달서구 진천로 68, 2~5층 (진천동)','진천모텔','여관업','O026');
Insert into BUSINESS_T (BNO,BADDR,BNAME,BTYPE,O_NO) values ('B050','대구광역시 달서구 대명천로 203 (본리동)','온호텔','여관업','O027');

-- ROOM_T 데이터 추가
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

-- RESERVATION_T 데이터 추가
Insert into RESERVATION_T (VNO,VTYPE,VPRICE,VNUM,VSTART,VEND,R_NO,C_NO,VVACANT) values ('R002','카드','163000','2',to_date('22/11/18','RR/MM/DD'),to_date('22/11/19','RR/MM/DD'),'RNAME002','C008','1');
Insert into RESERVATION_T (VNO,VTYPE,VPRICE,VNUM,VSTART,VEND,R_NO,C_NO,VVACANT) values ('R003','카카오페이','74000','2',to_date('22/11/18','RR/MM/DD'),to_date('22/11/19','RR/MM/DD'),'RNAME003','C009','0');
Insert into RESERVATION_T (VNO,VTYPE,VPRICE,VNUM,VSTART,VEND,R_NO,C_NO,VVACANT) values ('R004','삼성페이','114000','2',to_date('22/11/18','RR/MM/DD'),to_date('22/11/19','RR/MM/DD'),'RNAME004','C010','0');
Insert into RESERVATION_T (VNO,VTYPE,VPRICE,VNUM,VSTART,VEND,R_NO,C_NO,VVACANT) values ('R005','현금','100000','2',to_date('22/11/18','RR/MM/DD'),to_date('22/11/19','RR/MM/DD'),'RNAME005','C011','0');
Insert into RESERVATION_T (VNO,VTYPE,VPRICE,VNUM,VSTART,VEND,R_NO,C_NO,VVACANT) values ('R006','카드','154000','2',to_date('22/11/18','RR/MM/DD'),to_date('22/11/19','RR/MM/DD'),'RNAME006','C012','1');
Insert into RESERVATION_T (VNO,VTYPE,VPRICE,VNUM,VSTART,VEND,R_NO,C_NO,VVACANT) values ('R007','카카오페이','164000','2',to_date('22/11/18','RR/MM/DD'),to_date('22/11/19','RR/MM/DD'),'RNAME007','C013','1');
Insert into RESERVATION_T (VNO,VTYPE,VPRICE,VNUM,VSTART,VEND,R_NO,C_NO,VVACANT) values ('R008','삼성페이','193000','2',to_date('22/11/18','RR/MM/DD'),to_date('22/11/19','RR/MM/DD'),'RNAME008','C014','1');
Insert into RESERVATION_T (VNO,VTYPE,VPRICE,VNUM,VSTART,VEND,R_NO,C_NO,VVACANT) values ('R009','현금','156000','2',to_date('22/11/18','RR/MM/DD'),to_date('22/11/19','RR/MM/DD'),'RNAME009','C015','0');
Insert into RESERVATION_T (VNO,VTYPE,VPRICE,VNUM,VSTART,VEND,R_NO,C_NO,VVACANT) values ('R010','카드','91000','2',to_date('22/11/18','RR/MM/DD'),to_date('22/11/19','RR/MM/DD'),'RNAME010','C016','1');
Insert into RESERVATION_T (VNO,VTYPE,VPRICE,VNUM,VSTART,VEND,R_NO,C_NO,VVACANT) values ('R011','카카오페이','130000','2',to_date('22/11/18','RR/MM/DD'),to_date('22/11/19','RR/MM/DD'),'RNAME011','C017','0');
Insert into RESERVATION_T (VNO,VTYPE,VPRICE,VNUM,VSTART,VEND,R_NO,C_NO,VVACANT) values ('R012','삼성페이','198000','3',to_date('22/11/18','RR/MM/DD'),to_date('22/11/19','RR/MM/DD'),'RNAME012','C018','1');
Insert into RESERVATION_T (VNO,VTYPE,VPRICE,VNUM,VSTART,VEND,R_NO,C_NO,VVACANT) values ('R013','현금','52000','1',to_date('22/11/18','RR/MM/DD'),to_date('22/11/19','RR/MM/DD'),'RNAME013','C019','1');
Insert into RESERVATION_T (VNO,VTYPE,VPRICE,VNUM,VSTART,VEND,R_NO,C_NO,VVACANT) values ('R014','카드','51000','1',to_date('22/11/18','RR/MM/DD'),to_date('22/11/19','RR/MM/DD'),'RNAME014','C020','0');
Insert into RESERVATION_T (VNO,VTYPE,VPRICE,VNUM,VSTART,VEND,R_NO,C_NO,VVACANT) values ('R015','카카오페이','197000','3',to_date('22/11/18','RR/MM/DD'),to_date('22/11/19','RR/MM/DD'),'RNAME015','C021','1');
Insert into RESERVATION_T (VNO,VTYPE,VPRICE,VNUM,VSTART,VEND,R_NO,C_NO,VVACANT) values ('R016','삼성페이','187000','3',to_date('22/11/18','RR/MM/DD'),to_date('22/11/19','RR/MM/DD'),'RNAME016','C022','0');
Insert into RESERVATION_T (VNO,VTYPE,VPRICE,VNUM,VSTART,VEND,R_NO,C_NO,VVACANT) values ('R017','현금','25000','1',to_date('22/11/18','RR/MM/DD'),to_date('22/11/19','RR/MM/DD'),'RNAME017','C023','1');
Insert into RESERVATION_T (VNO,VTYPE,VPRICE,VNUM,VSTART,VEND,R_NO,C_NO,VVACANT) values ('R018','카드','90000','3',to_date('22/11/19','RR/MM/DD'),to_date('22/11/20','RR/MM/DD'),'RNAME018','C024','1');
Insert into RESERVATION_T (VNO,VTYPE,VPRICE,VNUM,VSTART,VEND,R_NO,C_NO,VVACANT) values ('R019','카카오페이','147000','2',to_date('22/11/19','RR/MM/DD'),to_date('22/11/20','RR/MM/DD'),'RNAME019','C025','0');
Insert into RESERVATION_T (VNO,VTYPE,VPRICE,VNUM,VSTART,VEND,R_NO,C_NO,VVACANT) values ('R020','삼성페이','129000','2',to_date('22/11/19','RR/MM/DD'),to_date('22/11/20','RR/MM/DD'),'RNAME020','C026','1');
Insert into RESERVATION_T (VNO,VTYPE,VPRICE,VNUM,VSTART,VEND,R_NO,C_NO,VVACANT) values ('R021','현금','270000','2',to_date('22/11/19','RR/MM/DD'),to_date('22/11/20','RR/MM/DD'),'RNAME021','C027','0');
Insert into RESERVATION_T (VNO,VTYPE,VPRICE,VNUM,VSTART,VEND,R_NO,C_NO,VVACANT) values ('R022','카드','182000','2',to_date('22/11/19','RR/MM/DD'),to_date('22/11/20','RR/MM/DD'),'RNAME022','C028','0');
Insert into RESERVATION_T (VNO,VTYPE,VPRICE,VNUM,VSTART,VEND,R_NO,C_NO,VVACANT) values ('R023','카카오페이','70000','2',to_date('22/11/19','RR/MM/DD'),to_date('22/11/20','RR/MM/DD'),'RNAME023','C029','1');
Insert into RESERVATION_T (VNO,VTYPE,VPRICE,VNUM,VSTART,VEND,R_NO,C_NO,VVACANT) values ('R024','삼성페이','103000','2',to_date('22/11/19','RR/MM/DD'),to_date('22/11/20','RR/MM/DD'),'RNAME024','C030','0');
Insert into RESERVATION_T (VNO,VTYPE,VPRICE,VNUM,VSTART,VEND,R_NO,C_NO,VVACANT) values ('R025','현금','147000','2',to_date('22/11/19','RR/MM/DD'),to_date('22/11/20','RR/MM/DD'),'RNAME025','C031','1');
Insert into RESERVATION_T (VNO,VTYPE,VPRICE,VNUM,VSTART,VEND,R_NO,C_NO,VVACANT) values ('R026','카드','46000','2',to_date('22/11/19','RR/MM/DD'),to_date('22/11/20','RR/MM/DD'),'RNAME026','C032','1');
Insert into RESERVATION_T (VNO,VTYPE,VPRICE,VNUM,VSTART,VEND,R_NO,C_NO,VVACANT) values ('R027','카카오페이','37000','2',to_date('22/11/19','RR/MM/DD'),to_date('22/11/20','RR/MM/DD'),'RNAME027','C033','1');
Insert into RESERVATION_T (VNO,VTYPE,VPRICE,VNUM,VSTART,VEND,R_NO,C_NO,VVACANT) values ('R028','삼성페이','108000','2',to_date('22/11/19','RR/MM/DD'),to_date('22/11/20','RR/MM/DD'),'RNAME028','C034','1');
Insert into RESERVATION_T (VNO,VTYPE,VPRICE,VNUM,VSTART,VEND,R_NO,C_NO,VVACANT) values ('R029','현금','119000','2',to_date('22/11/19','RR/MM/DD'),to_date('22/11/20','RR/MM/DD'),'RNAME029','C035','1');
Insert into RESERVATION_T (VNO,VTYPE,VPRICE,VNUM,VSTART,VEND,R_NO,C_NO,VVACANT) values ('R030','카드','69000','2',to_date('22/11/19','RR/MM/DD'),to_date('22/11/20','RR/MM/DD'),'RNAME030','C036','0');
Insert into RESERVATION_T (VNO,VTYPE,VPRICE,VNUM,VSTART,VEND,R_NO,C_NO,VVACANT) values ('R031','카카오페이','87000','1',to_date('22/11/19','RR/MM/DD'),to_date('22/11/20','RR/MM/DD'),'RNAME031','C037','0');
Insert into RESERVATION_T (VNO,VTYPE,VPRICE,VNUM,VSTART,VEND,R_NO,C_NO,VVACANT) values ('R032','삼성페이','105000','2',to_date('22/11/19','RR/MM/DD'),to_date('22/11/20','RR/MM/DD'),'RNAME032','C038','1');
Insert into RESERVATION_T (VNO,VTYPE,VPRICE,VNUM,VSTART,VEND,R_NO,C_NO,VVACANT) values ('R033','현금','185000','2',to_date('22/11/19','RR/MM/DD'),to_date('22/11/20','RR/MM/DD'),'RNAME033','C039','1');
Insert into RESERVATION_T (VNO,VTYPE,VPRICE,VNUM,VSTART,VEND,R_NO,C_NO,VVACANT) values ('R034','카드','127000','2',to_date('22/11/19','RR/MM/DD'),to_date('22/11/20','RR/MM/DD'),'RNAME034','C040','0');
Insert into RESERVATION_T (VNO,VTYPE,VPRICE,VNUM,VSTART,VEND,R_NO,C_NO,VVACANT) values ('R035','카카오페이','26000','2',to_date('22/11/19','RR/MM/DD'),to_date('22/11/20','RR/MM/DD'),'RNAME035','C041','0');
Insert into RESERVATION_T (VNO,VTYPE,VPRICE,VNUM,VSTART,VEND,R_NO,C_NO,VVACANT) values ('R036','삼성페이','154000','2',to_date('22/11/20','RR/MM/DD'),to_date('22/11/21','RR/MM/DD'),'RNAME036','C042','1');
Insert into RESERVATION_T (VNO,VTYPE,VPRICE,VNUM,VSTART,VEND,R_NO,C_NO,VVACANT) values ('R037','현금','172000','2',to_date('22/11/20','RR/MM/DD'),to_date('22/11/21','RR/MM/DD'),'RNAME037','C043','0');
Insert into RESERVATION_T (VNO,VTYPE,VPRICE,VNUM,VSTART,VEND,R_NO,C_NO,VVACANT) values ('R038','카드','110000','2',to_date('22/11/20','RR/MM/DD'),to_date('22/11/21','RR/MM/DD'),'RNAME038','C044','0');
Insert into RESERVATION_T (VNO,VTYPE,VPRICE,VNUM,VSTART,VEND,R_NO,C_NO,VVACANT) values ('R039','카카오페이','120000','1',to_date('22/11/20','RR/MM/DD'),to_date('22/11/21','RR/MM/DD'),'RNAME039','C045','1');
Insert into RESERVATION_T (VNO,VTYPE,VPRICE,VNUM,VSTART,VEND,R_NO,C_NO,VVACANT) values ('R040','삼성페이','73000','1',to_date('22/11/20','RR/MM/DD'),to_date('22/11/21','RR/MM/DD'),'RNAME040','C045','1');
Insert into RESERVATION_T (VNO,VTYPE,VPRICE,VNUM,VSTART,VEND,R_NO,C_NO,VVACANT) values ('R041','현금','177000','3',to_date('22/11/20','RR/MM/DD'),to_date('22/11/21','RR/MM/DD'),'RNAME041','C046','1');
Insert into RESERVATION_T (VNO,VTYPE,VPRICE,VNUM,VSTART,VEND,R_NO,C_NO,VVACANT) values ('R042','현금','110000','2',to_date('22/11/20','RR/MM/DD'),to_date('22/11/21','RR/MM/DD'),'RNAME042','C046','0');
Insert into RESERVATION_T (VNO,VTYPE,VPRICE,VNUM,VSTART,VEND,R_NO,C_NO,VVACANT) values ('R043','카카오페이','184000','3',to_date('22/11/20','RR/MM/DD'),to_date('22/11/21','RR/MM/DD'),'RNAME043','C047','0');
Insert into RESERVATION_T (VNO,VTYPE,VPRICE,VNUM,VSTART,VEND,R_NO,C_NO,VVACANT) values ('R044','카카오페이','73000','1',to_date('22/11/20','RR/MM/DD'),to_date('22/11/21','RR/MM/DD'),'RNAME044','C047','0');
Insert into RESERVATION_T (VNO,VTYPE,VPRICE,VNUM,VSTART,VEND,R_NO,C_NO,VVACANT) values ('R045','현금','178000','2',to_date('22/11/20','RR/MM/DD'),to_date('22/11/21','RR/MM/DD'),'RNAME045','C048','0');
Insert into RESERVATION_T (VNO,VTYPE,VPRICE,VNUM,VSTART,VEND,R_NO,C_NO,VVACANT) values ('R046','현금','95000','2',to_date('22/11/20','RR/MM/DD'),to_date('22/11/21','RR/MM/DD'),'RNAME046','C048','0');
Insert into RESERVATION_T (VNO,VTYPE,VPRICE,VNUM,VSTART,VEND,R_NO,C_NO,VVACANT) values ('R047','삼성페이','141000','1',to_date('22/11/20','RR/MM/DD'),to_date('22/11/21','RR/MM/DD'),'RNAME047','C049','0');
Insert into RESERVATION_T (VNO,VTYPE,VPRICE,VNUM,VSTART,VEND,R_NO,C_NO,VVACANT) values ('R048','삼성페이','173000','3',to_date('22/11/20','RR/MM/DD'),to_date('22/11/21','RR/MM/DD'),'RNAME048','C049','0');
Insert into RESERVATION_T (VNO,VTYPE,VPRICE,VNUM,VSTART,VEND,R_NO,C_NO,VVACANT) values ('R049','카드','121000','2',to_date('22/11/20','RR/MM/DD'),to_date('22/11/21','RR/MM/DD'),'RNAME049','C050','0');
Insert into RESERVATION_T (VNO,VTYPE,VPRICE,VNUM,VSTART,VEND,R_NO,C_NO,VVACANT) values ('R050','카드','142000','2',to_date('22/11/20','RR/MM/DD'),to_date('22/11/21','RR/MM/DD'),'RNAME050','C050','1');
Insert into RESERVATION_T (VNO,VTYPE,VPRICE,VNUM,VSTART,VEND,R_NO,C_NO,VVACANT) values ('R001','현금','157000','2',to_date('22/11/17','RR/MM/DD'),to_date('22/11/18','RR/MM/DD'),'RNAME001','C007','0');

