-- DDL--

-- CREATE(DDL), INSERT(DML) --
CREATE TABLE 고객
(고객ID VARCHAR(10) PRIMARY KEY,
고객명 VARCHAR(20) NOT NULL,
생년월일 DATE DEFAULT SYSDATE);

CREATE TABLE 계좌
(계좌번호 VARCHAR(20) PRIMARY KEY,
고객ID VARCHAR(10),
지점 VARCHAR(10) NOT NULL,
예수금 NUMBER(10,2) DEFAULT 0,
CONSTRAINT acpk FOREIGN KEY (고객ID) REFERENCES 고객(고객ID)
ON DELETE CASCADE); /*REFERENTIAL ACTION: MASTER 데이터 삭제 시 CHILD 데이터도 삭제*/
/*원래는 MASTER TABLE에서 데이터 삭제가 되지 않음: 참조 무결성 (MASTER에 없는 데이터는 CHILD에도 없어야 함) 위배 때문*/

INSERT INTO 고객(고객ID,고객명,생년월일)
VALUES('0000','한승희','1994-04-08');
INSERT INTO 고객(고객ID,고객명)
VALUES('0001','한승재');
INSERT INTO 고객(고객ID,고객명,생년월일)
VALUES('0002','이정임','1959-10-26');

INSERT INTO 계좌(계좌번호,고객ID,지점)
VALUES('110-360-167025','0001','남가좌');
INSERT INTO 계좌
VALUES('123-456-789000','0000','북가좌',10000000.00);

---- REFERENTIAL ACTION ----
----- DELETE -----
ALTER TABLE 계좌
DROP CONSTRAINT acpk;

ALTER TABLE 계좌
ADD CONSTRAINT acpk FOREIGN KEY (고객ID) REFERENCES 고객(고객ID)
ON DELETE SET NULL;

DELETE FROM 고객
WHERE 고객ID = '0001'; /*ON DELETE SET NULL: MASTER에서 데이터 삭제 시 CHILD의 해당 필드값을 NULL로 설정
ON DELETE SET DEFAULT: MASTER에서 데이터 삭제 시 CHILD의 해당 필드값을 DEFAULT값으로 설정*/

-- 형변환 --
SELECT * FROM 고객
WHERE 고객ID = 0000; /*ORACLE에서 자동으로 암시적 형변환 수행. 단, 고객ID를 인덱스로 활용하고자 할 경우 암시적 형변환 삼가야*/

SELECT * FROM 고객
WHERE 생년월일 = '1994-04-08';

SELECT * FROM 고객
WHERE TO_CHAR(생년월일,'YY/MM/DD') = '94/04/08';

SELECT * FROM 고객
WHERE 생년월일 = TO_DATE('1994-04-08','YY/MM/DD');

SELECT * FROM 계좌;
--ALTER--
---- ADD ----
ALTER TABLE 고객
ADD (성별 VARCHAR(10));

UPDATE 고객
SET 성별 = '여'
WHERE 고객ID IN (0000,0002);

---- RENAME ----
RENAME 고객 TO 멤버; /*테이블 RENAME 방식(1): ANSI 표준 (ORACLE, SQL SERVER 공통)*/

ALTER TABLE 멤버
RENAME COLUMN 고객명 TO 멤버명; /*칼럼 RENAME 방식: ALTER TABLE [테이블명] RENAME COLUMN [예전 칼럼명] TO [새 칼럼명];*/

ALTER TABLE 멤버
RENAME TO 고객; /*테이블 RENAME 방식(2): ORACLE에서만 (ALTER TABLE [테이블명] RENAME TO [새 테이블명];)*/
---- DROP ----
DROP TABLE 고객
CASCADE CONSTRAINTS; /*테이블 DROP 방식: DROP TABLE [테이블명]*/
/*테이블 DROP 시 PK가 다른 테이블의 FK로 참조된 테이블은 참조 무결성 때문에 DROP이 안됨: 이를 막기 위해
DROP TABLE [테이블명] CASCADE CONSTRAINTS; 실행*/

ALTER TABLE 계좌
DROP COLUMN 예수금; /*칼럼 DROP 방식: ALTER TABLE [테이블명] DROP COLUMN [칼럼명]*/

/*칼럼 변형 시 명령어 뒤에 반드시 COLUMN 기입해야 하는 명령어들: DROP, RENAME*/

DROP TABLE 계좌;

-- DML --
---- SELECT -----
SELECT * FROM EMP;

