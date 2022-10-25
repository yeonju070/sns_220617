<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div class="d-flex justify-content-center">
	<div class="w-50">
		<h1 class="my-3">글쓰기</h1>
		
		<input type="text" id="subject" class="form-control" placeholder="제목을 입력해주세요.">
		<textarea class="form-control" id="content" rows="15" cols="100" placeholder="내용을 입력해주세요."></textarea>
		<div class="d-flex justify-content-end my-3">
			<input type="file" id="file" accept=".jpg,.jpeg,.png,.gif">
		</div>
		<div class="d-flex justify-content-between my-3">
			<button type="button" id="postListBtn" class="btn btn-info">목록</button>
			<div class="d-flex justify-content-end">
				<button type="button" id="clearBtn" class="btn btn-danger">모두 지우기</button>
				<button type="button" id="postCreateBtn" class="btn btn-warning ml-3">저장</button>
			</div>
		</div>
	</div>
</div>