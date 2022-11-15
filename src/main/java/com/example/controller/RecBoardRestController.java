package com.example.controller;

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
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.example.domain.RecBoardVO;
import com.example.service.BoardService;

@RestController
@RequestMapping("/api/*")
public class RecBoardRestController {
	
	
	private BoardService boardService;
	
	public RecBoardRestController(BoardService boardService) {
		super();
		this.boardService = boardService;
	}
	

	@GetMapping(value = "/recBoard/{boardNum}", produces = { MediaType.APPLICATION_JSON_VALUE,
			MediaType.APPLICATION_XML_VALUE })
	public ResponseEntity<Map<String, Object>> getRecIdList(@PathVariable("boardNum")	int boardNum) {
		
		List<String> recIdList = boardService.getRecIdListByBoardNum(boardNum); 
		
		int count = recIdList.size();
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("recIdList", recIdList);
		map.put("count", count);
		map.put("success", "success");
		
		return new ResponseEntity<Map<String,Object>>(map, HttpStatus.OK);
	} // getRecIdList
	
	@PostMapping(value = "/addRecBoard", consumes = "application/json", produces = { MediaType.APPLICATION_JSON_VALUE,
			MediaType.APPLICATION_XML_VALUE })
	public ResponseEntity<Map<String, Object>> addRecBoard(@RequestBody RecBoardVO recBoardVO) {
		
		System.out.println("recBoardVO : " + recBoardVO);
		
		boardService.insertRecBoard(recBoardVO);
		
		int recCount = boardService.getRecCountByBoardNum(recBoardVO.getBoardNum());
		
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("recCount", recCount);
		map.put("success", "success");
		
		return new ResponseEntity<Map<String,Object>>(map, HttpStatus.OK);
	}
	
	@DeleteMapping(value = "/deleteRecBoard", consumes = "application/json", produces = { MediaType.APPLICATION_JSON_VALUE,
			MediaType.APPLICATION_XML_VALUE })
	public ResponseEntity<Map<String, Object>> deleteRecBoard(@RequestBody RecBoardVO recBoardVO){
		
		System.out.println("================deleteRecBoard=================");
		System.out.println("recBoardVO : " + recBoardVO);
		
		boardService.deleteRecBoard(recBoardVO);
		
		int recCount = boardService.getRecCountByBoardNum(recBoardVO.getBoardNum());
		
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("recCount", recCount);
		map.put("success", "success");
		
		return new ResponseEntity<Map<String,Object>>(map, HttpStatus.OK);
	}

}
