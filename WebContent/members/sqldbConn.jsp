<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>

<%-- jstl태그 라이브러리의 sql 태그를 이용하여 DB에 접속하는 코드 --%>
<sql:setDataSource var="dataSource"
	url="jdbc:mysql://localhost:3306/webmarketdb"
	driver="com.mysql.jdbc.Driver"
	user="" password = "" />