<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
/*
* 1. 랜덤 1~6 숫자 생성
* 2. 1~6 숫자 결과에 따라 이미지 분기 출력 one.jpg~six.jpg
*/
	int num = (int)(Math.random() * 6) + 1; //
	
	//디버깅 => 코드확인.
	System.out.println(num);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주사위 게임</title>
</head>
<body>
	<%
		if(num == 1){
	%>
			<img src="/ex1/images/one.jpg" height="200" width="200"><!-- height="200" width="200"이거는 잘 안쓰는 방법임 -->
	<%
		}else if(num == 2){
	%>
			<img src="/ex1/images/two.jpg" height="200" width="200">
	<%
		}else if(num == 3){
	%>
			<img src="/ex1/images/three.jpg" height="200" width="200">
	<%
		}else if(num == 4){
	%>
			<img src="/ex1/images/four.jpg" height="200" width="200">
	<%	
		}else if(num == 5){
	%>
			<img src="/ex1/images/five.jpg" height="200" width="200">
	<%
		}else if(num == 6){
	%>
			<img src="/ex1/images/six.jpg" height="200" width="200">
	<%			
		}
	%>
</body>
</html>