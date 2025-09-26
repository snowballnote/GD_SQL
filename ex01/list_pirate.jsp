<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %> <!-- ArrayList는 java.util.ArrayList로 치환. -->
<%@ page import="dto.PirateDto" %>

<%
	ArrayList<PirateDto> list = new ArrayList<>();

	PirateDto luffy = new PirateDto();
	luffy.name = "몽키 D. 루피";
	luffy.gender = "남";
	luffy.age = 19;
	luffy.isFruit = true;
	list.add(luffy);

	PirateDto zoro = new PirateDto();
	zoro.name = "로로노아 조로";
	zoro.gender = "남";
	zoro.age = 21;
	zoro.isFruit = false;
	list.add(zoro);

	PirateDto nami = new PirateDto();
	nami.name = "나미";
	nami.gender = "여";
	nami.age = 20;
	nami.isFruit = false;
	list.add(nami);

	PirateDto usopp = new PirateDto();
	usopp.name = "우솝";
	usopp.gender = "남";
	usopp.age = 19;
	usopp.isFruit = false;
	list.add(usopp);

	PirateDto sanji = new PirateDto();
	sanji.name = "상디";
	sanji.gender = "남";
	sanji.age = 21;
	sanji.isFruit = false;
	list.add(sanji);

	PirateDto chopper = new PirateDto();
	chopper.name = "토니토니 쵸파";
	chopper.gender = "남";
	chopper.age = 17;
	chopper.isFruit = true;
	list.add(chopper);

	PirateDto robin = new PirateDto();
	robin.name = "니코 로빈";
	robin.gender = "여";
	robin.age = 30;
	robin.isFruit = true;
	list.add(robin);

	PirateDto franky = new PirateDto();
	franky.name = "프랑키";
	franky.gender = "남";
	franky.age = 36;
	franky.isFruit = false;
	list.add(franky);

	PirateDto brook = new PirateDto();
	brook.name = "브룩";
	brook.gender = "남";
	brook.age = 90;
	brook.isFruit = true;
	list.add(brook);

	PirateDto jinbe = new PirateDto();
	jinbe.name = "징베";
	jinbe.gender = "남";
	jinbe.age = 46;
	jinbe.isFruit = false;
	list.add(jinbe);

%>

<!DOCTYPE html>

<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<table border="1">
		<tr>
			<th>이름</th>
			<th>성별</th>
			<th>나이</th>
			<th>악마의열매</th>
		</tr>
		<%
			for(PirateDto p : list){
		%>
				<tr>
					<td><%=p.name%></td>
					<td><%if(p.gender == "남"){
		%>
			<span>&#128130;</span>
		<%			
				}else{
		%>
			<span>&#128131;</span>
		<%
				}
		%>
					</td>
					<td><%=p.age%></td>
					<td><%=p.isFruit%></td>
				</tr>
		<%
			}
		%>
	</table>
</body>
</html>