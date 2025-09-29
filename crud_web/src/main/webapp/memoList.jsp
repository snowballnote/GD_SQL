<!-- memoList.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="dto.*" %>
<%
	int rowPerPage = 10;
	int currentPage = 1;
	String paramCurrentPage = request.getParameter("currentPage");
	if(paramCurrentPage != null){
		currentPage = Integer.parseInt(paramCurrentPage);
	}
	System.out.println("currentPage");
	int startRow = rowPerPage * (currentPage - 1);
	
	String memoCategory = request.getParameter("memoCategory");
	System.out.println("memoCategory: " + memoCategory);
	
	// 1) 드라이브 로딩 -> ClassNotFoundException -> 오타 or 파일위치확인
	Class.forName("com.mysql.cj.jdbc.Driver");
	
	// 2) 서버접근
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ex1","root","java1234");
	System.out.println("conn: " + conn);
	
	// 3) 쿼리 생성 후 실행-> 반환값
	String sql = "";
	PreparedStatement stmt = null;
	
	if(memoCategory == null){
		sql = "select memo_no, memo_category, memo_title, memo_content from memo order by memo_no desc limit ?,?"; //연결된 쿼리에 db보내줌.
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, startRow);
		stmt.setInt(2, rowPerPage);
	}else{
		sql = "select memo_no, memo_category, memo_title, memo_content from memo where memo_category=? order by memo_no desc limit ?,?"; //연결된 쿼리에 db보내줌.
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, memoCategory);
		stmt.setInt(2, startRow);
		stmt.setInt(3, rowPerPage);
	}
	
	ResultSet rs = stmt.executeQuery();

	//4)ResultSet
	List<MemoDto> list = new ArrayList<>();
	while(rs.next()){
		MemoDto m = new MemoDto();
		m.setMemoNo(rs.getInt("memo_no"));
		m.setMemoCategory(rs.getString("memo_category"));
		m.setMemoTitle(rs.getString("memo_title"));
		m.setMemoContent(rs.getString("memo_content"));
		list.add(m);
	}
	System.out.println(list);
	
	//lastPage 로직
	String sql2 = "";
	PreparedStatement stmt2 = null;
	if(memoCategory == null){
		sql2 = "select count(*) from memo";
		stmt2 = conn.prepareStatement(sql2);
	}else{
		sql2 = "select count(*) from memo where memo_category=?";
		stmt2 = conn.prepareStatement(sql2);
		stmt2.setString(1, memoCategory);
	}
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
	
	String[] memoCategoryList = {"회사일정", "부서일정", "개인일정"};
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>memoList.jsp</title>
</head>
<body>
	<div>
	<%
		for(String mc: memoCategoryList){
	%>
			<a href="memoList.jsp?memoCategory=<%=mc %>">[<%=mc %>]</a>	
			
	<%		
		}
	%>
	</div>
	
	<h1><a href="memoList.jsp">MEMO LIST</a></h1>
	
	<div>
		<a href="<%=request.getContextPath() %>/insertMemoForm.jsp">글입력</a>
	</div>
	<div>
		현재 페이지: <%=currentPage %> / <%=lastPage %>
	</div>
	<table border="1">
		<tr>
			
		</tr>
		<tr>
			<th>memo_no</th>
			<th>memo_category</th>
			<th>memo_title</th>
			<!-- <th>memo_content</th> -->
		</tr>	
		<%
			for(MemoDto m : list){
		%>
				<tr>
					<td><%=m.getMemoNo() %></td>
					<td><%=m.getMemoCategory() %></td>
					<td>
							<a href="<%=request.getContextPath() %>/memoOne.jsp?memoNo=<%=m.getMemoNo() %>">
								<%=m.getMemoTitle() %>
							</a>
					</td>
					<!-- <td><%=m.getMemoContent() %></td> -->
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
				if(memoCategory == null){
		%>
					<a href="<%=request.getContextPath() %>/memoList.jsp?currentPage=<%=currentPage-1%>">[이전]</a>			
		<%			
				}else{
		%>
					<a href="<%=request.getContextPath() %>/memoList.jsp?currentPage=<%=currentPage-1%>&memoCategory=<%=memoCategory%>">[이전]</a>
		<%			
				}	
			}
		%>
		<!-- 다음 -->
		<%
			if(currentPage < lastPage){
				if(memoCategory == null){
		%>
					<a href="<%=request.getContextPath() %>/memoList.jsp?currentPage=<%=currentPage+1%>">[다음]</a>
		<%			
				}else{
		%>
					<a href="<%=request.getContextPath() %>/memoList.jsp?currentPage=<%=currentPage+1%>&memoCategory=<%=memoCategory%>">[다음]</a>
		<%			
				}
			}
		%>		
	</div>
</body>
</html>