package com.test.model2board;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/board/list") 
public class BoardListServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {

        // 페이지 번호 및 페이지 크기 설정 (기본값 또는 파라미터에서 가져오기)
        int pageNum = 1;
        int pageSize = 10;
        
        String pageNumStr = request.getParameter("pageNum");
        if (pageNumStr != null && !pageNumStr.isEmpty()) {
            pageNum = Integer.parseInt(pageNumStr);
        }

        String pageSizeStr = request.getParameter("pageSize");
        if (pageSizeStr != null && !pageSizeStr.isEmpty()) {
            pageSize = Integer.parseInt(pageSizeStr);
        }

        // BoardService를 사용하여 게시글 목록 조회
        BoardService boardService = new BoardService();
        String viewPage = boardService.process(request, pageNum, pageSize);

        // JSP로 포워딩
        request.getRequestDispatcher(viewPage).forward(request, response);
    }
}