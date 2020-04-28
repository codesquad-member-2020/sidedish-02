DROP TABLE IF EXISTS image;
DROP TABLE IF EXISTS banchan_delivery;
DROP TABLE IF EXISTS delivery;
DROP TABLE IF EXISTS banchan_discount;
DROP TABLE IF EXISTS discount;
DROP TABLE IF EXISTS banchan;
DROP TABLE IF EXISTS category;

CREATE TABLE IF NOT EXISTS category
(
    path        VARCHAR(32),  -- main
    name        VARCHAR(32),  -- 메인반찬
    description VARCHAR(128), -- 한그릇 뚝딱 메인 요리
    PRIMARY KEY (path)
);

CREATE TABLE IF NOT EXISTS banchan
(
    id          VARCHAR(5),   -- HBDEF
    title       VARCHAR(128), -- [미노리키친] 규동 250g
    description VARCHAR(128), -- 일본인의 소울푸드! 한국인도 좋아하는 소고기덮밥
    price       INT,          -- 7000
    category    VARCHAR(32),  -- 메인반찬
    PRIMARY KEY (id),
    FOREIGN KEY (category) REFERENCES category (path)
);

CREATE TABLE IF NOT EXISTS delivery
(
    name VARCHAR(32),  -- 새벽배송
    info VARCHAR(128), -- 서울 경기 새벽배송
    fee  VARCHAR(128), -- 2,500원 (40,000원 이상 구매 시 무료)
    PRIMARY KEY (name)
);

CREATE TABLE IF NOT EXISTS banchan_delivery -- associative table
(
    id       INT AUTO_INCREMENT,
    banchan  VARCHAR(5),
    delivery VARCHAR(32),
    PRIMARY KEY (id),
    FOREIGN KEY (banchan) REFERENCES banchan (id),
    FOREIGN KEY (delivery) REFERENCES delivery (name)
);

CREATE TABLE IF NOT EXISTS discount
(
    name VARCHAR(32), -- 이벤트특가
    rate FLOAT(3, 2), -- 0.05
    PRIMARY KEY (name)
);

CREATE TABLE IF NOT EXISTS banchan_discount -- associative table
(
    id       INT AUTO_INCREMENT,
    banchan  VARCHAR(5),
    discount VARCHAR(32),
    PRIMARY KEY (id),
    FOREIGN KEY (banchan) REFERENCES banchan (id),
    FOREIGN KEY (discount) REFERENCES discount (name)
);

CREATE TABLE IF NOT EXISTS image
(
    id                 INT AUTO_INCREMENT,
    url                VARCHAR(256),
    banchan            VARCHAR(5),
    is_summary_image   BOOLEAN,
    is_top_image       BOOLEAN,
    is_thumb_image     BOOLEAN,
    thumb_image_index  INT,
    is_detail_image    BOOLEAN,
    detail_image_index INT,
    PRIMARY KEY (id),
    FOREIGN KEY (banchan) REFERENCES banchan (id)
);

