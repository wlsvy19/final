==================================================================================================================================
==================================================================================================================================
-- 테이블 삭제
drop table chatting;        -- 채팅 테이블 삭제
drop table purchase;        -- 회원구매정보 테이블 삭제
drop table shopping_sales;  -- 상품판매 테이블 삭제
drop table warehouse;       -- 상품입고 테이블 삭제
drop table shopping_file;   -- 상품 댓글 멀티파일 테이블 삭제
drop table shopping_reply;  -- 상품댓글 테이블 삭제
drop table shopping;        -- 상품정보 테이블 삭제
drop table board_reply;     -- 게시판 댓글 테이블 삭제
drop table board_file;      -- 게시판 멀티파일 테이블 삭제
drop table board;           -- 게시판 테이블 삭제
drop table member;          -- 회원정보 테이블 삭제
drop table basket;          -- 장바구니 테이블 삭제
drop table disc;            -- 취미분석 테이블 삭제
drop table shopping_like;   -- 관심상품 테이블 삭제
==================================================================================================================================
==================================================================================================================================
-- 시퀀스 삭제
drop sequence board_num_seq;  -- 게시글 번호 시퀀스 삭제
drop sequence reply_num_seq;  -- 게시글 댓글 번호 시퀀스 삭제
drop sequence shop_num_seq;   -- 상품 번호 시퀀스 삭제
drop sequence sreply_num_seq; -- 상품 댓글 번호 시퀀스 삭제
drop sequence ware_num_seq;   -- 상품 입고 번호 시퀀스 삭제
drop sequence sales_num_seq;  -- 상품 판매 번호 시퀀스 삭제
==================================================================================================================================
==================================================================================================================================
-- 테이블 생성

-- 회원정보 테이블 생성
CREATE TABLE member(
    mem_id          VARCHAR2(2000 BYTE) NOT NULL,   -- 회원 아이디
    mem_pw          VARCHAR2(2000 BYTE),            -- 회원 비밀번호
    mem_phone       VARCHAR2(2000 BYTE),            -- 회원 전화번호
    mem_email       VARCHAR2(2000 BYTE),            -- 회원 이메일
    mem_emailchk    VARCHAR2(2000 BYTE),            -- 회원 이메일체크
    mem_birth       VARCHAR2(2000 BYTE),            -- 회원 생일
    mem_address     VARCHAR2(2000 BYTE),            -- 회원 주소
    mem_detailaddress   VARCHAR2(2000 BYTE),        -- 회원 상세주소
    mem_oaddress    VARCHAR2(2000 BYTE),            -- 회원 우편번호
    mem_gender      VARCHAR2(2000 BYTE),            -- 회원 성별
    mem_hobby       VARCHAR2(2000 BYTE)             -- 회원 취미
);

-- 회원 아이디 기본키 설정
ALTER TABLE member ADD CONSTRAINT member_PK PRIMARY KEY (mem_id);

==================================================================================================================================

-- 나나게시판 테이블 생성
CREATE TABLE board(
    board_num       NUMBER NOT NULL,        -- 게시글 번호
    board_writer    VARCHAR2(2000 BYTE),    -- 게시글 작성자
    board_title     VARCHAR2(2000 BYTE),    -- 게시글 제목
    board_regdate   DATE,                   -- 게시글 작성날짜
    board_count     NUMBER(10) default 0,   -- 게시글 조회수
    board_content   VARCHAR2(2000 BYTE),    -- 게시글 내용
    board_ref       NUMBER(10),             -- 게시글, 답변글 그룹
    board_re_step   NUMBER(10),             -- 그룹내순서
    board_re_level  NUMBER(10),             -- 게시글 깊이
    board_file      VARCHAR2(2000 BYTE)     -- 게시글 파일
);

select * from board
commit;
-- 게시글 번호 기본키 설정
ALTER TABLE board ADD CONSTRAINT board_PK PRIMARY KEY (board_num);
select  *from board
delete from board
commit;

-- 게시글 번호 시퀀스 설정
create sequence board_num_seq 
start with 1
increment by 1
nocache
nocycle;

==================================================================================================================================

