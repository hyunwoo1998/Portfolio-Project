package com.example.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.domain.AttachVO;
import com.example.domain.BoardVO;
import com.example.domain.Criteria;
import com.example.domain.RecBoardVO;
import com.example.mapper.AttachMapper;
import com.example.mapper.BoardMapper;

@Service
@Transactional
public class BoardService {

	private BoardMapper boardMapper;
	private AttachMapper attachMapper;

	public BoardService(BoardMapper boardMapper, AttachMapper attachMapper) {
		super();
		this.boardMapper = boardMapper;
		this.attachMapper = attachMapper;
	}

	public List<BoardVO> getBoardsByCri(Criteria cri) {

		int startRow = (cri.getPageNum() - 1) * cri.getAmount();

		cri.setStartRow(startRow);

		return boardMapper.getBoardsByCri(cri);
	}

	public int getCountBoardsByCri(Criteria cri) {
		return boardMapper.getCountBoardsByCri(cri);
	}

	public int getNextNum() {
		return boardMapper.getNextNum();
	}

	public void addBoardAndAttaches(BoardVO boardVO) {
		boardMapper.addBoard(boardVO);

		if (boardVO.getAttachList().size() > 0) {
			attachMapper.addAttaches(boardVO.getAttachList());
		}
	}

	public BoardVO getBoardByNum(int num) {
		return boardMapper.getBoardByNum(num);
	}

	public BoardVO getBoardAndAttachesByNum(int num) {
		return boardMapper.getBoardAndAttachesByNum(num);
	}

	public void updateViewCount(int num) {
		boardMapper.updateViewCount(num);
	}

	public void updateBoardsAndInsertAttachesAndDeleteAttaches(BoardVO boardVO, List<AttachVO> newAttachList,
			List<String> delUuidList) {
		if (newAttachList != null && newAttachList.size() > 0) {
			attachMapper.addAttaches(newAttachList);
		}
		if (delUuidList != null && delUuidList.size() > 0) {
			attachMapper.deleteAttachesByUuidList(delUuidList);
		}

		boardMapper.updateBoard(boardVO);
	}

	public void deleteBoardAndAttachesByBoardNum(int boardNum) {

		attachMapper.deleteAttachesByBoardNum(boardNum);
		boardMapper.deleteBoardByNum(boardNum);

	}

	public void replyBoard(BoardVO boardVO) {

		boardMapper.updateBoardReSeq(boardVO);

		addBoardAndAttaches(boardVO);
	}
	
	public List<String> getRecIdListByBoardNum(int boardNum){
		return boardMapper.getRecIdListByBoardNum(boardNum);
	}
	
	public void insertRecBoard(RecBoardVO recBoardVO) {
		boardMapper.insertRecBoard(recBoardVO);
	}
	
	public void deleteRecBoard(RecBoardVO recBoardVO) {
		boardMapper.deleteRecBoard(recBoardVO);
	}
	
	public int getRecCountByBoardNum(int boardNum) {
		return boardMapper.getRecCountByBoardNum(boardNum);
	}

}
