package com.example.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import com.example.domain.BoardVO;
import com.example.domain.CommentVO;
import com.example.domain.Criteria;

public interface ViewMemberMapper {

	// =================== select ======================
	@Select("SELECT COUNT(*) AS cnt FROM board WHERE member_id = #{id} ")
	int getCountAll();

	@Select("SELECT * FROM board WHERE member_id = #{id} ORDER BY re_ref DESC, re_seq ASC ")
	List<BoardVO> getBoardsAll();

	int getCountBySearch(@Param("cri") Criteria cri, @Param("id") String id);

	List<BoardVO> getBoardsWithPaging(@Param("cri") Criteria cri, @Param("id") String id);

	BoardVO getBoardAndAttaches(String memberId);

	@Select("SELECT COUNT(*) AS cnt FROM comment WHERE member_id = #{id} ")
	int getCommentCountAll();

	@Select("SELECT * FROM comment WHERE member_id = #{id} ORDER BY reg_date ")
	List<CommentVO> getCommentsbyRegDate(String id);

	int getCommentCountSearchingforMemberId(@Param("cri") Criteria cri, @Param("id") String id);

	List<CommentVO> getCommentsByPaging(@Param("cri") Criteria cri, @Param("id") String id);

}
