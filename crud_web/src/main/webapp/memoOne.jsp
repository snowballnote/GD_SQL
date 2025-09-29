<!-- memoOne.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="dto.*" %>
<%
	String memoNo = request.getParameter("memoNo");
	System.out.println("memoNo: " + memoNo);
	if(memoNo == null){
		response.sendRedirect(request.getContextPath() + "/memoList.jsp");
		return;
	}
	
	//1)드라이브 로딩
	Class.forName("com.mysql.cj.jdbc.Driver");
	// 2) Mysql(RDBMS)서버 접근
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ex1","root","java1234");
	
	//3)쿼리 생성 후 실행
	String sql = "select memo_no, memo_category, memo_title, memo_content, createdate from memo where memo_no=?";
	PreparedStatement stmt = conn.prepareStatement(sql);
	stmt.setInt(1, Integer.parseInt(memoNo));
	System.out.println("stmt: " + stmt.toString());
	ResultSet rs = stmt.executeQuery();
	MemoDto memo = new MemoDto();
	if(rs.next()){
		memo.setMemoNo(rs.getInt("memo_no"));
		memo.setMemoCategory(rs.getString("memo_category"));
		memo.setMemoTitle(rs.getString("memo_title"));
		memo.setMemoContent(rs.getString("memo_content"));
		memo.setCreatedate(rs.getString("createdate"));
	}
	System.out.println(memo.toString());
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>memoOne.jsp</title>
</head>
<body>
	<!-- menu.jsp 이 위치에 include -->
	<jsp:include page="/menu.jsp"></jsp:include>
	
	<h1>MEMO ONE</h1>
	<table border="1">
		<tr>
			<th>memo_no</th>
			<td><%=memo.getMemoNo() %></td>
		</tr>
		<tr>
			<th>memo_category</th>
			<td><%=memo.getMemoCategory() %></td>
		</tr>
		<tr>
			<th>memo_title</th>
			<td><%=memo.getMemoTitle() %></td>
		</tr>
		<tr>
			<th>memo_content</th>
			<td><%=memo.getMemoContent() %></td>
		</tr>
		<tr>
			<th>createdate</th>
			<td><%=memo.getCreatedate() %></td>
		</tr>
	</table>
	<div>
		<a href="<%=request.getContextPath()%>/updateMemoForm.jsp?memoNo=<%=memo.getMemoNo()%>">[수정]</a>
		<a href="<%=request.getContextPath()%>/deleteMemo.jsp?memoNo=<%=memo.getMemoNo()%>">[삭제]</a>
	</div>
</body>
</html>