SELECT empno,ename,sal,deptno FROM EMP;
----- 연산자 -----
SELECT empno,ename,sal FROM EMP
WHERE sal BETWEEN 1000 AND 2500;

SELECT empno,ename,sal FROM EMP
WHERE sal >= 1000 AND sal <= 2500;

SELECT empno,ename,sal,deptno FROM EMP
WHERE deptno NOT IN (1001,1002)
AND sal >= 1500
OR deptno = 1001; /*WHERE 조건문 실행 순서: NOT->AND->OR*/

----- LIKE문(와일드카드) -----
SELECT empno,ename FROM EMP
WHERE ename LIKE '%을'; /*LIKE문: 와일드카드 사용해 문자열로 데이터 조회 시 사용
%[글자]: 문자열이 [글자]로 끝나는 행 조회
[글자]%: 문자열이 [글자]로 시작하는 행 조회
%[글자]%: 문자열 어디라도 [글자]가 들어가는 행 조회
_[글자]: [글자] 앞에 한 글자가 들어가는 행 조회
[글자]_: [글자] 뒤에 한 글자가 들어가는 행 조회*/

SELECT empno,ename FROM EMP
WHERE ename LIKE '을%';

SELECT empno,ename FROM EMP
WHERE ename LIKE '%을%';

SELECT empno,ename FROM EMP
WHERE ename LIKE '을___';

----- NULL 관련 함수 -----
CREATE TABLE 주문
(주문ID VARCHAR(20),
고객ID VARCHAR(20),
물건ID VARCHAR(20),
물건수량 NUMBER(10,0),
CONSTRAINT ordpk PRIMARY KEY (고객ID));

INSERT INTO 주문(고객ID,주문ID,물건ID,물건수량)
VALUES('000','100-001','','');
INSERT INTO 주문(고객ID,주문ID,물건ID,물건수량)
VALUES('001','100-002','1000','40');
INSERT INTO 주문(고객ID,주문ID,물건ID,물건수량)
VALUES('002','100-003','','');
INSERT INTO 주문(고객ID,주문ID,물건ID,물건수량)
VALUES('003','100-004','2000','43');
INSERT INTO 주문(고객ID,주문ID,물건ID,물건수량)
VALUES('004','100-005','','');
INSERT INTO 주문(고객ID,주문ID,물건ID,물건수량)
VALUES('005','100-006','3000','47');

SELECT * FROM 주문;

SELECT * FROM 주문
WHERE 물건ID IS NULL;

SELECT 고객ID,NVL(물건ID,'NONE') AS 물건ID,NVL(물건수량,0) AS 물건수량
FROM 주문; /*NVL([칼럼],[대체값]):[칼럼] 중 NULL값인 것들을 [대체값]으로 바꾸어서 조회*/

SELECT 고객ID,NVL2(물건ID,'있음','없음') AS 물건유무
FROM 주문; /*NVL2([칼럼],[값1],[값2]): [칼럼] 중 NULL값인 것들은 [값2], NULL값이 아닌 것들은 [값1]로 바꿔서 조회*/

SELECT 고객ID,NULLIF(물건수량,40) AS 물건수량_40이상
FROM 주문; /*NULLIF([값1],[값2]): [값1]과 [값2]가 같으면 NULL, 다르면 [값1]을 조회*/

SELECT 고객ID,COALESCE(물건ID,'없음') AS 물건ID
FROM 주문; /*COALESCE([값1],[값2],...): NULL이 아닌 첫번째 값
COALESCE([칼럼],[값]): [칼럼]이 NULL이면 [값]을 조회*/

----- GROUP BY -----
SELECT a.deptno,a.deptname,SUM(b.sal) AS 총급여
FROM DEPT a LEFT OUTER JOIN EMP b
ON a.deptno = b.deptno
GROUP BY a.deptno,a.deptname /*집계함수(COUNT,SUM,MAX,MIN,AVG,STDDEV,VARIANCE) 사용시 항상 GROUP BY로 집계 기준을 제시해줘야 하고, HAVING으로 집계함수에 조건을 걸 수 있음*/
HAVING SUM(b.sal) >= 1500
ORDER BY deptno; /*SELECT문 실행 순서: FROM->WHERE->GROUP BY->HAVING->SELECT->ORDER BY*/
/*GROUPING 속성은 항상 SELECT문에서 조회하는 칼럼(집계하는 칼럼 제외) 전부여야*/
/*SUM([칼럼]) = SUM(NVL([칼럼],0)): SUM 함수는 칼럼 중 NULL값을 제외한 것의 합계*/

