<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@ include file="sqldbConn.jsp" %>

<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="../resources/css/bootstrap.min.css">
<% 
	String sessionId = (String)session.getAttribute("sessionId");
%>

<%-- sql 쿼리문을 실행하는 코드 (resulSet에 담음). executeQuery() 기능과 유사 --%>
<sql:query dataSource="${dataSource }" var="resultSet">
	select * from members where id=?
	<sql:param value="<%=sessionId %>" />
</sql:query>


<meta charset="UTF-8">
<title>회원 정보 수정</title>
</head>
<%-- 윈도우 객체뿐만 아니라, 객체가 다 로드되었을 때 실행할 코드를 설정할 때 사용하는 속성 --%>
<body onload="init()">
	<jsp:include page="/menu.jsp" />
	<div class="my-4 p-5 bg-secondary text-white rounded">
		<div class="container">
			<h1 class="display-4">회원 정보 수정</h1>
		</div>
	</div>
	
	<c:forEach var="row" items="${resultSet.rows}">
		<c:set var="mail" value="${row.mail}" />
		<%-- split() - 구분자를 통해서 구분하고 Strin[]타입으로 리턴 --%>
		<c:set var="mail1" value="${mail.split('@')[0]}" />
		<c:set var="mail2" value="${mail.split('@')[1]}" />
		
		<c:set var="birth" value="${row.birth}" />
		<c:set var="year" value="${birth.split('/')[0]}" />
		<c:set var="month" value="${birth.split('/')[1]}" />
		<c:set var="day" value="${birth.split('/')[2]}" />
		
		<c:set var="gender" value="${row.gender}" />
		
		<div class="container">
			<form name="newMember" class="form-horizontal" action="processUpdateMember.jsp" method="post"
				 onsubmit="return checkForm()">
				<div class="form-group row">
				 	<label class="col-sm-3">아이디</label>
				 	<div class="col-sm-3">
				 		<%-- id값은 변하면 안 되기 때문에 readonly속성을 부여함 --%>
				 		<input name="id" type="text" class="form-control" placeholder="아이디"
				 			value="<c:out value='${row.id}'/>" readonly="readonly"/>
				 	</div>
				</div>
				<div class="form-group row mt-2">
				 	<label class="col-sm-3">비밀번호</label>
				 	<div class="col-sm-3">
				 		<input name="password" type="password" class="form-control" placeholder="비밀번호"
				 			value="<c:out value='${row.password}'/>">
				 	</div>
				</div>
				<div class="form-group row mt-2">
				 	<label class="col-sm-3">비밀번호 확인</label>
				 	<div class="col-sm-3">
				 		<input name="password_confirm" type="password" class="form-control" placeholder="비밀번호 확인">
				 	</div>
				</div>
				<div class="form-group row mt-2">
				 	<label class="col-sm-3">이름</label>
				 	<div class="col-sm-3">
				 		<input name="name" type="text" class="form-control" placeholder="이름"
				 			value="<c:out value='${row.name}'/>">
				 	</div>
				</div>
				<div class="form-group mt-2">
					<div class="form-check form-check-inline col-sm-3" style="padding-left: unset;">
						<input class="form-check-input" type="checkbox" id="inlineCheckbox3" value="성별" disabled>
	  					<label class="form-check-label" for="inlineCheckbox3">성별</label>
	  				</div>
				 	<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="gender" id="flexRadioDefault1" value="여" <c:if test="${gender.equals('여') }"> <c:out value="checked" /> </c:if> >
					  <label class="form-check-label" for="flexRadioDefault1">여</label>
					</div>
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="gender" id="flexRadioDefault2" value="남" <c:if test="${gender.equals('남') }"> <c:out value="checked" /> </c:if> >
					  <label class="form-check-label" for="flexRadioDefault2">남</label>
					</div>
				</div>
				<div class="form-group row mt-2">
				 	<label class="col-sm-3">생일</label>
				 	<div class="col-sm-9">
				 		<input name="birthyy" type="text" maxlength="4" placeholder="년도(4자리)" size="8" value="${year}" >
				 		<select name="birthmm" id="birthmm">
				 			<option value="">월</option>
				 			<option value="01">1</option>
				 			<option value="02">2</option>
				 			<option value="03">3</option>
				 			<option value="04">4</option>
				 			<option value="05">5</option>
				 			<option value="06">6</option>
				 			<option value="07">7</option>
				 			<option value="08">8</option>
				 			<option value="09">9</option>
				 			<option value="10">10</option>
				 			<option value="11">11</option>
				 			<option value="12">12</option>
				 		</select>
				 		<input type="text" name="birthdd" maxlength="2" placeholder="일" size="4" value="${day}" />
				 	</div>
				</div>
				<div class="form-group row mt-2">
				 	<label class="col-sm-3">이메일</label>
				 	<div class="col-sm-9">
				 		<input name="mail1" type="text" maxlength="50" value="${mail1}" >@
				 		<select name="mail2" id="mail2">
				 			<option>naver.com</option>
				 			<option>gmail.com</option>
				 			<option>hanmail.net</option>
				 			<option>nate.com</option>
				 		</select>
				 	</div>
				</div>
				<div class="form-group row mt-2">
				 	<label class="col-sm-3">전화번호</label>
				 	<div class="col-sm-3">
				 		<input name="phone" type="text" class="form-control" placeholder="전화번호(-생략)" value="${row.phone}" >
				 	</div>
				</div>
				<div class="form-group row mt-2">
				 	<label class="col-sm-3">주소</label>
				 	<div class="col-sm-5">
				 		<input name="address" type="text" class="form-control" placeholder="주소" value="${row.address}" >
				 	</div>
				</div>
				<div class="form-group row mt-2">
				 	<div class="col-sm-offset-2 col-sm-10">
				 		<input type="submit" class="btn btn-outline-primary" value="수정 반영">
				 		<input type="button" class="btn btn-outline-danger" value="회원 탈퇴"
				 			onclick="return delete_member()">
				 		<%-- <a href="${pageContext.request.contextPath}/members/deleteMember.jsp"
				 			class="btn btn-outline-danger">회원 탈퇴</a> --%>
				 	</div>
				</div>
			</form>
		</div>
	</c:forEach>

