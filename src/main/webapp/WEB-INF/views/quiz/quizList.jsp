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

		<%---------- Hero Section ----------%>
		<section class="hero">
			<div class="container">
				<div class="row align-items-center">
					<div class="card mb-3 pt-2 text-center text-white bg-dark">
						<h2 id="title">
							<strong>퀴즈 게시판</strong>
						</h2>
						<c:if test="${ not empty id }">
							<a href="/quiz/write" class="side"><i class="fas fa-pencil-alt"></i></a>
						</c:if>
					</div>

					<div class="page-content note-has-grid">
						<div class="tab-content bg-transparent">
							<div id="note-full-container" class="note-has-grid row">
								<c:if test="${ fn:length(bunchList) eq 0 }">
									<div class="no-result">
										<p>검색결과 없음</p>
									</div>
								</c:if>
								<c:forEach var="bunch" items="${ bunchList }">
									<div class="col-md-4 single-note-item">
										<div class="card card-body shadow-sm" onclick="location.href='/quiz/content?bunchNum=${ bunch.num }'">
											<span class="side-stick"></span>
											<h5 class="note-title text-truncate mt-2">${ bunch.title }</h5>
											<p class="badge rounded-pill bg-dark mt-0">${ bunch.quizCount } 문제</p>
											<div class="note-content">
												<p class="note-inner-content text-muted">만든이 : ${ bunch.memberId }</p>
											</div>
										</div>
									</div>
								</c:forEach>
							</div>
						</div>
					</div>

					<div class="page-group">
						<ul class="page">						
							<c:if test="${ pageMaker.prev eq true }">
								<li>
									<a class="arrow left shadow-sm" href="/quiz/list?pageNum=${ pageMaker.startPage - 1 }&type=${ pageMaker.cri.type }&keyword=${ pageMaker.cri.keyword }">
										<i class="fa-solid fa-angles-left"></i>
									</a>
								</li>
							</c:if>
							<c:forEach var="i" begin="${ pageMaker.startPage }" end="${ pageMaker.endPage }" step="1">
								<li>
									<a class="num shadow-sm ${ pageMaker.cri.pageNum eq i ? 'active' : '' }" href="/quiz/list?pageNum=${ pageScope.i }&type=${ pageMaker.cri.type }&keyword=${ pageMaker.cri.keyword }">${ i }</a>
								</li>
							</c:forEach>
							<c:if test="${ pageMaker.next eq true }">
								<li>
									<a class="arrow right shadow-sm" href="/quiz/list?pageNum=${ pageMaker.endPage + 1 }&type=${ pageMaker.cri.type }&keyword=${ pageMaker.cri.keyword }">
										<i class="fa-solid fa-angles-right"></i>
									</a>
								</li>
							</c:if>
						</ul>
					</div>

					<form action="/quiz/list" method="GET">
						<div class="input-group mx-auto" style="width: 30%">
							<select class="btn btn-dark px-2" name="type">
								<option value="" disabled selected>선택</option>
								<option value="title" ${ pageMaker.cri.type eq 'title' ? 'selected' : '' }>제목</option>
								<option value="memberId" ${ pageMaker.cri.type eq 'memberId' ? 'selected' : '' }>작성자</option>
							</select>
							<input type="text" class="form-control" name="keyword" value="${ pageMaker.cri.keyword }">
							<button class="btn btn-dark px-3" type="submit" id="btnSearch">검색</button>
						</div>
					</form>

				</div>
			</div>
		</section>
		<%---------- Hero Section End ----------%>

	</main>
	<%---------- Main End ----------%>

	<%---------- Footer Include ----------%>
	<jsp:include page="/WEB-INF/views/include/footer.jsp" />
	<%---------- Footer Include End ----------%>

</body>
</html>