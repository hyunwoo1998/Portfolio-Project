package com.example.controller;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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

import com.example.domain.CommentVO;
import com.example.service.CommentService;

@RestController
@RequestMapping("/api/*")
public class CommentRestController {

	
	private CommentService commentService;

	public CommentRestController(CommentService commentService) {
		super();
		this.commentService = commentService;
	}
	

	@GetMapping(value = "/comment/{boardNum}", produces = { MediaType.APPLICATION_JSON_VALUE,
			MediaType.APPLICATION_XML_VALUE })
	public ResponseEntity<Map<String, Object>> getCommentsByBoardNum(@PathVariable("boardNum") int boardNum) {

		List<CommentVO> commentList = commentService.getCommentsByBoardNum(boardNum);

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("commentList", commentList);
		map.put("count", commentList.size());

		return new ResponseEntity<Map<String, Object>>(map, HttpStatus.OK);
	} // getCommentsByBoardNum

	@PostMapping(value = "/comment", consumes = "application/json", produces = { MediaType.APPLICATION_JSON_VALUE,
			MediaType.APPLICATION_XML_VALUE })
	public ResponseEntity<Map<String, Object>> insertComment(@RequestBody CommentVO commentVO) {

		System.out.println("commentVO : " + commentVO);

		int nextNum = commentService.getNextNum();

		commentVO.setNum(nextNum);
		commentVO.setRegDate(new Date());
		commentVO.setReRef(nextNum);
		commentVO.setReLev(0);
		commentVO.setReSeq(0);

		System.out.println("수정 후 commentVO : " + commentVO);

		commentService.insertComment(commentVO);

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("result", "success");

		return new ResponseEntity<Map<String, Object>>(map, HttpStatus.OK);
	} // insertComment
	
	@PostMapping(value = "/replyComment", consumes = "application/json", produces = { MediaType.APPLICATION_JSON_VALUE,
			MediaType.APPLICATION_XML_VALUE })
	public ResponseEntity<Map<String, Object>> replyComment(@RequestBody CommentVO commentVO) {

		System.out.println("commentVO : " + commentVO);

		int nextNum = commentService.getNextNum();

		commentVO.setNum(nextNum);
		commentVO.setRegDate(new Date());
		commentVO.setReLev(commentVO.getReLev() + 1);
		commentVO.setReSeq(commentVO.getReSeq() + 1);

		System.out.println("수정 후 commentVO : " + commentVO);
		
		commentService.insertReplyComment(commentVO);

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("result", "success");

		return new ResponseEntity<Map<String, Object>>(map, HttpStatus.OK);
	} // replyComment

	@PutMapping(value = "/comment/{num}", consumes = "application/json", produces = { MediaType.APPLICATION_JSON_VALUE,
			MediaType.APPLICATION_XML_VALUE })
	public ResponseEntity<Map<String, Object>> modifyComment(@RequestBody CommentVO commentVO, @PathVariable int num) {

		System.out.println("commentVO : " + commentVO);
		System.out.println("num : " + num);

		commentService.updateComment(commentVO);

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("result", "success");

		return new ResponseEntity<Map<String, Object>>(map, HttpStatus.OK);
	} // modifyComment

	@DeleteMapping(value = "/comment/{num}", produces = MediaType.TEXT_PLAIN_VALUE)
	public ResponseEntity<String> deleteComment(@PathVariable int num) {

		commentService.deleteCommentByNum(num);

		return new ResponseEntity<String>("success", HttpStatus.OK);
	} // deleteComment
	
}
