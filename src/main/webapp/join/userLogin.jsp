<%@ page language="java" contentType="application/json; charset=UTF-8" 
   pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<jsp:useBean id="user" class="com.test.join.User"/>
<jsp:setProperty name="user" property="*"/>
<jsp:useBean id="dao" class="com.test.join.UserDAO"/>

<%
	boolean ok = dao.login(user);
	if(ok) session.setAttribute("uid", user.getUid());
%>
{"ok":<%=ok%>}