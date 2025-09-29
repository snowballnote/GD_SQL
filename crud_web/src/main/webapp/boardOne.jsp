<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "dto.*" %>
<%
	String boardNo = request.getParameter("boardNo");
	System.out.println("boardNo: " + boardNo);
	if(boardNo == null){
		response.sendRedirect(request.getContextPath() + "/boardList.jsp"); //다른곳으로 돌려놓고
		return; //종료
	}
	
	// 1) 드라이브 로딩
	Class.forName("com.mysql.cj.jdbc.Driver");
	// 2) Mysql(RDBMS)서버 접근
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ex1","root","java1234");
	
	// 3) 쿼리 생성 후 실행-> 반환값
	String sql = "select board_no, board_district, board_title, board_content, board_writer, createdate from board where board_no=?";
	PreparedStatement stmt = conn.prepareStatement(sql);
	stmt.setInt(1, Integer.parseInt(boardNo));
	System.out.println("stmt: " + stmt.toString());
	ResultSet rs = stmt.executeQuery();
	BoardDto board = new BoardDto();
	if(rs.next()){
		board.setBoardNo(rs.getInt("board_no"));
		board.setBoardDistrict(rs.getString("board_district"));
		board.setBoardTitle(rs.getString("board_title"));
		board.setBoardContent(rs.getString("board_content"));
		board.setBoardWriter(rs.getString("board_writer"));
		board.setCreatedate(rs.getString("createdate"));		
	}	
	System.out.println(board.toString());
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>boardOne.jsp</title>
</head>
<body>
	<h1>BOARD ONE</h1>
	<table border="1">
		<tr>
			<th>board_no</th>
			<td><%=board.getBoardNo() %></td>
		</tr>
		<tr>
			<th>board_district</th>
			<td><%=board.getBoardDistrict() %></td>			
		</tr>
		<tr>
			<th>board_title</th>
			<td><%=board.getBoardTitle() %></td>			
		</tr>
		<tr>
			<th>board_content</th>
			<td><%=board.getBoardContent() %></td>			
		</tr>
		<tr>
			<th>board_writer</th>
			<td><%=board.getBoardWriter() %></td>			
		</tr>
		<tr>
			<th>createdate</th>
			<td><%=board.getCreatedate() %></td>		
		</tr>
	</table>
	<div>
		<a href="<%=request.getContextPath()%>/updateBoardForm.jsp?boardNo=<%=board.getBoardNo()%>">[수정]</a>
		<a href="<%=request.getContextPath()%>/deleteBoard.jsp?boardNo=<%=board.getBoardNo()%>">[삭제]</a>
	</div>
</body>
</html>