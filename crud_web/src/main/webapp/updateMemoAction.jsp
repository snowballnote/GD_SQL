<!-- updateMemoAction.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
	String memoNo = request.getParameter("memoNo");
	String memoCategory = request.getParameter("memoCategory");
	String memoTitle = request.getParameter("memoTitle");
	String memoContent = request.getParameter("memoContent");

	Class.forName("com.mysql.cj.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ex1","root","java1234");
	String sql = "update memo set memo_category=?, memo_title=?, memo_content=? where memo_no=?";
	PreparedStatement stmt = conn.prepareStatement(sql);
	stmt.setString(1, memoCategory);
	stmt.setString(2, memoTitle);
	stmt.setString(3, memoContent);
	stmt.setInt(4, Integer.parseInt(memoNo));
	
	int row = stmt.executeUpdate(); //
	//view가 없다.
	//성공 -> boardOne 리다이렉스
	//실패 -> updateBoardForm 리다이렉트
	if(row == 1){
		response.sendRedirect(request.getContextPath() + "/memone.jsp?memoNo=" + memoNo);
	}else if(row == 0){
		response.sendRedirect(request.getContextPath() + "/updateMemoForm.jsp?memoNo=" + memoNo);
	}else{ //예상치 못한 상황
		throw new Exception("심각한 에러 발생");
	}
%>