SELECT a.deptno,a.deptname,MAX(b.sal) AS 최고급여
FROM DEPT a LEFT OUTER JOIN EMP b
ON a.deptno = b.deptno
GROUP BY a.deptno,a.deptname
ORDER BY deptno; /*MAX 함수는 칼럼 중 NULL값을 제외한 최댓값을 출력*/

SELECT a.deptno,a.deptname,MIN(b.sal) AS 최저급여
FROM DEPT a LEFT OUTER JOIN EMP b
ON a.deptno = b.deptno
GROUP BY a.deptno,a.deptname
ORDER BY deptno; /*MIN 함수는 칼럼 중 NULL값을 제외한 최솟값을 출력*/

SELECT a.deptno,a.deptname,STDDEV(b.sal) AS 급여표준편차
FROM DEPT a LEFT OUTER JOIN EMP b
ON a.deptno = b.deptno
GROUP BY a.deptno,a.deptname
ORDER BY deptno;

SELECT a.deptno,a.deptname,VARIANCE(b.sal) AS 급여분산
FROM DEPT a LEFT OUTER JOIN EMP b
ON a.deptno = b.deptno
GROUP BY a.deptno,a.deptname
ORDER BY deptno;

SELECT a.deptno,a.deptname,AVG(b.sal) AS 평균급여
FROM DEPT a LEFT OUTER JOIN EMP b
ON a.deptno = b.deptno
GROUP BY a.deptno,a.deptname
ORDER BY deptno;

SELECT a.deptno,a.deptname,COUNT(b.empno) AS 사원수
FROM DEPT a LEFT OUTER JOIN EMP b
ON a.deptno = b.deptno
GROUP BY a.deptno,a.deptname
ORDER BY deptno;

SELECT DEPTNO,SUM(SAL) AS 급여합계 FROM 사원
WHERE EMPNO BETWEEN 1000 AND 1003
GROUP BY DEPTNO;

/*집계함수는 NULL값이 있을 시 NULL을 제외하고 연산한다!!!!!!*/

----- 내장형 함수 -----
----- 문자 -----
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
/*결과값:
A a
B b*/

----- 숫자 -----
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

----- 날짜 -----
SELECT SYSDATE,
SYSTIMESTAMP,
TO_CHAR(SYSDATE,'YYYYMMDD'),
TO_CHAR(SYSTIMESTAMP, 'YYYYMMDDHHMMSS'),
EXTRACT(MONTH FROM SYSDATE),
EXTRACT(YEAR FROM SYSTIMESTAMP)
FROM DUAL;

----- DECODE -----
SELECT * FROM 사원;

SELECT EMPNO,DECODE(JOB,'CLERK',1) 사원여부,DECODE(JOB,'SALESMAN',1) 판매원여부,DECODE(JOB,'MANAGER',1) 매니저여부,DECODE(JOB,'ANALYST',1) 분석가여부
FROM 사원;

SELECT EMPNO,DECODE(JOB,'CLERK',1,0) 사원여부,DECODE(JOB,'SALESMAN',1,0) 판매원여부,DECODE(JOB,'MANAGER',1,0) 매니저여부,DECODE(JOB,'ANALYST',1,0) 분석가여부
FROM 사원;

SELECT SUM(DECODE(JOB,'CLERK',1)) AS 사원수,
SUM(DECODE(JOB,'SALESMAN',1)) AS 판매원수,
SUM(DECODE(JOB,'MANAGER',1)) AS 매니저수,
SUM(DECODE(JOB,'ANALYST',1)) AS 분석가수
FROM 사원; /*다중값 속성의 경우 sum과 decode로 각 값을 하나의 칼럼으로 분리해 각 값을 갖는 인스턴스의 수를 값별로 정리할 수 있음*/

SELECT JOB,COUNT(JOB) 직원수 FROM 사원
GROUP BY JOB; /*위 테이블의 피벗 버전*/

SELECT EMPNO,DECODE(JOB,'CLERK',DECODE(DEPTNO,'30','Y','N'),'N') 부서30소속_사원여부
FROM 사원; /*DECODE문 안에 DECODE문 중첩 가능*/

----- CASE -----
SELECT EMPNO,
CASE WHEN JOB = 'CLERK' THEN 'C'
WHEN JOB = 'SALESMAN' THEN 'S'
WHEN JOB = 'MANAGER' THEN 'M'
WHEN JOB = 'ANALYST' THEN 'A'
ELSE 'OT'
END
AS 직업
FROM 사원;/*Searched case expression: 조건별로 비교연산을 수행하는 CASE 구문*/

