package service;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.springframework.util.FileCopyUtils;
import org.springframework.web.multipart.MultipartFile;

import dao.BoardDAO;
import dto.BoardDTO;
import dto.Board_ReplyDTO;
import dto.NoticeDTO;
import dto.PageDTO;

//여기서 원래 트랜잭션이 이루어 져야 하는데 어차피 select는 값만 가지고 오면 되기 때문에 (테이블에 영향x) 두개(count, list)를 하나로 묶지 않고 작업함
public class BoardServiceImp implements BoardService {
	private BoardDAO dao;

	public BoardServiceImp() {

	}

	public void setDao(BoardDAO dao) {
		this.dao = dao;
	}

	/* 게시글 *//* 게시글 *//* 게시글 *//* 게시글 *//* 게시글 *//* 게시글 *//* 게시글 *//* 게시글 */
	/* 게시글 *//* 게시글 *//* 게시글 *//* 게시글 *//* 게시글 *//* 게시글 *//* 게시글 *//* 게시글 */
	/* 게시글 *//* 게시글 *//* 게시글 *//* 게시글 *//* 게시글 *//* 게시글 *//* 게시글 *//* 게시글 */

	@Override
	public int countProcess() {
		return dao.count();
	}

	@Override
	public List<BoardDTO> listProcess(PageDTO pv) {
		return dao.list(pv);
	}

	// 제목글일때 저장
	@Override
	public void insertProcess(BoardDTO dto) {
		dao.save(dto);
	}

	// 두개의 트랜젹션을 하나로 처리하도록 환경설정해둔 부분
	@Override
	public BoardDTO contentProcess(int num) {
		dao.readCount(num);
		return dao.content(num);
	}

	// 답변글일때 저장
	@Override
	public void reStepProcess(BoardDTO dto) {
		dao.reStepCount(dto);
		dto.setBoard_re_step(dto.getBoard_re_step() + 1);
		dto.setBoard_re_level(dto.getBoard_re_level() + 1);
		dao.save(dto);
	}

	@Override
	public BoardDTO updateSelectProcess(int num) {
		// TODO Auto-generated method stub
		return dao.updateNum(num);
	}

