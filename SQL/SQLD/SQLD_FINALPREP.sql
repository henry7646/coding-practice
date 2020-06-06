-- DDL--

-- CREATE(DDL), INSERT(DML) --
CREATE TABLE ��
(��ID VARCHAR(10) PRIMARY KEY,
���� VARCHAR(20) NOT NULL,
������� DATE DEFAULT SYSDATE);

CREATE TABLE ����
(���¹�ȣ VARCHAR(20) PRIMARY KEY,
��ID VARCHAR(10),
���� VARCHAR(10) NOT NULL,
������ NUMBER(10,2) DEFAULT 0,
CONSTRAINT acpk FOREIGN KEY (��ID) REFERENCES ��(��ID)
ON DELETE CASCADE); /*REFERENTIAL ACTION: MASTER ������ ���� �� CHILD �����͵� ����*/
/*������ MASTER TABLE���� ������ ������ ���� ����: ���� ���Ἲ (MASTER�� ���� �����ʹ� CHILD���� ����� ��) ���� ����*/

INSERT INTO ��(��ID,����,�������)
VALUES('0000','�ѽ���','1994-04-08');
INSERT INTO ��(��ID,����)
VALUES('0001','�ѽ���');
INSERT INTO ��(��ID,����,�������)
VALUES('0002','������','1959-10-26');

INSERT INTO ����(���¹�ȣ,��ID,����)
VALUES('110-360-167025','0001','������');
INSERT INTO ����
VALUES('123-456-789000','0000','�ϰ���',10000000.00);

---- REFERENTIAL ACTION ----
----- DELETE -----
ALTER TABLE ����
DROP CONSTRAINT acpk;

ALTER TABLE ����
ADD CONSTRAINT acpk FOREIGN KEY (��ID) REFERENCES ��(��ID)
ON DELETE SET NULL;

DELETE FROM ��
WHERE ��ID = '0001'; /*ON DELETE SET NULL: MASTER���� ������ ���� �� CHILD�� �ش� �ʵ尪�� NULL�� ����
ON DELETE SET DEFAULT: MASTER���� ������ ���� �� CHILD�� �ش� �ʵ尪�� DEFAULT������ ����*/

-- ����ȯ --
SELECT * FROM ��
WHERE ��ID = 0000; /*ORACLE���� �ڵ����� �Ͻ��� ����ȯ ����. ��, ��ID�� �ε����� Ȱ���ϰ��� �� ��� �Ͻ��� ����ȯ �ﰡ��*/

SELECT * FROM ��
WHERE ������� = '1994-04-08';

SELECT * FROM ��
WHERE TO_CHAR(�������,'YY/MM/DD') = '94/04/08';

SELECT * FROM ��
WHERE ������� = TO_DATE('1994-04-08','YY/MM/DD');

SELECT * FROM ����;
--ALTER--
---- ADD ----
ALTER TABLE ��
ADD (���� VARCHAR(10));

UPDATE ��
SET ���� = '��'
WHERE ��ID IN (0000,0002);

---- RENAME ----
RENAME �� TO ���; /*���̺� RENAME ���(1): ANSI ǥ�� (ORACLE, SQL SERVER ����)*/

ALTER TABLE ���
RENAME COLUMN ���� TO �����; /*Į�� RENAME ���: ALTER TABLE [���̺��] RENAME COLUMN [���� Į����] TO [�� Į����];*/

ALTER TABLE ���
RENAME TO ��; /*���̺� RENAME ���(2): ORACLE������ (ALTER TABLE [���̺��] RENAME TO [�� ���̺��];)*/
---- DROP ----
DROP TABLE ��
CASCADE CONSTRAINTS; /*���̺� DROP ���: DROP TABLE [���̺��]*/
/*���̺� DROP �� PK�� �ٸ� ���̺��� FK�� ������ ���̺��� ���� ���Ἲ ������ DROP�� �ȵ�: �̸� ���� ����
DROP TABLE [���̺��] CASCADE CONSTRAINTS; ����*/

ALTER TABLE ����
DROP COLUMN ������; /*Į�� DROP ���: ALTER TABLE [���̺��] DROP COLUMN [Į����]*/

/*Į�� ���� �� ��ɾ� �ڿ� �ݵ�� COLUMN �����ؾ� �ϴ� ��ɾ��: DROP, RENAME*/

DROP TABLE ����;

-- DML --
---- SELECT -----
SELECT * FROM EMP;

SELECT empno,ename,sal,deptno FROM EMP;
----- ������ -----
SELECT empno,ename,sal FROM EMP
WHERE sal BETWEEN 1000 AND 2500;

SELECT empno,ename,sal FROM EMP
WHERE sal >= 1000 AND sal <= 2500;

SELECT empno,ename,sal,deptno FROM EMP
WHERE deptno NOT IN (1001,1002)
AND sal >= 1500
OR deptno = 1001; /*WHERE ���ǹ� ���� ����: NOT->AND->OR*/

