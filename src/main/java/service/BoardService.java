package service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import dto.BoardDTO;
import dto.Board_ReplyDTO;
import dto.NoticeDTO;
import dto.PageDTO;

public interface BoardService {
	public int countProcess(); 
	public List<BoardDTO> listProcess(PageDTO pv);
	public void insertProcess(BoardDTO dto);
	public BoardDTO contentProcess(int num);
	public void reStepProcess(BoardDTO dto);
	public BoardDTO updateSelectProcess(int num);
	public void updateProcess(BoardDTO dto,HttpServletRequest request);
	public void deleteProcess(int num,HttpServletRequest request);
	public void deleteProcess2(int num,HttpServletRequest request);
	public List<BoardDTO> boardListProcess();
	public BoardDTO boardViewProcess(int bno);
	
	/*댓글*/
	public List<Board_ReplyDTO> replyListProcess(Board_ReplyDTO rdto);
	public List<Board_ReplyDTO> replyDeleteProcess(Board_ReplyDTO rdto);
	public List<Board_ReplyDTO> replyUpdateProcess(Board_ReplyDTO rdto);
	
	/*카테고리별 list 출력*/
	public int category_countProcess(BoardDTO bdto);
	public List<BoardDTO> category_listProcess(BoardDTO bdto, PageDTO pdto);
	
	/*관리자 공지사항*/
	public int notice_countProcess();
	public List<NoticeDTO> notice_listProcess(PageDTO pv);
	public void notice_insertProcess(NoticeDTO dto);
	public NoticeDTO notice_contentProcess(int num);
	public NoticeDTO notice_updateSelectProcess(int num);
	public void notice_updateProcess(NoticeDTO dto, HttpServletRequest request);
	public void notice_deleteProcess(int num, HttpServletRequest request);
	
	/*검색*/
	public List<BoardDTO> board_searchProcess(BoardDTO bdto, PageDTO pdto);
	public int search_countProcess(BoardDTO dto);
	public int noticesearch_countProcess(NoticeDTO dto);
	public List<NoticeDTO> notice_searchProcess(NoticeDTO ndto, PageDTO pdto);
	
	
	
	List<NoticeDTO> main_noticeProcess(PageDTO pv);
}//end interface
