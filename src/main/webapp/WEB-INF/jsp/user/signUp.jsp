<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 회원가입 --%>
<h1 class="text-center my-4">회원가입</h1>
<div class="d-flex justify-content-center">
	<form id="signUpForm" method="post" action="/user/sign_up">
		<%-- 아이디 --%>
		<div>아이디</div>
		<div class="d-flex">
			<input type="text" id="loginId" name="loginId" class="form-control" placeholder="아이디를 입력하세요.">
			<button type="button" id="loginIdCheckBtn" class="btn btn-success">중복확인</button>
		</div>
		
		<%-- 아이디 체크 결과 --%>
		<%-- d-none 클래스: display none (보이지 않게) --%>
		<div>
			<div id="idCheckLength" class="small text-danger d-none">ID를 4자 이상 입력해주세요.</div>
			<div id="idCheckDuplicated" class="small text-danger d-none">이미 사용중인 ID입니다.</div>
			<div id="idCheckOk" class="small text-success d-none">사용 가능한 ID 입니다.</div>
		</div>
		
		<%-- 비밀번호 --%>
		<div class="mt-2 sign-up-subject">비밀번호</div>
		<div>
			<input type="password" name="password" class="form-control" placeholder="비밀번호를 입력하세요">
		</div>

		<%-- 비밀번호 확인 --%>
		<div class="mt-2 sign-up-subject">비밀번호 확인</div>
		<div>
			<input type="password" name="confirmPassword" class="form-control" placeholder="비밀번호를 입력하세요">
		</div>

		<%-- 이름 --%>
		<div class="mt-2 sign-up-subject">이름</div>
		<div>
			<input type="text" name="name" class="form-control" placeholder="이름을 입력하세요">
		</div>

		<%-- 이메일 --%>
		<div class="mt-2 sign-up-subject">이메일</div>
		<div>
			<input type="text" name="email" class="form-control" placeholder="이메일을 입력하세요">
		</div>
		
		<%-- 가입하기 버튼 --%>
		<div class="mt-3">
			<button type="submit" id="signUpBtn" class="btn btn-success float-right mb-5">가입하기</button>
		</div>
	</form>
</div>
<script>
$(document).ready(function() {
	// 아이디 중복 확인
	$('#loginIdCheckBtn').on('click', function(e) {
		// validation
		let loginId = $('input[name=loginId]').val().trim();
		// id가 4자 이상이 아니면 경고문구 노출하고 끝낸다.
		if (loginId.length < 4) {
			$('#idCheckLength').removeClass('d-none'); // 경고문구 노출
			$('#idCheckDuplicated').addClass('d-none'); // 숨김
			$('#idCheckOk').addClass('d-none'); // 숨김
			return;
		}
		
		// 중복여부는 DB를 조회해야 하므로 서버에 묻는다. 
		// 화면을 이동시키지 않고 ajax 통신으로 중복여부 확인하고 동적으로 문구 노출
		$.ajax({
			url: "/user/is_duplicated_id",
			data: {"loginId": loginId},
			success: function(data) {
				if (data.result == true) { // 중복인 경우
					$('#idCheckDuplicated').removeClass('d-none'); // 중복 경고문구 노출
					$('#idCheckLength').addClass('d-none'); // 숨김
					$('#idCheckOk').addClass('d-none'); // 숨김
				} else {
					$('#idCheckOk').removeClass('d-none'); // 사용가능 문구 노출
					$('#idCheckLength').addClass('d-none'); // 숨김
					$('#idCheckDuplicated').addClass('d-none'); // 숨김
				}
			},
			error: function(error) {
				alert("아이디 중복확인에 실패했습니다. 관리자에게 문의해주세요.");
			}
		});
	});
	
	// 이번에는 서브밋 대신 일반 버튼 클릭으로 해본다.
	$('#signUpBtn').on('click', function(e) {
		e.preventDefault(); // 클릭 이벤트의 기본 동작을 중단
		
		// validation
		let loginId = $('input[name=loginId]').val().trim();
		if (loginId == '') {
			alert("아이디를 입력하세요.");
			return;
		}
		
		let password = $('input[name=password]').val().trim();
		let confirmPassword = $('input[name=confirmPassword]').val().trim();
		if (password == '' || confirmPassword == '') {
			alert("비밀번호를 입력하세요.");
			return;
		}
		
		// 비밀번호 확인 일치 여부
		if (password != confirmPassword) {
			alert("비밀번호가 일치하지 않습니다. 다시 입력하세요.");
			// 텍스트박스의 값을 초기화 한다.
			$('#password').val('');
			$('#confirmPassword').val('');
			return;
		}
		
		let name = $('input[name=name]').val().trim();
		if (name == '') {
			alert("이름을 입력하세요.");
			return;
		}
		let email = $('input[name=email]').val().trim();
		if (email == '') {
			alert("이메일 주소를 입력하세요.");
			return;
		}
		
		// 아이디 중복확인이 완료되었는지 확인
		//-- idCheckOk <div>의 클래스에 d-none이 없으면 사용가능으로 본다.
		if ($('#idCheckOk').hasClass('d-none') == true) {
			alert("아이디 확인을 다시 해주세요.");
			return;
		}
		
		
		// submit
		// 1. ajax로 서브밋
		// 2. non ajax 서브밋
		
		// 1) ajax
		let url = $('#signUpForm').attr("action");     // form에 있는 action 주소를 가져온다
		let params = $('#signUpForm').serialize(); // 폼태그 한번에 보낼 수 있게 구성한다.(이걸 사용하지 않으면 data에 json을 직접 만들어야 함)
		
		$.post(url, params)
		.done(function(data) {
			if (data.result == "success") {
				alert("가입을 환영합니다!!! 로그인을 해주세요.");				
				location.href="/user/sign_in_view";
			} else {
				alert("가입에 실패했습니다. 다시 시도해주세요.");
			}
		}); 
	})
	
	
});
</script>