<%@page import="java.text.DecimalFormat"%>
<%@page import="dto.Product"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="./resources/css/bootstrap.min.css">
<% 
	//세션의 ID값을 가져오는 코드
	String cartId = session.getId();
	DecimalFormat dfFormat = new DecimalFormat("###,###");
%>
<meta charset="UTF-8">
<title>장바구니</title>
</head>
<body>
	<jsp:include page="menu.jsp" />
	<div class="mt-4 p-5 bg-secondary text-white rounded">
		<div class="container">
			<h1 class="display-4">장바구니</h1>
		</div>
	</div>
	
	<div class="container">
		<div class="row">
			<table style="width: 70%; margin-top: 1.5rem ">
				<tr>
					<td align="left"><a href="./deleteCart.jsp?cartId=<%= cartId %>"
					class="btn btn-danger">삭제하기</a></td>
					<td align="right"><a href="./shippingInfo.jsp?cartId=<%= cartId %>"
					class="btn btn-success">주문하기</a></td>
				</tr>
			</table>
		</div>
		<div style="padding-top: 50px">
			<%-- hover - 마우스 포인터가 올라가 있는 행의 배경색이 조금씩 바뀌어 눈에 띄도록 만들어진 클래스 --%>
			<table class="table table-hover">
				<tr>
					<th>상품</th>
					<th>가격</th>
					<th>수량</th>
					<th>소계</th>
					<th>비고</th>
				</tr>
				<% 
					int sum=0;
					//장바구인 cartlist에 등록된 모든 상품을 가져오도록 session 내장 객체의 getAttribute를 사용함
					ArrayList<Product> cartList = (ArrayList<Product>)session.getAttribute("cartlist");
					
					//cart.jsp파일에서 전체 상품을 삭제하는 deleteCart.jsp에서 세션을 모두 삭제 후에는 다시 아래 코드가 필요
					if(cartList==null){
						cartList = new ArrayList<Product>();
					}
					
					//상품 리스트를 하나씩 출력하기
					for(int i=0; i<cartList.size(); i++){
						Product product = cartList.get(i);
						int total = product.getUnitPrice() * product.getQuantity();
						sum += total;
				%>
				<tr>
					<td><%= product.getProductId() %>-<%= product.getPname() %></td>
					<td><%= dfFormat.format(product.getUnitPrice()) %></td>
					<td><%= product.getQuantity() %></td>
					<td><%= dfFormat.format(total) %></td>
					<td><a href="./removeCart.jsp?id=<%= product.getProductId() %>"
							class="badge text-bg-danger">삭제</a></td>
				</tr>
				<% 
					}
				%>
				<tr>
					<th></th>
					<th></th>
					<th>총액</th>
					<th>총액<%= dfFormat.format(sum) %></th>
					<th></th>
				</tr>
			</table>
			<a href="./products.jsp" class="btn btn-outline-info">&raquo; 쇼핑 계속하기</a>
		</div>
		<hr>
	</div>
	<jsp:include page="footer.jsp" />


</body>
</html>