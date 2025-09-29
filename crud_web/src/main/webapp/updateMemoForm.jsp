<!-- updateMemoForm.jsp -->
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
	String sql = "select memo_no, memo_category, memo_title, memo_content from memo where memo_no=?";
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
	}
	System.out.println(memo.toString());
	
	String[] memoCategoryList = {"회사일정", "부서일정", "개인일정"};
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>updateMemoForm.jsp</title>
</head>
<body>
	<!-- menu.jsp 이 위치에 include -->
	<jsp:include page="/menu.jsp"></jsp:include>
	<h1>UPDATE MEMO</h1>
	
	<form action="<%=request.getContextPath() %>/updateMemoAction.jsp" method="post">
	<table border="1">
	<!-- memo의 카테고리, 제목, 내용만 수정가능 -->
		<tr>
			<th>memo_no</th>
			<td>
				<input type="text" name="memoNo" value="<%=memo.getMemoNo() %>" readonly="readonly">	
			</td>
		</tr>
		<tr>
			<th>memo_category</th>			
			<td>
				<select name="memoCategory">
						<%
							for(String s : memoCategoryList){
								if(s.equals(memo.getMemoCategory())){
						%>
									<option value="<%=s %>" selected="selected"><%=s %></option>
						<%
								}else{
						%>
							
									<option value="<%=s %>"><%=s %></option>
						<%
								}
						%>
								

						<%		
							}
						%>
					</select>
			</td>			
		</tr>
		<tr>
			<th>memo_title</th>
			<td>
				<input type="text" name="memoTitle" value="<%=memo.getMemoTitle() %>">
			</td>			
		</tr>
		<tr>
			<th>memo_content</th>
			<td>
				<textarea name="memoContent" row="5" cols="50"> <%=memo.getMemoContent() %></textarea>
			</td>			
	</table>
	</form>
</body>
</html>