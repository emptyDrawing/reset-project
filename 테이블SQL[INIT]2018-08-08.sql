-- 상품랭킹
ALTER TABLE `Rank`
	DROP PRIMARY KEY; -- 상품랭킹 기본키

-- 제품
ALTER TABLE `items`
	DROP PRIMARY KEY; -- 제품 기본키

-- 태그
ALTER TABLE `tags`
	DROP PRIMARY KEY; -- 태그 기본키

-- 리뷰
ALTER TABLE `Review`
	DROP PRIMARY KEY; -- 리뷰 기본키

-- 댓글
ALTER TABLE `Comment`
	DROP PRIMARY KEY; -- 댓글 기본키

-- 개인좋아요
ALTER TABLE `Likes`
	DROP PRIMARY KEY; -- 개인좋아요 기본키

-- 공지사항
ALTER TABLE `Notice`
	DROP PRIMARY KEY; -- 공지사항 기본키

-- 개인정보
ALTER TABLE `Members`
	DROP PRIMARY KEY; -- 개인정보 기본키

-- 계정
ALTER TABLE `User`
	DROP PRIMARY KEY; -- 계정 기본키

-- 기업
ALTER TABLE `Companys`
	DROP PRIMARY KEY; -- 기업 기본키

-- 이벤트주소
ALTER TABLE `Eve_addr`
	DROP PRIMARY KEY; -- 이벤트주소 기본키

-- 이벤트
ALTER TABLE `Event`
	DROP PRIMARY KEY; -- 이벤트 기본키

-- 문의센터
ALTER TABLE `Qna`
	DROP PRIMARY KEY; -- 문의센터 기본키

-- 매거진
ALTER TABLE `magazine`
	DROP PRIMARY KEY; -- 매거진 기본키

-- 상품랭킹
DROP TABLE IF EXISTS `Rank` RESTRICT;

-- 제품
DROP TABLE IF EXISTS `items` RESTRICT;

-- 태그
DROP TABLE IF EXISTS `tags` RESTRICT;

-- 리뷰
DROP TABLE IF EXISTS `Review` RESTRICT;

-- 댓글
DROP TABLE IF EXISTS `Comment` RESTRICT;

-- 개인좋아요
DROP TABLE IF EXISTS `Likes` RESTRICT;

-- 공지사항
DROP TABLE IF EXISTS `Notice` RESTRICT;

-- 개인정보
DROP TABLE IF EXISTS `Members` RESTRICT;

-- 계정
DROP TABLE IF EXISTS `User` RESTRICT;

-- 기업
DROP TABLE IF EXISTS `Companys` RESTRICT;

-- 이벤트주소
DROP TABLE IF EXISTS `Eve_addr` RESTRICT;

-- 이벤트
DROP TABLE IF EXISTS `Event` RESTRICT;

-- 문의센터
DROP TABLE IF EXISTS `Qna` RESTRICT;

-- 매거진
DROP TABLE IF EXISTS `magazine` RESTRICT;

-- 임시 테이블
DROP TABLE IF EXISTS `Temporary` RESTRICT;

-- 상품랭킹
CREATE TABLE `Rank` (
	`item`  INT NOT NULL COMMENT '상품코드', -- 상품코드
	`one`   INT NULL     DEFAULT 0 COMMENT '1점', -- 1점
	`two`   INT NULL     DEFAULT 0 COMMENT '2점', -- 2점
	`three` INT NULL     DEFAULT 0 COMMENT '3점', -- 3점
	`four`  INT NULL     DEFAULT 0 COMMENT '4점', -- 4점
	`five`  INT NULL     DEFAULT 0 COMMENT '5점' -- 5점
)
COMMENT '상품랭킹';

-- 상품랭킹
ALTER TABLE `Rank`
	ADD CONSTRAINT `PK_Rank` -- 상품랭킹 기본키
		PRIMARY KEY (
			`item` -- 상품코드
		);

