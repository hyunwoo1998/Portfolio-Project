package com.example.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.domain.AttachVO;
import com.example.mapper.AttachMapper;

@Service
@Transactional
public class AttachService {

	private AttachMapper attachMapper;

	public AttachService(AttachMapper attachMapper) {
		super();
		this.attachMapper = attachMapper;
	}

	public List<AttachVO> getAttachesByBoardNum(int boardNum) {
		return attachMapper.getAttachesByBoardNum(boardNum);
	}

	public List<AttachVO> getAttachesByUuid(List<String> uuidList) {
		return attachMapper.getAttachesByUuid(uuidList);
	}

	public List<AttachVO> getAttachesByUploadpath(String uploadpath) {
		return attachMapper.getAttachesByUploadpath(uploadpath);
	}

}
