<%@page import="java.util.Iterator"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="dao.ProductRepository"%>
<%@page import="dto.Product"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- <jsp:useBean id="productDAO" class="dao.ProductRepository" scope="session"/> --%>

<!DOCTYPE html>
<% 
	request.setCharacterEncoding("UTF-8"); 
	DecimalFormat dfFormat = new DecimalFormat("###,###"); //숫자 천 단위 구분
%>
<html>
<head>
<%-- CDN방식(인터넷 되는 곳 허용) 대신 부트스트랩 다운로드를 이용 --%>
<%--<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css"> --%>
<%-- 다운로드 받은 파일을 직접 link를 걸고 있음 --%>
<link rel="stylesheet" href="./resources/css/bootstrap.min.css">
<meta charset="UTF-8">
<title>상품 목록</title>
</head>
<body>
	<jsp:include page="menu.jsp" />
	<%-- jumbotron (B5에서는 더 이상 지원되지 않음) --%>
	<%-- mt(마진 탑) p(패딩) --%>
	<div class="mt-4 p-5 bg-secondary text-white rounded">
		<div class="container">
			<h1 class="display-4">상품 목록</h1>
		</div>
	</div>
	<%-- <%
		ProductRepository dao = ProductRepository.getInstance();
		//상품 목록을 다 가져온다.	+ useBean없앤 후 수정
		/* ArrayList<Product> listOfProducts = productDAO.getAllProducts(); */
		ArrayList<Product> listOfProducts = dao.getAllProducts();
	%> --%>
	
	<div class="container">
		<!-- 한 행씩 보이게 -->
		<div class="row" align="center">
			<%
				ProductRepository dao = ProductRepository.getInstance();
				ArrayList<Product> plist = new ArrayList<Product>();
				plist =	dao.getAllProducts();
				Iterator it = plist.iterator();
				Product pr = new Product();
				
				while(it.hasNext()){
			%>
				<div class="col-md-4 mt-4"> <!-- 컬럼을 12를 4개로 분할 -->
					<div class="container" style="text-align: center; height: 270px; max-width: 300px;">
						<%-- <img src="${pageContext.request.contextPath }/resources/images/<%=rs.getString("p_filename") %>" --%>
						<img src="${pageContext.request.contextPath }/resources/images/<%=pr.getFilename() %>"
							class="img-fluid rounded m-auto d-block" style="max-height: 90%; max-width: 100%">
					</div>
					
					<h3><%=pr.getPname() %> </h3>
					<p> <%=pr.getDescription() %></p>
					<p> <%=pr.getUnitPrice() %>원</p>
					<%-- <h3><%=rs.getString("p_name") %> </h3>
					<p> <%=rs.getString("p_description") %></p>
					<p> <%=dfFormat.format(Integer.parseInt(rs.getString("p_unitPrice"))) %>원</p> --%>
					
					<%-- 경로를 지정해서 이미지를 출력
					 <img src="./resources/images/<%= product.getFilename() %>" --%>
					 
					<%-- cos.jar 이용을 위해 물리적인 경로로 바꿈 --%>
					<%-- <img src="c:/upload/<%= product.getFilename() %>" 
					위처럼 하게 되면 일반 웹브라우저에서는 적용이 되지 않음. 웹 어플리케이션에서 적용이 되려면
					상대적 경로로 제시를 해줘야 제대로 인식이 됨--%>
					
					<%-- <div class="container" style="text-align: center; height: 270px; max-width: 300px;">
						<img src="${pageContext.request.contextPath }/resources/images/<%= product.getFilename() %>"
							class="img-fluid rounded m-auto d-block" style="max-height: 90%; max-width: 100%">
					</div>
					<h3><%=product.getPname()%> </h3>
					<p><%=product.getDescription() %></p>
					<p><%=dfFormat.format(product.getUnitPrice()) %>원</p> --%>
					
					<%-- 상품의 아이디에 대한 상세정보 페이지를 연결시키기 위한 코드 --%>
					
					<%-- <p><a href="./product.jsp?id=<%=request.getParameter("ProductId")%>" class="btn btn-secondary " --%>
					<p><a href="./product.jsp?id=<%=pr.getProductId() %>" class="btn btn-secondary "
							role="button">상세 정보 &raquo;</a></p>
				</div>
			<%
				} 
				/* if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close(); */
			%>
		</div>
		<hr>
	</div>
	
	<jsp:include page="footer.jsp" />
	
	<%-- <h1><%= greeting %></h1>
	<h3><%= tagline %></h3> --%>
</body>
</html>