<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="../resources/css/bootstrap.min.css">
<script type="text/javascript">
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

</script>


<meta charset="UTF-8">
<title>회원 가입</title>
</head>
<body>
	<jsp:include page="/menu.jsp" />
	<div class="my-4 p-5 bg-secondary text-white rounded">
		<div class="container">
			<h1 class="display-4">회원 가입</h1>
		</div>
	</div>
	
	<div class="container">
		<form name="newMember" class="form-horizontal" action="processAddMember.jsp" method="post"
			 onsubmit="return checkForm()">
			<div class="form-group row">
			 	<label class="col-sm-3">아이디</label>
			 	<div class="col-sm-3">
			 		<input name="id" type="text" class="form-control" placeholder="아이디">
			 	</div>
			</div>
			<div class="form-group row mt-2">
			 	<label class="col-sm-3">비밀번호</label>
			 	<div class="col-sm-3">
			 		<input name="password" type="password" class="form-control" placeholder="비밀번호">
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
			 		<input name="name" type="text" class="form-control" placeholder="이름">
			 	</div>
			</div>
			<div class="form-group mt-2">
				<div class="form-check form-check-inline col-sm-3" style="padding-left: unset;">
					<input class="form-check-input" type="checkbox" id="inlineCheckbox3" value="성별" disabled>
  					<label class="form-check-label" for="inlineCheckbox3">성별</label>
  				</div>
			 	<div class="form-check form-check-inline">
				  <input class="form-check-input" type="radio" name="gender" id="flexRadioDefault1" value="여" checked>
				  <label class="form-check-label" for="flexRadioDefault1">여</label>
				</div>
				<div class="form-check form-check-inline">
				  <input class="form-check-input" type="radio" name="gender" id="flexRadioDefault2" value="남">
				  <label class="form-check-label" for="flexRadioDefault2">남</label>
				</div>
			</div>
			<div class="form-group row mt-2">
			 	<label class="col-sm-3">생일</label>
			 	<div class="col-sm-9">
			 		<input name="birthyy" type="text" maxlength="4" placeholder="년도(4자리)" size="8">
			 		<select name="birthmm">
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
			 		<input type="text" name="birthdd" maxlength="2" placeholder="일" size="4" />
			 	</div>
			</div>
			<div class="form-group row mt-2">
			 	<label class="col-sm-3">이메일</label>
			 	<div class="col-sm-9">
			 		<input name="mail1" type="text" maxlength="50">@
			 		<select name="mail2">
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
			 		<input name="phone" type="text" class="form-control" placeholder="전화번호(-생략)">
			 	</div>
			</div>
			<div class="form-group row mt-2">
			 	<label class="col-sm-3">주소</label>
			 	<div class="col-sm-5">
			 		<input name="address" type="text" class="form-control" placeholder="주소">
			 	</div>
			</div>
			<div class="form-group row mt-2">
			 	<div class="col-sm-offset-2 col-sm-10">
			 		<input type="submit" class="btn btn-outline-primary" value="가입">
			 		<input type="reset" class="btn btn-outline-secondary" value="취소">
			 	</div>
			</div>
		</form>
	</div>

</body>
</html>