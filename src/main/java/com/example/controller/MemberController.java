package com.example.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.mindrot.jbcrypt.BCrypt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.example.domain.BoardVO;
import com.example.domain.BunchVO;
import com.example.domain.CommentVO;
import com.example.domain.Criteria;
import com.example.domain.MemberVO;
import com.example.domain.PageDTO;
import com.example.domain.ProfileImg;
import com.example.domain.SolveHistoryVO;
import com.example.service.MemberService;
import com.example.service.ProfileService;
import com.example.service.QuizService;
import com.example.util.JScript;

import net.coobird.thumbnailator.Thumbnailator;

@Controller
@RequestMapping("/member/*")
public class MemberController {

	
	@Autowired
	private MemberService memberService;
	@Autowired
	private ProfileService profileImgService;
	@Autowired
	private QuizService quizService;

	
	/****************************** GetMapping ******************************/

	@GetMapping("/signUp")
	public String signUp() {
		// 호출 확인용
		System.out.println("signUp 호출됨...");

		return "member/signUp";
	}

	@GetMapping("/logout")
	public String logout(HttpSession session, HttpServletRequest request, HttpServletResponse response) {

		session.invalidate();

		Cookie[] cookies = request.getCookies();

		if (cookies != null) {
			for (Cookie cookie : cookies) {
				if (cookie.getName().equals("loginId")) {
					cookie.setMaxAge(0);
					cookie.setPath("/");
					response.addCookie(cookie);
				}
			}
		}

		return "redirect:/member/signUp";
	} // logout

	@GetMapping("/info")
	public void info(HttpSession session, Model model) {
		System.out.println("information 호출됨...");
		String id = (String) session.getAttribute("id");

		// 회원 정보 조회
		MemberVO memberVO = memberService.getMemberById(id);

		// 회원 프로필 사진 조회
		ProfileImg profileImg = profileImgService.getProfileImg(id);
		System.out.println("프로필 나오는지 test 중입니다... " + profileImg);

		// 뷰에서 사용할 데이터를 Model 객체에 저장 -> requestScope로 옮겨줌
		model.addAttribute("member", memberVO);
		model.addAttribute("profileImg", profileImg);

	}

	@GetMapping("/passwd")
	public String passwd(HttpSession session, Model model) {
		System.out.println("비밀번호 수정 페이지 호출됨...");
		String id = (String) session.getAttribute("id");
		model.addAttribute("id", id);
		return "/member/passwd";
	} // passwd 비밀번호 변경 페이지 호출

	@GetMapping("/modify") // GET - "/member/modify"
	public String modifyForm(HttpSession session, Model model) throws Exception {
		String id = (String) session.getAttribute("id");

		// 회원 정보 조회
		MemberVO memberVO = memberService.getMemberById(id);

		// 회원 프로필 사진 조회
		ProfileImg profileImg = profileImgService.getProfileImg(id);
		System.out.println("프로필 나오는지 test 중입니다... " + profileImg);

		// 뷰에서 사용할 데이터를 Model 객체에 저장 -> requestScope로 옮겨줌
		model.addAttribute("member", memberVO);
		model.addAttribute("profileImg", profileImg);

		// 날짜 설정은 jsp 페이지에서 jstl 형식으로 해주기!!!!

		return "member/modifyMember";
	} // modifyForm 회원수정 페이지로!

	@GetMapping("/remove")
	public String removeForm() {
		System.out.println("removeForm() 호출됨...");
		return "member/removeMember";
	} // removeForm

	@GetMapping("/myBoard")
	public String myboardlistpage(Criteria cri, Model model, HttpSession session) {
		System.out.println("myboardlistpage 화면 호출됨...");

		String id = (String) session.getAttribute("id");

		List<BoardVO> myBoardList = memberService.getMyBoardListByCri(cri, id);

		System.out.println("myBoardList : " + myBoardList);

		int totalCount = memberService.getMyAllBoardsCount(cri, id);

		System.out.println("totalCount : " + totalCount);

		PageDTO pageDTO = new PageDTO(cri, totalCount);

		model.addAttribute("boardList", myBoardList);
		model.addAttribute("pageMaker", pageDTO);

		return "member/myBoard";
	} // myBoard

