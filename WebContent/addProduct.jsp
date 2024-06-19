<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<%-- <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css"> --%>
<link rel="stylesheet" href="./resources/css/bootstrap.min.css">

<%-- 외부 자바스크립트 파일을 가져오기 위한 경로 지정 --%>
<script type="text/javascript" src="./resources/js/validation.js"></script>
<meta charset="UTF-8">
<title>상품 등록</title>
</head>
<body>
	<%-- 다국어 처리를 하기 위한 코드 --%>
	<fmt:setLocale value='<%=request.getParameter("language") %>' />
	<fmt:bundle basename="resourceBundle.message" >
	
	<jsp:include page="menu.jsp" />
	<div class="mt-4 p-5 bg-secondary text-white rounded">
		<div class="container">
			<%-- <h1 class="display-4">상품 등록</h1> --%>
			<h1 class="display-4"><fmt:message key="title" /></h1>
		</div>
	</div>
	
	<div class="container">	
		<%-- 한글 혹은 영어로 표식할지 선택하는 부분을 추가함 --%>
		<div class="text-end mt-2">
			<a href="?language=ko">Korean</a>||<a href="?language=en">English</a>
			<%-- 로그아웃 버튼 --%>
			<a href="logout.jsp" class="btn btn-sm btn-outline-success"><b>로그아웃</b></a>
		</div>
			<%-- form-horizontal : 폼 요소들이 수평적으로 배치가 되도록 해줌 --%>
		<form name="newProduct" action="./processAddProduct.jsp" class="form-horizontal"
			method="post" enctype="multipart/form-data">
			
			<div class="form-group row mt-3" align="center">
			  <%-- 화면 크기가 768px 이상일 때 sm부분 적용됨. div요소의 block특성에 의해 100% 너비를 가지며
			  수직으로 쌓이게 만들어 준다. --%>
			  										<!-- 상품 코드  -->
				<label class="col-sm-2"><b><fmt:message key="productId"/></b></label>
				<div class="col-sm-3">			<%--form-control : 어떤 걸 입력 받을 때 의례적으로 넣어줌 --%>
					<input type="text" id="productId" name="productId" class="form-control" placeholder="상품 코드를 입력하세요.">
				</div>
			</div>
			
			<div class="form-group row mt-3" align="center">
				<!-- <label class="col-sm-2"><b>상품명</b></label> -->
				<label class="col-sm-2"><b><fmt:message key="pname"/></b></label>
				<div class="col-sm-3">
					<input type="text" id="name" name="name" class="form-control" placeholder="상품명을 입력하세요.">
				</div>
			</div>
		
			<div class="form-group row mt-3" align="center">
				<!-- <label class="col-sm-2"><b>가격</b></label> -->
				<label class="col-sm-2"><b><fmt:message key="unitPrice" /></b></label>
				<div class="col-sm-3">			
					<input type="text" id="unitPrice" name="unitPrice" class="form-control" placeholder="가격을 입력하세요.">
				</div>
			</div>
			
			<div class="form-group row mt-3" align="center">
				<!-- <label class="col-sm-2"><b>상세 정보</b></label> -->
				<label class="col-sm-2"><b><fmt:message key="description" /></b></label>
				<div class="col-sm-5">			
					<textarea name="description" cols="50" rows="2" class="form-control"
					placeholder="상세 정보를 입력하세요."></textarea>
				</div>
			</div>
			
			<div class="form-group row mt-3" align="center">
				<!-- <label class="col-sm-2"><b>제조사</b></label> -->
				<label class="col-sm-2"><b><fmt:message key="manufacturer" /></b></label>
				<div class="col-sm-3">		
					<input type="text" name="manufacturer" class="form-control" placeholder="제조사를 입력하세요.">
				</div>
			</div>
			
			<div class="form-group row mt-3" align="center">
				<!-- <label class="col-sm-2"><b>분류</b></label> -->
				<label class="col-sm-2"><b><fmt:message key="category" /></b></label>
				<div class="col-sm-3">		
					<input type="text" name="category" class="form-control" placeholder="분류를 입력하세요.">
				</div>
			</div>
			
			<div class="form-group row mt-3" align="center">
				<!-- <label class="col-sm-2"><b>재고 수</b></label> -->
				<label class="col-sm-2"><b><fmt:message key="unitsInStock" /></b></label>
				<div class="col-sm-3">		
					<input type="text" id="unitsInStock" name="unitsInStock" class="form-control" placeholder="재고 수량을 입력하세요.">
				</div>
			</div>
			
			<div class="form-group row mt-3" role="group" aria-label="Basic radio toggle button group" >
				<!-- <label class="col-sm-2"><b>상태</b></label> -->
				<label class="col-sm-2"  align="center"><b><fmt:message key="condition" /></b></label>
				<div class="col-sm-7">
					<!-- 신규 제품 -->
					<input type="radio" class="btn-check" name="condition" id="btnradio1" autocomplete="off" checked value="New">
					<label class="btn btn-outline-primary" for="btnradio1"><fmt:message key="condition_New" /></label>
					<!-- 중고 제품 -->
					<input type="radio" class="btn-check" name="condition" id="btnradio2" autocomplete="off" value="Old">
					<label class="btn btn-outline-primary" for="btnradio2"><fmt:message key="condition_Old" /></label>
					<!-- 재생 제품 -->
					<input type="radio" class="btn-check" name="condition" id="btnradio3" autocomplete="off" value="Refurbished">
					<label class="btn btn-outline-primary" for="btnradio3"><fmt:message key="condition_Refurbished" /></label>
				</div>
			</div>
			
			<!-- 상품 이미지 업로드 부분 -->
			<div class="form-group row mt-3">
				<!-- <label class="col-sm-2"><b>이미지</b></label> -->
				<label class="col-sm-2"  align="center"><b><fmt:message key="productImage" /></b></label>
				<div class="col-sm-5">
					<input type="file" name="productImage" class="form-control">
				</div>
			</div>
			
			<div class="form-group row mt-3" align="center">
			  <%-- offset 지정은 컬럼 격자의 2 만큼 띄우기--%>
				<div class="col-sm-offset-2 col-sm-10">		
					<%-- 타입을 submit으로 주게 되면 유효성 검사를 하다가 오류가 발생해도 action속성 값으로
					페이지 이동이 일어나기 때문에, button으로 바꿈 --%>
					<!-- <input type="button" class="btn btn-primary" value="등록"
						onclick="CheckAddProduct()"> -->
					<input type="button" class="btn btn-primary" value="<fmt:message key="button" />"
						onclick="CheckAddProduct()">
				</div>
			</div>
		</form>
	</div>
	</fmt:bundle>
</body>
</html>