SELECT EMPNO,
CASE JOB WHEN 'CLERK' THEN 'C'
WHEN 'SALESMAN' THEN 'S'
WHEN 'MANAGER' THEN 'M'
WHEN 'ANALYST' THEN 'A'
ELSE 'OT'
END
AS 직업
FROM 사원;/*Single case expression: 조건 칼럼 하나를 고정시키고 비교연산을 수행하는 CASE 구문*/
/*Searched case expression이 보다 더 복잡한 조건을 사용해 비교연산 수행이 가능하다는 장점이 있다*/

----- ROWNUM -----
SELECT * FROM 사원
WHERE ROWNUM <= 1;

SELECT * FROM 사원
WHERE ROWNUM = 2; /*실행되지 않음: INLINE VIEW 사용해야*/

SELECT * FROM
(SELECT ROWNUM 번호,EMPNO
FROM 사원)
WHERE 번호 BETWEEN 5 AND 10;

SELECT * FROM
(SELECT ROWNUM 번호,EMPNO
FROM 사원)
WHERE 번호 = 10;

----- ROWID -----
SELECT ROWID,EMPNO
FROM 사원;

-- TCL --
SHOW AUTOCOMMIT;
SET AUTOCOMMIT ON;/*AUTOCOMMIT:SQL(DML) 트랜잭션을 실행할 때마다 자동으로 COMMIT*/

CREATE TABLE ENT(
id VARCHAR(4),
name VARCHAR(15)); /*CREATE,ALTER,DROP,RENAME 등의 DDL는 원래 AUTOCOMMIT이 되기 때문에 ROLLBACK 수행이 불가능*/

INSERT INTO ENT
VALUES('0001','하승진');
INSERT INTO ENT
VALUES('0002','유상철');
SELECT * FROM ENT;
ROLLBACK;
SELECT * FROM ENT; /*ENT에 입력한 값이 ROLLBACK을 실행했음에도 불구하고 사라지지 않음: AUTOCOMMIT을 실행시켰기 때문에*/

SET AUTOCOMMIT OFF; /*AUTOCOMMIT 기능 끔*/
SHOW AUTOCOMMIT;

UPDATE EMP
SET SAL = 1000
WHERE SAL = 500;
COMMIT;
INSERT INTO EMP(EMPNO,ENAME,SAL,DEPTNO)
VALUES('105','제갈량',3000,'1004');
SAVEPOINT SVT1; /*SQLSERVER에서는 SAVE TRANSACTION SVT1*/
DELETE FROM EMP
WHERE EMPNO = '105';
SAVEPOINT SVT2;
ROLLBACK TO SVT1; /*SQLSERVER에서는 ROLLBACK TRANSACTION SVT1*/
/*그냥 ROLLBACK 시 COMMIT한 곳까지로 돌아감, ROLLBACK TO [SAVEPOINT] 시 [SAVEPOINT]까지 돌아감*/

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
SELECT a.deptno,a.deptname,SUM(b.sal) AS 총급여
FROM DEPT a LEFT OUTER JOIN EMP b
ON a.deptno = b.deptno
GROUP BY a.deptno,a.deptname
ORDER BY deptno

SELECT a.deptno,a.deptname,SUM(b.sal) AS 총급여
FROM DEPT a, EMP b
WHERE a.deptno = b.deptno (+)
GROUP BY a.deptno,a.deptname
ORDER BY deptno; /*ORACLE에서는 WHERE절 중 OUTER JOIN에서 기준으로 삼지 않는 테이블의 칼럼 옆에 (+)를 배치하여 OUTER JOIN과 동일한 효과를 낼 수 있다*/

---- CROSS JOIN ----
SELECT * FROM
DEPT CROSS JOIN EMP; /*두 테이블의 카테시안 곱 출력*/

---- JOIN 이외의 결합 연산 ----
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
---- ROLLUP: 지정한 칼럼값별 소계(SUBTOTAL)와 총계를 함께 구해준다 ----
SELECT * FROM 사원;

SELECT deptno 부서,SUM(SAL) 총급여
FROM 사원
GROUP BY deptno
ORDER BY deptno;

SELECT DECODE(deptno,NULL,'전체합계',deptno) 부서, SUM(SAL) 총급여
FROM 사원
GROUP BY ROLLUP(deptno); /*부서별 급여 합계와 총급여*/

