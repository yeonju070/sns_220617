<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">

<%-- Ajax를 사용하려면 jquery 원본이 있어야 한다. --%>
<script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
</head>
<body>
	<div class="d-flex justify-content-center">
		<div class="sign-up-box">
			<h1 class="text-center m-3">회원가입</h1>
			<form id="signUpForm" method="post" action="/user/sign_up">
				<span class="sign-up-subject">아이디</span>
				<%-- 인풋 옆에 중복확인 버튼을 옆에 붙이기 위해 div 만들고 d-flex --%>
				<div class="d-flex mt-2">
					<input type="text" name="loginId" class="form-control col-8">
					<button type="button" id="loginIdCheckBtn" class="btn btn-success ml-1 w-100">중복확인</button>
				</div>

				<%-- 아이디 체크 결과 --%>
				<div class="ml-3 mb-3">
					<div id="idCheckLength" class="small text-danger d-none">ID를
						4자 이상 입력해주세요.</div>
					<div id="idCheckDuplicated" class="small text-danger d-none">이미
						사용중인 ID입니다.</div>
					<div id="idCheckOk" class="small text-success d-none">사용 가능한
						ID 입니다.</div>
				</div>

				<div class="sign-up-subject">비밀번호</div>
				<div>
					<input type="password" name="password" class="mt-2 form-control col-12">
				</div>

				<div class="sign-up-subject mt-2">비밀번호 확인</div>
				<div>
					<input type="password" name="confirmPassword"
						class="mt-2 form-control col-12">
				</div>

				<div class="sign-up-subject mt-2">이름</div>
				<div>
					<input type="text" name="name" class="form-control col-12">
				</div>

				<div class="sign-up-subject mt-2">이메일</div>
				<div>
					<input type="text" name="email" class="form-control col-12">
				</div>
				<div class="d-flex justify-content-center mt-3">
					<button type="button" id="signUpBtn" class="btn btn-primary w-100">가입하기</button>
				</div>
			</form>
		</div>
	</div>
</body>
</html>