-- 게시판 멀티파일 테이블 생성
CREATE TABLE board_file(
    board_num       NUMBER NOT NULL,    -- 게시글 번호
    board_file      VARCHAR2(2000 BYTE) -- 게시글 첨부파일
);

-- 게시글 번호 외래키 설정
ALTER TABLE board_file
ADD CONSTRAINT board_file_board_FK FOREIGN KEY (board_num)
REFERENCES board (board_num);

==================================================================================================================================

-- 게시판 댓글 테이블 생성
CREATE TABLE board_reply(
    board_num       NUMBER NOT NULL,    -- 게시글 번호
    reply_num       NUMBER NOT NULL,    -- 게시글 댓글 번호
    reply_writer    VARCHAR2(2000 BYTE),-- 게시글 댓글 작성자
    reply_content   VARCHAR2(2000 BYTE),-- 게시글 댓글 내용
    reply_regdate   DATE,               -- 게시글 댓글 작성날짜 
    reply_like      NUMBER(10)          -- 게시글 댓글 좋아요
);

-- 댓글 번호 기본키 설정
ALTER TABLE board_reply ADD CONSTRAINT board_reply_PK PRIMARY KEY (reply_num);

-- 게시글 번호 외래키 설정
ALTER TABLE board_reply
ADD CONSTRAINT board_reply_board_FK FOREIGN KEY (board_num)
REFERENCES board (board_num);
        
-- 댓글 번호 시퀀스 설정
create sequence reply_num_seq 
start with 1
increment by 1
nocache
nocycle;

==================================================================================================================================

-- 상품정보 테이블 생성
CREATE TABLE shopping(
    shop_num            NUMBER NOT NULL,    -- 상품 번호
    shop_name           VARCHAR2(2000 BYTE),-- 상품 이름
    shop_code           VARCHAR2(2000 BYTE),-- 상품 코드
    shop_price          NUMBER(10),         -- 상품 가격
    shop_regdate        DATE,               -- 상품 등록 날짜
    shop_sellcnt        NUMBER(10),         -- 상품 출고 숫자
    shop_stock          NUMBER(10),         -- 상품 재고 수량
    shop_imgpath        VARCHAR2(2000 BYTE),-- 상품 이미지 경로
    shop_starcnt        NUMBER(10,2)        -- 상품 별점
);

delete from shopping;



insert into shopping
values (shop_num_seq.nextval, '드론이 처음인 당신을 위하여', '사교형', 79000, sysdate, 0, 10, '/nanaland/사교형/드론이 처음인 당신을 위하여 79000', 0);

insert into shopping
values (shop_num_seq.nextval, '셀토의 하비박스_스마트토이,T-REX', '사교형', 62500, sysdate, 0, 10, '/nanaland/사교형/셀토의 하비박스_스마트토이,T-REX 62500', 0);

insert into shopping
values (shop_num_seq.nextval, '쏄토의 하비박스_스마트토이,레이싱카', '사교형', 59500, sysdate, 0, 10, '/nanaland/사교형/쏄토의 하비박스_스마트토이,레이싱카 59500', 0);

insert into shopping
values (shop_num_seq.nextval, '쏄토의 하비박스_스마트토이,로더', '사교형', 59500, sysdate, 0, 10, '/nanaland/사교형/쏄토의 하비박스_스마트토이,로더 59500', 0);

insert into shopping
values (shop_num_seq.nextval, '쏄토의 하비박스_스마트토이,지프', '사교형', 59500, sysdate, 0, 10, '/nanaland/사교형/쏄토의 하비박스_스마트토이,지프 59500', 0);

insert into shopping
values (shop_num_seq.nextval, '쏄토의 하비박스_스마트토이,휠리', '사교형', 62500, sysdate, 0, 10, '/nanaland/사교형/쏄토의 하비박스_스마트토이,휠리 62500', 0);

insert into shopping
values (shop_num_seq.nextval, '알디프의 하비박스_달위의 티박스', '신중형', 44000, sysdate, 0, 10, '/nanaland/신중형/알디프의 하비박스_달위의 티박스 44000', 0);

insert into shopping
values (shop_num_seq.nextval, '알디프의 하비박스_오피스 티박스', '신중형', 29000, sysdate, 0, 10, '/nanaland/신중형/알디프의 하비박스_오피스 티박스 29000', 0);