SELECT DECODE(GROUPING(deptno),1,'전체합계',deptno) 부서, SUM(sal) 총급여
FROM 사원
GROUP BY ROLLUP(deptno); /*위 SQL문과 결과 동일: GROUPING에 대해서는 ---- GROUPING ---- 참고*/

SELECT deptno 부서, job 직업, SUM(SAL) 총급여
FROM 사원
GROUP BY ROLLUP(deptno,job); /*부서별.직업별 급여 합계, 부서별 급여 합계, 총급여*/

SELECT DECODE(GROUPING(deptno),1,'전체합계',deptno) 부서,DECODE(GROUPING(job),1,'부서합계',job) 직업,DECODE(GROUPING(mgr),1,'부서.직업 합계',mgr) 관리자,SUM(sal) 총급여
FROM 사원
GROUP BY ROLLUP(deptno,job,mgr); /*부서별.직업별.관리자별 급여 합계, 부서별.직업별 급여합계, 부서별 급여합계, 총급여
ROLLUP 함수의 GROUPING 칼럼 수가 N이면 출력하는 합계의 종류 수는 N+1*/

---- GROUPING: GROUP 함수 실행 시 어떤 칼럼을 묶어서 소계를 구했는지(1) 아닌지(0)를 나타내는 내장형 함수 ----
SELECT deptno 부서, GROUPING(deptno), job 직업, GROUPING(job), SUM(sal) 총급여
FROM 사원
GROUP BY ROLLUP(deptno,job);

SELECT deptno 부서, DECODE(GROUPING(deptno),1,'전체합계') TOTAL, job 직업, DECODE(GROUPING(job),1,'부서별소계') JOB_TOTAL, SUM(sal) 총급여
FROM 사원
GROUP BY ROLLUP(deptno,job); /*DECODE로 전체합계와 부서별 합계 구분하는 함수 생성*/

SELECT DECODE(GROUPING(deptno),1,'전체합계',deptno) 부서, DECODE(GROUPING(job),1,'부서합계',job) 직업, SUM(sal) 총급여
FROM 사원
GROUP BY ROLLUP(deptno,job); /*DECODE로 전체합계와 부서별 합계 구분하는 함수 생성*/

---- GROUPING SETS: 제시한 속성별로 소계 구하고, 각 속성 모두에 대한 소계와 총계는 구하지 않음 ----
SELECT deptno 부서, job 직업, SUM(sal) 총급여
FROM 사원
GROUP BY GROUPING SETS(deptno,job);

---- CUBE: 제시한 속성들에 대한 구할 수 있는 모든 종류의 소계와 총계를 구함 ----
SELECT deptno 부서, job 직업, SUM(sal) 총급여
FROM 사원
GROUP BY CUBE(deptno,job);

-- Window Function --
---- AGGREGATE FUNCTION ----
SELECT * FROM 사원
ORDER BY sal;

SELECT empno,ename,SUM(sal) OVER (ORDER BY sal
ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) 급여합계
FROM 사원; /*급여순으로 사원 정렬 후 총 급여합계 구함*/

/*SELECT WINDOW_FUNCTION([COLUMN])
OVER(PARTITION BY [PARTITIONING_COLUMN]
ORDER BY [ORDERING_COLUMN]
[ROWS/RANGE] BETWEEN [UNBOUNDED PRECEDING/CURRENT ROW] AND UNBOUNDED FOLLOWING)
FROM [TABLE];
PARTITION BY - 윈도우 함수를 적용하고 구분 지을 칼럼(파티션) 설정
ORDER BY - 각 파티션 내에서 행 정렬 기준 설정
UNBOUNDED PRECEDING - 파티션 내 첫 행
UNBOUNED FOLLOWING - 파티션 내 마지막 행
CURRENT ROW - 현재 행*/

SELECT empno,ename,SUM(sal) OVER (ORDER BY sal
ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) 누적급여합계
FROM 사원; /*사원들을 급여순으로 정렬 후 각 행마다 누적급여합계 구함*/

SELECT empno,ename,SUM(sal) OVER (ORDER BY sal
ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING) 역누적급여합계
FROM 사원; /*사원들을 급여순으로 정렬 후 누적급여합계에서 각 행의 급여 차감*/

SELECT empno,ename,deptno,SUM(sal) OVER(PARTITION BY deptno
ORDER BY sal ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) 부서별누적급여
FROM 사원; /*사원들을 부서별로 나누고 급여순으로 정렬 후 부서별 누적급여합계 구함*/

SELECT empno,ename,deptno,MAX(sal) OVER (PARTITION BY deptno) 부서별최대급여
FROM 사원; /*사원이 소속된 부서의 최대급여 구함*/

