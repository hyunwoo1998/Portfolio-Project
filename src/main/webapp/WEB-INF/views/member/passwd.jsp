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
		<form action="/member/passwd" method="POST" id="frm">
		
			<%---------- Hero Section ----------%>
			<section class="hero">
				<div class="container">

					<div class="card shadow-sm text-center px-0" style="margin: auto 20em">
					
	                 <div class="card-header">
                        <ul class="nav nav-tabs card-header-tabs">
                            <li class="nav-item"><a class="nav-link" aria-current="true" href="/member/info">내 정보</a></li>
                            <li class="nav-item"><a class="nav-link active" href="/member/passwd">비밀번호 변경</a></li>
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
								
									<h4 class="card-title text-center">비밀번호 변경</h4>
									
									<hr>

									<input id="id" type="hidden" class="form-control" name="id" value="${id}">

									<div class="form-group input-group-sm">
										<label for="passwd">기존 비밀번호</label>
										<input id="passwd" type="password" class="form-control" name="passwd" required>
									</div>

									<div class="form-group input-group-sm">
										<label for="passwd">새 비밀번호</label>
										<input id="npasswd" type="password" class="form-control" name="npasswd" required>
									</div>

									<div class="form-group input-group-sm">
										<label for="passwd">비밀번호 재확인</label>
										<input id="npasswd2" type="password" class="form-control" name="npasswd2" required>
									</div>
									
								</div>
							</div>
							
							<button type="submit" class="btn btn-outline-secondary mt-2">수정</button>

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
	    $('input#npasswd2').on('focusout', function () {
	        
	        const npasswd = $('input#npasswd').val();
	        const npasswd2 = $(this).val();
	        
	        if (npasswd != npasswd2) {
	            alert('비밀번호가 일치하지 않습니다.');
	            $('input#npasswd2').val('');
	            $('input#npasswd').focus().val('');
	        }
	    });
	    
	
	    $('form#frm').on('submit',function(event){
	        
	        var result = confirm("비밀번호를 변경하시겠습니까");
	        
	        if(result == false){
	            event.preventDefault();
	        }
	
	    });
	</script>

</body>
</html>