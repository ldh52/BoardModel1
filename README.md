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

# 모델 1 게시판 코드 리스트
Model 1 아키텍처를 기반으로 하는 게시판 프로젝트의 Java 코드와 JSP 코드 목록, 그리고 각 파일의 주요 기능을 간략하게 설명합니다. <br>

## Java 코드
+ com.test.join.UserVO<br>
사용자 정보를 저장하는 VO (Value Object) 또는 DTO (Data Transfer Object) 클래스입니다.<br>
uid, pwd, name, email, regdate 등의 필드와 getter/setter 메서드를 포함합니다.<br>

+ com.test.join.UserDAO<br>
사용자 관련 데이터베이스 작업을 처리하는 DAO (Data Access Object) 클래스입니다.<br>
login, add, checkDuplicate, getList, getDetail, updatePwd, delete 등의 메서드를 포함합니다.<br>
데이터베이스 연결 및 쿼리 실행, 결과 처리 등의 기능을 수행합니다.<br>

+ com.test.join.MemberVO<br>
회원 가입 시 입력받은 정보를 저장하는 VO 또는 DTO 클래스입니다.<br>
uid, pwd, gender, hobby, history, age, birth, intro 등의 필드와 getter/setter 메서드를 포함합니다.<br>
문자열 형식의 데이터를 적절한 타입으로 변환하는 기능도 포함합니다.<br>

+ com.test.model1board.Board<br>
게시글 정보를 저장하는 VO 또는 DTO 클래스입니다.<br>
bnum, title, author, contents, rdate, hit 등의 필드와 getter/setter 메서드를 포함합니다.<br>

+ com.test.model1board.BoardDAO<br>
게시글 관련 데이터베이스 작업을 처리하는 DAO 클래스입니다.<br>
addBoard, getBoard, getBoardList, increaseHit, updateBoard, deleteBoard, getTotalBoardCount, getBoardList(int, int), searchBoards, getSearchBoardCount 등의 메서드를 포함합니다.<br>
데이터베이스 연결 및 쿼리 실행, 결과 처리 등의 기능을 수행합니다.<br>

## JSP 코드

+ index.jsp<br>
게시판 프로젝트의 메인 페이지입니다.<br>
게시판 제목, 로그인/로그아웃, 게시글 입력, 게시글 목록 링크 등을 포함합니다.<br>
로그인 상태에 따라 표시되는 링크를 동적으로 제어합니다.<br>
다른 JSP 페이지를 포함하여 실제 내용을 표시합니다. (<jsp:include page="${viewPage}" />)<br>

+ boardList.jsp<br>
게시글 목록을 표시하는 페이지입니다.<br>
BoardDAO를 사용하여 게시글 목록을 조회하고 테이블 형태로 출력합니다.<br>
각 게시글의 제목을 클릭하면 boardDetail.jsp로 이동합니다.<br>
로그인한 사용자에게는 게시글 수정 및 삭제 링크를 표시합니다.<br>
페이징 처리, 검색 기능 등을 추가하여 개선할 수 있습니다.<br>

+ boardDetail.jsp<br>
특정 게시글의 상세 내용을 표시하는 페이지입니다.<br>
BoardDAO를 사용하여 게시글 정보를 조회하고 출력합니다.<br>
조회수를 증가시키는 로직을 포함합니다.<br>
로그인한 사용자에게는 게시글 수정 및 삭제 버튼을 표시합니다.<br>

+ boardAddForm.jsp<br>
게시글 작성 폼을 제공하는 페이지입니다.<br>
폼 제출 시 게시글 정보를 데이터베이스에 저장하고 목록 페이지로 이동합니다.<br>
사용자 입력값 검증 로직을 포함해야 합니다.<br>

+ boardEditForm.jsp<br>
게시글 수정 폼을 제공하는 페이지입니다.<br>
특정 게시글 번호에 해당하는 게시글 정보를 조회하여 수정 폼에 미리 채워 넣습니다.<br>
폼 제출 시 게시글 정보를 데이터베이스에 업데이트하고 상세 페이지로 이동합니다.<br>
사용자 인증 및 권한 검증, 입력값 검증 로직을 포함해야 합니다.<br>

+ deleteBoard.jsp<br>
삭제 확인 대화상자를 표시하고, 확인 시 AJAX 요청을 통해 deleteBoardProc.jsp에 게시글 번호를 전달합니다.<br>
deleteBoardProc.jsp에서 반환된 JSON 응답을 처리하여 삭제 성공/실패 메시지를 표시하고 페이지를 새로고침하거나 이전 페이지로 이동합니다.<br>

+ deleteBoardProc.jsp<br>
실제 게시글 삭제 로직을 처리하고 JSON 형식으로 결과를 반환합니다.<br>
사용자 인증 및 권한 검증 로직을 포함해야 합니다.<br>

+ loginForm.jsp<br>
로그인 폼을 제공하는 페이지입니다.<br>
폼 제출 시 사용자 정보를 데이터베이스에서 검증하고, 로그인 성공 시 세션에 사용자 정보를 저장하고 메인 페이지로 이동합니다.<br>
입력값 검증 로직을 포함해야 합니다.<br>

+ userLogin.jsp<br>
실제 로그인 처리 로직을 수행하고 JSON 형식으로 결과를 반환합니다.<br>
데이터베이스에서 사용자 정보를 조회하고, 입력된 아이디와 비밀번호가 일치하는지 확인합니다.<br>
로그인 성공 시 세션에 사용자 정보를 저장합니다.<br>

+ logout.jsp<br>
세션을 무효화하고 메인 페이지로 이동합니다.<br>

+ joinForm.jsp<br>
회원 가입 폼을 제공하는 페이지입니다.<br>
폼 제출 시 사용자 정보를 데이터베이스에 저장하고 메인 페이지로 이동합니다.<br>
아이디 중복 검사, 비밀번호 유효성 검사, 입력값 검증 로직을 포함해야 합니다.<br>

+ formProc.jsp<br>
실제 회원 가입 처리 로직을 수행하고 JSON 형식으로 결과를 반환합니다.<br>
데이터베이스에 사용자 정보를 저장합니다.<br>

+ checkDuplicate.jsp<br>
입력된 아이디의 중복 여부를 확인하고 JSON 형식으로 결과를 반환합니다.<br>


# 도서구매 사이트(장바구니)
- book 테이블(no, title, author, publisher, pubdate, pages, price, cover)
- book 테이블에 10권 분량의 도서 정보를 저장한다(SQL Developer에서 수동으로 도서정보 추가)
- 도서의 주제는 아래의 항목 참조
- html,css,javascript,java,jsp,servlet,python, bigdata, oracle, machine learning
- HTML5, 스티븐 홀즈너, 제이펍, 2011.05.10, 354, 36000, html5.jpg
- bookIndex.jsp 페이지에서 [도서목록] 메뉴 클릭 > 목록 페이지 표시 > 도서 아이템 클릭 > 상세보기 페이지 표시
- 상세보기 화면에서 구매 수량을 입력하고 [장바구니에 담기] 클릭 > "장바구니에 담기 성공"
- 모델1

# Java
- BookVO.java
- BookDAO.java
- CartVO.java
- BookCart.java
- BookDeleteServlet.java
- CartDAO.java
- CartItem.java

# JSP
- bookDelete, bookDetail, bookindex, bookinsert, booklist, bookUpdate, cart, cartADD, order, showCart, updateQty

# jsp/img

