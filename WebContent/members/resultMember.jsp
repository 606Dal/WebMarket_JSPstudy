<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="../resources/css/bootstrap.min.css">
<meta charset="UTF-8">
<title>회원 정보</title>
</head>
<body>
	<jsp:include page="/menu.jsp" />
	<div class="my-4 p-5 bg-secondary text-white rounded">
		<div class="container">
			<h1 class="display-4">회원 정보</h1>
		</div>
	</div>
	
	<div class="container">
		<% 
			String msg = request.getParameter("msg");
		
			if(msg != null){
				if(msg.equals("0")){
					out.println("<h2 class='alert alert-danger'>회원 정보가 수정되었습니다.</h2>");
				}
				else if(msg.equals("1")){
					out.println("<h2 class='alert alert-danger'>회원 가입을 축하드립니다. 로그인 해주세요.</h2>");
				}
				else if(msg.equals("2")){
					String loginId = (String)session.getAttribute("sessionId");
					out.println("<h2 class='alert alert-info'>"+ loginId + "님 환영합니다.</h2>");
				}
				else if(msg.equals("3")){
					String loginId = (String)session.getAttribute("sessionId");
					out.println("<h2 class='alert alert-info'>로그아웃 하셨습니다.</h2>");
				}
			} //null 값이 오면
			else{
					out.println("<h2 class='alert alert-danger'>회원 정보가 삭제되었습니다.</h2>");
				
			}
		%>
	
	</div>

</body>
</html>