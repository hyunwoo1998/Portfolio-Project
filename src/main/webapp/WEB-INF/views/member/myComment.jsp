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

		<%---------- Hero Section ----------%>
		<section class="hero">
			<div class="container">

				<div class="card shadow-sm text-center px-0" style="margin: auto 20em">

					<div class="card-header">
						<ul class="nav nav-tabs card-header-tabs">
							<li class="nav-item"><a class="nav-link" aria-current="true" href="/member/info">내 정보</a></li>
							<li class="nav-item"><a class="nav-link" href="/member/passwd">비밀번호 변경</a></li>
							<li class="nav-item dropdown"><a class="nav-link dropdown-toggle active" data-bs-toggle="dropdown" href="#" role="button" aria-expanded="false">내 활동</a>
								<ul class="dropdown-menu">
									<li><a class="dropdown-item" href="/member/myBoard">내 게시물</a></li>
									<li><a class="dropdown-item active" href="/member/myComment">내 댓글</a></li>
									<li><hr class="dropdown-divider"></li>
									<li><a class="dropdown-item" href="/member/myQuiz">만든 퀴즈</a></li>
									<li><a class="dropdown-item" href="/member/mySolveHistory">푼 퀴즈</a></li>
								</ul>
							</li>
						</ul>
					</div>

					<div class="card-body">
						<div class="card m-0">
							<div class="card-body col-12 mx-auto">
								<h4 class="card-title text-center">내가 쓴 댓글</h4>
								<hr>

								<table class="table table-hover" id="myComment">
                                    <thead>
                                        <tr>
                                            <th>댓글 번호</th>
                                            <th>댓글 내용</th>
                                            <th>작성일</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:choose>
                                            <c:when test="${ pageMaker.totalCount gt 0 }">
                                                <c:forEach var="comment" items="${ commentList }">
                                                    <tr onclick="location.href='/board/content?num=${ comment.boardNum }&commentNum=${ comment.num }#comment${ comment.num }'">
                                                        <td>${ comment.num }</td>
                                                        <td>
                                                            <c:if test="${ comment.reLev gt 0 }">
                                                                <span class="reply-level">⮡ </span>
                                                            </c:if>
                                                            ${ comment.content }
                                                        </td>
                                                        <td><fmt:formatDate value="${ comment.regDate }" pattern="yyyy.MM.dd"/></td>
                                                    </tr>
                                                </c:forEach>
                                            </c:when>
                                            <c:otherwise>
                                                <tr>
                                                    <td colspan="3">
                                                        <div class="no-result">
                                                            <p>검색결과 없음</p>
                                                        </div>
                                                    </td>
                                                </tr>
                                            </c:otherwise>
                                        </c:choose>
                                    </tbody>
                                </table>

                        		<div class="page-group">
									<ul class="page">						
										<c:if test="${ pageMaker.prev eq true }">
											<li>
												<a class="arrow left shadow-sm" href="/member/myCommentList?pageNum=${ pageMaker.startPage - 1 }&type=${ pageMaker.cri.type }&keyword=${ pageMaker.cri.keyword }#myComment">
													<i class="fa-solid fa-angles-left"></i>
												</a>
											</li>
										</c:if>
										<c:forEach var="i" begin="${ pageMaker.startPage }" end="${ pageMaker.endPage }" step="1">
											<li>
												<a class="num shadow-sm ${ pageMaker.cri.pageNum eq i ? 'active' : '' }" href="/member/myCommentList?pageNum=${ pageScope.i }&type=${ pageMaker.cri.type }&keyword=${ pageMaker.cri.keyword }#myComment">${ i }</a>
											</li>
										</c:forEach>
										<c:if test="${ pageMaker.next eq true }">
											<li>
												<a class="arrow right shadow-sm" href="/member/myCommentList?pageNum=${ pageMaker.endPage + 1 }&type=${ pageMaker.cri.type }&keyword=${ pageMaker.cri.keyword }#myComment">
													<i class="fa-solid fa-angles-right"></i>
												</a>
											</li>
										</c:if>
									</ul>
								</div>

                        <form action="/member/myCommentList" method="GET" id="frm">
                        <input type="hidden" name="pageNum" value="${ pageMaker.cri.pageNum }">
                            <div class="input-group mx-auto my-2" style="width: 60%">
                                <select class="btn btn-dark px-2" name="type">
                                    <option value="content" selected>내용</option>
                                </select>
                                <input id="autocomplete-input" type="text" class="form-control autocomplete" name="keyword" value="${ pageMaker.cri.keyword }">
                                <button class="btn btn-dark px-3" type="submit" id="btnSearch">검색</button>
                            </div>
                        </form>

							</div>
						</div>


					</div>
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