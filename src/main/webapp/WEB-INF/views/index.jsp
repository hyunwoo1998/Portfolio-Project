<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>

<head>
	<title>홈</title>
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
				<div class="row align-items-center">
					<div class="col-md-12 col-lg-6 order-2 order-lg-1">
						<div class="hero-content  mx-auto">
							<h1 class="hero-title text-dark mb-5">놀면서<br>공부하는<br><strong>퀴즈캣</strong></h1>
							<span class="hero-subtitle lead fw-normal" data-aos="fade-right" data-aos-delay="100" data-aos-easing="ease-in-sine">혹시 공부할 게 너무 많아서 힘드신가요?</span><br>
							<span class="hero-subtitle lead fw-normal" data-aos="fade-right" data-aos-delay="1250" data-aos-easing="ease-in-sine">또는 공부한 내용을 테스트해보고 싶나요?</span><br>
							<span class="hero-subtitle lead fw-normal" data-aos="fade-right" data-aos-delay="2500" data-aos-easing="ease-in-sine">그렇다면 퀴즈캣의 고양이 손이라도 빌리면 어떨까요?</span>
							<div class="hero-btns mt-2 mb-5" data-aos="fade-right" data-aos-delay="3000" data-aos-easing="ease-in-sine" data-aos-duration="500">
								<a href="/quiz/list" class="btn btn-dark hero-btn btn-lg">시작하기</a>
							</div>
						</div>
					</div>
					<div class="col-md-12 col-lg-6 order-1 order-lg-2">
						<div class="hero-img position-relative">
							<svg viewBox="0 0 500 500" xmlns="http://www.w3.org/2000/svg" width="100%" class="hero-blob waving">
                            <path d="M405,320.5Q332,391,231,424.5Q130,458,107.5,354Q85,250,107,145.5Q129,41,242.5,53.5Q356,66,417,158Q478,250,405,320.5Z" fill="#f1f1f1"></path>
                            </svg>
							<img id="cat-img" class="rounded floating" src="/resources/images/cat.svg">
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