-- 제품
CREATE TABLE `items` (
	`item`  INT         NOT NULL COMMENT '제품코드', -- 제품코드
	`name`  TEXT        NOT NULL COMMENT '제품명', -- 제품명
	`img`   TEXT        NOT NULL COMMENT '제품사진', -- 제품사진
	`brand` VARCHAR(10) NOT NULL COMMENT '브랜드', -- 브랜드
	`vol`   VARCHAR(30) NULL     DEFAULT 0 COMMENT '용량', -- 용량
	`price` INT         NULL     DEFAULT 0 COMMENT '가격', -- 가격
	`tot`   DOUBLE      NULL     DEFAULT 0 COMMENT '평점', -- 평점
	`oil`   INT         NULL     DEFAULT 0 COMMENT '지성용', -- 지성용
	`dry`   INT         NULL     DEFAULT 0 COMMENT '건성', -- 건성
	`sen`   INT         NULL     DEFAULT 0 COMMENT '민감성', -- 민감성
	`comp`  INT         NULL     COMMENT '기능성 성분', -- 기능성 성분
	`cate`  INT         NOT NULL COMMENT '카테고리', -- 카테고리
	`tags`  TEXT        NULL     COMMENT '해시태그', -- 해시태그
	`open`  TINYINT     NOT NULL DEFAULT 1 COMMENT '공개여부' -- 공개여부
)
COMMENT '제품';

-- 제품
ALTER TABLE `items`
	ADD CONSTRAINT `PK_items` -- 제품 기본키
		PRIMARY KEY (
			`item` -- 제품코드
		);

ALTER TABLE `items`
	MODIFY COLUMN `item` INT NOT NULL AUTO_INCREMENT COMMENT '제품코드';

ALTER TABLE `items`
	AUTO_INCREMENT = 0;

-- 태그
CREATE TABLE `tags` (
	`tag`   VARCHAR(20) NOT NULL COMMENT '태그내용', -- 태그내용
	`pop`   INT         NULL     COMMENT '인기도', -- 인기도
	`nalja` TIMESTAMP   NULL     DEFAULT CURRENT_TIMESTAMP COMMENT '갱신일'  -- 갱신일
		 COLUMN_FORMAT DEFAULT STORAGE DEFAULT,
	`cnt`   INT         NULL     DEFAULT 0 COMMENT '갱신횟수' -- 갱신횟수
)
COMMENT '태그';

-- 태그
ALTER TABLE `tags`
	ADD CONSTRAINT `PK_tags` -- 태그 기본키
		PRIMARY KEY (
			`tag` -- 태그내용
		);

-- 리뷰
CREATE TABLE `Review` (
	`rev_no` INT         NOT NULL COMMENT '글번호', -- 글번호
	`item`   INT         NOT NULL COMMENT '제품코드', -- 제품코드
	`img`    TEXT        NULL     COMMENT '사진', -- 사진
	`writer` VARCHAR(10) NOT NULL COMMENT '작성자', -- 작성자
	`good`   TEXT        NOT NULL COMMENT '좋은점', -- 좋은점
	`bad`    TEXT        NOT NULL COMMENT '나쁜점', -- 나쁜점
	`tip`    TEXT        NOT NULL COMMENT '꿀팁', -- 꿀팁
	`nalja`  TIMESTAMP   NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '작성일', -- 작성일
	`pop`    INT         NULL     COMMENT '좋아요', -- 좋아요
	`star`   INT         NOT NULL COMMENT '별점', -- 별점
	`open`   TINYINT     NOT NULL DEFAULT 1 COMMENT '공개여부' -- 공개여부
)
COMMENT '리뷰';

-- 리뷰
ALTER TABLE `Review`
	ADD CONSTRAINT `PK_Review` -- 리뷰 기본키
		PRIMARY KEY (
			`rev_no` -- 글번호
		);