	@GetMapping("/myComment")
	public String myreplyListpage(Criteria cri, Model model, HttpSession session) {

		System.out.println("======== /myComment ========");

		String id = (String) session.getAttribute("id");

		List<CommentVO> myCommentList = memberService.getMyCommentListByCri(cri, id);

		int totalCount = memberService.getMyAllCommentsCount(cri, id);

		System.out.println("myCommentList : " + myCommentList);
		System.out.println("totalCount : " + totalCount);

		PageDTO pageDTO = new PageDTO(cri, totalCount);

		model.addAttribute("commentList", myCommentList);
		model.addAttribute("pageMaker", pageDTO);

		return "member/myComment";
	} // myComment

	@GetMapping("/myQuiz")
	public String myQuizListpage(Criteria cri, Model model, HttpSession session) {
		System.out.println("myQuizListpage 화면 호출됨...");

		System.out.println("cri : " + cri);
		String id = (String) session.getAttribute("id");

		// BunchVO 테이블에서 (검색어가 있으면)검색, 페이징 적용한 글 리스트 가져오기
		List<BunchVO> myQuizList = quizService.getBunchesById(cri, id);

		// 검색유형, 검색어가 있으면 적용하여 글개수 가져오기
		int totalCount = quizService.getCountBunchesById(id);

		// 페이지블록 정보 객체준비. 필요한 정보를 생성자로 전달.
		PageDTO pageDTO = new PageDTO(cri, totalCount);

		// 뷰에서 사용할 데이터를 Model 객체에 저장 → 스프링(dispathcer servlet)이 requestScope로 옯겨줌.
		model.addAttribute("myQuiz", myQuizList);
		model.addAttribute("pageMaker", pageDTO);

		return "member/myQuiz";
	} // myQuiz

	@GetMapping("/mySolveHistory")
	public String myPrevQuizListpage(Criteria cri, Model model, HttpSession session) {
		System.out.println("mySolveHistory 화면 호출됨...");

		String id = (String) session.getAttribute("id");

		// SolveHistoryVO 테이블에서 (검색어가 있으면)검색, 페이징 적용한 글 리스트 가져오기
		List<SolveHistoryVO> myPrevQuizList = quizService.getSolveHistoryAndBunch(cri, id);

		// 검색유형, 검색어가 있으면 적용하여 글개수 가져오기
		int totalCount = myPrevQuizList.size();

		// 페이지블록 정보 객체준비. 필요한 정보를 생성자로 전달.
		PageDTO pageDTO = new PageDTO(cri, totalCount);

		// 뷰에서 사용할 데이터를 Model 객체에 저장 → 스프링(dispathcer servlet)이 requestScope로 옯겨줌.
		model.addAttribute("quizCheck", myPrevQuizList);
		model.addAttribute("pageMaker", pageDTO);

		return "member/mySolveHistory";
	} // mySolveHistory

	/****************************** GetMapping End ******************************/

	
	/****************************** PostMapping ******************************/

	@PostMapping("/signUp")
	public ResponseEntity<String> signUp(MemberVO memberVO, MultipartFile multipartFile, HttpSession session)
			throws IllegalStateException, IOException {

		// 회원가입 날짜 설정
		memberVO.setRegDate(new Date());

		// 비밀번호를 jbcrypt 라이브러리 사용해서 암호화하여 저장하기
		String passwd = memberVO.getPasswd();
		String pwHash = BCrypt.hashpw(passwd, BCrypt.gensalt()); // 60글자로 암호화된 문자열 리턴함
		memberVO.setPasswd(pwHash); // 암호화된 비밀번호 문자열로 수정하기

		// 생년월일에서 하이픈(-) 제거
		String birthday = memberVO.getBirthday();
		birthday = birthday.replace("-", ""); // 하이픈 문자열을 빈문자열로 변경
		memberVO.setBirthday(birthday);

		// 첨부파일 업로드(썸네일 생성) 후 profileImg 리턴
		ProfileImg profileImg = uploadProfile(multipartFile, memberVO.getId(), "profileImg"); // 예외처리하기
		System.out.println("profile : " + profileImg);

		// 업로드 할 이미지 파일이 있는 경우
		if (profileImg != null) {
			// 프로필 사진 테이블에서 정보 삽입하기
			profileImgService.insertProfileImg(profileImg);

			session.setAttribute("profileImg", profileImg); // VO도 같이 가져오기
		}

		memberService.register(memberVO);

		HttpHeaders headers = new HttpHeaders();
		headers.add("Content-Type", "text/html; charset=UTF-8");

		String str = JScript.href("회원가입 성공!", "/");

		return new ResponseEntity<String>(str, headers, HttpStatus.OK);
	} // signUp

