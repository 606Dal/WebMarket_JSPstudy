<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 아이디(코드) 오류</title>
<link rel="stylesheet" href="./resources/css/bootstrap.min.css">
</head>
<body>
	<jsp:include page="menu.jsp" />
	<%-- jumbotron (B5에서는 더 이상 지원되지 않음) --%>
	<div class="mt-4 p-5 bg-secondary text-white rounded">
		<div class="container">
			<h2 class="alert alert-danger">해당 상품이 존재하지 않습니다.</h2>
		</div>
	</div>

	<div class="container">
		<%-- 요청 URL을 표식하고 아울러 요청 파라메터의 값도 같이 표식 하고 있는 부분--%>
		<p><%= request.getRequestURL() %>?<%= request.getQueryString() %>
		<p> <a href="products.jsp" class="btn btn-secondary">상품 목록 &raquo;</a>
	</div>
	
</body>
</html>