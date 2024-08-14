package com.test.model2board;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class BoardService {

	private BoardDAO boardDAO;
    private Connection conn; // 데이터베이스 연결 객체
    private PreparedStatement pstmt;
    private ResultSet rs;

    public BoardService() {
        boardDAO = new BoardDAO(); 
    }

    public String process(HttpServletRequest request, int pageNum, int pageSize) {
        String uri = request.getRequestURI();
        String[] tokens = uri.split("/");
        String action = tokens.length > 0 ? tokens[tokens.length - 1] : ""; // 안전하게 action 값 가져오기

        String sortBy = request.getParameter("sortBy");
        String keyword = request.getParameter("keyword");

        int startRow = (pageNum - 1) * pageSize;
        List<Board> boardList = null;
        int totalBoardCount = 0;
        String viewPage = null;

        HttpServletResponse response = null;
		switch (action) {
            case "list": // 일반 게시판 목록 요청
            	if (sortBy != null) {
            	    switch (sortBy) {
            	    case "latest":
            	        	boardList = boardDAO.getBoardList(startRow, pageSize); 
            	            break;
            	        case "popularity":
            	            boardList = boardDAO.getBoardListByPopularity(startRow, pageSize); 
            	            break;
            	        default:
            	            boardList = boardDAO.getBoardList(startRow, pageSize); 
            	    }
            	} else {
            	    boardList = boardDAO.getBoardList(startRow, pageSize); 
            	}
                totalBoardCount = boardDAO.getTotalBoardCount();
                viewPage = "/model2board/list.jsp";
                break;

            case "search": // 검색 요청
            	boardList = boardDAO.searchBoards(keyword, startRow, pageSize);
            	totalBoardCount = boardDAO.getSearchBoardCount(keyword);
                viewPage = "/model2board/search.jsp";
                break;

            case "detail": // 게시글 상세 조회
                int bnum = Integer.parseInt(request.getParameter("bnum"));
                Board board = boardDAO.getBoard(bnum);
                String loggedInUser = (String) request.getSession().getAttribute("userId");
                request.setAttribute("board", board);
                request.setAttribute("loggedInUser", loggedInUser);
                viewPage = "/model2board/detail.jsp";
                break;

            case "add": // 게시글 추가
            	// 게시글 데이터 가져오기 및 Board 객체 생성
            	String title = request.getParameter("title");
            	String contents = request.getParameter("contents");
            	String author = (String) request.getSession().getAttribute("uid"); // 세션에서 작성자 정보 가져오기

            	board = new Board();
            	board.setTitle(title);
            	board.setContents(contents);
            	board.setAuthor(author);
            	// 작성일 설정 (필요한 경우)

            	// 게시글 추가 및 리다이렉트
            	bnum = boardDAO.addBoard(board);
            	try {
                    response.sendRedirect(request.getContextPath() + "/board/detail?bnum=" + bnum);
                } catch (IOException e) {
                    // TODO: 예외 처리 (로그 기록, 에러 페이지 등)
                    e.printStackTrace();
                }
                break;
			
            case "edit": // 게시글 수정
                if (request.getMethod().equalsIgnoreCase("GET")) {
                	bnum = Integer.parseInt(request.getParameter("bnum"));
                	board = boardDAO.getBoard(bnum);
                	request.setAttribute("board", board);
                    loggedInUser = (String) request.getSession().getAttribute("userId");
                    request.setAttribute("loggedInUser", loggedInUser);
                    viewPage = "/model2board/edit.jsp";
                } else if (request.getMethod().equalsIgnoreCase("POST")) {
                	// 폼 데이터 가져오기 및 Board 객체 업데이트
                	bnum = Integer.parseInt(request.getParameter("bnum"));
                	title = request.getParameter("title");
                	contents = request.getParameter("contents");

                	board = boardDAO.getBoard(bnum); // 기존 게시글 정보 가져오기
                	board.setTitle(title);
                	board.setContents(contents);

                	// 수정 처리 및 리다이렉트
                	loggedInUser = (String) request.getSession().getAttribute("userId");
                	boolean updated = boardDAO.updateBoard(board, loggedInUser); // 권한 검증 포함하여 수정

                	if (updated) {
                	    try
						{
							response.sendRedirect(request.getContextPath() + "/board/detail?bnum=" + bnum);
						} catch (IOException e)
						{
							// TODO Auto-generated catch block
							e.printStackTrace();
						} 
                	} else {
                	    // 수정 실패 처리 (예: 에러 메시지와 함께 수정 페이지로 다시 이동)
                	    request.setAttribute("errorMessage", "수정 권한이 없거나 오류가 발생했습니다.");
                	    try
						{
							request.getRequestDispatcher("/board/edit.jsp?bnum=" + bnum).forward(request, response);
						} catch (ServletException e)
						{
							// TODO Auto-generated catch block
							e.printStackTrace();
						} catch (IOException e)
						{
							// TODO Auto-generated catch block
							e.printStackTrace();
						} 
                	}
                }
                break;

            case "delete": // 게시글 삭제
            	bnum = Integer.parseInt(request.getParameter("bnum"));

            	// 사용자 인증 및 권한 검증 (예시)
            	loggedInUser = (String) request.getSession().getAttribute("uid");
            	if (loggedInUser == null) {
            	    return null; 
            	} 
            	// 추가적으로, 현재 사용자가 게시글 작성자인지 또는 관리자인지 확인하는 로직 필요

            	boolean deleted = boardDAO.deleteBoard(bnum, loggedInUser); // 권한 검증 포함하여 삭제

            	if (deleted) {
            	    try
					{
						response.sendRedirect(request.getContextPath() + "/board/list");
					} catch (IOException e)
					{
						// TODO Auto-generated catch block
						e.printStackTrace();
					} 
            	} else {
            	    // 삭제 실패 처리 (예: 에러 메시지와 함께 목록 페이지로 다시 이동)
            	    request.setAttribute("errorMessage", "삭제 권한이 없거나 오류가 발생했습니다.");
            	    try
					{
						request.getRequestDispatcher("/board/list.jsp").forward(request, response);
					} catch (ServletException e)
					{
						// TODO Auto-generated catch block
						e.printStackTrace();
					} catch (IOException e)
					{
						// TODO Auto-generated catch block
						e.printStackTrace();
					} 
            	}
                break;

            default:
                throw new IllegalArgumentException("Invalid action: " + action);
        }

        // request에 필요한 정보 저장 (list, search 경우에만 해당)
        if (action.equals("list") || action.equals("search")) {
            request.setAttribute("boardList", boardList);
            request.setAttribute("totalBoardCount", totalBoardCount);
            request.setAttribute("pageNum", pageNum);
            request.setAttribute("pageSize", pageSize);
            request.setAttribute("sortBy", sortBy); 
            request.setAttribute("keyword", keyword); 
        }
        return viewPage; 
    }
}