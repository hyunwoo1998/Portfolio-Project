<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!-- 문자열 →  Date 객체 변환  -->
<fmt:parseDate value="${member.birthday}" pattern="yyyymmdd" var="parseBirthday"/>

<!-- Date 객체 → 문자열 변환  -->
<fmt:formatDate value="${pageScope.parseBirthday}" pattern="yyyy-mm-dd" var="strBirthday" />

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
				  <div>
					  <div>
					    <div class="card">
					      <div class="card-body">
					        <div class="row">
					           <div class="col-md-6">
                                <c:choose>
                                    <c:when test="${ not empty profileImg }">
                                        <c:set var="fileCallPath" value="${ profileImg.uploadpath }/${profileImg.memberId}/s_${ profileImg.uuid }_${ profileImg.filename }" />
                                        <img src="/display?fileName=${fileCallPath}" class="img-fluid" style="width: 200px; height: 200px; border-radius: 100px; border: 2px solid gray;" />
                                    </c:when>
                                    <c:otherwise>
                                        <img src="/resources/images/person.png" class="img-fluid" style="width: 200px; height: 200px; border-radius: 100px; border: 2px solid gray;" />
                                    </c:otherwise>
                                </c:choose>
                                </div>
                                <div class="col-md-6" style="text-align: left;">
                                    <div class="card-body">
	                                    <div class="mb-3">
	                                        <p><b>아이디</b> : ${member.id}</p>
	                                    </div>
	                                    <div class="mb-3">
	                                        <p><b>이름</b> : ${member.name}</p>
	                                    </div>
	                                    <div class="mb-3">
	                                        <p><b>생년월일</b> : ${strBirthday}</p>
	                                    </div>
	                                    <div class="mb-3">
	                                        <p><b>성별</b> : ${ member.gender eq 'M' ? '남자' : '여자' }</p>
	                                    </div>
                                    </div>
                                </div>
                            </div>
					      </div>
					    </div>
					  </div>
					  <div class="my-3">
					    <div class="card">
					      <div class="card-body">
	                          <div class="row ps-4 pt-3" style="text-align: left;">
	                              <div class="col-md-6 mb-2">
	                                  <p><b>이메일</b> : ${member.email}</p>
	                              </div>
	                              <div class="col-md-6 mb-2">
	                                  <p><b>이메일 수신 여부</b> : ${ member.recvEmail eq 'Y' ? 'YES' : 'NO' }</p>
	                              </div>
	                              <div class="col-md-12">
	                                  <p><b>가입일</b> : ${ member.regDate }</p>
	                              </div>
	                          </div>
					      </div>
					    </div>
					  </div>
					  <a href="/member/modify" class="btn btn-outline-dark">정보 수정</a>
					  <a href="/member/remove" class="btn btn-outline-secondary">회원 탈퇴</a>
					  <a href="#" class="btn btn-outline-danger" data-bs-toggle="modal" data-bs-target="#logoutModal">로그아웃</a>
					</div>
				  
				  </div>
				</div>
				
			</div>
		</section>
		<%---------- Hero Section End ----------%>

	</main>
	<%---------- Main End ----------%>

    <!-- Logout Modal -->
    <div class="modal fade" id="logoutModal" tabindex="-1" aria-hidden="true">
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title">Logout</h5>
            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
          </div>
          <div class="modal-body">
          정말 로그아웃을 하시겠습니까?
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-primary"  onclick="location.href='/member/logout'">예</button>
            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
          </div>
        </div>
      </div>
    </div>

	<%---------- Footer Include ----------%>
	<jsp:include page="/WEB-INF/views/include/footer.jsp" />
	<%---------- Footer Include End ----------%>

</body>
</html>