SELECT empno,ename,deptno,MIN(sal) OVER (PARTITION BY deptno) 부서별평균급여
FROM 사원; /*사원이 소속된 부서의 평균급여 구함*/

---- RANK FUNCTION ----
SELECT empno,ename,deptno,sal,RANK() OVER (PARTITION BY deptno
ORDER BY sal DESC) 부서내급여순위
FROM 사원; /*부서 내 사원의 급여 순위. 동일한 순위에 동일한 값을 부여(공동순위 인정)*/

SELECT empno,ename,deptno,sal,DENSE_RANK() OVER (PARTITION BY deptno
ORDER BY sal DESC) 부서내급여순위
FROM 사원; /*부서 내 사원의 급여 순위. 동일한 순위에 동일한 값을 부여(공동순위 인정)하되 동일한 순위를 하나의 값으로 산정*/

SELECT empno,ename,deptno,sal,ROW_NUMBER() OVER (PARTITION BY deptno
ORDER BY sal DESC) 부서내급여순위
FROM 사원; /*부서 내 사원의 급여 순위. 동일한 순위에 다른 값을 부여*/

---- 행 순서 관련 함수 ----
SELECT empno,ename,deptno,sal,FIRST_VALUE(sal) OVER (PARTITION BY deptno
ORDER BY sal ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) 부서별최저급여
FROM 사원; /*부서별로 급여순으로 정렬 후 맨 첫줄, 즉 가장 낮은 급여 산정*/

SELECT empno,ename,deptno,sal,MIN(SAL) OVER (PARTITION BY deptno) 부서별최저급여
FROM 사원; /*집계 함수 중 FIRST_VALUE와 동일 기능 수행*/

SELECT empno,ename,deptno,sal,LAST_VALUE(sal) OVER (PARTITION BY deptno
ORDER BY sal ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) 부서별최고급여
FROM 사원; /*부서별로 급여순으로 정렬 후 맨 마지막 줄, 즉 가장 높은 급여 산정*/

SELECT empno,ename,deptno,sal,MAX(SAL) OVER (PARTITION BY deptno) 부서별최고급여
FROM 사원; /*집계 함수 중 LAST_VALUE와 동일 기능 수행*/

SELECT empno,ename,deptno,sal,LAG(SAL) OVER (PARTITION BY deptno
ORDER BY sal) 부서별전단계급여
FROM 사원; /*부서별로 급여순으로 정렬 후 이전 줄, 즉 한 단계 낮은 급여 산정*/

SELECT empno,ename,deptno,sal,LAG(SAL,2) OVER (PARTITION BY deptno
ORDER BY sal) 부서별전전단계급여
FROM 사원; /*부서별로 급여순으로 정렬 후 두 단계 낮은 급여 산정*/

SELECT empno,ename,deptno,sal,LEAD(SAL) OVER (PARTITION BY deptno
ORDER BY sal) 부서별후단계급여
FROM 사원; /*부서별로 급여순으로 정렬 후 한 단계 높은 급여 산정*/

SELECT empno,ename,deptno,sal,LEAD(SAL,2) OVER (PARTITION BY deptno
ORDER BY sal) 부서별후후단계급여
FROM 사원; /*부서별로 급여순으로 정렬 후 두 단계 높은 급여 산정*/

---- 비율 관련 함수 ----
SELECT empno,ename,sal,CUME_DIST() OVER (ORDER BY sal) 급여누적백분율
FROM 사원; /*급여의 누적백분율, 즉 전체 중 주어진 급여보다 작거나 같은 급여를 받는 사원의 비율을 계산. (주어진 급여보다 작거나 같은 급여를 받는 사원의 수)/(전체 사원의 수)*/

SELECT empno,ename,deptno,sal,CUME_DIST() OVER (PARTITION BY deptno ORDER BY sal) 부서내급여누적백분율
FROM 사원; /*부서별 급여누적백분율*/

SELECT empno,ename,sal,PERCENT_RANK() OVER (ORDER BY sal) 급여등수백분율
FROM 사원; /*가장 작은 급여는 0, 가장 큰 급여는 1로 두고 등수, 즉 행의 수로 백분율을 구함. (해당 급여보다 적은 급여를 받는 사원의 수)/{전체 사원의 수)-1}*/

SELECT empno,ename,deptno,sal,PERCENT_RANK() OVER (PARTITION BY deptno ORDER BY sal) 부서내급여등수백분율
FROM 사원; /*부서별 급여등수백분율*/

