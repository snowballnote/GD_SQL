<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>


<%	
	// ---------------------- Controller Layer
	//1) 출력할 달력의 년/월 값이 외부에서 전달되지 않은 경우, 기본값으로 오늘 날짜를 사용하기 위해 today 객체를 생성
	Calendar today = Calendar.getInstance(); // 현재 시스템의 날짜와 시간을 가지는 달력 객체
	// 실제로 화면에 출력할 달력을 담을 객체를 선언
	// 기본값은 today와 동일하게 '오늘 날짜'로 설정됨
	// 이후 set(), add() 메서드를 사용해 원하는 연/월로 변경할 수 있음
	Calendar targetDay = Calendar.getInstance(); 
	
	// ----------------------Model Layer
	// 2) 만약 출력할 달력의 년/월 매개값으로 전달 받는다면
	String targetYear = request.getParameter("targetYear");
	String targetMonth = request.getParameter("targetMonth");
	System.out.println("targetYear: " + targetYear);
	System.out.println("targetMonth: " + targetMonth);
	
	//targetYear and targetMonth 전달받지 못하면 today==targetCalendar, 전달받으면 today!=targetCalendar
	if(targetYear != null && targetMonth != null){
		targetDay.set(Calendar.YEAR, Integer.parseInt(targetYear));
		targetDay.set(Calendar.MONTH, Integer.parseInt(targetMonth));
	}
	System.out.println("today: " + today.get(Calendar.YEAR) + " " +today.get(Calendar.MONTH)+ " " +today.get(Calendar.DATE));
	System.out.println("targetDay: " + targetDay.get(Calendar.YEAR) + " " +targetDay.get(Calendar.MONTH)+ " " +targetDay.get(Calendar.DATE));
	
	// 3) targetDay가 확정되고 나면, targetDay의 1일 -> 1일의 요일 -> startBlank
	Calendar firstDay = targetDay;
	int firstDate = 1; //첫번째날짜
	firstDay.set(Calendar.DATE, 1);// 날짜를 1일로 변경
	int firstYo = firstDay.get(Calendar.DAY_OF_WEEK); //첫번째날자의 요일
	int startBlank = firstYo - 1;
	
	// 4) targetDay의 마지막 날짜 데이터 -> 1일의 요일 -> endBlank
	Calendar lastDay = targetDay;
	int lastDate = lastDay.getActualMaximum(Calendar.DAY_OF_MONTH);
	lastDay.set(Calendar.DATE, lastDate); //마지막 날짜로 바꿔주고
	int lastYo = lastDay.get(Calendar.DAY_OF_WEEK); //마지막 날짜의 요일.
	int endBlank = 7 - lastYo;
	
	System.out.println("lastDate: " + lastDate);
	System.out.println("startBlank: " + startBlank);
	System.out.println("endBlank: " + endBlank);
	
	int totalTd = startBlank + lastDate + endBlank;
%>
<%
	//if(targetYear == null || targetMonth == null){
	//targetYear = today.get(Calendar.YEAR) + ""; //targetYear가 String타입이여서 int타입인 today.000을 +""으로 숫자나 다른 타입을 문자열(String)으로 변환
	//targetMonth = today.get(Calendar.MONTH) + "";
	//}
%>

<!-- View Layer -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>달력</title>
</head>
<body>
	<!-- menu.jsp 이 위치에 include -->
	<jsp:include page="/menu.jsp"></jsp:include>
	
	<h1>
		<a href="<%=request.getContextPath()%>/memoDiary.jsp?targetYear=<%=targetDay.get(Calendar.YEAR)%>&targetMonth=<%=targetDay.get(Calendar.MONTH)-1%>">[이전달]</a>
		<%=targetDay.get(Calendar.YEAR)%>년<%=targetDay.get(Calendar.MONTH)+1%>월
		<a href="<%=request.getContextPath()%>/memoDiary.jsp?targetYear=<%=targetDay.get(Calendar.YEAR)%>&targetMonth=<%=targetDay.get(Calendar.MONTH)+1%>">[다음달]</a>
	</h1>
	<table border="1">
		<tr>
			<th><span style="color:#FF0000;">일</span></th>
			<th>월</th>
			<th>화</th>
			<th>수</th>
			<th>목</th>
			<th>금</th>
			<th><span style="color:#0000FF">토</span></th>
		</tr>
		<%
			for(int i = 1; i <= totalTd; i++){
				if(i > 1 && i % 7 == 1){ //i==1에도 </tr><tr>
		%>
					</tr><tr><!-- 행바뀜 -->
		<%		
				}				
				int d = i-startBlank;
				if(d > 0 && d <= lastDate){
					//d 출력 + 일정 출력
					//일정 날짜 포맷, d포맷 일치
					String ymd = targetDay.get(Calendar.YEAR) + "-";
					if(targetDay.get(Calendar.MONTH) < 10){
						ymd = ymd + "0" + targetDay.get(Calendar.MONTH) + "-";
					}else{
						ymd = ymd + targetDay.get(Calendar.MONTH) + "-";
					}
					
					if(d<10){
						ymd = ymd + "0" + d;
					}else{
						ymd = ymd + d;	
					}
					// 2025-9-7 --> 2025-09-07 : SimpleDateFormat API 사용
					//SimpleDateFormat format1 = new SimpleDateFormat("yyyy-M-d");
					//SimpleDateFormat format2 = new SimpleDateFormat("yyyy-MM-dd");
		%>
					<td>
						<%
							if(i % 7 == 1){
						%>
								<div style="color:#FF0000"><%=d %></div>
						<%	
							}else if(i % 7 == 0){
						%>
								<div style="color:#0000FF"><%=d %></div>
						<%		
							}else if(targetDay.get(Calendar.YEAR) == today.get(Calendar.YEAR) && targetDay.get(Calendar.MONTH) == today.get(Calendar.MONTH)){
								if(i == today.get(Calendar.DATE) + 1){
						%>
									<div style="color:#00FF00"><%=d %></div>
						<%		
								}else{
						%>			
									<div><%=d %></div>
						<%
								}	
							}else{
						%>
								<div><%=d %></div>
						<%		
							}
						%>
					</td>
		<%			
				}else{
					//공백 출력
		%>
					<td>&nbsp;</td>
		<%
				}
			}
		%>
	</table>
</body>
</html>