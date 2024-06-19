<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@ include file="sqldbConn.jsp" %>
<% 
	request.setCharacterEncoding("utf-8");
	//로그인 정보를 (loginMember에서) 가져오는 코드
	String id = request.getParameter("id");
	String password = request.getParameter("password");
%>
	
<%-- sql 쿼리문을 실행하는 코드 (resulSet에 담음). executeQuery() 기능과 유사 --%>
<sql:query dataSource="${dataSource }" var="resultSet">
	select * from members where id=? and password=?
	<sql:param value="<%=id %>" />
	<sql:param value="<%=password %>" />
</sql:query>

<c:forEach var="row" items="${resultSet.rows }">
<% 
	session.setAttribute("sessionId", id);
%>
	<c:redirect url="resultMember.jsp?msg=2" />
</c:forEach>

<c:redirect url="loginMember.jsp?error=1" />