----- LIKE��(���ϵ�ī��) -----
SELECT empno,ename FROM EMP
WHERE ename LIKE '%��'; /*LIKE��: ���ϵ�ī�� ����� ���ڿ��� ������ ��ȸ �� ���
%[����]: ���ڿ��� [����]�� ������ �� ��ȸ
[����]%: ���ڿ��� [����]�� �����ϴ� �� ��ȸ
%[����]%: ���ڿ� ���� [����]�� ���� �� ��ȸ
_[����]: [����] �տ� �� ���ڰ� ���� �� ��ȸ
[����]_: [����] �ڿ� �� ���ڰ� ���� �� ��ȸ*/

SELECT empno,ename FROM EMP
WHERE ename LIKE '��%';

SELECT empno,ename FROM EMP
WHERE ename LIKE '%��%';

SELECT empno,ename FROM EMP
WHERE ename LIKE '��___';

----- NULL ���� �Լ� -----
CREATE TABLE �ֹ�
(�ֹ�ID VARCHAR(20),
��ID VARCHAR(20),
����ID VARCHAR(20),
���Ǽ��� NUMBER(10,0),
CONSTRAINT ordpk PRIMARY KEY (��ID));

INSERT INTO �ֹ�(��ID,�ֹ�ID,����ID,���Ǽ���)
VALUES('000','100-001','','');
INSERT INTO �ֹ�(��ID,�ֹ�ID,����ID,���Ǽ���)
VALUES('001','100-002','1000','40');
INSERT INTO �ֹ�(��ID,�ֹ�ID,����ID,���Ǽ���)
VALUES('002','100-003','','');
INSERT INTO �ֹ�(��ID,�ֹ�ID,����ID,���Ǽ���)
VALUES('003','100-004','2000','43');
INSERT INTO �ֹ�(��ID,�ֹ�ID,����ID,���Ǽ���)
VALUES('004','100-005','','');
INSERT INTO �ֹ�(��ID,�ֹ�ID,����ID,���Ǽ���)
VALUES('005','100-006','3000','47');

SELECT * FROM �ֹ�;

SELECT * FROM �ֹ�
WHERE ����ID IS NULL;

SELECT ��ID,NVL(����ID,'NONE') AS ����ID,NVL(���Ǽ���,0) AS ���Ǽ���
FROM �ֹ�; /*NVL([Į��],[��ü��]):[Į��] �� NULL���� �͵��� [��ü��]���� �ٲپ ��ȸ*/

SELECT ��ID,NVL2(����ID,'����','����') AS ��������
FROM �ֹ�; /*NVL2([Į��],[��1],[��2]): [Į��] �� NULL���� �͵��� [��2], NULL���� �ƴ� �͵��� [��1]�� �ٲ㼭 ��ȸ*/

SELECT ��ID,NULLIF(���Ǽ���,40) AS ���Ǽ���_40�̻�
FROM �ֹ�; /*NULLIF([��1],[��2]): [��1]�� [��2]�� ������ NULL, �ٸ��� [��1]�� ��ȸ*/

SELECT ��ID,COALESCE(����ID,'����') AS ����ID
FROM �ֹ�; /*COALESCE([��1],[��2],...): NULL�� �ƴ� ù��° ��
COALESCE([Į��],[��]): [Į��]�� NULL�̸� [��]�� ��ȸ*/

----- GROUP BY -----
SELECT a.deptno,a.deptname,SUM(b.sal) AS �ѱ޿�
FROM DEPT a LEFT OUTER JOIN EMP b
ON a.deptno = b.deptno
GROUP BY a.deptno,a.deptname /*�����Լ�(COUNT,SUM,MAX,MIN,AVG,STDDEV,VARIANCE) ���� �׻� GROUP BY�� ���� ������ ��������� �ϰ�, HAVING���� �����Լ��� ������ �� �� ����*/
HAVING SUM(b.sal) >= 1500
ORDER BY deptno; /*SELECT�� ���� ����: FROM->WHERE->GROUP BY->HAVING->SELECT->ORDER BY*/
/*GROUPING �Ӽ��� �׻� SELECT������ ��ȸ�ϴ� Į��(�����ϴ� Į�� ����) ���ο���*/
/*SUM([Į��]) = SUM(NVL([Į��],0)): SUM �Լ��� Į�� �� NULL���� ������ ���� �հ�*/

SELECT a.deptno,a.deptname,MAX(b.sal) AS �ְ�޿�
FROM DEPT a LEFT OUTER JOIN EMP b
ON a.deptno = b.deptno
GROUP BY a.deptno,a.deptname
ORDER BY deptno; /*MAX �Լ��� Į�� �� NULL���� ������ �ִ��� ���*/

SELECT a.deptno,a.deptname,MIN(b.sal) AS �����޿�
FROM DEPT a LEFT OUTER JOIN EMP b
ON a.deptno = b.deptno
GROUP BY a.deptno,a.deptname
ORDER BY deptno; /*MIN �Լ��� Į�� �� NULL���� ������ �ּڰ��� ���*/

