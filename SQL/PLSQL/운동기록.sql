CREATE TABLE wh
(datetime date default sysdate primary key,
waist number(4,1),
hip number(4,1));

-- whr_update ���ν���: ��¥, �㸮�ѷ�, �����̵ѷ� �Է� �� 1)���� ���̺� �ش� ��¥�� WHR�� �� ��ȭ ��� �����ϸ� ��� 2)�׷��� ���� ��� �ش� ��¥�� WHR ��� 
CREATE OR REPLACE PROCEDURE whr_update
(whr_datetime in date,
whr_waist in number,
whr_hip in number,
whr_result out varchar2,
whr_whr out number)
IS

cnt number := 0;

BEGIN

SELECT COUNT(*) INTO cnt
FROM wh
WHERE datetime = whr_datetime
AND ROWNUM = 1;

IF cnt > 0
THEN whr_result := '�̹� �����ϴ� ����Դϴ�';
SELECT ROUND(waist/hip,1) INTO whr_whr
FROM wh
WHERE datetime = whr_datetime;

ELSE
INSERT INTO wh(datetime,waist,hip)
VALUES(whr_datetime, whr_waist, whr_hip);

whr_result := '����� �����߽��ϴ�';
SELECT ROUND(waist/hip,1) INTO whr_whr
FROM wh
WHERE datetime = whr_datetime;

END IF;

EXCEPTION
WHEN OTHERS THEN 
ROLLBACK;
whr_result := '���� �߻�';
whr_whr := NULL;

END;
-- ���ν��� ����

variable ��ȸ��� varchar2;
variable �㸮�����̺��� number;

EXECUTE whr_update(TO_DATE(SYSDATE,'YY/MM/DD'),104,107,:��ȸ���,:�㸮�����̺���);
PRINT ��ȸ���;
PRINT �㸮�����̺���;

-- � ���ۺ��� ���ݱ����� WHR�� �� ��ȭ ��Ÿ���� ��� (���� ���̺�)
DROP TABLE ����;
CREATE TABLE ���� AS
SELECT datetime, waist, hip, ROUND(waist/hip,1) AS whr,
DECODE(SIGN(ROUND(waist/hip,1) - LAG(ROUND(waist/hip,1)) OVER (ORDER BY datetime)), -1, 'IMPROVED',
0, 'SAME',
1, 'WORSENED') AS improvement,
ABS(ROUND(waist/hip,1) - LAG(ROUND(waist/hip,1)) OVER (ORDER BY datetime)) AS change
FROM wh;

SELECT * FROM ����;