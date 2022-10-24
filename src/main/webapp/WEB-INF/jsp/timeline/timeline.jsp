<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div class="d-flex justify-content-center">
	<div class="timeline-box">
		<form id="postForm" action="/user/timeline" method="post">
			<textarea rows="6" cols="70" placeholder="내용을 입력해주세요."></textarea>
			<div class="d-flex justify-content-between">
				<img src="/img/img.jpg">
				<input type="submit" class="btn btn-info form-control col-2" id="postBtn" name="postBtn">
			</div>
		</form>
	</div>
</div>