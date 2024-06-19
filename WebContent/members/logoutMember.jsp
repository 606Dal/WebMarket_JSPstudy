<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% 
	session.invalidate(); //모든 세션을 삭제 하면 로그아웃 됨
	
	response.sendRedirect("resultMember.jsp?msg=3");

%>