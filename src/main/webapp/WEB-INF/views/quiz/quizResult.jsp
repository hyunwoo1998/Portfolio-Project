<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html>

<head>

<title>${ bunch.title } 결과</title>

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
						</div>
						
						<h4 class="text-center">점수 : ${ solveHistory.point } 점</h4>
						<hr>

						<div class="card border-dark p-0 text-center mb-2">
							<div class="card-header">틀린 문제</div>
							<div class="card-body text-dark row">
								<c:if test="${ fn:length(incorrectList) eq 0 }">
				                    <h4>없습니다!!!</h4>
				                </c:if>
				                <c:forEach var="quiz" items="${ incorrectList }">
								<div class="col-4">
								    <h4 class="question">${ quiz.questionNum }. ${ quiz.question }</h4>
								    <button class="mt-2 btn ${ quiz.answer eq '1' ? 'btn-danger' : 'btn-outline-secondary' }" disabled>${ quiz.numOne }</button>
								    <button class="mt-2 btn ${ quiz.answer eq '2' ? 'btn-danger' : 'btn-outline-secondary' }" disabled>${ quiz.numTwo }</button>
								    <button class="mt-2 btn ${ quiz.answer eq '3' ? 'btn-danger' : 'btn-outline-secondary' }" disabled>${ quiz.numThree }</button>
								    <button class="mt-2 btn ${ quiz.answer eq '4' ? 'btn-danger' : 'btn-outline-secondary' }" disabled>${ quiz.numFour }</button>
								    <hr>
								    <p>정답 : ${ quiz.answer }번</p>
								</div>
								</c:forEach>
							</div>
						</div>

						<div class="card border-dark p-0 text-center">
							<div class="card-header">맞은 문제</div>
							<div class="card-body text-dark row">
								<c:if test="${ fn:length(correctList) eq 0 }">
				                    <h4>없습니다…</h4>
				                </c:if>
				                <c:forEach var="quiz" items="${ correctList }">
								<div class="col-4">
								    <h4 class="question">${ quiz.questionNum }. ${ quiz.question }</h4>
								    <button class="mt-2 btn ${ quiz.answer eq '1' ? 'btn-primary' : 'btn-outline-secondary' }" disabled>${ quiz.numOne }</button>
                                    <button class="mt-2 btn ${ quiz.answer eq '2' ? 'btn-primary' : 'btn-outline-secondary' }" disabled>${ quiz.numTwo }</button>
                                    <button class="mt-2 btn ${ quiz.answer eq '3' ? 'btn-primary' : 'btn-outline-secondary' }" disabled>${ quiz.numThree }</button>
                                    <button class="mt-2 btn ${ quiz.answer eq '4' ? 'btn-primary' : 'btn-outline-secondary' }" disabled>${ quiz.numFour }</button>
								    <hr>
                                    <p>정답 : ${ quiz.answer }번</p>
								</div>
								</c:forEach>
							</div>
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