insert into shopping
values (shop_num_seq.nextval, '디아페의 하비박스_향의 발견', '안정형', 49500, sysdate, 0, 10, '/nanaland/안정형/디아페의 하비박스_향의 발견 49500', 0);

insert into shopping
values (shop_num_seq.nextval, '디자인아난의 하비박스_예술놀이 콜라주엽서', '안정형', 22000, sysdate, 0, 10, '/nanaland/안정형/디자인아난의 하비박스_예술놀이 콜라주엽서 22000', 0);

insert into shopping
values (shop_num_seq.nextval, '피킷플라워의 하비박스_압화드로잉', '안정형', 13000, sysdate, 0, 10, '/nanaland/안정형/피킷플라워의 하비박스_압화드로잉 13000', 0);

insert into shopping
values (shop_num_seq.nextval, '홈앤톤즈의 하비박스_스트랩시계', '안정형', 50000, sysdate, 0, 10, '/nanaland/안정형/홈앤톤즈의 하비박스_스트랩시계 50000', 0);

insert into shopping
values (shop_num_seq.nextval, '홈앤톤즈의 하비박스_우드스피커 홈페인팅', '안정형', 50000, sysdate, 0, 10, '/nanaland/안정형/홈앤톤즈의 하비박스_우드스피커 홈페인팅 50000', 0);

insert into shopping
values (shop_num_seq.nextval, '가죽 미니 버킷백 만들기 클래스', '주도형', 62000, sysdate, 0, 10, '/nanaland/주도형/가죽 미니 버킷백 만들기 클래스 62000', 0);

insert into shopping
values (shop_num_seq.nextval, '가죽 여권케이스 만들기 클래스(베이지)', '주도형', 30000, sysdate, 0, 10, '/nanaland/주도형/가죽 여권케이스 만들기 클래스(베이지) 30000', 0);

insert into shopping
values (shop_num_seq.nextval, '가죽 여권케이스 만들기 클래스(크림)', '주도형', 30000, sysdate, 0, 10, '/nanaland/주도형/가죽 여권케이스 만들기 클래스(크림) 30000', 0);

insert into shopping
values (shop_num_seq.nextval, '가죽 카드지갑 만들기 클래스', '주도형', 30000, sysdate, 0, 10, '/nanaland/주도형/가죽 카드지갑 만들기 클래스 30000', 0);

insert into shopping
values (shop_num_seq.nextval, '가죽팔찌 3종 만들기 클래스', '주도형', 30000, sysdate, 0, 10, '/nanaland/주도형/가죽팔찌 3종 만들기 클래스 30000', 0);

insert into shopping
values (shop_num_seq.nextval, '걸어서 30분 지구와 달 팔찌 만들기(골드)', '주도형', 17500, sysdate, 0, 10, '/nanaland/주도형/걸어서 30분 지구와 달 팔찌 만들기(골드) 17500', 0);

insert into shopping
values (shop_num_seq.nextval, '걸어서 30분 지구와 달 팔찌 만들기(실버)', '주도형', 17500, sysdate, 0, 10, '/nanaland/주도형/걸어서 30분 지구와 달 팔찌 만들기(실버) 17500', 0);

insert into shopping
values (shop_num_seq.nextval, '꽃다발 스탠드 수채화 클래스', '주도형', 25000, sysdate, 0, 10, '/nanaland/주도형/꽃다발 스탠드 수채화 클래스 25000', 0);

insert into shopping
values (shop_num_seq.nextval, '꽃잎 가득 캔들 만들기 클래스', '주도형', 18500, sysdate, 0, 10, '/nanaland/주도형/꽃잎 가득 캔들 만들기 클래스 18500', 0);

insert into shopping
values (shop_num_seq.nextval, '마크라메 네트백 만들기 클래스', '주도형', 30000, sysdate, 0, 10, '/nanaland/주도형/마크라메 네트백 만들기 클래스 30000', 0);

insert into shopping
values (shop_num_seq.nextval, '마크라메 라그라스 월행잉 만들기 클래스', '주도형', 30000, sysdate, 0, 10, '/nanaland/주도형/마크라메 라그라스 월행잉 만들기 클래스 30000', 0);

