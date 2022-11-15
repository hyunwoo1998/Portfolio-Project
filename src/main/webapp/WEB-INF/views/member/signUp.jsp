<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html>

<head>

<title>회원가입</title>

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
	<main class="memberPage">
		<form action="/member/signUp" class="my-login-validation" method="POST" enctype="multipart/form-data">

            <%---------- Section ----------%>
			<section>
				<div class="container">
					<div class="row justify-content-md-center">
						<div class="card-wrapper">
							<div class="card fat shadow rounded">
								<div class="card-body text-center">

									<h4 class="card-title text-center">회원가입</h4>

									<hr>

									<div class="form-group input-group-sm">
										<label for="id">아이디</label>
										<input id="nid" type="text" class="form-control" name="id" required autofocus>
									</div>

									<div class="form-group input-group-sm">
										<label for="passwd">비밀번호</label>
										<input id="npasswd" type="password" class="form-control" name="passwd" required>
									</div>

									<div class="form-group input-group-sm">
										<label for="passwd2">비밀번호 재확인</label>
										<input id="npasswd2" type="password" class="form-control" name="passwd2" required>
									</div>

									<div class="form-group input-group-sm">
										<label for="birthday">생년월일</label>
										<input id="birthday" type="date" class="form-control" name="birthday" required>
									</div>

									<div class="form-group input-group-sm">
										<label for="multipartFile">프로필 사진</label>
										<input type="file" class="form-control" id="formFileSm" name="multipartFile" aria-label="Upload" required>
									</div>

									<div class="text-center">
										<button type="button" id="optionalBtn" class="btn btn-secondary btn-sm" onclick="option();">선택 정보</button>
									</div>

									<fieldset id="optional">

										<hr>
										
										<div class="form-group input-group-sm">
											<label for="name">이름</label>
											<input id="name" type="text" class="form-control" name="name">
										</div>

										<div class="form-group input-group-sm">
											<label for="gender">성별</label>
											<div class="form-check form-check-inline">
											    <input type="radio" class="btn btn-check" id="gender-M" name="gender" value="M">
                                                <label class="btn btn-outline-secondary" for="gender-M">남자</label>
											</div>
											<div class="form-check form-check-inline">
												<input type="radio" class="btn btn-check" id="gender-F" name="gender" value="F">
                                                <label class="btn btn-outline-secondary" for="gender-F">여자</label>
											</div>
										</div>

										<div class="form-group input-group-sm">
											<label for="email">이메일</label>
											<input id="email" type="email" class="form-control" name="email">
										</div>

										<div class="form-group input-group-sm">
											<label for="recvEmail">이메일 수신 여부</label>
											<div class="form-check form-check-inline">
												<input type="radio" class="btn btn-check" id="recvEmail-Y" name="recvEmail" value="Y">
                                                <label class="btn btn-outline-secondary" for="recvEmail-Y">예</label>
											</div>
											<div class="form-check form-check-inline">
											    <input type="radio" class="btn btn-check" id="recvEmail-N" name="recvEmail" value="N">
                                                <label class="btn btn-outline-secondary" for="recvEmail-N">아니오</label>
											</div>
										</div>
										
									</fieldset>

									<hr>

									<div class="form-group d-md-block text-center">
										<button type="submit" class="btn btn-dark">가입</button>
									</div>

								</div>
							</div>
						</div>
					</div>
				</div>
			</section>
			<%---------- Section End ----------%>

		</form>
	</main>
	<%---------- Main End ----------%>

	<%---------- Footer Include ----------%>
	<jsp:include page="/WEB-INF/views/include/footer.jsp" />
	<%---------- Footer Include End ----------%>

	<script>
		function option() {
			$('#optional').show();
			$('#optionalBtn').hide();
		};
		
		$('input#nid').on('keyup', function(event) {
			if (!(event.keyCode >= 37 && event.keyCode <= 40)) {
			    var id = $(this).val();
			    $(this).val(id.replace(/[^a-z0-9]/gi, ''));
			}
		});

		// 회원가입 아이디 중복여부 확인하기
		$('input#nid').on('focusout', function () {
		    
			var id = $(this).val();
			if (id.length == 0) {
			    return;
			}
		    
		    // ajax 함수 호출
			$.ajax({
			url: '/api/members/' + id,
			method: 'GET',
				success: function (data) {
				console.log(data);
				console.log(typeof data);
				
					if (data.count == 0) {
						alert('사용 할 수 있는 아이디입니다.');
					} else { // data.count == 1
						alert('중복된 아이디입니다.');
						$('input#nid').focus().val('');
					}
				} // success
			});
		    
		});
		
		$('input#npasswd2').on('focusout',function(){
			
			const npasswd2 = $(this).val();
			const npasswd = $('input#npasswd').val();
			
			if(npasswd == npasswd2){
				alert('비밀번호가 일치합니다.');
			}else{
				alert('비밀번호가 일치하지 않습니다.');
			    $('input#npasswd2').val('');
			    $('input#npasswd').focus().val('');
			}
		      
		});
    </script>

</body>
</html>