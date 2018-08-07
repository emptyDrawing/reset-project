# reset-project
=============================

### version 1.0 release ( Web, App )

- App download : webview[apk]resetbeauty.7z 를 압축풀어서 사용
- project deploy : maven을 이용해 주세요 
- contributers : 김형준(hyungjoon90), 김수성(emptyDrawing), 서충희(wjbs06), 이지현(JihyunLee99)

=============================
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
