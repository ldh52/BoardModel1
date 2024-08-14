package com.test.model2board;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

public class UserService {

    private UserDAO userDAO;

    public UserService() {
        userDAO = new UserDAO(); 
    }

    public String processGet(HttpServletRequest request, HttpServletResponse response, String pathInfo) throws ServletException, IOException {
        switch (pathInfo) {
            case "/login":
            case "/register":
                return "/user/" + pathInfo.substring(1) + ".jsp"; 

            case "/profile":
            case "/edit":
                HttpSession session = request.getSession(false);
                if (session != null && session.getAttribute("userId") != null) {
                    String userId = (String) session.getAttribute("userId");
                    User user = getUserById(userId); 
                    request.setAttribute("user", user);
                    return "/user/" + pathInfo.substring(1) + ".jsp"; 
                } else {
                    response.sendRedirect(request.getContextPath() + "/user/login");
                    return null;
                }

            default:
                response.sendError(HttpServletResponse.SC_NOT_FOUND); 
                return null;
        }
    }

    public void processPost(HttpServletRequest request, HttpServletResponse response, String pathInfo) throws ServletException, IOException {
        switch (pathInfo) {
            case "/login": handleLogin(request, response); break;
            case "/logout": handleLogout(request, response); break;
            case "/register": handleRegister(request, response); break;
            case "/edit": handleEditProfile(request, response); break;
            case "/delete": handleDeleteAccount(request, response); break;
            default: response.sendError(HttpServletResponse.SC_NOT_FOUND); 
        }
    }

    // 로그인 처리
    private void handleLogin(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String userId = request.getParameter("userId");
        String password = request.getParameter("password");

        boolean loginSuccess = login(userId, password); 

        if (loginSuccess) {
            HttpSession session = request.getSession();
            session.setAttribute("userId", userId); 
            response.sendRedirect(request.getContextPath() + "/board/list"); 
        } else {
            request.setAttribute("errorMessage", "아이디 또는 비밀번호가 일치하지 않습니다.");
            request.getRequestDispatcher("/user/login.jsp").forward(request, response);
        }
    }

    // 로그아웃 처리
    private void handleLogout(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession(false); 
        if (session != null) {
            session.invalidate(); 
        }
        response.sendRedirect(request.getContextPath() + "/user/login.jsp"); 
    }

    // 회원가입 처리
    private void handleRegister(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	String userId = request.getParameter("userId");
        String password = request.getParameter("password"); 
        // 필요에 따라 다른 사용자 정보도 가져오기

        User user = new User(userId, password); // User 객체 생성
        // ... (다른 사용자 정보 필드 설정)

        boolean registerSuccess = register(user); 

        if (registerSuccess) {
            response.sendRedirect(request.getContextPath() + "/user/login.jsp"); 
        } else {
            request.setAttribute("errorMessage", "회원가입에 실패했습니다. 다시 시도해주세요.");
            request.getRequestDispatcher("/user/register.jsp").forward(request, response);
        }
    }

    // 프로필 수정 처리
    private void handleEditProfile(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            // 로그인하지 않은 경우 로그인 페이지로 리다이렉트
            response.sendRedirect(request.getContextPath() + "/user/login");
            return;
        }

        String userId = (String) session.getAttribute("userId");

        // 수정된 프로필 정보 가져오기 및 User 객체 업데이트
        // ... (request에서 파라미터 값 가져오기)

        User user = getUserById(userId); 
        // ... (user 객체에 수정된 정보 설정)

        boolean updateSuccess = updateProfile(user); 

        if (updateSuccess) {
            response.sendRedirect(request.getContextPath() + "/user/profile"); 
        } else {
            // 프로필 수정 실패 처리 (예: 에러 메시지와 함께 수정 페이지로 다시 이동)
            request.setAttribute("errorMessage", "프로필 수정에 실패했습니다. 다시 시도해주세요.");
            request.getRequestDispatcher("/user/edit.jsp").forward(request, response);
        }
    }

    // 회원 탈퇴 처리
    private void handleDeleteAccount(HttpServletRequest request, HttpServletResponse response) throws IOException {
    	HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            // 로그인하지 않은 경우 로그인 페이지로 리다이렉트
            response.sendRedirect(request.getContextPath() + "/user/login");
            return;
        }

        String userId = (String) session.getAttribute("userId");

        boolean deleteSuccess = deleteAccount(userId);

        if (deleteSuccess) {
            session.invalidate(); 
            response.sendRedirect(request.getContextPath() + "/user/login.jsp"); 
        } else {
            // 회원 탈퇴 실패 처리 (예: 에러 메시지와 함께 프로필 페이지로 다시 이동)
            response.sendRedirect(request.getContextPath() + "/user/profile?error=delete_failed");
        }
    }

    // 사용자 정보 조회
    private User getUserById(String userId) {
        // TODO: UserDAO를 사용하여 사용자 정보 조회 로직 구현
        return userDAO.getUserById(userId); 
    }

    // 로그인 처리
    private boolean login(String userId, String password) {
        // TODO: UserDAO를 사용하여 로그인 로직 구현
        return userDAO.login(userId, password); 
    }

    // 회원가입 처리
    private boolean register(User user) {
        // TODO: UserDAO를 사용하여 회원가입 로직 구현
        return userDAO.register(user); 
    }

    // 프로필 수정 처리
    private boolean updateProfile(User user) {
        // TODO: UserDAO를 사용하여 프로필 수정 로직 구현
        return userDAO.updateProfile(user); 
    }

    // 회원 탈퇴 처리
    private boolean deleteAccount(String userId) {
        // TODO: UserDAO를 사용하여 회원 탈퇴 로직 구현
        return userDAO.deleteAccount(userId); 
    }
}