<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		String[] boardDistrictList = {"경기도", "강원도", "충청도", "전라도", "경상도", "제주도"};
	%>
	<h1>ADD BOARD</h1>
	<form action="<%=request.getContextPath()%>/insertBoardAction.jsp" method="post">
		<table border="1">
			<tr>
				<th>BOARD</th>
				<td>
					<select name="boardDistrict">
						<%
							for(String s : boardDistrictList){
						%>
								<option value="<%=s %>"><%=s %></option>
						<%		
							}
						%>
					</select>
				</td>
			</tr>
			<tr>
				<th>BOARD TITLE</th>
				<td><input type="text" name="boardTitle"></td>
			</tr>
			<tr>
				<th>BOARD CONTENT</th>
				<td><textarea rows="5" cols="80" name="boardContent"></textarea></td>
			</tr>
			<tr>
				<th>BOARD WRITER</th>
				<td><input type="text" name="boardWriter"></td>
			</tr>
		</table>
		<button type="submit">글입력</button>
	</form>
</body>
</html>