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
	<%-- 회원가입 --%>
	<h1 class="text-center my-4">회원가입</h1>
	<div class="d-flex justify-content-center">
		<form id="signUpForm" method="post" action="/user/sign_up">
		
			<%-- 아이디 --%>
			<div>아이디</div>
			<div class="d-flex">
				<input type="text" id="loginId" name="loginId" class="form-control" placeholder="아이디를 입력하세요.">
				<button type="button" id="loginIdCheckBtn" class="btn btn-success">중복확인</button><br>
			</div>
			
			<%-- 아이디 체크 결과 --%>
			<%-- d-none 클래스: display none (보이지 않게) --%>
			<div id="idCheckLength" class="small text-danger d-none">ID를 4자 이상 입력해주세요.</div>
			<div id="idCheckDuplicated" class="small text-danger d-none">이미 사용중인 ID입니다.</div>
			<div id="idCheckOk" class="small text-success d-none">사용 가능한 ID 입니다.</div>

			<%-- 비밀번호 --%>
			<div class="mt-2">비밀번호</div>
			<div>
				<input type="password" id="password" name="password" class="form-control" placeholder="비밀번호를 입력하세요.">
			</div>

			<%-- 비밀번호 확인 --%>
			<div class="mt-2">비밀번호 확인</div>
			<div>
				<input type="password" id="confirmPassword" class="form-control" placeholder="비밀번호를 입력하세요.">
			</div>

			<%-- 이름 --%>
			<div class="mt-2">이름</div>
			<div>
				<input type="text" id="name" name="name" class="form-control" placeholder="이름을 입력하세요.">
			</div>

			<%-- 이메일 --%>
			<div class="mt-2">이메일</div>
			<div>
				<input type="text" id="email" name="email" class="form-control" placeholder="이메일 주소를 입력하세요.">
			</div>
			
			<%-- 가입하기 버튼 --%>
			<div class="mt-3">
				<button type="submit" id="signUpBtn" class="btn btn-success float-right mb-5">가입하기</button>
			</div>
		</form>
	</div>
<script>
$(document).ready(function() {
	// 중복 확인
	$('#loginIdCheckBtn').on('click', function() {
		let loginId = $('#loginId').val().trim();
		
		if (loginId.length < 4) {
			// 4자 이하일 때 경고문구 노출하고 끝낸다
			$('#idCheckLength').removeClass('d-none'); // 경고문구 노출
			$('#idCheckDuplicated').addClass('d-none'); // 숨김
			$('#idCheckOk').addClass('d-none'); // 숨김
			return;
		}
		
		// ajax 중복 확인
		$.ajax({
			url:"/user/is_duplicated_id"
			, data:{"loginId":loginId}
		
			, success:function(data) {
				if (data.result) {
					// 중복일 때
					$('#idCheckDuplicated').removeClass('d-none'); // 경고문구 노출
					$('#idCheckLength').addClass('d-none'); // 숨김
					$('#idCheckOk').addClass('d-none'); // 숨김
				} else {
					// 중복 아닐 때
					$('#idCheckOk').removeClass('d-none'); // 사용 가능 문구 노출
					$('#idCheckLength').addClass('d-none'); // 숨김
					$('#idCheckDuplicated').addClass('d-none'); // 숨김
				}
			}
			, error: function(e) {
				alert("아이디 중복확인에 실패했습니다. 관리자에게 문의해주세요.");
			}
		});
	});
	
	// 회원 가입
	$('#signUpForm').on('submit', function(e) {
		e.preventDefault(); // 서브밋 기능 중단
		
		//alert("회원가입");
		// validation
		let loginId = $('#loginId').val().trim();
		let password = $('#password').val();
		let confirmPassword = $('#confirmPassword').val();
		let name = $('#name').val().trim();
		let email = $('#email').val().trim();
		
		if (loginId == '') {
			alert("아이디를 입력하세요");
			return false;
		}
		if (password == '' || confirmPassword == '') {
			alert("비밀번호를 입력하세요");
			return false;
		}
		if (password != confirmPassword) {
			alert("비밀번호가 일치하지 않습니다.");
			return false;
		}
		if (name == '') {
			alert("이름을 입력하세요");
			return false;
		}
		if (email == '') {
			alert("이메일을 입력하세요");
			return false;
		}
		// 아이디 중복확인이 완료 되었는지 확인 -> idCheckOk d-none이 없으면 사용 가능으로 본다.
		if ($('#idCheckOk').hasClass('d-none') === true) {
			alert("아이디 중복확인을 다시 해주세요.");
			return false;
		}
		
		// 1) submit
		//$(this)[0].submit(); // 서브밋 이후에 다른 화면으로 넘길 때 사용(action 주소-> 뷰화면)
		
		// 2) ajax
		let url = $(this).attr('action');
		let params = $(this).serialize(); // name 속성 값들을 파라미터로 구성
		//console.log(params);
		
		$.post(url, params)
		.done(function(data) {
			if (data.code == 100) {
				alert("가입을 환영합니다!!! 로그인 해주세요.");
				location.href = "/user/sign_in_view";
			} else {
				alert("가입에 실패했습니다.");
			}
		});
	});
});
</script>
</body>
</html>