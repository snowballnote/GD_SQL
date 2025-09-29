<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
	String boardNo = request.getParameter("boardNo");
	System.out.println("deleteBodard#boardNo: " + boardNo);
	if(boardNo == null){
		response.sendRedirect(request.getContextPath() + "/boardList.jsp"); //다른곳으로 돌려놓고
		return; //종료
	}
	
	//boardNo인 글을 삭제
	// 1) 드라이브 로딩
	Class.forName("com.mysql.cj.jdbc.Driver");
	// 2) Mysql(RDBMS)서버 접근
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ex1","root","java1234");
	// 3) 쿼리 생성 후 실행-> 반환값
	String sql = "delete from board where board_no=?";
	PreparedStatement stmt = conn.prepareStatement(sql);
	stmt.setInt(1, Integer.parseInt(boardNo));
	int row = stmt.executeUpdate(); //1: 한행이 삭제, 0: 하나의 행도 삭제되지 않았다.
	if(row == 1){
		System.out.println("deleteBodard 삭제실패");
		response.sendRedirect(request.getContextPath() + "/boardList.jsp");
	}else if(row == 0){
		System.out.println("deleteBodard 삭제성공");
		response.sendRedirect(request.getContextPath() + "/boardOne.jsp?boardNo=" + boardNo);
	}else{
		throw new Exception("2개이상의 행이 삭제!");
	}
	
	//view가없다
%>