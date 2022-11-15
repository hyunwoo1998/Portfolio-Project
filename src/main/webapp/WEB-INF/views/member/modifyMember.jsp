<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!-- 문자열 →  Date 객체 변환  -->
<fmt:parseDate value="${member.birthday}" pattern="yyyymmdd" var="dateBirthday" />

<!-- Date 객체 → 문자열 변환  -->
<fmt:formatDate value="${pageScope.dateBirthday}" pattern="yyyy-mm-dd" var="strBirthday" />

<!DOCTYPE html>
<html>

<head>

<title>내 정보</title>

<%---------- Head Include ----------%>
<jsp:include page="/WEB-INF/views/include/head.jsp" />
<%---------- Head Include End ----------%>

</head>

<body>

	<%---------- Navigation Include ----------%>
	<jsp:include page="/WEB-INF/views/include/navigation.jsp" />
	<%---------- Navigation Include End ----------%>

	<%---------- Login Modal Include ----------%>
	<jsp:include page="/WEB-INF/views/include/loginModal.jsp" />
	<%---------- Login Modal Include End ----------%>

	<%---------- Main ----------%>
	<main>
		<form action="/member/modify" method="POST" enctype="multipart/form-data">
		
			<%---------- Hero Section ----------%>
			<section class="hero">
				<div class="container">

					<div class="card shadow-sm text-center px-0" style="margin: auto 20em">
					
                      <div class="card-header">
                        <ul class="nav nav-tabs card-header-tabs">
                            <li class="nav-item"><a class="nav-link active" aria-current="true" href="/member/info">내 정보</a></li>
                            <li class="nav-item"><a class="nav-link" href="/member/passwd">비밀번호 변경</a></li>
                            <li class="nav-item dropdown"><a class="nav-link dropdown-toggle" data-bs-toggle="dropdown" href="#" role="button" aria-expanded="false">내 활동</a>
                                <ul class="dropdown-menu">
                                    <li><a class="dropdown-item" href="/member/myBoard">내 게시물</a></li>
                                    <li><a class="dropdown-item" href="/member/myComment">내 댓글</a></li>
                                    <li><hr class="dropdown-divider"></li>
                                    <li><a class="dropdown-item" href="/member/myQuiz">만든 퀴즈</a></li>
                                    <li><a class="dropdown-item" href="/member/mySolveHistory">푼 퀴즈</a></li>
                                </ul>
                            </li>
                         </ul>
                       </div>
                        
						<div class="card-body">
							<div class="card memberPage m-0">
								<div class="card-body col-8 mx-auto">
									<h4 class="card-title text-center">정보 수정</h4>
									<hr>

									<div class="form-group input-group-sm">
										<label for="id">아이디</label>
										<input id="id" type="text" class="form-control" name="id" value="${member.id}" readonly>
									</div>

									<div class="form-group input-group-sm">
										<label for="passwd">비밀번호</label>
										<input id="passwd" type="password" class="form-control" name="passwd" required>
										<div class="invalid-feedback">Password is Password?</div>
									</div>

									<div class="form-group input-group-sm">
										<label for="birthday">생년월일</label>
										<input id="birthday" type="date" class="form-control" name="birthday" value="${strBirthday}">
									</div>

									<div class="form-group input-group-sm">
										<label for="multipartFile">프로필 사진</label>
										<input type="file" class="form-control" id="formFileSm" name="multipartFile" aria-label="Upload" required>
									</div>

									<hr>

									<div class="form-group input-group-sm">
										<label for="name">이름</label>
										<input id="name" type="text" class="form-control" name="name" value="${member.name}">
									</div>

									<div class="form-group input-group-sm">
						                <label for="gender">성별</label>
	                                    <div class="form-check form-check-inline">
	                                        <input type="radio" class="btn btn-check" id="gender-M" name="gender" value="M" <c:if test="${member.gender eq 'M'}">checked</c:if>>
	                                        <label class="btn btn-outline-secondary" for="gender-M">남자</label>
	                                    </div>
	                                    <div class="form-check form-check-inline">
	                                        <input type="radio" class="btn btn-check" id="gender-F" name="gender" value="F" <c:if test="${member.gender eq 'F'}">checked</c:if>>
	                                        <label class="btn btn-outline-secondary" for="gender-F">여자</label>
	                                    </div>
									</div>

									<div class="form-group input-group-sm">
										<label for="email">이메일</label>
										<input id="email" type="email" class="form-control" value="${member.email}" name="email">
									</div>

									<div class="form-group input-group-sm">
										<label for="recvEmail">이메일 수신 여부</label>
	                                    <div class="form-check form-check-inline">
	                                        <input type="radio" class="btn btn-check" id="recvEmail-Y" name="recvEmail" value="Y" <c:if test="${member.recvEmail eq 'Y'}">checked</c:if>>
	                                        <label class="btn btn-outline-secondary" for="recvEmail-Y">예</label>
	                                    </div>
	                                    <div class="form-check form-check-inline">
	                                        <input type="radio" class="btn btn-check" id="recvEmail-N" name="recvEmail" value="N" <c:if test="${member.recvEmail eq 'N'}">checked</c:if>>
	                                        <label class="btn btn-outline-secondary" for="recvEmail-N">아니오</label>
	                                    </div>
									</div>

								</div>
							</div>
							
							<button type="submit" class="btn btn-outline-dark mt-2">확인</button>

						</div>
					</div>

				</div>
			</section>
			<%---------- Hero Section End ----------%>
			
		</form>
	</main>
	<%---------- Main End ----------%>

	<%---------- Footer Include ----------%>
	<jsp:include page="/WEB-INF/views/include/footer.jsp" />
	<%---------- Footer Include End ----------%>

</body>
</html>