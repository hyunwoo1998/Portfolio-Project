<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html>

<head>

<title>${ bunch.title }</title>

<%---------- Head Include ----------%>
<jsp:include page="/WEB-INF/views/include/head.jsp" />
<%---------- Head Include End ----------%>

<link href="/resources/css/quiz.css" rel="stylesheet">

</head>

<body>

	<%---------- Navigation Include ----------%>
	<jsp:include page="/WEB-INF/views/include/navigation.jsp" />
	<%---------- Navigation Include End ----------%>

	<%---------- Login Modal Include ----------%>
	<jsp:include page="/WEB-INF/views/include/loginModal.jsp" />
	<%---------- Login Modal Include End ----------%>

	<%---------- Main ----------%>
	<main class="m-0">
		<form action="/quiz/submit?bunchNum=${ bunch.num }" method="POST">
		
			<%---------- Hero Section ----------%>
			<section class="hero">
				<div class="container">
					<div class="row align-items-center">
						<div class="card mb-3 pt-2 text-center text-white bg-dark">
							<h2 id="title">
								<strong>퀴즈 게시판</strong>
							</h2>
							<a href="/quiz/list" id="btn-back" class="side"><i class="fas fa-backward"></i></a>
							<c:if test="${ id eq bunch.memberId || id eq 'admin' }">
								<a href="/quiz/modify?bunchNum=${ bunch.num }" id="btn-modify" class="side"><i class="fas fa-edit"></i></a>
								<a onclick="btnDelete()" id="btn-delete" class="side"><i class="fas fa-trash"></i></a>
							</c:if>
						</div>

						<div class="card border-dark p-0 text-center">
							<div class="card-header">${ bunch.title }</div>
							<div class="card-body text-dark row">

								<c:forEach var="quiz" items="${ quizList }">
									<div class="col-4 mb-4">
										<h4 class="question">${ quiz.questionNum }. ${ quiz.question }</h4>
										<input type="radio" class="btn btn-check" id="${ quiz.question }-1" name="reply${ quiz.questionNum }" value="1" required>
										<label class="mt-2 btn btn-outline-secondary" for="${ quiz.question }-1">${ quiz.numOne }</label>
										<input type="radio" class="btn btn-check" id="${ quiz.question }-2" name="reply${ quiz.questionNum }" value="2" required>
										<label class="mt-2 btn btn-outline-secondary" for="${ quiz.question }-2">${ quiz.numTwo }</label>
										<input type="radio" class="btn btn-check" id="${ quiz.question }-3" name="reply${ quiz.questionNum }" value="3" required>
										<label class="mt-2 btn btn-outline-secondary" for="${ quiz.question }-3">${ quiz.numThree }</label>
										<input type="radio" class="btn btn-check" id="${ quiz.question }-4" name="reply${ quiz.questionNum }" value="4" required>
										<label class="mt-2 btn btn-outline-secondary" for="${ quiz.question }-4">${ quiz.numFour }</label>
									</div>
									<br>
								</c:forEach>

							</div>
							<button class="card-footer border-dark btn btn-dark submit">제출하기</button>
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
     function btnDelete(){
         var isDelete = confirm('정말 삭제하시겠습니까?');
         
         if(isDelete == true){
             alert('삭제가 완료되었습니다.');
             location.href='/quiz/delete?bunchNum=${ bunch.num }';
         }
     }
    </script>

</body>
</html>