insert into shopping
values (shop_num_seq.nextval, '목화 리스 마크라메 클래스', '주도형', 28500, sysdate, 0, 10, '/nanaland/주도형/목화 리스 마크라메 클래스 28500', 0);

insert into shopping
values (shop_num_seq.nextval, '반려동물 장난감 뜨개질 클래스', '주도형', 30000, sysdate, 0, 10, '/nanaland/주도형/반려동물 장난감 뜨개질 클래스 30000', 0);

insert into shopping
values (shop_num_seq.nextval, '사각 티 코스터 뜨개질 클래스', '주도형', 30000, sysdate, 0, 10, '/nanaland/주도형/사각 티 코스터 뜨개질 클래스 30000', 0);

insert into shopping
values (shop_num_seq.nextval, '세상의 모든 강아지 수채화 클래스', '주도형', 38000, sysdate, 0, 10, '/nanaland/주도형/세상의 모든 강아지 수채화 클래스 38000', 0);

insert into shopping
values (shop_num_seq.nextval, '수납 포켓 월행잉 마크라메 클래스', '주도형', 38500, sysdate, 0, 10, '/nanaland/주도형/수납 포켓 월행잉 마크라메 클래스 38500', 0);

insert into shopping
values (shop_num_seq.nextval, '아기 돼지 삼형제 인형 뜨개질 클래스', '주도형', 38500, sysdate, 0, 10, '/nanaland/주도형/아기 돼지 삼형제 인형 뜨개질 클래스 38500', 0);

insert into shopping
values (shop_num_seq.nextval, '원형 수납바구니 뜨개질 클래스', '주도형', 30000, sysdate, 0, 10, '/nanaland/주도형/원형 수납바구니 뜨개질 클래스 30000', 0);

insert into shopping
values (shop_num_seq.nextval, '위빙 드림캐처 만들기 클래스', '주도형', 30000, sysdate, 0, 10, '/nanaland/주도형/위빙 드림캐처 만들기 클래스 30000', 0);

insert into shopping
values (shop_num_seq.nextval, '유미의 세포들 출출이 미니어처 만들기 클래스', '주도형', 30000, sysdate, 0, 10, '/nanaland/주도형/유미의 세포들 출출이 미니어처 만들기 클래스 30000', 0);

insert into shopping
values (shop_num_seq.nextval, '제주 바다 가랜드 수채화 클래스', '주도형', 26000, sysdate, 0, 10, '/nanaland/주도형/제주 바다 가랜드 수채화 클래스 26000', 0);

insert into shopping
values (shop_num_seq.nextval, '천연 가죽필통 만들기 클래스', '주도형', 34000, sysdate, 0, 10, '/nanaland/주도형/천연 가죽필통 만들기 클래스 34000', 0);

insert into shopping
values (shop_num_seq.nextval, '커피,프레즐 키링 프랑스자수 클래스', '주도형', 22500, sysdate, 0, 10, '/nanaland/주도형/커피,프레즐 키링 프랑스자수 클래스 22500', 0);

insert into shopping
values (shop_num_seq.nextval, '토끼인형 뜨개질 클래스', '주도형', 30000, sysdate, 0, 10, '/nanaland/주도형/토끼인형 뜨개질 클래스 30000', 0);

insert into shopping
values (shop_num_seq.nextval, '펀치니들 크로스백 만들기 클래스', '주도형', 62000, sysdate, 0, 10, '/nanaland/주도형/펀치니들 크로스백 만들기 클래스 62000', 0);

insert into shopping
values (shop_num_seq.nextval, '페이퍼 자이언트로즈 조명 만들기 클래스', '주도형', 35000, sysdate, 0, 10, '/nanaland/주도형/페이퍼 자이언트로즈 조명 만들기 클래스 35000', 0);

insert into shopping
values (shop_num_seq.nextval, '풀꽃 양말 프랑스자수 클래스', '주도형', 35000, sysdate, 0, 10, '/nanaland/주도형/풀꽃 양말 프랑스자수 클래스 35000', 0);

insert into shopping
values (shop_num_seq.nextval, '프랑스자수 꽃 향수 액자 클래스', '주도형', 30000, sysdate, 0, 10, '/nanaland/주도형/프랑스자수 꽃 향수 액자 클래스 30000', 0);