</body>
<script type="text/javascript">
	function init() {
		setComboMailValue("${mail2}");
		setComboBirthValue("${month}");
	}
	//select태그에서 선택한 option의 value를 가져오기 위한 코드
	function setComboMailValue(val) {
		var selectMail = document.getElementById('mail2');
		for(var i=0, j=selectMail.length; i<j; i++){
			// 매개변수로 넘어온 val이라는 값과 select태그의 값이 동일하다면 그 부분이 select되었다고 true로 설정하고 빠져나옴
			if(selectMail.options[i].value == val){
				selectMail.options[i].selected = true;
				break;
			}
		}
	}
	
	function setComboBirthValue(val) {
		var selectBirth = document.getElementById('birthmm');
		for(var i=0, j=selectBirth.length; i<j; i++){
			if(selectBirth.options[i].value == val){
				selectBirth.options[i].selected = true;
				break;
			}
		}
	}

	function checkForm() {
		if(!document.newMember.id.value) {
			alert("아이디를 입력하세요.");
			return false;
		}
		if(!document.newMember.password.value) {
			alert("비밀번호를 입력하세요.");
			return false;
		}
		if(document.newMember.password.value != document.newMember.password_confirm.value) {
			alert("비밀번호를 동일하게 입력하세요.");
			return false;
		}
		if(!document.newMember.name.value) {
			alert("이름을 입력하세요.");
			return false;
		}
	}
	
	function delete_member(){
		var result = confirm("정말 회원 탈퇴를 하시겠습니까?");
		if(result){
			location.href = "deleteMember.jsp";
			alert("탈퇴되었습니다.");
		}
		else{
			alert("취소되었습니다.");
			return;
		}
	}
</script>
</html>