ALTER TABLE `Review`
	MODIFY COLUMN `rev_no` INT NOT NULL AUTO_INCREMENT COMMENT '글번호';

ALTER TABLE `Review`
	AUTO_INCREMENT = 0;

-- 댓글
CREATE TABLE `Comment` (
	`co_no`   INT                            NOT NULL COMMENT '글번호', -- 글번호
	`writer`  VARCHAR(10)                    NOT NULL COMMENT '작성자', -- 작성자
	`email`   VARCHAR(100)                   NOT NULL COMMENT '이메일', -- 이메일
	`nalja`   TIMESTAMP                      NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '작성일', -- 작성일
	`content` TEXT                           NOT NULL COMMENT '내용', -- 내용
	`co_type` ENUM('매거진','리뷰','이벤트') NULL     COMMENT '타입값', -- 타입값
	`p_no`    INT                            NULL     COMMENT '부모시퀸스' -- 부모시퀸스
)
COMMENT '댓글';

-- 댓글
ALTER TABLE `Comment`
	ADD CONSTRAINT `PK_Comment` -- 댓글 기본키
		PRIMARY KEY (
			`co_no` -- 글번호
		);

ALTER TABLE `Comment`
	MODIFY COLUMN `co_no` INT NOT NULL AUTO_INCREMENT COMMENT '글번호';

ALTER TABLE `Comment`
	AUTO_INCREMENT = 0;

-- 개인좋아요
CREATE TABLE `Likes` (
	`like_no` INT                            NOT NULL COMMENT '글번호', -- 글번호
	`email`   VARCHAR(100)                   NOT NULL COMMENT '이메일', -- 이메일
	`nalja`   TIMESTAMP                      NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '좋아요날짜', -- 좋아요날짜
	`type`    ENUM('매거진','리뷰','이벤트') NULL     COMMENT '타입값', -- 타입값
	`p_no`    INT                            NULL     COMMENT '부모시퀀스' -- 부모시퀀스
)
COMMENT '개인좋아요';

-- 개인좋아요
ALTER TABLE `Likes`
	ADD CONSTRAINT `PK_Likes` -- 개인좋아요 기본키
		PRIMARY KEY (
			`like_no` -- 글번호
		);

ALTER TABLE `Likes`
	MODIFY COLUMN `like_no` INT NOT NULL AUTO_INCREMENT COMMENT '글번호';

ALTER TABLE `Likes`
	AUTO_INCREMENT = 0;

-- 공지사항
CREATE TABLE `Notice` (
	`no_no`   INT          NOT NULL COMMENT '글번호', -- 글번호
	`title`   VARCHAR(100) NOT NULL COMMENT '제목', -- 제목
	`content` TEXT         NULL     COMMENT '내용', -- 내용
	`nalja`   TIMESTAMP    NULL     DEFAULT Current_timestamp COMMENT '날짜' -- 날짜
)
COMMENT '공지사항';

-- 공지사항
ALTER TABLE `Notice`
	ADD CONSTRAINT `PK_Notice` -- 공지사항 기본키
		PRIMARY KEY (
			`no_no` -- 글번호
		);

ALTER TABLE `Notice`
	MODIFY COLUMN `no_no` INT NOT NULL AUTO_INCREMENT COMMENT '글번호';

ALTER TABLE `Notice`
	AUTO_INCREMENT = 0;

-- 개인정보
CREATE TABLE `Members` (
	`email`  VARCHAR(100)                 NOT NULL COMMENT '이메일', -- 이메일
	`nick`   VARCHAR(10)                  NOT NULL COMMENT '닉네임', -- 닉네임
	`gender` ENUM('남성','여성')          NOT NULL COMMENT '성별', -- 성별
	`age`    INT                          NOT NULL COMMENT '연령', -- 연령
	`skin`   ENUM('지성','건성','민감성') NOT NULL COMMENT '피부타입', -- 피부타입
	`phone`  VARCHAR(20)                  NOT NULL COMMENT '전화번호', -- 전화번호
	`cart`   TEXT                         NULL     COMMENT '찜목록', -- 찜목록
	`exp`    INT                          NULL     COMMENT '참여도점수', -- 참여도점수
	`nalja`  TIMESTAMP                    NOT NULL DEFAULT Current_timestamp COMMENT '회원가입 날짜' -- 회원가입 날짜
)
COMMENT '개인정보';