SELECT a.deptno,a.deptname,STDDEV(b.sal) AS �޿�ǥ������
FROM DEPT a LEFT OUTER JOIN EMP b
ON a.deptno = b.deptno
GROUP BY a.deptno,a.deptname
ORDER BY deptno;

SELECT a.deptno,a.deptname,VARIANCE(b.sal) AS �޿��л�
FROM DEPT a LEFT OUTER JOIN EMP b
ON a.deptno = b.deptno
GROUP BY a.deptno,a.deptname
ORDER BY deptno;

SELECT a.deptno,a.deptname,AVG(b.sal) AS ��ձ޿�
FROM DEPT a LEFT OUTER JOIN EMP b
ON a.deptno = b.deptno
GROUP BY a.deptno,a.deptname
ORDER BY deptno;

SELECT a.deptno,a.deptname,COUNT(b.empno) AS �����
FROM DEPT a LEFT OUTER JOIN EMP b
ON a.deptno = b.deptno
GROUP BY a.deptno,a.deptname
ORDER BY deptno;

SELECT DEPTNO,SUM(SAL) AS �޿��հ� FROM ���
WHERE EMPNO BETWEEN 1000 AND 1003
GROUP BY DEPTNO;

/*�����Լ��� NULL���� ���� �� NULL�� �����ϰ� �����Ѵ�!!!!!!*/

----- ������ �Լ� -----
----- ���� -----
SELECT ASCII('A'),
ASCII('a'),
ASCII(' '),
CHR(65),
CHR(97),
CHR(32),
CHR(10),
SUBSTR('QWERTYASCG',3,4),
LOWER('QWERTYASCG'),
LENGTH('   qwerty   '),
LTRIM('   qwerty   '),
RTRIM('   qwerty   '),
TRIM('   qwerty   '),
UPPER('   qwerty   ')
FROM DUAL;

SELECT CHR(65)||CHR(32)||CHR(97)||CHR(10)||CHR(13)||CHR(66)||CHR(32)||CHR(98)
FROM DUAL;
/*�����:
A a
B b*/

----- ���� -----
SELECT ABS(-105.1213141516),
SIGN(-105.1213141516),
MOD(-105.1213141516,4),
CEIL(-105.1213141516),
FLOOR(-105.1213141516),
ROUND(-105.1213141516),
ROUND(-105.1213141516,0),
ROUND(-105.1213141516,1),
ROUND(-105.1213141516,-1),
TRUNC(-105.1213141516),
TRUNC(-105.1213141516,0),
TRUNC(-105.1213141516,1),
TRUNC(-105.1213141516,-1)
FROM DUAL;

----- ��¥ -----
SELECT SYSDATE,
SYSTIMESTAMP,
TO_CHAR(SYSDATE,'YYYYMMDD'),
TO_CHAR(SYSTIMESTAMP, 'YYYYMMDDHHMMSS'),
EXTRACT(MONTH FROM SYSDATE),
EXTRACT(YEAR FROM SYSTIMESTAMP)
FROM DUAL;

----- DECODE -----
SELECT * FROM ���;

SELECT EMPNO,DECODE(JOB,'CLERK',1) �������,DECODE(JOB,'SALESMAN',1) �Ǹſ�����,DECODE(JOB,'MANAGER',1) �Ŵ�������,DECODE(JOB,'ANALYST',1) �м�������
FROM ���;

SELECT EMPNO,DECODE(JOB,'CLERK',1,0) �������,DECODE(JOB,'SALESMAN',1,0) �Ǹſ�����,DECODE(JOB,'MANAGER',1,0) �Ŵ�������,DECODE(JOB,'ANALYST',1,0) �м�������
FROM ���;

SELECT SUM(DECODE(JOB,'CLERK',1)) AS �����,
SUM(DECODE(JOB,'SALESMAN',1)) AS �Ǹſ���,
SUM(DECODE(JOB,'MANAGER',1)) AS �Ŵ�����,
SUM(DECODE(JOB,'ANALYST',1)) AS �м�����
FROM ���; /*���߰� �Ӽ��� ��� sum�� decode�� �� ���� �ϳ��� Į������ �и��� �� ���� ���� �ν��Ͻ��� ���� ������ ������ �� ����*/

SELECT JOB,COUNT(JOB) ������ FROM ���
GROUP BY JOB; /*�� ���̺��� �ǹ� ����*/

SELECT EMPNO,DECODE(JOB,'CLERK',DECODE(DEPTNO,'30','Y','N'),'N') �μ�30�Ҽ�_�������
FROM ���; /*DECODE�� �ȿ� DECODE�� ��ø ����*/

----- CASE -----
SELECT EMPNO,
CASE WHEN JOB = 'CLERK' THEN 'C'
WHEN JOB = 'SALESMAN' THEN 'S'
WHEN JOB = 'MANAGER' THEN 'M'
WHEN JOB = 'ANALYST' THEN 'A'
ELSE 'OT'
END
AS ����
FROM ���;/*Searched case expression: ���Ǻ��� �񱳿����� �����ϴ� CASE ����*/

