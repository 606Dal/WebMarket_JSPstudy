<%@page import="java.net.URLDecoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% 
	String shipping_cartId = "";
	String shipping_name = "";
	String shipping_shippingDate = "";
	String shipping_country = "";
	String shipping_zipCode = "";
	String shipping_addressName = "";
	
	//모든 쿠키로 설정된 내용을 쿠키배열로 받아온다.
	Cookie[] cookies = request.getCookies();
	
	if(cookies != null) {
		for(int i=0; i<cookies.length; i++){
			Cookie thisCookie = cookies[i];
			String str = thisCookie.getName(); //쿠키의 이름을 가져오고 있음
			
			//URLDecoder클래스를 이용하여 문자셋을 다시 맞추어서 가져오고 있음 (운영체제에 따라서 다르기 때문)
			if(str.equals("Shipping_cartId")){
				shipping_cartId = URLDecoder.decode(thisCookie.getValue(), "utf-8");
			}
			if(str.equals("Shipping_shippingDate")){
				shipping_shippingDate = URLDecoder.decode(thisCookie.getValue(), "utf-8");
			}
		}
	}
%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="./resources/css/bootstrap.min.css">
<meta charset="UTF-8">
<title>주문 완료</title>
</head>
<body>
	<jsp:include page="menu.jsp" />
	<div class="my-4 p-5 bg-secondary text-white rounded">
		<div class="container">
			<h1 class="display-4">주문 완료</h1>
		</div>
	</div>
	
	<div class="container">
		<h2 class="alert alert-danger">주문해 주셔서 감사합니다.</h2>
	</div>
	<div class="container">
		<p>주문은 <% out.println(shipping_shippingDate); %>에 배송될 예정입니다.</p>
		<p>주문번호 : <% out.println(shipping_cartId); %></p>
	</div>
	
	<div class="container">
		<p><a href="./products.jsp" class="btn btn-secondary">&laquo; 상품 목록</a>
	</div>

</body>
</html>
<% 
	//주문이 완료되었으니 세션을 삭제하고 관련된 쿠키도 삭제를 함
	session.invalidate();

	for(int i=0; i<cookies.length; i++){
		Cookie thiCookie = cookies[i];
		String str = thiCookie.getName();
		
		if(str.equals("Shipping_cartId")){
			thiCookie.setMaxAge(0);
		}
		if(str.equals("Shipping_name")){
			thiCookie.setMaxAge(0);
		}
		if(str.equals("Shipping_shippingDate")){
			thiCookie.setMaxAge(0);
		}
		if(str.equals("Shipping_country")){
			thiCookie.setMaxAge(0);
		}
		if(str.equals("Shipping_zipCode")){
			thiCookie.setMaxAge(0);
		}
		if(str.equals("Shipping_addressName")){
			thiCookie.setMaxAge(0);
		}
		//변경된 쿠키를 다시 응답처리객체에 재탑재를 하고 있다.
		response.addCookie(thiCookie);
	}

%>
