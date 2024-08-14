package exeModel1;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BoardDAO {

	private String writer;
	
    public static List<BoardVO> getList() throws SQLException, ClassNotFoundException {
        List<BoardVO> boardList = new ArrayList<>(); 

        Connection conn = DBConn.getConnection(); // 데이터베이스 연결
        String sql = "SELECT * FROM board ORDER BY board_id DESC"; // 게시글 목록 조회 쿼리
        PreparedStatement pstmt = conn.prepareStatement(sql);
        ResultSet rs = pstmt.executeQuery();

        while (rs.next()) { // 조회된 결과 처리
            BoardVO vo = new BoardVO();
            vo.setBoardId(rs.getInt("board_id"));
            vo.setTitle(rs.getString("title"));
            vo.setContent(rs.getString("content"));
            vo.setWriter(rs.getString("writer"));
            vo.setRegDate(rs.getTimestamp("reg_date"));
            vo.setRegDate(rs.getTimestamp("mod_date"));
            boardList.add(vo); 
        }

        rs.close();
        pstmt.close();
        conn.close(); 

        return boardList; 
    }
    
    public static BoardVO getView(int boardId) throws SQLException, ClassNotFoundException {
        BoardVO vo = null;

        Connection conn = DBConn.getConnection(); // 데이터베이스 연결
        String sql = "SELECT * FROM board WHERE board_id = ?"; // 게시글 조회 쿼리
        PreparedStatement pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1, boardId); 
        ResultSet rs = pstmt.executeQuery();

        if (rs.next()) { // 조회된 결과 처리
            vo = new BoardVO();
            vo.setBoardId(rs.getInt("board_id"));
            vo.setTitle(rs.getString("title"));
            vo.setContent(rs.getString("content"));
            vo.setWriter(rs.getString("writer"));
            vo.setRegDate(rs.getTimestamp("reg_date"));
            vo.setModDate(rs.getTimestamp("mod_date"));
        }

        rs.close();
        pstmt.close();
        conn.close(); 

        return vo; 
    }
      

    public String getWriter() {
        return writer;
    }
        
        
}