SELECT empno,ename,sal,NTILE(4) OVER (ORDER BY sal) 소속사분위
FROM 사원; /*급여순으로 전체 사원을 사분위로 나누어 그 중 하나에 배정*/

SELECT empno,ename,deptno,sal,RATIO_TO_REPORT(sal) OVER (PARTITION BY deptno) 부서별급여기여도
FROM 사원; /*부서별로 사원의 급여가 전체 급여에서 차지하는 비율*/

-- SUBQUERY --
/*서브쿼리의 종류:
위치에 따라-
1. 인라인 뷰: FROM절에 사용
2. 서브쿼리: WHERE구에 사용
3. 스칼라 서브쿼리: FROM절, WHERE구가 아닌 곳에 사용. 보다 정확한 정의는 오직 한 행, 한 열만 출력하는 서브쿼리

출력하는 행 수에 따라-
1.단일 행 서브쿼리: 오직 한 행만 출력하는 서브쿼리. >,<,>=,=<,<>,= 등의 비교연산자를 사용한다.
2.다중 행 서브쿼리: 여러 행을 출력하는 서브쿼리. IN,ANY,ALL,EXISTS 등의 비교연산자를 사용한다.
->IN: MAIN QUERY의 비교조건이 SUBQUERY의 결과와 하나만 동일해도 참 (OR의 역할)
->ALL: MAIN QUERY와 SUBQUERY의 결과와 모두 같아야 참 (<ALL(SUBQUERY):최솟값을 출력, >ALL(SUBQUERY):최댓값을 출력)
->ANY: MAIN QUERY의 비교조건이 SUBQUERY의 결과 중 하나 이상과 동일하면 참 (<ANY(SUBQUERY):하나라도 크게 되면 참,>ANY(SUBQUERY):하나라도 작게 되면 참)
->EXISTS: MAIN QUERY와 SUBQUERY의 결과가 하나라도 존재하면 참*/

---- IN ----
SELECT * FROM 사원
WHERE empno IN
(SELECT empno FROM 사원
WHERE job = 'CLERK');

---- ALL ----
SELECT * FROM 사원
WHERE sal <= ALL(SELECT DISTINCT sal FROM 사원); /*sal의 최솟값 가진 사원*/

---- ANY ----
SELECT * FROM 사원
WHERE sal >= ANY(2450,1250); /*>=ANY(목록): 목록에서 가장 작은 숫자보다 크거나 같은 값*/

---- EXISTS ----
SELECT * FROM EMP;
SELECT * FROM DEPT;

SELECT a.empno,a.ename,a.sal,a.deptno,b.deptname
FROM EMP a, DEPT b
WHERE a.sal >= 2000
AND EXISTS(SELECT 'Y' FROM EMP
WHERE a.deptno = b.deptno); /*EXISTS 안에 있는 서브쿼리의 결과 중 하나라도 만족하면 출력. 주로 DB 성능 향상을 위해 JOIN 대신 쓰인다*/
/*EXISTS함수 안에 쓰인 서브쿼리는 연관 서브쿼리: 메인 서브쿼리에 포함된 칼럼을 사용함*/

SELECT empno,ename,sal,(SELECT SUM(sal) FROM 사원) 총급여
FROM 사원
ORDER BY sal; /*스칼라 서브쿼리: 하나의 행과 열을 가진 데이터를 출력*/

SELECT empno,ename,sal,SUM(sal) OVER (ORDER BY sal ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) 총급여
FROM 사원; /*위 스칼라 서브쿼리를 포함한 SELECT문과 동일한 결과 출력*/

-- 계층형 질의 (Hierarchial QUERY) --
SELECT * FROM 사원;
/*사원 테이블은 순환관계 모델이며, 따라서 계층형 데이터이고, 트리 구조로 표현할 수 있다. 사원번호 1000은 밑에 사원번호 1001,1002,1003,1004를,
1001은 밑에 1005,1006,1011을, 1002는  밑에 1009,1010을, 1006은 밑에 1007,1008을 두고 있다. 이는 총 4단계의 트리 구조로, ROOT 노드에는 1000이,
TERMINAL(LEAF) 노드에는 1007이 자리잡고 있다.*/

