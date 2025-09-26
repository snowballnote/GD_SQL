<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="dto.*" %>
<%
	String boardDistrict = request.getParameter("boardDistrict");
	System.out.println("boardDistrict: " + boardDistrict);
	
	// 1) 드라이브 로딩 -> ClassNotFoundException -> 오타 or 파일위치 확인
	Class.forName("com.mysql.cj.jdbc.Driver");
	
	// 2) Mysql(RDBMS)서버 접근 -> 원래는 복붙하면되는 부분임.
	// java.sql.Connection :: class ConnectionImpl implements Connection
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ex1","root","java1234");
	System.out.println("conn: " + conn);
	
	// 3) 쿼리 생성 후 실행-> 반환값
	String sql = "";
	PreparedStatement stmt = null;
	
	if(boardDistrict == null){
		sql = "select board_no, board_district, board_title, board_writer from board order by board_no desc"; //연결된 쿼리에 db보내줌.
		stmt = conn.prepareStatement(sql);
	}else{
		sql = "select board_no, board_district, board_title, board_writer from board where board_district=? order by board_no desc";
		stmt = conn.prepareStatement(sql); //매개값은 하나?
		stmt.setString(1, boardDistrict);
	}
	
	ResultSet rs = stmt.executeQuery(); //stmt실행 table을 rs에 저장
	/*디버깅
	while(rs.next()){
		System.out.print(rs.getInt("board_no") + " ");
		System.out.print(rs.getString("board_district") + " ");
		System.out.print(rs.getString("board_title") + " ");
		System.out.println();
	}
	*/
	// 4) 특수한 자료구조(ResultSet) -> 기본API 자료구조(ArrayList) 변경하여 View Layer 기본자료구조를 사용가능하도록
	List<BoardDto> list = new ArrayList<>(); // rs자료구조의 데이터 -> list자료구조로 카피
	while(rs.next()) {
		BoardDto b = new BoardDto();
		b.setBoardNo(rs.getInt("board_no"));
		b.setBoardDistrict(rs.getString("board_district"));
		b.setBoardTitle(rs.getString("board_title"));
		b.setBoardWriter(rs.getString("board_writer"));
		list.add(b);
	}
	System.out.println(list);
	
	String[] boardDistrictList = {"경기도", "강원도", "충청도", "전라도", "경상도", "제주도"};
%>
<!-- View Layer : 전체 모델 사용한 API는 사용X, List자료구조만 사용하면 된다.-->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<!-- Navigation -->
	<div>
	<%
		 for(String bd : boardDistrictList){
	%>
			<a href="boardList.jsp?boardDistrict=<%=bd %>">[<%=bd %>]</a>
	<%		 
		 }
	%>
	</div>
	
	<h1>BOARD LIST</h1>
	
	<div>
		<a href="<%=request.getContextPath() %>/insertBoardForm.jsp">글입력</a></div>
	</div>
	<table border="1">
		<tr>
			<th>board_no</th>
			<th>board_district</th>
			<th>board_title</th>
			<th>board_writer</th>
		</tr>
		<%
			for(BoardDto b : list){
		%>
				<tr>
					<td><%=b.getBoardNo() %></td>
					<td><%=b.getBoardDistrict() %></td>
					<td><%=b.getBoardTitle() %></td>
					<td><%=b.getBoardWriter() %></td>
				</tr>		
		<%		
			}
		%>
	</table>
</body>
</html>