insert into shopping
values (shop_num_seq.nextval, '프랑스자수 밤의 숲 수놓기 클래스', '주도형', 19500, sysdate, 0, 10, '/nanaland/주도형/프랑스자수 밤의 숲 수놓기 클래스 19500', 0);

insert into shopping
values (shop_num_seq.nextval, '프랑스자수 수제버거 파우치 클래스', '주도형', 30000, sysdate, 0, 10, '/nanaland/주도형/프랑스자수 수제버거 파우치 클래스 30000', 0);

insert into shopping
values (shop_num_seq.nextval, '프랑스자수 식물 인테리어 액자 클래스', '주도형', 30000, sysdate, 0, 10, '/nanaland/주도형/프랑스자수 식물 인테리어 액자 클래스 30000', 0);

insert into shopping
values (shop_num_seq.nextval, '프랑스자수 카페 에코백 클래스', '주도형', 30000, sysdate, 0, 10, '/nanaland/주도형/프랑스자수 카페 에코백 클래스 30000', 0);

-- 상품 번호 기본키 설정
ALTER TABLE shopping ADD CONSTRAINT shopping_PK PRIMARY KEY (shop_num);

-- 상품 번호 시퀀스 설정
create sequence shop_num_seq 
start with 1
increment by 1
nocache
nocycle;

==================================================================================================================================

-- 상품 댓글 테이블 생성
CREATE TABLE shopping_reply(
    shop_num            NUMBER NOT NULL,     -- 상품 번호
    sreply_num          NUMBER NOT NULL,     -- 상품 댓글 번호
    sreply_writer       VARCHAR2(2000 BYTE), -- 상품 댓글 작성자
    sreply_content      VARCHAR2(2000 BYTE), -- 상품 댓글 내용
    sreply_regdate      DATE,                -- 상품 댓글 작성 날짜
    sreply_star         NUMBER(10)           -- 상품 댓글 별점
);

-- 댓글 번호 기본키 설정
ALTER TABLE shopping_reply ADD CONSTRAINT shopping_reply_PK PRIMARY KEY (sreply_num);

-- 상품 번호 외래키 설정
ALTER TABLE shopping_reply
ADD CONSTRAINT shopping_reply_shopping_FK FOREIGN KEY (shop_num)
REFERENCES shopping (shop_num);

-- 상품 댓글 번호 시퀀스 설정
create sequence sreply_num_seq 
start with 1
increment by 1
nocache
nocycle;

==================================================================================================================================

-- 상품댓글 멀티파일 테이블 생성
CREATE TABLE shopping_file(
    sreply_num      NUMBER NOT NULL,     -- 상품 댓글 번호
    shop_file       VARCHAR2(2000 BYTE), -- 상품 댓글 첨부 파일
    shop_num        NUMBER NOT NULL      -- 상품 번호
);

-- 상품댓글번호 외래키 설정
ALTER TABLE shopping_file
ADD CONSTRAINT shopping_file_reply_FK FOREIGN KEY (sreply_num)
REFERENCES shopping_reply (sreply_num);

-- 상품 번호 외래키 설정
ALTER TABLE shopping_file
ADD CONSTRAINT shopping_file_shopping_FK FOREIGN KEY (shop_num)
REFERENCES shopping (shop_num);

==================================================================================================================================

-- 상품 입고 테이블 생성
CREATE TABLE warehouse (
    ware_num        NUMBER NOT NULL,        -- 상품 입고 번호
    shop_num        NUMBER NOT NULL,        -- 상품 번호
    ware_regdate    DATE default sysdate,   -- 상품 입고 날짜
    ware_cnt        NUMBER(10),             -- 상품 입고 수량
    ware_price      NUMBER(10)              -- 상품 입고 단가
);

-- 상품입고번호 기본키 설정
ALTER TABLE warehouse ADD CONSTRAINT warehouse_PK PRIMARY KEY (ware_num);

-- 상품번호 외래키 설정
ALTER TABLE warehouse
ADD CONSTRAINT warehouse_shopping_FK FOREIGN KEY (shop_num)
REFERENCES shopping (shop_num);

-- 상품입고번호 시퀀스 설정
create sequence ware_num_seq 
start with 1
increment by 1
nocache
nocycle;

