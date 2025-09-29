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
	String sql = "select board_no, board_district, board_title, board_content from board where board_no=?";
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
	}	
	System.out.println(board.toString());
	
	String[] boardDistrictList = {"경기도", "강원도", "충청도", "전라도", "경상도", "제주도"};
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>updateBoardFrom.jsp</title>
</head>
<body>
	<!-- menu.jsp 이 위치에 include -->
	<jsp:include page="/menu.jsp"></jsp:include>
	<h1>UPDATE BOARD</h1>
	
	<form action="<%=request.getContextPath() %>/updateBoardAction.jsp" method="post">
	<table border="1">
	<!-- board의 지역, 제목, 내용만 수정가능 -->
		<tr>
			<th>board_no</th>
			<td>
				<input type="text" name="boardNo" value="<%=board.getBoardNo() %>" readonly="readonly">	
			</td>
		</tr>
		<tr>
			<th>board_district</th>			
			<td>
				<select name="boardDistrict">
						<%
							for(String s : boardDistrictList){
								if(s.equals(board.getBoardDistrict())){
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
			<th>board_title</th>
			<td>
				<input type="text" name="boardTitle" value="<%=board.getBoardTitle() %>">
			</td>			
		</tr>
		<tr>
			<th>board_content</th>
			<td>
				<textarea name="boardContent" row="5" cols="50"> <%=board.getBoardContent() %></textarea>
			</td>			
	</table>
	</form>
	<button type="submit">수정하기</button>
</body>
</html>