package com.example.controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.example.domain.AttachVO;
import com.example.domain.BoardVO;
import com.example.domain.CommentVO;
import com.example.domain.Criteria;
import com.example.domain.PageDTO;
import com.example.service.AttachService;
import com.example.service.BoardService;
import com.example.service.CommentService;

import net.coobird.thumbnailator.Thumbnailator;

@Controller
@RequestMapping("/board/*")
public class BoardController {
	

	private BoardService boardService;
	private CommentService commentService;
	private AttachService attachService;

	private final String BASE_PATH = "C:/portfolio/upload";

	public BoardController(BoardService boardService, CommentService commentService, AttachService attachService) {
		super();
		this.boardService = boardService;
		this.commentService = commentService;
		this.attachService = attachService;
	}

	
	/****************************** GetMapping ******************************/

	@GetMapping("/list")
	public String list(Criteria cri, Model model) {

		System.out.println("cri : " + cri);

		List<BoardVO> boardList = boardService.getBoardsByCri(cri);
		int totalCount = boardService.getCountBoardsByCri(cri);

		PageDTO pageDTO = new PageDTO(cri, totalCount);

		model.addAttribute("boardList", boardList);
		model.addAttribute("pageMaker", pageDTO);

		return "board/boardList";
	} // list

	@GetMapping("/write")
	public String writeForm() {

		return "board/boardWrite";
	} // writeForm

	@GetMapping("/content")
	public String content(int num, Model model, @RequestParam(required = false, defaultValue = "1") String pageNum,
			@RequestParam(required = false) String commentNum, HttpSession session) {

		List<String> recIdList = boardService.getRecIdListByBoardNum(num);

		System.out.println("recIdList: " + recIdList);

		String id = (String) session.getAttribute("id");

		boolean isRecommended = recIdList.contains(id);

		System.out.println("포함 여부 : " + isRecommended);

		boardService.updateViewCount(num);

		System.out.println("num : " + num);

		BoardVO boardVO = boardService.getBoardAndAttachesByNum(num);

		System.out.println("boardVO : " + boardVO);

		List<CommentVO> commentList = commentService.getCommentsByBoardNum(num);

		System.out.println("commentList : " + commentList);

		model.addAttribute("board", boardVO);
		model.addAttribute("attachList", boardVO.getAttachList());
		model.addAttribute("commentList", commentList);
		model.addAttribute("pageNum", pageNum);
		model.addAttribute("isRecommended", isRecommended);
		model.addAttribute("recCount", recIdList.size());
		if (commentNum != null) {
			model.addAttribute("commentNum", commentNum);
		}

		return "board/boardContent";
	}

	@GetMapping("/modify")
	public String modifyForm(int num, @RequestParam(required = false, defaultValue = "1") String pageNum, Model model) {

		BoardVO boardVO = boardService.getBoardAndAttachesByNum(num);

		model.addAttribute("board", boardVO);
		model.addAttribute("attachList", boardVO.getAttachList());
		model.addAttribute("pageNum", pageNum);

		return "board/boardModify";

	} // modifyForm

	@GetMapping("/remove")
	public String deleteBoard(int num, String pageNum) {

		System.out.println("num : " + num);
		System.out.println("pageNum : " + pageNum);

		List<AttachVO> attachList = attachService.getAttachesByBoardNum(num);

		deleteAttachFiles(attachList);

		boardService.deleteBoardAndAttachesByBoardNum(num);

		return "redirect:/board/list?pageNum=" + pageNum;
	}

	@GetMapping("/reply")
	public String replyForm(int num, @ModelAttribute("pageNum") String pageNum, Model model) {

		model.addAttribute("num", num);

		return "board/boardReply";
	}

	/****************************** GetMapping End ******************************/

	
	/****************************** PostMapping ******************************/

	@PostMapping("/write")
	public String write(List<MultipartFile> files, BoardVO boardVO, HttpSession session, RedirectAttributes rttr)
			throws IllegalStateException, IOException {

		int num = boardService.getNextNum();

		List<AttachVO> attachList = uploadFilesAndGetAttachList(files, num);

		String id = (String) session.getAttribute("id");

		boardVO.setNum(num);
		boardVO.setMemberId(id);
		boardVO.setViewCount(0);
		boardVO.setRegDate(new Date());
		boardVO.setReRef(num);
		boardVO.setReLev(0);
		boardVO.setReSeq(0);
		boardVO.setAttachList(attachList);

		boardService.addBoardAndAttaches(boardVO);

		rttr.addAttribute("num", boardVO.getNum());
		rttr.addAttribute("pageNum", 1);

		return "redirect:/board/content";
	} // write