SELECT EMPNO,
CASE JOB WHEN 'CLERK' THEN 'C'
WHEN 'SALESMAN' THEN 'S'
WHEN 'MANAGER' THEN 'M'
WHEN 'ANALYST' THEN 'A'
ELSE 'OT'
END
AS ����
FROM ���;/*Single case expression: ���� Į�� �ϳ��� ������Ű�� �񱳿����� �����ϴ� CASE ����*/
/*Searched case expression�� ���� �� ������ ������ ����� �񱳿��� ������ �����ϴٴ� ������ �ִ�*/

----- ROWNUM -----
SELECT * FROM ���
WHERE ROWNUM <= 1;

SELECT * FROM ���
WHERE ROWNUM = 2; /*������� ����: INLINE VIEW ����ؾ�*/

SELECT * FROM
(SELECT ROWNUM ��ȣ,EMPNO
FROM ���)
WHERE ��ȣ BETWEEN 5 AND 10;

SELECT * FROM
(SELECT ROWNUM ��ȣ,EMPNO
FROM ���)
WHERE ��ȣ = 10;

----- ROWID -----
SELECT ROWID,EMPNO
FROM ���;

-- TCL --
SHOW AUTOCOMMIT;
SET AUTOCOMMIT ON;/*AUTOCOMMIT:SQL(DML) Ʈ������� ������ ������ �ڵ����� COMMIT*/

CREATE TABLE ENT(
id VARCHAR(4),
name VARCHAR(15)); /*CREATE,ALTER,DROP,RENAME ���� DDL�� ���� AUTOCOMMIT�� �Ǳ� ������ ROLLBACK ������ �Ұ���*/

INSERT INTO ENT
VALUES('0001','�Ͻ���');
INSERT INTO ENT
VALUES('0002','����ö');
SELECT * FROM ENT;
ROLLBACK;
SELECT * FROM ENT; /*ENT�� �Է��� ���� ROLLBACK�� ������������ �ұ��ϰ� ������� ����: AUTOCOMMIT�� ������ױ� ������*/

SET AUTOCOMMIT OFF; /*AUTOCOMMIT ��� ��*/
SHOW AUTOCOMMIT;

UPDATE EMP
SET SAL = 1000
WHERE SAL = 500;
COMMIT;
INSERT INTO EMP(EMPNO,ENAME,SAL,DEPTNO)
VALUES('105','������',3000,'1004');
SAVEPOINT SVT1; /*SQLSERVER������ SAVE TRANSACTION SVT1*/
DELETE FROM EMP
WHERE EMPNO = '105';
SAVEPOINT SVT2;
ROLLBACK TO SVT1; /*SQLSERVER������ ROLLBACK TRANSACTION SVT1*/
/*�׳� ROLLBACK �� COMMIT�� �������� ���ư�, ROLLBACK TO [SAVEPOINT] �� [SAVEPOINT]���� ���ư�*/

-- JOIN --
---- INNER JOIN ----
SELECT b.empno,a.deptno,a.deptname
FROM DEPT a INNER JOIN EMP b
ON a.deptno = b.deptno
ORDER BY empno;

SELECT b.empno,a.deptno,a.deptname
FROM DEPT a, EMP b
WHERE a.deptno = b.deptno
ORDER BY empno;

SELECT empno,deptno,deptname
FROM DEPT NATURAL JOIN EMP
ORDER BY empno;

SELECT empno,deptno,deptname
FROM DEPT INNER JOIN EMP
USING (deptno)
ORDER BY empno;

---- OUTER JOIN ----
SELECT a.deptno,a.deptname,SUM(b.sal) AS �ѱ޿�
FROM DEPT a LEFT OUTER JOIN EMP b
ON a.deptno = b.deptno
GROUP BY a.deptno,a.deptname
ORDER BY deptno

SELECT a.deptno,a.deptname,SUM(b.sal) AS �ѱ޿�
FROM DEPT a, EMP b
WHERE a.deptno = b.deptno (+)
GROUP BY a.deptno,a.deptname
ORDER BY deptno; /*ORACLE������ WHERE�� �� OUTER JOIN���� �������� ���� �ʴ� ���̺��� Į�� ���� (+)�� ��ġ�Ͽ� OUTER JOIN�� ������ ȿ���� �� �� �ִ�*/

---- CROSS JOIN ----
SELECT * FROM
DEPT CROSS JOIN EMP; /*�� ���̺��� ī�׽þ� �� ���*/

---- JOIN �̿��� ���� ���� ----
SELECT empno a,ename b,sal c,deptno d,createdate e FROM emp
UNION
SELECT empno aa,ename bb,sal cc,deptno dd,createdate ee FROM emp;