-- 개인정보
ALTER TABLE `Members`
	ADD CONSTRAINT `PK_Members` -- 개인정보 기본키
		PRIMARY KEY (
			`email` -- 이메일
		);

-- 계정
CREATE TABLE `User` (
	`email`      VARCHAR(100)                           NOT NULL COMMENT '이메일', -- 이메일
	`password`   TEXT                                   NULL     COMMENT '비밀번호', -- 비밀번호
	`user_type`  ENUM('CEO','광고주','직원','일반')     NOT NULL COMMENT '유형', -- 유형
	`join_route` SET('google','kakao','naver','normal') NOT NULL COMMENT '가입경로' -- 가입경로
)
COMMENT '계정';

-- 계정
ALTER TABLE `User`
	ADD CONSTRAINT `PK_User` -- 계정 기본키
		PRIMARY KEY (
			`email` -- 이메일
		);

-- 기업
CREATE TABLE `Companys` (
	`email`    VARCHAR(100) NOT NULL COMMENT '이메일', -- 이메일
	`company`  VARCHAR(100) NOT NULL COMMENT '기업이름', -- 기업이름
	`bisnum`   INT          NOT NULL COMMENT '사업자번호', -- 사업자번호
	`manager`  VARCHAR(20)  NOT NULL COMMENT '담당자', -- 담당자
	`postcode` INT          NOT NULL COMMENT '기업우편번호', -- 기업우편번호
	`address`  TEXT         NOT NULL COMMENT '기업주소', -- 기업주소
	`phone`    VARCHAR(20)  NOT NULL COMMENT '전화번호' -- 전화번호
)
COMMENT '기업';

-- 기업
ALTER TABLE `Companys`
	ADD CONSTRAINT `PK_Companys` -- 기업 기본키
		PRIMARY KEY (
			`email` -- 이메일
		);

-- 이벤트주소
CREATE TABLE `Eve_addr` (
	`add_no`   INT          NOT NULL COMMENT '글번호', -- 글번호
	`eve_no`   INT          NOT NULL COMMENT '이벤트번호', -- 이벤트번호
	`email`    VARCHAR(100) NOT NULL COMMENT '이메일', -- 이메일
	`name`     VARCHAR(5)   NOT NULL COMMENT '이름', -- 이름
	`address`  TEXT         NOT NULL COMMENT '주소', -- 주소
	`phone`    VARCHAR(20)  NOT NULL COMMENT '전화번호', -- 전화번호
	`postcode` INT          NOT NULL COMMENT '우편번호' -- 우편번호
)
COMMENT '이벤트주소';

-- 이벤트주소
ALTER TABLE `Eve_addr`
	ADD CONSTRAINT `PK_Eve_addr` -- 이벤트주소 기본키
		PRIMARY KEY (
			`add_no` -- 글번호
		);

ALTER TABLE `Eve_addr`
	MODIFY COLUMN `add_no` INT NOT NULL AUTO_INCREMENT COMMENT '글번호';

ALTER TABLE `Eve_addr`
	AUTO_INCREMENT = 0;

