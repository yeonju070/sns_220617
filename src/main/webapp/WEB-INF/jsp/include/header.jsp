<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="header-box d-flex justify-content-between align-items-center">
	<%-- logo --%>
	<div>
		<h1 class="font-weight-bold">
			<a href="/timeline/timeline_view">
				<img src="https://cdn.icon-icons.com/icons2/2699/PNG/512/instagram_wordmark_logo_icon_169660.png" alt="인스타 사진" width="230px">
			</a>
		</h1>
	</div>

	<%-- 로그인 정보 --%>
	<div>
		<%-- 로그인이 되었을 때만 정보 노출 --%>
		<c:if test="${not empty userName}">
			<span>${userName} 안녕하세요</span>
			<a href="/user/sign_out" class="ml-3 font-weight-bold">로그아웃</a>
		</c:if>
	</div>
</div>