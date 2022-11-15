<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html>

<head>

<title>퀴즈</title>

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
		<form action="/quiz/write" method="POST">

			<%---------- Hero Section ----------%>
			<section class="hero">
				<div class="container">
					<div class="row align-items-center">
						<div class="card mb-3 pt-2 text-center text-white bg-dark">
							<h2 id="title">
								<strong>퀴즈 게시판</strong>
							</h2>
							<a href="/quiz/list" class="side"><i class="fas fa-backward"></i></a>
						</div>

						<div id="body">
							<div class="container">
								<div id="quizBox" class="p-3">
									<div class="input-group mb-3">
										<span class="input-group-text">퀴즈 주제</span>
										<input type="text" name="title" class="form-control" required>
									</div>

									<div class="quiz-form mb-2">
										<div class="input-group mb-1">
											<span class="input-group-text">&nbsp;Q&nbsp;</span>
											<input type="text" class="form-control" name="questions" required>
											<button class="btn btn-dark btn-delete-question" type="button">
												<i class="fas fa-times text-white"></i>
											</button>
										</div>
										<div class="input-group mb-1">
											<span class="input-group-text">A1</span><input type="text" class="form-control" name="numOnes" required>
											<span class="input-group-text">A2</span><input type="text" class="form-control" name="numTwos" required>
											<span class="input-group-text">A3</span><input type="text" class="form-control" name="numThrees" required>
											<span class="input-group-text">A4</span><input type="text" class="form-control" name="numFours" required>
										</div>
										<div class="input-group">
											<label class="input-group-text" for="inputGroupSelect01">&nbsp;답</label>
											<select class="form-select" name="answers" required>
												<option value="" disabled selected>?</option>
												<option value="1">A1</option>
												<option value="2">A2</option>
												<option value="3">A3</option>
												<option value="4">A4</option>
											</select>
										</div>
									</div>
								</div>
								<button type="button" class="btn btn-secondary my-2" id="btn-addQuiz">문제 추가</button>
								<button type="submit" class="btn btn-dark mt-2" class="btn-quiz submit">완료</button>
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

	<script>
        $('#btn-addQuiz').on('click', function() {
            const str = `
			            <div class="quiz-form mb-2">
			                <div class="input-group mb-1">
			                    <span class="input-group-text">&nbsp;Q&nbsp;</span>
			                    <input type="text" class="form-control" name="questions" required>
			                    <button class="btn btn-dark btn-delete-question" type="button">
			                        <i class="fas fa-times text-white"></i>
			                    </button>
			                </div>
			                <div class="input-group mb-1">
			                    <span class="input-group-text">A1</span><input type="text" class="form-control" name="numOnes" required>
			                    <span class="input-group-text">A2</span><input type="text" class="form-control" name="numTwos" required>
			                    <span class="input-group-text">A3</span><input type="text" class="form-control" name="numThrees" required>
			                    <span class="input-group-text">A4</span><input type="text" class="form-control" name="numFours" required>
			                </div>
			                <div class="input-group">
			                    <label class="input-group-text" for="inputGroupSelect01">&nbsp;답</label>
			                    <select class="form-select" name="answers" required>
			                        <option value="" disabled selected>?</option>
			                        <option value="1">A1</option>
			                        <option value="2">A2</option>
			                        <option value="3">A3</option>
			                        <option value="4">A4</option>
			                    </select>
			                </div>
			            </div>
			            `;
            $('#quizBox').append(str);
        })
        
        $('#quizBox').on('click','button.btn-delete-question',function(){
            $(this).closest('div.quiz-form').remove();
        })
    </script>

</body>
</html>