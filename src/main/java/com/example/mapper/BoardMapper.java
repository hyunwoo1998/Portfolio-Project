package com.example.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.example.domain.BoardVO;
import com.example.domain.Criteria;
import com.example.domain.RecBoardVO;

public interface BoardMapper {

	// =================== select ======================
	List<BoardVO> getBoardsByCri(Criteria cri);

	int getCountBoardsByCri(Criteria cri);

	int getNextNum();

	BoardVO getBoardByNum(int num);

	BoardVO getBoardAndAttachesByNum(int num);

	List<BoardVO> getMyBoardListByCri(@Param("cri") Criteria cri, @Param("id") String id);

	int getMyAllBoardsCount(@Param("cri") Criteria cri, @Param("id") String id);

	List<String> getRecIdListByBoardNum(int boardNum);

	int getRecCountByBoardNum(int boardNum);

	// =================== insert ======================
	void addBoard(BoardVO boardVO);

	void insertRecBoard(RecBoardVO recBoardVO);

	// =================== update ======================
	void updateViewCount(int num);

	void updateBoard(BoardVO boardVO);

	void updateBoardReSeq(BoardVO boardVO);

	// =================== delete ======================

	void deleteBoardByNum(int num);

	void deleteRecBoard(RecBoardVO recBoardVO);
	
}
