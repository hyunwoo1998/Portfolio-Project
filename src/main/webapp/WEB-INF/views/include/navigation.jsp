<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<header class="header">
	<nav id="primary-nav" class="primary-menu navbar navbar-expand-lg navbar-light fixed-top">
		<div class="container">
			<a class="navbar-brand" href="/index"><img src="/resources/images/logo.png"></a>
			<button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse" id="navbarSupportedContent">
				<ul class="navbar-nav mx-auto mt-3 mt-md-0 mb-2 mb-lg-0">
					<li class="nav-item"><a class="nav-link" href="/quiz/list">퀴즈 목록</a></li>
					<li class="nav-item"><a class="nav-link" href="/board/list">자유 게시판</a></li>
				</ul>

				<c:choose>
					<c:when test="${empty sessionScope.id}">
						<a href="#" class="text-dark ms-3 fw-bold ms-lg-4" data-bs-toggle="modal" data-bs-target="#loginModal">로그인</a>
						<a href="/member/signUp" class="btn btn-dark ms-2 fw-bold ms-lg-4">회원가입</a>
					</c:when>
					<c:otherwise>
						<c:set var="fileCallPath" value="${ profileImg.uploadpath }/${profileImg.memberId}/s_${ profileImg.uuid }_${ profileImg.filename }" />
						<div class="box mx-3">
							<a href="/member/info" style="color: inherit;">${sessionScope.id}님 </a>
							<c:choose>
								<c:when test="${not empty profileImg }">
									<img class="profile" src="/display?fileName=${fileCallPath}" style="width: 50px; height: 50px; border-radius: 100px;">
								</c:when>
								<c:otherwise>
									<img class="profile" src="/resources/images/person.png" style="width: 50px; height: 50px; border-radius: 100px;" />
								</c:otherwise>
							</c:choose>
						</div>
					</c:otherwise>
				</c:choose>

			</div>
		</div>
	</nav>
</header>