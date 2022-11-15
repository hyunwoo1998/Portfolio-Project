<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

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
		<form action="/member/remove" method="POST" id="frm">
		
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
								
									<h4 class="card-title text-center">회원 탈퇴</h4>
									
									<hr>

									<div class="form-group input-group-sm">
										<label for="id">아이디</label>
										<input id="id" type="text" class="form-control" name="id" value="${id}" readonly>
									</div>

									<div class="form-group input-group-sm">
										<label for="passwd">비밀번호</label>
										<input id="passwd" type="password" class="form-control" name="passwd" required>
										<div class="invalid-feedback">Password is Password?</div>
									</div>
								</div>
							</div>
							
							<button type="submit" class="btn btn-outline-secondary mt-2">탈퇴</button>

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

	<script>
		$('form#frm').on('submit', function(event) {
			var isDelete = confirm('정말 회원탈퇴 하시겠습니까?');

			if (isDelete == false) {
				event.preventDefault(); // form태그의 기본동작 막기
			}
		});
	</script>

</body>
</html>