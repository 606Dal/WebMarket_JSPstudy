<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@ include file="sqldbConn.jsp" %>

<% 
	request.setCharacterEncoding("utf-8");

	String id = request.getParameter("id");
	String password = request.getParameter("password");
	String name = request.getParameter("name");
	String gender = request.getParameter("gender");
	//생년월일을 3개로 나눠서 받고 다시 문자열로 합치는 중
	String year = request.getParameter("birthyy");
	String month = request.getParameter("birthmm");
	String day = request.getParameter("birthdd");
	String birth = year + "/" + month + "/" + day;
	
	String mail1 = request.getParameter("mail1");
	String mail2 = request.getParameter("mail2");
	String mail = mail1 + "@" + mail2;
	
	String phone = request.getParameter("phone");
	String address = request.getParameter("address");
	
	//가입 버튼을 누를 때, 그 시점으로 저장이 됨
	SimpleDateFormat sDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	String regist_day = sDateFormat.format(new Date());
%>
	
<%-- sql 태그를 이용하여 DB에 데이터를 삽입하는 코드
 	update는 모든 수정, 삽입, 삭제까지 담당하고 있음. --%>
<sql:update dataSource="${dataSource }" var="resultSet">
	insert into members values(?,?,?,?,?,?,?,?,?);
	<sql:param value="<%=id %>" />
	<sql:param value="<%=password %>" />
	<sql:param value="<%=name %>" />
	<sql:param value="<%=gender %>" />
	<sql:param value="<%=birth %>" />
	<sql:param value="<%=mail %>" />
	<sql:param value="<%=phone %>" />
	<sql:param value="<%=address %>" />
	<sql:param value="<%=regist_day %>" />
	<%-- <sql:param value="${id}" /> --%>
</sql:update>

<c:if test="${resultSet >= 1}">
	<c:redirect url="resultMember.jsp?msg=1" />
</c:if>

