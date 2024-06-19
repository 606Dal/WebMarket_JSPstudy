<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.text.DecimalFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
	request.setCharacterEncoding("UTF-8"); 
	DecimalFormat dfFormat = new DecimalFormat("###,###"); //숫자 천 단위 구분
%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="./resources/css/bootstrap.min.css">
<meta charset="UTF-8">
<title>상품 목록 수정</title>
</head>
<body>
	<jsp:include page="menu.jsp" />
	<%-- jumbotron (B5에서는 더 이상 지원되지 않음) --%>
	<div class="my-4 p-5 bg-secondary text-white rounded">
		<div class="container">
			<h1 class="display-4">상품 목록 수정</h1>
		</div>
	</div>
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
				<div class="col-md-5">
				<img alt="image" src="${pageContext.request.contextPath }/resources/images/<%= rs.getString("p_filename") %>" 
					style="width: 100%">
				</div>
				<div class="col-md-7">
					<form name="newProduct" action="./processUpdateProduct.jsp" class="form-horizontal" method="post"
						enctype="multipart/form-data">
						<div class="form-group row">
							<label class="col-sm-3">상품 코드</label>
							<div class="col-sm-5">
								<input type="text" id="productId" name="productId" class="form-control"
									value='<%= rs.getString("p_id") %>'>
							</div>
						</div>
						<div class="form-group row mt-3">
							<label class="col-sm-3">상품명</label>
							<div class="col-sm-5">
								<input type="text" id="name" name="name" class="form-control"
									value='<%= rs.getString("p_name") %>'>
							</div>
						</div>
						<div class="form-group row mt-3">
							<label class="col-sm-3">가격</label>
							<div class="col-sm-5">
								<input type="text" id="unitPrice" name="unitPrice" class="form-control"
									value='<%= rs.getInt("p_unitPrice") %>'>
							</div>
						</div>
						<div class="form-group row mt-3">
							<label class="col-sm-3">상세 정보</label>
							<div class="col-sm-5">
								<input type="text" id="description" name="description" class="form-control"
									value='<%= rs.getString("p_description") %>'>
							</div>
						</div>
						<div class="form-group row mt-3">
							<label class="col-sm-3">제조사</label>
							<div class="col-sm-5">
								<input type="text" id="manufacturer" name="manufacturer" class="form-control"
									value='<%= rs.getString("p_manufacturer") %>'>
							</div>
						</div>
						<div class="form-group row mt-3">
							<label class="col-sm-3">분류</label>
							<div class="col-sm-5">
								<input type="text" id="category" name="category" class="form-control"
									value='<%= rs.getString("p_category") %>'>
							</div>
						</div>
						<div class="form-group row mt-3">
							<label class="col-sm-3">재고 수</label>
							<div class="col-sm-5">
								<input type="text" id="unitsInStock" name="unitsInStock" class="form-control"
									value='<%= rs.getLong("p_unitsInStock") %>'>
							</div>
						</div>
						<div class="form-group row mt-3" role="group" aria-label="Basic radio toggle button group" >
							<label class="col-sm-3">상태</label>
							<div class="col-sm-9">
								<!-- 신규 제품 -->
								<input type="radio" class="btn-check" name="condition" id="btnradio1" autocomplete="off" checked value="New">
								<label class="btn btn-outline-primary btn-sm" for="btnradio1">신규 제품</label>
								<!-- 중고 제품 -->
								<input type="radio" class="btn-check" name="condition" id="btnradio2" autocomplete="off" value="Old">
								<label class="btn btn-outline-primary btn-sm" for="btnradio2">중고 제품</label>
								<!-- 재생 제품 -->
								<input type="radio" class="btn-check" name="condition" id="btnradio3" autocomplete="off" value="Refurbished">
								<label class="btn btn-outline-primary btn-sm" for="btnradio3">재생 제품</label>
							</div>
						</div>
						<div class="form-group row mt-3">
							<label class="col-sm-3">이미지</label>
							<div class="col-sm-7">
								<input type="file" id="productImage" name="productImage" class="form-control">
							</div>
						</div>
						
						<div class="form-group row mt-3">
							<%-- col-sm-offset-2 좌측에 공백을 2칸 줌 --%>
							<div class="col-sm-offset-2 col-sm-10">
								<input type="submit" class="btn btn-success" value="수정 완료">
							</div>
						</div>
					</form>
				</div>
			</div>
		</div>
	<% 
		}
		if(rs != null) rs.close();
		if(pstmt != null) pstmt.close();
		if(conn != null) conn.close();
	%>
	

</body>
</html>