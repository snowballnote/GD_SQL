<!-- updateBoardAction.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
	String boardNo = request.getParameter("boardNo");
	String boardDistrict = request.getParameter("boardDistrict");
	String boardTitle = request.getParameter("boardTitle");
	String boardContent = request.getParameter("boardContent");

	Class.forName("com.mysql.cj.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ex1","root","java1234");
	String sql = "update board set board_district=?, board_title=?, board_content=? where board_no=?";
	PreparedStatement stmt = conn.prepareStatement(sql);
	stmt.setString(1, boardDistrict);
	stmt.setString(2, boardTitle);
	stmt.setString(3, boardContent);
	stmt.setInt(4, Integer.parseInt(boardNo));
	
	int row = stmt.executeUpdate(); //
	//view가 없다.
	//성공 -> boardOne 리다이렉스
	//실패 -> updateBoardForm 리다이렉트
	if(row == 1){
		response.sendRedirect(request.getContextPath() + "/boardOne.jsp?boardNo=" + boardNo);
	}else if(row == 0){
		response.sendRedirect(request.getContextPath() + "/updateBoardForm.jsp?boardNo=" + boardNo);
	}else{ //예상치 못한 상황
		throw new Exception("심각한 에러 발생");
	}
%>