	@PostMapping("/login") // POST - "/member/login"
	public ResponseEntity<String> login(String id, String passwd, @RequestParam(required = false, defaultValue = "false") boolean rememberMe,
			HttpSession session, HttpServletResponse response) {
		// 콘트롤러 메소드의 매개변수 형식이 기본자료형(String형 포함)에 해당하면
		// 해당 매개변수 이름으로 사용자 입력 파라미터값을 자동으로 찾아서 넣어줌.

		MemberVO memberVO = memberService.getMemberById(id);

		boolean isPasswdSame = false;
		String message = "";

		if (memberVO != null) { // id 일치
			isPasswdSame = BCrypt.checkpw(passwd, memberVO.getPasswd());

			if (isPasswdSame == false) { // 비밀번호 일치하지 않음
				message = "비밀번호가 일치하지 않습니다.";
			}
		} else { // id 불일치
			message = "존재하지 않는 아이디 입니다.";
		}

		// 로그인 실패인 경우 (없는 아이디거나 비밀번호가 틀렸을때)
		if (memberVO == null || isPasswdSame == false) {
			HttpHeaders headers = new HttpHeaders();
			headers.add("Content-Type", "text/html; charset=UTF-8");

			String str = JScript.back(message);

			return new ResponseEntity<String>(str, headers, HttpStatus.OK);
		}

		// 로그인 성공인 경우
		// 로그인 인증 처리
		// 사용자 당 유지되는 세션객체에 기억할 데이터를 저장
		session.setAttribute("id", id);

		// 로그인 상태유지가 체크되었으면(사용자가 로그인 유지를 원하면)
		if (rememberMe == true) {
			// 쿠키 생성
			Cookie cookie = new Cookie("loginId", id);
			// 쿠키 유효시간(유통기한) 설정
			// cookie.setMaxAge(60 * 10); // 초단위로 설정. 10분 = 60초 * 10
			cookie.setMaxAge(60 * 60 * 24 * 7); // 1주일 설정.

			// 쿠키 경로설정
			cookie.setPath("/"); // 프로젝트 모든 경로에서 쿠키 받도록 설정

			// 클라이언트로 보낼 쿠키를 response 응답객체에 추가하기. -> 응답시 쿠키도 함께 보냄.
			response.addCookie(cookie);
		}

		HttpHeaders headers = new HttpHeaders();
		headers.add("Location", "/"); // redirect 경로를 "/"로 지정
		// 리다이렉트일 경우는 응답코드로 HttpStatus.FOUND 를 지정해야함에 주의!
		return new ResponseEntity<String>(headers, HttpStatus.FOUND);
	} // login

	@PostMapping("/passwd")
	public ResponseEntity<String> passwdPro(String id, String passwd, String npasswd, MemberVO memberVO) {

		MemberVO memberVO1 = memberService.getMemberById(id);
		String message = "";

		boolean isPasswdSame = BCrypt.checkpw(passwd, memberVO1.getPasswd());

		if (isPasswdSame == false) { // 비밀번호 일치하지 않음
			message = "비밀번호가 일치하지 않습니다.";
			HttpHeaders headers = new HttpHeaders();
			headers.add("Content-Type", "text/html; charset=UTF-8");

			String str = JScript.back(message);
			return new ResponseEntity<String>(str, headers, HttpStatus.OK);
		}

		String pwHash = BCrypt.hashpw(npasswd, BCrypt.gensalt()); // 60글자로 암호화된 문자열 리턴함

		memberVO1.setPasswd(pwHash);

		memberService.updateOnlyPasswd(memberVO1);

		HttpHeaders headers = new HttpHeaders();
		headers.add("Content-Type", "text/html; charset=UTF-8");

		String str = JScript.href("비밀번호변경 성공!", "/member/passwd");

		return new ResponseEntity<String>(str, headers, HttpStatus.OK);
	} // passwdPro

