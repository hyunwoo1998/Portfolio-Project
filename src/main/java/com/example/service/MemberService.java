package com.example.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.domain.BoardVO;
import com.example.domain.CommentVO;
import com.example.domain.Criteria;
import com.example.domain.MemberVO;
import com.example.mapper.BoardMapper;
import com.example.mapper.CommentMapper;
import com.example.mapper.MemberMapper;

@Service
@Transactional
public class MemberService {

	private MemberMapper memberMapper;
	private BoardMapper boardMapper;
	private CommentMapper commentMapper;

	public MemberService(MemberMapper memberMapper, BoardMapper boardMapper, CommentMapper commentMapper) {
		super();
		this.memberMapper = memberMapper;
		this.boardMapper = boardMapper;
		this.commentMapper = commentMapper;
	}

	public void register(MemberVO memberVO) {
		memberMapper.insert(memberVO);
	}

	public int deleteById(String id) {
		return memberMapper.deleteById(id);
	}

	public void updateById(MemberVO memberVO) {
		memberMapper.updateById(memberVO);
	}

	public void updateOnlyPasswd(MemberVO memberVO) {
		memberMapper.updateOnlyPasswd(memberVO);
	}

	public int getCountById(String id) {
		return memberMapper.getCountById(id);
	}

	public MemberVO getMemberById(String id) {
		return memberMapper.getMemberById(id);
	}

	public List<MemberVO> getMembers() {
		return memberMapper.getMembers();
	}
	
	public List<BoardVO> getMyBoardListByCri(Criteria cri, String id) {

		int StartRow = (cri.getPageNum() - 1) * cri.getAmount();

		cri.setStartRow(StartRow);

		return boardMapper.getMyBoardListByCri(cri, id);
	}
	
	public int getMyAllBoardsCount(Criteria cri, String id) {
		return boardMapper.getMyAllBoardsCount(cri, id);
	}
	
	public List<CommentVO> getMyCommentListByCri(Criteria cri, String id) {

		int StartRow = (cri.getPageNum() - 1) * cri.getAmount();

		cri.setStartRow(StartRow);

		return commentMapper.getMyCommentListByCri(cri, id);
	}
	
	public int getMyAllCommentsCount(Criteria cri, String id) {
		return commentMapper.getMyAllCommentsCount(cri, id);
	}

}
