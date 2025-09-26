<!-- insertMemoAction.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
	//Controller Layer
	String memoNo = request.getParameter("memoNo");
	String memoCategory = request.getParameter("memoCategory");
	String memoTitle = request.getParameter("memoTitle");
	String memoContent = request.getParameter("memoContent");
	
	Class.forName("com.mysql.cj.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ex1","root","java1234");
	String sql = "insert into memo(memo_no, memo_category, memo_title, memo_content) values(?,?,?,?)";
	
	PreparedStatement stmt = conn.prepareStatement(sql);
	stmt.setString(1, memoNo);
	stmt.setString(2, memoCategory);
	stmt.setString(3, memoTitle);
	stmt.setString(4, memoContent);
	int row = stmt.executeUpdate(); //1이면 입력성공 0이면 실패
	
	//글입력에 성공하면 보여줄 내용이 존재하지 않는다.
	//View Layer가 없다 -> 아무것도 보이지 않는 뷰를 보내고 클라이언트에게 /boardList.jsp 재요청
	response.sendRedirect(request.getContextPath() + "/memoList.jsp");
%>