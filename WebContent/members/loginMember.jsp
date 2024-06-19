<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="../resources/css/bootstrap.min.css">
<meta charset="UTF-8">
<title>로그인</title>
</head>
<body>
	<jsp:include page="/menu.jsp" />
	<%-- jumbotron (B5에서는 더 이상 지원되지 않음) --%>
	<div class="my-4 p-5 bg-secondary text-white rounded">
		<div class="container">
			<h1 class="display-4">로그인</h1>
		</div>
	</div>
	
	<%! int cnt = 0; %>
	
	<div class="container" align="center">
		<div class="col-md-6">
			<h3 class="form-signin-heading">Please sign in</h3>
			<% 
				//로그인 인증에서 실패했을 때 작동하는 코드
				String error = request.getParameter("error");
				if(error != null){
					if(cnt == 3) {
						out.println("<div class='alert alert-danger'>");
						out.println("존재하는 아이디가 없습니다.<br>회원가입을 해주세요.");
						out.println("</div>");
					} else{
						out.println("<div class='alert alert-danger'>");
						out.println("아이디와 비밀번호를 확인해 주세요!");
						out.println("</div>");
					}
				cnt++;
				}
			%>
			<form class="form-signin" action="processLoginMember.jsp" method="post">
				<div class="form-group">
					<label for="inputUserName" class="visually-hidden">User Name</label>
					<input type="text" class="form-control" placeholder="아이디" name="id" required autofocus >
				</div>
				<div class="form-group mt-2">
					<label for="inputPassword" class="visually-hidden">Password</label>
					<input type="password" class="form-control" placeholder="비밀번호" name="password" required >
				</div>
				<div class="d-grid mt-2">
					<%-- btn-lg 버튼 크기, success 초록색 --%>
					<button class="btn btn-lg btn-success btn-block" type="submit">로그인</button>
				</div>
			</form>
		</div>
	</div>

</body>
</html>