	@PostMapping("/modify")
	public String modify(BoardVO boardVO, String pageNum, List<MultipartFile> files,
			@RequestParam(name = "delFile", required = false) List<String> delUuidList, RedirectAttributes rttr)
			throws IllegalStateException, IOException {
		System.out.println("boardVO : " + boardVO);

		// 신규 첨부파일 업로드, 리스트 가져오기
		List<AttachVO> newAttachList = uploadFilesAndGetAttachList(files, boardVO.getNum());

		// 삭제할 첨부파일 폴더에서 삭제하기
		List<AttachVO> delAttachList = null;
		if (delUuidList != null && delUuidList.size() > 0) {
			delAttachList = attachService.getAttachesByUuid(delUuidList);

			deleteAttachFiles(delAttachList);
		}

		// DB테이블 작업. 게시글 수정, 첨부파일 추가, 삭제
		boardService.updateBoardsAndInsertAttachesAndDeleteAttaches(boardVO, newAttachList, delUuidList);

		rttr.addAttribute("num", boardVO.getNum());
		rttr.addAttribute("pageNum", pageNum);

		return "redirect:/board/content";
	} // modify

	@PostMapping("/reply")
	public String reply(List<MultipartFile> files, int boardNum, String pageNum, BoardVO boardVO, HttpSession session, RedirectAttributes rttr)
			throws IllegalStateException, IOException {
		System.out.println("boardVO : " + boardVO);

		BoardVO targetBoardVO = boardService.getBoardByNum(boardNum);

		System.out.println("targetBoardVO : " + targetBoardVO);

		int nextNum = boardService.getNextNum();

		List<AttachVO> attachList = uploadFilesAndGetAttachList(files, nextNum);

		String id = (String) session.getAttribute("id");
		boardVO.setNum(nextNum);
		boardVO.setMemberId(id);
		boardVO.setRegDate(new Date());
		boardVO.setReRef(targetBoardVO.getReRef());
		boardVO.setReLev(targetBoardVO.getReLev() + 1);
		boardVO.setReSeq(targetBoardVO.getReSeq() + 1);
		boardVO.setAttachList(attachList);

		System.out.println("수정후 boardVO : " + boardVO);

		boardService.replyBoard(boardVO);

		return "redirect:/board/content?num=" + boardVO.getNum() + "&pageNum=" + pageNum;
	}

	/****************************** PostMapping End ******************************/
	

	/****************************** Method ******************************/

	// "년/월/일' 형식의 폴더명을 리턴하는 메소드
	private String getFolder() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");

		String str = sdf.format(new Date());

		return str;
	}// getFolder

	private boolean checkImageType(File file) throws IOException {
		boolean isImage = false;

		String contentType = Files.probeContentType(file.toPath()); // "image/jpg" "image/png" 등으로 리턴함.
		System.out.println("contentType : " + contentType);

		isImage = contentType.startsWith("image"); // image로 시작할 때 true로 리턴

		return isImage;
	} // checkImageType

	private List<AttachVO> uploadFilesAndGetAttachList(List<MultipartFile> files, int boardNum) throws IllegalStateException, IOException {

		List<AttachVO> attachList = new ArrayList<AttachVO>();

		// null 체크
		if (files == null || files.size() == 0) {
			System.out.println("첨부파일 없음 ...");
			return attachList;
		}

		File uploadPath = new File(BASE_PATH, getFolder());

		if (uploadPath.exists() == false) {
			uploadPath.mkdirs();
		}

		for (MultipartFile multipartFile : files) {
			if (multipartFile.isEmpty()) {
				continue;
			}

			String originalFilename = multipartFile.getOriginalFilename();

			UUID uuid = UUID.randomUUID();
			String uploadFilename = uuid.toString() + "_" + originalFilename;

			File file = new File(uploadPath, uploadFilename);

			multipartFile.transferTo(file); // 파일 생성

			// 첨부파일이 이미지일 경우
			boolean isImage = checkImageType(file);
			if (isImage == true) {
				File outFile = new File(uploadPath, "s_" + uploadFilename);

				Thumbnailator.createThumbnail(file, outFile, 100, 100);
			}

			AttachVO attachVO = new AttachVO();
			attachVO.setUuid(uuid.toString());
			attachVO.setUploadpath(getFolder());
			attachVO.setFilename(originalFilename);
			attachVO.setFiletype(isImage ? "I" : "O");
			attachVO.setBoardNum(boardNum);

			attachList.add(attachVO);

		} // for

		return attachList;
	} // uploadFilesAndGetAttachList

	// 첨부파일 삭제하는 메소드
	private void deleteAttachFiles(List<AttachVO> attachList) {

		if (attachList == null || attachList.size() == 0) {
			System.out.println("삭제할 첨부파일 정보가 없습니다...");
			return;
		}

		for (AttachVO attachVO : attachList) {
			String uploadpath = BASE_PATH + "/" + attachVO.getUploadpath();
			String filename = attachVO.getUuid() + "_" + attachVO.getFilename();

			File file = new File(uploadpath, filename);

			if (file.exists()) {
				file.delete();
			}

			if (attachVO.getFiletype().equals("I")) {
				File thumbnailFile = new File(uploadpath, "s_" + filename);
				if (thumbnailFile.exists()) {
					thumbnailFile.delete();
				}
			}
		} // for

	} // deleteAttachFiles

	/****************************** Method End ******************************/
	
}