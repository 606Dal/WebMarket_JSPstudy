<%@page import="java.util.Calendar"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<% request.setCharacterEncoding("UTF-8"); %>
<html>
<head>
<!-- <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css"> -->
<link rel="stylesheet" href="./resources/css/bootstrap.min.css">
<meta charset="UTF-8">
<title>웹 쇼핑몰</title>
</head>
<body>
	<jsp:include page="menu.jsp" />
	<%
		String greeting = "웹 쇼핑몰에 오신 것을 환영합니다!";
		String tagline = "Welcome to Web Market!";
	%>
	<%-- jumbotron (B5에서는 더 이상 지원되지 않음) --%>
	<div class="mt-4 p-5 bg-secondary text-white rounded">
		<div class="container">
			<h1 class="display-4"><%= greeting %></h1>
		</div>
	</div>
	<div class="container">
		<div class="text-center mt-3">
			<h3><%= tagline %></h3>
			<%
				//웹사이트의 새로고침 기능 추가
				response.setIntHeader("Refresh", 5);
				// 접속 시간을 표식하기 위한 자바 코드
				Calendar calendar = Calendar.getInstance();
				int hour = calendar.get(Calendar.HOUR_OF_DAY);
				int minute = calendar.get(Calendar.MINUTE);
				int second = calendar.get(Calendar.SECOND);
				int am_pm = calendar.get(Calendar.AM_PM);
				String ampm = (am_pm == 0) ? "오전" : "오후";
				// 0이 오전 1이 오후
				
				String cennectTime = hour + ":" + minute + ":" + second + " " + ampm;
				out.println("현재 접속 시간 : " + cennectTime);
			%>
		</div>
		<hr>
	</div>
	
	<jsp:include page="footer.jsp" />
	
	<%-- <h1><%= greeting %></h1>
	<h3><%= tagline %></h3> --%>
</body>
</html>