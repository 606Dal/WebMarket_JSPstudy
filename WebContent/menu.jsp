<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="C" %>
<% 
	request.setCharacterEncoding("UTF-8"); 
	//로그인 여부를 판단하기 위한 코드
	String sessionId = (String) session.getAttribute("sessionId");
%>

<%-- 네비게이션 바를 만듦.	크기를 유동적으로.			색상 --%>
<nav class="navbar navbar-expand navbar bg-dark border-bottom border-body" data-bs-theme="dark">
	<div class="container"> <%-- container라는 클래스 부터는 무엇인가 내용을 표식 --%>
		<div class="navbar-header">
			<a class="navbar-brand" href="${pageContext.request.contextPath}/welcome.jsp">Home</a> <%-- 로고 --%>
		</div>
		<%-- 네비게이션 바의 요소들을 추가등록 하는 코드 --%>
		<div>
								<%-- 마진 자동 --%>
			<ul class="navbar-nav mr-auto">
				<C:choose>
					<%-- sessionId가 null이라면 로그인으로 링크를 거는 코드 --%>
					<C:when test="${empty sessionId }">
						<li class="nav-item"><a class="nav-link"
							href="${pageContext.request.contextPath}/members/loginMember.jsp">로그인</a></li>
						<li class="nav-item"><a class="nav-link"
							href="${pageContext.request.contextPath}/members/addMember.jsp">회원가입</a></li>
					</C:when>
					<%-- 로그인이 되어 있다면... --%>
					<C:otherwise>
						<li style="padding-top: 7px; color: white;">[<%= sessionId %>님]</li>
						<li class="nav-item"><a class="nav-link"
							href="${pageContext.request.contextPath}/members/logoutMember.jsp">로그아웃</a></li>
						<li class="nav-item"><a class="nav-link"
							href="${pageContext.request.contextPath}/members/updateMember.jsp">회원 정보 수정</a></li>
					</C:otherwise>
				</C:choose>
				
				<C:choose>
					<%-- 아이디가 admin이 아니면 보여질 것들 구분 --%>
					<C:when test="${sessionId ne 'admin'}">
						<li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/products.jsp">상품 목록</a></li>
					</C:when>
					<C:otherwise>
						<li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/products.jsp">상품 목록</a></li>
						<li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/addProduct.jsp">상품 등록</a></li>
						<li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/editProduct.jsp?edit=update">상품 수정</a></li>
						<li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/editProduct.jsp?edit=delete">상품 삭제</a></li>
					</C:otherwise>
				</C:choose>
				<li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/BoardListAction.do?pageNum=1">게시판</a></li>
			</ul>
		</div>
		
	</div>
</nav>