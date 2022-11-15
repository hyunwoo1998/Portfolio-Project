<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<form action="/member/login" method="POST" id="login-frm" name="login-frm" class="login-frm">
	<div class="modal fade" id="loginModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h4 class="modal-title" id="exampleModalLabel">Login</h4>
					<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				</div>
				<div class="modal-body memberPage m-0 px-5">

					<div class="form-group input-group-sm">
						<label for="id">아이디</label>
						<input id="id" type="text" class="form-control" name="id" required autofocus>
					</div>

					<div class="form-group input-group-sm">
						<label for="passwd">비밀번호</label>
						<input id="passwd" type="password" class="form-control" name="passwd" required>
					</div>

					<div class="form-group form-check">
						<input type="checkbox" class="form-check-input" id="loginRememberMe" name="rememberMe">
						<label class="form-check-label" for="loginRememberMe">로그인 유지</label>
					</div>
					<hr>
					<div class="form-group d-md-block text-center">
						<button type="submit" class="btn btn-dark">로그인</button>
						<button type="button" class="btn btn-danger" data-bs-dismiss="modal">취소</button>
					</div>
				</div>
			</div>
		</div>
	</div>
</form>