SELECT empno a,ename b,sal c,deptno d,createdate e FROM emp
UNION ALL
SELECT empno aa,ename bb,sal cc,deptno dd,createdate ee FROM emp;

SELECT empno a,ename b,sal c,deptno d,createdate e FROM emp
INTERSECT
SELECT empno aa,ename bb,sal cc,deptno dd,createdate ee FROM emp;

SELECT empno a,ename b,sal c,deptno d,createdate e FROM emp
MINUS
SELECT empno aa,ename bb,sal cc,deptno dd,createdate ee FROM emp;

-- GROUP FUNCTION --
---- ROLLUP: ������ Į������ �Ұ�(SUBTOTAL)�� �Ѱ踦 �Բ� �����ش� ----
SELECT * FROM ���;

SELECT deptno �μ�,SUM(SAL) �ѱ޿�
FROM ���
GROUP BY deptno
ORDER BY deptno;

SELECT DECODE(deptno,NULL,'��ü�հ�',deptno) �μ�, SUM(SAL) �ѱ޿�
FROM ���
GROUP BY ROLLUP(deptno); /*�μ��� �޿� �հ�� �ѱ޿�*/

SELECT DECODE(GROUPING(deptno),1,'��ü�հ�',deptno) �μ�, SUM(sal) �ѱ޿�
FROM ���
GROUP BY ROLLUP(deptno); /*�� SQL���� ��� ����: GROUPING�� ���ؼ��� ---- GROUPING ---- ����*/

SELECT deptno �μ�, job ����, SUM(SAL) �ѱ޿�
FROM ���
GROUP BY ROLLUP(deptno,job); /*�μ���.������ �޿� �հ�, �μ��� �޿� �հ�, �ѱ޿�*/

SELECT DECODE(GROUPING(deptno),1,'��ü�հ�',deptno) �μ�,DECODE(GROUPING(job),1,'�μ��հ�',job) ����,DECODE(GROUPING(mgr),1,'�μ�.���� �հ�',mgr) ������,SUM(sal) �ѱ޿�
FROM ���
GROUP BY ROLLUP(deptno,job,mgr); /*�μ���.������.�����ں� �޿� �հ�, �μ���.������ �޿��հ�, �μ��� �޿��հ�, �ѱ޿�
ROLLUP �Լ��� GROUPING Į�� ���� N�̸� ����ϴ� �հ��� ���� ���� N+1*/

---- GROUPING: GROUP �Լ� ���� �� � Į���� ��� �Ұ踦 ���ߴ���(1) �ƴ���(0)�� ��Ÿ���� ������ �Լ� ----
SELECT deptno �μ�, GROUPING(deptno), job ����, GROUPING(job), SUM(sal) �ѱ޿�
FROM ���
GROUP BY ROLLUP(deptno,job);

SELECT deptno �μ�, DECODE(GROUPING(deptno),1,'��ü�հ�') TOTAL, job ����, DECODE(GROUPING(job),1,'�μ����Ұ�') JOB_TOTAL, SUM(sal) �ѱ޿�
FROM ���
GROUP BY ROLLUP(deptno,job); /*DECODE�� ��ü�հ�� �μ��� �հ� �����ϴ� �Լ� ����*/

SELECT DECODE(GROUPING(deptno),1,'��ü�հ�',deptno) �μ�, DECODE(GROUPING(job),1,'�μ��հ�',job) ����, SUM(sal) �ѱ޿�
FROM ���
GROUP BY ROLLUP(deptno,job); /*DECODE�� ��ü�հ�� �μ��� �հ� �����ϴ� �Լ� ����*/

---- GROUPING SETS: ������ �Ӽ����� �Ұ� ���ϰ�, �� �Ӽ� ��ο� ���� �Ұ�� �Ѱ�� ������ ���� ----
SELECT deptno �μ�, job ����, SUM(sal) �ѱ޿�
FROM ���
GROUP BY GROUPING SETS(deptno,job);

---- CUBE: ������ �Ӽ��鿡 ���� ���� �� �ִ� ��� ������ �Ұ�� �Ѱ踦 ���� ----
SELECT deptno �μ�, job ����, SUM(sal) �ѱ޿�
FROM ���
GROUP BY CUBE(deptno,job);

-- Window Function --
---- AGGREGATE FUNCTION ----
SELECT * FROM ���
ORDER BY sal;

SELECT empno,ename,SUM(sal) OVER (ORDER BY sal
ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) �޿��հ�
FROM ���; /*�޿������� ��� ���� �� �� �޿��հ� ����*/

/*SELECT WINDOW_FUNCTION([COLUMN])
OVER(PARTITION BY [PARTITIONING_COLUMN]
ORDER BY [ORDERING_COLUMN]
[ROWS/RANGE] BETWEEN [UNBOUNDED PRECEDING/CURRENT ROW] AND UNBOUNDED FOLLOWING)
FROM [TABLE];
PARTITION BY - ������ �Լ��� �����ϰ� ���� ���� Į��(��Ƽ��) ����
ORDER BY - �� ��Ƽ�� ������ �� ���� ���� ����
UNBOUNDED PRECEDING - ��Ƽ�� �� ù ��
UNBOUNED FOLLOWING - ��Ƽ�� �� ������ ��
CURRENT ROW - ���� ��*/

