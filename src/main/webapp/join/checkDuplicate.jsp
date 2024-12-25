<%@ page language="java" contentType="application/json; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="org.json.simple.JSONObject"%>

<jsp:useBean id="dao" class="com.test.join.UserDAO"/>

<%
    JSONObject jsonObject = new JSONObject();

    try {
        // 1. 아이디 가져오기 및 예외 처리
        String uid = request.getParameter("uid");
        if (uid == null || uid.trim().isEmpty()) {
            jsonObject.put("ok", false);
            jsonObject.put("message", "아이디를 입력하세요.");
        } else {
            // 2. 아이디 중복 검사
            boolean isDuplicate = !dao.checkDuplicate(uid); // checkDuplicate는 중복이 없으면 true를 반환하므로 !를 붙여줍니다.
            jsonObject.put("ok", !isDuplicate); 

            if (isDuplicate) {
                jsonObject.put("message", "이미 사용 중인 아이디입니다.");
            }
        }
    } catch (Exception e) {
        jsonObject.put("ok", false);
        jsonObject.put("message", "오류가 발생했습니다.");
    }

    // 3. JSON 응답 전송
    out.print(jsonObject.toJSONString());
    out.flush();
%>