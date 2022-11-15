package com.example.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.example.domain.CommentVO;
import com.example.domain.Criteria;

public interface CommentMapper {

	// =================== select ======================
	int getNextNum();
	
	List<CommentVO> getCommentsByBoardNum(int boardNum);
	
	List<CommentVO> getMyCommentListByCri(@Param("cri") Criteria cri, @Param("id") String id);
	
	int getMyAllCommentsCount(@Param("cri") Criteria cri, @Param("id") String id);
	
	// =================== insert ======================
	void insertComment(CommentVO commentVO);
	
	// =================== update ======================
	void updateComment(CommentVO commentVO);
	
	void updateCommentReSeq(CommentVO commentVO);
	
	// =================== delete ======================
	void deleteCommentByNum(int num);
	
}
