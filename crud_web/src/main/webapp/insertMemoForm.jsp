<!-- insertMemoForm.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>insertMemoForm.jsp</title>
</head>
<body>
	<%
	String[] memoCategoryList = {"회사일정","부서일정","개인일정"};
	%>
	<h1>ADD MEMO</h1>
	<form action="<%=request.getContextPath()%>/insertMemoAction.jsp" method="post">
		<table border="1">
			<tr>
				<th>MEMO CATEGORY</th>
				<td>
					<select name="memoCategory">
						<%
							for(String m : memoCategoryList){
						%>
								<option value="<%=m%>"><%=m%></option>
						<% 
							}
						%>
					</select>
				</td>
			</tr>
			<tr>
				<th>MEMO TITLE</th>
				<td><input type="text" name="memoTitle"></td>
			</tr>
			<tr>
				<th>MEMO CONTENT</th>
				<td><textarea rows="5" cols="80" name="memoContent"></textarea></td>
			</tr>
		</table>
		<button type="submit">글입력</button>
	</form>
</body>
</html>