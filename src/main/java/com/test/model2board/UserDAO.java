package com.test.model2board;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UserDAO {

    private Connection conn;
    private PreparedStatement pstmt;
    private ResultSet rs;

    // 데이터베이스 연결 가져오기 (getConn() 메서드는 BoardDAO와 동일하게 사용 가능)
    private Connection getConn() {
        try {
            Class.forName("oracle.jdbc.OracleDriver"); // JDBC 드라이버 로드
            conn = DriverManager.getConnection(
                    "jdbc:oracle:thin:@localhost:1521:xe", "SCOTT", "TIGER"); // Oracle 연결 정보
            return conn;
        } catch (Exception e) {
            e.printStackTrace(); // 예외 처리 (로그 출력 등)
        }
        return null;
    }


    // 사용자 정보 조회
    public User getUserById(String userId) {
        conn = getConn();
        if (conn == null) {
            return null;
        }

        String sql = "SELECT * FROM users WHERE userId = ?"; // users 테이블과 userId 컬럼 사용 가정
        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, userId);

            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    User user = new User();
                    user.setUserId(rs.getString("userId"));
                    // ... (다른 사용자 정보 필드 설정 - User 클래스의 필드에 맞게 설정)
                    return user;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace(); // 로그 출력 등 예외 처리
        } finally {
            closeAll();
        }

        return null;
    }

    // 로그인 처리
    public boolean login(String userId, String password) {
        conn = getConn();
        if (conn == null) {
            return false;
        }

        String sql = "SELECT * FROM users WHERE userId = ? AND password = ?"; 
        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, userId);
            pstmt.setString(2, password); // 실제 환경에서는 비밀번호 암호화 필요

            try (ResultSet rs = pstmt.executeQuery()) {
                return rs.next(); // 로그인 성공 여부 반환
            }
        } catch (SQLException e) {
            e.printStackTrace(); // 로그 출력 등 예외 처리
        } finally {
            closeAll();
        }

        return false;
    }

    // 회원가입 처리
    public boolean register(User user) {
        conn = getConn();
        if (conn == null) {
            return false;
        }

        String sql = "INSERT INTO users (userId, password, ...) VALUES (?, ?, ...)"; // 필요한 컬럼 추가
        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, user.getUserId());
            pstmt.setString(2, user.getPassword()); // 실제 환경에서는 비밀번호 암호화 필요
            // ... (다른 사용자 정보 필드 설정 - User 클래스의 필드에 맞게 설정)

            int rowsAffected = pstmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace(); // 로그 출력 등 예외 처리
        } finally {
            closeAll();
        }

        return false;
    }

    // 프로필 수정 처리
    public boolean updateProfile(User user) {
        conn = getConn();
        if (conn == null) {
            return false;
        }

        String sql = "UPDATE users SET ... WHERE userId = ?"; // 수정할 필드 및 조건 설정
        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            // ... (수정할 필드 값 설정 - User 클래스의 필드에 맞게 설정)
            pstmt.setString(1, user.getUserId());

            int rowsAffected = pstmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace(); // 로그 출력 등 예외 처리
        } finally {
            closeAll();
        }

        return false;
    }

    // 회원 탈퇴 처리
    public boolean deleteAccount(String userId) {
        conn = getConn();
        if (conn == null) {
            return false;
        }

        String sql = "DELETE FROM users WHERE userId = ?";
        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, userId);

            int rowsAffected = pstmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace(); // 로그 출력 등 예외 처리
        } finally {
            closeAll();
        }

        return false;
    }

    // 자원 해제
    private void closeAll() {
        try {
            if (rs != null) rs.close();
        } catch (SQLException e) {
            e.printStackTrace(); 
        } finally {
            try {
                if (pstmt != null) pstmt.close();
            } catch (SQLException e) {
                e.printStackTrace(); 
            } finally {
                try {
                    if (conn != null) conn.close();
                } catch (SQLException e) {
                    e.printStackTrace(); 
                }
            }
        }
    }
}