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
BoardModel1_CodeList 참조<br>

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

# 도서구매 사이트(장바구니): Model1BookCart
- book 테이블(no, title, author, publisher, pubdate, pages, price, cover)
- book 테이블에 10권 분량의 도서 정보를 저장한다(SQL Developer에서 수동으로 도서정보 추가)
- 도서의 주제는 아래의 항목 참조
- html,css,javascript,java,jsp,servlet,python, bigdata, oracle, machine learning
- HTML5, 스티븐 홀즈너, 제이펍, 2011.05.10, 354, 36000, html5.jpg
- bookIndex.jsp 페이지에서 [도서목록] 메뉴 클릭 > 목록 페이지 표시 > 도서 아이템 클릭 > 상세보기 페이지 표시
- 상세보기 화면에서 구매 수량을 입력하고 [장바구니에 담기] 클릭 > "장바구니에 담기 성공"
- 모델1
- Model1BookCart_CodeList 참조<br>


# 장바구니 모델1 (Java, Servlet, JSP) 코드 리스트 요약

## Java 클래스
+ BookVO.java: 책 정보를 저장하는 Value Object 클래스. equals 및 hashCode 메서드를 구현하여 객체 비교를 가능하게 합니다.<br>
+ BookCart.java: 장바구니 기능을 구현하는 클래스. 책 추가, 삭제, 수량 변경, 총 가격 계산 등의 기능을 제공합니다.<br>
+ BookDAO.java: 데이터베이스와의 상호작용을 담당하는 데이터 액세스 객체(DAO). 책 정보 조회, 삽입, 수정, 삭제 기능을 제공합니다.<br>
+ CartItem.java: 장바구니에 담긴 개별 상품 항목을 나타내는 클래스. 책 정보와 구매 수량을 저장합니다.<br>

## Servlet
+ BookDeleteServlet.java: 책 삭제 요청을 처리하는 서블릿. BookDAO를 사용하여 데이터베이스에서 책 정보를 삭제합니다.<br>

## JSP 페이지
+ bookIndex.jsp: 도서 관리 시스템의 메인 페이지. "도서 목록" 메뉴를 통해 bookList.jsp 페이지로 이동할 수 있습니다.<br>
+ bookInsert.jsp: 새로운 책 정보를 등록하는 페이지. 폼을 통해 사용자 입력을 받고, BookDAO를 사용하여 데이터베이스에 책 정보를 삽입합니다.<br>
+ bookList.jsp: 데이터베이스에서 조회한 도서 목록을 표 형태로 보여주는 페이지. 각 도서 항목에는 상세 정보 페이지로 이동하는 링크가 포함됩니다.<br>
+ bookDetail.jsp: 특정 책의 상세 정보를 보여주는 페이지. BookDAO를 사용하여 데이터베이스에서 책 정보를 조회하고, 사용자가 "장바구니에 담기" 버튼을 클릭하면 해당 책을 장바구니에 추가합니다.<br>
+ showCart.jsp: 사용자의 장바구니에 담긴 상품 목록을 표 형태로 보여주는 페이지. 각 상품의 정보와 총 가격을 표시하고, 상품 수량 변경 및 삭제 기능을 제공합니다.<br>
+ cartAdd.jsp: AJAX 요청을 처리하여 장바구니에 상품을 추가하는 페이지. (Model 2 아키텍처에서는 CartAddServlet으로 대체될 수 있습니다.)<br>
+ updateQty.jsp: AJAX 요청을 처리하여 장바구니 아이템의 수량을 변경하는 페이지. (Model 2 아키텍처에서는 CartUpdateServlet으로 대체될 수 있습니다.)<br>
+ order.jsp: 장바구니에 담긴 상품을 주문하는 페이지. 사용자 정보, 배송 정보, 결제 정보 입력 및 주문 처리 로직을 포함합니다.<br>


