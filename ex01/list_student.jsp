<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %> <!-- ArrayList는 java.util.ArrayList로 치환. -->
<%@ page import="java.lang.*" %>

<%
	java.util.ArrayList<String> studentList = new java.util.ArrayList<String>();
	studentList.add("공성웅");
	studentList.add("권순표");
	studentList.add("김서희");
	studentList.add("김정민");
	studentList.add("김준기");
	studentList.add("문윤정");
	studentList.add("조수현");
	studentList.add("이준문");
	studentList.add("정순오");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<ol>
		<%
			for(String n : studentList){
		%>
			<li><%=n%></li> <!-- jsp표현식 -->
		<%
			}
		%>
	</ol>
	
</body>
</html>