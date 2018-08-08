# reset-project

### version 1.0 release ( Web, App )

- App download : webview[apk]resetbeauty.7z 를 압축풀어서 사용
- project deploy : maven을 이용해 주세요 
- contributers : 김형준(hyungjoon90), 김수성(emptyDrawing), 서충희(wjbs06), 이지현(JihyunLee99)

## Instrall 

1. tomcat 7.0.9 버젼을 추천하며, 이를 루트/Tomcat/ 에 설치힌다.
2. Mysql 8.0.11 을 추천하며 이를 만들고 mydb 스키마를 만들고 첨부한 sql문을 넣어 초기 테이블은 만든다.
3. 현 Master branch를 maven Instrall 하여 만들어진 war파일을 ROOT.war 파일로 이름을 변경하고,
4. 서버에 설치한 Tomcat디렉토리 > webapps 에 옮긴다.
5. 이때 기존의 ROOT 디렉토리가 있다민 이를 삭제를 하고, Tomcat 서버를 구동한다.

## Backup

1. 서버에 올라간 사진파일들이 /Tomcat/webapps/ROOT/resource/ 아래에 저장되기 때문에 이를 미리 백업한다.
2. Mysql dummySql을 만들어둔다.
3. 서버를 중단하고, /Tomcat/webapps 디렉토리에 있는 ROOT.WAR와 ROOT 디렉토리를 지운다.
4. 루트/reset/ 디렉토리 자체를 백업한다.
5. 새로운 버젼의 ROOT.WAR 파일을 Instrall 절차에 맞쳐서 진행한다.
6. 서버를 가동하고 80포트가 정상화 되었는지 확인한다.
( Window cmd : netstat -nao  / Linux console : netstat -tnlp | grep ':80' )
7. 만약 포트가 정상화되지 않았다면 서버를 재부팅 하는 등의 조치를 취한다.


## 개발시 주의사항
1. 환경
- Java 1.8 이상
- Spring tool suite ( Version: 4.3.8 RELEASE )
- Mysql ( Version 8.0.11 )
- Apache Tomcat ( Version : 7.0.85)
- 그외 자세한 내용은 pom.xml 참고
-- mybatis, jackjon, javaxMail, jstl, commom-fileUpload 등

2. Package 구성
- ga.beauty.reset : 기본 패키지
- .controller : 컨트롤러
- .service : 서비스 계층
- .dao : Dao 모듈
- .dao.entity : Vo 및 Dto 
- .utils : vaildate, 권한체크, 계산식 등

3. commit 규칙
: [주제] 설명 / 2018-xx-xx / 이름

4. 디렉토리 설명
/Tomcat/webapps/ROOT.war : 프로젝트 war 파일
/reset/ : 사용자 행동정보 및 log파일 위치
