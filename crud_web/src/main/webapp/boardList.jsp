<%@page import="java.security.DomainLoadStoreParameter"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="dto.*" %>
<%
	/*
		//이부분이 개발자가 짜는 거
		Top Query : mysql : limit 키워드 사용
		한 페이지에 10행을 출력하면 : int rowPerPage = 10
		PAGE(currentPage)	첫번째매개값(start rowPerPage 배수 * page-1)	두번째매개값(rowPerPage)
		1		0									10
		2		10									10
		3		20									10
		
		한 페이지에 7행을 출력하면
		1		0		7
		2		7		7
		3		14		7		
	*/
	int rowPerPage = 10;
	int currentPage = 1;
	String paramCurrentPage = request.getParameter("currentPage");
	//paramCurrentPage null이면(매개값으로 넘어오지 않으면 currentPage = 1)
	//paramCurrentPage null이 아니면 currentPage는 변경
	if(paramCurrentPage != null){
		currentPage = Integer.parseInt(paramCurrentPage);
	}
	System.out.println("currentPage");
	int startRow = rowPerPage * (currentPage -1); //0
	
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
		sql = "select board_no, board_district, board_title, board_writer from board order by board_no desc limit ?,?"; //연결된 쿼리에 db보내줌.
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, startRow); 
		stmt.setInt(2, rowPerPage);
	}else{
		sql = "select board_no, board_district, board_title, board_writer from board where board_district=? order by board_no desc limit ?,?";
		stmt = conn.prepareStatement(sql); //매개값은 하나?
		stmt.setString(1, boardDistrict);
		stmt.setInt(2, startRow); 
		stmt.setInt(3, rowPerPage);
	}
	System.out.println("stmt: " + stmt.toString());
	
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
	
	//lastPage 로직
	String sql2 = "";
	PreparedStatement stmt2 = null;
	if(boardDistrict == null){
		sql2 = "select count(*) from board"; //매개값은 표현식으로
		stmt2 = conn.prepareStatement(sql2);
	}else{
		sql2 = "select count(*) from board where board_district=?";
		stmt2 = conn.prepareStatement(sql2);
		stmt2.setString(1, boardDistrict);
	}
	
	// PreparedStatement 디버깅(물음표 있는 것들 디버깅 해주기)
	System.out.println("stmt2: " + stmt2.toString());
	//전라도 선택시. stmt2: com.mysql.cj.jdbc.ClientPreparedStatement: select count(*) from board where board_district='전라도'
	
	ResultSet rs2 = stmt2.executeQuery();
			
	int totalCount = 0;
	if(rs2.next()){
		totalCount = rs2.getInt("count(*)");
	}
		
	System.out.println("totalCount: " + totalCount);
		
	int lastPage = totalCount / rowPerPage;
	if(totalCount % rowPerPage != 0){
		lastPage = lastPage + 1;
	}
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
	<!-- menu.jsp 이 위치에 include -->
	<jsp:include page="/menu.jsp"></jsp:include>
	
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
	
	<h1><a href="boardList.jsp" >BOARD LIST</a></h1>
	
	<div>
		<a href="<%=request.getContextPath() %>/insertBoardForm.jsp">글입력</a>
	</div>	
	<div>
		현재 페이지: <%=currentPage %> / <%=lastPage %>
	</div>
	<table border="1">
		<tr>
			<th>board_no</th>
			<th>board_district</th>
			<th>board_title</th>
			<!-- <th>board_writer</th> -->
		</tr>
		<%
			for(BoardDto b : list){
		%>
				<tr>
					<td><%=b.getBoardNo() %></td>
					<td><%=b.getBoardDistrict() %></td>
					<td>
						<a href="<%=request.getContextPath() %>/boardOne.jsp?boardNo=<%=b.getBoardNo()%>">
							<%=b.getBoardTitle() %>
						</a>		
					</td>
					<!-- <td><%=b.getBoardWriter() %></td> -->
				</tr>		
		<%		
			}
		%>
	</table>
	<!-- Paging Navigation -->
	<div>
		<!-- 이전 -->
		<%
			if(currentPage > 1){
				if(boardDistrict == null){
		%>
					<a href="<%=request.getContextPath() %>/boardList.jsp?currentPage=<%=currentPage-1%>">[이전]</a>			
		<%			
				}else{
		%>
					<a href="<%=request.getContextPath() %>/boardList.jsp?currentPage=<%=currentPage-1%>&boardDistrict=<%=boardDistrict%>">[이전]</a>
		<%			
				}	
			}
		%>
		<!-- 다음 -->
		<%
			if(currentPage < lastPage){
				if(boardDistrict == null){
		%>
					<a href="<%=request.getContextPath() %>/boardList.jsp?currentPage=<%=currentPage+1%>">[다음]</a>
		<%			
				}else{
		%>
					<a href="<%=request.getContextPath() %>/boardList.jsp?currentPage=<%=currentPage+1%>&boardDistrict=<%=boardDistrict%>">[다음]</a>
		<%			
				}
			}
		%>		
	</div>
</body>
</html>