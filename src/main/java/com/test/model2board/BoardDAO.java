package com.test.model2board;

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
            sqle.printStackTrace(); 
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

    // 게시글 상세 조회 (조회수 증가 포함)
    public void increaseHit(int bnum)
	{
    	String sql = "UPDATE board SET hit = hit + 1 WHERE bnum = ?";

        try (Connection conn = getConn();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, bnum);
            pstmt.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
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
    
    // 페이징 처리를 위한 게시글 목록 조회
 	// 전체 게시글 개수 조회
    public int getTotalBoardCount() {
        int count = 0;
        String sql = "SELECT COUNT(*) FROM board"; // 전체 게시글 개수 조회 쿼리

        try (Connection conn = getConn(); 
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) { 

            if (rs.next()) {
                count = rs.getInt(1); // 첫 번째 컬럼(COUNT(*)) 값 가져오기
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return count;
    }
 	
    // 페이징 처리된 게시글 목록 조회
    public List<Board> getBoardList(int startRow, int pageSize) {
        List<Board> boardList = new ArrayList<>();
        String sql = "SELECT * FROM board ORDER BY bnum DESC LIMIT ?, ?"; 

        try (Connection conn = getConn();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, startRow); 
            pstmt.setInt(2, pageSize);

            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    Board board = new Board();
                    board.setBnum(rs.getInt("bnum"));
                    board.setTitle(rs.getString("title"));
                    board.setAuthor(rs.getString("author"));
                    board.setRdate(rs.getDate("rdate"));
                    board.setHit(rs.getInt("hit"));
                    board.setContents(rs.getString("contents"));
                    boardList.add(board);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace(); 
        }
        return boardList;
    }
 	
    // 검색기능 추가
 	public List<Board> searchBoards(String keyword, int startRow, int pageSize) {
 	    List<Board> boardList = new ArrayList<>();
 	    String sql = "SELECT * FROM board WHERE title LIKE ? OR contents LIKE ? ORDER BY bnum DESC LIMIT ?, ?";

 	    try (Connection conn = getConn();
 	         PreparedStatement pstmt = conn.prepareStatement(sql)) {

 	        pstmt.setString(1, "%" + keyword + "%"); // 제목 검색
 	        pstmt.setString(2, "%" + keyword + "%"); // 내용 검색
 	        pstmt.setInt(3, startRow); 
 	        pstmt.setInt(4, pageSize);

 	        try (ResultSet rs = pstmt.executeQuery()) {
 	            while (rs.next()) {
 	                Board board = new Board();
 	                board.setBnum(rs.getInt("bnum"));
 	                board.setTitle(rs.getString("title"));
 	                board.setAuthor(rs.getString("author"));
 	                board.setRdate(rs.getDate("rdate"));
 	                board.setHit(rs.getInt("hit"));
 	                board.setContents(rs.getString("contents"));
 	                boardList.add(board);
 	            }
 	        }
 	    } catch (SQLException e) {
 	        e.printStackTrace(); // 예외 처리 (로그 출력 등)
 	    }
 	    return boardList;
 	}

 	// 키워드로 검색된 게시글의 총 개수
 	public int getSearchBoardCount(String keyword) {
 	    int count = 0;
 	    String sql = "SELECT COUNT(*) FROM board WHERE title LIKE ? OR contents LIKE ?";

 	    try (Connection conn = getConn();
 	         PreparedStatement pstmt = conn.prepareStatement(sql)) {

 	        pstmt.setString(1, "%" + keyword + "%"); // 제목 검색
 	        pstmt.setString(2, "%" + keyword + "%"); // 내용 검색

 	        try (ResultSet rs = pstmt.executeQuery()) {
 	            if (rs.next()) {
 	                count = rs.getInt(1); // 첫 번째 컬럼(COUNT(*)) 값 가져오기
 	            }
 	        }
 	    } catch (SQLException e) {
 	        e.printStackTrace(); // 예외 처리 (로그 출력 등)
 	        // 필요에 따라 예외를 다시 던지거나 사용자에게 오류 메시지를 표시할 수 있습니다.
 	    }
 	    return count;
 	}

	private void closeAll() {
        try {
            if (rs != null) rs.close();
        } catch (Exception e) {
            e.printStackTrace(); 
        } finally {
            try {
                if (pstmt != null) pstmt.close();
            } catch (Exception e) {
                e.printStackTrace(); 
            } finally {
                try {
                    if (conn != null) conn.close();
                } catch (Exception e) {
                    e.printStackTrace(); 
                }
            }
        }
    }

	public List<Board> getBoardListByPopularity(int startRow, int pageSize)
	{
		// TODO Auto-generated method stub
		return null;
	}

	public boolean updateBoard(Board board, String loggedInUser)
	{
		// TODO Auto-generated method stub
		return false;
	}

	public boolean deleteBoard(int bnum, String loggedInUser)
	{
		// TODO Auto-generated method stub
		return false;
	}
}