SELECT empno,ename,SUM(sal) OVER (ORDER BY sal
ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) �����޿��հ�
FROM ���; /*������� �޿������� ���� �� �� �ึ�� �����޿��հ� ����*/

SELECT empno,ename,SUM(sal) OVER (ORDER BY sal
ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING) �������޿��հ�
FROM ���; /*������� �޿������� ���� �� �����޿��հ迡�� �� ���� �޿� ����*/

SELECT empno,ename,deptno,SUM(sal) OVER(PARTITION BY deptno
ORDER BY sal ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) �μ��������޿�
FROM ���; /*������� �μ����� ������ �޿������� ���� �� �μ��� �����޿��հ� ����*/

SELECT empno,ename,deptno,MAX(sal) OVER (PARTITION BY deptno) �μ����ִ�޿�
FROM ���; /*����� �Ҽӵ� �μ��� �ִ�޿� ����*/

SELECT empno,ename,deptno,MIN(sal) OVER (PARTITION BY deptno) �μ�����ձ޿�
FROM ���; /*����� �Ҽӵ� �μ��� ��ձ޿� ����*/

---- RANK FUNCTION ----
SELECT empno,ename,deptno,sal,RANK() OVER (PARTITION BY deptno
ORDER BY sal DESC) �μ����޿�����
FROM ���; /*�μ� �� ����� �޿� ����. ������ ������ ������ ���� �ο�(�������� ����)*/

SELECT empno,ename,deptno,sal,DENSE_RANK() OVER (PARTITION BY deptno
ORDER BY sal DESC) �μ����޿�����
FROM ���; /*�μ� �� ����� �޿� ����. ������ ������ ������ ���� �ο�(�������� ����)�ϵ� ������ ������ �ϳ��� ������ ����*/

SELECT empno,ename,deptno,sal,ROW_NUMBER() OVER (PARTITION BY deptno
ORDER BY sal DESC) �μ����޿�����
FROM ���; /*�μ� �� ����� �޿� ����. ������ ������ �ٸ� ���� �ο�*/

---- �� ���� ���� �Լ� ----
SELECT empno,ename,deptno,sal,FIRST_VALUE(sal) OVER (PARTITION BY deptno
ORDER BY sal ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) �μ��������޿�
FROM ���; /*�μ����� �޿������� ���� �� �� ù��, �� ���� ���� �޿� ����*/

SELECT empno,ename,deptno,sal,MIN(SAL) OVER (PARTITION BY deptno) �μ��������޿�
FROM ���; /*���� �Լ� �� FIRST_VALUE�� ���� ��� ����*/

SELECT empno,ename,deptno,sal,LAST_VALUE(sal) OVER (PARTITION BY deptno
ORDER BY sal ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) �μ����ְ�޿�
FROM ���; /*�μ����� �޿������� ���� �� �� ������ ��, �� ���� ���� �޿� ����*/

SELECT empno,ename,deptno,sal,MAX(SAL) OVER (PARTITION BY deptno) �μ����ְ�޿�
FROM ���; /*���� �Լ� �� LAST_VALUE�� ���� ��� ����*/

SELECT empno,ename,deptno,sal,LAG(SAL) OVER (PARTITION BY deptno
ORDER BY sal) �μ������ܰ�޿�
FROM ���; /*�μ����� �޿������� ���� �� ���� ��, �� �� �ܰ� ���� �޿� ����*/

SELECT empno,ename,deptno,sal,LAG(SAL,2) OVER (PARTITION BY deptno
ORDER BY sal) �μ��������ܰ�޿�
FROM ���; /*�μ����� �޿������� ���� �� �� �ܰ� ���� �޿� ����*/

SELECT empno,ename,deptno,sal,LEAD(SAL) OVER (PARTITION BY deptno
ORDER BY sal) �μ����Ĵܰ�޿�
FROM ���; /*�μ����� �޿������� ���� �� �� �ܰ� ���� �޿� ����*/

SELECT empno,ename,deptno,sal,LEAD(SAL,2) OVER (PARTITION BY deptno
ORDER BY sal) �μ������Ĵܰ�޿�
FROM ���; /*�μ����� �޿������� ���� �� �� �ܰ� ���� �޿� ����*/

---- ���� ���� �Լ� ----
SELECT empno,ename,sal,CUME_DIST() OVER (ORDER BY sal) �޿����������
FROM ���; /*�޿��� ���������, �� ��ü �� �־��� �޿����� �۰ų� ���� �޿��� �޴� ����� ������ ���. (�־��� �޿����� �۰ų� ���� �޿��� �޴� ����� ��)/(��ü ����� ��)*/

