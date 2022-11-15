package com.example.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.domain.CommentVO;
import com.example.mapper.CommentMapper;

@Service
@Transactional
public class CommentService {
	
	private CommentMapper commentMapper;

	public CommentService(CommentMapper commentMapper) {
		super();
		this.commentMapper = commentMapper;
	}
	
	public int getNextNum() {
		return commentMapper.getNextNum();
	}
	
	public void insertComment(CommentVO commentVO) {
		commentMapper.insertComment(commentVO);
	}
	
	public List<CommentVO> getCommentsByBoardNum(int boardNum){
		return commentMapper.getCommentsByBoardNum(boardNum);
	}
	
	public void updateComment(CommentVO commentVO) {
		commentMapper.updateComment(commentVO);
	}
	
	public void deleteCommentByNum(int num) {
		commentMapper.deleteCommentByNum(num);
	}
	
	public void insertReplyComment(CommentVO commentVO) {
		commentMapper.updateCommentReSeq(commentVO);
		commentMapper.insertComment(commentVO);
	}
	
	
}
