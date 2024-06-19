<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="dao.ProductRepository"%>
<%@page import="dto.Product"%>
<%@page import="java.util.ArrayList"%>
<%@page errorPage="exceptionNoProductId.jsp" %> <%-- 상품 코드 값이 유효하지 않으면 에러페이지로 이동 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- <jsp:useBean id="productDAO" class="dao.ProductRepository" scope="session" /> --%>

<!DOCTYPE html>
<%
	request.setCharacterEncoding("UTF-8"); 
	DecimalFormat dfFormat = new DecimalFormat("###,###"); //숫자 천 단위 구분
%>
<html>
<head>
<!-- <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css">-->
<link rel="stylesheet" href="./resources/css/bootstrap.min.css">
<meta charset="UTF-8">
<title>상품 상세 정보</title>

<%-- 장바구니에 추가하기 위한 핸들러 함수 --%>
<script type="text/javascript">
	function addToCart() {
		//confirm()함수는 사용자의 선택을 할 때 사용.
		if(confirm("해당 상품을 장바구니에 추가 하시겠습니까?")){
			document.addForm.submit();
		} else {
			document.addForm.reset();
		}
	}
</script>


</head>
<body>
	<jsp:include page="menu.jsp" />
	<div class="mt-4 p-5 bg-secondary text-white rounded">
		<div class="container">
			<h1 class="display-4">상품 정보</h1>
		</div>
	</div>
	<%-- <%
		//넘어온 상품 아이디값을 얻어낸다.
		String id = request.getParameter("id");
		ProductRepository dao = ProductRepository.getInstance();
		//넘어온 상품 아이디값을 이용해서 실제 해당하는 Product객체를 얻고 있음
		/* Product product = productDAO.getProductById(id); */
		Product product = dao.getProductById(id);
	%> --%>
	<%@ include file="dbconn.jsp" %>
	<% 
		//어떤 제품을 수정할지 id값이 넘어오는 것을 받고 있다.
		String productId = request. getParameter("id");
	
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String sql = "select * from product where p_id = ?";
		//Connection객체로 부터 쿼리문을 주고 prepareStatement를 얻고 있다.
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, productId);
		//쿼리문의 결과를 받아옴
		rs = pstmt.executeQuery();
	
		if(rs.next()) {
	%>
	<div class="container">
		<div class="row">
				<%-- cos.jar 이용을 위해 물리적인 경로로 바꿈-%>
				<%-- <img src="c:/upload/<%= product.getFilename() %>"
					style="width: 100%"> 
					 -> 웹 브라우저에서 적용 안 되서 다시 변경---%>
			<!-- 이미지 추가 -->
			<div class="col-md-5">
				<img src="${pageContext.request.contextPath }/resources/images/<%= rs.getString("p_filename") %>"
					style="width: 100%" class="mt-4">
			</div>
			
			<div class="col-md-6 m-4">
				<h3><%= rs.getString("p_name") %> </h3>
				<p><%= rs.getString("p_description")  %></p>
				<p><b>상품 코드 : </b><span class="badge rounded-pill text-bg-info"><%= rs.getString("p_id")%></span></p>
				<p><b>제조사 : </b><%= rs.getString("p_manufacturer") %></p>
				<p><b>분류 : </b><%= rs.getString("p_category") %></p>
				<p><b>재고 수 : </b><%= dfFormat.format(rs.getLong("p_unitsInStock")) %></p>
				<h4><%= dfFormat.format(Integer.parseInt(rs.getString("p_unitPrice"))) %>원</h4>
				
				<p><form name="addForm" action="./addCart.jsp?id=<%=rs.getString("p_id")%>" method="post">
					<%-- 상품 주문을 클릭하면 자바스크립트의 핸들러 함수 addToCart()가 호출되도록 만듦 --%>
					<a href="#" class="btn btn-outline-primary" onclick="addToCart()">상품 주문 &raquo;</a>
					<%-- 장바구니 버튼을 추가함. --%>
					<a href="./cart.jsp" class="btn btn-outline-warning">장바구니 &raquo;</a>
					<a href="./products.jsp" class="btn btn-outline-secondary">상품 목록 &raquo;</a>
				</form>
			</div>
		</div>
		<hr>
	</div>
	<% 
		}
		if(rs != null) rs.close();
		if(pstmt != null) pstmt.close();
		if(conn != null) conn.close();
	%>
	<jsp:include page="footer.jsp" />

</body>
</html>