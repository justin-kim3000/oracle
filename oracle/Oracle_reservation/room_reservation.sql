select bname 건물이름, rname 방이름, rtype 등급, rprice "1박 가격", baddr 주소
from room_t r inner join reservation_t v
on r.rname = v.r_no
inner join business_t b
on b.bno=r.b_no;

-- 빈방확인
select *
from room_t r inner join reservation_t v
on vvacant = 1 and r.rname = v.r_no
inner join business_t b
on b.bno=r.b_no;

select bname 건물이름, rname 방이름, rtype 등급, rprice "1박 가격", baddr 주소
from room_t r inner join reservation_t v
on vvacant = 1 and r.rname = v.r_no
inner join business_t b
on b.bno=r.b_no;

-- 투숙기간에 따른 총 가격
select bname 건물이름, rname 방이름, rtype 등급, rprice "1박 가격", baddr 주소, vperiod 투숙기간, vprice*vperiod 총가격
from room_t r inner join reservation_t v
on vvacant = 1 and r.rname = v.r_no
inner join business_t b
on b.bno=r.b_no;

-- 주소지 검색 : 동구
select bname 건물이름, rname 방이름, rtype 등급, rprice "1박 가격", baddr 주소
from room_t r inner join reservation_t v
on vvacant = 1 and r.rname = v.r_no
inner join business_t b
on b.bno=r.b_no
where baddr like '%동구%';

-- 가격검색 30000~60000만
select bname 건물이름, rname 방이름, rtype 등급, rprice "1박 가격",  
        decode(vvacant, 1, '예약가능',
                                0, '예약불가능') 예약상태, baddr 주소
from room_t r inner join reservation_t v
on r.rname = v.r_no
inner join business_t b
on b.bno=r.b_no
where rprice between 30000 and 60000;

-- 건물이름으로 검색(프랜차이즈 검색 : 신라호텔, toyoco-in, 사보이)
select bname 건물이름, rname 방이름, rtype 등급, rprice "1박 가격",  
            decode(vvacant, 1, '예약가능',
                                     0, '예약불가능') 예약상태, baddr 주소
from room_t r inner join reservation_t v
on r.rname = v.r_no
inner join business_t b
on b.bno=r.b_no
where bname like '%사보이%';

-- n성급 숙소 검색 : 3성급, 4성급
select bname 건물이름, rname 방이름, rtype 등급, rprice "1박 가격",  
            decode(vvacant, 1, '예약가능',
                                     0, '예약불가능') 예약상태, baddr 주소
from room_t r inner join reservation_t v
on r.rname = v.r_no
inner join business_t b
on b.bno=r.b_no
where rtype in ('3STAR', '4STAR')
order by 예약상태, rtype;

select bname 건물이름, rname 방이름, rtype 등급, rprice "1박 가격",  
            decode(vvacant, 1, '예약가능',
                                     0, '예약불가능') 예약상태, baddr 주소
from room_t r inner join reservation_t v
on r.rname = v.r_no
inner join business_t b
on b.bno=r.b_no
where rtype like '3%' or rtype like '4%'
order by 예약상태, rtype;

-- 50만원 선에서 2박 이상인 방
select bname 건물이름, rname 방이름, rtype 등급, rprice "1박 가격",  
            decode(vvacant, 1, '예약가능',
                                     0, '예약불가능') 예약상태, baddr 주소, vperiod 투숙기간, vprice*vperiod 총가격
from room_t r inner join reservation_t v
on r.rname = v.r_no
inner join business_t b
on b.bno=r.b_no
where vperiod >= 2 and vprice*vperiod <= 500000;

-- 장기투숙객 할인
-- 고객이름(고객t) 건물이름(업소t) 방이름(방t) 등급(방t) 1일가격(방t) 숙박일수(예약t) 할인율 총결제액(1일가격*숙박일수*할인율)
-- 투숙일이 3일이상이면 5%할인(현 테이블에는 3일이 최대 숙박, 데이터 추가하면 5or10일을 5%, 20일 넘어가면 10%
select cname 고객이름, bname 건물이름, rname 방이름, rtype 등급, rprice "1박 가격", vperiod 숙박일수, 
        case when vperiod >=3 then vprice*vperiod*0.95
        else vprice*vperiod
        end as 총가격
from room_t r inner join reservation_t v
on r.rname = v.r_no
inner join business_t b
on b.bno=r.b_no
inner join customer_t c
on c.cno = v.c_no
where vperiod >=3;

-- 장기투숙객+현금결제 할인
-- 투숙일이 3일이상이면 5%할인(현 테이블에는 3일이 최대 숙박, 데이터 추가하면 5or10일을 5%, 20일 넘어가면 10%
-- 결제방식 = 현금이면 할인 5%
-- 고객이름(고객t) 건물이름(업소t) 방이름(방t) 등급(방t) 1일가격(방t) 결제방식 숙박일수(예약t) 할인율 총결제액(1일가격*숙박일수*할인율)
select cname 고객이름, bname 건물이름, rname 방이름, rtype 등급, rprice "1박 가격", vtype "결제 방식", vperiod 숙박일수, vprice*vperiod "할인 전 가격",
        case when vperiod >=3 and vtype = '현금' then vprice*vperiod*0.95*0.95
                when (vperiod >=3 and vtype != '현금') or (vperiod <3 and vtype = '현금') then vprice*vperiod*0.95
        else vprice*vperiod
        end as 총가격
from room_t r inner join reservation_t v
on r.rname = v.r_no
inner join business_t b
on b.bno=r.b_no
inner join customer_t c
on c.cno = v.c_no;
--where vperiod >=3 and vtype = '현금';  --장기투숙객, 현금 조건추가



 
 -- 다이용고객 할인정보
-- 고객이름(고객t) 건물이름(업소t) 방이름(방t) 등급(방t) 1일가격(방t) 이용횟수(예약t에서카운트) 할인율 숙박일수(예약t) 총결제액(1일가격*숙박일수*할인율)
select cname 고객이름, bname 건물이름, rname 방이름, rtype 등급, rprice "1박 가격", vperiod 숙박일수, vprice*vperiod 총가격, count(*)
from room_t r inner join reservation_t v
on r.rname = v.r_no
inner join business_t b
on b.bno=r.b_no
inner join customer_t c
on c.cno = v.c_no
group by c.cno;
-- 예약테이블에서 고객고유번호 검색으로 일정갯수 이상이 검색되면 할인율 적용