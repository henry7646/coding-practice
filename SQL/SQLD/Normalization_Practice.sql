GRANT DBA TO seungjae_han;
CONNECT seungjae_han/#Scotch7646#;

-- Functional Dependency: (X->Y) <-> (Y functionally depends on X) <-> (If X changes, Y changes)
-- <-> (There exists 1:1 relation between X and Y)

-- 1st Normalization: Simply find primary keys (no duplication, no empty value, representativeness)

CREATE TABLE ord (
    ��ǰ��ȣ varchar2(4),
    �ֹ���ȣ varchar2(5),
    �ֹ����� number,
    CONSTRAINT ord_pk PRIMARY KEY (��ǰ��ȣ,�ֹ���ȣ)
);

INSERT INTO ord(��ǰ��ȣ,�ֹ���ȣ,�ֹ�����)
VALUES ('1001','AB345',150);
INSERT INTO ord(��ǰ��ȣ,�ֹ���ȣ,�ֹ�����)
VALUES ('1001','AD347',600);
INSERT INTO ord(��ǰ��ȣ,�ֹ���ȣ,�ֹ�����)
VALUES ('1007','CA210',1200);
INSERT INTO ord(��ǰ��ȣ,�ֹ���ȣ,�ֹ�����)
VALUES ('1007','AB345',300);
INSERT INTO ord(��ǰ��ȣ,�ֹ���ȣ,�ֹ�����)
VALUES ('1007','CB230',390);
INSERT INTO ord(��ǰ��ȣ,�ֹ���ȣ,�ֹ�����)
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
    ��ǰ��ȣ varchar2(4),
    ��ǰ�� varchar2(10),
    ������ number,
    CONSTRAINT prod_pk PRIMARY KEY (��ǰ��ȣ)
);

INSERT INTO prod (��ǰ��ȣ,��ǰ��,������)
VALUES ('1001','�����',1990);
INSERT INTO prod (��ǰ��ȣ,��ǰ��,������)
VALUES ('1007','���콺',9702);
INSERT INTO prod (��ǰ��ȣ,��ǰ��,������)
VALUES ('1201','����Ŀ',2108);

CREATE TABLE cust (
    �ֹ���ȣ varchar2(5),
    ���⿩�� varchar2(1),
    ����ȣ varchar2(4),
    ����ڹ�ȣ varchar2(6),
    �켱���� number,
    CONSTRAINT cust_pk PRIMARY KEY (�ֹ���ȣ)
);

INSERT INTO cust (�ֹ���ȣ,����ȣ,���⿩��,����ڹ�ȣ,�켱����)
VALUES ('AB345','4520','X','398201',1);
INSERT INTO cust (�ֹ���ȣ,����ȣ,���⿩��,����ڹ�ȣ,�켱����)
VALUES ('AD347','2341','Y',NULL,3);
INSERT INTO cust (�ֹ���ȣ,����ȣ,���⿩��,����ڹ�ȣ,�켱����)
VALUES ('CA210','3280','X','200212',8);
INSERT INTO cust (�ֹ���ȣ,����ȣ,���⿩��,����ڹ�ȣ,�켱����)
VALUES ('CB230','2341','X','563892',3);
INSERT INTO cust (�ֹ���ȣ,����ȣ,���⿩��,����ڹ�ȣ,�켱����)
VALUES ('CB231','8320','Y',NULL,2);

-- 3rd Normalization: Eliminate transitive functional dependency (=functional dependency between non-primary key columns)
--- Unnecessary for this example

-- Add foreign keys: prod and cust are strong entities, ord is a weak entity, prod and cust have no relation with with each other
ALTER TABLE ord
ADD CONSTRAINT ord_prod_fk FOREIGN KEY (��ǰ��ȣ) REFERENCES prod(��ǰ��ȣ)
ON DELETE CASCADE;

ALTER TABLE ord
ADD CONSTRAINT ord_cust_fk FOREIGN KEY (�ֹ���ȣ) REFERENCES cust(�ֹ���ȣ)
ON DELETE CASCADE;