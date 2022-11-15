<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html>

<head>

<title>자유 게시판</title>

<%---------- Head Include ----------%>
<jsp:include page="/WEB-INF/views/include/head.jsp" />
<%---------- Head Include End ----------%>

<link rel="stylesheet" href="/resources/css/board.css">

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
							<strong>자유 게시판</strong>
						</h2>
						<a href="/board/list?pageNum=${ pageNum }" id="btn-back" class="side"><i class="fas fa-backward"></i></a>
                        <c:if test="${ id eq board.memberId || id eq 'admin' }">
                            <a href="/board/modify?num=${ board.num }&pageNum=${ pageNum }" id="btn-modify" class="side"><i class="fas fa-edit"></i></a>
                            <a onclick="deleteBoard()" id="btn-delete" class="side"><i class="fas fa-trash"></i></a>
                       </c:if>
					</div>
					<div class="card">
						<div class="text-dark mx-auto mt-4" style="width: 98%">
							<h3 class="font-weight-bold text-left">${ board.subject }</h3>
							<div>
								<ul class="list" style="margin-left: -35px;">
									<li>&nbsp;<b>${ board.memberId }</b>&nbsp;</li>
									<li>&nbsp;<b>조회수</b>&nbsp;${ board.viewCount }&nbsp;</li>
									<li class="comment-count">&nbsp;<b>댓글</b>&nbsp;${ fn:length(commentList) }&nbsp;</li>
									<li>&nbsp;<b>작성일</b>&nbsp;<fmt:formatDate value="${ board.regDate }" pattern="yyyy.MM.dd (HH:mm)" />&nbsp;</li>
								</ul>
							</div>
							<hr>
							<div class="my-3">${ board.content }</div>
							
							<div id="dashedLine"></div>
                        <div>
                            <c:choose>
                                <c:when test="${ fn:length(attachList) gt 0 }">
                                    <c:forEach var="attach" items="${ attachList }">
                                        <c:if test="${ attach.filetype eq 'O' }">
                                            <c:set var="fileCallPath"
                                                value="${ attach.uploadpath }/${ attach.uuid }_${ attach.filename }" />
                                            <div>
                                                <a href="/download?fileName=${ fileCallPath }"><i class="far fa-file-alt me-2"></i>${ attach.filename }</a>
                                            </div>
                                        </c:if>
                                        <c:if test="${ attach.filetype eq 'I' }">
                                            <c:set var="fileCallPath"
                                                value="${ attach.uploadpath }/s_${ attach.uuid }_${ attach.filename }"/>
                                            <c:set var="fileCallPathOrigin"
                                                value="${ attach.uploadpath }/${ attach.uuid }_${ attach.filename }"/>
                                            <div>
                                                <a href="/download?fileName=${ fileCallPathOrigin }"><i class="far fa-file-image me-2"></i>${ attach.filename }
                                                    <img src="/display?fileName=${ fileCallPath }" style="width: 50px">
                                                </a>
                                            </div>
                                        </c:if>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <div>
                                        <a><i class="fas fa-file-excel me-2"></i>첨부파일이 존재하지 않습니다.</a>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </div>
							<div id="dashedLine"></div>
							
							<div class="mt-4 text-center likey-row">
	                            <div class="likey-box" onclick="clickBtnLikey()">
	                                <div class="my-2 text-center">
	                                   <span class="likey-icon mx-1">
	                                    <c:choose>
	                                        <c:when test="${ isRecommended eq true }">
	                                            <i class="fas fa-laugh-beam"></i>
	                                        </c:when>
	                                        <c:otherwise>
	                                            <i class="far fa-smile"></i> 
	                                        </c:otherwise>
	                                    </c:choose>
	                                    </span>
	                                    <span class="recCount mx-1">${ recCount }</span>
	                                </div>
	                            </div>
	                        </div>
							
							<hr>
							
							<div>
							
							    <ul class="list" style="margin-left: -35px;">
                                        <li><span class="comment-count">댓글 ${ fn:length(commentList) }개</span>&nbsp;</li>
                                    <c:if test="${ not empty id }">
                                        <li>&nbsp;<a href="/board/reply?num=${ board.num }&pageNum=${ pageNum }" class="btn btn-dark">답글</a></li>
                                    </c:if>
                                </ul>
								
								<div id="dashedLine"></div>

								<div>
									<div class="row comment-line">
									
										<c:choose>
											<c:when test="${ fn:length(commentList) gt 0 }">
												<c:forEach var="comment" items="${ commentList }">
													<div class="comment-parent" id="comment${ comment.num }">
														<input class="hidden-num" type="hidden" name="num" value="${ comment.num }" />
														<div class="row" style="padding-left: ${ comment.reLev * 20 }px;">
															<div class="col-md-6 mx-2 speech-bubble text-white">
																<c:if test="${ comment.reLev gt 0 }">
																	<span>&nbsp;⮡&nbsp;</span>
																</c:if>
																ID : ${ comment.memberId }
															</div>
															<div class="col-12 my-2">
																<i class="fas fa-angle-right mx-1"></i>${ comment.content }</div>
														    <c:if test="${ not empty id }">
																<div class="mb-3">
																	<div class="badge bg-dark comment-option btn-commentReply">답글</div>
																	<c:if test="${ comment.memberId eq id || id eq 'admin' }">
																		<div class="badge bg-secondary comment-option btn-commentModify">수정</div>
																		<div class="badge bg-danger comment-option btn-commentDelete">삭제</div>
																	</c:if>
																</div>
															</c:if>
														</div>
														<div class="commentModify-form" style="display: none; padding-left: ${ comment.reLev * 20 }px;">
															<div class="col-md-12 comment-write-title">
																<span>⮡&nbsp;</span>댓글 수정
															</div>
															<form class="modifyComment-form">
																<div class="form-floating mb-3">
																	<input type="hidden" name="num" value="${ comment.num }" />
																	<textarea name="content" class="form-control" id="modifyComment-content" style="height: 7rem">${ comment.content }</textarea>
																</div>
															</form>
															<div class="row div-right">
																<c:if test="${ comment.memberId eq id || id eq 'admin' }">
																	<div class="badge bg-dark btn-modifyComment btn-comment">확인</div>
																</c:if>
															</div>
														</div>
														<div class="commentReply-form" style="display: none; padding-left: ${ comment.reLev * 20 }px;">
															<div class="col-md-12 comment-write-title">
																<span>⮡&nbsp;</span>답글 쓰기
															</div>
															<form class="replyComment-form">
																<div class="form-floating mb-3">
																	<input type="hidden" name="num" value="${ comment.num }" />
																	<input type="hidden" name="boardNum" value="${ board.num }" />
																	<input type="hidden" name="memberId" value="${ id }" />
																	<input type="hidden" name="reRef" value="${ comment.reRef }" />
																	<input type="hidden" name="reLev" value="${ comment.reLev }" />
																	<input type="hidden" name="reSeq" value="${ comment.reSeq }" />
																	<textarea name="content" class="form-control" id="replyComment-content" style="height: 7rem"></textarea>
																	<label for="replyComment-content">답글 작성</label>
																</div>
															</form>
															<div class="row div-right">
																<div class="badge bg-dark btn-replyComment btn-comment">확인</div>
															</div>
														</div>
													</div>
												</c:forEach>
											</c:when>
											<c:otherwise>
												<div>댓글이 없습니다.</div>
											</c:otherwise>
										</c:choose>
										
									</div>
								</div>

                                <c:if test="${ not empty id }">
									<form class="newComment-form my-2">
										<div class="form-floating">
											<input type="hidden" name="boardNum" value="${ board.num }" />
											<input type="hidden" name="memberId" value="${ id }" />
											<textarea id="comment-content" name="content" class="form-control" style="height: 7rem"></textarea>
											<label for="comment-content">댓글 입력</label>
										</div>
									</form>
	
									<div class="mb-3">
										<button type="button" class="btn btn-dark btn-newComment">확인</button>
										<button type="reset" class="btn btn-secondary">취소</button>
									</div>
								</c:if>

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

	<script>
    // 댓글 작성
    $('.btn-newComment').on('click',function(){
        
        var content = $('#comment-content').val();
        
        if(content.length < 5){
            alert('5글자 이상 입력하세요');
            return false;
        }
        
        var obj = $('.newComment-form').serializeObject();
        console.log(obj);
        console.log(typeof obj);
        
        var strJson = JSON.stringify(obj);
        console.log(strJson);
        console.log(typeof strJson);
        
        $.ajax({
            url: '/api/comment',
            method: 'POST',
            data: strJson,
            contentType: 'application/json; charset=UTF-8',
            success: function (data){
                console.log(data)
                location.reload();
            }
        });
        
        $('#comment-content').val('');
        
    });
    
    // 댓글 수정 토글
    $(document).on('click','.btn-commentModify',function(){
        var $commentModify = $(this).parents('.comment-parent').children('.commentModify-form');
        
        $commentModify.toggle();
    });
    
    // 댓글 답글 토글
    $(document).on('click','.btn-commentReply',function(){
        var $commentReply = $(this).parents('.comment-parent').children('.commentReply-form');
        
        $commentReply.toggle();
    });
    
    // 댓글 수정 클릭
    $(document).on('click','.btn-modifyComment',function(){
        
        var content = $(this).parents('.commentModify-form').find('#modifyComment-content').val();
        
        console.log('content : ' + content);
        
        if(content.length < 5){
            alert('5글자 이상 입력하세요');
            return false;
        }
        
        var $form = $(this).parents('.commentModify-form').children('.modifyComment-form');
        
        var obj = $form.serializeObject();
        console.log(obj);
        console.log(typeof obj);
        
        var strJson = JSON.stringify(obj);
        console.log(strJson);
        console.log(typeof strJson);
        
        var num = obj.num;
        
        console.log('num : ' + num);
        
        $.ajax({
            url: '/api/comment/' + num,
            method: 'PUT',
            data: strJson,
            contentType: 'application/json; charset=UTF-8',
            success: function(data){
                console.log(data);
                location.reload();
            }
        });
    });
    
    // 댓글 삭제 클릭
    $(document).on('click','.btn-commentDelete',function(){
        
        var isRight = confirm('정말 삭제하시겠습니까?');
        
        if(isRight == false){
            return false;
        }
        
        var num = $(this).parents('.comment-parent').children('.hidden-num').val();
        
        console.log("num : "+ num);
        
        $.ajax({
            url: '/api/comment/' + num,
            method: 'DELETE',
            success : function(data){
                console.log(data);
                location.reload();
                alert('삭제 완료');
            }
        });
    });
    
    // 댓글 답글 클릭
    $(document).on('click','.btn-replyComment',function(){
        
        var $form = $(this).parents('.commentReply-form').children('.replyComment-form');
        
        var obj = $form.serializeObject();
        console.log(obj);
        console.log(typeof obj);
        
        var strJson = JSON.stringify(obj);
        console.log(strJson);
        console.log(typeof strJson);
        
        $.ajax({
            url: '/api/replyComment',
            method: 'POST',
            data: strJson,
            contentType: 'application/json; charset=UTF-8',
            success: function (data) {
                console.log(data);
                location.reload();
            }
        });
    });
    
    // 게시글 삭제 클릭
    function deleteBoard(){
        
        if(confirm('정말 삭제하시겠습니까?') == false){
            return false
        }
        
        alert('삭제완료');
        
        location.href='/board/remove?num=${ board.num }&pageNum=${ pageNum }';
    }
    
    // 추천 버튼 클릭 시
    function clickBtnLikey(){
        
        var boardNum = '${ board.num }';
        console.log('boardNum : ' + boardNum);
        
        var sessionId = '${ id }';
        console.log('id : ' +sessionId);
        
        if(sessionId == '' || sessionId.length==0){
            alert('로그인이 필요한 서비스 입니다.');
            return false;
        }
        
        var recBoardVO = {
                'boardNum' : boardNum,
                'memberId' : sessionId,
        }
        
        console.log(recBoardVO);
        
        
        $.ajax({
            url: '/api/recBoard/' + boardNum,
            method: 'GET',
            success: function(data){
                console.log(data);
                console.log(typeof data);
                console.log(data.recIdList);
                console.log(data.count);
                
                var recIdList = data.recIdList;
                
                console.log('recIdList : ' + recIdList);
                
                var result = recIdList.indexOf(sessionId);
                
                console.log('result : ' + result);
                
                
                if(recIdList.indexOf(sessionId) == -1){// id가 존재하지않음
                    $.ajax({
                        url: '/api/addRecBoard',
                        method: 'POST',
                        data : JSON.stringify(recBoardVO),
                        contentType: 'application/json',
                        success: function (data){
                            console.log(data);
                            
                            console.log($('.likey-icon'));
                        
                            $('.likey-icon')[0].innerHTML = '<i class="fas fa-laugh-beam"></i>';
                            $('span.recCount')[0].innerText = data.recCount;
                        }
                    });
                    
                }else{ // id가 존재함
                    $.ajax({
                        url: '/api/deleteRecBoard',
                        method: 'DELETE',
                        data : JSON.stringify(recBoardVO),
                        contentType: 'application/json',
                        success: function (data){
                            console.log(data);
                            
                            $('.likey-icon')[0].innerHTML = '<i class="far fa-smile"></i>';
                            $('span.recCount')[0].innerText = data.recCount;
                        }
                    });
                    
                }
                
                
            }
        });
        
    }
    </script>

</body>
</html>