<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<% 
	String sessionId = (String)session.getAttribute("sessionId");
%>
<%@ include file="sqldbConn.jsp" %>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="../resources/css/bootstrap.min.css">
<meta charset="UTF-8">
<title>회원 삭제</title>

</head>
<body>

	<sql:update dataSource="${dataSource}" var="resultSet">
		delete from members where id = ?
		<sql:param value="<%=sessionId %>" />
	</sql:update>
	
	<%-- 쿼리 실행이 끝나면 페이지 이동 --%>
	<c:if test="${resultSet>=1}">
		<c:import url="logoutMember.jsp" />
		<c:redirect url="resultMember.jsp" />
	</c:if>

</body>
</html>