SELECT empno,ename,deptno,sal,CUME_DIST() OVER (PARTITION BY deptno ORDER BY sal) �μ����޿����������
FROM ���; /*�μ��� �޿����������*/

SELECT empno,ename,sal,PERCENT_RANK() OVER (ORDER BY sal) �޿���������
FROM ���; /*���� ���� �޿��� 0, ���� ū �޿��� 1�� �ΰ� ���, �� ���� ���� ������� ����. (�ش� �޿����� ���� �޿��� �޴� ����� ��)/{��ü ����� ��)-1}*/

SELECT empno,ename,deptno,sal,PERCENT_RANK() OVER (PARTITION BY deptno ORDER BY sal) �μ����޿���������
FROM ���; /*�μ��� �޿���������*/

SELECT empno,ename,sal,NTILE(4) OVER (ORDER BY sal) �Ҽӻ����
FROM ���; /*�޿������� ��ü ����� ������� ������ �� �� �ϳ��� ����*/

SELECT empno,ename,deptno,sal,RATIO_TO_REPORT(sal) OVER (PARTITION BY deptno) �μ����޿��⿩��
FROM ���; /*�μ����� ����� �޿��� ��ü �޿����� �����ϴ� ����*/

-- SUBQUERY --
/*���������� ����:
��ġ�� ����-
1. �ζ��� ��: FROM���� ���
2. ��������: WHERE���� ���
3. ��Į�� ��������: FROM��, WHERE���� �ƴ� ���� ���. ���� ��Ȯ�� ���Ǵ� ���� �� ��, �� ���� ����ϴ� ��������

����ϴ� �� ���� ����-
1.���� �� ��������: ���� �� �ุ ����ϴ� ��������. >,<,>=,=<,<>,= ���� �񱳿����ڸ� ����Ѵ�.
2.���� �� ��������: ���� ���� ����ϴ� ��������. IN,ANY,ALL,EXISTS ���� �񱳿����ڸ� ����Ѵ�.
->IN: MAIN QUERY�� �������� SUBQUERY�� ����� �ϳ��� �����ص� �� (OR�� ����)
->ALL: MAIN QUERY�� SUBQUERY�� ����� ��� ���ƾ� �� (<ALL(SUBQUERY):�ּڰ��� ���, >ALL(SUBQUERY):�ִ��� ���)
->ANY: MAIN QUERY�� �������� SUBQUERY�� ��� �� �ϳ� �̻�� �����ϸ� �� (<ANY(SUBQUERY):�ϳ��� ũ�� �Ǹ� ��,>ANY(SUBQUERY):�ϳ��� �۰� �Ǹ� ��)
->EXISTS: MAIN QUERY�� SUBQUERY�� ����� �ϳ��� �����ϸ� ��*/

---- IN ----
SELECT * FROM ���
WHERE empno IN
(SELECT empno FROM ���
WHERE job = 'CLERK');

---- ALL ----
SELECT * FROM ���
WHERE sal <= ALL(SELECT DISTINCT sal FROM ���); /*sal�� �ּڰ� ���� ���*/

---- ANY ----
SELECT * FROM ���
WHERE sal >= ANY(2450,1250); /*>=ANY(���): ��Ͽ��� ���� ���� ���ں��� ũ�ų� ���� ��*/

---- EXISTS ----
SELECT * FROM EMP;
SELECT * FROM DEPT;

SELECT a.empno,a.ename,a.sal,a.deptno,b.deptname
FROM EMP a, DEPT b
WHERE a.sal >= 2000
AND EXISTS(SELECT 'Y' FROM EMP
WHERE a.deptno = b.deptno); /*EXISTS �ȿ� �ִ� ���������� ��� �� �ϳ��� �����ϸ� ���. �ַ� DB ���� ����� ���� JOIN ��� ���δ�*/
/*EXISTS�Լ� �ȿ� ���� ���������� ���� ��������: ���� ���������� ���Ե� Į���� �����*/

SELECT empno,ename,sal,(SELECT SUM(sal) FROM ���) �ѱ޿�
FROM ���
ORDER BY sal; /*��Į�� ��������: �ϳ��� ��� ���� ���� �����͸� ���*/

SELECT empno,ename,sal,SUM(sal) OVER (ORDER BY sal ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) �ѱ޿�
FROM ���; /*�� ��Į�� ���������� ������ SELECT���� ������ ��� ���*/

-- ������ ���� (Hierarchial QUERY) --
SELECT * FROM ���;
/*��� ���̺��� ��ȯ���� ���̸�, ���� ������ �������̰�, Ʈ�� ������ ǥ���� �� �ִ�. �����ȣ 1000�� �ؿ� �����ȣ 1001,1002,1003,1004��,
1001�� �ؿ� 1005,1006,1011��, 1002��  �ؿ� 1009,1010��, 1006�� �ؿ� 1007,1008�� �ΰ� �ִ�. �̴� �� 4�ܰ��� Ʈ�� ������, ROOT ��忡�� 1000��,
TERMINAL(LEAF) ��忡�� 1007�� �ڸ���� �ִ�.*/