/*사원 테이블과 같은 계층형 데이터는 계층형 질의를 통해 조회할 수 있다:
SELECT LEVEL,[자식 노드가 속한 칼럼], [부모 노드가 속한 칼럼], [기타 칼럼]
FROM [테이블]
START WITH [ROOT 노드가 속한 칼럼] = [ROOT 노드의 값]
CONNECT BY PRIOR [자식 노드가 속한 칼럼] = [부모 노드가 속한 칼럼];: 부모 노드부터 자식 노드로 순방향 전개

CONNECT BY PRIOR [부모 노드가 속한 칼럼] = [자식 노드가 속한 칼럼];: 자식 노드부터 부모 노드로 역방향 전개. LEVEL도 이에 맞게 변경된다.*/

SELECT LEVEL,empno,mgr,ename
FROM 사원
START WITH MGR IS NULL
CONNECT BY PRIOR empno = mgr;/*empno는 자식 노드, mgr은 부모 노드다. CONNECT BY에서 자식노드의 PRIOR, 즉 선행노드로 부모노드를 설정했으니
순방향 전개가 이루어진다.*/

SELECT LEVEL,empno,mgr,ename
FROM 사원
START WITH empno = 1008
CONNECT BY empno = PRIOR mgr;/*CONNECT BY에서 부모노드의 PRIOR, 즉 선행노드로 자식노드를 설정했으니
역방향 전개가 이루어진다.*/

/*몇가지 함수를 추가해 계층형 조회의 결과(순방향이던 역방향이던 선행노드부터 후속노드까지 순서대로 데이터를 조회)를 육안으로 이해하기 쉽게 바꾸기*/
SELECT LEVEL,LPAD(' ',4*(LEVEL-1))||empno AS 사원,mgr AS 관리자,CONNECT_BY_ISLEAF 리프데이터여부
FROM 사원
START WITH MGR IS NULL
CONNECT BY PRIOR empno = mgr
ORDER SIBLINGS BY sal DESC;/*LPAD([문자1],[숫자],[문자2]): 미리 [숫자]만큼 할당된 글자수 중 오른쪽에 [문자1]을 배치한 후 왼쪽부터 남은
글자수만큼 [문자2]를 배치. [문자2]가 없을 경우 그냥 남은 글자수만큼 공백을 배치.
LPAD(' ',4*(LEVEL-1)): 레벨이 올라갈수록 문자가 오른쪽으로 네칸씩 늘어남. 덕분에 부모노드와 자식노드 간 관계 육안으로 확실히 구분 가능*/

SELECT LEVEL,LPAD(' ',4*(LEVEL-1))||empno AS 사원,mgr AS 관리자,CONNECT_BY_ISLEAF 리프데이터여부
FROM 사원
START WITH empno = 1008
CONNECT BY empno = PRIOR mgr; /*역방향 전개*/

SELECT LEVEL,CONNECT_BY_ROOT(empno) 루트,SYS_CONNECT_BY_PATH(empno,'/') 경로, empno 사원, mgr 메니저
FROM 사원
START WITH mgr IS NULL
CONNECT BY PRIOR empno = mgr; /*CONNECT_BY_ROOT(칼럼): 계층형 데이터에서 해당 칼럼값까지 도달하는 경로의 최초 루트
SYS_CONNECT_BY_PATH(칼럼): 계층형 데이터에서 해당 칼럼값까지 도달하는 경로(루트에서부터)*/

SELECT LEVEL,CONNECT_BY_ROOT(empno) 루트,SYS_CONNECT_BY_PATH(empno,'/') 경로, mgr 메니저
FROM 사원
START WITH empno = 1008
CONNECT BY empno = PRIOR mgr; /*CONNECT_BY_ROOT(칼럼): 계층형 데이터에서 해당 칼럼값까지 도달하는 경로의 최초 루트
SYS_CONNECT_BY_PATH(칼럼): 계층형 데이터에서 해당 칼럼값까지 도달하는 경로(루트에서부터)*/

---- 셀프 조인 ----
/*셀프 조인은 한 테이블에서 두 칼럼이 서로 연관이 있을 때 사용한다. 계층형 데이터의 경우 셀프 조인을 이용해 데이터 전개의 각 경로를 하나의 테이블
로 표현할 수 있다. 사원 테이블을 예로 들어보자*/
SELECT * FROM 사원;/*EMPNO(자식)와 MGR(부모)은 연관되어 있다. */

SELECT a.empno 사원, a.mgr 관리자, b.mgr 상위관리자
FROM 사원 a LEFT OUTER JOIN 사원 b
ON a.mgr = b.empno
ORDER BY 상위관리자 DESC, 관리자, 사원; /*LEFT OUTER JOIN을 하는 이유: 사원 중 관리자가 없는 경우도 반영해야 하므로*/