	@PostMapping("/modify")
	public ResponseEntity<String> modifyPro(MemberVO memberVO, MultipartFile multipartFile, HttpSession session)
			throws IllegalStateException, IOException {

		System.out.println("POST modify... file : " + multipartFile.isEmpty()); // 파일이 받아와 지는지 콘솔창에서 확인하기!!

		String id = (String) session.getAttribute("id");

		// DB 테이블에서 id에 해당하는 데이터 행 가져오기
		MemberVO dbMemberVO = memberService.getMemberById(id);

		boolean isPasswdSame = BCrypt.checkpw(memberVO.getPasswd(), dbMemberVO.getPasswd());
		if (isPasswdSame == false) {
			HttpHeaders headers = new HttpHeaders();
			headers.add("Content-Type", "text/html; charset=UTF-8");

			String str = JScript.back("비밀번호 틀림");

			return new ResponseEntity<String>(str, headers, HttpStatus.OK);
		}
		// 비밀번호 일치할 때

		// 첨부파일 업로드(썸네일 생성) 후 profilepicVO 리턴
		ProfileImg profileImg = uploadProfile(multipartFile, memberVO.getId(), "profileImg"); // 예외처리하기
		System.out.println("POST modify... profilepicVO : " + profileImg); //

		// 업로드 또는 변경할 이미지 파일이 있는 경우
		if (profileImg != null) {
			// 현재 해당 id의 회원정보 프로필 사진 조회
			ProfileImg profilepic = profileImgService.getProfileImg(memberVO.getId());

			if (profilepic != null) { // 프로필 사진이 있으면

				// 프로필 사진 테이블에서 정보 업데이트하기
				profileImgService.updateProfileImg(profileImg);

			} else {
				// 프로필 사진 테이블에서 정보 삽입하기
				profileImgService.insertProfileImg(profileImg);
			}

			session.setAttribute("profileImg", profileImg); // VO도 같이 가져오기
		}

		// 회원정보 수정날짜로 수정하기
		memberVO.setRegDate(new Date());

		// 생년월일 문자열에서 하이픈(-) 기호 제거하기
		String birthday = memberVO.getBirthday();
		birthday = birthday.replace("-", ""); // 하이픈 문자열을 빈문자열로 대체
		memberVO.setBirthday(birthday);

		System.out.println(memberVO); // 서버 콘솔 출력

		memberService.updateById(memberVO);

		HttpHeaders headers = new HttpHeaders();
		headers.add("Content-Type", "text/html; charset=UTF-8");

		String str = JScript.href("회원정보 수정성공", "/");

		return new ResponseEntity<String>(str, headers, HttpStatus.OK);
	}// 수정하는 페이지 : Pro 역할, 처리하는 곳.

