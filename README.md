# BoardModel1
HTML Tags<br>
EL/JSTL<br>
Thymeleaf<br>
JSP개발방법론 Model1<Servlet 제외, JSP와 Java만으로 사이트 제작)<br>
-JSP 중심 개발<br>
<br>
JSP:useBean 사용하여 자바 객체 생성<br>
Model 1을 사용한 게시판 프로젝트<br>

서버에서 사용할 프로젝트만 체크<br>

# Transaction
- DB가 일괄적으로 처리해야 하는 작업단위<br>
- 한 개의 Transaction 안에는 다수개 SQL이 포함될 수 있다<br>
- Transaction 안의 모든 SQL이 성공할 때 그 작업이 성공한 것이다.<br>
- 구성 SQL이 하나라도 실패하면 작업단위 안의 성공한 SQL도 취소해야 한다.<br>
- 오류 없이 Transaction이 성공하면 모든 SQL 문장의 결과를 영구적으로 반영해야 한다.<br>
- commit(): Transaction이 성공했을 때 호출Transaction
- rollback(): Transaction안의 한 개의 SQL이라도 실패한 경우에 모든 SQL을 취소한다.<br>
<br>
SQL Developer에서는 개발자가 명시적으로 commit(), rollback() 명령해 주어야 한다.<br>
Java(JDBC)에서는 자동으로 한 문장마다 commit()이 호출된다.<br>
<br>

웹페이지를 쉽게 태그만 사용하여 작성하는 기술<br>
HTML이 사용되는 곳에서 Java 코드를 배제한다<br><br>
# EL(Expression Language)
<br>
게시글 상세보기 페이지를 EL을 사용하여 변경해보세요.<br>

# JSTL(JSP Standard Tag Library)
https://repo.maven.apache.org/maven2/jakarta/servlet/jsp/jstl/jakarta.servlet.jsp.jstl-api/2.0.0/jakarta.servlet.jsp.jstl-api-2.0.0.jar
<br>
https://repo.maven.apache.org/maven2/org/glassfish/web/jakarta.servlet.jsp.jstl/2.0.0/jakarta.servlet.jsp.jstl-2.0.0.jar<br><br>

# 모델1 게시판 프로젝트 -> 모델2 변환
- JSP에서 EL,JSP 사용<br>
- Servlet 추가<br>
- Service 추가<br>
- JSP 고쳐서 사용<br>
- DAO 그대로 사용<br>
- VO 그대로 사용<br>

