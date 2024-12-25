<%@ page language="java" contentType="application/json; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="org.json.simple.JSONObject"%>

<jsp:useBean id="board" class="com.test.model1board.Board"/>
<jsp:setProperty name="board" property="*"/>

<c:set var="author" value="${sessionScope.uid}" /> <%-- 세션에서 사용자 ID 가져오기 --%>
<c:set var="currentDate" value="<%= new java.sql.Date(new java.util.Date().getTime()) %>" /> <%-- 현재 날짜 설정 --%>

<jsp:setProperty name="board" property="author" value="${author}" /> <%-- 작성자 설정 --%>
<jsp:setProperty name="board" property="rdate" value="${currentDate}" /> <%-- 작성일 설정 --%>

<jsp:useBean id="dao" class="com.test.model1board.BoardDAO"/>

<%
    int bnum = dao.addBoard(board);
    boolean saved = bnum > 0;

    JSONObject jsObj = new JSONObject();
    jsObj.put("saved", saved);
    jsObj.put("bnum", bnum);
    out.print(jsObj.toJSONString());
    out.flush();
%>