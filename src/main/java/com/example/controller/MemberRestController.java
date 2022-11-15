package com.example.controller;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mindrot.jbcrypt.BCrypt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.example.domain.MemberVO;
import com.example.service.MemberService;

@RestController // 이 컨트롤러 클래스의 모든 메소드의 리턴값이 JSON 또는 XML 응답으로 동작함
@RequestMapping("/api/*")
public class MemberRestController {

	@Autowired
	private MemberService memberService;

	@GetMapping(value = "/members/{id}", produces = { MediaType.APPLICATION_JSON_VALUE, MediaType.APPLICATION_XML_VALUE })
	public ResponseEntity<Map<String, Object>> getOne(@PathVariable("id") String id) {

		MemberVO memberVO = memberService.getMemberById(id);
		int count = memberService.getCountById(id);

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("member", memberVO);
		map.put("count", count);

		return new ResponseEntity<Map<String, Object>>(map, HttpStatus.OK);
	} // getOne

	@GetMapping(value = "/members", produces = { MediaType.APPLICATION_JSON_VALUE, MediaType.APPLICATION_XML_VALUE })
	public ResponseEntity<List<MemberVO>> getAll() {

		List<MemberVO> memberList = memberService.getMembers();

		return new ResponseEntity<List<MemberVO>>(memberList, HttpStatus.OK);
	} // getAll

	@PostMapping(value = "/members", consumes = "application/json", produces = { MediaType.APPLICATION_JSON_VALUE, MediaType.APPLICATION_XML_VALUE })
	public ResponseEntity<Map<String, Object>> create(@RequestBody MemberVO memberVO) {

		// 회원가입날짜 설정
		memberVO.setRegDate(new Date());

		// 비밀번호를 jbcrypt 라이브러리 사용해서 암호화하여 저장하기
		String passwd = memberVO.getPasswd();
		String pwHash = BCrypt.hashpw(passwd, BCrypt.gensalt()); // 60글자로 암호화된 문자열 리턴함
		memberVO.setPasswd(pwHash); // 암호화된 비밀번호 문자열로 수정하기

		// 생년월일 문자열에서 하이픈(-) 기호 제거하기
		String birthday = memberVO.getBirthday();
		birthday = birthday.replace("-", ""); // 하이픈 문자열을 빈문자열로 대체
		memberVO.setBirthday(birthday);

		System.out.println(memberVO); // 서버 콘솔 출력

		// 회원가입 insert 처리하기
		memberService.register(memberVO);

		// 응답 데이터 준비
		Map<String, Object> map = new HashMap<>();
		map.put("result", "success");
		map.put("member", memberVO);

		// insert된 VO객체를 OK 상태코드와 함께 응답으로 줌
		return new ResponseEntity<Map<String, Object>>(map, HttpStatus.OK);
	} // create

	@PutMapping(value = "/members/{id}", consumes = "application/json", produces = MediaType.TEXT_PLAIN_VALUE)
	public ResponseEntity<String> modify(@PathVariable("id") String id, @RequestBody MemberVO memberVO) {

		// 회원가입날짜 설정
		memberVO.setRegDate(new Date());

		// 비밀번호를 jbcrypt 라이브러리 사용해서 암호화하여 저장하기
		String passwd = memberVO.getPasswd();
		String pwHash = BCrypt.hashpw(passwd, BCrypt.gensalt()); // 60글자로 암호화된 문자열 리턴함
		memberVO.setPasswd(pwHash); // 암호화된 비밀번호 문자열로 수정하기

		// 생년월일 문자열에서 하이픈(-) 기호 제거하기
		String birthday = memberVO.getBirthday();
		birthday = birthday.replace("-", ""); // 하이픈 문자열을 빈문자열로 대체
		memberVO.setBirthday(birthday);

		System.out.println(memberVO); // 서버 콘솔 출력

		// 회원정보 수정하기
		memberService.updateById(memberVO);

		// insert된 VO객체를 OK 상태코드와 함께 응답으로 줌
		return new ResponseEntity<String>("success", HttpStatus.OK);
	} // create

	@DeleteMapping(value = "/members/{id}", produces = MediaType.TEXT_PLAIN_VALUE)
	public ResponseEntity<String> remove(@PathVariable("id") String id) {

		int count = memberService.deleteById(id);

		// INTERNAL_SERVER_ERROR (500) : 서버 내부 로직 문제로 오류가 발생한 경우
		// BAD_GATEWAY (502) : 외부에서 전달받은 값이 잘못되어 오류가 발생한 경우

		return (count > 0) ? new ResponseEntity<String>("success", HttpStatus.OK) : new ResponseEntity<String>("fail", HttpStatus.BAD_GATEWAY);
	} // remove

}
