package com.test.model2board;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

/**
 * 사용자 관련 요청을 처리하는 서블릿입니다.
 * 로그인, 로그아웃, 회원가입, 프로필 수정, 회원 탈퇴 기능을 제공합니다.
 */
@WebServlet("/user/*")
public class UserServlet extends HttpServlet {

    private UserService userService;

    @Override
    public void init() throws ServletException {
        super.init();
        userService = new UserService(); // UserService 객체 생성
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String pathInfo = request.getPathInfo();
        if (pathInfo == null) {
            pathInfo = "/";
        }

        String viewPage = userService.processGet(request, response, pathInfo); 

        if (viewPage != null) {
            request.getRequestDispatcher(viewPage).forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String pathInfo = request.getPathInfo();
        if (pathInfo == null) {
            pathInfo = "/";
        }

        userService.processPost(request, response, pathInfo); 
    }
}