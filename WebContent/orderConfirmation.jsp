<%@page import="java.text.DecimalFormat"%>
<%@page import="dto.Product"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.net.URLDecoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
	request.setCharacterEncoding("UTF-8");
	DecimalFormat dfFormat = new DecimalFormat("###,###");

	String cartId = session.getId();
	
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
			if(str.equals("Shipping_name")){
				shipping_name = URLDecoder.decode(thisCookie.getValue(), "utf-8");
			}
			if(str.equals("Shipping_shippingDate")){
				shipping_shippingDate = URLDecoder.decode(thisCookie.getValue(), "utf-8");
			}
			if(str.equals("Shipping_country")){
				shipping_country = URLDecoder.decode(thisCookie.getValue(), "utf-8");
			}
			if(str.equals("Shipping_zipCode")){
				shipping_zipCode = URLDecoder.decode(thisCookie.getValue(), "utf-8");
			}
			if(str.equals("Shipping_addressName")){
				shipping_addressName = URLDecoder.decode(thisCookie.getValue(), "utf-8");
			}
		}
	}
	 
%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="./resources/css/bootstrap.min.css">
<meta charset="UTF-8">
<title>주문 정보</title>
</head>
<body>
	<jsp:include page="menu.jsp" />
	<div class="my-4 p-5 bg-secondary text-white rounded">
		<div class="container">
			<h1 class="display-4">주문 정보</h1>
		</div>
	</div>
	<%-- 하늘색 알림창 --%>
	<div class="container col-8 alert alert-info">
		<div class="text-center">
			<h1>영수증</h1>
		</div>
		<%-- 콘텐츠 채우기 - 정렬 방식 --%>
		<div class="d-flex justify-content-between">
			<div class="col-4" align="left">
				<strong>배송 주소</strong><br>
				성명 : <% out.println(shipping_name); %><br>
				우편번호 : <% out.println(shipping_zipCode); %><br>
				주소 : <% out.println(shipping_addressName); %><br>
			</div>
			<div class="col-4" align="right">
				<p><em>배송일 : <% out.println(shipping_shippingDate); %> </em></p>
			</div>
		</div>
		
		<div>
			<table class="table table-primary table-hover">
				<tr style="text-align: center;">
					<th>물품</th>
					<th>수량</th>
					<th>가격</th>
					<th>소계</th>
				</tr>
				<% 
					int sum = 0;
					ArrayList<Product> cartList = (ArrayList<Product>)session.getAttribute("cartlist"); 
				
					if(cartList == null)
						cartList = new ArrayList<Product>();
					
					for(int i=0; i<cartList.size(); i++){
						Product product = cartList.get(i);
						int total = product.getUnitPrice() * product.getQuantity(); // 소계?
						sum += total; //총액
					
				%>
				<tr>
					<td class="text-center"><em><%= product.getPname() %></em></td>
					<td class="text-center"><em><%= product.getQuantity() %></em></td>
					<td class="text-center"><em><%= dfFormat.format(product.getUnitPrice()) %>원</em></td>
					<td class="text-center"><em><%= dfFormat.format(total) %>원</em></td>
				</tr>
				<% 
					}
				%>
				<tr>
					<td></td>
					<td></td>
					<td class="text-end"><strong>총액 : </strong></td>
					<td class="text-center text-danger"><strong><%= dfFormat.format(sum) %>원</strong></td>
				</tr>
			</table>
			
			<a href="./shippingInfo.jsp?cartId=<%= shipping_cartId %>" class="btn btn-secondary" role="button">이전</a>
			<a href="./thankCustomer.jsp" class="btn btn-success" role="button">주문 완료</a>
			<a href="./checkOutCancelled.jsp" class="btn btn-secondary" role="button">취소</a>
		</div>
	</div>
</body>
</html>