-- 이벤트
CREATE TABLE `Event` (
	`eve_no`    INT          NOT NULL COMMENT '글번호', -- 글번호
	`img`       TEXT         NOT NULL COMMENT '대표이미지', -- 대표이미지
	`title`     VARCHAR(100) NOT NULL COMMENT '제목', -- 제목
	`con`       TEXT         NOT NULL COMMENT '내용', -- 내용
	`com_email` VARCHAR(100) NULL     COMMENT '기업이메일', -- 기업이메일
	`nalja`     TIMESTAMP    NOT NULL DEFAULT current_timestamp COMMENT '글쓴날짜', -- 글쓴날짜
	`pop`       INT          NULL     DEFAULT 0 COMMENT '좋아요', -- 좋아요
	`view`      INT          NULL     DEFAULT 0 COMMENT '조회수', -- 조회수
	`open`      TINYINT      NOT NULL DEFAULT 1 COMMENT '공개여부' -- 공개여부
)
COMMENT '이벤트';

-- 이벤트
ALTER TABLE `Event`
	ADD CONSTRAINT `PK_Event` -- 이벤트 기본키
		PRIMARY KEY (
			`eve_no` -- 글번호
		);

ALTER TABLE `Event`
	MODIFY COLUMN `eve_no` INT NOT NULL AUTO_INCREMENT COMMENT '글번호';

ALTER TABLE `Event`
	AUTO_INCREMENT = 0;

-- 문의센터
CREATE TABLE `Qna` (
	`qa_no`   INT          NOT NULL COMMENT '글번호', -- 글번호
	`nalja`   TIMESTAMP    NOT NULL DEFAULT current_timestamp COMMENT '작성일', -- 작성일
	`con`     TEXT         NOT NULL COMMENT '내용', -- 내용
	`qa_type` INT          NOT NULL COMMENT '문의종류', -- 문의종류
	`email`   VARCHAR(100) NOT NULL COMMENT '답변 받을 이메일', -- 답변 받을 이메일
	`answer`  TEXT         NULL     COMMENT '답변' -- 답변
)
COMMENT '문의센터';

-- 문의센터
ALTER TABLE `Qna`
	ADD CONSTRAINT `PK_Qna` -- 문의센터 기본키
		PRIMARY KEY (
			`qa_no` -- 글번호
		);

ALTER TABLE `Qna`
	MODIFY COLUMN `qa_no` INT NOT NULL AUTO_INCREMENT COMMENT '글번호';

ALTER TABLE `Qna`
	AUTO_INCREMENT = 0;

-- 매거진
CREATE TABLE `magazine` (
	`mag_no`    INT          NOT NULL COMMENT '글번호', -- 글번호
	`img`       TEXT         NOT NULL COMMENT '대표이미지', -- 대표이미지
	`title`     VARCHAR(100) NOT NULL COMMENT '제목', -- 제목
	`con`       TEXT         NOT NULL COMMENT '내용', -- 내용
	`cate`      INT          NULL     COMMENT '카테고리', -- 카테고리
	`com_email` VARCHAR(100) NULL     COMMENT '기업이메일', -- 기업이메일
	`writer`    VARCHAR(10)  NOT NULL COMMENT '작성자', -- 작성자
	`nalja`     TIMESTAMP    NOT NULL DEFAULT current_timestamp COMMENT '작성일', -- 작성일
	`pop`       INT          NULL     DEFAULT 0 COMMENT '인기도', -- 인기도
	`view`      INT          NULL     DEFAULT 0 COMMENT '조회수', -- 조회수
	`open`      TINYINT      NOT NULL DEFAULT 1 COMMENT '공개여부' -- 공개여부
)
COMMENT '매거진';

-- 매거진
ALTER TABLE `magazine`
	ADD CONSTRAINT `PK_magazine` -- 매거진 기본키
		PRIMARY KEY (
			`mag_no` -- 글번호
		);

ALTER TABLE `magazine`
	MODIFY COLUMN `mag_no` INT NOT NULL AUTO_INCREMENT COMMENT '글번호';

ALTER TABLE `magazine`
	AUTO_INCREMENT = 0;

-- 임시 테이블
CREATE TABLE `Temporary` (
	`mag_no` INT NULL COMMENT '글번호' -- 글번호
)
COMMENT '임시 테이블';