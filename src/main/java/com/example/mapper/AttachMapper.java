package com.example.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Select;

import com.example.domain.AttachVO;

public interface AttachMapper {

	// =================== select ======================
	List<AttachVO> getAttachesByBoardNum(int boardNum);

	List<AttachVO> getAttachesByUuid(List<String> uuidList);
	
	List<AttachVO> getAttachesByUploadpath(String uploadpath);

	// =================== insert ======================
	void addAttaches(List<AttachVO> attachList);

	// =================== delete ======================
	void deleteAttachesByUuidList(List<String> uuidList);

	void deleteAttachesByBoardNum(int boardNum);
	
}
