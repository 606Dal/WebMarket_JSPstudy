<%@page import="mvc.model.BoardDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<% 
	BoardDTO notice = (BoardDTO)request.getAttribute("board");
	int num = (Integer)request.getAttribute("num");
	int nowpage = (Integer)request.getAttribute("pageNum");
	
/* 	System.out.println(notice.getName());
	System.out.println(num);
	System.out.println(nowpage); */
%>

<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="./resources/css/bootstrap.min.css">
<meta charset="UTF-8">
<title>글 상세 보기</title>
</head>
<body>
	<jsp:include page="/menu.jsp" />
	<div class="my-4 p-5 bg-secondary text-white rounded">
		<div class="container">
			<h1 class="display-4"><%=notice.getSubject()%></h1>
		</div>
	</div>
	<%-- 수정도 가능하게 --%>
	<div class="container">
		<form name="newUpdate" action="./BoardUpdateAction.do?num=<%=notice.getNum()%>&pageNum=<%=nowpage%>"
			class="form-horizontal" method="post">
			<%-- DB에 저장되어 있는 이름 값을 출력하는 부분--%>
			<div class="form-group row">
				<label class="col-sm-2 control-label">이름</label>
				<div class="col-sm-3">
					<input name="name" class="form-control" value="<%=notice.getName()%>" readonly>
				</div>
			</div>
			
			<c:set var="userId" value="<%=notice.getId() %>" />
			<%-- 게시글 작성자가 맞다면 수정 가능. 아니면 읽기만 가능 --%>
			<c:choose>
				<c:when test="${sessionId == userId}">
					<%-- DB에 저장되어 있는 제목을 출력하는 부분--%>
					<div class="form-group row mt-2">
						<label class="col-sm-2 control-label">제목</label>
						<div class="col-sm-5">
							<input name="subject" class="form-control" value="<%=notice.getSubject()%>">
						</div>
					</div>
					
					<div class="form-group row mt-2">
						<label class="col-sm-2 control-label">내용</label>
						<%-- word-break 속성은 단어의 분리를 결정하여 줄 바꿈에 대한 속성을 지정할 때 사용한다. 
							break-all 값은 영어 단어나 공백, 하이픈이 아닌 두 문자 사이에서 분리하려 할 때 사용--%>
						<div class="col-sm-8" style="word-break: break-all">
							<textarea name="content" cols="50" rows="5" class="form-control"><%=notice.getContent()%></textarea>
						</div>
					</div>
				</c:when>
				<c:otherwise>
					<div class="form-group row mt-2">
						<label class="col-sm-2 control-label">제목</label>
						<div class="col-sm-5">
							<input name="subject" class="form-control" value="<%=notice.getSubject()%>" readonly>
						</div>
					</div>
					
					<div class="form-group row mt-2">
						<label class="col-sm-2 control-label">내용</label>
						<div class="col-sm-8" style="word-break: break-all">
							<textarea name="content" cols="50" rows="5" class="form-control"
								readonly><%=notice.getContent()%></textarea>
						</div>
					</div>
				</c:otherwise>
			</c:choose>
			
			<%-- 게시글 작성자가 맞다면, 수정과 삭제를 할 수 있게 버튼이 보이는 코드이다. --%>
			<div class="form-group row mt-3">
				<div class="col-sm-offset-2 col-sm-10">
					<c:if test="${sessionId == userId}">
						<p><a href="./BoardDeleteAction.do?num=<%=notice.getNum()%>&pageNum=<%=nowpage%>"
								class="btn btn-danger">삭제</a>
						<input type="submit" class="btn btn-success" value="수정">
					</c:if>
					
					<a href="./BoardListAction.do?num=<%=nowpage%>"
						class="btn btn-outline-primary">목록</a>
				</div>
			</div>
		</form>
		<hr>
	</div>
	<jsp:include page="/footer.jsp" />
</body>
</html>