	@PostMapping("/remove")
	public ResponseEntity<String> removePro(String passwd, HttpSession session, HttpServletRequest request, HttpServletResponse response) {
		System.out.println("remove() 호출됨...");

		// 세션에서 로그인 아이디 가져오기
		String id = (String) session.getAttribute("id");

		// DB에서 아이디로 자신의 정보를 VO로 가져오기
		MemberVO memberVO = memberService.getMemberById(id);

		// 비밀번호 비교하기
		boolean isPasswdSame = BCrypt.checkpw(passwd, memberVO.getPasswd());

		// 비밀번호가 일치하지 않을 때
		if (isPasswdSame == false) { // !isPasswdSame 과 같음
			HttpHeaders headers = new HttpHeaders();
			headers.add("Content-Type", "text/html; charset=UTF-8");

			String str = JScript.back("비밀번호 틀림");
			return new ResponseEntity<String>(str, headers, HttpStatus.OK);
		}

		// 비밀번호가 일치할 때
		memberService.deleteById(id); // DB 레코드 삭제

		// 해당 아이디 회원 프로필 사진 조회
		ProfileImg isProfileImg = profileImgService.getProfileImg(id);

		// 프로필 사진 존재하면 삭제하기
		if (isProfileImg != null) {
			// 프로필 사진 정보 삭제
			profileImgService.deleteProfileImg(id);
			// 프로필 사진 삭제
			deleteProfile(isProfileImg, "profileImg");
		}

		session.invalidate(); // 세션 비우기

		// 쿠키값 가져오기
		Cookie[] cookies = request.getCookies();

		// 특정 쿠키 삭제하기(브라우저가 삭제하도록 유효기간 0초로 설정해서 보내기)
		if (cookies != null) {
			for (Cookie cookie : cookies) {
				if (cookie.getName().equals("loginId")) { // ""안에 들어갈 아이디 잘 보기!
					cookie.setMaxAge(0); // 쿠키 유효기간 0초 설정(삭제 의도)
					cookie.setPath("/");
					response.addCookie(cookie); // 응답객체에 추가하기
				}
			}
		}
		HttpHeaders headers = new HttpHeaders();
		headers.add("Content-Type", "text/html; charset=UTF-8");

		String str = JScript.href("회원탈퇴 하였습니다.", "/");

		return new ResponseEntity<String>(str, headers, HttpStatus.OK);

	} // remove -- 실제 삭제처리

	/****************************** PostMapping End ******************************/

	
	/****************************** Method ******************************/

	// 년/월/일 형식의 폴더명 리턴하는 메소드
	private String getFolder() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
		String str = sdf.format(new Date());
		return str;
	} // getFolder

	// 프로필 업로드 메소드
	private ProfileImg uploadProfile(MultipartFile multipartFile, String id, String isProfileImg) throws IllegalStateException, IOException {

		ProfileImg profileImg = null;

		// 업로드 할 파일이 없으면 메소드 종료
		if (multipartFile == null) {
			return profileImg;
		}

		profileImg = new ProfileImg();

		String uploadFolder = "C:/portfolio/upload"; // 업로드 기준경로

		File uploadPath = new File(uploadFolder, getFolder());

		// 프로필 사진일 경우(경로 변경)
		if (isProfileImg != null) {
			uploadFolder = "C:/portfolio/upload/profile/" + id;
			uploadPath = new File(uploadFolder);
		}

		if (!uploadPath.exists()) {
			uploadPath.mkdirs();
		}

		if (!multipartFile.isEmpty()) {
			String originalFilename = multipartFile.getOriginalFilename();
			UUID uuid = UUID.randomUUID();
			String uploadFilename = uuid.toString() + "_" + originalFilename;

			File proFile = new File(uploadPath, uploadFilename); // 생성할 파일이름 정보

			multipartFile.transferTo(proFile);
			System.out.println("프로필 사진 파일 업로드 성공!");

			// 현재 업로드한 파일이 이미지 파일이면 썸네일 이미지를 추가로 생성하기
			File outFile = new File(uploadPath, "s_" + uploadFilename);

			Thumbnailator.createThumbnail(proFile, outFile, 200, 200); // 썸네일 이미지 파일 생성하기

			profileImg.setUuid(uuid.toString());
			profileImg.setUploadpath((isProfileImg != null) ? "profile" : getFolder());
			profileImg.setFilename(originalFilename);
			profileImg.setMemberId(id);
		}

		return profileImg;
	} // uploadProfile

	// 프로필 삭제 메소드
	private void deleteProfile(ProfileImg profileImg, String isProfileImg) {

		if (profileImg == null) {
			return;
		}

		String basePath = "C:/portfolio/upload";

		String uploadpath = basePath + "/" + profileImg.getUploadpath();

		if (isProfileImg != null) {
			basePath = "C:/portfolio/upload/profile/" + profileImg.getMemberId();

		}

		String filename = profileImg.getUuid() + "_" + profileImg.getFilename();

		File file = new File(uploadpath, filename);

		if (file.exists() == true) { // 해당 경로에 첨부파일이 존재하면
			file.delete(); // 첨부파일 삭제하기
		}

		File thumbnailFile = new File(uploadpath, "s_" + filename);

		if (thumbnailFile.exists() == true) {
			thumbnailFile.delete();
		}

	} // deleteProfile

	/****************************** Method End ******************************/

}