/*��� ���̺�� ���� ������ �����ʹ� ������ ���Ǹ� ���� ��ȸ�� �� �ִ�:
SELECT LEVEL,[�ڽ� ��尡 ���� Į��], [�θ� ��尡 ���� Į��], [��Ÿ Į��]
FROM [���̺�]
START WITH [ROOT ��尡 ���� Į��] = [ROOT ����� ��]
CONNECT BY PRIOR [�ڽ� ��尡 ���� Į��] = [�θ� ��尡 ���� Į��];: �θ� ������ �ڽ� ���� ������ ����

CONNECT BY PRIOR [�θ� ��尡 ���� Į��] = [�ڽ� ��尡 ���� Į��];: �ڽ� ������ �θ� ���� ������ ����. LEVEL�� �̿� �°� ����ȴ�.*/

SELECT LEVEL,empno,mgr,ename
FROM ���
START WITH MGR IS NULL
CONNECT BY PRIOR empno = mgr;/*empno�� �ڽ� ���, mgr�� �θ� ����. CONNECT BY���� �ڽĳ���� PRIOR, �� ������� �θ��带 ����������
������ ������ �̷������.*/

SELECT LEVEL,empno,mgr,ename
FROM ���
START WITH empno = 1008
CONNECT BY empno = PRIOR mgr;/*CONNECT BY���� �θ����� PRIOR, �� ������� �ڽĳ�带 ����������
������ ������ �̷������.*/

/*��� �Լ��� �߰��� ������ ��ȸ�� ���(�������̴� �������̴� ��������� �ļӳ����� ������� �����͸� ��ȸ)�� �������� �����ϱ� ���� �ٲٱ�*/
SELECT LEVEL,LPAD(' ',4*(LEVEL-1))||empno AS ���,mgr AS ������,CONNECT_BY_ISLEAF ���������Ϳ���
FROM ���
START WITH MGR IS NULL
CONNECT BY PRIOR empno = mgr
ORDER SIBLINGS BY sal DESC;/*LPAD([����1],[����],[����2]): �̸� [����]��ŭ �Ҵ�� ���ڼ� �� �����ʿ� [����1]�� ��ġ�� �� ���ʺ��� ����
���ڼ���ŭ [����2]�� ��ġ. [����2]�� ���� ��� �׳� ���� ���ڼ���ŭ ������ ��ġ.
LPAD(' ',4*(LEVEL-1)): ������ �ö󰥼��� ���ڰ� ���������� ��ĭ�� �þ. ���п� �θ���� �ڽĳ�� �� ���� �������� Ȯ���� ���� ����*/

SELECT LEVEL,LPAD(' ',4*(LEVEL-1))||empno AS ���,mgr AS ������,CONNECT_BY_ISLEAF ���������Ϳ���
FROM ���
START WITH empno = 1008
CONNECT BY empno = PRIOR mgr; /*������ ����*/

SELECT LEVEL,CONNECT_BY_ROOT(empno) ��Ʈ,SYS_CONNECT_BY_PATH(empno,'/') ���, empno ���, mgr �޴���
FROM ���
START WITH mgr IS NULL
CONNECT BY PRIOR empno = mgr; /*CONNECT_BY_ROOT(Į��): ������ �����Ϳ��� �ش� Į�������� �����ϴ� ����� ���� ��Ʈ
SYS_CONNECT_BY_PATH(Į��): ������ �����Ϳ��� �ش� Į�������� �����ϴ� ���(��Ʈ��������)*/

SELECT LEVEL,CONNECT_BY_ROOT(empno) ��Ʈ,SYS_CONNECT_BY_PATH(empno,'/') ���, mgr �޴���
FROM ���
START WITH empno = 1008
CONNECT BY empno = PRIOR mgr; /*CONNECT_BY_ROOT(Į��): ������ �����Ϳ��� �ش� Į�������� �����ϴ� ����� ���� ��Ʈ
SYS_CONNECT_BY_PATH(Į��): ������ �����Ϳ��� �ش� Į�������� �����ϴ� ���(��Ʈ��������)*/

---- ���� ���� ----
/*���� ������ �� ���̺��� �� Į���� ���� ������ ���� �� ����Ѵ�. ������ �������� ��� ���� ������ �̿��� ������ ������ �� ��θ� �ϳ��� ���̺�
�� ǥ���� �� �ִ�. ��� ���̺��� ���� ����*/
SELECT * FROM ���;/*EMPNO(�ڽ�)�� MGR(�θ�)�� �����Ǿ� �ִ�. */

SELECT a.empno ���, a.mgr ������, b.mgr ����������
FROM ��� a LEFT OUTER JOIN ��� b
ON a.mgr = b.empno
ORDER BY ���������� DESC, ������, ���; /*LEFT OUTER JOIN�� �ϴ� ����: ��� �� �����ڰ� ���� ��쵵 �ݿ��ؾ� �ϹǷ�*/