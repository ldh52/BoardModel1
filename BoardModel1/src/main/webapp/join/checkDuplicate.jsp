<%@ page language="java" contentType="application/json; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<jsp:useBean id="dao" class="com.test.join.UserDAO"/>
{"ok":<%=dao.checkDuplicate(request.getParameter("uid"))%>}