	@Override
	public void updateProcess(BoardDTO dto, HttpServletRequest request) {
		// 기존 첨부파일
		String filename = dao.getFile(dto.getBoard_num());
		String root = request.getSession().getServletContext().getRealPath("/");
		String saveDirectory = root + "temp" + File.separator;

		// 수정할 첨부파일
		MultipartFile file = dto.getFilename();

		// 수정한 첨부파일이 있으면
		if (!file.isEmpty()) {
			// 중복파일명을 처리하기 위해 난수 발생
			UUID random = UUID.randomUUID();

			// 기존 첨부파일이 있으면
			if (filename != null) {
				File fe = new File(saveDirectory, filename);
				fe.delete();
			}

			String fileName = file.getOriginalFilename();
			dto.setBoard_file(random + "_" + fileName);
			File ff = new File(saveDirectory, random + "_" + fileName);

			try {
				FileCopyUtils.copy(file.getInputStream(), new FileOutputStream(ff));
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		dao.update(dto);
	}

	@Override
	public void deleteProcess(int num, HttpServletRequest request) {
		dao.replydel(num);
		String upload = dao.getFile(num);
		if (upload != null) {
			String root = request.getSession().getServletContext().getRealPath("/");
			String saveDirectory = root + "temp" + File.separator;
			File fe = new File(saveDirectory, upload);
			fe.delete();
		}
		dao.delete(num);
	}

	@Override
	public void deleteProcess2(int num, HttpServletRequest request) {
		System.out.println("num ==============>" + num);
		dao.replydel2(num);
		String upload = dao.getFile(num);
		if (upload != null) {
			String root = request.getSession().getServletContext().getRealPath("/");
			String saveDirectory = root + "temp" + File.separator;
			File fe = new File(saveDirectory, upload);
			fe.delete();
		}
		dao.delete2(num);
	}

	/* 댓글 *//* 댓글 *//* 댓글 *//* 댓글 *//* 댓글 *//* 댓글 *//* 댓글 *//* 댓글 *//* 댓글 *//* 댓글 */
	/* 댓글 *//* 댓글 *//* 댓글 *//* 댓글 *//* 댓글 *//* 댓글 *//* 댓글 *//* 댓글 *//* 댓글 *//* 댓글 */
	/* 댓글 *//* 댓글 *//* 댓글 *//* 댓글 *//* 댓글 *//* 댓글 *//* 댓글 *//* 댓글 *//* 댓글 *//* 댓글 */

	@Override
	public List<BoardDTO> boardListProcess() {
		return dao.boardListMethod();
	}

	@Override
	public BoardDTO boardViewProcess(int bno) {
		return dao.boardviewMethod(bno);
	}

	@Override
	public List<Board_ReplyDTO> replyListProcess(Board_ReplyDTO rdto) {
		if (rdto.getReply_writer() != null) {
			dao.replyInsertMethod(rdto);
		}
		return dao.replyListMethod(rdto.getBoard_num());
	}

	@Override
	public List<Board_ReplyDTO> replyDeleteProcess(Board_ReplyDTO rdto) {
		dao.replyDeleteMethod(rdto.getReply_num());
		return dao.replyListMethod(rdto.getBoard_num());
	}

	@Override
	public List<Board_ReplyDTO> replyUpdateProcess(Board_ReplyDTO rdto) {
		dao.replyUpdateMethod(rdto);
		return dao.replyListMethod(rdto.getBoard_num());
	}

	/* 카테고리 *//* 카테고리 *//* 카테고리 *//* 카테고리 *//* 카테고리 *//* 카테고리 *//* 카테고리 */
	/* 카테고리 *//* 카테고리 *//* 카테고리 *//* 카테고리 *//* 카테고리 *//* 카테고리 *//* 카테고리 */
	/* 카테고리 *//* 카테고리 *//* 카테고리 *//* 카테고리 *//* 카테고리 *//* 카테고리 *//* 카테고리 */

	/* 카테고리별 list 출력 */
	@Override
	public List<BoardDTO> category_listProcess(BoardDTO bdto, PageDTO pdto) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("board_type", bdto.getBoard_type());
		map.put("startRow", pdto.getStartRow());
		map.put("endRow", pdto.getEndRow());
		return dao.category_list(map);
	}

	/* 카테고리별 레코드 수 출력 */
	@Override
	public int category_countProcess(BoardDTO bdto) {
		return dao.category_count(bdto.getBoard_type());
	}

	/* 공지사항 *//* 공지사항 *//* 공지사항 *//* 공지사항 *//* 공지사항 *//* 공지사항 *//* 공지사항 */
	/* 공지사항 *//* 공지사항 *//* 공지사항 *//* 공지사항 *//* 공지사항 *//* 공지사항 *//* 공지사항 */
	/* 공지사항 *//* 공지사항 *//* 공지사항 *//* 공지사항 *//* 공지사항 *//* 공지사항 *//* 공지사항 */

	/* 관리자 공지사항 레코드 수 출력 */
	@Override
	public int notice_countProcess() {
		return dao.notice_count();
	}

	/* 관리자 공지사항 list 출력 */
	@Override
	public List<NoticeDTO> notice_listProcess(PageDTO pv) {
		return dao.notice_list(pv);
	}

	// 제목글일때 저장
	@Override
	public void notice_insertProcess(NoticeDTO dto) {
		dao.notice_save(dto);
	}

	// 두개의 트랜젹션을 하나로 처리하도록 환경설정해둔 부분
	@Override
	public NoticeDTO notice_contentProcess(int num) {
		dao.notice_readCount(num);
		return dao.notice_content(num);
	}

	@Override
	public NoticeDTO notice_updateSelectProcess(int num) {
		return dao.notice_updateNum(num);
	}

	@Override
	public void notice_updateProcess(NoticeDTO dto, HttpServletRequest request) {
		// 기존 첨부파일
		String filename = dao.notice_getFile(dto.getNotice_num());
		String root = request.getSession().getServletContext().getRealPath("/");
		String saveDirectory = root + "temp" + File.separator;

		// 수정할 첨부파일
		MultipartFile file = dto.getFilename();

		// 수정한 첨부파일이 있으면
		if (!file.isEmpty()) {
			// 중복파일명을 처리하기 위해 난수 발생
			UUID random = UUID.randomUUID();

			// 기존 첨부파일이 있으면
			if (filename != null) {
				File fe = new File(saveDirectory, filename);
				fe.delete();
			}

			String fileName = file.getOriginalFilename();
			dto.setNotice_file(random + "_" + fileName);
			File ff = new File(saveDirectory, random + "_" + fileName);

			try {
				FileCopyUtils.copy(file.getInputStream(), new FileOutputStream(ff));
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		dao.notice_update(dto);
	}

	@Override
	public void notice_deleteProcess(int num, HttpServletRequest request) {
		dao.replydel(num);
		String upload = dao.notice_getFile(num);
		if (upload != null) {
			String root = request.getSession().getServletContext().getRealPath("/");
			String saveDirectory = root + "temp" + File.separator;
			File fe = new File(saveDirectory, upload);
			fe.delete();
		}
		dao.notice_delete(num);
	}
	
	/*검색*//*검색*//*검색*//*검색*//*검색*//*검색*//*검색*//*검색*//*검색*//*검색*//*검색*//*검색*/
	/*검색*//*검색*//*검색*//*검색*//*검색*//*검색*//*검색*//*검색*//*검색*//*검색*//*검색*//*검색*/
	/*검색*//*검색*//*검색*//*검색*//*검색*//*검색*//*검색*//*검색*//*검색*//*검색*//*검색*//*검색*/
	
	/* Q&A 검색 레코드 수 출력*/
	@Override
	public int search_countProcess(BoardDTO dto) {
		return dao.search_count(dto);
	}
	
	/* Q&A 검색 리스트 출력*/
	@Override
	public List<BoardDTO> board_searchProcess(BoardDTO bdto, PageDTO pdto) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("board_writer", bdto.getBoard_writer());
		map.put("board_title", bdto.getBoard_title());
		map.put("startRow", pdto.getStartRow());
		map.put("endRow", pdto.getEndRow());
		return dao.board_search(map);
	}
	
	/* notice 검색 레코드 수 출력*/
	@Override
	public int noticesearch_countProcess(NoticeDTO dto) {
		return dao.noticesearch_count(dto);
	}
	
	/* notice 검색 리스트 출력*/
	@Override
	public List<NoticeDTO> notice_searchProcess(NoticeDTO ndto, PageDTO pdto) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		System.out.println("프로세스다" +ndto.getNotice_title());
		System.out.println("프로세스다" +ndto.getNotice_writer());
		map.put("notice_writer", ndto.getNotice_writer());
		map.put("notice_title", ndto.getNotice_title());
		map.put("startRow", pdto.getStartRow());
		map.put("endRow", pdto.getEndRow());
		return dao.notice_search(map);
	}
	
	/*메인페이지 공지사항 출력용*/
	@Override
	public List<NoticeDTO> main_noticeProcess(PageDTO pv) {
		return dao.main_notice(pv);
	}
}// end class