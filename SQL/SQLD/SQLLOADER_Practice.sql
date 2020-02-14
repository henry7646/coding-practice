/*SQL*LOADER ����ؼ� �ܺ� ������ (csv ����)�� ORACLE DB�� ȣ�� �� ���� (import)�� �� ����*/
/*github.com/henry7646/coding-practice/tree/master/SQL/How%20to%20Import%20CSV%20Files%20into%20Oracle%20DB.txt
 ����*/
/*�� �������� ����� �ܺ� ������: github.com/henry7646/coding-practice/tree/master/SQL/SQLD/�ֹ���ȣ.csv*/
 
/*1. �ܺ� �����͸� import��ų ���̺� ����*/
TRUNCATE TABLE deliveryinfo;
DROP TABLE deliveryinfo;
CREATE TABLE deliveryinfo(
deliveryid number(20) primary key,
customerid number(20),
deliverydate timestamp,
deliveryamount number(20));
 
/*2. �ܺ� ������ import�ϴµ� �ʿ��� ��Ʈ�� ���� ���� (�޸��忡 �Ʒ� �ڵ� ���� �� ���� �� Ÿ�� '��� ����' ���� �� Ȯ���� '.ctl'�� �� ��)
load data
truncate into table deliveryinfo
fields terminated by ","
trailing nullcols
(deliveryid, customerid, deliverydate, deliveryamount)

3. cmd���� SQL*LOADER ���� (cmdâ�� �Ʒ� �ڵ� ���� �� ����)
sqlldr [Oracle DB username]/[Oracle DB password] data='[�ܺε����� ���� ���]' control='[��Ʈ�� ���� ���� ���]' bad='[bad ���� ���� ���]' discard='[discard ���� ���� ���]' log='[�α� ���� ���� ���]'
* ����� bad ������ Ȯ���ڴ� .bad, discard ������ Ȯ���ڴ� .dsc, �α� ������ Ȯ���ڴ� .txt��

4. �ܺ� ������ ���������� import�Ǿ����� SELECT������ Ȯ��*/
SELECT * FROM deliveryinfo;

/* ��Ʈ�� ������ �� ������ �ٿ� �ܺ� �����͸� import��ų ���̺��� Į������ �����µ�, Į������ ���� ����� �ؾ� ���� SQL*LOADER ���� �� ���� (SQL*Loader-350)�� ���� ����
* �ѱ��� ���Ե� ��Ī�� ���� �ܺ� �������� ��� ��Ʈ�� ���Ͽ��� 'infile '[�ܺ� ������ ���� ���]''�� �����ϸ� ���� SQL*LOADER ���� �� ���� (Cannot Find the File) �߻��ϹǷ� SQL*LOADER ���� ��
cmdâ�� 'data = '[�ܺ� ������ ���� ���]'' ������ ��
* SQL*LOADER�� �ܺ� ������ import �� �ѱ� ���� �� ���ڼ� (NLS_CHARACTERSET) �����ϴ� ���: https://blog.naver.com/intropp/10028768224
* ���ڼ� (NLS_CHARACTERSET) ���� ��  ORA-06552,  ORA-06553 ���� �߻� �� �ذ��ϴ� ���: https://jehna.tistory.com/36 */