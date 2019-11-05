package dao;

import java.util.HashMap;
import java.util.List;

import dto.BoardDTO;
import dto.Board_ReplyDTO;
import dto.NoticeDTO;
import dto.PageDTO;

public interface BoardDAO {
	/*Q&A*/
	public int count();
	public List<BoardDTO> list(PageDTO pv);
	public void readCount(int num);
	public BoardDTO content(int num);
	public void reStepCount(BoardDTO dto);
	public void save(BoardDTO dto);
	public BoardDTO updateNum(int num);
	public void update( BoardDTO dto);
	public void delete(int num);
	public void delete2(int num);
	public String getFile(int num);
	
	/*댓글*/
	void replyUpdateMethod(Board_ReplyDTO rdto);
	void replyDeleteMethod(int rno);
	public List<Board_ReplyDTO> replyListMethod(int bno);
	void replyInsertMethod(Board_ReplyDTO rdto);
	public BoardDTO boardviewMethod(int bno);
	public List<BoardDTO> boardListMethod();
	void replydel2(int num);
	void replydel(int num);
	
	/*카테고리별 list 출력*/
	int category_count(String category);
	List<BoardDTO> category_list(HashMap<String, Object> map);
	
	/*관리자 공지사항*/
	int notice_count();
	List<NoticeDTO> notice_list(PageDTO pv);
	void notice_readCount(int num);
	NoticeDTO notice_content(int num);
	void notice_save(NoticeDTO dto);
	NoticeDTO notice_updateNum(int num);
	void notice_update(NoticeDTO dto);
	void notice_delete(int num);
	String notice_getFile(int num);
	
	/*검색*/
	List<BoardDTO> board_search(HashMap<String, Object> map);
	int search_count(BoardDTO dto);
	int noticesearch_count(NoticeDTO dto);
	List<NoticeDTO> notice_search(HashMap<String, Object> map);
	
	
	List<NoticeDTO> main_notice(PageDTO pv);
}
