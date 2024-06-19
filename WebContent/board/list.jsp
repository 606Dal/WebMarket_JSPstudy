<%@page import="mvc.model.BoardDTO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%
	String sessionId = (String)session.getAttribute("sessionId");
	ArrayList<BoardDTO> boardList = (ArrayList<BoardDTO>)request.getAttribute("boardlist");
	//BListCommand에서 저장한 값 가져옴
	int total_record = (Integer)request.getAttribute("total_record");
					//위 아래 방식 다 상관없음(박싱)
	int pageNum = ((Integer)request.getAttribute("pageNum")).intValue();
	int total_page = ((Integer)request.getAttribute("total_page")).intValue();
	
%>

<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="./resources/css/bootstrap.min.css">
<meta charset="UTF-8">
<title>게시판</title>

<%-- 로그인 여부를 판단하는 자바스크립트 함수 내용 --%>
<script type="text/javascript">
	function checkForm() {
		if(${sessionId == null}){
			alert("로그인을 해야 작성할 수 있습니다.");
			return false;
		}
		//로그인이 되었다면...
		location.href = "./BoardWriteForm.do?id=<%=sessionId %>";
	}
	function loginForm() {
		if(${sessionId == null}){
			alert("로그인을 해야 게시글을 볼 수 있습니다.");
			return false;
		}
	}
</script>
<style type="text/css">
	a {
		text-decoration: none;
	}
</style>
</head>
<body>
	<jsp:include page="/menu.jsp" />
	<div class="my-4 p-5 bg-secondary text-white rounded">
		<div class="container">
			<h1 class="display-4">게시판</h1>
		</div>
	</div>
	<div class="container">
		<form action='<c:url value="./BoardListAction.do"/>' method="post">
			<div>
				<div class="text-end">
					<span class="badge rounded-pill text-bg-success">전체 건수 : <%=total_record  %></span>
				</div>
			</div>
			<%-- 게시글을 표식하는 부분 --%>
			<div style="padding-top: 50px">
				<table class="table table-hover">
					<tr>
						<th>번호</th>
						<th>제목</th>
						<th>작성일</th>
						<th>조회</th>
						<th>글쓴이</th>
					</tr>
					<% 
						for(int j=0; j<boardList.size(); j++){
							BoardDTO notice = boardList.get(j);
					%>
					<tr>
						<td><%=notice.getNum() %></td>
						<%-- 게시글의 제목을 클릭하면 해당 게시글이 보일 수 있도록 a태그 이용 --%>
						<td><% if(sessionId == null) { %>
								<a href="#" onclick="loginForm()"><%=notice.getSubject() %></a>
							<% } 
								else {
							%>
								<a href="./BoardViewAction.do?num=<%= notice.getNum()%>&pageNum=<%=pageNum %>"><%=notice.getSubject() %></a>
							<%  
								}
							%>
						</td>
						<td><%=notice.getRegist_day() %></td>
						<td><%=notice.getHit() %></td>
						<td><%=notice.getName() %></td>
					</tr>
					<% 
						}
					%>
				</table>
			</div>
			<%-- 페이지 수를 표식하는 부분 --%>
			<div align="center">
				<c:set var="pageNum" value="<%=pageNum %>" />
				<c:forEach var="i" begin="1" end="<%=total_page %>">
					<a href='<c:url value="./BoardListAction.do?pageNum=${i}" ></c:url>'>
						<c:choose>
							<c:when test="${pageNum==i}">
								<span class="text-primary-emphasis"><b>[${i}]</b></span>
							</c:when>
							<c:otherwise>
								<span class="text-primary text-opacity-50">[${i}]</span>
							</c:otherwise>
						</c:choose>
					</a>
				</c:forEach>
			</div>
			<%-- 검색페이지 코드 --%>
			<div align="center" class="mt-3">
				<table>
					<tr>
						<td width="100%" align="left" class="col-6">&nbsp;&nbsp;
							<select name="items" class="text">
								<option value="subject">제목</option>
								<option value="content">본문</option>
								<option value="name">글쓴이</option>
							</select>
							<input name="text" type="text" />
							<input type="submit" id="btnAdd" class="btn btn-outline-dark btn-sm" value="검색" />
						</td>
						<td width="100%" align="right" class="col-6">
							<%-- 로그인이 된 회원들만 글쓰기가 되도록 하기 위해서 checkForm()함수를 거쳐가도록 설정을 함 --%>
							<a href="#" onclick="checkForm(); return false;"
								class="btn btn-outline-primary">글쓰기</a>
						</td>
					</tr>
				</table>
			</div>
		</form>
		<hr>
	</div>
	<jsp:include page="/footer.jsp" />

</body>
</html>