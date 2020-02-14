/*SQL*LOADER 사용해서 외부 데이터 (csv 파일)을 ORACLE DB로 호출 및 저장 (import)할 수 있음*/
/*github.com/henry7646/coding-practice/tree/master/SQL/How%20to%20Import%20CSV%20Files%20into%20Oracle%20DB.txt
 참고*/
/*이 예제에서 사용한 외부 데이터: github.com/henry7646/coding-practice/tree/master/SQL/SQLD/IMPORT/주문번호.csv*/
 
/*1. 외부 데이터를 import시킬 테이블 생성*/
TRUNCATE TABLE deliveryinfo;
DROP TABLE deliveryinfo;
CREATE TABLE deliveryinfo(
deliveryid number(20) primary key,
customerid number(20),
deliverydate timestamp,
deliveryamount number(20));
 
/*2. 외부 데이터 import하는데 필요한 컨트롤 파일 생성 (메모장에 아래 코드 기입 후 저장 시 타입 '모든 파일' 선택 후 확장자 '.ctl'로 할 것)
load data
truncate into table deliveryinfo
fields terminated by ","
trailing nullcols
(deliveryid, customerid, deliverydate, deliveryamount)

3. cmd에서 SQL*LOADER 실행 (cmd창에 아래 코드 기입 후 실행)
sqlldr [Oracle DB username]/[Oracle DB password] data='[외부데이터 파일 경로]' control='[컨트롤 파일 파일 경로]' bad='[bad 파일 파일 경로]' discard='[discard 파일 파일 경로]' log='[로그 파일 파일 경로]'
* 참고로 bad 파일의 확장자는 .bad, discard 파일의 확장자는 .dsc, 로그 파일의 확장자는 .txt다

4. 외부 데이터 성공적으로 import되었는지 SELECT문으로 확인*/
SELECT * FROM deliveryinfo;

/* 컨트롤 파일의 맨 마지막 줄에 외부 데이터를 import시킬 테이블의 칼럼명이 나오는데, 칼럼명을 전부 영어로 해야 향후 SQL*LOADER 실행 시 오류 (SQL*Loader-350)가 나지 않음
* 한글이 포함된 명칭을 가진 외부 데이터의 경우 컨트롤 파일에서 'infile '[외부 데이터 파일 경로]''을 기재하면 향후 SQL*LOADER 실행 시 오류 (Cannot Find the File) 발생하므로 SQL*LOADER 실행 시
cmd창에 'data = '[외부 데이터 파일 경로]'' 기입할 것
* SQL*LOADER로 외부 데이터 import 시 한글 깨질 때 문자셋 (NLS_CHARACTERSET) 변경하는 방법: https://blog.naver.com/intropp/10028768224
* 문자셋 (NLS_CHARACTERSET) 변경 후  ORA-06552,  ORA-06553 오류 발생 시 해결하는 방법: https://jehna.tistory.com/36 */