==================================================================================================================================

-- 상품판매 테이블 생성
CREATE TABLE shopping_sales(
    sales_num       NUMBER NOT NULL,        -- 상품 판매 번호
    shop_num        NUMBER NOT NULL,        -- 상품 번호
    sales_regdate   DATE default sysdate,   -- 상품 판매 날짜
    sales_cnt       NUMBER(10),             -- 상품 판매 수량
    sales_price     NUMBER(10)              -- 상품 판매 단가
);

-- 상품판매번호 기본키 설정
ALTER TABLE shopping_sales ADD CONSTRAINT shopping_sales_PK PRIMARY KEY (sales_num);

-- 상품번호 외래키 설정
ALTER TABLE shopping_sales
ADD CONSTRAINT shopping_sales_shopping_FK FOREIGN KEY (shop_num)
REFERENCES shopping (shop_num);

-- 상품판매번호 시퀀스 설정
create sequence sales_num_seq 
start with 1
increment by 1
nocache
nocycle;

==================================================================================================================================

-- 회원구매정보 테이블 생성
CREATE TABLE purchase(
    mem_id                 VARCHAR2(2000 BYTE) NOT NULL, -- 회원 아이디
    shop_num               NUMBER NOT NULL,              -- 상품 번호
    purchase_cnt           NUMBER(10),                   -- 상품 구매 수량
    purchase_totalprice    NUMBER(10),                   -- 총 구매 가격
    purchase_regdate       DATE,                         -- 구매 날짜
    purchase_condition     NUMBER(10)                    -- 배송 상태
);

-- 회원 아이디 외래키 설정
ALTER TABLE purchase
ADD CONSTRAINT purchase_member_FK FOREIGN KEY (mem_id)
REFERENCES member (mem_id);

-- 상품 번호 외래키 설정
ALTER TABLE purchase
ADD CONSTRAINT purchase_shopping_FK FOREIGN KEY (shop_num)
REFERENCES shopping (shop_num);

==================================================================================================================================

-- 채팅 테이블 생성
CREATE TABLE chatting(
    chat_category   NUMBER(10),          -- 채팅방 분류
    chat_sendid     VARCHAR2(2000 BYTE), -- 발신자
    chat_receiver   VARCHAR2(2000 BYTE), -- 수신자
    chat_content    VARCHAR2(2000 BYTE), -- 채팅 내용
    chat_regdate    DATE                 -- 채팅 날짜
);

==================================================================================================================================
-- 장바구니 테이블 생성

CREATE TABLE basket(
    -- 배송지가 회원정보와 동일하지 않는 경우 입력할 정보를 담을 컬럼
    basket_phone       VARCHAR2(2000 BYTE),            -- 회원 전화번호
    basket_address     VARCHAR2(2000 BYTE),            -- 회원 주소
    basket_detailaddress   VARCHAR2(2000 BYTE),        -- 회원 상세주소
    basket_oaddress    VARCHAR2(2000 BYTE)             -- 회원 우편번호
);

==================================================================================================================================

-- 취미분석 테이블 생성
CREATE TABLE disc (
    disc_num        NUMBER(10),         -- 항목번호(24번까지)
    disc_one        VARCHAR(2000BYTE),  -- 1번 보기
    disc_two        VARCHAR(2000BYTE),  -- 2번 보기
    disc_three      VARCHAR(2000BYTE),  -- 3번 보기
    disc_four       VARCHAR(2000BYTE)   -- 4번 보기
);
-- 값은 hashMap으로 저장

==================================================================================================================================
-- disc 테이블 레코드 추가

