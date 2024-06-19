<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<% request.setCharacterEncoding("UTF-8"); %>
<html>
<head>
<link rel="stylesheet" href="./resources/css/bootstrap.min.css">
<meta charset="UTF-8">
<title>로그인</title>
</head>
<body>
	<jsp:include page="menu.jsp" />
	<%-- jumbotron (B5에서는 더 이상 지원되지 않음) --%>
	<div class="mt-4 p-5 bg-secondary text-white rounded">
		<div class="container">
			<h1 class="display-4">로그인</h1>
		</div>
	</div>
	
	<div class="container mt-4" align="center">
		<div class="col-md-4">
			<h3 class="form-signin-heading">Please sign in</h3>
			
			<% 
				//로그인 인증에서 실패했을 때 작동하는 코드
				String error = request.getParameter("error");
				if(error != null){
					out.println("<div class='alert alert-danger'>");
					out.println("아이디와 비밀번호를 확인해 주세요!");
					out.println("</div>");
				}
			%>
			<form class="form-signin" action="j_security_check" method="post">
				<%-- 아이디를 입력하는 부분 --%>
				<div class="form_group">
					<label for="inputUserName" class="visually-hidden">User Name</label>
					<input type="text" class="form-control" placeholder="ID"
						   name='j_username' required autofocus>
				</div>
				<%-- 비밀번호를 입력하는 부분 --%>
				<div class="form_group">
					<%-- 기존의 sr-only클래스는 부트스트랩5에서는 visually-hidden으로 변경됨.
					웹접근성을 위한 코드이며 역할은 Lable 내용을 숨김.--%>
					<label for="inputPassword" class="visually-hidden">Password</label>
					<input type="password" class="form-control" placeholder="Password"
						   name='j_password' required>
				</div>
				<%-- grid 있어야 버튼 크기가 위에 2개랑 같아짐 --%>
				<div class="d-grid">
					<%-- btn-lg 버튼 크기, success 초록색 --%>
					<button class="btn btn-lg btn-success btn-block" type="submit">로그인</button>
				</div>
			</form>
		</div>
	</div>
</body>
</html>