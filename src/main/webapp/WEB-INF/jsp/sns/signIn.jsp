<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">

<%-- Ajax를 사용하려면 jquery 원본이 있어야 한다. --%>
<script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
</head>
<body>
	<div class="d-flex justify-content-center">
		<div class="shadow-box m-5">
			<h1 class="text-center">로그인</h1>
			<div class="d-flex justify-content-center m-5">
				<%-- 키보드 Enter키로 로그인이 될 수 있도록 form 태그를 만들어준다.(submit 타입의 버튼이 동작됨) --%>

				<form id="loginForm" action="/user/sign_in" method="post">
					<%-- input-group-prepend: input box 앞에 ID 부분을 회색으로 붙인다. --%>
					<div class="input-group mb-3">
						<div class="input-group-prepend">
							<span class="input-group-text">ID</span>
						</div>
						<input type="text" class="form-control" name="loginId">
					</div>

					<div class="input-group mb-3">
						<div class="input-group-prepend">
							<span class="input-group-text">PW</span>
						</div>
						<input type="password" class="form-control" name="password">
					</div>

					<%-- btn-block: 로그인 박스 영역에 버튼을 가득 채운다. --%>
					<a class="btn btn-block btn-dark" href="/user/sign_up_view">회원가입</a>
					<input type="submit" class="btn btn-block btn-info" value="로그인">
				</form>
			</div>
		</div>
	</div>

<script>
$(document).ready(function() {
	// 로그인 서브밋
	$('#loginForm').submit(function(e) {
		e.preventDefault(); // submit 자동 수행 중단
		
		var loginId = $('input[name=loginId]').val().trim();
		if (loginId == '') {
			alert("아이디를 입력해주세요.");
			return;
		}
		
		var password = $('input[name=password]').val();
		if (password == '') {
			alert("비밀번호를 입력해주세요.");
			return;
		}
		
		// AJAX로 서브밋
		var url = $(this).attr("action");
		var data = $(this).serialize(); // form의 name 속성으로 data를 구성한다.
		
		$.post(url, data)
		.done(function(data) {
			if (data.result == "success") {
				location.href="/timeline/timeline_view"; 
			} else {
				alert("로그인에 실패했습니다. 다시 시도해주세요.");
			}
		}); 
	});
});
</script>
</body>
</html>