insert into disc
values (1, '절제하는,s', '강력한,d', '꼼꼼한,c', '표현력 있는,i');
insert into disc
values (2, '개척적인,d', '정확한,c', '흥미진진한,i', '만족스러운,s');
insert into disc
values (3, '기꺼이 하는,s', '활기 있는,i', '대담한,d', '정교한,c');
insert into disc
values (4, '논쟁을 좋아 하는,d', '회의적인,c', '주저하는,s', '예측할 수 없는,i');
insert into disc
values (5, '공손한,c', '사교적인,i', '참을성 있는,s', '무서움을 모르는,d');
insert into disc
values (6, '설득력 있는,i', '독립심 강한,d', '논리적인,c', '온화한,s');
insert into disc
values (7, '신중한,c', '차분한,s', '과단성 있는,d', '파티를 좋아하는,i');
insert into disc
values (8, '인기 있는,i', '고집 있는,d', '완벽주의자,c', '인심 좋은,s');
insert into disc
values (9, '변화가 많은,i', '수줍음을 타는,c', '느긋한,s', '완고한,d');
insert into disc
values (10, '체계적인,c', '낙관적인,i', '의지가 강한,d', '친절한,s');
insert into disc
values (11, '엄격한,d', '겸손한,c', '상냥한,s', '말주변이 좋은,i');
insert into disc
values (12, '호의적인,s', '빈틈 없는,c', '놀기 좋아하는,i', '의지가 강한,d');
insert into disc
values (13, '참신한,i', '모험적인,d', '절제된,c', '신중한,s');
insert into disc
values (14, '참는,c', '성실한,s', '공격적인,d', '매력있는,i');
insert into disc
values (15, '열정적인,i', '분석적인,c', '동정심이 많은,s', '단호한,d');
insert into disc
values (16, '지도력 있는,d', '충동적인,i', '느린,s', '비판적인,c');
insert into disc
values (17, '일관성 있는,c', '영향력 있는,d', '생기 있는,i', '느긋한,s');
insert into disc
values (18, '유력한,i', '친절한,s', '독립적인,d', '정돈된,c');
insert into disc
values (19, '이상주의적인,c', '평판이 좋은,i', '쾌활한,s', '솔직한,d');
insert into disc
values (20, '참을성 없는,d', '진지한,c', '미루는,s', '감성적인,i');
insert into disc
values (21, '경쟁심 있는,d', '자발적인,i', '충성스러운,s', '사려깊은,c');
insert into disc
values (22, '희생적인,c', '이해심 많은,s', '설득력 있는,i', '용기 있는,d');
insert into disc
values (23, '의존적인,s', '변덕스러운,i', '절제력 있는,c', '밀어 붙이는,d');
insert into disc
values (24, '포용력 있는,s', '전통적인,c', '사람을 부추기는,i', '이끌어 가는,d');
==================================================================================================================================
-- 트리거 생성

-- 창고(warehouse)에 상품이 입고될 때마다 상품(item)의 수량이 늘어나도록
-- [재고수량 갱신을 위한 트리거 생성]
create or replace trigger cnt_add
after insert on warehouse                   -- 웨어하우스에 insert가 발생한 후
for each row                                        -- 각 row마다 반복한다는 의미
begin
update shopping set shop_stock = shop_stock + :new.ware_cnt
    -- new 선언은 insert문,update문에서만 사용가능
    -- new키워드를 통해 warehouse 테이블 데이터에접근할 수 있고, warehouse 테이블에 insert작업이 이루어진 후의
    -- 데이터를 가지고 온다는 의미이다.(new)
where shop_num = :new.shop_num;
end;
/                                                            -- / 까지 실행해야합니다.
--item 테이블에 있는 값이 warehouse의 값과 같을 때 cnt 값을 수정..


--판매테이블에서 insert트리거를 작성(BEFORE트리거로 작성)
--[판매테이브레서 자료가 추가되는 경우 상품테이블의 재고수량이 변경되도록 트리거 작성
create or replace trigger trg_sales_insert
before insert on shopping_sales
-- sales 테이블에 insert가 발생되기 전에 update하라
for each row
begin
update shopping
set shop_stock=shop_stock-:NEW.sales_cnt
where shop_num=:NEW.shop_num;
end;
/
 
 commit;
 
 
 ---------------------------------------------------------------------------------------------
 --관심상품 처리 테이블
CREATE TABLE shopping_like(
    mem_id          VARCHAR2(2000 BYTE) NOT NULL,   -- 회원 아이디
    shop_num        NUMBER NOT NULL                 -- 상품 번호
);

-- 회원 아이디 외래키 설정
ALTER TABLE shopping_like
ADD CONSTRAINT shopping_like_member_FK FOREIGN KEY (mem_id)
REFERENCES member (mem_id);


commit;
