package com.test.model1board;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

public class BoardDAO {
    private Connection conn;
    private PreparedStatement pstmt;
    private ResultSet rs;

    private Connection getConn() {
        try {
            Class.forName("oracle.jdbc.OracleDriver");
            conn = DriverManager.getConnection(
                    "jdbc:oracle:thin:@localhost:1521:xe", "SCOTT", "TIGER");
            return conn;
        } catch (Exception e) {
            e.printStackTrace(); 
        }
        return null;
    }

    // 게시글 추가
    public int addBoard(Board b) {
        conn = getConn();
        if (conn == null) { // 연결 실패 시 0 반환
            return 0;
        }

        String sql = "INSERT INTO board1(bnum,title,author,contents,rdate,hit) "
                + "VALUES(board1_num_seq.NEXTVAL, ?,?,?,?,0) "
                + "RETURNING bnum INTO ?";
        try {
            CallableStatement cstmt = conn.prepareCall("{call " + sql + "}");

            cstmt.setString(1, b.getTitle());
            cstmt.setString(2, b.getAuthor());
            cstmt.setString(3, b.getContents());
            cstmt.setDate(4, b.getRdate());

            cstmt.registerOutParameter(5, Types.INTEGER);

            int rows = cstmt.executeUpdate();
            int bnum = cstmt.getInt(5);

            return bnum;

        } catch (SQLException sqle) {
            sqle.printStackTrace(); // 실제 운영 환경에서는 로깅 프레임워크를 사용하여 오류 기록
        } finally {
            closeAll();
        }
        return 0;
    }

    // 번호로 게시글 조회
    public Board getBoard(int bnum) {
        conn = getConn();
        if (conn == null) {
            return null;
        }

        String sql = "SELECT * FROM board1 WHERE bnum=?";
        try {
            pstmt = conn.prepareStatement(sql);

            pstmt.setInt(1, bnum);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                Board b = new Board();
                b.setBnum(rs.getInt("BNUM"));
                b.setTitle(rs.getString("TITLE"));
                b.setAuthor(rs.getString("AUTHOR"));
                b.setContents(rs.getString("CONTENTS"));
                b.setRdate(rs.getDate("RDATE"));
                b.setHit(rs.getInt("HIT"));
                return b;
            }
        } catch (SQLException sqle) {
            sqle.printStackTrace(); // 실제 운영 환경에서는 로깅 프레임워크를 사용하여 오류 기록
        } finally {
            closeAll();
        }
        return null;
    }

    // 게시글 목록 보기
    public List<Board> getBoardList() {
        conn = getConn();
        if (conn == null) {
            return null;
        }

        String sql = "SELECT * FROM board1 ORDER BY bnum";
        try {
            pstmt = conn.prepareStatement(sql);

            rs = pstmt.executeQuery();
            List<Board> list = new ArrayList<Board>();
            while (rs.next()) {
                Board b = new Board();
                b.setBnum(rs.getInt("BNUM"));
                b.setTitle(rs.getString("TITLE"));
                b.setAuthor(rs.getString("AUTHOR"));
                b.setContents(rs.getString("CONTENTS"));
                b.setRdate(rs.getDate("RDATE"));
                b.setHit(rs.getInt("HIT"));
                list.add(b);
            }
            return list;
        } catch (SQLException sqle) {
            sqle.printStackTrace(); // 실제 운영 환경에서는 로깅 프레임워크를 사용하여 오류 기록
        } finally {
            closeAll();
        }
        return null;
    }

    // 게시글 수정
    public boolean updateBoard(Board b) {
        conn = getConn();
        if (conn == null) {
            return false;
        }

        String sql = "UPDATE board1 SET title=?, contents=? WHERE bnum=?";
        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, b.getTitle());
            pstmt.setString(2, b.getContents());
            pstmt.setInt(3, b.getBnum());

            int rowsAffected = pstmt.executeUpdate();
            return rowsAffected > 0;

        } catch (SQLException e) {
            e.printStackTrace(); 
            return false;
        } finally {
            closeAll();
        }
    }

    // 게시글 삭제
    public boolean deleteBoard(int bnum) {
        conn = getConn();
        if (conn == null) {
            return false;
        }

        String sql = "DELETE FROM board1 WHERE bnum=?";
        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, bnum);

            int rowsAffected = pstmt.executeUpdate();
            return rowsAffected > 0;

        } catch (SQLException e) {
            e.printStackTrace(); 
            return false;
        } finally {
            closeAll();
        }
    }

    private void closeAll() {
        try {
            if (rs != null) rs.close();
        } catch (Exception e) {
            e.printStackTrace(); // 실제 운영 환경에서는 로깅 프레임워크를 사용하여 오류 기록
        } finally {
            try {
                if (pstmt != null) pstmt.close();
            } catch (Exception e) {
                e.printStackTrace(); // 실제 운영 환경에서는 로깅 프레임워크를 사용하여 오류 기록
            } finally {
                try {
                    if (conn != null) conn.close();
                } catch (Exception e) {
                    e.printStackTrace(); // 실제 운영 환경에서는 로깅 프레임워크를 사용하여 오류 기록
                }
            }
        }
    }
}