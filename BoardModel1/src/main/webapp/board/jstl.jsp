<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="javax.print.attribute.HashAttributeSet"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Arrays"%>
<%@ page import="java.util.Date"%>
<%@ page import="com.test.join.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%
   User u = new User("smith", "smithpwd");
   Date today = new Date();
   int price = 1234567;
   List<String> list = (List<String>)Arrays.asList("A","B","C","D","E");
   List<User> users = new ArrayList<>();
   users.add(new User("smith", "smithpwd"));
   users.add(new User("james", "jamespwd"));
   
   Map<String, User> map = new HashMap<>();
   map.put("smith", new User("smith", "smithpwd"));
   map.put("james", new User("james", "jamespwd"));
%>

<c:set var="user" value="<%=u%>"/>
<c:set var="today" value="<%=today%>" scope="page"/>
<c:set var="price" value="<%=price%>"/>
<c:set var="str" value="<%=list%>"/>
<c:set var="users" value="<%=users%>"/>
<c:set var="umap" value="<%=map%>"/>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JSTL (JSP Standard Tag Library)</title>

</head>
<body>
<c:forEach var="item" items="${umap}">
	<div>아이디:${item.key}, 암호:${item.value.pwd}
	</div>
</c:forEach>
<br>

<%
	for(String s : list) { %>
	<%=s%>
<% } 
%>
<p>
<c:forEach var="s" items="${str}" varStatus="status">
	<div>&nbsp; ${status.index+1}.${s}</div>
</c:forEach>
<p>


<c:forEach var="u" items="${users}" varStatus="status">
	<div>&nbsp; ${status.index+1}.${u.uid}, ${u.pwd}
	</div>
</c:forEach>


<p>
${user}
<p>
${today}
<p>
<fmt:formatDate var="today2" value="${today}" pattern="yyyy-MM-dd HH:mm:ss"/>
오늘은 ${today2}
<p>
price : <fmt:formatNumber value="${price}" type="currency" currencySymbol="\\"/>
</body>
</html>