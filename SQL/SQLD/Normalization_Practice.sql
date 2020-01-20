GRANT DBA TO seungjae_han;
CONNECT seungjae_han/#Scotch7646#;

-- Functional Dependency: (X->Y) <-> (Y functionally depends on X) <-> (If X changes, Y changes)
-- <-> (There exists 1:1 relation between X and Y)

-- 1st Normalization: Simply find primary keys (no duplication, no empty value, representativeness)

CREATE TABLE ord (
    제품번호 varchar2(4),
    주문번호 varchar2(5),
    주문수량 number,
    CONSTRAINT ord_pk PRIMARY KEY (제품번호,주문번호)
);

INSERT INTO ord(제품번호,주문번호,주문수량)
VALUES ('1001','AB345',150);
INSERT INTO ord(제품번호,주문번호,주문수량)
VALUES ('1001','AD347',600);
INSERT INTO ord(제품번호,주문번호,주문수량)
VALUES ('1007','CA210',1200);
INSERT INTO ord(제품번호,주문번호,주문수량)
VALUES ('1007','AB345',300);
INSERT INTO ord(제품번호,주문번호,주문수량)
VALUES ('1007','CB230',390);
INSERT INTO ord(제품번호,주문번호,주문수량)
VALUES ('1201','CB231',80);

-- 2nd Normalization: Eliminate partial functional dependency (only when there are more than one primary keys)
--- Step 1: Check if any one of the non-primary key columns functionally depend on 
--- any one of the primary keys. Combine and separate that primary key and columns as a single table.

--- Step 2: Check if any one of the non-primary key columns functionally depend on
--- the remaining primary key. Combine and separate that primary key and columns as a single table.

--- Step 3: If none of the non-primary key columns functionally depend on
--- any one of the primary keys from Step 1 and Step 2, check if any of the rows duplicate
--- with each other column by column for each primary key. Combine and separate that primary key 
--- and columns as a single table.

--- Step 4: Back from the original table, eliminate all the columns included in the tables created from
--- Step 1, Step 2, and Step 3.

CREATE TABLE prod (
    제품번호 varchar2(4),
    제품명 varchar2(10),
    재고수량 number,
    CONSTRAINT prod_pk PRIMARY KEY (제품번호)
);

INSERT INTO prod (제품번호,제품명,재고수량)
VALUES ('1001','모니터',1990);
INSERT INTO prod (제품번호,제품명,재고수량)
VALUES ('1007','마우스',9702);
INSERT INTO prod (제품번호,제품명,재고수량)
VALUES ('1201','스피커',2108);

CREATE TABLE cust (
    주문번호 varchar2(5),
    수출여부 varchar2(1),
    고객번호 varchar2(4),
    사업자번호 varchar2(6),
    우선순위 number,
    CONSTRAINT cust_pk PRIMARY KEY (주문번호)
);

INSERT INTO cust (주문번호,고객번호,수출여부,사업자번호,우선순위)
VALUES ('AB345','4520','X','398201',1);
INSERT INTO cust (주문번호,고객번호,수출여부,사업자번호,우선순위)
VALUES ('AD347','2341','Y',NULL,3);
INSERT INTO cust (주문번호,고객번호,수출여부,사업자번호,우선순위)
VALUES ('CA210','3280','X','200212',8);
INSERT INTO cust (주문번호,고객번호,수출여부,사업자번호,우선순위)
VALUES ('CB230','2341','X','563892',3);
INSERT INTO cust (주문번호,고객번호,수출여부,사업자번호,우선순위)
VALUES ('CB231','8320','Y',NULL,2);

-- 3rd Normalization: Eliminate transitive functional dependency (=functional dependency between non-primary key columns)
--- Unnecessary for this example

-- Add foreign keys: prod and cust are strong entities, ord is a weak entity, prod and cust have no relation with with each other
ALTER TABLE ord
ADD CONSTRAINT ord_prod_fk FOREIGN KEY (제품번호) REFERENCES prod(제품번호)
ON DELETE CASCADE;

ALTER TABLE ord
ADD CONSTRAINT ord_cust_fk FOREIGN KEY (주문번호) REFERENCES cust(주문번호)
ON DELETE CASCADE;