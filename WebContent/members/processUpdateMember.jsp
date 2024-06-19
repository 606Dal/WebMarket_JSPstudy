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
	//select 사용한 건 다르게 받아와야 함. Values가 스트링 배열로 리턴
	String month = request.getParameterValues("birthmm")[0];
	String day = request.getParameter("birthdd");
	String birth = year + "/" + month + "/" + day;
	
	String mail1 = request.getParameter("mail1");
	String mail2 = request.getParameterValues("mail2")[0];
	String mail = mail1 + "@" + mail2;
	
	String phone = request.getParameter("phone");
	String address = request.getParameter("address");
	
	/* //가입 버튼을 누를 때, 그 시점으로 저장이 됨
	SimpleDateFormat sDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	String regist_day = sDateFormat.format(new Date()); */
%>
	
<%-- sql 태그를 이용하여 DB에 데이터를 삽입하는 코드
 	update는 모든 수정, 삽입, 삭제까지 담당하고 있음. --%>
<sql:update dataSource="${dataSource }" var="resultSet">
	update members set password=?, name=?, gender=?, birth=?, mail=?, phone=?, address=? where id=?
	<sql:param value="<%=password %>" />
	<sql:param value="<%=name %>" />
	<sql:param value="<%=gender %>" />
	<sql:param value="<%=birth %>" />
	<sql:param value="<%=mail %>" />
	<sql:param value="<%=phone %>" />
	<sql:param value="<%=address %>" />
	<sql:param value="<%=id %>" />
	<%-- <sql:param value="${id}" /> --%>
</sql:update>

<c:if test="${resultSet >= 1}">
	<c:redirect url="resultMember.jsp?msg=0" />
</c:if>